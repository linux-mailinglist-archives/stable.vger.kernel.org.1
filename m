Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBCC77A197
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjHLSBb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHLSBb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:01:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4F010E5
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCDFC61D14
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4BDC433C7;
        Sat, 12 Aug 2023 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691863293;
        bh=V8xTLfH1S/LdxEMN+UQPPPm2JGbucGR/8WT0RmqSgGE=;
        h=Subject:To:Cc:From:Date:From;
        b=jBo4ay7bYGIDEnmOvLstYgONWo1/10yiwoti/z+qJFU3N5Yw+Lq6NqpQ4eM8Uy18o
         AM3TstMdFBGSXJeHfTilp5foHPdwhwij0c6hZWKoCFl/gwJUrbObnxPsqqC0PbQFWc
         peiVadX07o+jbJJRxZPYdUj1TLdE82rqgoCDsg54=
Subject: FAILED: patch "[PATCH] drm/rockchip: Don't spam logs in atomic check" failed to apply to 5.10-stable tree
To:     daniels@collabora.com, heiko@sntech.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:01:30 +0200
Message-ID: <2023081230-urology-body-89ab@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 43dae319b50fac075ad864f84501c703ef20eb2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081230-urology-body-89ab@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

43dae319b50f ("drm/rockchip: Don't spam logs in atomic check")
ba5c1649465d ("drm: Rename plane atomic_check state names")
abd64e5f6ccc ("drm/vmwgfx/vmwgfx_kms: Remove unused variable 'ret' from 'vmw_du_primary_plane_atomic_check()'")
60f2f74978e6 ("Merge tag 'drm-msm-next-2020-12-07' of https://gitlab.freedesktop.org/drm/msm into drm-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 43dae319b50fac075ad864f84501c703ef20eb2b Mon Sep 17 00:00:00 2001
From: Daniel Stone <daniels@collabora.com>
Date: Tue, 8 Aug 2023 11:44:05 +0100
Subject: [PATCH] drm/rockchip: Don't spam logs in atomic check

Userspace should not be able to trigger DRM_ERROR messages to spam the
logs; especially not through atomic commit parameters which are
completely legitimate for userspace to attempt.

Signed-off-by: Daniel Stone <daniels@collabora.com>
Fixes: 7707f7227f09 ("drm/rockchip: Add support for afbc")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230808104405.522493-1-daniels@collabora.com

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a530ecc4d207..bf34498c1b6d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -833,12 +833,12 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	 * need align with 2 pixel.
 	 */
 	if (fb->format->is_yuv && ((new_plane_state->src.x1 >> 16) % 2)) {
-		DRM_ERROR("Invalid Source: Yuv format not support odd xpos\n");
+		DRM_DEBUG_KMS("Invalid Source: Yuv format not support odd xpos\n");
 		return -EINVAL;
 	}
 
 	if (fb->format->is_yuv && new_plane_state->rotation & DRM_MODE_REFLECT_Y) {
-		DRM_ERROR("Invalid Source: Yuv format does not support this rotation\n");
+		DRM_DEBUG_KMS("Invalid Source: Yuv format does not support this rotation\n");
 		return -EINVAL;
 	}
 
@@ -846,7 +846,7 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 		struct vop *vop = to_vop(crtc);
 
 		if (!vop->data->afbc) {
-			DRM_ERROR("vop does not support AFBC\n");
+			DRM_DEBUG_KMS("vop does not support AFBC\n");
 			return -EINVAL;
 		}
 
@@ -855,15 +855,16 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 			return ret;
 
 		if (new_plane_state->src.x1 || new_plane_state->src.y1) {
-			DRM_ERROR("AFBC does not support offset display, xpos=%d, ypos=%d, offset=%d\n",
-				  new_plane_state->src.x1,
-				  new_plane_state->src.y1, fb->offsets[0]);
+			DRM_DEBUG_KMS("AFBC does not support offset display, " \
+				      "xpos=%d, ypos=%d, offset=%d\n",
+				      new_plane_state->src.x1, new_plane_state->src.y1,
+				      fb->offsets[0]);
 			return -EINVAL;
 		}
 
 		if (new_plane_state->rotation && new_plane_state->rotation != DRM_MODE_ROTATE_0) {
-			DRM_ERROR("No rotation support in AFBC, rotation=%d\n",
-				  new_plane_state->rotation);
+			DRM_DEBUG_KMS("No rotation support in AFBC, rotation=%d\n",
+				      new_plane_state->rotation);
 			return -EINVAL;
 		}
 	}

