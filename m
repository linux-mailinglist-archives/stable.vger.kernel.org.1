Return-Path: <stable+bounces-188939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F3BFB05D
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349A75859C6
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F52310763;
	Wed, 22 Oct 2025 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eH6He9ef"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B43101A9
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123513; cv=none; b=WHG4hqLKtAHeTrDep2AT28R4dv68l3YrTJG3ye/s6FwHYlxOpq1EvlHk6UCLdDwD638aKGPtUmJEiR3NPKqtSCznundKC4hMZ4xpLB0Jo1wAQ/8jsmp3ZuulHk3O3vrooBH0TD/ZBkwpdOGxjdiSRzQIuK7CPEnWnmUdHghko68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123513; c=relaxed/simple;
	bh=7JPKOUEFVzVdS9+oT3QEARXWQBTXWHUqd5QQt9ZdSJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbLhA8BInHpsOgJ+PhOXzh1QpDzvwfsHLpTJU6n8NHDLC3098zPQ+7DSj4wU8JAjvA2AXbnjkXPNgx7PkkEbqIXP02EeyqqAkCUgRW9ygKmPbUOt+RNt3cEx3Lra7LdDlOmko9xBCG14MCDyhmGNz33Va489D5mVLj61xSIfQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eH6He9ef; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 22 Oct 2025 01:28:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761123499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+NkZdt9/8D7af5xNzbwT8FjO8g/Osa1zwilvJgVf3g=;
	b=eH6He9efJsMwbOixc9RvDFUh8tsZvahvJywM0N3eNmprrRZCBBkDXq2jBQ3ocOdwvuYfLM
	3b7ihsMOCQjAa6kRsba40fG51JDrGwreVRs6AsCj+cSD4n4Tr0dKZNk4rPHWvvpc4r28re
	Fh5DL23t70253d2pgt8vgRpGDTHZ3RA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 6.12 006/136] KVM: arm64: Prevent access to vCPU events
 before init
Message-ID: <aPiVtgLCCbQ9igWp@linux.dev>
References: <20251021195035.953989698@linuxfoundation.org>
 <20251021195036.111716876@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021195036.111716876@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

Hey,

Can you please drop this patch from all but 6.17?

On Tue, Oct 21, 2025 at 09:49:54PM +0200, Greg Kroah-Hartman wrote:

[...]

> Cc: stable@vger.kernel.org # 6.17

FWIW, I called this out here.

Thanks,
Oliver

> Fixes: b7b27facc7b5 ("arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS")
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm64/kvm/arm.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1760,6 +1760,9 @@ long kvm_arch_vcpu_ioctl(struct file *fi
>  	case KVM_GET_VCPU_EVENTS: {
>  		struct kvm_vcpu_events events;
>  
> +		if (!kvm_vcpu_initialized(vcpu))
> +			return -ENOEXEC;
> +
>  		if (kvm_arm_vcpu_get_events(vcpu, &events))
>  			return -EINVAL;
>  
> @@ -1771,6 +1774,9 @@ long kvm_arch_vcpu_ioctl(struct file *fi
>  	case KVM_SET_VCPU_EVENTS: {
>  		struct kvm_vcpu_events events;
>  
> +		if (!kvm_vcpu_initialized(vcpu))
> +			return -ENOEXEC;
> +
>  		if (copy_from_user(&events, argp, sizeof(events)))
>  			return -EFAULT;
>  
> 
> 

