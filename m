Return-Path: <stable+bounces-165082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043E8B14F80
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8BA3A5780
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53C1E8333;
	Tue, 29 Jul 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EdiT7q95"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB302AF07
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800410; cv=none; b=t9briuSOA6g1p4Nm8GVkotJrUeDGR0e/JcUpvYTjPBWZV+XE7m7MFMrrxH497VC6fgg2GkCzKfOQ50xhCTsOCWsJvFH5cOc/NA1W+Pimd0H9QLPJWfAlEjnVzcNjX+AYb+DtU4uZfJ++Z1upJdlH+s/8+N90K3AsBeCqj6VCPmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800410; c=relaxed/simple;
	bh=HGK980yM9ZN+SoY2KQWTRuSNWA9eUQKWGdfBik4mjlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4n+Rx8ul3XqCC2TD16Ux3hCGverSn3GwjU5fEEg0O3IZu0IfbK+stkZNc5QFsF982WgYcUCkyTGnRVrFAKEUcIcAMefdDKGbYD9ph4L03XRS3jzjEswa0naX1gj3XL2dJtZCQ+Q06GPmrvFqzZ0mDwMjF/vrCffg2bYUbO45w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EdiT7q95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F3DC4CEF4;
	Tue, 29 Jul 2025 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753800410;
	bh=HGK980yM9ZN+SoY2KQWTRuSNWA9eUQKWGdfBik4mjlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdiT7q95Pbq3tnsuUmIRfNUgal0jj1xuKep9xojSXyFG0G8ljvbh8gJQ4KiIxXMBh
	 785E0QdQXpvWDfdG9ATkGtsrA0WP4N4Poh6o55O4EQgVSuikWJ9wZmPF9DaHbQLnI2
	 Lnt+5OM/LXQcyyINUeN4BfePNqBGMCXSJP0q7AZk=
Date: Tue, 29 Jul 2025 16:46:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kevin Cheng <chengkev@google.com>
Cc: sashal@kernel.org, stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Jim Mattson <jmattson@google.com>, Yan Zhao <yan.y.zhao@intel.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.12.y v2] KVM: x86: Free vCPUs before freeing VM state
Message-ID: <2025072934-path-slightly-24f2@gregkh>
References: <1753492499-da8df97e@stable.kernel.org>
 <20250728175122.4021478-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728175122.4021478-1-chengkev@google.com>

On Mon, Jul 28, 2025 at 05:51:22PM +0000, Kevin Cheng wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 17bcd714426386fda741a4bccd96a2870179344b ]
> 
> Free vCPUs before freeing any VM state, as both SVM and VMX may access
> VM state when "freeing" a vCPU that is currently "in" L2, i.e. that needs
> to be kicked out of nested guest mode.
> 
> Commit 6fcee03df6a1 ("KVM: x86: avoid loading a vCPU after .vm_destroy was
> called") partially fixed the issue, but for unknown reasons only moved the
> MMU unloading before VM destruction.  Complete the change, and free all
> vCPU state prior to destroying VM state, as nVMX accesses even more state
> than nSVM.
> 
> In addition to the AVIC, KVM can hit a use-after-free on MSR filters:
> 
>   kvm_msr_allowed+0x4c/0xd0
>   __kvm_set_msr+0x12d/0x1e0
>   kvm_set_msr+0x19/0x40
>   load_vmcs12_host_state+0x2d8/0x6e0 [kvm_intel]
>   nested_vmx_vmexit+0x715/0xbd0 [kvm_intel]
>   nested_vmx_free_vcpu+0x33/0x50 [kvm_intel]
>   vmx_free_vcpu+0x54/0xc0 [kvm_intel]
>   kvm_arch_vcpu_destroy+0x28/0xf0
>   kvm_vcpu_destroy+0x12/0x50
>   kvm_arch_destroy_vm+0x12c/0x1c0
>   kvm_put_kvm+0x263/0x3c0
>   kvm_vm_release+0x21/0x30
> 
> and an upcoming fix to process injectable interrupts on nested VM-Exit
> will access the PIC:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000090
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   CPU: 23 UID: 1000 PID: 2658 Comm: kvm-nx-lpage-re
>   RIP: 0010:kvm_cpu_has_extint+0x2f/0x60 [kvm]
>   Call Trace:
>    <TASK>
>    kvm_cpu_has_injectable_intr+0xe/0x60 [kvm]
>    nested_vmx_vmexit+0x2d7/0xdf0 [kvm_intel]
>    nested_vmx_free_vcpu+0x40/0x50 [kvm_intel]
>    vmx_vcpu_free+0x2d/0x80 [kvm_intel]
>    kvm_arch_vcpu_destroy+0x2d/0x130 [kvm]
>    kvm_destroy_vcpus+0x8a/0x100 [kvm]
>    kvm_arch_destroy_vm+0xa7/0x1d0 [kvm]
>    kvm_destroy_vm+0x172/0x300 [kvm]
>    kvm_vcpu_release+0x31/0x50 [kvm]
> 
> Inarguably, both nSVM and nVMX need to be fixed, but punt on those
> cleanups for the moment.  Conceptually, vCPUs should be freed before VM
> state.  Assets like the I/O APIC and PIC _must_ be allocated before vCPUs
> are created, so it stands to reason that they must be freed _after_ vCPUs
> are destroyed.
> 
> Reported-by: Aaron Lewis <aaronlewis@google.com>
> Closes: https://lore.kernel.org/all/20240703175618.2304869-2-aaronlewis@google.com
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-ID: <20250224235542.2562848-2-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Kevin Cheng <chengkev@google.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f378d479fea3f..7f91b11e6f0ec 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12888,11 +12888,11 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>  		mutex_unlock(&kvm->slots_lock);
>  	}
>  	kvm_unload_vcpu_mmus(kvm);
> +	kvm_destroy_vcpus(kvm);
>  	kvm_x86_call(vm_destroy)(kvm);
>  	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
>  	kvm_pic_destroy(kvm);
>  	kvm_ioapic_destroy(kvm);
> -	kvm_destroy_vcpus(kvm);
>  	kvfree(rcu_dereference_check(kvm->arch.apic_map, 1));
>  	kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->srcu, 1));
>  	kvm_mmu_uninit_vm(kvm);
> -- 
> 2.50.1.487.gc89ff58d15-goog
> 
> 

What changed in this v2 version?

confused,

greg k-h

