Return-Path: <stable+bounces-26084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7325D870CFF
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE6C28BCF9
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3E7992E;
	Mon,  4 Mar 2024 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y7Moknq/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2F1F60A;
	Mon,  4 Mar 2024 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587803; cv=none; b=Ffn44s8awu7/hrAKYx/IYIxtaebHOiBxamI83jQjgsHp0myeTbdmc1E6XVO30KDktHVL7C35Xji4x1hnFUsDmYIXNgVq+iY0Mq+L69VcPavwCaWzH81HN+7/SfXXHa3x70HXbNlnCIjXctuqoFWOy7PoXQPEU9okVZfFsB3OQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587803; c=relaxed/simple;
	bh=ZJBwGmk47ic449+qQnD+JLpO9z5oW7nb5N16ISZAkYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RU6DXlfc1rSelAGiknIpAqBipmBvE5buVIdyfZ5fiaDGLnIYGVFU8KuLp0KcrtybZ/4/GoK1COF75bEPSB1Vn7nZ2OhF42GUk6fQ2pn8THr91MZ5ZCvNEfLPacOLlF0rsRLm59w4tUxTPcVP+NvulyCaY2wziOuo4aGmQQp/hw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y7Moknq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F625C433C7;
	Mon,  4 Mar 2024 21:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587803;
	bh=ZJBwGmk47ic449+qQnD+JLpO9z5oW7nb5N16ISZAkYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y7Moknq/dApOSYYjwD+QyhU3tc3zNA7e6zy8fRweP7F4aKVavSLIhWNbn2jxK+X43
	 iJLxqayEMDOmIC3XnRKW+F4kfSkDIvhqZQ3+DkYdho5WnfAE4XlOTZTllAVb0RCm4V
	 2fWqkkJo/KvyMjbNxczRdznMZvc6/XP8/GH5SjXc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ubisectech Sirius <bugreport@ubisectech.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 062/162] fbcon: always restore the old font data in fbcon_do_set_font()
Date: Mon,  4 Mar 2024 21:22:07 +0000
Message-ID: <20240304211553.833429338@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

[ Upstream commit 00d6a284fcf3fad1b7e1b5bc3cd87cbfb60ce03f ]

Commit a5a923038d70 (fbdev: fbcon: Properly revert changes when
vc_resize() failed) started restoring old font data upon failure (of
vc_resize()). But it performs so only for user fonts. It means that the
"system"/internal fonts are not restored at all. So in result, the very
first call to fbcon_do_set_font() performs no restore at all upon
failing vc_resize().

This can be reproduced by Syzkaller to crash the system on the next
invocation of font_get(). It's rather hard to hit the allocation failure
in vc_resize() on the first font_set(), but not impossible. Esp. if
fault injection is used to aid the execution/failure. It was
demonstrated by Sirius:
  BUG: unable to handle page fault for address: fffffffffffffff8
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD cb7b067 P4D cb7b067 PUD cb7d067 PMD 0
  Oops: 0000 [#1] PREEMPT SMP KASAN
  CPU: 1 PID: 8007 Comm: poc Not tainted 6.7.0-g9d1694dc91ce #20
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  RIP: 0010:fbcon_get_font+0x229/0x800 drivers/video/fbdev/core/fbcon.c:2286
  Call Trace:
   <TASK>
   con_font_get drivers/tty/vt/vt.c:4558 [inline]
   con_font_op+0x1fc/0xf20 drivers/tty/vt/vt.c:4673
   vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
   vt_ioctl+0x632/0x2ec0 drivers/tty/vt/vt_ioctl.c:752
   tty_ioctl+0x6f8/0x1570 drivers/tty/tty_io.c:2803
   vfs_ioctl fs/ioctl.c:51 [inline]
  ...

So restore the font data in any case, not only for user fonts. Note the
later 'if' is now protected by 'old_userfont' and not 'old_data' as the
latter is always set now. (And it is supposed to be non-NULL. Otherwise
we would see the bug above again.)

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resize() failed")
Reported-and-tested-by: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20240208114411.14604-1-jirislaby@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 63af6ab034b5f..e6c45d585482f 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2400,11 +2400,9 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
-	char *old_data = NULL;
+	u8 *old_data = vc->vc_font.data;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
-	if (p->userfont)
-		old_data = vc->vc_font.data;
 	vc->vc_font.data = (void *)(p->fontdata = data);
 	old_userfont = p->userfont;
 	if ((p->userfont = userfont))
@@ -2438,13 +2436,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
-	if (old_data && (--REFCOUNT(old_data) == 0))
+	if (old_userfont && (--REFCOUNT(old_data) == 0))
 		kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
 	return 0;
 
 err_out:
 	p->fontdata = old_data;
-	vc->vc_font.data = (void *)old_data;
+	vc->vc_font.data = old_data;
 
 	if (userfont) {
 		p->userfont = old_userfont;
-- 
2.43.0




