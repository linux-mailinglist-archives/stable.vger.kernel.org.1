Return-Path: <stable+bounces-222909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E4UOAEQp2k0cwAAu9opvQ
	(envelope-from <stable+bounces-222909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:44:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 553181F4089
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63747319112C
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF1D370D6B;
	Tue,  3 Mar 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0N5afue"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E4370D65
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555842; cv=none; b=t8PEqa/aFsXttt/40Dt1n4NGEIlQ6EBQY10Td2OhqxZQM+d73Z0TKKjQkf2HOP19qAnYSkfm8mwwwDshxF3YBGcmXVIr6H97Wozc1HR4mGDJJTmQYO+F0fZlSyPdRpCSsx7uwOj/NkfQPaeTNzGjOrfruH1EB6UxlxNNj6DKTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555842; c=relaxed/simple;
	bh=ksyFNCnLpx2R/3Ka1zHi5jH5atrJnwlIA432Y3Uh1HQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+R4grH/Nz08cuKMXqNZrAX1/wsAWzY/36b0/VOOtXNqZk1jr8ze1tKdUu/F3ROumc39nBY/u6MLQuOThiFCjWOnOCLERvlHlEV9Q6qjmf3NfWVKS7KZ0hCeWnnYQLzB1BIDmcSHu9N4FSv3nCOL+Wo7bQYHz9MRRJXR55p7eig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0N5afue; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598733bec0so14777348a91.2
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 08:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772555840; x=1773160640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=novcs+7dhq6YmDLM83URYxbR3439otPBMA/8Tuo5VT8=;
        b=J0N5afueJw5dIMbqzTUxvv/4KyROBjaUtllou0DBdgxb02NGfvoqkj6SZq8htq2xcF
         jVKfZA6aTVLzUiapI6Gs4mUk9LvkWEt6XamyoXJ+jMdjJU80PLKDZ4BdjvYnjQfBg78o
         JBGAm/F6yBVtMXmlK8O6YLU3eBLcodFMy9Pu0beG7PF5fWVoCWLUIrs6cUrM+MpuVPp6
         5Ts0mmjNI7EZgzsgw3RwjSms2e3VbinrH37Tat9MTzHYfQJ7fxPqwKJ814/eWKbef80r
         RTc9f6MQUFLiD4L1wqI8TSA091BYf7+C9Z/VhSxcsJ58gzCKbClV1gIGrtrNgdv81Uyg
         YoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772555840; x=1773160640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=novcs+7dhq6YmDLM83URYxbR3439otPBMA/8Tuo5VT8=;
        b=rhnAgFfl75YTyAwQidFAJsNBRBSfBEUG6Hf2MBIuCbBWfzZalVUZEjW5kzbBX7r6Q+
         hzfhxI3bbwcGOT0KKKgUV1LL+ZeAdc2DmZHXETymeouyNcJ1MdBT7wokYaToabkJQp+z
         J0V8GBaN8XlGtEJgghJQvNMpMeqgoJyERI7H1rDN/vWWgJ2nTSlxZMKa4YFrD/QbIoqr
         NLb5Zdy5m9BnBvC+Tuxe2T/y3r9sCDc6vuJ8Mxu/9N2D+8lxYWcgZfM8NW8qpfAyrFdc
         TAnug11ZHy2Jwu4rS/MMFW+QtYQnAf2zISZZym2b3lqRNzbLnHt5e7b+xzep3Bn9w4sD
         zryw==
X-Forwarded-Encrypted: i=1; AJvYcCW+5jZZIj3uK2GLSwE8C9FCMuCGmjeGt7hy/002lETHJuv9qqQwAhhMNHQg/iChG3tkuZGNkEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0l6h43BtQD0bmcvwbR/FIIVCQczwQbhOLEWbZK8nJXSkv2vNV
	3mmzK+X68Ti5Nbobu2yNFMbJ2uHqZcyRfSIy35BPoGnEIBaRiRSDLMWgq64Gear2IFpmReYGcHw
	B22R4Fg==
X-Received: from pjbms20.prod.google.com ([2002:a17:90b:2354:b0:359:8d4a:7276])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:560e:b0:356:1edc:b6e
 with SMTP id 98e67ed59e1d1-35965c4966bmr13310746a91.8.1772555840138; Tue, 03
 Mar 2026 08:37:20 -0800 (PST)
Date: Tue, 3 Mar 2026 08:37:18 -0800
In-Reply-To: <20260303003421.2185681-4-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303003421.2185681-1-yosry@kernel.org> <20260303003421.2185681-4-yosry@kernel.org>
Message-ID: <aacOPmIS7HUtzJA6@google.com>
Subject: Re: [PATCH v7 03/26] KVM: SVM: Add missing save/restore handling of
 LBR MSRs
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 553181F4089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222909-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026, Yosry Ahmed wrote:
> MSR_IA32_DEBUGCTLMSR and LBR MSRs are currently not enumerated by
> KVM_GET_MSR_INDEX_LIST, and LBR MSRs cannot be set with KVM_SET_MSRS. So
> save/restore is completely broken.
> 
> Fix it by adding the MSRs to msrs_to_save_base, and allowing writes to
> LBR MSRs from userspace only (as they are read-only MSRs). Additionally,
> to correctly restore L1's LBRs while L2 is running, make sure the LBRs
> are copied from the captured VMCB01 save area in svm_copy_vmrun_state().
> 
> For VMX, this also adds save/restore handling of KVM_GET_MSR_INDEX_LIST.
> For unspported MSR_IA32_LAST* MSRs, kvm_do_msr_access() should 0 these
> MSRs on userspace reads, and ignore KVM_MSR_RET_UNSUPPORTED on userspace
> writes.
> 
> Fixes: 24e09cbf480a ("KVM: SVM: enable LBR virtualization")
> Cc: stable@vger.kernel.org
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/nested.c |  5 +++++
>  arch/x86/kvm/svm/svm.c    | 24 ++++++++++++++++++++++++
>  arch/x86/kvm/x86.c        |  3 +++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index f7d5db0af69ac..3bf758c9cb85c 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1100,6 +1100,11 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
>  		to_save->isst_addr = from_save->isst_addr;
>  		to_save->ssp = from_save->ssp;
>  	}
> +
> +	if (lbrv) {

Tomato, tomato, but maybe make this

	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {

to capture that this requires nested support.  I can't imagine we'll ever disable
X86_FEATURE_LBRV when nested=1 && lbrv=1, but I don't see any harm in being
paranoid in this case.

> +		svm_copy_lbrs(to_save, from_save);
> +		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
> +	}
>  }
>  
>  void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f52e588317fcf..cb53174583a26 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3071,6 +3071,30 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
>  		svm_update_lbrv(vcpu);
>  		break;
> +	case MSR_IA32_LASTBRANCHFROMIP:

Shouldn't these be gated on lbrv?  If LBRV is truly unsupported, KVM would be
writing "undefined" fields and clearing "unknown" clean bits.

Specifically, if we do:

		if (!lbrv)
			return KVM_MSR_RET_UNSUPPORTED;

then kvm_do_msr_access() will allow writes of '0' from the host, via this code:

	if (host_initiated && !*data && kvm_is_advertised_msr(msr))
		return 0;

And then in the read side, do e.g.:

	msr_info->data = lbrv ? svm->vmcb->save.dbgctl : 0;

to ensure KVM won't feed userspace garbage (the VMCB fields should be '0', but
there's no reason to risk that).

The changelog also needs to call out that kvm_set_msr_common() returns
KVM_MSR_RET_UNSUPPORTED for unhandled MSRs (i.e. for VMX and TDX), and that
kvm_get_msr_common() explicitly zeros the data for MSR_IA32_LASTxxx (because per
b5e2fec0ebc3 ("KVM: Ignore DEBUGCTL MSRs with no effect"), old and crust kernels
would read the MSRs on Intel...).

So all in all (not yet tested), this?  If this is the only issue in the series,
or at least in the stable@ part of the series, no need for a v8 (I've obviously
already done the fixup).

--
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 00:33:57 +0000
Subject: [PATCH] KVM: SVM: Add missing save/restore handling of LBR MSRs

MSR_IA32_DEBUGCTLMSR and LBR MSRs are currently not enumerated by
KVM_GET_MSR_INDEX_LIST, and LBR MSRs cannot be set with KVM_SET_MSRS. So
save/restore is completely broken.

Fix it by adding the MSRs to msrs_to_save_base, and allowing writes to
LBR MSRs from userspace only (as they are read-only MSRs) if LBR
virtualization is enabled.  Additionally, to correctly restore L1's LBRs
while L2 is running, make sure the LBRs are copied from the captured
VMCB01 save area in svm_copy_vmrun_state().

Note, for VMX, this also fixes a flaw where MSR_IA32_DEBUGCTLMSR isn't
reported as an MSR to save/restore.

Note #2, over-reporting MSR_IA32_LASTxxx on Intel is ok, as KVM already
handles unsupported reads and writes thanks to commit b5e2fec0ebc3 ("KVM:
Ignore DEBUGCTL MSRs with no effect") (kvm_do_msr_access() will morph the
unsupported userspace write into a nop).

Fixes: 24e09cbf480a ("KVM: SVM: enable LBR virtualization")
Cc: stable@vger.kernel.org
Reported-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-4-yosry@kernel.org
[sean: guard with lbrv checks, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c |  5 +++++
 arch/x86/kvm/svm/svm.c    | 44 +++++++++++++++++++++++++++++++++------
 arch/x86/kvm/x86.c        |  3 +++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d0faa3e2dc97..d142761ad517 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1098,6 +1098,11 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 		to_save->isst_addr = from_save->isst_addr;
 		to_save->ssp = from_save->ssp;
 	}
+
+	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
+		svm_copy_lbrs(to_save, from_save);
+		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
+	}
 }
 
 void svm_copy_vmloadsave_state(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4649cef966f6..317c8c28443a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2788,19 +2788,19 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = svm->tsc_aux;
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
-		msr_info->data = svm->vmcb->save.dbgctl;
+		msr_info->data = lbrv ? svm->vmcb->save.dbgctl : 0;
 		break;
 	case MSR_IA32_LASTBRANCHFROMIP:
-		msr_info->data = svm->vmcb->save.br_from;
+		msr_info->data = lbrv ? svm->vmcb->save.br_from : 0;
 		break;
 	case MSR_IA32_LASTBRANCHTOIP:
-		msr_info->data = svm->vmcb->save.br_to;
+		msr_info->data = lbrv ? svm->vmcb->save.br_to : 0;
 		break;
 	case MSR_IA32_LASTINTFROMIP:
-		msr_info->data = svm->vmcb->save.last_excp_from;
-		break;
+		msr_info->data = lbrv ? svm->vmcb->save.last_excp_from : 0;
+		breakk;
 	case MSR_IA32_LASTINTTOIP:
-		msr_info->data = svm->vmcb->save.last_excp_to;
+		msr_info->data = lbrv ? svm->vmcb->save.last_excp_to : 0;
 		break;
 	case MSR_VM_HSAVE_PA:
 		msr_info->data = svm->nested.hsave_msr;
@@ -3075,6 +3075,38 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 		svm_update_lbrv(vcpu);
 		break;
+	case MSR_IA32_LASTBRANCHFROMIP:
+		if (!lbrv)
+			return KVM_MSR_RET_UNSUPPORTED;
+		if (!msr->host_initiated)
+			return 1;
+		svm->vmcb->save.br_from = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+		break;
+	case MSR_IA32_LASTBRANCHTOIP:
+		if (!lbrv)
+			return KVM_MSR_RET_UNSUPPORTED;
+		if (!msr->host_initiated)
+			return 1;
+		svm->vmcb->save.br_to = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+		break;
+	case MSR_IA32_LASTINTFROMIP:
+		if (!lbrv)
+			return KVM_MSR_RET_UNSUPPORTED;
+		if (!msr->host_initiated)
+			return 1;
+		svm->vmcb->save.last_excp_from = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+		break;
+	case MSR_IA32_LASTINTTOIP:
+		if (!lbrv)
+			return KVM_MSR_RET_UNSUPPORTED;
+		if (!msr->host_initiated)
+			return 1;
+		svm->vmcb->save.last_excp_to = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+		break;
 	case MSR_VM_HSAVE_PA:
 		/*
 		 * Old kernels did not validate the value written to
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6e87ec52fa06..64da02d1ee00 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -351,6 +351,9 @@ static const u32 msrs_to_save_base[] = {
 	MSR_IA32_U_CET, MSR_IA32_S_CET,
 	MSR_IA32_PL0_SSP, MSR_IA32_PL1_SSP, MSR_IA32_PL2_SSP,
 	MSR_IA32_PL3_SSP, MSR_IA32_INT_SSP_TAB,
+	MSR_IA32_DEBUGCTLMSR,
+	MSR_IA32_LASTBRANCHFROMIP, MSR_IA32_LASTBRANCHTOIP,
+	MSR_IA32_LASTINTFROMIP, MSR_IA32_LASTINTTOIP,
 };
 
 static const u32 msrs_to_save_pmu[] = {

base-commit: 149b996ea367eef39faf82ccba0659a5f3d389ea
--

