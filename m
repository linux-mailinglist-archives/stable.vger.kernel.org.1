Return-Path: <stable+bounces-170916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C9B2A6E1
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEDE583E27
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773D322760;
	Mon, 18 Aug 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eo1vjmC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C852231E115;
	Mon, 18 Aug 2025 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524216; cv=none; b=Hh7vE1DI3NTWzlnjKbjxEsxb9xaVL52/KN4Cgiwko4KJUDcjOM5nXaR6o7IEZBQKY18nIi3vWglHQktUa1QH/2Fq6GYNzD7JPK7yuxczJWBUmAijnVb58Lq9tkmKbnBOz10CWFeevQfZFK+/Pyi6zQ8k4Ei7GaWHZsY3cvB9zK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524216; c=relaxed/simple;
	bh=UXjzx5O2MaSNXfCVKKtjpw21HhYUwcCf/VqE2CiHuqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvHzw0pgm63dGNMo3S2IQIHgJTyvtfnm+Q3I1T6TGAZqVj2pXd4mg6d9d6s/JE0zE6/njJLbANGo0o7kFPAk/nXochyQJ3r+9MaNAJ0t5msAdvGHpYnmHNMIPd9xOL1n+5JSd0c1dWIkEuGQbMUY/JXNz8NWDl/6GdUfjaU8qr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eo1vjmC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3806FC4CEEB;
	Mon, 18 Aug 2025 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524216;
	bh=UXjzx5O2MaSNXfCVKKtjpw21HhYUwcCf/VqE2CiHuqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eo1vjmC/rfAG9bsC0VMyuUMmO2CYnAITqXN1a8Nzdor88xWTW3Rtgih95Tp8Z/pF0
	 QL3ZZ+5Rm1fvjJ1oyxdGNOfPlWGmWagHFSFg+FZx6O0a6rGNXKEemOBAkmyxC8fV2l
	 sW6Tt4/hGYz3N9WNwg/fC0ScgbDANVLm1CfhG9No=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 404/515] printk: nbcon: Allow reacquire during panic
Date: Mon, 18 Aug 2025 14:46:30 +0200
Message-ID: <20250818124513.966304350@linuxfoundation.org>
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

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 571c1ea91a73db56bd94054fabecd0f070dc90db ]

If a console printer is interrupted during panic, it will never
be able to reacquire ownership in order to perform and cleanup.
That in itself is not a problem, since the non-panic CPU will
simply quiesce in an endless loop within nbcon_reacquire_nobuf().

However, in this state, platforms that do not support a true NMI
to interrupt the quiesced CPU will not be able to shutdown that
CPU from within panic(). This then causes problems for such as
being unable to load and run a kdump kernel.

Fix this by allowing non-panic CPUs to reacquire ownership using
a direct acquire. Then the non-panic CPUs can successfullyl exit
the nbcon_reacquire_nobuf() loop and the console driver can
perform any necessary cleanup. But more importantly, the CPU is
no longer quiesced and is free to process any interrupts
necessary for panic() to shutdown the CPU.

All other forms of acquire are still not allowed for non-panic
CPUs since it is safer to have them avoid gaining console
ownership that is not strictly necessary.

Reported-by: Michael Kelley <mhklinux@outlook.com>
Closes: https://lore.kernel.org/r/SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://patch.msgid.link/20250606185549.900611-1-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/nbcon.c | 63 ++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fd12efcc4aed..e7a3af81b173 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -214,8 +214,9 @@ static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
 
 /**
  * nbcon_context_try_acquire_direct - Try to acquire directly
- * @ctxt:	The context of the caller
- * @cur:	The current console state
+ * @ctxt:		The context of the caller
+ * @cur:		The current console state
+ * @is_reacquire:	This acquire is a reacquire
  *
  * Acquire the console when it is released. Also acquire the console when
  * the current owner has a lower priority and the console is in a safe state.
@@ -225,17 +226,17 @@ static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
  *
  * Errors:
  *
- *	-EPERM:		A panic is in progress and this is not the panic CPU.
- *			Or the current owner or waiter has the same or higher
- *			priority. No acquire method can be successful in
- *			this case.
+ *	-EPERM:		A panic is in progress and this is neither the panic
+ *			CPU nor is this a reacquire. Or the current owner or
+ *			waiter has the same or higher priority. No acquire
+ *			method can be successful in these cases.
  *
  *	-EBUSY:		The current owner has a lower priority but the console
  *			in an unsafe state. The caller should try using
  *			the handover acquire method.
  */
 static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
-					    struct nbcon_state *cur)
+					    struct nbcon_state *cur, bool is_reacquire)
 {
 	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
@@ -243,14 +244,20 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 
 	do {
 		/*
-		 * Panic does not imply that the console is owned. However, it
-		 * is critical that non-panic CPUs during panic are unable to
-		 * acquire ownership in order to satisfy the assumptions of
-		 * nbcon_waiter_matches(). In particular, the assumption that
-		 * lower priorities are ignored during panic.
+		 * Panic does not imply that the console is owned. However,
+		 * since all non-panic CPUs are stopped during panic(), it
+		 * is safer to have them avoid gaining console ownership.
+		 *
+		 * If this acquire is a reacquire (and an unsafe takeover
+		 * has not previously occurred) then it is allowed to attempt
+		 * a direct acquire in panic. This gives console drivers an
+		 * opportunity to perform any necessary cleanup if they were
+		 * interrupted by the panic CPU while printing.
 		 */
-		if (other_cpu_in_panic())
+		if (other_cpu_in_panic() &&
+		    (!is_reacquire || cur->unsafe_takeover)) {
 			return -EPERM;
+		}
 
 		if (ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio)
 			return -EPERM;
@@ -301,8 +308,9 @@ static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_prio)
 	 * Event #1 implies this context is EMERGENCY.
 	 * Event #2 implies the new context is PANIC.
 	 * Event #3 occurs when panic() has flushed the console.
-	 * Events #4 and #5 are not possible due to the other_cpu_in_panic()
-	 * check in nbcon_context_try_acquire_direct().
+	 * Event #4 occurs when a non-panic CPU reacquires.
+	 * Event #5 is not possible due to the other_cpu_in_panic() check
+	 *          in nbcon_context_try_acquire_handover().
 	 */
 
 	return (cur->req_prio == expected_prio);
@@ -431,6 +439,16 @@ static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
 	WARN_ON_ONCE(ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio);
 	WARN_ON_ONCE(!cur->unsafe);
 
+	/*
+	 * Panic does not imply that the console is owned. However, it
+	 * is critical that non-panic CPUs during panic are unable to
+	 * wait for a handover in order to satisfy the assumptions of
+	 * nbcon_waiter_matches(). In particular, the assumption that
+	 * lower priorities are ignored during panic.
+	 */
+	if (other_cpu_in_panic())
+		return -EPERM;
+
 	/* Handover is not possible on the same CPU. */
 	if (cur->cpu == cpu)
 		return -EBUSY;
@@ -558,7 +576,8 @@ static struct printk_buffers panic_nbcon_pbufs;
 
 /**
  * nbcon_context_try_acquire - Try to acquire nbcon console
- * @ctxt:	The context of the caller
+ * @ctxt:		The context of the caller
+ * @is_reacquire:	This acquire is a reacquire
  *
  * Context:	Under @ctxt->con->device_lock() or local_irq_save().
  * Return:	True if the console was acquired. False otherwise.
@@ -568,7 +587,7 @@ static struct printk_buffers panic_nbcon_pbufs;
  * in an unsafe state. Otherwise, on success the caller may assume
  * the console is not in an unsafe state.
  */
-static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
+static bool nbcon_context_try_acquire(struct nbcon_context *ctxt, bool is_reacquire)
 {
 	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
@@ -577,7 +596,7 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 
 	nbcon_state_read(con, &cur);
 try_again:
-	err = nbcon_context_try_acquire_direct(ctxt, &cur);
+	err = nbcon_context_try_acquire_direct(ctxt, &cur, is_reacquire);
 	if (err != -EBUSY)
 		goto out;
 
@@ -913,7 +932,7 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 
-	while (!nbcon_context_try_acquire(ctxt))
+	while (!nbcon_context_try_acquire(ctxt, true))
 		cpu_relax();
 
 	nbcon_write_context_set_buf(wctxt, NULL, 0);
@@ -1101,7 +1120,7 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 		cant_migrate();
 	}
 
-	if (!nbcon_context_try_acquire(ctxt))
+	if (!nbcon_context_try_acquire(ctxt, false))
 		goto out;
 
 	/*
@@ -1486,7 +1505,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	ctxt->prio			= nbcon_get_default_prio();
 	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
-	if (!nbcon_context_try_acquire(ctxt))
+	if (!nbcon_context_try_acquire(ctxt, false))
 		return -EPERM;
 
 	while (nbcon_seq_read(con) < stop_seq) {
@@ -1762,7 +1781,7 @@ bool nbcon_device_try_acquire(struct console *con)
 	ctxt->console	= con;
 	ctxt->prio	= NBCON_PRIO_NORMAL;
 
-	if (!nbcon_context_try_acquire(ctxt))
+	if (!nbcon_context_try_acquire(ctxt, false))
 		return false;
 
 	if (!nbcon_context_enter_unsafe(ctxt))
-- 
2.39.5




