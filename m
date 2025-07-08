Return-Path: <stable+bounces-161222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE91AFD415
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEC8188B7AB
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7E8202F70;
	Tue,  8 Jul 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1gJa3YG3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7958F5E;
	Tue,  8 Jul 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993950; cv=none; b=q2syV503pO/IJ9xPaQo8S09P2nYSrNv0b2nWo4Jo6WxTI6rGLRCC9OGQcCL8T9WQB4J1wPPupE3UtHmm4iitU8/4S+2MMFDRfbM1YQsHhnnXgZmyILDUs5YCYj6viDr6AuOr1IFEwbStrD4y/wNzPbqdUTAgTnB1zicWfWiJbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993950; c=relaxed/simple;
	bh=WlqP1P6gRj9MTyBkOWxqgd7b2CVTcxy1jeg3Q34VnCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4BcB2QYvh/qiVS44O1zOdCsTzYLphHpcnq1IpoxwgMhg95wfWJEodgiPow3naK7EAVz5SRfbSPWGYlFqOLIcPK1ctssgQXU5eedQ0pVaYloT3AnQ5fDFbGw0MJ339IXlibYsDAjCNtkU7LboZsIKcyPlTQSUAVijDFSy1l81sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1gJa3YG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5792FC4CEED;
	Tue,  8 Jul 2025 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993949;
	bh=WlqP1P6gRj9MTyBkOWxqgd7b2CVTcxy1jeg3Q34VnCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1gJa3YG3Wy21zrMPTLZ1Cuu/vH8LPgX5/xYXOXIYERwiQPSDStyoImcWzMx62X88d
	 ydhF52psbVW8Mb+BzQMVYT3HmOF9+YrmKWaNQKCOu0vAksqb8rmpNeFW3+b5eEcSLX
	 jOKt5n+jaqXD6sqGl01wHTSXnq1rZ6LN8rFlzJmc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 044/160] fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in fb_videomode_to_var
Date: Tue,  8 Jul 2025 18:21:21 +0200
Message-ID: <20250708162232.760659324@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

[ Upstream commit 17186f1f90d34fa701e4f14e6818305151637b9e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbmem.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 5e8ee360f6ba2..a8d6bd465ffe4 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1622,7 +1622,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 
 static int do_register_framebuffer(struct fb_info *fb_info)
 {
-	int i;
+	int i, err = 0;
 	struct fb_videomode mode;
 
 	if (fb_check_foreignness(fb_info))
@@ -1635,10 +1635,18 @@ static int do_register_framebuffer(struct fb_info *fb_info)
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
@@ -1671,16 +1679,12 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	if (!fb_info->pixmap.blit_y)
 		fb_info->pixmap.blit_y = ~(u32)0;
 
-	if (!fb_info->modelist.prev || !fb_info->modelist.next)
-		INIT_LIST_HEAD(&fb_info->modelist);
-
 	if (fb_info->skip_vt_switch)
 		pm_vt_switch_required(fb_info->dev, false);
 	else
 		pm_vt_switch_required(fb_info->dev, true);
 
-	fb_var_to_videomode(&mode, &fb_info->var);
-	fb_add_videomode(&mode, &fb_info->modelist);
+	num_registered_fb++;
 	registered_fb[i] = fb_info;
 
 #ifdef CONFIG_GUMSTIX_AM200EPD
-- 
2.39.5




