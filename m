Return-Path: <stable+bounces-242775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A3GRO7Q992lKdwIAu9opvQ
	(envelope-from <stable+bounces-242775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:21:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CDB4B5AE1
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1DA830071EF
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2382C39936E;
	Sun,  3 May 2026 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g2RPQ9rl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC39D16A956
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810863; cv=none; b=eCni7UL7wt1R15owaVtgtLkDZ6wKlVnxnDbIomB+gbshHxrPZxoA+XZ+RSij/NoniLHFy72aLj518iuDjNIQ9PbtowC4PSZgE4XIfpKYTHOX0p5IvOrGJvjSET6ETpsr3FSx9jS7zpoIzQMvDokoIRjwUPK1cq4KrZ+byFnjTXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810863; c=relaxed/simple;
	bh=nFuVaN6ue016mMgEs2yyQcA9vZeE+tnLicBPjftYm6M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u1eLRATeLdJrNY1SKjuzMICbV9KQmGcyf7dfFe8MUUdg8uUnAzMXZTQSX599TkRfAlFrMOUlR5A1rA5EUY5Ozw6Ss4PD6LJ4OtRQnHec4RmM4yJHBTmFLEJ8qIdK33H38zd2R//NNcD+AqKYsoceqo8OWUT5aMCf5nIh7peJLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g2RPQ9rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36771C2BCB4;
	Sun,  3 May 2026 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777810863;
	bh=nFuVaN6ue016mMgEs2yyQcA9vZeE+tnLicBPjftYm6M=;
	h=Subject:To:Cc:From:Date:From;
	b=g2RPQ9rllUsum1nQeKY9r5S/gFJuJP2my/5nHCaUi6ehcH3A3nxP5did2y8aF1YfI
	 pvIpduiGxXaculzaoxVBpQCpG17UxstewGYb0GoRP5D6RpWhD/hI/sZEQ/7qUbB79l
	 eUxjdFGtXyH0y38ETejU72cE3qbekjeZ7ZQnuETo=
Subject: FAILED: patch "[PATCH] KVM: nSVM: Add missing consistency check for EVENTINJ" failed to apply to 7.0-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:20:45 +0200
Message-ID: <2026050345-yam-spectacle-5c4b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43CDB4B5AE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242775-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email]


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 7e79f71bca5cf536f92effc7227bd044c2722c11
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050345-yam-spectacle-5c4b@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e79f71bca5cf536f92effc7227bd044c2722c11 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Mar 2026 00:34:11 +0000
Subject: [PATCH] KVM: nSVM: Add missing consistency check for EVENTINJ
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to the APM Volume #2, 15.20 (24593—Rev. 3.42—March 2024):

  VMRUN exits with VMEXIT_INVALID error code if either:
  • Reserved values of TYPE have been specified, or
  • TYPE = 3 (exception) has been specified with a vector that does not
    correspond to an exception (this includes vector 2, which is an NMI,
    not an exception).

Add the missing consistency checks to KVM. For the second point, inject
VMEXIT_INVALID if the vector is anything but the vectors defined by the
APM for exceptions. Reserved vectors are also considered invalid, which
matches the HW behavior. Vector 9 (i.e. #CSO) is considered invalid
because it is reserved on modern CPUs, and according to LLMs no CPUs
exist supporting SVM and producing #CSOs.

Defined exceptions could be different between virtual CPUs as new CPUs
define new vectors. In a best effort to dynamically define the valid
vectors, make all currently defined vectors as valid except those
obviously tied to a CPU feature: SHSTK -> #CP and SEV-ES -> #VC. As new
vectors are defined, they can similarly be tied to corresponding CPU
features.

Invalid vectors on specific (e.g. old) CPUs that are missed by KVM
should be rejected by HW anyway.

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
CC: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-18-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 50180565bcfc..1c5f0f08bb8c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -339,6 +339,54 @@ static bool nested_svm_check_bitmap_pa(struct kvm_vcpu *vcpu, u64 pa, u32 size)
 	    kvm_vcpu_is_legal_gpa(vcpu, addr + size - 1);
 }
 
+static bool nested_svm_event_inj_valid_exept(struct kvm_vcpu *vcpu, u8 vector)
+{
+	/*
+	 * Vectors that do not correspond to a defined exception are invalid
+	 * (including #NMI and reserved vectors). In a best effort to define
+	 * valid exceptions based on the virtual CPU, make all exceptions always
+	 * valid except those obviously tied to a CPU feature.
+	 */
+	switch (vector) {
+	case DE_VECTOR: case DB_VECTOR: case BP_VECTOR: case OF_VECTOR:
+	case BR_VECTOR: case UD_VECTOR: case NM_VECTOR: case DF_VECTOR:
+	case TS_VECTOR: case NP_VECTOR: case SS_VECTOR: case GP_VECTOR:
+	case PF_VECTOR: case MF_VECTOR: case AC_VECTOR: case MC_VECTOR:
+	case XM_VECTOR: case HV_VECTOR: case SX_VECTOR:
+		return true;
+	case CP_VECTOR:
+		return guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
+	case VC_VECTOR:
+		return guest_cpu_cap_has(vcpu, X86_FEATURE_SEV_ES);
+	}
+	return false;
+}
+
+/*
+ * According to the APM, VMRUN exits with SVM_EXIT_ERR if SVM_EVTINJ_VALID is
+ * set and:
+ * - The type of event_inj is not one of the defined values.
+ * - The type is SVM_EVTINJ_TYPE_EXEPT, but the vector is not a valid exception.
+ */
+static bool nested_svm_check_event_inj(struct kvm_vcpu *vcpu, u32 event_inj)
+{
+	u32 type = event_inj & SVM_EVTINJ_TYPE_MASK;
+	u8 vector = event_inj & SVM_EVTINJ_VEC_MASK;
+
+	if (!(event_inj & SVM_EVTINJ_VALID))
+		return true;
+
+	if (type != SVM_EVTINJ_TYPE_INTR && type != SVM_EVTINJ_TYPE_NMI &&
+	    type != SVM_EVTINJ_TYPE_EXEPT && type != SVM_EVTINJ_TYPE_SOFT)
+		return false;
+
+	if (type == SVM_EVTINJ_TYPE_EXEPT &&
+	    !nested_svm_event_inj_valid_exept(vcpu, vector))
+		return false;
+
+	return true;
+}
+
 static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 				       struct vmcb_ctrl_area_cached *control)
 {
@@ -364,6 +412,9 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 		return false;
 	}
 
+	if (CC(!nested_svm_check_event_inj(vcpu, control->event_inj)))
+		return false;
+
 	return true;
 }
 


