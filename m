Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379C2726EAA
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjFGUvy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjFGUvs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF6FFC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA79263192
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA43C433EF;
        Wed,  7 Jun 2023 20:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171100;
        bh=bmu1QLg/DywlH+5TBXa+qmwSNdE+kBJRTPG8kqOqZ+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Je61e9/FJMJ1A4FW3UHOCLWd0FcfsKzUsEWS/aYfzUeUeuBQIft3z7v1Nz8VTQzWq
         /lwMOrLzL9n/NuK9vBbvWiBjkyyZOPnaBufCa5D7hY/Bqqs6XwnSbWbs+SgVwtNKlJ
         7RoROw2JOzxJq/JAJ7GjC+u+ZmYIYXhv4u5lVwJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 5.10 111/120] drm/rcar: stop using imply for dependencies
Date:   Wed,  7 Jun 2023 22:17:07 +0200
Message-ID: <20230607200904.423856630@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 42d95d1b3a9c649bf5ee881fee5938e00126479a upstream.

The meaning of the 'imply' keyword has changed recently, and neither the
old meaning (select the symbol if its dependencies are met) nor the new
meaning (enable it by default, but let the user set any other setting)
is what we want here.

Work around this by adding two more Kconfig options that lead to
the correct behavior: if DRM_RCAR_USE_CMM and DRM_RCAR_USE_LVDS
are enabled, that portion of the driver becomes usable, and no
configuration results in a link error.

This avoids a link failure:

arm-linux-gnueabi-ld: drivers/gpu/drm/rcar-du/rcar_du_crtc.o: in function `rcar_du_crtc_atomic_begin':
rcar_du_crtc.c:(.text+0x1444): undefined reference to `rcar_cmm_setup'
arm-linux-gnueabi-ld: drivers/gpu/drm/rcar-du/rcar_du_crtc.o: in function `rcar_du_crtc_atomic_enable':
rcar_du_crtc.c:(.text+0x14d4): undefined reference to `rcar_cmm_enable'
arm-linux-gnueabi-ld: rcar_du_crtc.c:(.text+0x1548): undefined reference to `rcar_cmm_setup'
arm-linux-gnueabi-ld: drivers/gpu/drm/rcar-du/rcar_du_crtc.o: in function `rcar_du_crtc_atomic_disable':
rcar_du_crtc.c:(.text+0x18b8): undefined reference to `rcar_cmm_disable'
arm-linux-gnueabi-ld: drivers/gpu/drm/rcar-du/rcar_du_kms.o: in function `rcar_du_modeset_init':

Link: https://lore.kernel.org/all/20200417155553.675905-5-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rcar-du/Kconfig |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -4,8 +4,6 @@ config DRM_RCAR_DU
 	depends on DRM && OF
 	depends on ARM || ARM64
 	depends on ARCH_RENESAS || COMPILE_TEST
-	imply DRM_RCAR_CMM
-	imply DRM_RCAR_LVDS
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
@@ -14,13 +12,17 @@ config DRM_RCAR_DU
 	  Choose this option if you have an R-Car chipset.
 	  If M is selected the module will be called rcar-du-drm.
 
-config DRM_RCAR_CMM
-	tristate "R-Car DU Color Management Module (CMM) Support"
-	depends on DRM && OF
+config DRM_RCAR_USE_CMM
+	bool "R-Car DU Color Management Module (CMM) Support"
 	depends on DRM_RCAR_DU
+	default DRM_RCAR_DU
 	help
 	  Enable support for R-Car Color Management Module (CMM).
 
+config DRM_RCAR_CMM
+	def_tristate DRM_RCAR_DU
+	depends on DRM_RCAR_USE_CMM
+
 config DRM_RCAR_DW_HDMI
 	tristate "R-Car Gen3 and RZ/G2 DU HDMI Encoder Support"
 	depends on DRM && OF
@@ -28,15 +30,20 @@ config DRM_RCAR_DW_HDMI
 	help
 	  Enable support for R-Car Gen3 or RZ/G2 internal HDMI encoder.
 
+config DRM_RCAR_USE_LVDS
+	bool "R-Car DU LVDS Encoder Support"
+	depends on DRM_BRIDGE && OF
+	default DRM_RCAR_DU
+	help
+	  Enable support for the R-Car Display Unit embedded LVDS encoders.
+
 config DRM_RCAR_LVDS
-	tristate "R-Car DU LVDS Encoder Support"
-	depends on DRM && DRM_BRIDGE && OF
+	def_tristate DRM_RCAR_DU
+	depends on DRM_RCAR_USE_LVDS
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	select OF_FLATTREE
 	select OF_OVERLAY
-	help
-	  Enable support for the R-Car Display Unit embedded LVDS encoders.
 
 config DRM_RCAR_VSP
 	bool "R-Car DU VSP Compositor Support" if ARM


