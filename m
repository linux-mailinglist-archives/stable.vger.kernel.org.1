Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25466755233
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGPUFD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjGPUFC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC90E43
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B7D60EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2490BC433C7;
        Sun, 16 Jul 2023 20:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537899;
        bh=kSwWEuHZH4v7RbCGNvEiW/j4GFuGkz2LIvxEC+cR2x8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cd5zZHN/JMnMz+/DW3QGmjgSsJskmXf8cwoWipZwXNceHn5If45xQUXXNsunmHGYZ
         SaMQMQbbiJICJ08Q3rBjSZJd3rCbtSyTT+rd2NT5V5G6GBA5gCBL/Doe7olEw+yVH7
         KxpGLTU64MY5ICVPBD26e75h2r94F7qztmYZ8BH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 260/800] drm/vkms: Fix RGB565 pixel conversion
Date:   Sun, 16 Jul 2023 21:41:53 +0200
Message-ID: <20230716194955.135706577@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit ab87f558dcfb2562c3497e89600dec798a446665 ]

Currently, the pixel conversion isn't rounding the fixed-point values
before assigning it to the RGB coefficients, which is causing the IGT
pixel-format tests to fail. So, use the drm_fixp2int_round() fixed-point
helper to round the values when assigning it to the RGB coefficients.

Tested with igt@kms_plane@pixel-format and igt@kms_plane@pixel-format-source-clamping.

[v2]:
    * Use drm_fixp2int_round() to fix the pixel conversion instead of
      casting the values to s32 (Melissa Wen).

Fixes: 89b03aeaef16 ("drm/vkms: fix 32bit compilation error by replacing macros")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20230512104044.65034-2-mcanal@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 8d948c73741ef..b11342026485f 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -97,9 +97,9 @@ static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
 	s64 fp_b = drm_int2fixp(rgb_565 & 0x1f);
 
 	out_pixel->a = (u16)0xffff;
-	out_pixel->r = drm_fixp2int(drm_fixp_mul(fp_r, fp_rb_ratio));
-	out_pixel->g = drm_fixp2int(drm_fixp_mul(fp_g, fp_g_ratio));
-	out_pixel->b = drm_fixp2int(drm_fixp_mul(fp_b, fp_rb_ratio));
+	out_pixel->r = drm_fixp2int_round(drm_fixp_mul(fp_r, fp_rb_ratio));
+	out_pixel->g = drm_fixp2int_round(drm_fixp_mul(fp_g, fp_g_ratio));
+	out_pixel->b = drm_fixp2int_round(drm_fixp_mul(fp_b, fp_rb_ratio));
 }
 
 void vkms_compose_row(struct line_buffer *stage_buffer, struct vkms_plane_state *plane, int y)
@@ -216,9 +216,9 @@ static void argb_u16_to_RGB565(struct vkms_frame_info *frame_info,
 		s64 fp_g = drm_int2fixp(in_pixels[x].g);
 		s64 fp_b = drm_int2fixp(in_pixels[x].b);
 
-		u16 r = drm_fixp2int(drm_fixp_div(fp_r, fp_rb_ratio));
-		u16 g = drm_fixp2int(drm_fixp_div(fp_g, fp_g_ratio));
-		u16 b = drm_fixp2int(drm_fixp_div(fp_b, fp_rb_ratio));
+		u16 r = drm_fixp2int_round(drm_fixp_div(fp_r, fp_rb_ratio));
+		u16 g = drm_fixp2int_round(drm_fixp_div(fp_g, fp_g_ratio));
+		u16 b = drm_fixp2int_round(drm_fixp_div(fp_b, fp_rb_ratio));
 
 		*dst_pixels = cpu_to_le16(r << 11 | g << 5 | b);
 	}
-- 
2.39.2



