Return-Path: <stable+bounces-112317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66C7A28A50
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C373B165A17
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 12:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BFE1E868;
	Wed,  5 Feb 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YazgREI4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D8151987
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738758721; cv=none; b=EZ02w9vm+99++1YVtmpIGrhFXMjJOK18M8yTZA7QTTDYQ9dccv2yo7hw4jX4LXpvOHyg2zl3PhDCDub4/ImTiJyOUXq14d7XE/+YXgQncFCLPj0WLQ5SF0/sPU9EEfA/MR3h6nmGwJBFcL2ZwZ3PuFLJ1gyDOnRs8Yd/msY4jFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738758721; c=relaxed/simple;
	bh=rkPsZCd4DAeOJD5OR6QiEJ9J6CUWsTz2D7mNNXUcIj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSHEA/usJoCrpSvCwIuzLxSftnQTMDjPmSSY7EPqjAsUS6Z9tJ7rWXkpBm95K5nE4RFFcm6N7F7cGd2rX+y19C8ujpW8CAPqVhu2LKOi0K3m88oP8W1rt9FbhdbACdl1wgHKGdpM0wiWWvkhY8y3BCMJwoynluMaAFTlo2LUwvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YazgREI4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738758718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nX4R1J3tJqgXNtmHCVf3jelvmV9h4OXD2UPjQtl2Fsw=;
	b=YazgREI43LRI62wocsL5FTFExmf4q32LC5J9fuWjLZM+yIRhZhTUfZTRwVU1oGhW2NCO7V
	9eORkpxDhEHnfvsK0W/0I1epCL2kO2QORnBip4IZGnNVXg9ULf5RtBh4TRFPIkS9n1PLLE
	c/HtpXIFytvmAsMDapEpqhWBwMDO1lA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ykrr_B6lP3qpP6dgdre4kw-1; Wed, 05 Feb 2025 07:31:57 -0500
X-MC-Unique: ykrr_B6lP3qpP6dgdre4kw-1
X-Mimecast-MFC-AGG-ID: ykrr_B6lP3qpP6dgdre4kw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436723bf7ffso58666655e9.3
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 04:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738758716; x=1739363516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nX4R1J3tJqgXNtmHCVf3jelvmV9h4OXD2UPjQtl2Fsw=;
        b=c5ngYqvb7p9Lg93P6Z6+XI/LVgiVw+CqA8HNx+IgOVPh+LShfiDCVQhy5JMecU08mY
         tdMGjSRCgjcyTlKZ4bFutvocVaFDeWAuNzz+sQHhbWVG+k5Suzcin12l1ZzABHuxDlo2
         fTzm/bI+hYfr8dHRlc9BPA60GTK3HhtwHrGflOnogS6vrtbnwrwgg3jN+K5WfzenhneS
         zcBDTyAy1CuzXcJhGQ3NjemTaDyQ0SE+KtrvaiJaHegQcVs3PNCtdTNb/HTlL6OBQiCm
         h9PIiZANvISUEmwoUiJietVK/r9wSPxwvxmSfgqP3OG7XkhSXRfD41kk4FjjnAspG76e
         02Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWArh4eEobEid5flHRFydJdk2NmLtJRWY7t/0Rt3nNQBF1ebZfduYNmouhaL5PcLySr1wX/OXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytRORJmIgOBVcVu/Yo+CWN8C1E0JVrlnv4w81gUiYt9vCYdz2c
	f/g6etqUJD7eVoLZePxTdWLnias7gKxc1CPQRL3Nn+PYi4HGHvEC1MK0WRdYFIiHTO+HHXnhG+z
	0vmaBIX1g0BxmAkzvhmO+Gn1IoXj9qqKB3yUW1A/Qrq8rmwPaJsGfvA==
X-Gm-Gg: ASbGncudF+YUQQb72XM2U0aSIg9LvvPdfY3+t3PGOY0Qefz4rB+XIuzjJBxKO1oPBkK
	cbbROxQjMqUaCuKyRkgbVEJW+kNNzWXWFb2Ks2h8of9f57kqZKpt0xKFd5UxLWRWpecg2zN+06z
	Ta5JD2EkVmmVyscNt3ItDN9l5vAGdjidm3Sqd61WdmCwnwrFVJNw1RACyENurc74bkIq9LiI6cE
	FuMhHW2Tntx4RSSV/KA3SoUymW47U5IF0+DQrAywzYHIav+Kt3ikEw/uyd1zdtzlbK4AQA8CUN0
	SgcaVwTU+T5WIKNcV7RYLlDcXDq8CsXZO4fmgyePrqtWQDA=
X-Received: by 2002:a05:600c:5127:b0:436:1baa:de1c with SMTP id 5b1f17b1804b1-4390d43e4fdmr22441035e9.13.1738758715855;
        Wed, 05 Feb 2025 04:31:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu8UQolYnAq5L4ETol9e+CppDVauJEFOX/uqtF/MVCF19JA9RxfWAWC3l0svk2IQEOGRJbqQ==
X-Received: by 2002:a05:600c:5127:b0:436:1baa:de1c with SMTP id 5b1f17b1804b1-4390d43e4fdmr22440555e9.13.1738758715452;
        Wed, 05 Feb 2025 04:31:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390da6e653sm19539215e9.24.2025.02.05.04.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 04:31:54 -0800 (PST)
Message-ID: <d1302cfe-486c-4516-a875-d9467529482a@redhat.com>
Date: Wed, 5 Feb 2025 13:31:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] KVM: arm64: Unconditionally save+flush host
 FPSIMD/SVE/SME state
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org, catalin.marinas@arm.com, fweimer@redhat.com,
 jeremy.linton@arm.com, maz@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, stable@vger.kernel.org, tabba@google.com,
 wilco.dijkstra@arm.com, will@kernel.org
References: <20250204152100.705610-1-mark.rutland@arm.com>
 <20250204152100.705610-2-mark.rutland@arm.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250204152100.705610-2-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 2/4/25 4:20 PM, Mark Rutland wrote:
> There are several problems with the way hyp code lazily saves the host's
> FPSIMD/SVE state, including:
> 
> * Host SVE being discarded unexpectedly due to inconsistent
>   configuration of TIF_SVE and CPACR_ELx.ZEN. This has been seen to
>   result in QEMU crashes where SVE is used by memmove(), as reported by
>   Eric Auger:
> 
>   https://issues.redhat.com/browse/RHEL-68997

I tested the above test case with the whole series.

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> 
> * Host SVE state is discarded *after* modification by ptrace, which was an
>   unintentional ptrace ABI change introduced with lazy discarding of SVE state.
> 
> * The host FPMR value can be discarded when running a non-protected VM,
>   where FPMR support is not exposed to a VM, and that VM uses
>   FPSIMD/SVE. In these cases the hyp code does not save the host's FPMR
>   before unbinding the host's FPSIMD/SVE/SME state, leaving a stale
>   value in memory.
> 
> Avoid these by eagerly saving and "flushing" the host's FPSIMD/SVE/SME
> state when loading a vCPU such that KVM does not need to save any of the
> host's FPSIMD/SVE/SME state. For clarity, fpsimd_kvm_prepare() is
> removed and the necessary call to fpsimd_save_and_flush_cpu_state() is
> placed in kvm_arch_vcpu_load_fp(). As 'fpsimd_state' and 'fpmr_ptr'
> should not be used, they are set to NULL; all uses of these will be
> removed in subsequent patches.
> 
> Historical problems go back at least as far as v5.17, e.g. erroneous
> assumptions about TIF_SVE being clear in commit:
> 
>   8383741ab2e773a9 ("KVM: arm64: Get rid of host SVE tracking/saving")
> 
> ... and so this eager save+flush probably needs to be backported to ALL
> stable trees.
> 
> Fixes: 93ae6b01bafee8fa ("KVM: arm64: Discard any SVE state when entering KVM guests")
> Fixes: 8c845e2731041f0f ("arm64/sve: Leave SVE enabled on syscall if we don't context switch")
> Fixes: ef3be86021c3bdf3 ("KVM: arm64: Add save/restore support for FPMR")
> Reported-by: Eric Auger <eauger@redhat.com>
> Reported-by: Wilco Dijkstra <wilco.dijkstra@arm.com>
> Cc: stable@vger.kernel.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 25 -------------------------
>  arch/arm64/kvm/fpsimd.c    | 35 ++++++++++-------------------------
>  2 files changed, 10 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 2b601d88762d4..8370d55f03533 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1694,31 +1694,6 @@ void fpsimd_signal_preserve_current_state(void)
>  		sve_to_fpsimd(current);
>  }
>  
> -/*
> - * Called by KVM when entering the guest.
> - */
> -void fpsimd_kvm_prepare(void)
> -{
> -	if (!system_supports_sve())
> -		return;
> -
> -	/*
> -	 * KVM does not save host SVE state since we can only enter
> -	 * the guest from a syscall so the ABI means that only the
> -	 * non-saved SVE state needs to be saved.  If we have left
> -	 * SVE enabled for performance reasons then update the task
> -	 * state to be FPSIMD only.
> -	 */
> -	get_cpu_fpsimd_context();
> -
> -	if (test_and_clear_thread_flag(TIF_SVE)) {
> -		sve_to_fpsimd(current);
> -		current->thread.fp_type = FP_STATE_FPSIMD;
> -	}
> -
> -	put_cpu_fpsimd_context();
> -}
> -
>  /*
>   * Associate current's FPSIMD context with this cpu
>   * The caller must have ownership of the cpu FPSIMD context before calling
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 4d3d1a2eb1570..ceeb0a4893aa7 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -54,16 +54,18 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
>  	if (!system_supports_fpsimd())
>  		return;
>  
> -	fpsimd_kvm_prepare();
> -
>  	/*
> -	 * We will check TIF_FOREIGN_FPSTATE just before entering the
> -	 * guest in kvm_arch_vcpu_ctxflush_fp() and override this to
> -	 * FP_STATE_FREE if the flag set.
> +	 * Ensure that any host FPSIMD/SVE/SME state is saved and unbound such
> +	 * that the host kernel is responsible for restoring this state upon
> +	 * return to userspace, and the hyp code doesn't need to save anything.
> +	 *
> +	 * When the host may use SME, fpsimd_save_and_flush_cpu_state() ensures
> +	 * that PSTATE.{SM,ZA} == {0,0}.
>  	 */
> -	*host_data_ptr(fp_owner) = FP_STATE_HOST_OWNED;
> -	*host_data_ptr(fpsimd_state) = kern_hyp_va(&current->thread.uw.fpsimd_state);
> -	*host_data_ptr(fpmr_ptr) = kern_hyp_va(&current->thread.uw.fpmr);
> +	fpsimd_save_and_flush_cpu_state();
> +	*host_data_ptr(fp_owner) = FP_STATE_FREE;
> +	*host_data_ptr(fpsimd_state) = NULL;
> +	*host_data_ptr(fpmr_ptr) = NULL;
>  
>  	host_data_clear_flag(HOST_SVE_ENABLED);
>  	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
> @@ -73,23 +75,6 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
>  		host_data_clear_flag(HOST_SME_ENABLED);
>  		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
>  			host_data_set_flag(HOST_SME_ENABLED);
> -
> -		/*
> -		 * If PSTATE.SM is enabled then save any pending FP
> -		 * state and disable PSTATE.SM. If we leave PSTATE.SM
> -		 * enabled and the guest does not enable SME via
> -		 * CPACR_EL1.SMEN then operations that should be valid
> -		 * may generate SME traps from EL1 to EL1 which we
> -		 * can't intercept and which would confuse the guest.
> -		 *
> -		 * Do the same for PSTATE.ZA in the case where there
> -		 * is state in the registers which has not already
> -		 * been saved, this is very unlikely to happen.
> -		 */
> -		if (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)) {
> -			*host_data_ptr(fp_owner) = FP_STATE_FREE;
> -			fpsimd_save_and_flush_cpu_state();
> -		}
>  	}
>  
>  	/*


