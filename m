Return-Path: <stable+bounces-114681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17EA2F2B3
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725CC166D27
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9E24FBFA;
	Mon, 10 Feb 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XejSj2mP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1024FBE9
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203970; cv=none; b=FbmuFkLgXsKrR+93ugWWjzuj6/mEJEf9NWGh+u44Z776M4Ic612fDy2p0brGRK76MpnlChytp8DrUY+H0ATYqj7gdT9lXTvSB+LzKo7ZKDKtg11HgauDbx8rjRGXY7wdCGYE0D170XzM6LY6eEV0m0pZLhEIv/F7tRTgrFva5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203970; c=relaxed/simple;
	bh=5WIIG4Dg8N8gj/fGw3vBXRm+uKLD8KX6NxcJaL2mvRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHcq/9qZj7tLhSrg5TO+ZHOnsW+emKsc6uibSU0YhY6LY+mxnnPCSh9EcUuXciT/CxxttHEaFWPTa8Hkg8ChpmzjAHgReJKu/071gx6+7buafRQz0kws9ChlFAmyf9PS65be8pibdPUP4w6lYbWY2qY0duagYabOaz5J6eXBVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XejSj2mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BACC4CEE7;
	Mon, 10 Feb 2025 16:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739203969;
	bh=5WIIG4Dg8N8gj/fGw3vBXRm+uKLD8KX6NxcJaL2mvRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XejSj2mPeA5iJGCF6cLB4eMgzTmZMI9yDTMRkFEYzsooB3QizAUfu4ho+Lox8I/L7
	 M0zlMwpjD7zo+vQrt3GFJWvdMX8vVMwopVWrNLuPUj6ElYzUVXqY+Qgx7ehuL2jQ7F
	 9oQO/OEc3DevfiXvFpaZohize5q1OSBt1VOx2msqGg+nq8kPdagGiKWHtm1Zep732Z
	 UOSm/l16/0TFU2634s6SNaQqesRgnJESOmOPgi7Tjp3lUxa0Nz7KSaXaD+K1L1cUU/
	 SVq5PqS7JWVG3LlcYvtR5T6mhhid/0/FJzyHeA1Plzu/aENcyFfsBX9g/brcCqEeRE
	 e1YelJdpctPUQ==
Date: Mon, 10 Feb 2025 16:12:43 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 2/8] KVM: arm64: Remove host FPSIMD saving for
 non-protected KVM
Message-ID: <20250210161242.GC7568@willie-the-truck>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-3-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206141102.954688-3-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 06, 2025 at 02:10:56PM +0000, Mark Rutland wrote:
> Now that the host eagerly saves its own FPSIMD/SVE/SME state,
> non-protected KVM never needs to save the host FPSIMD/SVE/SME state,
> and the code to do this is never used. Protected KVM still needs to
> save/restore the host FPSIMD/SVE state to avoid leaking guest state to
> the host (and to avoid revealing to the host whether the guest used
> FPSIMD/SVE/SME), and that code needs to be retained.
> 
> Remove the unused code and data structures.
> 
> To avoid the need for a stub copy of kvm_hyp_save_fpsimd_host() in the
> VHE hyp code, the nVHE/hVHE version is moved into the shared switch
> header, where it is only invoked when KVM is in protected mode.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h       | 20 +++++-------------
>  arch/arm64/kvm/arm.c                    |  8 -------
>  arch/arm64/kvm/fpsimd.c                 |  2 --
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 25 ++++++++++++++++++++--
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  2 +-
>  arch/arm64/kvm/hyp/nvhe/switch.c        | 28 -------------------------
>  arch/arm64/kvm/hyp/vhe/switch.c         |  8 -------
>  7 files changed, 29 insertions(+), 64 deletions(-)

[...]

> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index f838a45665f26..c5b8a11ac4f50 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -375,7 +375,28 @@ static inline void __hyp_sve_save_host(void)
>  			 true);
>  }
>  
> -static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu);
> +static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Non-protected kvm relies on the host restoring its sve state.
> +	 * Protected kvm restores the host's sve state as not to reveal that
> +	 * fpsimd was used by a guest nor leak upper sve bits.
> +	 */
> +	if (system_supports_sve()) {
> +		__hyp_sve_save_host();
> +
> +		/* Re-enable SVE traps if not supported for the guest vcpu. */
> +		if (!vcpu_has_sve(vcpu))
> +			cpacr_clear_set(CPACR_EL1_ZEN, 0);
> +
> +	} else {
> +		__fpsimd_save_state(host_data_ptr(host_ctxt.fp_regs));
> +	}
> +
> +	if (kvm_has_fpmr(kern_hyp_va(vcpu->kvm)))
> +		*host_data_ptr(fpmr) = read_sysreg_s(SYS_FPMR);
> +}
> +
>  
>  /*
>   * We trap the first access to the FP/SIMD to save the host context and
> @@ -425,7 +446,7 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
>  	isb();
>  
>  	/* Write out the host state if it's in the registers */
> -	if (host_owns_fp_regs())
> +	if (is_protected_kvm_enabled() && host_owns_fp_regs())
>  		kvm_hyp_save_fpsimd_host(vcpu);

I wondered briefly whether this would allow us to clean up the CPACR
handling a little and avoid the conditional SVE trap re-enabling inside
kvm_hyp_save_fpsimd_host() but I couldn't come up with a clean way to
do it without an additional ISB. Hrm.

Anyway, as far as the patch goes:

Acked-by: Will Deacon <will@kernel.org>

Will

