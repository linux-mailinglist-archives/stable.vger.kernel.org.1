Return-Path: <stable+bounces-261368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Flh7GPFIJWpVGAIAu9opvQ
	(envelope-from <stable+bounces-261368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:33:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7F864FC76
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:33:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=N3z7oMz4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261368-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261368-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF4D83011058
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312B31E842;
	Sun,  7 Jun 2026 10:31:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD51FE47B;
	Sun,  7 Jun 2026 10:31:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828281; cv=none; b=gVLjHu+jMsM3AyD2+sTl/zIv7VEF4gUGk2RH2RtEyXUjpG0U6jJqgA5wryZxWaOSBOycwv2hrSlpTWOwGPOeWgVRMODXZZEMP4GksThYFdrbuRXa0Rx1bm2T0Q1aAvUfoYVlCxepFinD9dysNVGKzuWMrH19WfFTvmnVUg7b0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828281; c=relaxed/simple;
	bh=YiQUKA+eUIdtnP2u+RR8N2O7VAbCNjt24X6X1nEcGGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWMZS82eQF1oK2UGVoGn6p8l0kdgaxtv0djBcrrAMZErWVupah/11OfwaKnA9GxX5MGJcnG3c0GfKNZq6o3kQkquyqHtqRsOaHUYfwMUpsmSMZH+XW+gUY3ujlDu4aWz9a4dKO9JVxU2DQXVAZutQHbxPUCV4WAfxC0TYs8VyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N3z7oMz4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8871F00893;
	Sun,  7 Jun 2026 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828280;
	bh=s1iHB3UmF5IyG0XsOJIyMtJAaNLzRevvT4/6WStR2Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N3z7oMz45g4ANYZH8WIpcCMqc54dUWco+TD9Zja+c1d3EzQfAz4pyducfgh2bVFlz
	 MIa1wQCxUOor1ZEnZi9JSuln0FCSAdonywq4RyuEBiAbBJ3eFqyNECJFX+NbLsZoVA
	 CNfNhkjssfxFl3C7n9AomkFtZoD5K4synuxx64Wk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 7.0 169/332] KVM: SEV: Dont explicitly pass PSC buffer to snp_begin_psc()
Date: Sun,  7 Jun 2026 11:58:58 +0200
Message-ID: <20260607095734.272859508@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261368-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:thomas.lendacky@amd.com,m:michael.roth@amd.com,m:seanjc@google.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C7F864FC76

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit ebe4b2dc9cfbfb2d8f665667c4d08f4c6c9bec05 upstream.

Stop explicitly passing the PSC buffer to snp_begin_psc(): it *must*
be the scratch area.  This will allow fixing a variety of bugs without
further complicating the code.

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-9-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3796,7 +3796,7 @@ struct psc_buffer {
 	struct psc_entry entries[];
 } __packed;
 
-static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc);
+static int snp_begin_psc(struct vcpu_svm *svm);
 
 static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 {
@@ -3838,7 +3838,6 @@ static void __snp_complete_one_psc(struc
 static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct psc_buffer *psc = svm->sev_es.ghcb_sa;
 
 	if (vcpu->run->hypercall.ret) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
@@ -3848,11 +3847,13 @@ static int snp_complete_one_psc(struct k
 	__snp_complete_one_psc(svm);
 
 	/* Handle the next range (if any). */
-	return snp_begin_psc(svm, psc);
+	return snp_begin_psc(svm);
 }
 
-static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc)
+static int snp_begin_psc(struct vcpu_svm *svm)
 {
+	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
+	struct psc_buffer *psc = sev_es->ghcb_sa;
 	struct psc_entry *entries = psc->entries;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct psc_hdr *hdr = &psc->hdr;
@@ -4540,7 +4541,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *
 		if (ret)
 			break;
 
-		ret = snp_begin_psc(svm, svm->sev_es.ghcb_sa);
+		ret = snp_begin_psc(svm);
 		break;
 	case SVM_VMGEXIT_AP_CREATION:
 		ret = sev_snp_ap_creation(svm);



