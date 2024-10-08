Return-Path: <stable+bounces-83041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA6E9950AE
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D7928449F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD5D1DF27A;
	Tue,  8 Oct 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="MZUiqWFi"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239726ADD;
	Tue,  8 Oct 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395559; cv=none; b=oTnBHSDgECgz3qFY/Mu6YXkC05uvQndcvGWqIIoK/aWzPd0XkOzmTpQyfI+KxCkTt6rN+aNrJyaQn+Z45R/lhBZC5VJiaswsk5opsZ0yrZCBK6dKtSk60b5/CJd5I17Gi7viuFl97+D7FKyOjCBsq/iaQw5mAw3vGxIJK65HHo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395559; c=relaxed/simple;
	bh=ZMS+Rl5TsaGNB9WGoe+0owkn3i/R060CfQBCn5OKDWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaxkqSmRqE3iBDcdBbru7xEnKjCgNjjYY/uqIxdOklI8JBLQE/fX+IXcjcdzGQ2r8W1TNMXiJzbCIJUYiGtk1wQEyR2051yE4NUcT6NRUzIMW/oJ1TqNBAceMXSuv2X5NK7PijcfNd7Y4OrWgKXAN10ReHbPpL0IQr1a90czbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=MZUiqWFi; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=K3XwwW061KgN1orzCcgKcqHnOvhEmFckEUZYuHPC+9U=; t=1728395557;
	x=1728827557; b=MZUiqWFicqC9auoJJbqmEDPwoTxIKyhzwAZ51CRo+wqNHYe1Wy9RUnPRFWHK4
	fLN3kTLH3zpUpBad0LDFfHGMWy0TF3xJ8CNml7VYVUm0qB3/8kNhHRInYJY4ZBBFmtzh6rnXE8Qia
	SOv3D1b5Zhl6lAnWCj1h5nNu68zXFLihuRdj3a6XEHJJhB3JG2EFrDrUNUpWdk7gHe7DqlWuIehsr
	DZPJP6a57S9Voi6CbpFc6AOTL/SMlu6vNWyfWOSW7x8HEEI6iKvQ5KNW64BqIFS55bV3OOm4ZUEfJ
	1liAxr2RKE+lJT2PEmkvRlMfPS6dhnrAbciYzdYoLL5PyQjHnQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1syAdH-0005fT-74; Tue, 08 Oct 2024 15:52:11 +0200
Message-ID: <bd933e11-7836-462f-9b6b-5172301f188b@leemhuis.info>
Date: Tue, 8 Oct 2024 15:52:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] Fix dosemu vm86() fault
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Robert Gill <rtgill82@gmail.com>, Jari Ruusu <jariruusu@protonmail.com>,
 Brian Gerst <brgerst@gmail.com>, antonio.gomez.iglesias@linux.intel.com,
 daniel.sneddon@linux.intel.com, stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1728395557;fb0b07a4;
X-HE-SMSGID: 1syAdH-0005fT-74

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Is there hope that patches like these makes it to mainline any time
soon? I fully understand that this it a hard problem, but in the end
what triggered this were at least two regression reports afaics:
https://bugzilla.kernel.org/show_bug.cgi?id=218707
https://lore.kernel.org/lkml/IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com/

Sure, the older one was in April, so one week more or less now won't
make much of a difference. But I think it still would be great to get
this fixed rather sooner than later. Or where those issues meanwhile
fixed through other patches without me noticing and I'm making a fool of
myself here?

This yet again makes me wonder if some "[regression fix]" in the subject
or "CC: regressions@lists.linux.dev" in the patches would help to make
the regression aspect obvious to everyone involved. But it would create
yet another small bit of overhead... :-/

Pawan Gupta, btw: many thx for working on this and sticking to it!

Ciao, Thorsten

On 26.09.24 00:25, Pawan Gupta wrote:
> Changes in v7:
> - Using %ss for verw fails kselftest ldt_gdt.c in 32-bit mode, use safer %cs instead (Dave).
> 
> v6: https://lore.kernel.org/r/20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com
> - Use %ss in 64-bit mode as well for all VERW calls. This avoids any having
>   a separate macro for 32-bit (Dave).
> - Split 32-bit mode fixes into separate patches.
> 
> v5: https://lore.kernel.org/r/20240711-fix-dosemu-vm86-v5-1-e87dcd7368aa@linux.intel.com
> - Simplify the use of ALTERNATIVE construct (Uros/Jiri/Peter).
> 
> v4: https://lore.kernel.org/r/20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com
> - Further simplify the patch by using %ss for all VERW calls in 32-bit mode (Brian).
> - In NMI exit path move VERW after RESTORE_ALL_NMI that touches GPRs (Dave).
> 
> v3: https://lore.kernel.org/r/20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com
> - Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian).
> - Do verw before popf in SYSEXIT path (Jari).
> 
> v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com
> - Safe guard against any other system calls like vm86() that might change %ds (Dave).
> 
> v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com
> 
> Hi,
> 
> This series fixes a #GP in 32-bit kernels when executing vm86() system call
> in dosemu software. In 32-bit mode, their are cases when user can set an
> arbitrary %ds that can cause a #GP when executing VERW instruction. The
> fix is to use %ss for referencing the VERW operand.
> 
> Patch 1-2: Fixes the VERW callsites in 32-bit entry path.
> Patch   3: Uses %ss for VERW in 32-bit and 64-bit mode.
> 
> The fix is tested with below kselftest on 32-bit kernel:
> 
> 	./tools/testing/selftests/x86/entry_from_vm86.c
> 
> 64-bit kernel was boot tested. On a Rocket Lake, measuring the CPU cycles
> for VERW with and without the %ss shows no significant difference. This
> indicates that the scrubbing behavior of VERW is intact.
> 
> Thanks,
> Pawan
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
> Pawan Gupta (3):
>       x86/entry_32: Do not clobber user EFLAGS.ZF
>       x86/entry_32: Clear CPU buffers after register restore in NMI return
>       x86/bugs: Use code segment selector for VERW operand
> 
>  arch/x86/entry/entry_32.S            | 6 ++++--
>  arch/x86/include/asm/nospec-branch.h | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> ---
> base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
> change-id: 20240426-fix-dosemu-vm86-dd111a01737e
> 
> Best regards,

#regzbot poke

