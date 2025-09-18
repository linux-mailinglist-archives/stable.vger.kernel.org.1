Return-Path: <stable+bounces-170996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813E4B2A7B2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86017682913
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8345E207A26;
	Mon, 18 Aug 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AaWPbbf2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E1335BA0;
	Mon, 18 Aug 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524475; cv=none; b=mDWcZrrrEI0HQDQVqOg3uShfCrdNtPFTP9/G3zj5nsPs/BkpjiScuiIAxY9um/c5aHREXqWNGZAqBg5rjH7F06nDlJKwZJVEBgIoHOl97EfikVY6tVvmeNKQlQ0P76vb8OWhVBgClhKLOG81oUo5CvZ/lWW6KB9533wsdu/qJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524475; c=relaxed/simple;
	bh=zh+WbuBsNHywc1w+1vQAWCABG5r+2Ccf7JbZ65KLW8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMGASONEjXfa4aq/v0smlQmkWDvMSqSFJjcZqB37xYa9oQaItL1V3M883pak0IlOx3ilDeoaew9izq9OJDKbKXkqo7CqsPhiM4mBkVHHsRJKAsUkLqhpptBb8gsCI/Cb5hRrcZky8Fk+nCf4JxYay3R2u/xcd/w6hgwDNQJtWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AaWPbbf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4369CC4CEEB;
	Mon, 18 Aug 2025 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524474;
	bh=zh+WbuBsNHywc1w+1vQAWCABG5r+2Ccf7JbZ65KLW8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaWPbbf2YR+eoeHDOWmq0nk/AXBnNuSKHnopWHbw/01szjErtR/ciXun0Rqi5dd8J
	 dI2CEtHQ74gjAOC5WHoOwEhTIf6npG+mghiQNZTZAibVfWldMwRbri5Q2mtZU2beZG
	 49WYetePYAQOl5ADsmNtsFjKrqX5VvjiuL+5K6vw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Helge Deller <deller@gmx.de>,
	syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com
Subject: [PATCH 6.15 484/515] fbdev: Fix vmalloc out-of-bounds write in fast_imageblit
Date: Mon, 18 Aug 2025 14:47:50 +0200
Message-ID: <20250818124517.058375336@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sravan Kumar Gundu <sravankumarlpu@gmail.com>

commit af0db3c1f898144846d4c172531a199bb3ca375d upstream.

This issue triggers when a userspace program does an ioctl
FBIOPUT_CON2FBMAP by passing console number and frame buffer number.
Ideally this maps console to frame buffer and updates the screen if
console is visible.

As part of mapping it has to do resize of console according to frame
buffer info. if this resize fails and returns from vc_do_resize() and
continues further. At this point console and new frame buffer are mapped
and sets display vars. Despite failure still it continue to proceed
updating the screen at later stages where vc_data is related to previous
frame buffer and frame buffer info and display vars are mapped to new
frame buffer and eventully leading to out-of-bounds write in
fast_imageblit(). This bheviour is excepted only when fg_console is
equal to requested console which is a visible console and updates screen
with invalid struct references in fbcon_putcs().

Reported-and-tested-by: syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
Signed-off-by: Sravan Kumar Gundu <sravankumarlpu@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fbcon.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -825,7 +825,8 @@ static void con2fb_init_display(struct v
 				   fg_vc->vc_rows);
 	}
 
-	update_screen(vc_cons[fg_console].d);
+	if (fg_console != unit)
+		update_screen(vc_cons[fg_console].d);
 }
 
 /**
@@ -1362,6 +1363,7 @@ static void fbcon_set_disp(struct fb_inf
 	struct vc_data *svc;
 	struct fbcon_ops *ops = info->fbcon_par;
 	int rows, cols;
+	unsigned long ret = 0;
 
 	p = &fb_display[unit];
 
@@ -1412,11 +1414,10 @@ static void fbcon_set_disp(struct fb_inf
 	rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
 	cols /= vc->vc_font.width;
 	rows /= vc->vc_font.height;
-	vc_resize(vc, cols, rows);
+	ret = vc_resize(vc, cols, rows);
 
-	if (con_is_visible(vc)) {
+	if (con_is_visible(vc) && !ret)
 		update_screen(vc);
-	}
 }
 
 static __inline__ void ywrap_up(struct vc_data *vc, int count)



