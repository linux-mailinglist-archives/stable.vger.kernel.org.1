Return-Path: <stable+bounces-217334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOBWNbtVlmnrdwIAu9opvQ
	(envelope-from <stable+bounces-217334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 01:13:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDF715B168
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 01:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7720D302730E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 00:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FF28634C;
	Thu, 19 Feb 2026 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0XXRhhU2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD962AEE4
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771460013; cv=none; b=u62iUx2Chkt04UxalbEg1t8evgIyVBdrsjiU47LfCpiJ8GG870Y+34xwA/kET2CTbcILU6wsH58/IZZmfO1SqLXkkEIsjpUsos2qRZnuFMVQrJxK+yI3aKH3dI4+tBx/7R9pN2J1jkw/c4QHhHm8rajoCzaoCaPRLVqrjF1JGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771460013; c=relaxed/simple;
	bh=5LBVOhN5/tZsOeO8gtiQtyUGUL6ip3rX4p/O6Jqs8Wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dquSIfMNBl3kftwc2SAYQKd7gcLI40FbZiDbYhQjiY/DHZnQsUI3hQxn3ZLQkIjA4kzBjUwkm9xq0GWLGP18Yo1jvRmp+k/Owo451gk5soACaGesXgxCYLXEZLdQC7KCGD+uQ+jv2BWG70zbjmkYPMiEaRY29FBkg9JcGDRoOOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0XXRhhU2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a944e6336eso20327975ad.0
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 16:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771460011; x=1772064811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jpc3P+bZWaKUUzprm5fVf6tAxsYLg9P8gmiGzeYpTJs=;
        b=0XXRhhU2iXsiF6F6SpySsT4Lno2CHDW9MfgzC4tmCchtLiqDZ1Qkt89zdJRMNrXgbp
         Hjg5e8lMMDSRrZXHEjnqaq+IZO6ZaGOeW0/DUQoVdlbas7Y5wPebpG6EcJJ0fHMd4IVn
         2meVbC7vC2AOvG1w7fdbunCqkgEmoGgzckli3qmSNQCh08DTWVFKtvbr/JgmQEozvHbK
         oaxBql//X5QAbI3rFR7LTVyfcPQ2mLrfP9FfxtjPTGKPV90L0Z9uJoMpIE5+vXsC11sX
         40Pi2DUMP45ZyiUSDFSlt13jzdwjwTqjIdlt2zXoYWNBV8g0d2DQX/Kdmmnv7Yf9+fwp
         Bwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771460011; x=1772064811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jpc3P+bZWaKUUzprm5fVf6tAxsYLg9P8gmiGzeYpTJs=;
        b=dEaNvFLRT6OQxqszAfVIRrhrW129cB72UeRo1q0t8coTHqolM7pU03ySAMyDU45l6O
         piFv63vek5Ag2qyCFgCRQviKQD1Uul4t2RFIyXhbORvAxC4zsW+XqtFoOlQVHr6cHE2b
         rUGl/Y5BfwomdAPjPy739qLftA98LTeKj+ConehP77qnVC1NLXB0tREBfRJDaUOOgjpB
         wGNpPpZKRQfUWYzBm+QMW3u1o/eyiAnXzqqkLnr6k9oX30ceQQJ+mdk9b6j7NgBpaMEG
         9kWztBF3yhhEdDKvBSdbMweJA7Gq1K2EGBHYZHDBEUqcdUAhKEhAfDGZeKSLShVeU8a3
         lB1w==
X-Forwarded-Encrypted: i=1; AJvYcCWIkY+F/m1TnDiY1EYEy+/DPh8M/XBu8WpW13XOtMtqA/LsnwIy+J46Vjv/DFIvrYPOcZTBq1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXT8wMgAH7XKmXrxjMEPcrQiX6YGpEl++D7E2YhZaOBal+PMl
	Rw0jNUBhqVtwtOrJXo9M7jPjLp6yr+bC9C48yj49CFuJ4ZaXHasLRWyx0ET3utuOivfM/kPLWtU
	yG5RkgA==
X-Received: from plsm8.prod.google.com ([2002:a17:902:bb88:b0:2aa:dce0:e741])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc50:b0:295:96bc:8699
 with SMTP id d9443c01a7336-2ad50e9ceadmr34889765ad.20.1771460010649; Wed, 18
 Feb 2026 16:13:30 -0800 (PST)
Date: Wed, 18 Feb 2026 16:13:29 -0800
In-Reply-To: <20260212230751.1871720-5-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260212230751.1871720-1-yosry.ahmed@linux.dev> <20260212230751.1871720-5-yosry.ahmed@linux.dev>
Message-ID: <aZZVqQrQ1iCNJhJJ@google.com>
Subject: Re: [RFC PATCH 4/5] KVM: SVM: Recalculate nested RIPs after restoring REGS/SREGS
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217334-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EDF715B168
X-Rspamd-Action: no action

On Thu, Feb 12, 2026, Yosry Ahmed wrote:
> In the save/restore path, if KVM_SET_NESTED_STATE is performed before
> restoring REGS and/or SREGS , the values of CS and RIP used to
> initialize the vmcb02's NextRIP and soft interrupt tracking RIPs are
> incorrect.
> 
> Recalculate them up after CS is set, or REGS are restored. This is only
> needed when a nested run is pending during restore. After L2 runs for
> the first time, any soft interrupts injected by L1 are already delivered
> or tracked by KVM separately for re-injection, so the CS and RIP values
> are no longer relevant.
> 
> If KVM_SET_NESTED_STATE is performed after both REGS and SREGS are
> restored, it will just overwrite the fields.

Apparently I suggested this general idea, but ugh.  :-)

>  static void svm_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
>  {
>  	kvm_register_mark_available(vcpu, reg);
> @@ -1826,6 +1844,8 @@ static void svm_set_segment(struct kvm_vcpu *vcpu,
>  	if (seg == VCPU_SREG_SS)
>  		/* This is symmetric with svm_get_segment() */
>  		svm->vmcb->save.cpl = (var->dpl & 3);
> +	else if (seg == VCPU_SREG_CS)
> +		svm_fixup_nested_rips(vcpu);
>  
>  	vmcb_mark_dirty(svm->vmcb, VMCB_SEG);
>  }
> @@ -5172,6 +5192,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>  	.get_rflags = svm_get_rflags,
>  	.set_rflags = svm_set_rflags,
>  	.get_if_flag = svm_get_if_flag,
> +	.post_user_set_regs = svm_fixup_nested_rips,
>  
>  	.flush_tlb_all = svm_flush_tlb_all,
>  	.flush_tlb_current = svm_flush_tlb_current,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index db3f393192d9..35fe1d337273 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12112,6 +12112,8 @@ static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>  	kvm_rip_write(vcpu, regs->rip);
>  	kvm_set_rflags(vcpu, regs->rflags | X86_EFLAGS_FIXED);
>  
> +	kvm_x86_call(post_user_set_regs)(vcpu);

I especially don't love this callback.  Aside from adding a new kvm_x86_ops hook,
I don't like that _any_ CS change triggers a fixup, whereas only userspace writes
to RIP trigger a fixup.  That _should_ be a moot point, because neither CS nor RIP
should change while nested_run_pending is true, but I dislike the asymmetry.

I was going to suggest we instead react to RIP being dirty, but what if we take
it a step further?  Somewhat of a crazy idea, but what happens if we simply wait
until just before VMRUN to set soft_int_csbase, soft_int_old_rip, and
soft_int_next_rip (when the guest doesn't have NRIPS)?

E.g. after patch 2, completely untested...

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index aec17c80ed73..6fc1b2e212d2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -863,12 +863,9 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
        svm->nmi_l1_to_l2 = is_evtinj_nmi(vmcb02->control.event_inj);
        if (is_evtinj_soft(vmcb02->control.event_inj)) {
                svm->soft_int_injected = true;
-               svm->soft_int_csbase = vmcb12_csbase;
-               svm->soft_int_old_rip = vmcb12_rip;
+
                if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
                        svm->soft_int_next_rip = svm->nested.ctl.next_rip;
-               else
-                       svm->soft_int_next_rip = vmcb12_rip;
        }
 
        /* LBR_CTL_ENABLE_MASK is controlled by svm_update_lbrv() */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8f8bc863e214..358ec940ffc9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4322,6 +4322,14 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
                return EXIT_FASTPATH_EXIT_USERSPACE;
        }
 
+       if (is_guest_mode(vcpu) && svm->nested.nested_run_pending &&
+           svm->soft_int_injected) {
+               svm->soft_int_csbase = svm->vmcb->save.cs.base;
+               svm->soft_int_old_rip = kvm_rip_read(vcpu);
+               if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
+                       svm->soft_int_next_rip = kvm_rip_read(vcpu);
+       }
+
        sync_lapic_to_cr8(vcpu);
 
        if (unlikely(svm->asid != svm->vmcb->control.asid)) {

