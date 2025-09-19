Return-Path: <stable+bounces-180677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEFDB8ABA3
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8973B72AD
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2943521C195;
	Fri, 19 Sep 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1t2lNJK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC47464
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302326; cv=none; b=o3VxqA5M1Se27Zm/pyHOUCARaCENnDgGld620V5nNr5DB0+dWf9LNWEf0h67CmHi+f5ORclA/AR/h845yYvoNft0Ac6e3daq09I5Tl8UFhJOSY0xDUBzI3h/sQpYbT+z/ZKOM5NpkAGpirOORuNbNTzELWd2qyLLF3YZ3Pn96vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302326; c=relaxed/simple;
	bh=DNf3UGIm+8L8KNHUARnhgaOFd0YQqtml+Jy5rQrZpsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8hoc2n5r5Xh/OewVjS2NQYHQY8ueiWkPcoYsucQ0uzjzKkvI+Qv+76OhVlRnJOv6r66odxr0mhdAD19OJksI8eNYMwqfIYu6BXMNydXWvo7wUtmXhlmBHkGT3rnT74zHFaTngxeTS3d2/yMpPXbs28Dx2add7iKiUtc6J5ICNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1t2lNJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD066C4CEF9;
	Fri, 19 Sep 2025 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758302326;
	bh=DNf3UGIm+8L8KNHUARnhgaOFd0YQqtml+Jy5rQrZpsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x1t2lNJKh86vhNT9z47Zjc32qkAb6ildg3ag4mJw1lmN0KR7SqJ+kF1H1Qgk8dN7z
	 RwDwB6RXgIgZxcROUHtbsQkbWKlzBdhQd8TgAydGvZF01y/k8C813zc8MG9ecXJbYd
	 UbhyCO16hug+BJqXx8Ot3K1taoQcqsndh5Q+m86E=
Date: Fri, 19 Sep 2025 19:18:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Borislav Petkov <bp@alien8.de>, pawan.kumar.gupta@linux.intel.com,
	dave.hansen@linux.intel.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [bug-report 6.12.y] Probably a problematic stable backport
 commit: 7c62c442b6eb ("x86/vmscape: Enumerate VMSCAPE bug")
Message-ID: <2025091932-delay-goofball-fc26@gregkh>
References: <915c0e00-b92d-4e37-9d4b-0f6a4580da97@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <915c0e00-b92d-4e37-9d4b-0f6a4580da97@oracle.com>

On Fri, Sep 19, 2025 at 10:42:33PM +0530, Harshit Mogalapalli wrote:
> Hi stable maintainers,
> 
> While skimming over stable backports for VMSCAPE commits, I found something
> unusual.
> 
> 
> This is regarding the 6.12.y commit: 7c62c442b6eb ("x86/vmscape: Enumerate
> VMSCAPE bug")
> 
> 
> commit 7c62c442b6eb95d21bc4c5afc12fee721646ebe2
> Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Date:   Thu Aug 14 10:20:42 2025 -0700
> 
>     x86/vmscape: Enumerate VMSCAPE bug
> 
>     Commit a508cec6e5215a3fbc7e73ae86a5c5602187934d upstream.
> 
>     The VMSCAPE vulnerability may allow a guest to cause Branch Target
>     Injection (BTI) in userspace hypervisors.
> 
>     Kernels (both host and guest) have existing defenses against direct BTI
>     attacks from guests. There are also inter-process BTI mitigations which
>     prevent processes from attacking each other. However, the threat in this
>     case is to a userspace hypervisor within the same process as the
> attacker.
> 
>     Userspace hypervisors have access to their own sensitive data like disk
>     encryption keys and also typically have access to all guest data. This
>     means guest userspace may use the hypervisor as a confused deputy to
> attack
>     sensitive guest kernel data. There are no existing mitigations for these
>     attacks.
> 
>     Introduce X86_BUG_VMSCAPE for this vulnerability and set it on affected
>     Intel and AMD CPUs.
> 
>     Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>     Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>     Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 
> So the problem in this commit is this part of the backport:
> 
> in file: arch/x86/kernel/cpu/common.c
> 
>         VULNBL_AMD(0x15, RETBLEED),
>         VULNBL_AMD(0x16, RETBLEED),
> -       VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
> -       VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
> -       VULNBL_AMD(0x19, SRSO | TSA),
> +       VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO | VMSCAPE),
> +       VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO | VMSCAPE),
> +       VULNBL_AMD(0x19, SRSO | TSA | VMSCAPE),
> +       VULNBL_AMD(0x1a, SRSO | VMSCAPE),
> +
>         {}
> 
> Notice the part where VULNBL_AMD(0x1a, SRSO | VMSCAPE) is added, 6.12.y
> doesn't have commit: 877818802c3e ("x86/bugs: Add SRSO_USER_KERNEL_NO
> support") so I think we shouldn't be adding VULNBL_AMD(0x1a, SRSO | VMSCAPE)
> directly.
> 
> Boris Ostrovsky suggested me to verify this on a Turin machine as this could
> cause a very big performance regression : and stated if SRSO mitigation
> status is Safe RET we are likely in a problem, and we are in that situation.
> 
> # lscpu | grep -E "CPU family"
> CPU family:          26
> 
> Notes: CPU ID 26 -> 0x1a
> 
> And Turin machine reports the SRSO mitigation status as "Safe RET"
> 
> # uname -r
> 6.12.48-master.20250917.el8.rc1.x86_64
> 
> # cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
> Mitigation: Safe RET
> 
> 
> Boris Ostrovsky suggested backporting three commits to 6.12.y:
> 1. commit: 877818802c3e ("x86/bugs: Add SRSO_USER_KERNEL_NO support")
> 2. commit: 8442df2b49ed ("x86/bugs: KVM: Add support for SRSO_MSR_FIX") and
> its fix
> 3. commit: e3417ab75ab2 ("KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=>
> 1 VM count transitions") -- Maybe optional
> 
> After backporting these three:
> 
> # uname -r
> 6.12.48-master.20250919.el8.dev.x86_64 // Note this this is kernel with
> patches above three applied.
> 
> # dmesg | grep -C 2 Reduce
> [ 3.186135] Speculative Store Bypass: Mitigation: Speculative Store Bypass
> disabled via prctl
> [ 3.187135] Speculative Return Stack Overflow: Reducing speculation to
> address VM/HV SRSO attack vector.
> [ 3.188134] Speculative Return Stack Overflow: Mitigation: Reduced
> Speculation
> [ 3.189135] VMSCAPE: Mitigation: IBPB before exit to userspace
> [ 3.191139] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point
> registers'
> 
> # cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
> Mitigation: Reduced Speculation
> 
> I can send my backports to stable if this looks good. Thoughts ?

Please submit them if they solve this issue, thank you!

