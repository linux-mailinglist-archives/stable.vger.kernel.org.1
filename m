Return-Path: <stable+bounces-204773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5BCCF3DB5
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E9A430F8921
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E102533506C;
	Mon,  5 Jan 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YYDh+/id"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A5D335066
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619307; cv=none; b=J0Xk1uZ1KUGmW3t8XXLV/VawBxUA5z2RZFzBuA9fm1Ul9zGV3UwlxQt/p+c5jfxUzG0DW9z8c8agO8RzrMb/ySk6KFxck4L5nYKQggnaw25GNw3kI1d5NVlj54h2ISHRilDscGbqAPdv0PoP7IYtfof5L+1r4+1zDLNX18RdYoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619307; c=relaxed/simple;
	bh=xiHPqfZKL6DEl9wbbPWExCXr4JBTpLRdmGQvxbGkrQM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qieCZbYnMTWsuQD6FukLHLheL6LCV78K/1A45BTgk8Qa98wwebtMowzc9ZurTEFeHytiU9CzkLNOlz43oyCtT/WveQl7hGv3l9SzXZVhowZs2rQMghcK6d4SsJroNnL3Lq2y4RKkua4PveKDo8itRXswZ6QiQC9pcQroa5uqPBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YYDh+/id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9944C116D0;
	Mon,  5 Jan 2026 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619307;
	bh=xiHPqfZKL6DEl9wbbPWExCXr4JBTpLRdmGQvxbGkrQM=;
	h=Subject:To:Cc:From:Date:From;
	b=YYDh+/idSeVETGkWya1ae4olcyXaRcKPnYmdFvGh4Nv1R7E4zF4pXD6HYjaLYeFJh
	 1y3J6Gyd+p2mNCXNQ81fi00iLOH4PgJauIeqoa057kt68tHuaNis4a20rTypEMW2tZ
	 CxSubRQgFfq/qrx5MF714VFWA1ksvbhtIl1nb5Es=
Subject: FAILED: patch "[PATCH] drm/gma500: Remove unused helper psb_fbdev_fb_setcolreg()" failed to apply to 5.10-stable tree
To: tzimmermann@suse.de,contact@stefanchrist.eu,daniel.vetter@ffwll.ch,patrik.r.jakobsson@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:21:36 +0100
Message-ID: <2026010536-thwarting-rare-1984@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x be729f9de6c64240645dc80a24162ac4d3fe00a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010536-thwarting-rare-1984@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be729f9de6c64240645dc80a24162ac4d3fe00a8 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 29 Sep 2025 10:23:23 +0200
Subject: [PATCH] drm/gma500: Remove unused helper psb_fbdev_fb_setcolreg()

Remove psb_fbdev_fb_setcolreg(), which hasn't been called in almost
a decade.

Gma500 commit 4d8d096e9ae8 ("gma500: introduce the framebuffer support
code") added the helper psb_fbdev_fb_setcolreg() for setting the fbdev
palette via fbdev's fb_setcolreg callback. Later
commit 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for
fb_ops") set several default helpers for fbdev emulation, including
fb_setcmap.

The fbdev subsystem always prefers fb_setcmap over fb_setcolreg. [1]
Hence, the gma500 code is no longer in use and gma500 has been using
drm_fb_helper_setcmap() for several years without issues.

Fixes: 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for fb_ops")
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Stefan Christ <contact@stefanchrist.eu>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.10+
Link: https://elixir.bootlin.com/linux/v6.16.9/source/drivers/video/fbdev/core/fbcmap.c#L246 # [1]
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Link: https://lore.kernel.org/r/20250929082338.18845-1-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index 32d31e5f5f1a..a6af21514cff 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -50,48 +50,6 @@ static const struct vm_operations_struct psb_fbdev_vm_ops = {
  * struct fb_ops
  */
 
-#define CMAP_TOHW(_val, _width) ((((_val) << (_width)) + 0x7FFF - (_val)) >> 16)
-
-static int psb_fbdev_fb_setcolreg(unsigned int regno,
-				  unsigned int red, unsigned int green,
-				  unsigned int blue, unsigned int transp,
-				  struct fb_info *info)
-{
-	struct drm_fb_helper *fb_helper = info->par;
-	struct drm_framebuffer *fb = fb_helper->fb;
-	uint32_t v;
-
-	if (!fb)
-		return -ENOMEM;
-
-	if (regno > 255)
-		return 1;
-
-	red = CMAP_TOHW(red, info->var.red.length);
-	blue = CMAP_TOHW(blue, info->var.blue.length);
-	green = CMAP_TOHW(green, info->var.green.length);
-	transp = CMAP_TOHW(transp, info->var.transp.length);
-
-	v = (red << info->var.red.offset) |
-	    (green << info->var.green.offset) |
-	    (blue << info->var.blue.offset) |
-	    (transp << info->var.transp.offset);
-
-	if (regno < 16) {
-		switch (fb->format->cpp[0] * 8) {
-		case 16:
-			((uint32_t *) info->pseudo_palette)[regno] = v;
-			break;
-		case 24:
-		case 32:
-			((uint32_t *) info->pseudo_palette)[regno] = v;
-			break;
-		}
-	}
-
-	return 0;
-}
-
 static int psb_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	if (vma->vm_pgoff != 0)
@@ -135,7 +93,6 @@ static const struct fb_ops psb_fbdev_fb_ops = {
 	.owner = THIS_MODULE,
 	__FB_DEFAULT_IOMEM_OPS_RDWR,
 	DRM_FB_HELPER_DEFAULT_OPS,
-	.fb_setcolreg = psb_fbdev_fb_setcolreg,
 	__FB_DEFAULT_IOMEM_OPS_DRAW,
 	.fb_mmap = psb_fbdev_fb_mmap,
 	.fb_destroy = psb_fbdev_fb_destroy,


