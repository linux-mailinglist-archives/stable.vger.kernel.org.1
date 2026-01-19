Return-Path: <stable+bounces-210369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7668CD3AF48
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 744A930052A4
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA75138A9B3;
	Mon, 19 Jan 2026 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyKfX50q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzmUQBXi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03E1A285
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837081; cv=none; b=lLY0eA46xVIXJhvGePrOVCZVOSsa2nXAeviABKB6VTirmupRFf1aHakgHy7x1M2MYg/rLhRb0KZOZ9xbbji4gJDD10/aA1YziJi/7+pqSyyzdNoncnvDkh3Fg6odwWSJMPphLuUFUzUjYjvYevDKWunFMuEOrgenx6gTxS5thME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837081; c=relaxed/simple;
	bh=Yp67TS2pIfpAmS3vSdHNyKBJe9tMzbDFxMsgGQbPmqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+pt4oqUmNN2tQJstoC2hx2AH+7P4Q9hX1wDapDmoiQibGkIympsMv1RjiA9qJg4jA41EMD0e8pVuChtXulf+K5VmsCMnZejzVgcAfhzqH4CG3yRKEDHHz+z/VCOjwNfwLX4gyQQzqO9JmArqzFN0hIypG8xxUuyZ0ADJTgXJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyKfX50q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzmUQBXi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768837078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N5HdQyEqPVuI6xKKKN8iU0AnWxPVHWH7wW2JMdeQD8M=;
	b=eyKfX50qZBSvO46EsYiFBoll5Zx2L+9yLMNl3A/hzoH3nN7XzD+ogIGMCwwM30SR4ww+5T
	2WEBsYQel8Qh2atR8TRjn2KIQ1KVl4/BVWVeVbu6a+6EtXLBjl4qajSJDM8XrgN8Bi/QB5
	DP6vNTXuvH3Muo9s4vkxf8mE5EUisDA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-AjPWdN8XMrKfZPDOS38uhg-1; Mon, 19 Jan 2026 10:37:57 -0500
X-MC-Unique: AjPWdN8XMrKfZPDOS38uhg-1
X-Mimecast-MFC-AGG-ID: AjPWdN8XMrKfZPDOS38uhg_1768837076
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-434302283dcso3443042f8f.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 07:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768837076; x=1769441876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N5HdQyEqPVuI6xKKKN8iU0AnWxPVHWH7wW2JMdeQD8M=;
        b=hzmUQBXicDtjS+66QxCto/ona0DCsN9IM0LmU4YpKKK5M5Aey2tucreA2F628ZDCp9
         SVVLLc/5LKysCmPP+aNWQ2Zb/i3jE3hlCQGDRaiclRJxn+tjBkkcUUNggVOArC3HBmek
         yTKtFuVaa6zPprvK+YItTKHk4d61Czu91+q++1FWFvZli5SG2QQrrxiCZ7Ud9qJipaDv
         9iUrJf5dmpyiqW1bQ3qeFJHbEOTS+5csLvk90nzuPy6gc/nVMdu4cWAV4otuEcXoZLox
         CYgdG20bKKM36ssxR1TX8phUdWkxDszeFWl9DIYB6bwr9oK5a9qV3SRTwm3CQQfy7q8e
         2b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768837076; x=1769441876;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5HdQyEqPVuI6xKKKN8iU0AnWxPVHWH7wW2JMdeQD8M=;
        b=nRDlD+7qPlruMTGnpeFkhQw64AHSOcELzH9vMBpcQdWGb5xj4HsOdm+DnSybYxdASw
         azyJUWb4++v8TXDopJrAKL8Nyo7BXi3JdJzWntHLIZEcPY1Y1PHBQCHuqYLs7dtHEKJJ
         oTH9OyvhzLn9+mLtw37oF4gvhy0Cd+YLubWyGOzPG25eYqVNYAU3o5j0ZGr3nUh87k8U
         9h8TNBPDqvW5o/9I82aU7VD/55XY7rsMD95zNkGcpwY3RY5Xe192/j1QVvutDajF7bxg
         axrp17bSDnj1J9Tn2Y1pZ+d/CnGCFFTRT+5WfcVnFd4tcYuI8sP1SBASj9OuuOYTA/Zz
         hpNg==
X-Forwarded-Encrypted: i=1; AJvYcCUy3OmwWWUQI4ksW1RZ9MWON1rqG8kZy7PeSkuwAepRK51PdbH8LyQSx5k/FS+uA8La8up3/Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8xbedImzU6Xwc5ZF1/zgxQpVIM26ZlzevOeGJr0XapT2w6Y/
	v8pDBwi865dghlbwjJY16PrM9jhKxgTISaUzFdsu+Bu7zp/YeufCl/TQgDtnVH9QK3X4kf4TDRx
	eIUhI8hONL4MH1+2U+TNYHMxzZqprgvx6USGZNm46MSYZSjHazxcvhtX9i2c9vxcLHw==
X-Gm-Gg: AZuq6aLiMpSbR7DMGs5BXLuDBWYYgR65UCP8cPc7lvtAytyfLH1lo8/bgauJuOheDrZ
	sgiZPxEU09Rvwj3Y+GPVfmHSgOwtHl2aFQYde6NulZkqr/2/9vYzCkMYpKC5fxCcSNsceM3IuVi
	BHvvyl2PgbxZL1XVp7OhgyfxvEJx6mDBrFtC5yhFqFUBsLPzmAUsOCnsWwNj0F63fdyeHCZfgBk
	j6alBUu6qX9FORSzcHbRttd2eFVL5YjhjDwzAlDIcTTpizt5PAF7KSb/L1dwxjgDXuNJFKMAg/z
	1wdU1x4r8ACzE1PlcRLy/HxNMrI4+xnl97k+ABKWPZCjx+waQVMKXUw6REb/ibu7Szl+mxrSM2l
	6LHBvs1Oxjcgcdrns+BReYXBsLYx+FYcvPekVslp3WFXfRzOwSZuPZ5ucOZnaVzoNd90oN+iths
	cY1+hYDxqGi38xMQ==
X-Received: by 2002:a05:6000:3110:b0:430:f40f:61ba with SMTP id ffacd0b85a97d-43569bbaf11mr15280973f8f.41.1768837075669;
        Mon, 19 Jan 2026 07:37:55 -0800 (PST)
X-Received: by 2002:a05:6000:3110:b0:430:f40f:61ba with SMTP id ffacd0b85a97d-43569bbaf11mr15280917f8f.41.1768837075077;
        Mon, 19 Jan 2026 07:37:55 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43569927007sm23646232f8f.16.2026.01.19.07.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 07:37:54 -0800 (PST)
Message-ID: <4eb96c8e-fd5b-43b5-b6b0-f7dfad5c460b@redhat.com>
Date: Mon, 19 Jan 2026 16:37:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] x86/fpu: Clear XSTATE_BV[i] in guest XSAVE state
 whenever XFD[i]=1
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <2026011917-record-decorated-9020@gregkh>
 <20260119152825.3011564-1-sashal@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260119152825.3011564-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/26 16:28, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit b45f721775947a84996deb5c661602254ce25ce6 ]
> 
> When loading guest XSAVE state via KVM_SET_XSAVE, and when updating XFD in
> response to a guest WRMSR, clear XFD-disabled features in the saved (or to
> be restored) XSTATE_BV to ensure KVM doesn't attempt to load state for
> features that are disabled via the guest's XFD.  Because the kernel
> executes XRSTOR with the guest's XFD, saving XSTATE_BV[i]=1 with XFD[i]=1
> will cause XRSTOR to #NM and panic the kernel.
> 
> E.g. if fpu_update_guest_xfd() sets XFD without clearing XSTATE_BV:
> 
>    ------------[ cut here ]------------
>    WARNING: arch/x86/kernel/traps.c:1524 at exc_device_not_available+0x101/0x110, CPU#29: amx_test/848
>    Modules linked in: kvm_intel kvm irqbypass
>    CPU: 29 UID: 1000 PID: 848 Comm: amx_test Not tainted 6.19.0-rc2-ffa07f7fd437-x86_amx_nm_xfd_non_init-vm #171 NONE
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>    RIP: 0010:exc_device_not_available+0x101/0x110
>    Call Trace:
>     <TASK>
>     asm_exc_device_not_available+0x1a/0x20
>    RIP: 0010:restore_fpregs_from_fpstate+0x36/0x90
>     switch_fpu_return+0x4a/0xb0
>     kvm_arch_vcpu_ioctl_run+0x1245/0x1e40 [kvm]
>     kvm_vcpu_ioctl+0x2c3/0x8f0 [kvm]
>     __x64_sys_ioctl+0x8f/0xd0
>     do_syscall_64+0x62/0x940
>     entry_SYSCALL_64_after_hwframe+0x4b/0x53
>     </TASK>
>    ---[ end trace 0000000000000000 ]---
> 
> This can happen if the guest executes WRMSR(MSR_IA32_XFD) to set XFD[18] = 1,
> and a host IRQ triggers kernel_fpu_begin() prior to the vmexit handler's
> call to fpu_update_guest_xfd().
> 
> and if userspace stuffs XSTATE_BV[i]=1 via KVM_SET_XSAVE:
> 
>    ------------[ cut here ]------------
>    WARNING: arch/x86/kernel/traps.c:1524 at exc_device_not_available+0x101/0x110, CPU#14: amx_test/867
>    Modules linked in: kvm_intel kvm irqbypass
>    CPU: 14 UID: 1000 PID: 867 Comm: amx_test Not tainted 6.19.0-rc2-2dace9faccd6-x86_amx_nm_xfd_non_init-vm #168 NONE
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>    RIP: 0010:exc_device_not_available+0x101/0x110
>    Call Trace:
>     <TASK>
>     asm_exc_device_not_available+0x1a/0x20
>    RIP: 0010:restore_fpregs_from_fpstate+0x36/0x90
>     fpu_swap_kvm_fpstate+0x6b/0x120
>     kvm_load_guest_fpu+0x30/0x80 [kvm]
>     kvm_arch_vcpu_ioctl_run+0x85/0x1e40 [kvm]
>     kvm_vcpu_ioctl+0x2c3/0x8f0 [kvm]
>     __x64_sys_ioctl+0x8f/0xd0
>     do_syscall_64+0x62/0x940
>     entry_SYSCALL_64_after_hwframe+0x4b/0x53
>     </TASK>
>    ---[ end trace 0000000000000000 ]---
> 
> The new behavior is consistent with the AMX architecture.  Per Intel's SDM,
> XSAVE saves XSTATE_BV as '0' for components that are disabled via XFD
> (and non-compacted XSAVE saves the initial configuration of the state
> component):
> 
>    If XSAVE, XSAVEC, XSAVEOPT, or XSAVES is saving the state component i,
>    the instruction does not generate #NM when XCR0[i] = IA32_XFD[i] = 1;
>    instead, it operates as if XINUSE[i] = 0 (and the state component was
>    in its initial state): it saves bit i of XSTATE_BV field of the XSAVE
>    header as 0; in addition, XSAVE saves the initial configuration of the
>    state component (the other instructions do not save state component i).
> 
> Alternatively, KVM could always do XRSTOR with XFD=0, e.g. by using
> a constant XFD based on the set of enabled features when XSAVEing for
> a struct fpu_guest.  However, having XSTATE_BV[i]=1 for XFD-disabled
> features can only happen in the above interrupt case, or in similar
> scenarios involving preemption on preemptible kernels, because
> fpu_swap_kvm_fpstate()'s call to save_fpregs_to_fpstate() saves the
> outgoing FPU state with the current XFD; and that is (on all but the
> first WRMSR to XFD) the guest XFD.
> 
> Therefore, XFD can only go out of sync with XSTATE_BV in the above
> interrupt case, or in similar scenarios involving preemption on
> preemptible kernels, and it we can consider it (de facto) part of KVM
> ABI that KVM_GET_XSAVE returns XSTATE_BV[i]=0 for XFD-disabled features.
> 
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 820a6ee944e7 ("kvm: x86: Add emulation for IA32_XFD", 2022-01-14)
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [Move clearing of XSTATE_BV from fpu_copy_uabi_to_guest_fpstate
>   to kvm_vcpu_ioctl_x86_set_xsave. - Paolo]
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kernel/fpu/core.c | 32 +++++++++++++++++++++++++++++---
>   arch/x86/kvm/x86.c         |  9 +++++++++
>   2 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 175c14567cf14..75dad6e3c9840 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -294,10 +294,29 @@ EXPORT_SYMBOL_GPL(fpu_enable_guest_xfd_features);
>   #ifdef CONFIG_X86_64
>   void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd)
>   {
> +	struct fpstate *fpstate = guest_fpu->fpstate;
> +
>   	fpregs_lock();
> -	guest_fpu->fpstate->xfd = xfd;
> -	if (guest_fpu->fpstate->in_use)
> -		xfd_update_state(guest_fpu->fpstate);
> +
> +	/*
> +	 * KVM's guest ABI is that setting XFD[i]=1 *can* immediately revert the
> +	 * save state to its initial configuration.  Likewise, KVM_GET_XSAVE does
> +	 * the same as XSAVE and returns XSTATE_BV[i]=0 whenever XFD[i]=1.
> +	 *
> +	 * If the guest's FPU state is in hardware, just update XFD: the XSAVE
> +	 * in fpu_swap_kvm_fpstate will clear XSTATE_BV[i] whenever XFD[i]=1.
> +	 *
> +	 * If however the guest's FPU state is NOT resident in hardware, clear
> +	 * disabled components in XSTATE_BV now, or a subsequent XRSTOR will
> +	 * attempt to load disabled components and generate #NM _in the host_.
> +	 */
> +	if (xfd && test_thread_flag(TIF_NEED_FPU_LOAD))
> +		fpstate->regs.xsave.header.xfeatures &= ~xfd;
> +
> +	fpstate->xfd = xfd;
> +	if (fpstate->in_use)
> +		xfd_update_state(fpstate);
> +
>   	fpregs_unlock();
>   }
>   EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
> @@ -405,6 +424,13 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
>   	if (ustate->xsave.header.xfeatures & ~xcr0)
>   		return -EINVAL;
>   
> +	/*
> +	 * Disabled features must be in their initial state, otherwise XRSTOR
> +	 * causes an exception.
> +	 */
> +	if (WARN_ON_ONCE(ustate->xsave.header.xfeatures & kstate->xfd))
> +		return -EINVAL;
> +
>   	/*
>   	 * Nullify @vpkru to preserve its current value if PKRU's bit isn't set
>   	 * in the header.  KVM's odd ABI is to leave PKRU untouched in this
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8acaaa8f17b98..89df215ebf284 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5432,9 +5432,18 @@ static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
>   static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
>   					struct kvm_xsave *guest_xsave)
>   {
> +	union fpregs_state *xstate = (union fpregs_state *)guest_xsave->region;
> +
>   	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
>   		return 0;
>   
> +	/*
> +	 * For backwards compatibility, do not expect disabled features to be in
> +	 * their initial state.  XSTATE_BV[i] must still be cleared whenever
> +	 * XFD[i]=1, or XRSTOR would cause a #NM.
> +	 */
> +	xstate->xsave.header.xfeatures &= ~vcpu->arch.guest_fpu.fpstate->xfd;
> +
>   	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
>   					      guest_xsave->region,
>   					      kvm_caps.supported_xcr0,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


