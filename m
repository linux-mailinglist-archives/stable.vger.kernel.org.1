Return-Path: <stable+bounces-114686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF91A2F3AD
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DF71883417
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3641F460D;
	Mon, 10 Feb 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsZEiMhY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB101CA84
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205277; cv=none; b=RXACYMWded1bnxwRl5ScU/0ntfYqggcDvY9Ta9EgF9s3OgTkZl7+GQDPLZnc5FBoLTaRXeBHZPRNSewpKzWWjy+JRUCVaXDkRHmaVCZhjnK0TIJbsp6Y6zcVrZNiaTBfw0HvAg18RxwufzfkxpAdN0PFU1nmqXleYHCATgkUIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205277; c=relaxed/simple;
	bh=TlIWjQGJKlEBYE9A3vQa414cBX1UvKjrazPd6Ba6uv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQuhrqt+mxpJyayyxPoLoPrAGAXCA3ydwTJXe23WVhPjAlsKvnlPaWogYLxEkSShGK5lnCB9EfOfj+0yOerUqnTSiBTWV6cxpO3T/nOByXVOnUIvNNQPc4strpw1KZVJ5/DPwIGpxz6mUortNmOQQ1ymqS/FIghxTXp9mwU26/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsZEiMhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81655C4CEDF;
	Mon, 10 Feb 2025 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205276;
	bh=TlIWjQGJKlEBYE9A3vQa414cBX1UvKjrazPd6Ba6uv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsZEiMhYOaUB4/c+LRVfXW8h1xWWk929xFW7Vqyq7hrl+8CI75VtkgQtRsmP9+8++
	 bKGKUpQKMxxErAIT4vKvgYMPXXG9GmxZ9Rh7yeAYdFHrwIEftdOhm/W/xutFpjiiLH
	 C9yLrsmcNFXtWJA7mD4mlG3PZL0lKPlrDXdzl2I1+nKlUH4ONGw0rK8RO54wVM2JSd
	 Cz6YUJxZC13lvt2QGLSLVVIuH4np1El0WLeAVzIGPHsDkzjMwVpQ0NRQ0ce1+eaUR9
	 ffwDbn9s5e1CUldv8IKxTvRy/15huhkC/q7D246M61WZxEu8b9DX4xgy0DiqCjiqbv
	 TvrxwogMAPDEw==
Date: Mon, 10 Feb 2025 16:34:31 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 5/8] KVM: arm64: Refactor CPTR trap deactivation
Message-ID: <20250210163429.GF7568@willie-the-truck>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-6-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206141102.954688-6-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 06, 2025 at 02:10:59PM +0000, Mark Rutland wrote:
> For historical reasons, the VHE and nVHE/hVHE implementations of
> __activate_cptr_traps() pair with a common implementation of
> __kvm_reset_cptr_el2(), which ideally would be named
> __deactivate_cptr_traps().
> 
> Rename __kvm_reset_cptr_el2() to __deactivate_cptr_traps(), and split it
> into separate VHE and nVHE/hVHE variants so that each can be paired with
> its corresponding implementation of __activate_cptr_traps().
> 
> At the same time, fold kvm_write_cptr_el2() into its callers. This
> makes it clear in-context whether a write is made to the CPACR_EL1
> encoding or the CPTR_EL2 encoding, and removes the possibility of
> confusion as to whether kvm_write_cptr_el2() reformats the sysreg fields
> as cpacr_clear_set() does.
> 
> In the nVHE/hVHE implementation of __activate_cptr_traps(), placing the
> sysreg writes within the if-else blocks requires that the call to
> __activate_traps_fpsimd32() is moved earlier, but as this was always
> called before writing to CPTR_EL2/CPACR_EL1, this should not result in a
> functional change.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Will Deacon <will@kernel.org>

[...]

> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 7a2d189176249..5d79f63a4f861 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -39,6 +39,9 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
>  {
>  	u64 val = CPTR_EL2_TAM;	/* Same bit irrespective of E2H */
>  
> +	if (!guest_owns_fp_regs())
> +		__activate_traps_fpsimd32(vcpu);
> +
>  	if (has_hvhe()) {
>  		val |= CPACR_EL1_TTA;
>  
> @@ -47,6 +50,8 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
>  			if (vcpu_has_sve(vcpu))
>  				val |= CPACR_EL1_ZEN;
>  		}
> +
> +		write_sysreg(val, cpacr_el1);
>  	} else {
>  		val |= CPTR_EL2_TTA | CPTR_NVHE_EL2_RES1;
>  
> @@ -61,12 +66,34 @@ static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
>  
>  		if (!guest_owns_fp_regs())
>  			val |= CPTR_EL2_TFP;
> +
> +		write_sysreg(val, cptr_el2);
>  	}
> +}
>  
> -	if (!guest_owns_fp_regs())
> -		__activate_traps_fpsimd32(vcpu);
> +static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = kern_hyp_va(vcpu->kvm);

nit: You could lose the local if you used vcpu_has_sve(vcpu) instead.

However, given that this gets removed _anyway_ when we eagerly switch
ZCR later on:

Acked-by: Will Deacon <will@kernel.org>

Will

