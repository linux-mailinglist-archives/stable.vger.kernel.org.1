Return-Path: <stable+bounces-158459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91302AE70F1
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 22:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F42188C8D4
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7DF3074B5;
	Tue, 24 Jun 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="deGzkPUs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7dtBQX7W"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259942E3B14;
	Tue, 24 Jun 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750797329; cv=none; b=j0b6nUBX6ZvP9AOuiXfgl9dGtup2d6qrPID5IRQr8FFxHMl9iH+D3NoGeuFbsboHSWBQG4ZNn3+rqGfEEwqHT1O2I1u/jP3KmpIhIQEr8io7/myHRo9/v4Fg4RNSXaC/UBXIegjCgzTQHXINxMDX9SehQxLFe73jO/HLyWvw8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750797329; c=relaxed/simple;
	bh=Ofgl3d5hcJQ0dxQmGdR6z5tCLAC52R5GbmVZodTUN9s=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Uz6m5ZfirGLln+F0YQOysAWBhYhptP4KCY/+7NvpLU50KsPsn2KSWOIeIUt5gX8Ou8ka7c85kOhlXG1zNayDzn+fx+2raCZxWXQKSrM4bLE64OK907BXQtocs7JcUF0fu3FHhl5FBFhGxF3j9gpEebjC0MjrVvgkOS3q583wTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=deGzkPUs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7dtBQX7W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 20:35:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750797324;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FbBceXaicaVAgXcuJaywU6HUlfbn9dUW66xXJA4yZRg=;
	b=deGzkPUstBI8V8aGTEj0Dcz7+ybjrEq3VShk5FU2sxJ2p/G4Uu0K+mP4DosGKAPKILm9oc
	sURTmz4OSNs2sD9DeKbh8lUGdQku6tu0RErVeeCKlghogg/chsL55kZDN9CyTTZ9oVDss+
	mwIlLFJJuk4V5rVz08LXWXVqOG9vZOoYidRp6TNWf8myP7jFAXZegYK2zDsgKotz3+JPm9
	JcPuNYmWFtvW5v7yKRVJXhx6Jk0P5XVlNKoTtgBRYGrVexoNFzXubc+EKJBsag0qwtQEyW
	1+wkW7HCcHmIZ+lUNU0UGy26cQMN7KgGUCFKHwvHEc8ls5la0L9r7lwOCK870g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750797324;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FbBceXaicaVAgXcuJaywU6HUlfbn9dUW66xXJA4yZRg=;
	b=7dtBQX7WeKyFQ02oWR71cl8TKbNzUwNJL9jR6FM8Hn/7Omznj4pMvd9joja3URBPoYhGqE
	bAaJBlN1bF5ncyDw==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/traps: Initialize DR6 by writing its
 architectural reset value
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175079732323.406.383086015651563298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5f465c148c61e876b6d6eacd8e8e365f2d47758f
Gitweb:        https://git.kernel.org/tip/5f465c148c61e876b6d6eacd8e8e365f2d47758f
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Fri, 20 Jun 2025 16:15:03 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 24 Jun 2025 13:15:51 -07:00

x86/traps: Initialize DR6 by writing its architectural reset value

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
---
 arch/x86/include/uapi/asm/debugreg.h | 21 ++++++++++++++++-
 arch/x86/kernel/cpu/common.c         | 24 +++++++------------
 arch/x86/kernel/traps.c              | 34 ++++++++++++++++-----------
 3 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/uapi/asm/debugreg.h b/arch/x86/include/uapi/asm/debugreg.h
index 0007ba0..41da492 100644
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
index 8feb8fd..0f6c280 100644
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
index c5c897a..36354b4 100644
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
+	 *
+	 *   BLD induced #DB clears DR6.BLD and any other debug
+	 *   exception doesn't modify DR6.BLD.
 	 *
-	 * Keep it simple: clear DR6 immediately.
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
@@ -1239,13 +1247,13 @@ out:
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

