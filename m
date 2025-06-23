Return-Path: <stable+bounces-156773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3141AE5118
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E7F4412F6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29070221FD2;
	Mon, 23 Jun 2025 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ga4NavzL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA410224F6;
	Mon, 23 Jun 2025 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714230; cv=none; b=lPvosRknePN2rSH/CrDl5UwlnE2gn6qT1TB/LTeWzFhGhWzxqVTJDc8t6w6Zi+2gPZhKKTe/Tpn/5owuYrct10sSgyMMDfJpwkfpY6fBMQP+KvncB7kXISFwav5qjaCWYpHTVM2O8K39RFR0Y8IQtExNec6/KDgW1cgEPIEX6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714230; c=relaxed/simple;
	bh=Nq05HT5hjhPoZL4Hsu+RssW1c+QcmfC3+gNQiaxV16k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgviGloYPwTmHNpjGJyED4B3nb8WDifUY5I1hbFT4V6I6jjXnB2R/jytJflvqqEYop6A/hLvQ6PwJqHyHY7WvZyO2WtLrnTTEFSRnc9gExlAyTi4cx56AVDvVI5Xh0Y+e469Uin4sn5RpofZZtKmTWVkx7lHXTcC1Vy3Kgwenuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ga4NavzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EEDC4CEEA;
	Mon, 23 Jun 2025 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714230;
	bh=Nq05HT5hjhPoZL4Hsu+RssW1c+QcmfC3+gNQiaxV16k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ga4NavzL+rAK1JqxeaX0FTimThxUO5AS1jtAq2og3eIaquAIEpTtbnGVxhcFAT652
	 Dqw4r+AH0L7Wlse9PlsHnQA9+UkGhU9JQCIp4JTewuXsnVDSq6qxH0NGCLUiMLVDKi
	 OSAWhR4Z2YbxFpK+j84LQINYvWK19EnkQCvOrSUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 5.10 193/355] fbdev: Fix fb_set_var to prevent null-ptr-deref in fb_videomode_to_var
Date: Mon, 23 Jun 2025 15:06:34 +0200
Message-ID: <20250623130632.480139464@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

commit 05f6e183879d9785a3cdf2f08a498bc31b7a20aa upstream.

If fb_add_videomode() in fb_set_var() fails to allocate memory for
fb_videomode, later it may lead to a null-ptr dereference in
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

The reason is that fb_info->var is being modified in fb_set_var(), and
then fb_videomode_to_var() is called. If it fails to add the mode to
fb_info->modelist, fb_set_var() returns error, but does not restore the
old value of fb_info->var. Restore fb_info->var on failure the same way
it is done earlier in the function.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fbmem.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1062,8 +1062,10 @@ fb_set_var(struct fb_info *info, struct
 	    !list_empty(&info->modelist))
 		ret = fb_add_videomode(&mode, &info->modelist);
 
-	if (ret)
+	if (ret) {
+		info->var = old_var;
 		return ret;
+	}
 
 	event.info = info;
 	event.data = &mode;



