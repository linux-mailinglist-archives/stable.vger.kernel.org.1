Return-Path: <stable+bounces-267623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gHGQCYbyOGrEkQcAu9opvQ
	(envelope-from <stable+bounces-267623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:29:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E26ADB6B
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 10:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=desiato.20200630 header.b=JfJBOhMn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267623-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267623-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C70230098AC
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351F38F63D;
	Mon, 22 Jun 2026 08:29:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240F03914FE;
	Mon, 22 Jun 2026 08:29:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116952; cv=none; b=nDKIiMfIWmMn/C0uXfBXdeplnsmQpAz+PXQ8UbQS6mIhBXa08isnI2joWJKPzizhdX07NWcJXS5RfgD8OGpt4EUAoedJo8I4A8GAQk5YpIXxq8TCSkVDlbrafPOy+pcRZSW5IHEVyOnZSH9PY/nDze8VAUzhIM2+P1NkDB7W7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116952; c=relaxed/simple;
	bh=oshX+1OGH/tG2YcTkp8LoN02KXSBFvXanHE3Hn7KKrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bypN7WDJXLl53qI2YkJ/jx6SpfK90pdSdz1UraegPJiXKvhEcx1/t98BTUGIp1MqNiKRMD4kWznS5+r2ZpRFvpqEstxBWSpegP4oDi8bMBk1bLy6g2W6EEg5wLRZGvpxzVaujTs8bajO3wuwPbPhhIdFa6pcUtC+ihgmbV4hMTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JfJBOhMn; arc=none smtp.client-ip=90.155.92.199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bbTyrnhqvWIcaXGI5ya6CH216d2F3ewFkzDXa3yFmPg=; b=JfJBOhMnP5yLYxb1TUJmIV3k3W
	bvDEHpVJOLzGrwPYiEZMexVe1cwXhJ7WA7O/wQMfJbczJU3pKj7Pt2HntYo2K0viOYJuuIaPE6zoP
	gnj6Py8/FSiFean+s4tC2MRe1sLbxfL2ML0WaSa5oFpmjTxN00XvDVyUaHRWkEaG/V8REbqwL2a0W
	getComPHsxZWERYn3U+N/OeI8ZjUI/WtzVLI/b0ssXSU9CDznuiazbAmYET+RljytwgDllD887NDg
	Xxt9F1YlHFJ2Wm8dEMN8u8BAjDYdDs36LB8N8IOQbOYpiZ0xGuW7/n9Xo9Fi7d9UMbrb28GCgwFdx
	LMjYg2eg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wba1L-0000000HCHO-3ygg;
	Mon, 22 Jun 2026 08:28:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D0349300B5F; Mon, 22 Jun 2026 10:28:41 +0200 (CEST)
Date: Mon, 22 Jun 2026 10:28:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guo Ren <guoren@kernel.org>
Cc: Kees Cook <kees@kernel.org>, arnd@arndb.de, palmer@rivosinc.com,
	tglx@linutronix.de, luto@kernel.org, conor.dooley@microchip.com,
	heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
	falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
	atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
	palmer@dabbelt.com, bjorn@rivosinc.com, daniel.thompson@linaro.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, stable@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
Message-ID: <20260622082841.GW49951@noisy.programming.kicks-ass.net>
References: <20230702025708.784106-1-guoren@kernel.org>
 <202606191652.38297DE51@keescook>
 <ajeKPpg2rwadVPY4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajeKPpg2rwadVPY4@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267623-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,rivosinc.com,linutronix.de,microchip.com,sntech.de,gmail.com,tinylab.org,ventanamicro.com,atishpatra.org,arm.com,dabbelt.com,linaro.org,vger.kernel.org,lists.infradead.org,linux.alibaba.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:guoren@kernel.org,m:kees@kernel.org,m:arnd@arndb.de,m:palmer@rivosinc.com,m:tglx@linutronix.de,m:luto@kernel.org,m:conor.dooley@microchip.com,m:heiko@sntech.de,m:jszhang@kernel.org,m:lazyparser@gmail.com,m:falcon@tinylab.org,m:chenhuacai@kernel.org,m:apatel@ventanamicro.com,m:atishp@atishpatra.org,m:mark.rutland@arm.com,m:bjorn@kernel.org,m:palmer@dabbelt.com,m:bjorn@rivosinc.com,m:daniel.thompson@linaro.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:stable@vger.kernel.org,m:guoren@linux.alibaba.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,alibaba.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:dkim,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B52E26ADB6B

On Sun, Jun 21, 2026 at 02:52:46AM -0400, Guo Ren wrote:
> On Fri, Jun 19, 2026 at 04:54:53PM -0700, Kees Cook wrote:
> > *thread encromancy*
> > 
> > On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > > 
> > > The irqentry_nmi_enter/exit would force the current context into in_interrupt.
> > > That would trigger the kernel to dead panic, but the kdb still needs "ebreak" to
> > > debug the kernel.
> > > 
> > > Move irqentry_nmi_enter/exit to exception_enter/exit could correct handle_break
> > > of the kernel side.
> > > 
> > > Before the fixup:
> > > $echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
> > >   lkdtm: Performing direct entry BUG
> > >   ------------[ cut here ]------------
> > >   kernel BUG at drivers/misc/lkdtm/bugs.c:78!
> > > [...]
> > >   Kernel panic - not syncing: Aiee, killing interrupt handler!
> > 
> > This appears to still be unfixed. What's the blocker? The solutions in
> > this thread seem to work...
> > 
> > I'd like to be exercising an Oops path via KUnit (for KCFI), and riscv
> > just instantly falls over instead of thread-killing on the exception.
> Thanks for reviving this thread. At the time I didn’t fully understand
> Peter’s point. We should only use the NMI path when the trap occurs with
> interrupts disabled.
> Here’s the updated fix:
> 
>  do_trap_break(struct pt_regs *regs)
> ... 
>  		irqentry_exit_to_user_mode(regs);
>  	} else {
> -		irqentry_state_t state = irqentry_nmi_enter(regs);
> +		if (regs->status & SR_IE) {
> +			enum ctx_state prev_state = exception_enter();
>  
> -		handle_break(regs);
> +			handle_break(regs);
>  
> -		irqentry_nmi_exit(regs, state);
> +			exception_exit(prev_state);
> +		} else {
> +			irqentry_state_t state = irqentry_nmi_enter(regs);
> +
> +			handle_break(regs);
> +
> +			irqentry_nmi_exit(regs, state);
> +		}
>  	}
>  }
> 
> If you & Peter have no objection, I’ll post a v2.

I still don't understand it. This cannot fix anything. Consider:

 EBREAK
 raw_spin_lock_irq(&your_lock)
 EBREAK

So now the first 'works', but the second will crash. Additionally,
having the EBREAK context differ so dramatically between invocations
seems like a very bad deal to me.


