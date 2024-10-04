Return-Path: <stable+bounces-80854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E664990C15
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1316EB225B1
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C6F1EBA0B;
	Fri,  4 Oct 2024 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkL7lC/o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0D1EBA06;
	Fri,  4 Oct 2024 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066063; cv=none; b=pN4KJK5h+wfjZEbte0e0/ldx6uPMtXkoTL4kHeT17KnQWzvZXjYJ71G9pAiNnPggtQKWvfHKqLclwxrJlNP7YmH5U8dWxlOnNrp7O4L73fFijB98IXRWyjHpRCNDi+k7JtUqAVu+PAiQIuuNP8RTYetdwXIMtWx2zKcklSMTHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066063; c=relaxed/simple;
	bh=oEFSlR58nDMd09E94PgA9CUZgL5fRNeq8lC+AEKU7cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hls+kalIGeO6L1iUep53DRpT29eYC6atFSz61FeISWgHTiJbpjW516rXysaUHLlDhkx6KKsbRVb9NhukaG4tF+P1KK3OdieNJErRDoVlJwirG3agw1MPvVgrzkdSdkINaqyBwYEPW6P7va61ZbMJMugijRnjFgP9rh9cqEfO+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkL7lC/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08271C4CECC;
	Fri,  4 Oct 2024 18:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066063;
	bh=oEFSlR58nDMd09E94PgA9CUZgL5fRNeq8lC+AEKU7cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkL7lC/obgZsh/nLqfpHXmC9FvHZlL68FpKQ6RVWNbwrrDswNMmLNKdga7ZbNbuUj
	 kbljTk6nettja/Hfc/i+046RPVOYQJxhjbp072FcAOahqnkuJxUdG88KeV8fFgk6uU
	 3bMQvxvy8MEVXNhXoBJtz1ij2AFU38EaGFlgSicEs+GKBSEansih244+iH6QcNcVim
	 qn0/29N08+LE0i2IGIISX6mWd1jwnYUZj+TzCAOnfIGzRoHr7GJtoOGh4UT68O68H3
	 4gW4gzsDXUgQi31VrWg2il1shBE4CaKQsogLnwCYbguhxzCnJJNrHniGABedoNKhBy
	 Jisg+w9/62YLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qianqiang Liu <qianqiang.liu@163.com>,
	syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	daniel@ffwll.ch,
	jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	geert+renesas@glider.be,
	samuel.thibault@ens-lyon.org,
	tzimmermann@suse.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 74/76] fbcon: Fix a NULL pointer dereference issue in fbcon_putcs
Date: Fri,  4 Oct 2024 14:17:31 -0400
Message-ID: <20241004181828.3669209-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Qianqiang Liu <qianqiang.liu@163.com>

[ Upstream commit 5b97eebcce1b4f3f07a71f635d6aa3af96c236e7 ]

syzbot has found a NULL pointer dereference bug in fbcon.
Here is the simplified C reproducer:

struct param {
	uint8_t type;
	struct tiocl_selection ts;
};

int main()
{
	struct fb_con2fbmap con2fb;
	struct param param;

	int fd = open("/dev/fb1", 0, 0);

	con2fb.console = 0x19;
	con2fb.framebuffer = 0;
	ioctl(fd, FBIOPUT_CON2FBMAP, &con2fb);

	param.type = 2;
	param.ts.xs = 0; param.ts.ys = 0;
	param.ts.xe = 0; param.ts.ye = 0;
	param.ts.sel_mode = 0;

	int fd1 = open("/dev/tty1", O_RDWR, 0);
	ioctl(fd1, TIOCLINUX, &param);

	con2fb.console = 1;
	con2fb.framebuffer = 0;
	ioctl(fd, FBIOPUT_CON2FBMAP, &con2fb);

	return 0;
}

After calling ioctl(fd1, TIOCLINUX, &param), the subsequent ioctl(fd, FBIOPUT_CON2FBMAP, &con2fb)
causes the kernel to follow a different execution path:

 set_con2fb_map
  -> con2fb_init_display
   -> fbcon_set_disp
    -> redraw_screen
     -> hide_cursor
      -> clear_selection
       -> highlight
        -> invert_screen
         -> do_update_region
          -> fbcon_putcs
           -> ops->putcs

Since ops->putcs is a NULL pointer, this leads to a kernel panic.
To prevent this, we need to call set_blitting_type() within set_con2fb_map()
to properly initialize ops->putcs.

Reported-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3d613ae53c031502687a
Tested-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3f7333dca508c..fedd796c9a5cd 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -847,6 +847,8 @@ static int set_con2fb_map(int unit, int newidx, int user)
 			return err;
 
 		fbcon_add_cursor_work(info);
+	} else if (vc) {
+		set_blitting_type(vc, info);
 	}
 
 	con2fb_map[unit] = newidx;
-- 
2.43.0


