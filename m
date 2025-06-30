Return-Path: <stable+bounces-158888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E6AED85F
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0734217694A
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3A24502F;
	Mon, 30 Jun 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cSvjDWfW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE56FC1D
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275036; cv=none; b=VawM2Zu860jYdwG49pXGhjiiAA0jXuGfl3aI6diyTg8O2/qL4Xin+Zc7JG3A5IXhuDZMMmNoo+Gnj75ZbiY7vhhWdBXlFMD5O357xKtLPgf6T7pw5oCXAVOjf/Lwq3htv2TRHoS8gmzfbHEgXzS/UX1iUnG6KrG01FjkqJZqoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275036; c=relaxed/simple;
	bh=nCLve8skjQLQYCP5Ljisv95WJS1zOiK5jb75umk1KoM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=le3rL92wISE1NBDhIQo23pXZr+5VmTrJg9HM0pQ7xQ3gMS6EXvBlUdh0A1G6qxbUZ7EiUyqBYVmJxsLuNKL+4c2GpQNsSJbYg8cJk6QxxOkAIx+ycg3sbaGmxLoQ5nLmZUqTvSR2PqPFVvtFUWcruBRsE6+NOtnYOCaSj5mQtqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cSvjDWfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D605CC4CEEB;
	Mon, 30 Jun 2025 09:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275035;
	bh=nCLve8skjQLQYCP5Ljisv95WJS1zOiK5jb75umk1KoM=;
	h=Subject:To:Cc:From:Date:From;
	b=cSvjDWfWBwp36rGUg1BjoVAR4z2utzO2s1vHA8lXxxpdhyUm1MTuA3l8DgVwKQyCE
	 DPz30jOcgGByUL0qyZ1UP3tWypYWJ+7eCSXi90VFBRAYdbf7uLS0yiQf/gq82wbqqh
	 rJ09fnEDS3STHuZV00L7/gE0a9f/7yTFxqhA/HU4=
Subject: FAILED: patch "[PATCH] x86/traps: Initialize DR6 by writing its architectural reset" failed to apply to 6.1-stable tree
To: xin@zytor.com,dave.hansen@linux.intel.com,hpa@zytor.com,peterz@infradead.org,sohil.mehta@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:17:12 +0200
Message-ID: <2025063012-clammy-bluish-930d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5f465c148c61e876b6d6eacd8e8e365f2d47758f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063012-clammy-bluish-930d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f465c148c61e876b6d6eacd8e8e365f2d47758f Mon Sep 17 00:00:00 2001
From: "Xin Li (Intel)" <xin@zytor.com>
Date: Fri, 20 Jun 2025 16:15:03 -0700
Subject: [PATCH] x86/traps: Initialize DR6 by writing its architectural reset
 value

Initialize DR6 by writing its architectural reset value to avoid
incorrectly zeroing DR6 to clear DR6.BLD at boot time, which leads
to a false bus lock detected warning.

The Intel SDM says:

  1) Certain debug exceptions may clear bits 0-3 of DR6.

  2) BLD induced #DB clears DR6.BLD and any other debug exception
     doesn't modify DR6.BLD.

  3) RTM induced #DB clears DR6.RTM and any other debug exception
     sets DR6.RTM.

  To avoid confusion in identifying debug exceptions, debug handlers
  should set DR6.BLD and DR6.RTM, and clear other DR6 bits before
  returning.

The DR6 architectural reset value 0xFFFF0FF0, already defined as
macro DR6_RESERVED, satisfies these requirements, so just use it to
reinitialize DR6 whenever needed.

Since clear_all_debug_regs() no longer zeros all debug registers,
rename it to initialize_debug_regs() to better reflect its current
behavior.

Since debug_read_clear_dr6() no longer clears DR6, rename it to
debug_read_reset_dr6() to better reflect its current behavior.

Fixes: ebb1064e7c2e9 ("x86/traps: Handle #DB for bus lock")
Reported-by: Sohil Mehta <sohil.mehta@intel.com>
Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/lkml/06e68373-a92b-472e-8fd9-ba548119770c@intel.com/
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250620231504.2676902-2-xin%40zytor.com

diff --git a/arch/x86/include/uapi/asm/debugreg.h b/arch/x86/include/uapi/asm/debugreg.h
index 0007ba077c0c..41da492dfb01 100644
--- a/arch/x86/include/uapi/asm/debugreg.h
+++ b/arch/x86/include/uapi/asm/debugreg.h
@@ -15,7 +15,26 @@
    which debugging register was responsible for the trap.  The other bits
    are either reserved or not of interest to us. */
 
-/* Define reserved bits in DR6 which are always set to 1 */
+/*
+ * Define bits in DR6 which are set to 1 by default.
+ *
+ * This is also the DR6 architectural value following Power-up, Reset or INIT.
+ *
+ * Note, with the introduction of Bus Lock Detection (BLD) and Restricted
+ * Transactional Memory (RTM), the DR6 register has been modified:
+ *
+ * 1) BLD flag (bit 11) is no longer reserved to 1 if the CPU supports
+ *    Bus Lock Detection.  The assertion of a bus lock could clear it.
+ *
+ * 2) RTM flag (bit 16) is no longer reserved to 1 if the CPU supports
+ *    restricted transactional memory.  #DB occurred inside an RTM region
+ *    could clear it.
+ *
+ * Apparently, DR6.BLD and DR6.RTM are active low bits.
+ *
+ * As a result, DR6_RESERVED is an incorrect name now, but it is kept for
+ * compatibility.
+ */
 #define DR6_RESERVED	(0xFFFF0FF0)
 
 #define DR_TRAP0	(0x1)		/* db0 */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8feb8fd2957a..0f6c280a94f0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2243,20 +2243,16 @@ EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif
 #endif
 
-/*
- * Clear all 6 debug registers:
- */
-static void clear_all_debug_regs(void)
+static void initialize_debug_regs(void)
 {
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		/* Ignore db4, db5 */
-		if ((i == 4) || (i == 5))
-			continue;
-
-		set_debugreg(0, i);
-	}
+	/* Control register first -- to make sure everything is disabled. */
+	set_debugreg(0, 7);
+	set_debugreg(DR6_RESERVED, 6);
+	/* dr5 and dr4 don't exist */
+	set_debugreg(0, 3);
+	set_debugreg(0, 2);
+	set_debugreg(0, 1);
+	set_debugreg(0, 0);
 }
 
 #ifdef CONFIG_KGDB
@@ -2417,7 +2413,7 @@ void cpu_init(void)
 
 	load_mm_ldt(&init_mm);
 
-	clear_all_debug_regs();
+	initialize_debug_regs();
 	dbg_restore_debug_regs();
 
 	doublefault_init_cpu_tss();
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c5c897a86418..36354b470590 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1022,24 +1022,32 @@ static bool is_sysenter_singlestep(struct pt_regs *regs)
 #endif
 }
 
-static __always_inline unsigned long debug_read_clear_dr6(void)
+static __always_inline unsigned long debug_read_reset_dr6(void)
 {
 	unsigned long dr6;
 
+	get_debugreg(dr6, 6);
+	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
+
 	/*
 	 * The Intel SDM says:
 	 *
-	 *   Certain debug exceptions may clear bits 0-3. The remaining
-	 *   contents of the DR6 register are never cleared by the
-	 *   processor. To avoid confusion in identifying debug
-	 *   exceptions, debug handlers should clear the register before
-	 *   returning to the interrupted task.
+	 *   Certain debug exceptions may clear bits 0-3 of DR6.
 	 *
-	 * Keep it simple: clear DR6 immediately.
+	 *   BLD induced #DB clears DR6.BLD and any other debug
+	 *   exception doesn't modify DR6.BLD.
+	 *
+	 *   RTM induced #DB clears DR6.RTM and any other debug
+	 *   exception sets DR6.RTM.
+	 *
+	 *   To avoid confusion in identifying debug exceptions,
+	 *   debug handlers should set DR6.BLD and DR6.RTM, and
+	 *   clear other DR6 bits before returning.
+	 *
+	 * Keep it simple: write DR6 with its architectural reset
+	 * value 0xFFFF0FF0, defined as DR6_RESERVED, immediately.
 	 */
-	get_debugreg(dr6, 6);
 	set_debugreg(DR6_RESERVED, 6);
-	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
 
 	return dr6;
 }
@@ -1239,13 +1247,13 @@ static noinstr void exc_debug_user(struct pt_regs *regs, unsigned long dr6)
 /* IST stack entry */
 DEFINE_IDTENTRY_DEBUG(exc_debug)
 {
-	exc_debug_kernel(regs, debug_read_clear_dr6());
+	exc_debug_kernel(regs, debug_read_reset_dr6());
 }
 
 /* User entry, runs on regular task stack */
 DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
-	exc_debug_user(regs, debug_read_clear_dr6());
+	exc_debug_user(regs, debug_read_reset_dr6());
 }
 
 #ifdef CONFIG_X86_FRED
@@ -1264,7 +1272,7 @@ DEFINE_FREDENTRY_DEBUG(exc_debug)
 {
 	/*
 	 * FRED #DB stores DR6 on the stack in the format which
-	 * debug_read_clear_dr6() returns for the IDT entry points.
+	 * debug_read_reset_dr6() returns for the IDT entry points.
 	 */
 	unsigned long dr6 = fred_event_data(regs);
 
@@ -1279,7 +1287,7 @@ DEFINE_FREDENTRY_DEBUG(exc_debug)
 /* 32 bit does not have separate entry points. */
 DEFINE_IDTENTRY_RAW(exc_debug)
 {
-	unsigned long dr6 = debug_read_clear_dr6();
+	unsigned long dr6 = debug_read_reset_dr6();
 
 	if (user_mode(regs))
 		exc_debug_user(regs, dr6);


