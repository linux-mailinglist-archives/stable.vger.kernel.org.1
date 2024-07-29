Return-Path: <stable+bounces-62507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F693F4EA
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA381C21497
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ED1146D41;
	Mon, 29 Jul 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1adQ3Czz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DEA146A7A
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255022; cv=none; b=atv/4BaNzCbw63aA5b/8CWV5rnN05WgU4nziIuoAujWetEI7iCWQlDpNxFBs/3eTeoE01QT2U/F653jkkkNG0RNM0siWftOmVJigcQrXmqpZniuTl+ccTVMsS8xfcvqQUk2JQAwao3+IGddrAL0wzV+6GcdMdT0+bHT5lf7IHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255022; c=relaxed/simple;
	bh=fgtyaDtKw7P0fPioVRL0bQ1F1UdyqcJdYEYnOR910s0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZEhIdmQn+8CtDWZX91OTRL87vLBJ1hFp7bQx3ipqFSmOZzO/NcJh5JPTuR/NXqFYgl9BF/lGnLYPbUzbC62lVrCJ2MDKTpvbRpcN8SRQfqpUIO+6ndgQ1TCkbZ0hr8VVfKtooC4XbB4E0FsQK5/EI4oI1ZssfLbIj8UAF768clQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1adQ3Czz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB435C4AF07;
	Mon, 29 Jul 2024 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255022;
	bh=fgtyaDtKw7P0fPioVRL0bQ1F1UdyqcJdYEYnOR910s0=;
	h=Subject:To:Cc:From:Date:From;
	b=1adQ3Czzzhtgd5K0n/sI9NXkvI+y7nAfYqK7aNdRbvhCHTzWapVn1pRT8QZn7Amgs
	 qeSCrzol7MLuBKgF38YbWq7lZe/wxYm++NfjWBAbOnbMcJyz7eRZP5O+qlY6GXTcHx
	 FN2zlq/HfCePdehvaoyTuG+gM+gmI14qg7oJyXj0=
Subject: FAILED: patch "[PATCH] fbdev: vesafb: Detect VGA compatibility from screen info's" failed to apply to 4.19-stable tree
To: tzimmermann@suse.de,deller@gmx.de,javierm@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:10:18 +0200
Message-ID: <2024072917-platter-duke-71de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c2bc958b2b03e361f14df99983bc64a39a7323a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072917-platter-duke-71de@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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
7283f862bd99 ("drm: Implement DRM aperture helpers under video/")
efc8f3229f84 ("MAINTAINERS: Broaden scope of simpledrm entry")
fb84efa28a48 ("drm/aperture: Run fbdev removal before internal helpers")
2518f226c60d ("Merge tag 'drm-next-2022-05-25' of git://anongit.freedesktop.org/drm/drm")

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


