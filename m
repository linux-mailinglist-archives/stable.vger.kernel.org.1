Return-Path: <stable+bounces-195428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D821BC7692B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 00:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C8FA528D2D
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4162D8779;
	Thu, 20 Nov 2025 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EbVdCBFR"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF62E62A9
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763680062; cv=none; b=b9chxdzC69ihg+xkZOVvIT1p/oDbQOAAz0Sn47NopkPADRmLXhpTrcrw+oOQ3zpsUKRF4l/ECJeHKmIrfydjtefh57tgParsI5t8LYqbhwakheveJj47S1gj9tsJcV+N1XflctxARYCnoul34foBAJ+DO73jgKxP1oJJt2Yu6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763680062; c=relaxed/simple;
	bh=JPgc7fxC461ZQVkZ+wKNwBc/Fc46K40bnVfB2rRr5BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjf+pMcR2weXLntYef7UF80Zz404PNhwlwgPkZ/GQW/40qSNvczz6OwcSBThnKkT5rJzG6iehoAMlPAI93X4VAL/EiBGad5643h7QgE60tzTAl1YBU7jzV3D3QGTlOBaLKGY/aHbzlIo0w3cq080Y6AYQXFPBKLfpQXv6fV/tL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EbVdCBFR; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Nov 2025 23:07:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763680055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NFV1jBslup2HibKrj+0IdK/PXVX5WPeuK6i5VCMIRVQ=;
	b=EbVdCBFR1hMr4msMn63XfXURwb/Yotp/Todw2lTL4KH29LiFpdEaiWgU7spQaSFBlTZ1g+
	qO0Am7tctvwbw3pNLPJD4FX0FteS5J0WDVTa5MVlXnYnOnxxfgt/g1IpawsGBJTdAJXV6g
	+4g+uJjiQOLVm5DSz1bxE3Z4fkCh6OE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Matteo Rizzo <matteorizzo@google.com>, 
	evn@google.com, Jim Mattson <jmattson@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.1.y] KVM: SVM: Mark VMCB_LBR dirty when
 MSR_IA32_DEBUGCTLMSR is updated
Message-ID: <zt2n54fpetzwtnokaarbx75zvybop5sdbhjy7xbjyblhf3q5pj@k3kzyyv7csac>
References: <2025112036-abdominal-envelope-7ca0@gregkh>
 <20251120180655.1918545-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120180655.1918545-1-sashal@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 20, 2025 at 01:06:55PM -0500, Sasha Levin wrote:
> From: Yosry Ahmed <yosry.ahmed@linux.dev>
> 
> [ Upstream commit dc55b3c3f61246e483e50c85d8d5366f9567e188 ]
> 
> The APM lists the DbgCtlMsr field as being tracked by the VMCB_LBR clean
> bit.  Always clear the bit when MSR_IA32_DEBUGCTLMSR is updated.
> 
> The history is complicated, it was correctly cleared for L1 before
> commit 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when
> L2 is running").  At that point svm_set_msr() started to rely on
> svm_update_lbrv() to clear the bit, but when nested virtualization
> is enabled the latter does not always clear it even if MSR_IA32_DEBUGCTLMSR
> changed. Go back to clearing it directly in svm_set_msr().
> 
> Fixes: 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running")
> Reported-by: Matteo Rizzo <matteorizzo@google.com>
> Reported-by: evn@google.com
> Co-developed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Link: https://patch.msgid.link/20251108004524.1600006-2-yosry.ahmed@linux.dev
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [ Open coded svm_get_lbr_vmcb() call ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kvm/svm/svm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f56dcbbbf7341..00fb1c18e23a8 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3053,11 +3053,17 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		if (data & DEBUGCTL_RESERVED_BITS)
>  			return 1;
>  
> -		if (svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK)
> +		if (svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) {
> +			if (svm->vmcb->save.dbgctl == data)
> +				break;
>  			svm->vmcb->save.dbgctl = data;
> -		else
> +		} else {
> +			if (svm->vmcb01.ptr->save.dbgctl == data)
> +				break;
>  			svm->vmcb01.ptr->save.dbgctl = data;
> +		}
>  
> +		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);

The patch LGTM, thanks. FWIW, the call to vmcb_mark_dirty() is the real
fix, the above changes are just a microoptimization, so we can just drop
it if we want to keep it simple.

>  		svm_update_lbrv(vcpu);
>  
>  		break;
> -- 
> 2.51.0
> 

