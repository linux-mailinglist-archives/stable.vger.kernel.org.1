Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07387A39DC
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbjIQTzP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbjIQTzL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:55:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ADD103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:55:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DE6C433C8;
        Sun, 17 Sep 2023 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980505;
        bh=8Z29cEQGLL/WMFoYptKbXIxgoVKWzegYp7l6MCQ8xwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqWN70RR/IJxeiVvTGS37BcOJ15Zc3UgIOZVmm4aBiWgVxCIwUmwPEd6LRuPP+8at
         fjIfYNuJtjV3dJh76nLahUpFp9EBDnUSRow4vAtHVOjt67NyWvBZ2XnpgqhRowFn+G
         csE5IZXgGiG+Mb5hqs6XyNNh2OsE5FUolPJhVJhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liu Ying <victor.liu@nxp.com>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 6.5 212/285] drm/mxsfb: Disable overlay plane in mxsfb_plane_overlay_atomic_disable()
Date:   Sun, 17 Sep 2023 21:13:32 +0200
Message-ID: <20230917191058.900150919@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Ying <victor.liu@nxp.com>

commit aa656d48e871a1b062e1bbf9474d8b831c35074c upstream.

When disabling overlay plane in mxsfb_plane_overlay_atomic_update(),
overlay plane's framebuffer pointer is NULL.  So, dereferencing it would
cause a kernel Oops(NULL pointer dereferencing).  Fix the issue by
disabling overlay plane in mxsfb_plane_overlay_atomic_disable() instead.

Fixes: cb285a5348e7 ("drm: mxsfb: Replace mxsfb_get_fb_paddr() with drm_fb_cma_get_gem_addr()")
Cc: stable@vger.kernel.org # 5.19+
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Marek Vasut <marex@denx.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230612092359.784115-1-victor.liu@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/mxsfb/mxsfb_kms.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -611,6 +611,14 @@ static void mxsfb_plane_overlay_atomic_u
 	writel(ctrl, mxsfb->base + LCDC_AS_CTRL);
 }
 
+static void mxsfb_plane_overlay_atomic_disable(struct drm_plane *plane,
+					       struct drm_atomic_state *state)
+{
+	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
+
+	writel(0, mxsfb->base + LCDC_AS_CTRL);
+}
+
 static bool mxsfb_format_mod_supported(struct drm_plane *plane,
 				       uint32_t format,
 				       uint64_t modifier)
@@ -626,6 +634,7 @@ static const struct drm_plane_helper_fun
 static const struct drm_plane_helper_funcs mxsfb_plane_overlay_helper_funcs = {
 	.atomic_check = mxsfb_plane_atomic_check,
 	.atomic_update = mxsfb_plane_overlay_atomic_update,
+	.atomic_disable = mxsfb_plane_overlay_atomic_disable,
 };
 
 static const struct drm_plane_funcs mxsfb_plane_funcs = {


