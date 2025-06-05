Return-Path: <stable+bounces-151493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47ADACEAF9
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 09:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6009C189B6DA
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 07:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112E1E89C;
	Thu,  5 Jun 2025 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZIMVyFo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iImNtzLO"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF442A9B;
	Thu,  5 Jun 2025 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749109069; cv=none; b=dncsv0OjZEw5U0RSnx1SwcV1CNd93G5qrEu4/iuDgT16/mQe0+Oigp0JdCanYVk2hV2zXHVtVWpOQDifEGGhNeGeo0wA+N+Dbv5v1Lmb5jud6ius2YZqCVvphc5U2zM23w7GSDHoWVeKoWqYhUGR3e19AtMyCFWEz2cN2y8ySlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749109069; c=relaxed/simple;
	bh=IaY5Lgr5VfZJ3xaAOEkb8FT8Ou/Vxrq/5JfjGJ8nIYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN/nm7uO/RwXw4jHtK8mEpXYUmYB8zUXSG4ttM1wZSwJuabI3QwRUf1uAlZ0yd1kU55iT0N7S3ob0sCH1BrEKHZNGH9penIfy1nNytswqlgO/JA3L9Axb5yC6syxgnNCvOgfOV7VQQlIcypQlyds8tO//EG4mrt/x+se9M72xgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZIMVyFo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iImNtzLO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Jun 2025 09:37:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749109066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wF8eAipcjIt3omPev2NAmi21MfMoslaY24iFiYJBlIg=;
	b=KZIMVyFoeYRQ5S5x7RTvkpWaJXFmfI2wDejc84O+mZOzUODMZG7ly5iS94G2CPZ26PGYt6
	MBvU+boTcJg7Tc3ijw39zO1ZB1qgLUkemf76TWD+bFjCbdzcBb100LyBNDSW7eav59aQVz
	SY6bL8yfR3DLuzWt5RT7s0BAOD6SJwUyjO0N1r5onnLVQYSrDGt6kt5EwcHxbLse27H4Ga
	xWTHepnyyWQStXtTdb4tNmdHG4T7AYHYmWb6tijlVuySGDQt+LoqPy3lLOgK0G0RWhDdHh
	fSI4j0286Lm1TTBd7hAtuECmtsRUOeWYjjDWSLGeVjxkzeW/ViwefbYqDMmSJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749109066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wF8eAipcjIt3omPev2NAmi21MfMoslaY24iFiYJBlIg=;
	b=iImNtzLO6y1nqeyLtGMj/6dkFYnq6dZt1HzVON+HR4uNX52tOLr+vkVL4WfQqlG6QgvU4J
	aJsRYJZs7bns+sDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: vDSO: correctly use asm parameters in syscall
 wrappers
Message-ID: <20250605092735-bd76e803-e896-4d4c-a1f1-c30f8d321a9a@linutronix.de>
References: <20250603-loongarch-vdso-syscall-v1-1-6d12d6dfbdd0@linutronix.de>
 <CAAhV-H4Ba7DMV6AvGnvNBJ8FL_YcHjeeHYZWw2NG6JHL=X4PkQ@mail.gmail.com>
 <5a5329feaab84acb91bbb4f48ea548b3fb4eab0f.camel@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a5329feaab84acb91bbb4f48ea548b3fb4eab0f.camel@xry111.site>

On Wed, Jun 04, 2025 at 10:30:55PM +0800, Xi Ruoyao wrote:
> On Wed, 2025-06-04 at 22:05 +0800, Huacai Chen wrote:
> > On Tue, Jun 3, 2025 at 7:49 PM Thomas Weißschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > > 
> > > The syscall wrappers use the "a0" register for two different register
> > > variables, both the first argument and the return value. The "ret"
> > > variable is used as both input and output while the argument register is
> > > only used as input. Clang treats the conflicting input parameters as
> > > undefined behaviour and optimizes away the argument assignment.
> > > 
> > > The code seems to work by chance for the most part today but that may
> > > change in the future. Specifically clock_gettime_fallback() fails with
> > > clockids from 16 to 23, as implemented by the upcoming auxiliary clocks.
> > > 
> > > Switch the "ret" register variable to a pure output, similar to the other
> > > architectures' vDSO code. This works in both clang and GCC.
> > Hmmm, at first the constraint is "=r", during the progress of
> > upstream, Xuerui suggested me to use "+r" instead [1].
> > [1]  https://lore.kernel.org/linux-arch/5b14144a-9725-41db-7179-c059c41814cf@xen0n.name/
> 
> Based on the example at
> https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html:
> 
>    To force an operand into a register, create a local variable and specify
>    the register name after the variable’s declaration. Then use the local
>    variable for the asm operand and specify any constraint letter that
>    matches the register:
>    
>    register int *p1 asm ("r0") = …;
>    register int *p2 asm ("r1") = …;
>    register int *result asm ("r0");
>    asm ("sysint" : "=r" (result) : "0" (p1), "r" (p2));
>    
> I think this should actually be written
> 
>  	asm volatile(
>  	"      syscall 0\n"
> 	: "=r" (ret)
>  	: "r" (nr), "0" (buffer), "r" (len), "r" (flags)
>  	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
> "$t8",
>  	  "memory");
> 
> i.e. "=" should be used for the output operand 0, and "0" should be used
> for the input operand 2 (buffer) to emphasis the same register as
> operand 0 is used.

I would have expected that matching constraints ("0") would only really make
sense if the compiler selects the specific register to use. When the register is
already selected manually it seems redundant.
But my inline ASM knowledge is limited and this is a real example from the GCC
docs, so it is probably more correct.
On the other hand all the other vDSO implementations use "r" over "0" for the
input operand 2 and I'd like to keep them consistent.


Thomas

