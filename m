Return-Path: <stable+bounces-127089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1CA7684D
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF17A36A7
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839E0222563;
	Mon, 31 Mar 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjhNu388"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9412222D9;
	Mon, 31 Mar 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431718; cv=none; b=diDTiLnmvvjzt2CGaNRNXtyBDzzwtUu5YfNPcBlIZo3kjGNzkb/QX/TZNeim39jUlXZl5OuTqRrfwp7NvQfRVhW8QsuWKxLbJ1oWYATObz6bOa6IcMpnKto6mNydN+6/8qGdOQAiYZewsMH08uEJcPPEWeZRIZqodlPjoGSTLHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431718; c=relaxed/simple;
	bh=0isJ5Jd2yjV2HU1pmWz4MqH5sUVQ3IcQZm2LWPSWiO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0IPz2mfMZ5OKHyEZsIb5IL5jw/+sxE1NZV4raizNeApz5f82b1i4t9zF9BCaW8iGtnnceHMaTSKw5mU+ttuDk1FwTXrgPB6N345iG+fWYOR9i4wagW2ER6zVwmh0s1iEXZQsbbznqoTsL1TGcxKfEmOuCZygTK4DJ1Is3fL/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjhNu388; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256D6C4CEE4;
	Mon, 31 Mar 2025 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431718;
	bh=0isJ5Jd2yjV2HU1pmWz4MqH5sUVQ3IcQZm2LWPSWiO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjhNu388lQ8KilT79sbOfE5HRuivCxVQwZQ7hM05mG+rN0qTAvUn4PjhQRsedwBZZ
	 X+kpQ7LLs7E49nR0K4Dlb2DGVTe9G/4oRmIxbHt4hrtQed842+gjPp3D9om9yRHL7z
	 Afeo6ozdfrIP/97F7fPIiUBhJNRU+Kbj78RZ/p7m2yG7x354wJJ/3g2sHe9hwX91Wc
	 yW8KrC3sG1doMSHYYvDlkztfQGKeAtaCl3yGAmrilV1376XVhYCcmcuKNIWZJkGcgX
	 tyi9k0OfS9ePOu4XfQfxHBi/MH03JyTv0Ovjk1nPzhSsesb7s6j4r5ZcX97MeTIiyn
	 CdsjV/PZOuU7g==
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
	jani.nikula@intel.com,
	bhe@redhat.com,
	linux@weissschuh.net,
	zhangguopeng@kylinos.cn,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 11/16] Flush console log from kernel_power_off()
Date: Mon, 31 Mar 2025 10:34:45 -0400
Message-Id: <20250331143450.1685242-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143450.1685242-1-sashal@kernel.org>
References: <20250331143450.1685242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 4217a9f412b26..5b462029d03c1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -207,6 +207,7 @@ void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
+bool pr_flush(int timeout_ms, bool reset_on_progress);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -315,6 +316,11 @@ static inline void nbcon_atomic_flush_unsafe(void)
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
index 07668433644b8..057db78876cd9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2461,7 +2461,6 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress);
 
 #else /* CONFIG_PRINTK */
@@ -2474,7 +2473,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 static u64 syslog_seq;
 
-static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
 #endif /* CONFIG_PRINTK */
@@ -4466,7 +4464,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * Context: Process context. May sleep while acquiring console lock.
  * Return: true if all usable printers are caught up.
  */
-static bool pr_flush(int timeout_ms, bool reset_on_progress)
+bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a701000bab347..3ba15b2c40662 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -704,6 +704,7 @@ void kernel_power_off(void)
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	pr_emerg("Power down\n");
+	pr_flush(1000, true);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_power_off();
 }
-- 
2.39.5


