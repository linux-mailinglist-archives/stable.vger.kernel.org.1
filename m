Return-Path: <stable+bounces-267681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /mG+CdEeOWqNnAcAu9opvQ
	(envelope-from <stable+bounces-267681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:38:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0D6AF28B
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 13:38:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=xnyQeoQR;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=iGVQ+jWq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267681-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267681-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73637304EA02
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BE62BEFE8;
	Mon, 22 Jun 2026 11:33:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12728F949;
	Mon, 22 Jun 2026 11:33:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127985; cv=none; b=D3/jGxPj0dn03++hQtAiOVXT54IfjhiXpavokiYdGCrnb7sdUDb+B/6+FupSaovlZW32ldf5B65SK/KSoio/6z7V4M9zcI2HXqlKjsBpam6w9JJvVW8ed7/peSbE3Y/SVeZBJDXCYobp7WliLyp1cBLwLngOe38TT5ca6fFTUn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127985; c=relaxed/simple;
	bh=kf8vfyWdeO5PPL8f72u45KRkRpLqrPEzhXHxRFXSeeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A0mDuNWmX5JgnBV9vXNNulIoxsd+VjMuCsMxNoWuzZ4UCt3x3IsY4+8Yy9FiVkxOFv4daf7VM8CcqQNmgnb5s+dd1nrtRzjJ/gfRCDF17CK9joZx7MB9vdAgv8KRSuOOs2zYA19I5WQ333hq/ZoAw1SmyuD8ynbcaJFrdM2KO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xnyQeoQR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iGVQ+jWq; arc=none smtp.client-ip=193.142.43.55
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782127982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y2+lA1bnMd2Lh85AAiAhj4GuJ60oJplGFxvTMy/uKps=;
	b=xnyQeoQRLp/re2VnewJZjik6EXVwMV032A5Xilrc7Lq34IsMg99UNLRY6lSYJW3Nr8vSEc
	ZUJ2SzQZ7JYUha0a8eYBSG5uhMx53SKn8/UGuUN/X76+SDxiShxzKglS65oVkQvW4X+qKO
	DnLb0DVNqLwBIdW7LeSe9WkOtEHRNGREUbCF6XiPlbNtUljAmuUZTLIog/Kze07/ifpRZn
	MZ52/IBT7A+ejf+oCHHVRnkuYSY9xjzZuuGXXFyRoTBbLWZiqFzM12VMmkjDcg2B5Hyy69
	OCd0b7faTcwhBYUW6lNlpyIQ+u4lpFKm7N57gCVV9B2oc6XRYbD+j7f5uL+nAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782127982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y2+lA1bnMd2Lh85AAiAhj4GuJ60oJplGFxvTMy/uKps=;
	b=iGVQ+jWqJbghN6nKav2b7KCiX/MklCy0FxIaf3CO2danyMO/lif5Q+c2MlIehSnjXB3UJT
	XLhLj2rIuZCqJsBw==
To: Vivian Wang <wangruikang@iscas.ac.cn>, Peter Zijlstra
 <peterz@infradead.org>, Guo Ren <guoren@kernel.org>
Cc: Kees Cook <kees@kernel.org>, arnd@arndb.de, palmer@rivosinc.com,
 luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
 jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
 chenhuacai@kernel.org, apatel@ventanamicro.com, atishp@atishpatra.org,
 mark.rutland@arm.com, bjorn@kernel.org, palmer@dabbelt.com,
 bjorn@rivosinc.com, daniel.thompson@linaro.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, stable@vger.kernel.org, Guo Ren
 <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
In-Reply-To: <2f32370b-63c1-4e8a-bf71-d40874b6bebb@iscas.ac.cn>
References: <20230702025708.784106-1-guoren@kernel.org>
 <202606191652.38297DE51@keescook> <ajeKPpg2rwadVPY4@gmail.com>
 <20260622082841.GW49951@noisy.programming.kicks-ass.net>
 <2f32370b-63c1-4e8a-bf71-d40874b6bebb@iscas.ac.cn>
Date: Mon, 22 Jun 2026 13:33:01 +0200
Message-ID: <87pl1ilsia.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267681-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[tglx@linutronix.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:wangruikang@iscas.ac.cn,m:peterz@infradead.org,m:guoren@kernel.org,m:kees@kernel.org,m:arnd@arndb.de,m:palmer@rivosinc.com,m:luto@kernel.org,m:conor.dooley@microchip.com,m:heiko@sntech.de,m:jszhang@kernel.org,m:lazyparser@gmail.com,m:falcon@tinylab.org,m:chenhuacai@kernel.org,m:apatel@ventanamicro.com,m:atishp@atishpatra.org,m:mark.rutland@arm.com,m:bjorn@kernel.org,m:palmer@dabbelt.com,m:bjorn@rivosinc.com,m:daniel.thompson@linaro.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:stable@vger.kernel.org,m:guoren@linux.alibaba.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,rivosinc.com,microchip.com,sntech.de,gmail.com,tinylab.org,ventanamicro.com,atishpatra.org,arm.com,dabbelt.com,linaro.org,vger.kernel.org,lists.infradead.org,linux.alibaba.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74B0D6AF28B

On Mon, Jun 22 2026 at 18:25, Vivian Wang wrote:
> On 6/22/26 16:28, Peter Zijlstra wrote:
>> I still don't understand it. This cannot fix anything. Consider:
>>
>>  EBREAK
>>  raw_spin_lock_irq(&your_lock)
>>  EBREAK
>>
>> So now the first 'works', but the second will crash. Additionally,
>> having the EBREAK context differ so dramatically between invocations
>> seems like a very bad deal to me.
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
>
> How do you think this should be fixed? Here are some ideas but I'm not
> familiar with generic entry stuff:
>
>   * Should we irqentry_nmi_exit() before calling die() for BUG()?
>   * Should we move the GENERIC_BUG trap instruction to cause illegal
>     instruction exception instead, for which we can write a simpler
>     handler that doesn't need to care about the probe stuff?

Look at how x86 handles UD exceptions.

