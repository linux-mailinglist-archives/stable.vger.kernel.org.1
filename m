Return-Path: <stable+bounces-214574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s/VFAkk6hWn6+QMAu9opvQ
	(envelope-from <stable+bounces-214574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 01:48:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAB8F8C16
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 01:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4E023023D9E
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 00:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123611F130B;
	Fri,  6 Feb 2026 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1fQCi5Hs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB31C84C0
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770338881; cv=none; b=h53thOJA+zW61Gjhwrx7rc6MvfHm/9SqNPsjWHT6dGhyj684Dv4nAUCvfHEltIj6iTsJItXzXswOoebf49KRIl9M/5R0jJvt3at5ChNGTRhEQbKjNJrD6X29nlN5T4dNmZMoF2chumHKi20TmLTNFuIfKsDz1gznA81poX2EO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770338881; c=relaxed/simple;
	bh=u57zmi9QATrJCwGbhOw9adxwygav5ddpIaPs/uKQ4Cs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C0vdH8RewdKPc5as0xp4ZoptbEwyHRz2XTigQhKTvV9p8ohrSTyZEHJ7cDRFGUz1EWl4V2k47FcgsiWn+lRdlJEcfwmKl+4QkXfZM/ckbGqHBAhm6uH9lV30Vo2pEoO4mlMN+DHSfh979oE+oiMmWvkYb38RFpKekdL4/zP4VI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1fQCi5Hs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0f0c7a06eso14530425ad.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 16:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770338881; x=1770943681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=THB1tEnnviDiuh79UQ78u6wkoEDwJvwa95g/THSVKMU=;
        b=1fQCi5HsDP6jPJWu4GI2Nk7GNCeUeg+rTUgYtp1JiGXZI52IkXB+x1BSxFOtbEr5QM
         /NO99FU1+66Aq0OiTYe4fHJhS4NTBoQWWQXzwJ7O5nZMnv0aoRXG+Ofc8MZGle9A/XMM
         uP6T0ymBdKKMIbIem+Ay7GTf136/QEFCxrAfAlvm+4SbRisOcBzxXDcJk6PQbP795snd
         XiLdVMf5ItAXUwHvzHyD4tb3qcnmiB05I2VgTvl3BAHbT5Mo7QP+qOstqr9/N5BnW440
         Q7cTSQZ3o7/XUXbfj7YrNFcoxBar364eDD5Bd2pcVJXHYnRP96Xm2JFDBhwGp8puLVPw
         GvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770338881; x=1770943681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THB1tEnnviDiuh79UQ78u6wkoEDwJvwa95g/THSVKMU=;
        b=c5FXwnP/U9AouxPr+h1nwxj/dVygbDK8ln2WV8cmZYI71xrFM/7rw+SEIdGdUDZVHO
         0WWsNol1Zj6jxiiFme24RciaOp84wdNDSUaRexjgi7+W7QGpxtPLZOhAUjfs8xYg8PxG
         9iAVZBT3Rri5jxbCE4rBI+wYdYDkBwgkKO26wSHhO7YiUQ9zUwvtTHfa+0/37Z3kch/A
         lnRrsAJHNEGiVutJUuqbe5RV3w6+lMkfihtBCCMRxznriJdWD5nHDFKvcDbp2xvQKoSv
         ug1tHFnUyR4m+IdZARvllsH3q0pCEEksb4YnobHH+0KW3WpPzGzBh8Amr0LSMzdyOLTc
         FaZg==
X-Forwarded-Encrypted: i=1; AJvYcCUbMm9Au5QgOCoSs3fyAYHD+CE6s+81tPo/POr7wEjjsGHVRt1H5mbvUAVXwlGJH3W9sa3CN7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDxsz3lp0M+tOfPcPv2cVMN3k8JpdubraynFyfeLNpiUwPwRi
	3wMK7OLU7isdqdht6pyhjrxyi8nYsZ8MOmN4tv5HVGxn+uciy49SvhbkevYjeKc93r3Iecw+hCX
	1g3MlbQ==
X-Received: from plar21.prod.google.com ([2002:a17:902:c7d5:b0:2a7:78b9:f962])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70e:b0:2a9:4bd9:bba1
 with SMTP id d9443c01a7336-2a952256f1fmr9497105ad.52.1770338881089; Thu, 05
 Feb 2026 16:48:01 -0800 (PST)
Date: Thu, 5 Feb 2026 16:47:59 -0800
In-Reply-To: <20260115011312.3675857-14-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115011312.3675857-1-yosry.ahmed@linux.dev> <20260115011312.3675857-14-yosry.ahmed@linux.dev>
Message-ID: <aYU6P2qNEpRVWllL@google.com>
Subject: Re: [PATCH v4 13/26] KVM: nSVM: Unify handling of VMRUN failures with
 proper cleanup
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
	TAGGED_FROM(0.00)[bounces-214574-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 6DAB8F8C16
X-Rspamd-Action: no action

On Thu, Jan 15, 2026, Yosry Ahmed wrote:
> @@ -983,6 +991,8 @@ static void __nested_svm_vmexit(struct vcpu_svm *svm)
>  	struct vmcb *vmcb01 = svm->vmcb01.ptr;
>  	struct kvm_vcpu *vcpu = &svm->vcpu;
>  
> +	WARN_ON_ONCE(is_guest_mode(vcpu));
> +
>  	svm->nested.vmcb12_gpa = 0;
>  	svm->nested.ctl.nested_cr3 = 0;
>  
> @@ -1006,6 +1016,19 @@ static void __nested_svm_vmexit(struct vcpu_svm *svm)
>  		kvm_queue_exception(vcpu, DB_VECTOR);
>  }
>  
> +static void nested_svm_failed_vmrun(struct vcpu_svm *svm, struct vmcb *vmcb12)

I don't love the name.  "fail" has very specific meaning in VMX for VMLAUNCH and
VMRESUME, as VM-Fail is not a VM-Exit, e.g. doesn't load host state from the VMCS.

I also don't love that the name doesn't capture that this is synthesizing a #VMEXIT.
Maybe nested_svm_vmrun_error_vmexit()?  I suppose nested_svm_failed_vmrun_vmexit()
isn't too bad either, as that at least addresses my concerns about conflating it
with VMX's VM-Fail.

> +{
> +	WARN_ON(svm->vmcb == svm->nested.vmcb02.ptr);

WARN_ON_ONCE()

> +
> +	leave_guest_mode(vcpu);

Someone didn't test each patch.  "vcpu" doesn't exist until
"KVM: nSVM: Restrict mapping VMCB12 on nested VMRUN".  Just pass in @vcpu and
@vmcb12, i.e. don't pass @svm and then pull @vcpu back out.

> +	vmcb12->control.exit_code = SVM_EXIT_ERR;
> +	vmcb12->control.exit_code_hi = -1u;
> +	vmcb12->control.exit_info_1 = 0;
> +	vmcb12->control.exit_info_2 = 0;
> +	__nested_svm_vmexit(svm);
> +}

...

> @@ -1224,6 +1232,8 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
>  	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
>  		vmcb01->control.erap_ctl |= ERAP_CONTROL_CLEAR_RAP;
>  
> +	/* VMRUN failures before switching to VMCB02 are handled by nested_svm_failed_vmrun() */

Please don't add comments that just point elsewhere.  They inevitably become
stale, and they don't help the reader understand "why" any of this matters.

E.g. something like

	/*
	 * This helper is intended for use only when KVM synthesizing a #VMEXIT
	 * after a successful nested VMRUN.  All VMRUN consistency checks must
	 * be performed before loading guest state, and so should use the inner
	 * helper.
	 */ 


