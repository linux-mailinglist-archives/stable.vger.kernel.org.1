Return-Path: <stable+bounces-94764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691449D6EE3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5AE1615B2
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53E1189B86;
	Sun, 24 Nov 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+mbw6ya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FDD18CC08;
	Sun, 24 Nov 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452320; cv=none; b=CKnR5u5RF2j23Oh2J1QB4Pbo0+pP3Y11ystlXpj/aVsjxiFSvEwpCdoz0qtN7e8rO186VJh608hCZaHnTmAjdn84j8F7+afaspv49Hgbd+PsBkEirP60w1W08BO9NKIRcz6ZXZw75Bu7s7MntKaE6/DtTWCe7Y41XB/rx0YX0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452320; c=relaxed/simple;
	bh=cvEqfEFalq+ONRHW9LKC4tm5UFwZRZ7Ui2oTH2WOQFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiPUCDLdFhCnosxKahYwHMfyoMraVj3NPczzlkAZ0MJPKar40GeV55hbBtFEU4qZcjHhiQgvUKPMYBsYKKBYzOGXUxx+fEc6YCxpXypL1VerYD8K+ZONcWhUVBunWKpUNm4tOMdXmnHAqOmtLn/nYpThjqTm1ftrnwU/1PXHbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+mbw6ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D16C4CED6;
	Sun, 24 Nov 2024 12:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452320;
	bh=cvEqfEFalq+ONRHW9LKC4tm5UFwZRZ7Ui2oTH2WOQFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+mbw6yabbwrHr1CC9NiA1LorXOusR3gArJlwmce784ayIP+/Pgd0d94ErlPcVL9f
	 3a0Ff07Im5ft1ghmDJlAnG3ajosGeTBGnsNdcWocvz6gRHrZ3lCHj8r+8VHTS3R27f
	 W1ed63EzBg2qnwEtfGimYF644TNErMYldc0Qj1y7z3NbynQ9aq6C45+SqoyVSMILoD
	 yOvz1WeVoIZzDXFc3gSbgK7HfeDprZI79DxgoxJ1cHE07QzOC7n4C5SYt+gRKu6ItD
	 fR0RMgvVxG0w8az0EXMq4h6NDjKU+LCz7I6Ly81a+uex1JWYxwxmpwaNRQYRNpFv4c
	 Xe8Sg3YqgQdiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Sasha Levin <sashal@kernel.org>,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kasan-dev@googlegroups.com,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 2/6] kcsan: Turn report_filterlist_lock into a raw_spinlock
Date: Sun, 24 Nov 2024 07:45:07 -0500
Message-ID: <20241124124516.3337485-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124516.3337485-1-sashal@kernel.org>
References: <20241124124516.3337485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Marco Elver <elver@google.com>

[ Upstream commit 59458fa4ddb47e7891c61b4a928d13d5f5b00aa0 ]

Ran Xiaokai reports that with a KCSAN-enabled PREEMPT_RT kernel, we can see
splats like:

| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
| in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
| preempt_count: 10002, expected: 0
| RCU nest depth: 0, expected: 0
| no locks held by swapper/1/0.
| irq event stamp: 156674
| hardirqs last  enabled at (156673): [<ffffffff81130bd9>] do_idle+0x1f9/0x240
| hardirqs last disabled at (156674): [<ffffffff82254f84>] sysvec_apic_timer_interrupt+0x14/0xc0
| softirqs last  enabled at (0): [<ffffffff81099f47>] copy_process+0xfc7/0x4b60
| softirqs last disabled at (0): [<0000000000000000>] 0x0
| Preemption disabled at:
| [<ffffffff814a3e2a>] paint_ptr+0x2a/0x90
| CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0+ #3
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
| Call Trace:
|  <IRQ>
|  dump_stack_lvl+0x7e/0xc0
|  dump_stack+0x1d/0x30
|  __might_resched+0x1a2/0x270
|  rt_spin_lock+0x68/0x170
|  kcsan_skip_report_debugfs+0x43/0xe0
|  print_report+0xb5/0x590
|  kcsan_report_known_origin+0x1b1/0x1d0
|  kcsan_setup_watchpoint+0x348/0x650
|  __tsan_unaligned_write1+0x16d/0x1d0
|  hrtimer_interrupt+0x3d6/0x430
|  __sysvec_apic_timer_interrupt+0xe8/0x3a0
|  sysvec_apic_timer_interrupt+0x97/0xc0
|  </IRQ>

On a detected data race, KCSAN's reporting logic checks if it should
filter the report. That list is protected by the report_filterlist_lock
*non-raw* spinlock which may sleep on RT kernels.

Since KCSAN may report data races in any context, convert it to a
raw_spinlock.

This requires being careful about when to allocate memory for the filter
list itself which can be done via KCSAN's debugfs interface. Concurrent
modification of the filter list via debugfs should be rare: the chosen
strategy is to optimistically pre-allocate memory before the critical
section and discard if unused.

Link: https://lore.kernel.org/all/20240925143154.2322926-1-ranxiaokai627@163.com/
Reported-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Tested-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kcsan/debugfs.c | 74 ++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 53b21ae30e00e..b14072071889f 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -46,14 +46,8 @@ static struct {
 	int		used;		/* number of elements used */
 	bool		sorted;		/* if elements are sorted */
 	bool		whitelist;	/* if list is a blacklist or whitelist */
-} report_filterlist = {
-	.addrs		= NULL,
-	.size		= 8,		/* small initial size */
-	.used		= 0,
-	.sorted		= false,
-	.whitelist	= false,	/* default is blacklist */
-};
-static DEFINE_SPINLOCK(report_filterlist_lock);
+} report_filterlist;
+static DEFINE_RAW_SPINLOCK(report_filterlist_lock);
 
 /*
  * The microbenchmark allows benchmarking KCSAN core runtime only. To run
@@ -110,7 +104,7 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
 		return false;
 	func_addr -= offset; /* Get function start */
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	if (report_filterlist.used == 0)
 		goto out;
 
@@ -127,7 +121,7 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
 		ret = !ret;
 
 out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 	return ret;
 }
 
@@ -135,9 +129,9 @@ static void set_report_filterlist_whitelist(bool whitelist)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	report_filterlist.whitelist = whitelist;
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 }
 
 /* Returns 0 on success, error-code otherwise. */
@@ -145,6 +139,9 @@ static ssize_t insert_report_filterlist(const char *func)
 {
 	unsigned long flags;
 	unsigned long addr = kallsyms_lookup_name(func);
+	unsigned long *delay_free = NULL;
+	unsigned long *new_addrs = NULL;
+	size_t new_size = 0;
 	ssize_t ret = 0;
 
 	if (!addr) {
@@ -152,32 +149,33 @@ static ssize_t insert_report_filterlist(const char *func)
 		return -ENOENT;
 	}
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+retry_alloc:
+	/*
+	 * Check if we need an allocation, and re-validate under the lock. Since
+	 * the report_filterlist_lock is a raw, cannot allocate under the lock.
+	 */
+	if (data_race(report_filterlist.used == report_filterlist.size)) {
+		new_size = (report_filterlist.size ?: 4) * 2;
+		delay_free = new_addrs = kmalloc_array(new_size, sizeof(unsigned long), GFP_KERNEL);
+		if (!new_addrs)
+			return -ENOMEM;
+	}
 
-	if (report_filterlist.addrs == NULL) {
-		/* initial allocation */
-		report_filterlist.addrs =
-			kmalloc_array(report_filterlist.size,
-				      sizeof(unsigned long), GFP_ATOMIC);
-		if (report_filterlist.addrs == NULL) {
-			ret = -ENOMEM;
-			goto out;
-		}
-	} else if (report_filterlist.used == report_filterlist.size) {
-		/* resize filterlist */
-		size_t new_size = report_filterlist.size * 2;
-		unsigned long *new_addrs =
-			krealloc(report_filterlist.addrs,
-				 new_size * sizeof(unsigned long), GFP_ATOMIC);
-
-		if (new_addrs == NULL) {
-			/* leave filterlist itself untouched */
-			ret = -ENOMEM;
-			goto out;
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
+	if (report_filterlist.used == report_filterlist.size) {
+		/* Check we pre-allocated enough, and retry if not. */
+		if (report_filterlist.used >= new_size) {
+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+			kfree(new_addrs); /* kfree(NULL) is safe */
+			delay_free = new_addrs = NULL;
+			goto retry_alloc;
 		}
 
+		if (report_filterlist.used)
+			memcpy(new_addrs, report_filterlist.addrs, report_filterlist.used * sizeof(unsigned long));
+		delay_free = report_filterlist.addrs; /* free the old list */
+		report_filterlist.addrs = new_addrs;  /* switch to the new list */
 		report_filterlist.size = new_size;
-		report_filterlist.addrs = new_addrs;
 	}
 
 	/* Note: deduplicating should be done in userspace. */
@@ -185,9 +183,9 @@ static ssize_t insert_report_filterlist(const char *func)
 		kallsyms_lookup_name(func);
 	report_filterlist.sorted = false;
 
-out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 
+	kfree(delay_free);
 	return ret;
 }
 
@@ -204,13 +202,13 @@ static int show_info(struct seq_file *file, void *v)
 	}
 
 	/* show filter functions, and filter type */
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	seq_printf(file, "\n%s functions: %s\n",
 		   report_filterlist.whitelist ? "whitelisted" : "blacklisted",
 		   report_filterlist.used == 0 ? "none" : "");
 	for (i = 0; i < report_filterlist.used; ++i)
 		seq_printf(file, " %ps\n", (void *)report_filterlist.addrs[i]);
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 
 	return 0;
 }
-- 
2.43.0


