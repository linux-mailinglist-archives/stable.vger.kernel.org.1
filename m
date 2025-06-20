Return-Path: <stable+bounces-155001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C34AE1628
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE17F5A5C9F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90497218E97;
	Fri, 20 Jun 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xUMVf/gV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72C2AD16
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408394; cv=none; b=WN9PVOhjFtvmJqLxeleK5eXZJaZlWWH07Dwv9Jrpy1bI1HlxKO4mfdpfbKpmR1ZbpQ2hFGn0G2lQoo84ZioG8SPbCa6YadEkM1KPx5kgH8H8pe/EQFiMWc0btwD+RgJGJ8KpHQOVgDdaGLErQd2RWkuICHzBmpjyoupXKH62liw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408394; c=relaxed/simple;
	bh=n9NWCttTHDi3IM521IC8apEfaIg3rFigb3gTy8G1p9g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t1Xyx9S9DTCWt5p97ZyPhWrioGRkNaPOA0I2tL/eB/V0+L//LaMV0d3bGqxlbo/Q2yH/AhC+5LRSZRKi+5BvOPd/pcgZRJ1aAjg7n01l3lamWH+pEjOYSEkrU/qqFpRDK92x+0il+gz+LLtgnydYKJZW2hS8t7LzjnRsgbcejDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xUMVf/gV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D081C4CEED;
	Fri, 20 Jun 2025 08:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750408393;
	bh=n9NWCttTHDi3IM521IC8apEfaIg3rFigb3gTy8G1p9g=;
	h=Subject:To:Cc:From:Date:From;
	b=xUMVf/gVkcdlOPZOpdWPVFTAuWbInZCKNqqEazZVySMTlp+G2vCiYKlzEcins+fUP
	 Ua1Xxxs41/KtM74J2/KBIY1+qJHIC51FSLo+w5y9ldYqUKUglSF+1/Je0sfMGJV+Nl
	 fW02tk3s1ynvkylyCdXhqd01zJmN/BydFBCsmczE=
Subject: FAILED: patch "[PATCH] fbdev: Fix do_register_framebuffer to prevent null-ptr-deref" failed to apply to 5.15-stable tree
To: m.masimov@mt-integration.ru,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:33:02 +0200
Message-ID: <2025062002-haven-boil-c0ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 17186f1f90d34fa701e4f14e6818305151637b9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062002-haven-boil-c0ad@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 17186f1f90d34fa701e4f14e6818305151637b9e Mon Sep 17 00:00:00 2001
From: Murad Masimov <m.masimov@mt-integration.ru>
Date: Mon, 28 Apr 2025 18:34:06 +0300
Subject: [PATCH] fbdev: Fix do_register_framebuffer to prevent null-ptr-deref
 in fb_videomode_to_var

If fb_add_videomode() in do_register_framebuffer() fails to allocate
memory for fb_videomode, it will later lead to a null-ptr dereference in
fb_videomode_to_var(), as the fb_info is registered while not having the
mode in modelist that is expected to be there, i.e. the one that is
described in fb_info->var.

================================================================
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 30371 Comm: syz-executor.1 Not tainted 5.10.226-syzkaller #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:fb_videomode_to_var+0x24/0x610 drivers/video/fbdev/core/modedb.c:901
Call Trace:
 display_to_var+0x3a/0x7c0 drivers/video/fbdev/core/fbcon.c:929
 fbcon_resize+0x3e2/0x8f0 drivers/video/fbdev/core/fbcon.c:2071
 resize_screen drivers/tty/vt/vt.c:1176 [inline]
 vc_do_resize+0x53a/0x1170 drivers/tty/vt/vt.c:1263
 fbcon_modechanged+0x3ac/0x6e0 drivers/video/fbdev/core/fbcon.c:2720
 fbcon_update_vcs+0x43/0x60 drivers/video/fbdev/core/fbcon.c:2776
 do_fb_ioctl+0x6d2/0x740 drivers/video/fbdev/core/fbmem.c:1128
 fb_ioctl+0xe7/0x150 drivers/video/fbdev/core/fbmem.c:1203
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x19a/0x210 fs/ioctl.c:739
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1
================================================================

Even though fbcon_init() checks beforehand if fb_match_mode() in
var_to_display() fails, it can not prevent the panic because fbcon_init()
does not return error code. Considering this and the comment in the code
about fb_match_mode() returning NULL - "This should not happen" - it is
better to prevent registering the fb_info if its mode was not set
successfully. Also move fb_add_videomode() closer to the beginning of
do_register_framebuffer() to avoid having to do the cleanup on fail.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 3c568cff2913..e1557d80768f 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -388,7 +388,7 @@ static int fb_check_foreignness(struct fb_info *fi)
 
 static int do_register_framebuffer(struct fb_info *fb_info)
 {
-	int i;
+	int i, err = 0;
 	struct fb_videomode mode;
 
 	if (fb_check_foreignness(fb_info))
@@ -397,10 +397,18 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	if (num_registered_fb == FB_MAX)
 		return -ENXIO;
 
-	num_registered_fb++;
 	for (i = 0 ; i < FB_MAX; i++)
 		if (!registered_fb[i])
 			break;
+
+	if (!fb_info->modelist.prev || !fb_info->modelist.next)
+		INIT_LIST_HEAD(&fb_info->modelist);
+
+	fb_var_to_videomode(&mode, &fb_info->var);
+	err = fb_add_videomode(&mode, &fb_info->modelist);
+	if (err < 0)
+		return err;
+
 	fb_info->node = i;
 	refcount_set(&fb_info->count, 1);
 	mutex_init(&fb_info->lock);
@@ -426,16 +434,12 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	if (bitmap_empty(fb_info->pixmap.blit_y, FB_MAX_BLIT_HEIGHT))
 		bitmap_fill(fb_info->pixmap.blit_y, FB_MAX_BLIT_HEIGHT);
 
-	if (!fb_info->modelist.prev || !fb_info->modelist.next)
-		INIT_LIST_HEAD(&fb_info->modelist);
-
 	if (fb_info->skip_vt_switch)
 		pm_vt_switch_required(fb_info->device, false);
 	else
 		pm_vt_switch_required(fb_info->device, true);
 
-	fb_var_to_videomode(&mode, &fb_info->var);
-	fb_add_videomode(&mode, &fb_info->modelist);
+	num_registered_fb++;
 	registered_fb[i] = fb_info;
 
 #ifdef CONFIG_GUMSTIX_AM200EPD


