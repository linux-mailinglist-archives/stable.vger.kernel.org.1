Return-Path: <stable+bounces-88235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6644C9B1F25
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 16:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF20EB20FA3
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2040916EB54;
	Sun, 27 Oct 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WwMfGiqV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="86XD6CNH"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8878C9D;
	Sun, 27 Oct 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730044590; cv=none; b=tQYCoLx+MuoV/fyoeecZnTYSsPYrlvZ6LHF0LxQU1v8RLoBVfNaLHzyahdWy0Cj8DnX6HEJkCXVqGvU72PFe4nSMsu3o1NCP4zQfH2mPMYV39IWW3/gtEuWvecQi+yOVvinCxdZ4Bvw9bgYzwJFExkdgtBTizb2n1U92U41HAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730044590; c=relaxed/simple;
	bh=h3YQUPwm72XVMjl5GzQVMZ3L+stg8nlZGTx38d9vzC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Il+YfTbNgDbF3xDPNaeQChG5/3Q242euQKvegr245sIwtrCdPIXFwr7O2cQXx8Uj5AO0foLRfHxHBVWxiRMPI07y57dJujPE9sJeZcdQbxgFFsU347a6sd1x29Lxc/SiixJ7rNkusXLYjOOD2pjfaAzQeiAmeeMpMZqEdS9Isko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WwMfGiqV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=86XD6CNH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730044585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uXrX1QNxr8SdaKFPlGOl0uCLyfvdg+yhI/DiahWTSQ=;
	b=WwMfGiqV8IWE9ZnXau9tUPrf91c8dF/qmw6tAr7evfycRWGrDFuYoiwuDGP51TKo8h0GQD
	t4C9V4T8+JnWj9Hv5fT7PkY8TdxuzaXGRE3qNPQLWVRMeuvjXaPUazxj89amJcAgCeDBlf
	cVaGPtD1qYPYSlByW6BYQjaUXZ9mXH17CuYsvbFYsl1x/i0bewmRlRm2oK/fGwOTFrdD5Z
	Rukv7Het7tvZH9ajvG4Xe4MEl+7yjqESHn9CcGgC52fptUfABWDqLzsL5Ir1IRSmK6FZcb
	9jGgKSLt33FHKBqQiI2xjEhcq6fd2DJfoBXrTz46zBvS4wx1XhgnmQbXvpYr9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730044585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uXrX1QNxr8SdaKFPlGOl0uCLyfvdg+yhI/DiahWTSQ=;
	b=86XD6CNHMZM+YcZ0imnmN0RlxwuuJDg30Ji9TiaNJRngVHoikkn448VWerh3w+/9gnF8SD
	CgRpTnitXAx9wnDg==
To: Celeste Liu <coelacanthushex@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBl?=
 =?utf-8?B?bA==?= <bjorn@kernel.org>,
 Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, =?utf-8?B?Qmo=?=
 =?utf-8?B?w7ZybiBUw7ZwZWw=?=
 <bjorn@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, Yao Zi
 <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
In-Reply-To: <3dc10d89-6c0c-4654-95ed-dd6f19efbad4@gmail.com>
References: <87ldya4nv0.ffs@tglx>
 <3dc10d89-6c0c-4654-95ed-dd6f19efbad4@gmail.com>
Date: Sun, 27 Oct 2024 16:56:24 +0100
Message-ID: <87a5ep4k0n.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 27 2024 at 23:29, Celeste Liu wrote:
> On 2024-10-27 04:21, Thomas Gleixner wrote:
>> The real problem is that orig_a0 is not exposed in the user view of the
>> registers. Changing that struct breaks the existing applications
>> obviously.
>> 
>> But you can expose it without changing the struct by exposing a regset
>> for orig_a0 which allows you to read and write it similar to what ARM64
>> does for the syscall number.
>
> If we add something like NT_SYSCALL_NR to UAPI, it cannot solve anything: We 
> already have PTRACE_GET_SYSCALL_INFO to get syscall number, which was introduced 
> in 5.3 kernel. The problem is only in the kernel before 5.3. So we can't fix 
> this issue unless we also backport NT_SYSCALL_NR to 4.19 LTS. But if we can 
> backport it, we can backport PTRACE_GET_SYSCALL_INFO directly instead.

PTRACE_GET_SYSCALL_INFO only solves half of the problem. It correctly
returns orig_a0, but there is no way to modify orig_a0, which is
required to change arg0.

On x86 AX contains the syscall number and is used for the return
value. So the tracer has do modify orig_AX when it wants to change the
syscall number.

Equivalently you need to be able to modify orig_a0 for changing arg0,
no?

Thanks,

        tglx



