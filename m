Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15577AD04
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjHMViq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHMViq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3960310E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C121D63738
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44B8C433C7;
        Sun, 13 Aug 2023 21:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962727;
        bh=zQ7JjXAv6OOV9YMAi7FyrYd9Ed4ZZv90LwmLG7/0LLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLSzM4J7Q5gmHADd4LrOXtgEsrQk7GKkyGcKKd5+bZtJnvx9SVM4a+QAXvJmP3WW7
         VeCi0Ypt/mac0p7Tnjocvjkkpn9BDHSSWVItJR8yvMmUd0CTRbudpuvzj923s3T+R+
         qGmtSwg/DW4ZlgZ139SCEMuiBMQ6I+0S7/KsMFjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Stone <daniels@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.1 100/149] drm/rockchip: Dont spam logs in atomic check
Date:   Sun, 13 Aug 2023 23:19:05 +0200
Message-ID: <20230813211721.774944935@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Stone <daniels@collabora.com>

commit 43dae319b50fac075ad864f84501c703ef20eb2b upstream.

Userspace should not be able to trigger DRM_ERROR messages to spam the
logs; especially not through atomic commit parameters which are
completely legitimate for userspace to attempt.

Signed-off-by: Daniel Stone <daniels@collabora.com>
Fixes: 7707f7227f09 ("drm/rockchip: Add support for afbc")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230808104405.522493-1-daniels@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -836,12 +836,12 @@ static int vop_plane_atomic_check(struct
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
 
@@ -849,7 +849,7 @@ static int vop_plane_atomic_check(struct
 		struct vop *vop = to_vop(crtc);
 
 		if (!vop->data->afbc) {
-			DRM_ERROR("vop does not support AFBC\n");
+			DRM_DEBUG_KMS("vop does not support AFBC\n");
 			return -EINVAL;
 		}
 
@@ -858,15 +858,16 @@ static int vop_plane_atomic_check(struct
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


