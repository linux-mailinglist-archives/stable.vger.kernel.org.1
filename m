Return-Path: <stable+bounces-48060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D458FCBEF
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5758D28B876
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994431AD9E4;
	Wed,  5 Jun 2024 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx8oRjbx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466C1AD9D2;
	Wed,  5 Jun 2024 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588386; cv=none; b=VMh6tkkdrjtvd2/0ktT3WFqxhpW7izo/njL7RByOGv7XslR2hqDAb1eNrwQJtaaxR/bXUs7vDk1IqJDYhr3We7Q10jnjsZTnWxlm7XsIG7H0j3PKHMKUucr0csslhmHYYlsGAPss5gd/1HFPwTd7yod/goGgAA+uLz2feLvs/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588386; c=relaxed/simple;
	bh=GZAfX1pB/cqgkoEcGeuRbxZPy9aoOmxX1hqFvvr3+Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGIp8DUpr4KNy+nAnCndiu0qe0y6+0zhrI0BW+Iv5k1X/MHCD1Dzi42ePlf2UceFEm9+P8vhtKpRt7Mr8y4dkt/B9xM74KUpTrrxHUnb+bxn2ePlCMT0HN539uUOGQIPZMGJ6IRYGF2EskBcoBXn6TjDld1wBWxxXVHgjijBqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx8oRjbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A839C32781;
	Wed,  5 Jun 2024 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588386;
	bh=GZAfX1pB/cqgkoEcGeuRbxZPy9aoOmxX1hqFvvr3+Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mx8oRjbxpgwJ4kauMx+qPdRy6C6Y2KcqyipCv+036IuUg0AOZGjTnOaYjKgE32t21
	 Ja7kN+DyjAVq4yhBtS32C8RJ9l/NQa1x0AqCIZFTPl310C5ixwFol9nHPtKftTODRW
	 3JkeG7ywV7Ogks1ItUXC4DYNxJGgJ7I0plJkg9pkC2OYfOCumyEqwX3rdPu0I+vRWZ
	 I0NWih1lb8SLuDbSS8lPwboQjl4908x8joHo+Nx7XXf10+yW4H4hUScITHkN3GHFwP
	 LuPv1jonfX/AooknS7x9gCiLdZD7acQ7h52XyCXPHcK7bMrywLVVWPZfLruEEQuVnM
	 pMyT4Bze3WA6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Daniel Starke <daniel.starke@siemens.com>,
	syzbot <syzbot+dbac96d8e73b61aa559c@syzkaller.appspotmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/20] tty: add the option to have a tty reject a new ldisc
Date: Wed,  5 Jun 2024 07:51:58 -0400
Message-ID: <20240605115225.2963242-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 6bd23e0c2bb6c65d4f5754d1456bc9a4427fc59b ]

... and use it to limit the virtual terminals to just N_TTY.  They are
kind of special, and in particular, the "con_write()" routine violates
the "writes cannot sleep" rule that some ldiscs rely on.

This avoids the

   BUG: sleeping function called from invalid context at kernel/printk/printk.c:2659

when N_GSM has been attached to a virtual console, and gsmld_write()
calls con_write() while holding a spinlock, and con_write() then tries
to get the console lock.

Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Starke <daniel.starke@siemens.com>
Reported-by: syzbot <syzbot+dbac96d8e73b61aa559c@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240423163339.59780-1-torvalds@linux-foundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_ldisc.c    |  6 ++++++
 drivers/tty/vt/vt.c        | 10 ++++++++++
 include/linux/tty_driver.h |  8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 3f68e213df1f7..d80e9d4c974b4 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -545,6 +545,12 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
 		goto out;
 	}
 
+	if (tty->ops->ldisc_ok) {
+		retval = tty->ops->ldisc_ok(tty, disc);
+		if (retval)
+			goto out;
+	}
+
 	old_ldisc = tty->ldisc;
 
 	/* Shutdown the old discipline. */
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e66ff9c11dade..a22da757ca6d1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3390,6 +3390,15 @@ static void con_cleanup(struct tty_struct *tty)
 	tty_port_put(&vc->port);
 }
 
+/*
+ * We can't deal with anything but the N_TTY ldisc,
+ * because we can sleep in our write() routine.
+ */
+static int con_ldisc_ok(struct tty_struct *tty, int ldisc)
+{
+	return ldisc == N_TTY ? 0 : -EINVAL;
+}
+
 static int default_color           = 7; /* white */
 static int default_italic_color    = 2; // green (ASCII)
 static int default_underline_color = 3; // cyan (ASCII)
@@ -3509,6 +3518,7 @@ static const struct tty_operations con_ops = {
 	.resize = vt_resize,
 	.shutdown = con_shutdown,
 	.cleanup = con_cleanup,
+	.ldisc_ok = con_ldisc_ok,
 };
 
 static struct cdev vc0_cdev;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 18beff0cec1ab..b4f99f6a5385a 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -155,6 +155,13 @@ struct serial_struct;
  *
  *	Optional. Called under the @tty->termios_rwsem. May sleep.
  *
+ * @ldisc_ok: ``int ()(struct tty_struct *tty, int ldisc)``
+ *
+ *	This routine allows the @tty driver to decide if it can deal
+ *	with a particular @ldisc.
+ *
+ *	Optional. Called under the @tty->ldisc_sem and @tty->termios_rwsem.
+ *
  * @set_ldisc: ``void ()(struct tty_struct *tty)``
  *
  *	This routine allows the @tty driver to be notified when the device's
@@ -373,6 +380,7 @@ struct tty_operations {
 	void (*hangup)(struct tty_struct *tty);
 	int (*break_ctl)(struct tty_struct *tty, int state);
 	void (*flush_buffer)(struct tty_struct *tty);
+	int (*ldisc_ok)(struct tty_struct *tty, int ldisc);
 	void (*set_ldisc)(struct tty_struct *tty);
 	void (*wait_until_sent)(struct tty_struct *tty, int timeout);
 	void (*send_xchar)(struct tty_struct *tty, char ch);
-- 
2.43.0


