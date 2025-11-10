Return-Path: <stable+bounces-192985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B9C48FBD
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 20:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 295ED4E7228
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 19:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F732B98F;
	Mon, 10 Nov 2025 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zt85dsqR"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C02FF66D
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802650; cv=none; b=gej1u9rYGrYaT57vju/j+ZJRh+YDr4SnJXZH7A+aAcYhlNKOAeeGU5eRJCTKOhJrpjE/cZlAL9/4XGl9BJRKZkcwZ5OZ2Wl8FHuYqsrUr9Z2uf/CKbC5y/9wReB+gnCuGjaxoiL1LDYW+bZX4WVlBSrQkjlbd6k3d4ZEQQsqx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802650; c=relaxed/simple;
	bh=cPHuYy1Wv4KChFqeJH+AEWpOUMF+PpB+ceAvxNwbR4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq3poQsXp9VB2hZlRRDMeWA/8LTPuJxv75LRcpauQvQ/J20cpNSmKDhrG/HBi/Kvg3cdO9KIN1deZY675IxIfhfS/aygsFVTPwNNBC/w9obKoSdTXjzoLzRJkm8SpIx0xq2cEv97N9bvvJmEmKoisFYQIBKuM9Xkq9Lmwb6Ubmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zt85dsqR; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 19:23:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762802636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOQqHpzs5q+h5Yjbnc6DPZt8+0zjzGikaeAdSf3y5Kg=;
	b=Zt85dsqRh+CYFl2JZ84Z0d5GpmolfFxnYuzQ1yrgjLnTW0O5r3Xqe+FTSyHtRDu7VHMkuz
	kGacCCsp9XHoKNYVMmciAUQgetU+IS1E0ISGouRZwUuBOlYeHma6+eOPWxPkSIAv5MAU/L
	7T000vk8DdXcsxtFq98IvgcE2KaykyM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Jim Mattson <jmattson@google.com>, Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/6] KVM: SVM: Switch svm_copy_lbrs() to a macro
Message-ID: <dyfu7nopxqtdw6k6s37dmq3wedqua2risfgolsltepykffqjkp@ij3ogvhxpvrg>
References: <20251108004524.1600006-1-yosry.ahmed@linux.dev>
 <20251108004524.1600006-5-yosry.ahmed@linux.dev>
 <be2a7126-2abc-4333-b067-75dd16634f13@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2a7126-2abc-4333-b067-75dd16634f13@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 09, 2025 at 08:59:18AM +0100, Paolo Bonzini wrote:
> On 11/8/25 01:45, Yosry Ahmed wrote:
> > In preparation for using svm_copy_lbrs() with 'struct vmcb_save_area'
> > without a containing 'struct vmcb', and later even 'struct
> > vmcb_save_area_cached', make it a macro. Pull the call to
> > vmcb_mark_dirty() out to the callers.
> 
> The changes to use `struct vmcb_save_area_cached' are not included in this
> series, so they are irrelevant.
> 
> Since I've applied patches 1-3, which fix the worst bugs, there are two ways
> to handle the rest:
> 
> * keep the function instead of the macro, while making it take a struct
> vmcb_save_area (and therefore pulling vmcb_mark_dirty() to the callers and
> fixing the bug you mention below).
> 
> * you resubmit with the changes to use struct vmcb_save_area_cached, so that
> the commit message makes more sense.

I can include patches 4-6 with the respin of the series [1] that has the
changes to use `struct vmcb_save_area_cached`. That series origianlly
had the patch to switch svm_copy_lbrs() to a macro, but I moved it here
to use for the save/restore patch. I was planning to rebase [1] on top
of this series anyway.

There is a hiccup though, I assumed everything would go through Sean's
tree so I planned to respin [1] on top of this series. Otherwise, they
will conflict. With the first 3 patches in your tree, I am not sure how
that would work.

I can respin [1] on top of Sean's kvm-x86/next or kvm-x86/svm, but it
will conflict with the patches you picked up eventually, and I already
have them locally on top of the LBR fixes so it seems like wasted
effort.

Sean, Paolo, how do you want to handle this?

[1]https://lore.kernel.org/kvm/20251104195949.3528411-1-yosry.ahmed@linux.dev/

> 
> Thanks,
> 
> Paolo
> 
> > Macros are generally not preferred compared to functions, mainly due to
> > type-safety. However, in this case it seems like having a simple macro
> > copying a few fields is better than copy-pasting the same 5 lines of
> > code in different places.
> > 
> > On the bright side, pulling vmcb_mark_dirty() calls to the callers makes
> > it clear that in one case, vmcb_mark_dirty() was being called on VMCB12.
> > It is not architecturally defined for the CPU to clear arbitrary clean
> > bits, and it is not needed, so drop that one call.
> 
> > Technically fixes the non-architectural behavior of setting the dirty
> > bit on VMCB12.
> > 
> > Fixes: d20c796ca370 ("KVM: x86: nSVM: implement nested LBR virtualization")
> > Cc: stable@vger.kernel.org
> > 
> > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > ---
> >   arch/x86/kvm/svm/nested.c | 16 ++++++++++------
> >   arch/x86/kvm/svm/svm.c    | 11 -----------
> >   arch/x86/kvm/svm/svm.h    | 10 +++++++++-
> >   3 files changed, 19 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index c81005b245222..e7861392f2fcd 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -676,10 +676,12 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
> >   		 * Reserved bits of DEBUGCTL are ignored.  Be consistent with
> >   		 * svm_set_msr's definition of reserved bits.
> >   		 */
> > -		svm_copy_lbrs(vmcb02, vmcb12);
> > +		svm_copy_lbrs(&vmcb02->save, &vmcb12->save);
> > +		vmcb_mark_dirty(vmcb02, VMCB_LBR);
> >   		vmcb02->save.dbgctl &= ~DEBUGCTL_RESERVED_BITS;
> >   	} else {
> > -		svm_copy_lbrs(vmcb02, vmcb01);
> > +		svm_copy_lbrs(&vmcb02->save, &vmcb01->save);
> > +		vmcb_mark_dirty(vmcb02, VMCB_LBR);
> >   	}
> >   	svm_update_lbrv(&svm->vcpu);
> >   }
> > @@ -1186,10 +1188,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
> >   		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
> >   	if (unlikely(guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
> > -		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK)))
> > -		svm_copy_lbrs(vmcb12, vmcb02);
> > -	else
> > -		svm_copy_lbrs(vmcb01, vmcb02);
> > +		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
> > +		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
> > +	} else {
> > +		svm_copy_lbrs(&vmcb01->save, &vmcb02->save);
> > +		vmcb_mark_dirty(vmcb01, VMCB_LBR);
> > +	}
> >   	svm_update_lbrv(vcpu);
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index fc42bcdbb5200..9eb112f0e61f0 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -795,17 +795,6 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
> >   	 */
> >   }
> > -void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
> > -{
> > -	to_vmcb->save.dbgctl		= from_vmcb->save.dbgctl;
> > -	to_vmcb->save.br_from		= from_vmcb->save.br_from;
> > -	to_vmcb->save.br_to		= from_vmcb->save.br_to;
> > -	to_vmcb->save.last_excp_from	= from_vmcb->save.last_excp_from;
> > -	to_vmcb->save.last_excp_to	= from_vmcb->save.last_excp_to;
> > -
> > -	vmcb_mark_dirty(to_vmcb, VMCB_LBR);
> > -}
> > -
> >   static void __svm_enable_lbrv(struct kvm_vcpu *vcpu)
> >   {
> >   	to_svm(vcpu)->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
> > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > index c2acaa49ee1c5..e510c8183bd87 100644
> > --- a/arch/x86/kvm/svm/svm.h
> > +++ b/arch/x86/kvm/svm/svm.h
> > @@ -687,8 +687,16 @@ static inline void *svm_vcpu_alloc_msrpm(void)
> >   	return svm_alloc_permissions_map(MSRPM_SIZE, GFP_KERNEL_ACCOUNT);
> >   }
> > +#define svm_copy_lbrs(to, from)					\
> > +({								\
> > +	(to)->dbgctl		= (from)->dbgctl;		\
> > +	(to)->br_from		= (from)->br_from;		\
> > +	(to)->br_to		= (from)->br_to;		\
> > +	(to)->last_excp_from	= (from)->last_excp_from;	\
> > +	(to)->last_excp_to	= (from)->last_excp_to;		\
> > +})
> > +
> >   void svm_vcpu_free_msrpm(void *msrpm);
> > -void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb);
> >   void svm_enable_lbrv(struct kvm_vcpu *vcpu);
> >   void svm_update_lbrv(struct kvm_vcpu *vcpu);
> Since
> 

