Return-Path: <stable+bounces-114899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74058A308A3
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191AF16754E
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF771F5420;
	Tue, 11 Feb 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7PeTo+m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D421F4606
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270206; cv=none; b=YMAeERptWvXjhMklBewrRJuJiSH8CX+o0HjUpd9C2eJxaHrF3RVZ+8BhlQqg0nmbd+c/N2hhw/kYIP5/qcORhO/CdyFFDOhwgMAnQC3t4XX2aft8YQrrfEmnw0Zw/OO5/Q6zyGuWAFkRKFisu2858pc8MKTBgGUgVla8bCtTOTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270206; c=relaxed/simple;
	bh=1zu6tZCsh7aYgjU+gNDoFE87fQ7V3td5jRhPpf0IkJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z62rHHeLgI+OiPhkjk/o/QUyiG6lj40XaVkuEMmYgMfKx+Zsp/IZ2SSYHUlf/udRnDvTA59OGg6hEui1nl81HG/ku11NmGWXNIMkihCIyMfog3KDVGekPHhYv/+3+eWdhxmZKkgAjxMe9ItEbOlPvvL1/PkF6t9AH/eSrUKYURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7PeTo+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F66C4CEDD;
	Tue, 11 Feb 2025 10:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739270206;
	bh=1zu6tZCsh7aYgjU+gNDoFE87fQ7V3td5jRhPpf0IkJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7PeTo+mIHLgO6J81jy2uDEEgKkM36ufdVbuMhZ/59KgG5zQ1LJh+QVcxwcwx4yvF
	 ProIcvwKivCw/KPeE+b7gvzH73GuebXeXtowVmkFCQXj6C8iJkRaTw5idJ38nCPLHT
	 IYkO8u/DbQLxcqWAG5mOoAZPW13xQKfoGmCVh+9gILOu8Z3E7OPhr/bXP+kpwa7Bam
	 qRc17nfSTVIK0tiDr+OUh9FMoUQ01c0pHgAATOP12e9XPbtzJY8k5LpMPOPYqRM/wD
	 jb5+W7GB0Yol98C8imPPwB/LeLUcvcne0J/wBA+nQgxT5Tj8ACwd7REbUpj+hmMRVd
	 lrPp0nv59CHGg==
Date: Tue, 11 Feb 2025 10:36:40 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v3 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Message-ID: <20250211103640.GC8653@willie-the-truck>
References: <20250210195226.1215254-1-mark.rutland@arm.com>
 <20250210195226.1215254-9-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210195226.1215254-9-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 10, 2025 at 07:52:26PM +0000, Mark Rutland wrote:
> In non-protected KVM modes, while the guest FPSIMD/SVE/SME state is live on the
> CPU, the host's active SVE VL may differ from the guest's maximum SVE VL:
> 
> * For VHE hosts, when a VM uses NV, ZCR_EL2 contains a value constrained
>   by the guest hypervisor, which may be less than or equal to that
>   guest's maximum VL.
> 
>   Note: in this case the value of ZCR_EL1 is immaterial due to E2H.
> 
> * For nVHE/hVHE hosts, ZCR_EL1 contains a value written by the guest,
>   which may be less than or greater than the guest's maximum VL.
> 
>   Note: in this case hyp code traps host SVE usage and lazily restores
>   ZCR_EL2 to the host's maximum VL, which may be greater than the
>   guest's maximum VL.
> 
> This can be the case between exiting a guest and kvm_arch_vcpu_put_fp().
> If a softirq is taken during this period and the softirq handler tries
> to use kernel-mode NEON, then the kernel will fail to save the guest's
> FPSIMD/SVE state, and will pend a SIGKILL for the current thread.
> 
> This happens because kvm_arch_vcpu_ctxsync_fp() binds the guest's live
> FPSIMD/SVE state with the guest's maximum SVE VL, and
> fpsimd_save_user_state() verifies that the live SVE VL is as expected
> before attempting to save the register state:
> 
> | if (WARN_ON(sve_get_vl() != vl)) {
> |         force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
> |         return;
> | }
> 
> Fix this and make this a bit easier to reason about by always eagerly
> switching ZCR_EL{1,2} at hyp during guest<->host transitions. With this
> happening, there's no need to trap host SVE usage, and the nVHE/nVHE
> __deactivate_cptr_traps() logic can be simplified to enable host access
> to all present FPSIMD/SVE/SME features.
> 
> In protected nVHE/hVHE modes, the host's state is always saved/restored
> by hyp, and the guest's state is saved prior to exit to the host, so
> from the host's PoV the guest never has live FPSIMD/SVE/SME state, and
> the host's ZCR_EL1 is never clobbered by hyp.
> 
> Fixes: 8c8010d69c132273 ("KVM: arm64: Save/restore SVE state for nVHE")
> Fixes: 2e3cf82063a00ea0 ("KVM: arm64: nv: Ensure correct VL is loaded before saving SVE state")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Tested-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kvm/fpsimd.c                 | 30 -------------
>  arch/arm64/kvm/hyp/entry.S              |  5 +++
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 59 +++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c      | 13 +++---
>  arch/arm64/kvm/hyp/nvhe/switch.c        |  6 +--
>  arch/arm64/kvm/hyp/vhe/switch.c         |  4 ++
>  6 files changed, 76 insertions(+), 41 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Thanks for the quick re-spin!

Will

