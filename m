Return-Path: <stable+bounces-94103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CFA9D35E4
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 09:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450C31F21AC9
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B395172BA9;
	Wed, 20 Nov 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IBZejzyX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3SFs9zG/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CB161321;
	Wed, 20 Nov 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092650; cv=none; b=PwkFDA47N9Z8A5LPjrsV5HX6s8LAq2HrIgIDCTDoy8rcXmMhuk5wvpT4pw/Lzd//9sMXBEsGns/ZqR8/lk+plq24qoirw6dbjfRrJt8oed+7kjPoaF/4wk5Mh/AYsz2DoRKm1OK1Q8hF+y7wNzAYFgu1zO+HuoXZ/427B/qEQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092650; c=relaxed/simple;
	bh=sMxXyfdZ6KRSllXJEGIi58evPGGJtnrUvgDQLm70gO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/K+DPGqgSX3UB7yAix25igFmsGLdMkwPS0ycsA25Hns7zZi3jFeMLd/QXOzsodx8eOEoAmEScNn1xo50VC/VG1wn+j2J/XMXd/4fWFOk6r5iVogz8ZfBlHc/D2A5MZOs/PwNJiv9fA2dN7IokGl51Bb/gtIMY1GRH34IzT2no4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IBZejzyX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3SFs9zG/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Nov 2024 09:50:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732092647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oe9wHru8jR91xqwNVUEM0jNj172x93463fWxP69UVU=;
	b=IBZejzyXTEybKdyqYcth8IMRNhFugumdnp9FOv6mFRVSH1+XfGomM0HOBlsB8/VZ5FanSq
	KBakqRuuJwjqMLFjzVuqFDJom//QDTQIgvzFlCP81srSGVhIwzv+qX8EQTAh6aKnzNNbfm
	NMKQkYvP3ZQaBPr/xoSXu+r3tK4FG7fEYBllTp1H94LxDZEb7J/hGu9mPh+HhL2HqczE0/
	loi3mC4WEfy5p9Wn5nl3qieXyLNYpltAAFR6THGHUtBeezXvc6/m3TYBjSV4kWT69lzDap
	Kz1tcALMSNTFFMrmIgz1Z4P2WjMmJHf3pdj1fgi0Ex1/o4+inQw44iHDr9w3WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732092647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Oe9wHru8jR91xqwNVUEM0jNj172x93463fWxP69UVU=;
	b=3SFs9zG/TnFK0RNywoKEqmPzmDkdUJiG2BU+LsI5+xY0wE3dHr2tHuesls1xJuOHaAzI8E
	Su+TrfWHvfvQ+YBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Andreas Schwab <schwab@suse.de>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Celeste Liu <coelacanthushex@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix sleeping in invalid context in die()
Message-ID: <20241120085045.LJ5b7oh9@linutronix.de>
References: <20241118091333.1185288-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118091333.1185288-1-namcao@linutronix.de>

On 2024-11-18 10:13:33 [+0100], Nam Cao wrote:
> die() can be called in exception handler, and therefore cannot sleep.
> However, die() takes spinlock_t which can sleep with PREEMPT_RT enabled.
> That causes the following warning:
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 285, name: mutex
> preempt_count: 110001, expected: 0
> RCU nest depth: 0, expected: 0
> CPU: 0 UID: 0 PID: 285 Comm: mutex Not tainted 6.12.0-rc7-00022-ge19049cf7d56-dirty #234
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
>     dump_backtrace+0x1c/0x24
>     show_stack+0x2c/0x38
>     dump_stack_lvl+0x5a/0x72
>     dump_stack+0x14/0x1c
>     __might_resched+0x130/0x13a
>     rt_spin_lock+0x2a/0x5c
>     die+0x24/0x112
>     do_trap_insn_illegal+0xa0/0xea
>     _new_vmalloc_restore_context_a0+0xcc/0xd8
> Oops - illegal instruction [#1]
> 
> Switch to use raw_spinlock_t, which does not sleep even with PREEMPT_RT
> enabled.
> 
> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The die_lock() is probably do let one CPU die at a time. On x86 there is
support for for recursive die so if it happens, you don't spin on the
die_lock and see nothing. Not sure if this is a thing.

Sebastian

