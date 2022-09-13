PORTNAME=	kconfig-frontends
DISTVERSION=	4.11.0.1
CATEGORIES=	devel
MASTER_SITES=	https://bitbucket.org/nuttx/tools/downloads/

MAINTAINER=	tomek@cedro.info
COMMENT=	Mkfs equivalent for ROMFS filesystem
WWW=		https://bitbucket.org/nuttx/tools/downloads/

LICENSE=	GPLv2

USES=		gmake gperf libtool python shebangfix tar:bz2
SHEBANG_FILES=	utils/kconfig-diff utils/kconfig-tweak.in
GNU_CONFIGURE=	yes
INSTALL_TARGET=	install-strip
DOCS=		AUTHORS COPYING README docs/kconfig-language.txt \
		docs/kconfig.txt
PORTDOCS=	${DOCS:T}

# TODO: GCONF QCONF
OPTIONS_DEFINE=		DOCS MCONF NCONF
OPTIONS_DEFAULT=	MCONF NCONF
OPTIONS_SUB=		yes
MCONF_DESC=		Enable Ncurses frontend (traditional)
NCONF_DESC=		Enable Ncurses frontend (modern)

MCONF_CONFIGURE_ENABLE=	mconf
NCONF_CONFIGURE_ENABLE=	nconf
# TODO
#GCONF_CONFIGURE_ENABLE=	gconf
#QCONF_CONFIGURE_ENABLE=	qconf

.include <bsd.port.options.mk>

.if ${PORT_OPTIONS:MMCONF} || ${PORT_OPTIONS:MNCONF}
USES+=		ncurses
.endif

# TODO
#.if ${PORT_OPTIONS:MGCONF}
#USES+=		gnome
#USE_GNOME=	cairo gdkpixbuf2 gtk20 libglade2
#LIB_DEPENDS+=	libfontconfig.so:x11-fonts/fontconfig \
#		libfreetype.so:print/freetype2 \
#		libharfbuzz.so:print/harfbuzz
#.endif
#
#.if ${PORT_OPTIONS:MQCONF}
#USES+=		qt:5
#USE_QT=		core gui widgets buildtools_build
#.endif

do-install-DOCS-on:
	${MKDIR} ${STAGEDIR}${DOCSDIR}
	cd ${WRKSRC} && ${INSTALL_DATA} ${DOCS} ${STAGEDIR}${DOCSDIR}

.include <bsd.port.mk>
