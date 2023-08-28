Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445BC78AC76
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjH1KkC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjH1Kjv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3EB10D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6507863FFD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746F2C433C7;
        Mon, 28 Aug 2023 10:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219187;
        bh=PLW2tGN+OasK4ieKkNwhyAb848ESN4XZUUiVmVC6KJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YpRioF7IY6dhXvz5ZDwKpnOAMxwSue1XbGHBCTTtqy85ppmK8cO5LxGw7zi0JEuWQ
         MSfE9509JD8TyKqHRS3VP3d5d9SvtJ26pObso5wck0rjsLEnMEGGPk8IWVQ+5UqCvc
         WwEz9En/6g71jP7SrIT6VPrZNwSzL49rWlKxO8W0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 105/158] fbdev: Fix sys_imageblit() for arbitrary image widths
Date:   Mon, 28 Aug 2023 12:13:22 +0200
Message-ID: <20230828101200.850688325@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 61bfcb6a3b981e8f19e044ac8c3de6edbe6caf70 ]

Commit 6f29e04938bf ("fbdev: Improve performance of sys_imageblit()")
broke sys_imageblit() for image width that are not aligned to 8-bit
boundaries. Fix this by handling the trailing pixels on each line
separately. The performance improvements in the original commit do not
regress by this change.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 6f29e04938bf ("fbdev: Improve performance of sys_imageblit()")
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20220313192952.12058-2-tzimmermann@suse.de
Stable-dep-of: c2d22806aecb ("fbdev: fix potential OOB read in fast_imageblit()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/sysimgblt.c | 29 ++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/sysimgblt.c b/drivers/video/fbdev/core/sysimgblt.c
index 722c327a381bd..335e92b813fc4 100644
--- a/drivers/video/fbdev/core/sysimgblt.c
+++ b/drivers/video/fbdev/core/sysimgblt.c
@@ -188,7 +188,7 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 {
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
-	u32 bit_mask, eorx;
+	u32 bit_mask, eorx, shift;
 	const char *s = image->data, *src;
 	u32 *dst;
 	const u32 *tab;
@@ -229,17 +229,23 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 
 	for (i = image->height; i--; ) {
 		dst = dst1;
+		shift = 8;
 		src = s;
 
+		/*
+		 * Manually unroll the per-line copying loop for better
+		 * performance. This works until we processed the last
+		 * completely filled source byte (inclusive).
+		 */
 		switch (ppw) {
 		case 4: /* 8 bpp */
-			for (j = k; j; j -= 2, ++src) {
+			for (j = k; j >= 2; j -= 2, ++src) {
 				*dst++ = colortab[(*src >> 4) & bit_mask];
 				*dst++ = colortab[(*src >> 0) & bit_mask];
 			}
 			break;
 		case 2: /* 16 bpp */
-			for (j = k; j; j -= 4, ++src) {
+			for (j = k; j >= 4; j -= 4, ++src) {
 				*dst++ = colortab[(*src >> 6) & bit_mask];
 				*dst++ = colortab[(*src >> 4) & bit_mask];
 				*dst++ = colortab[(*src >> 2) & bit_mask];
@@ -247,7 +253,7 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 			}
 			break;
 		case 1: /* 32 bpp */
-			for (j = k; j; j -= 8, ++src) {
+			for (j = k; j >= 8; j -= 8, ++src) {
 				*dst++ = colortab[(*src >> 7) & bit_mask];
 				*dst++ = colortab[(*src >> 6) & bit_mask];
 				*dst++ = colortab[(*src >> 5) & bit_mask];
@@ -259,6 +265,21 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 			}
 			break;
 		}
+
+		/*
+		 * For image widths that are not a multiple of 8, there
+		 * are trailing pixels left on the current line. Print
+		 * them as well.
+		 */
+		for (; j--; ) {
+			shift -= ppw;
+			*dst++ = colortab[(*src >> shift) & bit_mask];
+			if (!shift) {
+				shift = 8;
+				++src;
+			}
+		}
+
 		dst1 += p->fix.line_length;
 		s += spitch;
 	}
-- 
2.40.1



