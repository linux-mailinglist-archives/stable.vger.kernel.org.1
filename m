Return-Path: <stable+bounces-48038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780188FCB84
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593E02872FE
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B41A1872;
	Wed,  5 Jun 2024 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBYs6BaH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431D1A1860;
	Wed,  5 Jun 2024 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588306; cv=none; b=INAwsJiCDaMHEN2Dl46UI4iDvoCHrs+hr08Qrd31ccfte4ACmLKe28Ph6C5vfIwNxN5O9BefVgrqAwr7ix+u7z7Ji6u1XKLOL6roh4ORNLLW+I8Ci8CxqBG/Wg7VQNVEgZt0Q46m1MnMeh1+k4RxPnGR8YHgVymSAJWodtN4v/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588306; c=relaxed/simple;
	bh=/koGbcjt/brA1y2OEcG0TQp5Myw75w2PN2xhFyfAxqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSAyHCKsJ/ewEsOEWqdpdCApvKNiSDf1XgXuOGmf0SWlK2ghqjXt2F8/UsYla1Hx77fkkHiCiFlv5ra4EG+ehFI+h1spo5swyBB+5FyZJwkBWkh7utBwfyilMc3zuWnBItmtjyLmDvyQdBTd1Qy5j3WmSbzXBqD/C3VOXRuJCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBYs6BaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264ABC32786;
	Wed,  5 Jun 2024 11:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588306;
	bh=/koGbcjt/brA1y2OEcG0TQp5Myw75w2PN2xhFyfAxqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBYs6BaHUfKmIq+xNOesILNOuDpU42yoCTJtoou2jMaWyB6uGcafhV6JVpRpVfqZV
	 MZYV/1UpE0heY6MUGNIxtzikCjnnF/OKFAI3TRVNWGgRVr+D83ex8Pu+/it4cB/J1k
	 Vxo5gnWwoRoR9aR2VoGmZGbCSG5kyJl2wczzTjCyW0pT9pxEKn+gzLhhdQ4mpgH7P/
	 1TJvprCUebZf9fZsTk8T/r1oM0G7VJGn+XPITU4CUgca7Kwcwy9wN2LnJnWpKVEprN
	 m+z7wPbT5wIv1y0RdiPo9lRwarTKlJ3eADDBMLav88jNyAQSuz2KJTNrKJrVfghP5Q
	 OuRDn9PIdO/jQ==
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
Subject: [PATCH AUTOSEL 6.8 17/24] tty: add the option to have a tty reject a new ldisc
Date: Wed,  5 Jun 2024 07:50:27 -0400
Message-ID: <20240605115101.2962372-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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
index 52e6ca1ba21df..09126aed97bc1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3396,6 +3396,15 @@ static void con_cleanup(struct tty_struct *tty)
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
@@ -3515,6 +3524,7 @@ static const struct tty_operations con_ops = {
 	.resize = vt_resize,
 	.shutdown = con_shutdown,
 	.cleanup = con_cleanup,
+	.ldisc_ok = con_ldisc_ok,
 };
 
 static struct cdev vc0_cdev;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 7372124fbf90b..dd4b31ce6d5d4 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -154,6 +154,13 @@ struct serial_struct;
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
@@ -372,6 +379,7 @@ struct tty_operations {
 	void (*hangup)(struct tty_struct *tty);
 	int (*break_ctl)(struct tty_struct *tty, int state);
 	void (*flush_buffer)(struct tty_struct *tty);
+	int (*ldisc_ok)(struct tty_struct *tty, int ldisc);
 	void (*set_ldisc)(struct tty_struct *tty);
 	void (*wait_until_sent)(struct tty_struct *tty, int timeout);
 	void (*send_xchar)(struct tty_struct *tty, u8 ch);
-- 
2.43.0


