Return-Path: <stable+bounces-267674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +EuaKgEaOWqFmwcAu9opvQ
	(envelope-from <stable+bounces-267674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:18:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFEB6AEFF5
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:18:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=desiato.20200630 header.b=izFgCDrX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267674-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267674-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C820300B518
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F53395AD3;
	Mon, 22 Jun 2026 11:18:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715A37A48D;
	Mon, 22 Jun 2026 11:18:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127099; cv=none; b=Bvr40a8N0hy2rqgKeG8uXliDaNHA8xtDe6oX1QbTScWlMkRRC8RbJS/f+FIahmq3rceuCPOjv8o9M40OsOeOJNoce/uqTI2l2IKVdckwp4AT/LqfXvFFA+jBtG5Yvk/GwjBHK8vWD7HK2B/Ckk50k9il0KLd0L/nNKwgUdXbyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127099; c=relaxed/simple;
	bh=kdDo6ypa4cOIwBmMmbS8Rzq4f/dFdL6x+3y7be+fJwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYfjifZXbipszjRZIDp93O/yjScnTBKpnzZmIHIHaAbV/+vc68E65BWMSXHdEzJ3fb+snh1UjGqUGBphZu1kNAZr20TlwbQ0K39yiV+Xo94wrp9Q7pzuUb9kvu4a08fdxotJ9/14CMhuQDqD5ju3Z/TvQ0oPRWRhWkAdu+GIILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=izFgCDrX; arc=none smtp.client-ip=90.155.92.199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZcreGeJT4Kj/CaPNDSlKZDUKKKxkr0txGhSxJTbFmLI=; b=izFgCDrXKVK8GXO6DlHUFoL2vI
	s88x4+C8IX21G+0x7NcPB5HFHwA+XDBNGwGuhmdcFJX4XqA8n9DYODh7tGfBAjbxElFFg72fme9Rv
	jKRBExkUG+Sq4skXhuGGMsDyXT+ZOKtU3ya/3uZ8fnEpPFWDKWUHW8AyQ07mPZsDAPpgpj92riBvk
	4LNDRM2T6KAVH53dJECXozeiITts7uIwsaSMvKenLwh9LcMwrsO1PCPjhzGP5NasPyukm/RUF+j5y
	GUtO/ozfTq8sFRJz+Vcrx9MZ7j7UblLnyg1a6Fua3TRtFPWiC9xpcew7xLJgh5KzK887kX8z+TvS+
	YzmfMhxw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbcf8-0000000HNgu-49Ue;
	Mon, 22 Jun 2026 11:17:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F49B300B5F; Mon, 22 Jun 2026 13:17:57 +0200 (CEST)
Date: Mon, 22 Jun 2026 13:17:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Guo Ren <guoren@kernel.org>, Kees Cook <kees@kernel.org>, arnd@arndb.de,
	palmer@rivosinc.com, tglx@linutronix.de, luto@kernel.org,
	conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
	lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
	apatel@ventanamicro.com, atishp@atishpatra.org,
	mark.rutland@arm.com, bjorn@kernel.org, palmer@dabbelt.com,
	bjorn@rivosinc.com, daniel.thompson@linaro.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, stable@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
Message-ID: <20260622111757.GR48970@noisy.programming.kicks-ass.net>
References: <20230702025708.784106-1-guoren@kernel.org>
 <202606191652.38297DE51@keescook>
 <ajeKPpg2rwadVPY4@gmail.com>
 <20260622082841.GW49951@noisy.programming.kicks-ass.net>
 <2f32370b-63c1-4e8a-bf71-d40874b6bebb@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f32370b-63c1-4e8a-bf71-d40874b6bebb@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267674-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,rivosinc.com,linutronix.de,microchip.com,sntech.de,gmail.com,tinylab.org,ventanamicro.com,atishpatra.org,arm.com,dabbelt.com,linaro.org,vger.kernel.org,lists.infradead.org,linux.alibaba.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:wangruikang@iscas.ac.cn,m:guoren@kernel.org,m:kees@kernel.org,m:arnd@arndb.de,m:palmer@rivosinc.com,m:tglx@linutronix.de,m:luto@kernel.org,m:conor.dooley@microchip.com,m:heiko@sntech.de,m:jszhang@kernel.org,m:lazyparser@gmail.com,m:falcon@tinylab.org,m:chenhuacai@kernel.org,m:apatel@ventanamicro.com,m:atishp@atishpatra.org,m:mark.rutland@arm.com,m:bjorn@kernel.org,m:palmer@dabbelt.com,m:bjorn@rivosinc.com,m:daniel.thompson@linaro.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:stable@vger.kernel.org,m:guoren@linux.alibaba.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFFEB6AEFF5

On Mon, Jun 22, 2026 at 06:25:13PM +0800, Vivian Wang wrote:

> > I still don't understand it. This cannot fix anything. Consider:
> >
> >  EBREAK
> >  raw_spin_lock_irq(&your_lock)
> >  EBREAK
> >
> > So now the first 'works', but the second will crash. Additionally,
> > having the EBREAK context differ so dramatically between invocations
> > seems like a very bad deal to me.
> 
> To spell it out, the problem that needs fixing is:
> 
> -> BUG()
>    -> ebreak instruction
>       -> Breakpoint exception
>          -> do_trap_break()
>             -> irqentry_nmi_enter()
>             [ now in_nmi() / in_interrupt() ]
>             -> report_bug() returns BUG_TRAP_TYPE_BUG
>             -> die()
>                -> make_task_dead()
>                   -> panic() because we're in_interrupt()
> 
> As such, currently on riscv all BUG() simply completely panic() the
> entire machine, rather than just killing the one task.

Hmm, from reading some of the previous emails this morning, I got the
impression the problem was with kgdb, not BUG().

Anyway, my argument doesn't change, with the proposed patch:

  BUG()

and:

  local_irq_disable();
  BUG();

will behave quite differently, for no sane reason.

Anyway, BUG()/trap is indeed a bit of magic, the x86 code lives in
arch/x86/kernel/traps.c:exc_invalid_op(). And it looks like we do not
indeed use NMI-like for this path, although I cannot remember why.

*however* I see your kgdb thing also uses ebreak, whereas on x86
WARN/BUG and kGDB use different exceptions (#UD for WARN/BUG and #BP for
gdb). And our #BP handler (exc_int3) very much does NMI for from-kernel.

Same for kprobes, we use #BP/int3 for that, you also have that in
EBREAK.

Anyway, you're handling 3 different cases in one exception, which is a
bit of a mess, but something like so perhaps?

---
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8c62c771a656..41c7faac7eb3 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -264,42 +264,58 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 	return GET_INSN_LENGTH(insn);
 }
 
-static bool probe_single_step_handler(struct pt_regs *regs)
+static void handle_kernel_die(struct pt_regs *regs)
 {
-	bool user = user_mode(regs);
-
-	return user ? uprobe_single_step_handler(regs) : kprobe_single_step_handler(regs);
+	irqentry_state_t state = irqentry_enter(regs);
+	die(regs, "Kernel BUG");
+	irqentry_exit(regs, state);
 }
 
-static bool probe_breakpoint_handler(struct pt_regs *regs)
+static bool handle_kernel_bug(struct pt_regs *regs)
 {
-	bool user = user_mode(regs);
+	if (report_bug(regs->epc, regs) == BUG_TRAP_TYPE_WARN ||
+	    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
+		regs->epc += get_break_insn_length(regs->epc);
+		return true;
+	}
 
-	return user ? uprobe_breakpoint_handler(regs) : kprobe_breakpoint_handler(regs);
+	return false;
 }
 
-void handle_break(struct pt_regs *regs)
+static bool  __handle_kernel_break(struct pt_regs *regs)
 {
-	if (probe_single_step_handler(regs))
-		return;
 
-	if (probe_breakpoint_handler(regs))
+	if (kprobe_single_step_handler(regs) ||
+	    kprobe_breakpoint_handler(regs))
+		return true;
+
+	current->thread.bad_cause = regs->cause;
+
+#ifdef CONFIG_KGDB
+	if (notify_die(DIE_TRAP, "EBREAK", regs, 0, regs->cause, SIGTRAP)
+								== NOTIFY_STOP)
+		return true;
+#endif
+	return false;
+}
+
+static bool handle_kernel_break(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_nmi_enter(regs);
+	bool ret = __handle_kernel_break(regs);
+	irqentry_nmi_exit(regs, state);
+	return ret;
+}
+
+static void handle_user_break(struct pt_regs *regs)
+{
+	if (uprobe_single_step_handler(regs) ||
+	    uprobe_breakpoint_handler(regs))
 		return;
 
 	current->thread.bad_cause = regs->cause;
 
-	if (user_mode(regs))
-		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->epc);
-#ifdef CONFIG_KGDB
-	else if (notify_die(DIE_TRAP, "EBREAK", regs, 0, regs->cause, SIGTRAP)
-								== NOTIFY_STOP)
-		return;
-#endif
-	else if (report_bug(regs->epc, regs) == BUG_TRAP_TYPE_WARN ||
-		 handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN)
-		regs->epc += get_break_insn_length(regs->epc);
-	else
-		die(regs, "Kernel BUG");
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->epc);
 }
 
 asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
@@ -308,16 +324,18 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 		irqentry_enter_from_user_mode(regs);
 		local_irq_enable();
 
-		handle_break(regs);
+		handle_user_break(regs);
 
 		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
+		if (handle_kernel_bug(regs))
+			return;
 
-		handle_break(regs);
+		if (handle_kernel_break(regs))
+			return;
 
-		irqentry_nmi_exit(regs, state);
+		handle_kernel_die(regs);
 	}
 }
 


