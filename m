Return-Path: <stable+bounces-156443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC988AE4F9D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D325162CE5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DADF21B9C9;
	Mon, 23 Jun 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RkAzziSs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583781EFFA6;
	Mon, 23 Jun 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713424; cv=none; b=Yx4AcypRLYzL7uYJn/sekCBOWMOeX/UUWscIFIq0cIE8U8hCqxyo/Dyjx7P4rIwIQS0jvAoPP7gXOWXq+NL7286v7h2MY24iXzvw2HSr+5FgFwBlBpELcnQUoS/74oAbBKDcC+8PILaK0MY8DJrUf8xcCBsZeYyoxLetf9o2In8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713424; c=relaxed/simple;
	bh=gPliUPd1XJqlBfhyCAjdTduhJBGz2N3rM3dEhaEzKq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jES9PGovZslBZX8eX276tN0qHSTt8k85vt+Qb4yGcfnZw87ZGjQeS50WrYQYh27rS7Cidnezmq+egTZ00TeOErIE6FEEwniKw1yJq3iEPtjoMdFlDbJyU6KIvNNVWnwA3hP0O3PVLqAWN8/y6XyNBg+OotHV6c374vBMOl8ZVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RkAzziSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56C0C4CEEA;
	Mon, 23 Jun 2025 21:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713424;
	bh=gPliUPd1XJqlBfhyCAjdTduhJBGz2N3rM3dEhaEzKq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkAzziSs9EC+/BEYSPeIpchBhps579G52eOPWJh1uS/NnSc3iuUPTgeOSdYV8BHHe
	 EnTjYgmM9Q6Eg0Q93dDA08wadwOmD9euSKfqmtBVXVrTw1K1cu54z4PcUQ4Fb6RKbC
	 EsEXVxdlMCqNuDkac2LWg89711hp12gY9zIoAlvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6 074/290] fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var
Date: Mon, 23 Jun 2025 15:05:35 +0200
Message-ID: <20250623130629.217083939@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

commit 17186f1f90d34fa701e4f14e6818305151637b9e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fbmem.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -928,7 +928,7 @@ static int fb_check_foreignness(struct f
 
 static int do_register_framebuffer(struct fb_info *fb_info)
 {
-	int i;
+	int i, err = 0;
 	struct fb_videomode mode;
 
 	if (fb_check_foreignness(fb_info))
@@ -937,10 +937,18 @@ static int do_register_framebuffer(struc
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
@@ -966,16 +974,12 @@ static int do_register_framebuffer(struc
 	if (!fb_info->pixmap.blit_y)
 		fb_info->pixmap.blit_y = ~(u32)0;
 
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



