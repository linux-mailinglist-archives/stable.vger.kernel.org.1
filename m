Return-Path: <stable+bounces-124895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3578AA68955
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C3189C0FB
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD9F253F3F;
	Wed, 19 Mar 2025 10:20:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D772A253B78;
	Wed, 19 Mar 2025 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379622; cv=none; b=GCGxu8BWaHJdgz19gPaexnGTeBzxsU+AKgu35BlnUtuH3GUi0pxcZCGF7NW/ST2Cr6ks2NTP6rxhHGclX/qVAQOrIIsIuf0J/aeiaEb3F/nKj8XThoUB5Y3uJSSyNmpBCI+58RdWACVYJvOzM74cXlMwnQ7yk58XmVV6EYhfr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379622; c=relaxed/simple;
	bh=D4HoGfxXoAX0m0phJHphaYBVTS1GFPTcbc17VtKIm1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMqZ/71OpiK8n3jKDEOBHvsPDGMkKE6FjKvYmxJ8SXATDFtzJ1TsIKc4PJ9zuoH47aDn5olHnvoHxtdESesxfESLJLpSeWvHjus+6CNc0aN8Jr1LiDq1qER8a7dbwjm0PYw4Xx7JRsq8/sO+AdNPPxr6SeRE4s+KohEoWvm4nyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4136512FC;
	Wed, 19 Mar 2025 03:20:27 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BD103F694;
	Wed, 19 Mar 2025 03:20:16 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:20:11 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, Gavin Shan <gshan@redhat.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH 6.12 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Message-ID: <Z9qaW_H9UFqdc1bI@J2N7QTR9R3>
References: <20250314-stable-sve-6-12-v1-0-ddc16609d9ba@kernel.org>
 <20250314-stable-sve-6-12-v1-8-ddc16609d9ba@kernel.org>
 <019afc2d-b047-4e33-971c-7debbbaec84d@redhat.com>
 <86r02tmldh.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r02tmldh.wl-maz@kernel.org>

On Wed, Mar 19, 2025 at 09:15:54AM +0000, Marc Zyngier wrote:
> On Wed, 19 Mar 2025 00:26:14 +0000,
> Gavin Shan <gshan@redhat.com> wrote:
> > On 3/14/25 10:35 AM, Mark Brown wrote:

> > > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > > index 4e757a77322c9efc59cdff501745f7c80d452358..1c8e2ad32e8c396fc4b11d5fec2e86728f2829d9 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > > @@ -5,6 +5,7 @@
> > >    */
> > >     #include <hyp/adjust_pc.h>
> > > +#include <hyp/switch.h>
> > >     #include <asm/pgtable-types.h>
> > >   #include <asm/kvm_asm.h>
> > > @@ -176,8 +177,12 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
> > >   		sync_hyp_vcpu(hyp_vcpu);
> > >   		pkvm_put_hyp_vcpu(hyp_vcpu);
> > >   	} else {
> > > +		struct kvm_vcpu *vcpu = kern_hyp_va(host_vcpu);
> > > +
> > >   		/* The host is fully trusted, run its vCPU directly. */
> > > -		ret = __kvm_vcpu_run(host_vcpu);
> > > +		fpsimd_lazy_switch_to_guest(vcpu);
> > > +		ret = __kvm_vcpu_run(vcpu);
> > > +		fpsimd_lazy_switch_to_host(vcpu);
> > >   	}
> > >   
> > 
> > @host_vcpu should have been hypervisor's linear mapping address in v6.12. It looks
> > incorrect to assume it's a kernel's linear mapping address and convert it (@host_vcpu)
> > to the hypervisor's linear address agin, if I don't miss anything.
> 
> host_vcpu is passed as a parameter to the hypercall, and is definitely
> a kernel address.
> 
> However, at this stage, we have *already* converted it to a HYP VA:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm64/kvm/hyp/nvhe/hyp-main.c?h=linux-6.12.y#n147

That's also the case in v6.13; the earlier conversion was removed in
v6.14-rc1 in commit:

  f7d03fcbf1f48206 ("KVM: arm64: Introduce __pkvm_vcpu_{load,put}()")

... where the code in the 'else' block changed from:

|	ret = __kvm_vcpu_run(host_vcpu);

... to:

	ret = __kvm_vcpu_run(kern_hyp_va(host_vcpu));
|

In the upstream version of this patch, the code here changed from

|	/* The host is fully trusted, run its vCPU directly. */
|	ret = __kvm_vcpu_run(kern_hyp_va(host_vcpu));

... to:

|	struct kvm_vcpu *vcpu = kern_hyp_va(host_vcpu);
|
|	/* The host is fully trusted, run its vCPU directly. */
|	fpsimd_lazy_switch_to_guest(vcpu);
|	ret = __kvm_vcpu_run(vcpu);
|	fpsimd_lazy_switch_to_host(vcpu);

> The result is that this change is turning a perfectly valid HYP VA
> into... something. Odds are that the masking/patching will not mess up
> the address, but this is completely buggy anyway. In general,
> kern_hyp_va() is not an idempotent operation.

IIUC today it *happens* to be idempotent, but as you say that is not
guaranteed to remain the case, and this is definitely a logical bug.

> Thanks for noticing that something was wrong.
> 
> Broonie, can you please look into this?
> 
> Greg, it may be more prudent to unstage this series from 6.12-stable
> until we know for sure this is the only problem.

As above, likewise with the v6.13 version.

I'll go reply there linking to this thread.

Mark.

