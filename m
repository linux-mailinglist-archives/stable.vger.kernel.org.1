Return-Path: <stable+bounces-127101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BBA76862
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8297A2133
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C9225396;
	Mon, 31 Mar 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwJYPg3b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EF214A92;
	Mon, 31 Mar 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431752; cv=none; b=KZHy4oPXg6unH14hymedI1l0bTaKjzOAHL+2yYeMJQspECNBC0+9IjntYFtRlk+IjO87NRjW3H4HZKVOFrvFS0WxKKB77kcPTszt4nItydSRFyxhuqS3wIEONcpOpMokVJnAYDsXCmumn6MM4QgFJcLV3P+IOor+2Fo2zlwFYi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431752; c=relaxed/simple;
	bh=ph6kfzHAh0EM3oPxVjEcnTH6scR9G5BgbmruTaFYM0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+jU2vF5/XN9dyUtAAkZxwqTMnZ2tdo2RoAylROwfdlm27Myq4YQBtQCEjlo9zzPXX++zxzK7sRpuiXmXIkS6kZ+1vsSePRJM9f1OVw/z/xhw//flFmhZSoTaxYqJXvPYiAY1m0ws1upFYyC8Ep2wJNoPLu3BmpJbvfqQvaTdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwJYPg3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156F7C4CEE4;
	Mon, 31 Mar 2025 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431751;
	bh=ph6kfzHAh0EM3oPxVjEcnTH6scR9G5BgbmruTaFYM0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwJYPg3bBzwSCHHTvLDZ6d3WMnU/516dmADQ213qGvSrVjS4vXUbvFp/APk774GtP
	 ZNapE+X0XQIQ5OKFUlEogem/6FX/GyPMa/812sg5XOxFtRt5LnHCfXBwjDJ/igknIQ
	 OUOhVEwzdTVl634qlNFU2HnJa9lZufHSzZMRhvIXksM6dr+KEQeCal4Au4t81mdbW8
	 idrUUKLJDRM0eO5WaLjVWQaR7i4qNJP2YvTQE20cJWqIIzpofZQW6IcVScqrl1/yXU
	 euxoGutpgM0Bmj7mGazpB+ehZSVvYMjqGn18qCKKA36nB15KcFxWdAbsEdunoJmrPW
	 fA60SS6fJvh9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	joel.granados@kernel.org,
	akpm@linux-foundation.org,
	wei.liu@kernel.org,
	linux@weissschuh.net,
	zhangguopeng@kylinos.cn,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 09/13] Flush console log from kernel_power_off()
Date: Mon, 31 Mar 2025 10:35:23 -0400
Message-Id: <20250331143528.1685794-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143528.1685794-1-sashal@kernel.org>
References: <20250331143528.1685794-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 6ea9a1781c70a8be1fcdc49134fc1bf4baba8bca ]

Kernels built with CONFIG_PREEMPT_RT=y can lose significant console output
and shutdown time, which hides shutdown-time RCU issues from rcutorture.
Therefore, make pr_flush() public and invoke it after then last print
in kernel_power_off().

[ paulmck: Apply John Ogness feedback. ]
[ paulmck: Appy Sebastian Andrzej Siewior feedback. ]
[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://lore.kernel.org/r/5f743488-dc2a-4f19-bdda-cf50b9314832@paulmck-laptop
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/printk.h | 6 ++++++
 kernel/printk/printk.c | 4 +---
 kernel/reboot.c        | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index eca9bb2ee637b..0cb647ecd77f5 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -204,6 +204,7 @@ void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -304,6 +305,11 @@ static inline void nbcon_atomic_flush_unsafe(void)
 {
 }
 
+static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
+{
+	return true;
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3b75f6e8410b9..881a26e18c658 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2436,7 +2436,6 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -2449,7 +2448,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 static u64 syslog_seq;
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
@@ -4436,7 +4434,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all usable printers are caught up.
  */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f05dbde2c93fe..d6ee090eda943 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -697,6 +697,7 @@ void kernel_power_off(void)
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
+	pr_flush(1000, true);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_power_off();
 }
-- 
2.39.5


