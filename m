Return-Path: <stable+bounces-242704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMNULkc592nudgIAu9opvQ
	(envelope-from <stable+bounces-242704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:02:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA04B56EF
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B68CE3007656
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35435AC25;
	Sun,  3 May 2026 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HcBrcTYv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06B282F10
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777809730; cv=none; b=hvVlFyKNVrHIUKtorhSfYXKSczomwyAmfkWQDxHLKyETqza8CYKlsTI2ofzA41yWKoGrkHRb+ImnwowHawSEki0aGcSC25sblDgMe1oVmyCZpaCUHtnU/MNBPAw6orefbi2XLW/zML8LKBLcQRiww82zN6i68dHG7UjsK12rVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777809730; c=relaxed/simple;
	bh=LyrE5+V/X6yG6c1W6JCofFC6dG6XKjaWtXhyF4j25Pg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dOjfp8V/McCGKxoH4ZEA8iB5n8njmzAB2A7DnqI2slwo1ozBrF68Qvdt7/3ziWH9V8gwwacxmEKWrx9refnPwplaeTLFFrRu96afN5p02Ac32g1oMmPeT1DqcVjR6A7Aec9uYfPn9T1lq4pUVdQcvFRxBW3joZH0jmSmuIyJf3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HcBrcTYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33DCC2BCB4;
	Sun,  3 May 2026 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777809730;
	bh=LyrE5+V/X6yG6c1W6JCofFC6dG6XKjaWtXhyF4j25Pg=;
	h=Subject:To:Cc:From:Date:From;
	b=HcBrcTYvpyVcd2Slqj5mDgmmZ1C3jA+Zxu+I9rDRU+jVXqqOgZwi9K3ds5myBhNAp
	 hcfMvQc2RizaEeduPJly4Z7C/R1sNvdzgB3ZRb3dtc49jbP82WtUTJWVbXE32qARrX
	 oeb1RbFrNvFmy3fShz1fO2/vC/eAZckPiGFuJ++M=
Subject: FAILED: patch "[PATCH] KVM: SVM: Add missing save/restore handling of LBR MSRs" failed to apply to 6.12-stable tree
To: yosry@kernel.org,jmattson@google.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:02:07 +0200
Message-ID: <2026050307-acclaim-marauding-3923@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 32FA04B56EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242704-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3700f0788da6acf73b2df56690f4b201aa4aefd2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050307-acclaim-marauding-3923@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3700f0788da6acf73b2df56690f4b201aa4aefd2 Mon Sep 17 00:00:00 2001
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

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9c64d036e30b..2b1066ce23f5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1099,6 +1099,11 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
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
index 7170f2f623af..e97c56df41f6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2787,19 +2787,19 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
+		msr_info->data = lbrv ? svm->vmcb->save.last_excp_from : 0;
 		break;
 	case MSR_IA32_LASTINTTOIP:
-		msr_info->data = svm->vmcb->save.last_excp_to;
+		msr_info->data = lbrv ? svm->vmcb->save.last_excp_to : 0;
 		break;
 	case MSR_VM_HSAVE_PA:
 		msr_info->data = svm->nested.hsave_msr;
@@ -3074,6 +3074,38 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
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


