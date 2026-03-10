Return-Path: <stable+bounces-224571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NoOEOh+sGmwjwIAu9opvQ
	(envelope-from <stable+bounces-224571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:28:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBE5257D8E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32A1330D9405
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810403EAC8B;
	Tue, 10 Mar 2026 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkLPTygH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENN7Aunw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA13E929B
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174267; cv=none; b=tHRp+JJwN2K6NKkVHBGl08gsOmRJKd3rvnBzjByRt/X0kkD8reA1p5+wWcywAk/3uq/K7DoarIZrztl2zbKLJXcc6iSoCONDahKuKELi5VVKtTfn1bTjcVh37dTFn8xEgOTIav54qK5b96d/jkp7CQWn3Brjhlo0AEAHuSXXeZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174267; c=relaxed/simple;
	bh=JJO5qewKWIqGbxpfcpQoE00DHR/fbyp+xQU2r4R6u5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPraIYjnKCjK76spNvpehNeRmWPyzjQkGi2h5Qry6e4v/ETPUsC/sD9Z0Iqa0Lhs8QF4lrAeTx171l469hm4VcxBwnBiVCmKWg22SXR0mGr4l7B2N8qS15o94o8QTKfaUMt+2rAcfaBwAGmIvp0jDrrJVSsD2mAhK5EKXnhjNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkLPTygH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENN7Aunw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773174262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJ85Lkzx3nSPKz8vbaVq+hpymVq+1ScaQgtLPpniKs4=;
	b=LkLPTygHV/HP4DVQUeK0YijcwFAJCa3WOmhdCU9mE7xN7yyS7Hh7dD8Q7KRAXB7m3qqh5d
	AhQ3cugOVz4PC5HsvK/9oNvtpO1uJ1sYwQknDRJpq0xvfG/zZVkzqDMoCZvdxM/xvvWP86
	hnP+DmJ8IfgbyoJdDbuGKQZWLh6Moik=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-gNiXhBrtPZq2gGlRj8NuFA-1; Tue, 10 Mar 2026 16:24:20 -0400
X-MC-Unique: gNiXhBrtPZq2gGlRj8NuFA-1
X-Mimecast-MFC-AGG-ID: gNiXhBrtPZq2gGlRj8NuFA_1773174259
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439c54e0f6aso186537f8f.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773174259; x=1773779059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ85Lkzx3nSPKz8vbaVq+hpymVq+1ScaQgtLPpniKs4=;
        b=ENN7AunwnuoxQNdjN9tfHrr0HKXiET+Gl7YqtAzhncsOaua049ULloIia0dTfg2/pH
         Vnc6gSGuBaQJ6zb3nYNtPYauC9VO1vlivLVJ3XvDN/RKpWFIokA/TDaiw81jnmgElGGt
         APn4S6+w8+WGLIFyST3Q7Mlg7oqPYFcHfksrab5/mfn+nS24laPkl1e/FrNNvIqyIzeA
         q+iZxg5NoCbp49RZD8ywG1ToovQaASe8xQ/AOSRil/qjQdHzgcMiveHtlcQKU8Dg4JCG
         tP/n6DoMmLEzu5nbGwjh10FQhlP1wXkeXqzrDxTBmmPHcquChGlnGKU7Uk/sBkof8/TV
         QLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174259; x=1773779059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJ85Lkzx3nSPKz8vbaVq+hpymVq+1ScaQgtLPpniKs4=;
        b=dsuJ2DUANnQFkHaBK0IljkSIfGpxWbY8iRB6rGCIYQ5pK5fBxyQDi8xozySJaRGQv/
         wAXXr/9HKWPMmus4bG6cFLq+4CtnD3JQetRqe8JNf55RitqPPFiW070eILIVwSb7rgoU
         qeE7IPjFfRfnM9Jbdq5SfguIqn1ixllIlo/XAAgXH0vm8SI2UrbcaG8Ti+qVRkOtjuqw
         +Ih6uAaunM4v3C3Fp5tH9dVjd5onGZfp7/PB8wrvoxkdF9FEZ8oaABkEc1SBPF0NWNK9
         CIDWQ/4MjgfuhfkCm1TAnU8FxFTnjol4XN0geFERXfVgtliWLD0eduS/j+ia0Vc8PCSt
         9phQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFlVfI+H5v/9fyaTSfZb2SpQYSuQBxYzQfN1hK1LYCcOlhSBnMlua5giWZXG3GquRtN/uaEJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwthY3TyrUPr0ks2Yccy0MosYUfXjefIlHvBez3YTEsjkAqvEh/
	pUW//ri0DNNjoXaZhfzPWKBMJY3h7DMw/Ty8OBPNmAxR6AKWOI3bYF1lALIaiz/sO3zlG5Ab97H
	vvlP/nyDG35TYEaxoUqwkEQbhZWkdKGWFAzv4cr6lS7hKat2BWVDEzZB7IQ==
X-Gm-Gg: ATEYQzy1pcFNEmfmsTnp6p30+KyIc2Lkx5U6HTknE9yhx4wQYZVBA/eNDDbVRwY7DBo
	GmfzAyPHx/2KF6CMLvItbpUsSUsCkMPLDQAWZfaXFUe9s4M+fCmrBO+neAla/4PvKrSN8xjVemH
	NwLywlKCW6Ork2j4rpWNQzZOiBQFYS2L6FDQsNz6REDTpNHELqvroVKXuLSOBuw99yVAY0yvxgo
	CDUpXHfxZMsZGePsoE2udJh5YV9AsXBeiBpnfgh5l0MocPvjMDNDEgBCIN9M3pyXaz1Hd/iyzyX
	h2r9/dAdkD6kN8NdSAPm3iAdscUuS5MP5ua9d1lUDmSJCrdZFi0Axv6Ikgyw695qKWPQcPwkR0Q
	NbuDfpo3+lSv9dyxdzlj6my8nJ/SE/CeP6MxTFp9xqYy3ZqRU+guNmgPutZYVtYh+HGJhwYNoSf
	yBwIjqyGXYycRdOve3bnkOy6CecWE=
X-Received: by 2002:a05:6000:2908:b0:439:b6b3:faa7 with SMTP id ffacd0b85a97d-439f8c10e3dmr43757f8f.28.1773174259357;
        Tue, 10 Mar 2026 13:24:19 -0700 (PDT)
X-Received: by 2002:a05:6000:2908:b0:439:b6b3:faa7 with SMTP id ffacd0b85a97d-439f8c10e3dmr43703f8f.28.1773174258827;
        Tue, 10 Mar 2026 13:24:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3638sm621443f8f.9.2026.03.10.13.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:24:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	xinyang@anthropic.com,
	stable@vger.kernel.org
Subject: [PATCH 1/5] KVM: VMX: check validity of VMCS controls when returning from SMM
Date: Tue, 10 Mar 2026 21:24:10 +0100
Message-ID: <20260310202414.406078-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310202414.406078-1-pbonzini@redhat.com>
References: <20260310202414.406078-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDBE5257D8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-224571-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,anthropic.com:email]
X-Rspamd-Action: no action

The VMCS12 is not available while in SMM.  However, it can be overwritten
if userspace manages to trigger copy_enlightened_to_vmcs12() - for example
via KVM_GET_NESTED_STATE.

Because of this, the VMCS12 has to be checked for validity before it is
used to generate the VMCS02.  Move the check code out of vmx_set_nested_state()
(the other "not a VMLAUNCH/VMRESUME" path that emulates a nested vmentry)
and reuse it in vmx_leave_smm().

Cc: stable@vger.kernel.org
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 39 +++++++++++++++++++++++++++------------
 arch/x86/kvm/vmx/nested.h |  1 +
 arch/x86/kvm/vmx/vmx.c    |  4 ++++
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index cb925cc53389..d4bc47079809 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6849,13 +6849,34 @@ void vmx_leave_nested(struct kvm_vcpu *vcpu)
 	free_nested(vcpu);
 }
 
+int nested_vmx_check_restored_vmcs12(struct kvm_vcpu *vcpu)
+{
+	enum vm_entry_failure_code ignored;
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+
+	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
+	    vmcs12->vmcs_link_pointer != INVALID_GPA) {
+		struct vmcs12 *shadow_vmcs12 = get_shadow_vmcs12(vcpu);
+
+		if (shadow_vmcs12->hdr.revision_id != VMCS12_REVISION ||
+		    !shadow_vmcs12->hdr.shadow_vmcs)
+			return -EINVAL;
+	}
+
+	if (nested_vmx_check_controls(vcpu, vmcs12) ||
+	    nested_vmx_check_host_state(vcpu, vmcs12) ||
+	    nested_vmx_check_guest_state(vcpu, vmcs12, &ignored))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 				struct kvm_nested_state __user *user_kvm_nested_state,
 				struct kvm_nested_state *kvm_state)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12;
-	enum vm_entry_failure_code ignored;
 	struct kvm_vmx_nested_state_data __user *user_vmx_nested_state =
 		&user_kvm_nested_state->data.vmx[0];
 	int ret;
@@ -6986,25 +7007,20 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	vmx->nested.mtf_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_MTF_PENDING);
 
-	ret = -EINVAL;
 	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
 	    vmcs12->vmcs_link_pointer != INVALID_GPA) {
 		struct vmcs12 *shadow_vmcs12 = get_shadow_vmcs12(vcpu);
 
+		ret = -EINVAL;
 		if (kvm_state->size <
 		    sizeof(*kvm_state) +
 		    sizeof(user_vmx_nested_state->vmcs12) + sizeof(*shadow_vmcs12))
 			goto error_guest_mode;
 
+		ret = -EFAULT;
 		if (copy_from_user(shadow_vmcs12,
 				   user_vmx_nested_state->shadow_vmcs12,
-				   sizeof(*shadow_vmcs12))) {
-			ret = -EFAULT;
-			goto error_guest_mode;
-		}
-
-		if (shadow_vmcs12->hdr.revision_id != VMCS12_REVISION ||
-		    !shadow_vmcs12->hdr.shadow_vmcs)
+				   sizeof(*shadow_vmcs12)))
 			goto error_guest_mode;
 	}
 
@@ -7015,9 +7031,8 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 			kvm_state->hdr.vmx.preemption_timer_deadline;
 	}
 
-	if (nested_vmx_check_controls(vcpu, vmcs12) ||
-	    nested_vmx_check_host_state(vcpu, vmcs12) ||
-	    nested_vmx_check_guest_state(vcpu, vmcs12, &ignored))
+	ret = nested_vmx_check_restored_vmcs12(vcpu);
+	if (ret < 0)
 		goto error_guest_mode;
 
 	vmx->nested.dirty_vmcs12 = true;
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index b844c5d59025..213a448104af 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -22,6 +22,7 @@ void nested_vmx_setup_ctls_msrs(struct vmcs_config *vmcs_conf, u32 ept_caps);
 void nested_vmx_hardware_unsetup(void);
 __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *));
 void nested_vmx_set_vmcs_shadowing_bitmap(void);
+int nested_vmx_check_restored_vmcs12(struct kvm_vcpu *vcpu);
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu);
 enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 						     bool from_vmentry);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 48f0e426a8a2..e9fa59e92548 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8540,6 +8540,10 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	}
 
 	if (vmx->nested.smm.guest_mode) {
+		/* Triple fault if the state is invalid.  */
+		if (nested_vmx_check_restored_vmcs12(vcpu) < 0)
+			return 1;
+
 		ret = nested_vmx_enter_non_root_mode(vcpu, false);
 		if (ret)
 			return ret;
-- 
2.53.0


