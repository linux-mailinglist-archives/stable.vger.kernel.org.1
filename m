Return-Path: <stable+bounces-83265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D81599759B
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 21:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B09281FDC
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419911A0BD7;
	Wed,  9 Oct 2024 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ki0k9YSb"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903017BB28
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501962; cv=none; b=YipcHXaU6/EEQ0pB7QWB0T1AW7fX9wvkdAk4RkUvRLIwBp1Eh+jDrTYxZmyWBybtw4qvWgF5+Z+LfWlwtqNp7xPgZco3EjQ8ApD4DriyfLnCUYRULB/YwaVAYkB0bEMhACRIqQ1xWzBroIKrKuB9Xp7XtSdiwoqP1hxuKG4EjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501962; c=relaxed/simple;
	bh=29B4ouze1AMCsi/DEaajUMrZB5tkgFLzr8riHT36tuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGIsobyBmwQAPPIodAQbgqVPtKySpn+MneAwOYpHiDsZvIdA1S6wTl/ulFf0wwgU/Mcv60sb8htlLj9m6ihYDTlEjj7oU9SVBJ4JEIQvL5nwY8CuxSXx1qQy45A4wG0duRduXA7KVqupVcSG871H6cRzNWixeJvwYAFe+/erP00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ki0k9YSb; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Oct 2024 12:25:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728501956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q6tIzhsoWpI8OActtQsa2+WNCC3Oz8pxLk/X6USEkU=;
	b=Ki0k9YSbRb8hPkAO0EtbW+r+z11wP0Mkn1h3zKB6/Yt1r2h8wsoyzKRFz8d5NVwOKTvs9r
	nuKoB7eqIH6esAO9KB7bLjRdjSjtAwwLTOXWRwSKBGZBafB6vEKIsg+6v0Oh7v+X/5FIPz
	VpIHBYoS3XPmsOY27gBS51lyKCk+1Ks=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] KVM: arm64: Don't eagerly teardown the vgic on init error
Message-ID: <ZwbYvHJdOqePYjDf@linux.dev>
References: <20241009183603.3221824-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009183603.3221824-1-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 09, 2024 at 07:36:03PM +0100, Marc Zyngier wrote:
> As there is very little ordering in the KVM API, userspace can
> instanciate a half-baked GIC (missing its memory map, for example)
> at almost any time.
> 
> This means that, with the right timing, a thread running vcpu-0
> can enter the kernel without a GIC configured and get a GIC created
> behind its back by another thread. Amusingly, it will pick up
> that GIC and start messing with the data structures without the
> GIC having been fully initialised.

Huh, I'm definitely missing something. Could you remind me where we open
up this race between KVM_RUN && kvm_vgic_create()?

I'd thought the fact that the latter takes all the vCPU mutexes and
checks if any vCPU in the VM has run would be enough to guard against
such a race, but clearly not...

> Similarly, a thread running vcpu-1 can enter the kernel, and try
> to init the GIC that was previously created. Since this GIC isn't
> properly configured (no memory map), it fails to correctly initialise.
> 
> And that's the point where we decide to teardown the GIC, freeing all
> its resources. Behind vcpu-0's back. Things stop pretty abruptly,
> with a variety of symptoms.  Clearly, this isn't good, we should be
> a bit more careful about this.
> 
> It is obvious that this guest is not viable, as it is missing some
> important part of its configuration. So instead of trying to tear
> bits of it down, let's just mark it as *dead*. It means that any
> further interaction from userspace will result in -EIO. The memory
> will be released on the "normal" path, when userspace gives up.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Anyway, regarless of *how* we got here, it is pretty clear that tearing
things down on the error path is a bad idea. So:

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

> ---
>  arch/arm64/kvm/arm.c            | 3 +++
>  arch/arm64/kvm/vgic/vgic-init.c | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index a0d01c46e4084..b97ada19f06a7 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -997,6 +997,9 @@ static int kvm_vcpu_suspend(struct kvm_vcpu *vcpu)
>  static int check_vcpu_requests(struct kvm_vcpu *vcpu)
>  {
>  	if (kvm_request_pending(vcpu)) {
> +		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
> +			return -EIO;
> +
>  		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
>  			kvm_vcpu_sleep(vcpu);
>  
> diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
> index e7c53e8af3d16..c4cbf798e71a4 100644
> --- a/arch/arm64/kvm/vgic/vgic-init.c
> +++ b/arch/arm64/kvm/vgic/vgic-init.c
> @@ -536,10 +536,10 @@ int kvm_vgic_map_resources(struct kvm *kvm)
>  out:
>  	mutex_unlock(&kvm->arch.config_lock);
>  out_slots:
> -	mutex_unlock(&kvm->slots_lock);
> -
>  	if (ret)
> -		kvm_vgic_destroy(kvm);
> +		kvm_vm_dead(kvm);
> +
> +	mutex_unlock(&kvm->slots_lock);
>  
>  	return ret;
>  }
> -- 
> 2.39.2
> 

-- 
Thanks,
Oliver

