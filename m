Return-Path: <stable+bounces-62503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C94F93F4E4
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614451C21A34
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C6146A9B;
	Mon, 29 Jul 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U556Cbua"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128980034
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254996; cv=none; b=t7A381/fUV90qjFNku9WniDhulX6tjlwyNJVlhqKiPM5Fg8farn9Mswj0yHRofLaeU/Ss4D5R9NNrTI42PG0jOMSzCIeiVoxdqZW63SW8UcWh14PiPwXBp4h0B6cjrigySQYNpsXNAQ0KSqfOcHiE7v09o6MfF7Bdfv75NVBfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254996; c=relaxed/simple;
	bh=bvsf+EvqqBCvpfzHZS0s5j5zSZUP17QYBtXXCMTigT8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FYKQcONTCBROV/OYGbc0GJ1DbJsb06zxfWyX0kNtcxpm8ssyEagm/PbBvBGtPqOIpazzeQ4vt5gqeyDJqPC9T478A7rXJScilRGvsdawiEnqFC/sT8rhL7N5rnxgr0T9rY8bk7rwj9RWHB9p+xL9nb86uaOOEEmuDscaeW5HqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U556Cbua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462F1C32786;
	Mon, 29 Jul 2024 12:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722254995;
	bh=bvsf+EvqqBCvpfzHZS0s5j5zSZUP17QYBtXXCMTigT8=;
	h=Subject:To:Cc:From:Date:From;
	b=U556Cbuayy7OdV/mZuPOmL8KbiHGGxMuj3o48z0uxc/NUm4ZCjLypyuGzzyqEkjPc
	 9hRSycs7CIqUSgpJmjeXF6o/cMvlWRIapiyYg5cp6lCJGYcp8lzKHM9qH1bp/ojusK
	 PQVA5qjTHtpKK1qrPYA8ZkyiDIrKfhXF30K92bfg=
Subject: FAILED: patch "[PATCH] fbdev: vesafb: Detect VGA compatibility from screen info's" failed to apply to 6.1-stable tree
To: tzimmermann@suse.de,deller@gmx.de,javierm@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:09:52 +0200
Message-ID: <2024072951-greeter-mummy-752b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c2bc958b2b03e361f14df99983bc64a39a7323a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072951-greeter-mummy-752b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c2bc958b2b03 ("fbdev: vesafb: Detect VGA compatibility from screen info's VESA attributes")
75fa9b7e375e ("video: Add helpers for decoding screen_info")
3218286bbb78 ("fbdev/vesafb: Replace references to global screen_info by local pointer")
7470849745e6 ("video: Move HP PARISC STI core code to shared location")
93604a5ade3a ("fbdev: Handle video= parameter in video/cmdline.c")
367221793d47 ("fbdev: Move option-string lookup into helper")
6d8ad3406a69 ("fbdev: Unexport fb_mode_option")
cedaf7cddd73 ("fbdev: Support NULL for name in option-string lookup")
73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
678573b8eee2 ("fbdev/vesafb: Do not use struct fb_info.apertures")
4ef614be6557 ("fbdev/vesafb: Remove trailing whitespaces")
9a758d8756da ("drm: Move nomodeset kernel parameter to drivers/video")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2bc958b2b03e361f14df99983bc64a39a7323a3 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 17 Jun 2024 13:06:27 +0200
Subject: [PATCH] fbdev: vesafb: Detect VGA compatibility from screen info's
 VESA attributes

Test the vesa_attributes field in struct screen_info for compatibility
with VGA hardware. Vesafb currently tests bit 1 in screen_info's
capabilities field which indicates a 64-bit lfb address and is
unrelated to VGA compatibility.

Section 4.4 of the Vesa VBE 2.0 specifications defines that bit 5 in
the mode's attributes field signals VGA compatibility. The mode is
compatible with VGA hardware if the bit is clear. In that case, the
driver can access VGA state of the VBE's underlying hardware. The
vesafb driver uses this feature to program the color LUT in palette
modes. Without, colors might be incorrect.

The problem got introduced in commit 89ec4c238e7a ("[PATCH] vesafb: Fix
incorrect logo colors in x86_64"). It incorrectly stores the mode
attributes in the screen_info's capabilities field and updates vesafb
accordingly. Later, commit 5e8ddcbe8692 ("Video mode probing support for
the new x86 setup code") fixed the screen_info, but did not update vesafb.
Color output still tends to work, because bit 1 in capabilities is
usually 0.

Besides fixing the bug in vesafb, this commit introduces a helper that
reads the correct bit from screen_info.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 5e8ddcbe8692 ("Video mode probing support for the new x86 setup code")
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: <stable@vger.kernel.org> # v2.6.23+
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index 8ab64ae4cad3..5a161750a3ae 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -271,7 +271,7 @@ static int vesafb_probe(struct platform_device *dev)
 	if (si->orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENODEV;
 
-	vga_compat = (si->capabilities & 2) ? 0 : 1;
+	vga_compat = !__screen_info_vbe_mode_nonvga(si);
 	vesafb_fix.smem_start = si->lfb_base;
 	vesafb_defined.bits_per_pixel = si->lfb_depth;
 	if (15 == vesafb_defined.bits_per_pixel)
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index 75303c126285..6a4a3cec4638 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -49,6 +49,16 @@ static inline u64 __screen_info_lfb_size(const struct screen_info *si, unsigned
 	return lfb_size;
 }
 
+static inline bool __screen_info_vbe_mode_nonvga(const struct screen_info *si)
+{
+	/*
+	 * VESA modes typically run on VGA hardware. Set bit 5 signals that this
+	 * is not the case. Drivers can then not make use of VGA resources. See
+	 * Sec 4.4 of the VBE 2.0 spec.
+	 */
+	return si->vesa_attributes & BIT(5);
+}
+
 static inline unsigned int __screen_info_video_type(unsigned int type)
 {
 	switch (type) {


