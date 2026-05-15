Return-Path: <stable+bounces-248159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ELIEUFIB2qrwQIAu9opvQ
	(envelope-from <stable+bounces-248159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:22:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF35531C0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85BEC3115268
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0B03E7BC0;
	Fri, 15 May 2026 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ypf9YDw3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B83FF1AD;
	Fri, 15 May 2026 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861022; cv=none; b=EvoGUxSlMbYfcgSH9WFEy9bdOLkrA83rzOKVvoBvSf0y07X8gAsDi91BivXZ5LL4I9nd0bfJPmrzfw/V+3HtwaPEb1Tg3OuHsBF5plXwP3r/qaGuTFUW6TEpl9butH6J+ywx2gDWN9ZMiVPBMwZl527J3VPDd4klEMFlsNZG2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861022; c=relaxed/simple;
	bh=k9Vx94vH1fn4o+Sqay+LLGG9ZsOsTyYZVlSoOXR0SzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0lmGIShIDfHouelEL6S8QcHqK216/hWibe6DC8ebQcqGmkFkPg8AxByUFMia8wF8oYRwrcHzXAPbZwLplVDakSyhj846rs6/pYvT8IWX0dXCRAnAqfV2gYxVJk0Jk1qReMWCgNHh7AKTxpWoISyIgiKO2eyXN39BsVnLk4vIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ypf9YDw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BDDC2BCB0;
	Fri, 15 May 2026 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861022;
	bh=k9Vx94vH1fn4o+Sqay+LLGG9ZsOsTyYZVlSoOXR0SzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ypf9YDw30IKm8COUM213FuL29mjBVXJd80eHK+SCovaHcM9etWpiM606qrNQVQnde
	 2iT3tF0aOw2LdSfPBQgYUZmMdPYw3iyEYmcINGh2BqHyth1YMAamTt5cuNEw8umxqx
	 5pceRDpTCtzGouPcm2WS9Vz5/s6VxsxVKvLbKVxQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.6 170/474] KVM: SVM: check validity of VMCB controls when returning from SMM
Date: Fri, 15 May 2026 17:44:39 +0200
Message-ID: <20260515154718.701193930@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8CF35531C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248159-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit be5fa8737d42c5ba16d2ea72c23681f8abbb07e8 upstream.

The VMCB12 is stored in guest memory and can be mangled while in SMM; it
is then reloaded by svm_leave_smm(), but it is not checked again for
validity.

Move the cached vmcb12 control and save consistency checks out of
svm_set_nested_state() and into a helper, and reuse it in
svm_leave_smm().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |   12 ++++++++++--
 arch/x86/kvm/svm/svm.c    |    4 ++++
 arch/x86/kvm/svm/svm.h    |    1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -415,6 +415,15 @@ void nested_copy_vmcb_save_to_cache(stru
 	__nested_copy_vmcb_save_to_cache(&svm->nested.save, save);
 }
 
+int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
+{
+	if (!nested_vmcb_check_save(vcpu) ||
+	    !nested_vmcb_check_controls(vcpu))
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * Synchronize fields that are written by the processor, so that
  * they can be copied back into the vmcb12.
@@ -888,8 +897,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vc
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 
-	if (!nested_vmcb_check_save(vcpu) ||
-	    !nested_vmcb_check_controls(vcpu)) {
+	if (nested_svm_check_cached_vmcb12(vcpu) < 0) {
 		vmcb12->control.exit_code    = SVM_EXIT_ERR;
 		vmcb12->control.exit_code_hi = -1u;
 		vmcb12->control.exit_info_1  = 0;
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4817,6 +4817,10 @@ static int svm_leave_smm(struct kvm_vcpu
 	vmcb12 = map.hva;
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
+
+	if (nested_svm_check_cached_vmcb12(vcpu) < 0)
+		goto unmap_save;
+
 	ret = enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, vmcb12, false);
 
 	if (ret)
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -612,6 +612,7 @@ static inline int nested_svm_simple_vmex
 
 int nested_svm_exit_handled(struct vcpu_svm *svm);
 int nested_svm_check_permissions(struct kvm_vcpu *vcpu);
+int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu);
 int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
 			       bool has_error_code, u32 error_code);
 int nested_svm_exit_special(struct vcpu_svm *svm);



