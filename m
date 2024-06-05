Return-Path: <stable+bounces-48012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A03748FCB29
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EE71C20CA3
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF72198847;
	Wed,  5 Jun 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRy0mk/k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8819883E;
	Wed,  5 Jun 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588214; cv=none; b=Te6qDwlyRqphcEr0P+SydJCNGkZBzFCvoz0yylLsY2jxbokxVXDyIJj6MF4X9BRp2EE+wgtWkdJBOzQOCr+SAWlMwIBJLxhVKVaknUgHcVkVNtkZIWsqBWZLUONFInwnMmtgcPqb3GnnyRTTttfXHVuhrmQDzpichE7mOnlVR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588214; c=relaxed/simple;
	bh=fleVN7ISfaghh035pXo3iOZUVpDnya1Sga8sZg6qgrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcp885tovOp7O795uQHQUY0SPzMwBC/5R2PlHhogaTT7SaouQ1GFeGGobFS8cakQ+cMiybxabSDz/Q5+71vUKM1UUdIthH2CxQsWSrJT0kgnMjWy+tv1xRVpqILAiFn7W3ezlM2k5TXW+9OOra8MWZaKWnHCqZMfL2vPZlhvUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRy0mk/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D1BC32781;
	Wed,  5 Jun 2024 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588214;
	bh=fleVN7ISfaghh035pXo3iOZUVpDnya1Sga8sZg6qgrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRy0mk/ktghfoSlSMGs+kUPzp3HMMat0TWK1ola6up1bfQqRtFVZ/iFx7mZhAzRFI
	 S13R/OW3pbsH4zIxEJWEYWqyqv0ObnXNPwAmTmdUIN2MoTqCtms6ni1F8QROy4UENf
	 Dmy1wMKD9Jc1qbUm81ERDFkbvdYCpslhBoaRSGAmxw/TbTxPOf76WafiP3Ozh1TmbY
	 u6omzwwNfI99ZAk36e3IvrhftAC8ws0UaRvKKcyJ0sRmmzY6MMUqjPy6sFc4hxNFX8
	 4phc7ehfwWXZPSoAK4kDEO+HcqnmZ0tlgwDYqB3yTwwWPAbrW+jWajzxHimH0arTO+
	 GdQL00RyEwdwg==
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
Subject: [PATCH AUTOSEL 6.9 19/28] tty: add the option to have a tty reject a new ldisc
Date: Wed,  5 Jun 2024 07:48:48 -0400
Message-ID: <20240605114927.2961639-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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
index 9b5b98dfc8b40..cd87e3d1291ed 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3576,6 +3576,15 @@ static void con_cleanup(struct tty_struct *tty)
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
@@ -3695,6 +3704,7 @@ static const struct tty_operations con_ops = {
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


