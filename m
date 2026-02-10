Return-Path: <stable+bounces-215583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAN8NpuOimmwLwAAu9opvQ
	(envelope-from <stable+bounces-215583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:49:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4834A116145
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39F1D3015C87
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 01:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719FF28466C;
	Tue, 10 Feb 2026 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4l5y/R+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061F285C84
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688150; cv=none; b=TGXhDFHFaGBpn3QIuUiAOEvuLV3U0Kmqpz1vrHoSCQukoVQxb8sXL0R8D2q0V5KqWAGVYNkj20Sr6IoF6ZTn6jt9L5DjQVDkjX3YChG0FTDr0KI4Nq0L/ABnT/f1qWIY82EFEOpHA5SFhtocH/hf5/5v/1o6CjTM4fJSvT6QO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688150; c=relaxed/simple;
	bh=f0M30O36pDWmWBeFmtpq3aPQid16Ebu45oYQtgcZlpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=suacPkedHUax5Azc0jlwkw9EUtQ16cTceIxK2xJ7qjWUbeG9hnk6sO7fOfvh+eCjVpMYZsgRBfdGmCpxE637FHk9f2ILFtavuO8VRm+xM/tCOnlKap0TadnMGsQSzzymJNmDRirsNeN3hUhVqllxpEf+Id3pXkRR1mRk0wx7v+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4l5y/R+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-352e214cce9so301567a91.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 17:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770688148; x=1771292948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZDg23eObk06p2X9aJI9PRi0MksTWlD14nG5Hqvivpw=;
        b=r4l5y/R+gw8r3iNw5TW4MoSHVzV6JEn0ozAyLwIpjMvucCp1WUQ7EDYRFYVBSXbBQB
         rg2ofJYHi4RuR7hNPXhyjCHjHIcrxIyjt/gP9WNykucBhI6h+hnPmPN34+UmsK0toGVW
         lZw0/YfQTscV+w37gxYhLWVvBgXit4cy3VL6UD0oJ6NrHbIuGbLeaJ9SO68QIpkc9Jyd
         u9eJZNiUaNO2PjSHHK/SnI6VYmD4Chgx4qiyIYknjeHXaNVFtkOfa++J7DhRofK7W21O
         YcbY9wnnlE/fVhUy/Q3jJBPlnlP7B3z76D1W0p2Ig8pTgCF4AeAzSF8tRNFO8iCGC10h
         WZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770688148; x=1771292948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZDg23eObk06p2X9aJI9PRi0MksTWlD14nG5Hqvivpw=;
        b=rd2iTJWFQeu1yzGN9P+v1Vop/51LsbFKLFXT20wgokreuczgTNjv25A/xurWWnsfIJ
         8W7uNYRHdBFKHntRws70pMEOGa+T+YJyOdrwrZaT/2PSsEuB31t3KSYNPlxKH2VssOWu
         BR+buch4Wdv1rwaYivXZKqscMYDCt5mWzjOtLQgwr8//TwyOY5mfvbXzzaZ6i4m8vk0E
         n+Ka7n3eh44pgOVgnGl2mXzt7zP+JKo98AvrfLajXW7kOzQq6PDalVzR1Apua5DQ8ZT9
         de1VmOrlCF1dj1fVjxECYC0mAOHTtLWCyOvYOPPvYk2iNgRQ5eR3ATAXqs4TEei6k8cc
         72UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQmAA9bVH386jW3UD4JTGtRQ/m73IP89eHoZ2ux3diXVujAO5CaR1CH7C5QIJZureGs0CzgRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTjTlnXj2qpgdjzynCC+hPZpleDUIDrIXzBAqhdNslsSb8PmNU
	cKQsrZPgQ11NERMLxw5zkHoWDkTK2US6+/U28vknxk+CQDb+PLJMoSm4p3dTFRv2L5jsHEwUsSd
	+tFNGoQ==
X-Received: from pjtf21.prod.google.com ([2002:a17:90a:c295:b0:34a:a9d5:99d6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d86:b0:341:134:a962
 with SMTP id 98e67ed59e1d1-354b3e4c3f3mr9201788a91.28.1770688148074; Mon, 09
 Feb 2026 17:49:08 -0800 (PST)
Date: Mon, 9 Feb 2026 17:49:06 -0800
In-Reply-To: <20260210005449.3125133-2-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260210005449.3125133-1-yosry.ahmed@linux.dev> <20260210005449.3125133-2-yosry.ahmed@linux.dev>
Message-ID: <aYqOkvHs3L-AX-CG@google.com>
Subject: Re: [PATCH 1/4] KVM: nSVM: Sync next_rip to cached vmcb12 after VMRUN
 of L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215583-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4834A116145
X-Rspamd-Action: no action

On Tue, Feb 10, 2026, Yosry Ahmed wrote:
> After VMRUN in guest mode, nested_sync_control_from_vmcb02() syncs
> fields written by the CPU from vmcb02 to the cached vmcb12. This is
> because the cached vmcb12 is used as the authoritative copy of some of
> the controls, and is the payload when saving/restoring nested state.
> 
> next_rip is also written by the CPU (in some cases) after VMRUN, but is
> not sync'd to cached vmcb12. As a result, it is corrupted after
> save/restore (replaced by the original value written by L1 on nested
> VMRUN). This could cause problems for both KVM (e.g. when injecting a
> soft IRQ) or L1 (e.g. when using next_rip to advance RIP after emulating
> an instruction).
> 
> Fix this by sync'ing next_rip in nested_sync_control_from_vmcb02(). Move
> the call to nested_sync_control_from_vmcb02() (and the entire
> is_guest_mode() block) after svm_complete_interrupts(), as it may update
> next_rip in vmcb02.

I'll give you one guess as to what I would say about bundling changes.  AFAICT,
there is _zero_ reason to move the call nested_sync_control_from_vmcb02() in a
patch tagged for stable@.

> Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
> CC: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c |  6 ++++--
>  arch/x86/kvm/svm/svm.c    | 26 +++++++++++++++-----------
>  2 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index de90b104a0dd..70086ba6497f 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -519,8 +519,10 @@ void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
>  void nested_sync_control_from_vmcb02(struct vcpu_svm *svm)
>  {
>  	u32 mask;
> -	svm->nested.ctl.event_inj      = svm->vmcb->control.event_inj;
> -	svm->nested.ctl.event_inj_err  = svm->vmcb->control.event_inj_err;
> +
> +	svm->nested.ctl.event_inj	= svm->vmcb->control.event_inj;
> +	svm->nested.ctl.event_inj_err	= svm->vmcb->control.event_inj_err;
> +	svm->nested.ctl.next_rip	= svm->vmcb->control.next_rip;

This is all a mess (the existing code).  nested_svm_vmexit() does this:

	vmcb12->control.int_state         = vmcb02->control.int_state;
	vmcb12->control.exit_code         = vmcb02->control.exit_code;
	vmcb12->control.exit_info_1       = vmcb02->control.exit_info_1;
	vmcb12->control.exit_info_2       = vmcb02->control.exit_info_2;

	if (!svm_is_vmrun_failure(vmcb12->control.exit_code))
		nested_save_pending_event_to_vmcb12(svm, vmcb12);

	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
		vmcb12->control.next_rip  = vmcb02->control.next_rip;

	vmcb12->control.int_ctl           = svm->nested.ctl.int_ctl;
	vmcb12->control.event_inj         = svm->nested.ctl.event_inj;
	vmcb12->control.event_inj_err     = svm->nested.ctl.event_inj_err;

but then svm_get_nested_state(), by way of nested_copy_vmcb_cache_to_control(),
pulls everything from the cached fields.  Which probably only works because the
only fields that are pulled from vmcb02 nested_svm_vmexit() are never modified
by the CPU.

Actually, I take that back, I have no idea how this code works.  How does e.g.
exit_info_1 not get clobbered on save/restore?

In other words, AFAICT, nested.ctl.int_ctl is special in that KVM needs it to be
up-to-date at all times, *and* it needs to copied back to vmcb12 (or userspace).

Part of me wants to remove these two fields entirely:

	/* cache for control fields of the guest */
	struct vmcb_ctrl_area_cached ctl;

	/*
	 * Note: this struct is not kept up-to-date while L2 runs; it is only
	 * valid within nested_svm_vmrun.
	 */
	struct vmcb_save_area_cached save;

and instead use "full" caches only for the duration of nested_svm_vmrun().  Or
hell, just copy the entire vmcb12 and throw the cached structures in the garbage.
But that'll probably end in a game of whack-a-mole as things get moved back in.

So rather than do something totally drastic, I think we should kill
nested_copy_vmcb_cache_to_control() and replace it with a "save control" flow.
And then have it share code as much code as possible with nested_svm_vmexit(),
and fixup nested_svm_vmexit() to not pull from svm->nested.ctl unnecessarily.
Which, again AFICT, is pretty much limited to int_ctl: either vmcb02 is
authoritative, or KVM shouldn't be updating vmcb12, and so only the "save control"
for KVM_GET_NESTED_STATE needs to copy from the cache to the migrated vmcb12.

That'll probably end up a bit fat for a stable@ patch, so we could do a gross
one-off fix for this issue, and then do cleanups on top.

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5f0136dbdde6..cd5664c65a00 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4435,6 +4435,16 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
        svm_complete_interrupts(vcpu);
 
+       /*
+        * Update the cache after completing interrupts to get an accurate
+        * NextRIP, e.g. when re-injecting a soft interrupt.
+        *
+        * FIXME: Rework svm_get_nested_state() to not pull data from the
+        *        cache (except for maybe int_ctl).
+        */
+       if (is_guest_mode(vcpu))
+               svm->nested.ctl.next_rip = svm->vmcb->control.next_rip;
+
        return svm_exit_handlers_fastpath(vcpu);
 }
 
>  	/* Only a few fields of int_ctl are written by the processor.  */
>  	mask = V_IRQ_MASK | V_TPR_MASK;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 5f0136dbdde6..6d8d4d19455e 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4399,17 +4399,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>  	sync_cr8_to_lapic(vcpu);
>  
>  	svm->next_rip = 0;
> -	if (is_guest_mode(vcpu)) {
> -		nested_sync_control_from_vmcb02(svm);
> -
> -		/* Track VMRUNs that have made past consistency checking */
> -		if (svm->nested.nested_run_pending &&
> -		    !svm_is_vmrun_failure(svm->vmcb->control.exit_code))
> -                        ++vcpu->stat.nested_run;
> -
> -		svm->nested.nested_run_pending = 0;
> -	}
> -
>  	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
>  
>  	/*
> @@ -4435,6 +4424,21 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>  
>  	svm_complete_interrupts(vcpu);
>  
> +	/*
> +	 * svm_complete_interrupts() may update svm->vmcb->control.next_rip,
> +	 * which is sync'd by nested_sync_control_from_vmcb02() below.

Please try to avoid referencing functions and fields in comments.  History has
shown that they almost always become stale.

> +	 */
> +	if (is_guest_mode(vcpu)) {
> +		nested_sync_control_from_vmcb02(svm);
> +
> +		/* Track VMRUNs that have made past consistency checking */
> +		if (svm->nested.nested_run_pending &&
> +		    !svm_is_vmrun_failure(svm->vmcb->control.exit_code))
> +			++vcpu->stat.nested_run;
> +
> +		svm->nested.nested_run_pending = 0;
> +	}
> +
>  	return svm_exit_handlers_fastpath(vcpu);
>  }
>  
> 
> base-commit: e944fe2c09f405a2e2d147145c9b470084bc4c9a
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 

