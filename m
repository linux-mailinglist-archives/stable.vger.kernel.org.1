Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D5170C844
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjEVThV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjEVThQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AD610E2
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:36:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5CE1629A8
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC718C433EF;
        Mon, 22 May 2023 19:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784217;
        bh=fmWqwqpgSSASLPBrgq/CypkzcOponisddlOg30q9gi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5DxtpnRfcOSK8FW5vL/8mRkd6eznYIUinPMjezFxJogP1nvnnZ4uHrIwFveKXyxH
         JvW4sEN1dvikTDKVGRTHtxdCwIKLWky5qxqCx8YeQV/0iMQhL1p0ggsizgupzea6MZ
         ATD/kEzpcPbS4HQgU3xQxPKyhDC7kkatgHK8PpxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sui Jingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 001/364] drm/fbdev-generic: prohibit potential out-of-bounds access
Date:   Mon, 22 May 2023 20:05:06 +0100
Message-Id: <20230522190412.842480208@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

[ Upstream commit c8687694bb1f5c48134f152f8c5c2e53483eb99d ]

The fbdev test of IGT may write after EOF, which lead to out-of-bound
access for drm drivers with fbdev-generic. For example, run fbdev test
on a x86+ast2400 platform, with 1680x1050 resolution, will cause the
linux kernel hang with the following call trace:

  Oops: 0000 [#1] PREEMPT SMP PTI
  [IGT] fbdev: starting subtest eof
  Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
  [IGT] fbdev: starting subtest nullptr

  RIP: 0010:memcpy_erms+0xa/0x20
  RSP: 0018:ffffa17d40167d98 EFLAGS: 00010246
  RAX: ffffa17d4eb7fa80 RBX: ffffa17d40e0aa80 RCX: 00000000000014c0
  RDX: 0000000000001a40 RSI: ffffa17d40e0b000 RDI: ffffa17d4eb80000
  RBP: ffffa17d40167e20 R08: 0000000000000000 R09: ffff89522ecff8c0
  R10: ffffa17d4e4c5000 R11: 0000000000000000 R12: ffffa17d4eb7fa80
  R13: 0000000000001a40 R14: 000000000000041a R15: ffffa17d40167e30
  FS:  0000000000000000(0000) GS:ffff895257380000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffa17d40e0b000 CR3: 00000001eaeca006 CR4: 00000000001706e0
  Call Trace:
   <TASK>
   ? drm_fbdev_generic_helper_fb_dirty+0x207/0x330 [drm_kms_helper]
   drm_fb_helper_damage_work+0x8f/0x170 [drm_kms_helper]
   process_one_work+0x21f/0x430
   worker_thread+0x4e/0x3c0
   ? __pfx_worker_thread+0x10/0x10
   kthread+0xf4/0x120
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x2c/0x50
   </TASK>
  CR2: ffffa17d40e0b000
  ---[ end trace 0000000000000000 ]---

The is because damage rectangles computed by
drm_fb_helper_memory_range_to_clip() function is not guaranteed to be
bound in the screen's active display area. Possible reasons are:

1) Buffers are allocated in the granularity of page size, for mmap system
   call support. The shadow screen buffer consumed by fbdev emulation may
   also choosed be page size aligned.

2) The DIV_ROUND_UP() used in drm_fb_helper_memory_range_to_clip()
   will introduce off-by-one error.

For example, on a 16KB page size system, in order to store a 1920x1080
XRGB framebuffer, we need allocate 507 pages. Unfortunately, the size
1920*1080*4 can not be divided exactly by 16KB.

 1920 * 1080 * 4 = 8294400 bytes
 506 * 16 * 1024 = 8290304 bytes
 507 * 16 * 1024 = 8306688 bytes

 line_length = 1920*4 = 7680 bytes

 507 * 16 * 1024 / 7680 = 1081.6

 off / line_length = 507 * 16 * 1024 / 7680 = 1081
 DIV_ROUND_UP(507 * 16 * 1024, 7680) will yeild 1082

memcpy_toio() typically issue the copy line by line, when copy the last
line, out-of-bound access will be happen. Because:

 1082 * line_length = 1082 * 7680 = 8309760, and 8309760 > 8306688

Note that userspace may still write to the invisiable area if a larger
buffer than width x stride is exposed. But it is not a big issue as
long as there still have memory resolve the access if not drafting so
far.

 - Also limit the y1 (Daniel)
 - keep fix patch it to minimal (Daniel)
 - screen_size is page size aligned because of it need mmap (Thomas)
 - Adding fixes tag (Thomas)

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
Fixes: aa15c677cc34 ("drm/fb-helper: Fix vertical damage clipping")
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/dri-devel/ad44df29-3241-0d9e-e708-b0338bf3c623@189.cn/
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230420030500.1578756-1-suijingfeng@loongson.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 2fe8349be0995..2a4e9fea03dd7 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -625,19 +625,27 @@ static void drm_fb_helper_damage(struct drm_fb_helper *helper, u32 x, u32 y,
 static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off, size_t len,
 					       struct drm_rect *clip)
 {
+	u32 line_length = info->fix.line_length;
+	u32 fb_height = info->var.yres;
 	off_t end = off + len;
 	u32 x1 = 0;
-	u32 y1 = off / info->fix.line_length;
+	u32 y1 = off / line_length;
 	u32 x2 = info->var.xres;
-	u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
+	u32 y2 = DIV_ROUND_UP(end, line_length);
+
+	/* Don't allow any of them beyond the bottom bound of display area */
+	if (y1 > fb_height)
+		y1 = fb_height;
+	if (y2 > fb_height)
+		y2 = fb_height;
 
 	if ((y2 - y1) == 1) {
 		/*
 		 * We've only written to a single scanline. Try to reduce
 		 * the number of horizontal pixels that need an update.
 		 */
-		off_t bit_off = (off % info->fix.line_length) * 8;
-		off_t bit_end = (end % info->fix.line_length) * 8;
+		off_t bit_off = (off % line_length) * 8;
+		off_t bit_end = (end % line_length) * 8;
 
 		x1 = bit_off / info->var.bits_per_pixel;
 		x2 = DIV_ROUND_UP(bit_end, info->var.bits_per_pixel);
-- 
2.39.2



