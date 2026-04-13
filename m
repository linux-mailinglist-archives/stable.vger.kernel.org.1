Return-Path: <stable+bounces-237281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB5FJl4f3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-237281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:52:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA483F0184
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBDB53020756
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4C131619A;
	Mon, 13 Apr 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jXWsOGyM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDB317141;
	Mon, 13 Apr 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099052; cv=none; b=b/kQUwoNZqfQwRFwQlW95+wTQukn3Xav/6TzYPD5a1FgBPcT3Vhphr7X+yTtTtgwRZFDOayFBLolwOl6uQ78ZUpgeKa9ydGm5hSP6+YGqUJ90wfcs7P0jcnRql9kkfWMQsce0uyCCqJYQm5TSK/3P1bArVwB+xdQKDKbhrG+ZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099052; c=relaxed/simple;
	bh=WSj+ymx5OkN2/MPxcfBWk1DbSpWm/gVAbVcBC/S320g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZ67K8eyd7okKtArZb7NlHqrGcsE60BLC46djE6TVQ3H0lDGHAAOrz2JlQgDf0JddxJMC0geXb3uSau30qwfEnMusyBRZjDuzTVZcfqnml1aC4wQUco00AU6xFGg/hY6PgB+iGanzELP94PIbHZuV9ex2EzPsd6U1gyyGUicSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jXWsOGyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F15C2BCAF;
	Mon, 13 Apr 2026 16:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099052;
	bh=WSj+ymx5OkN2/MPxcfBWk1DbSpWm/gVAbVcBC/S320g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXWsOGyMuDvCbJdNtsMq1ZmV5zPFPJ3A47/dzVEBMl1he/Su1TexNYRkrocRqxmst
	 6FDWMSFvfBpjpp0I+nUcvlyLCGmaEFXIFPu26D2Aarj0xZo+68H042tjlGMFpc9wv5
	 /VeRxA24CfceAHMUiZDT9M8iNwY27c0gFJT8yVYk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Naveen N Rao (AMD)" <naveen@kernel.org>,
	Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 192/491] KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-kernel APIC
Date: Mon, 13 Apr 2026 17:57:17 +0200
Message-ID: <20260413155826.257190686@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237281-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FA483F0184
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 3989a6d036c8ec82c0de3614bed23a1dacd45de5 ]

Initialize all per-vCPU AVIC control fields in the VMCB if AVIC is enabled
in KVM and the VM has an in-kernel local APIC, i.e. if it's _possible_ the
vCPU could activate AVIC at any point in its lifecycle.  Configuring the
VMCB if and only if AVIC is active "works" purely because of optimizations
in kvm_create_lapic() to speculatively set apicv_active if AVIC is enabled
*and* to defer updates until the first KVM_RUN.  In quotes because KVM
likely won't do the right thing if kvm_apicv_activated() is false, i.e. if
a vCPU is created while APICv is inhibited at the VM level for whatever
reason.  E.g. if the inhibit is *removed* before KVM_REQ_APICV_UPDATE is
handled in KVM_RUN, then __kvm_vcpu_update_apicv() will elide calls to
vendor code due to seeing "apicv_active == activate".

Cleaning up the initialization code will also allow fixing a bug where KVM
incorrectly leaves CR8 interception enabled when AVIC is activated without
creating a mess with respect to whether AVIC is activated or not.

Cc: stable@vger.kernel.org
Fixes: 67034bb9dd5e ("KVM: SVM: Add irqchip_split() checks before enabling AVIC")
Fixes: 6c3e4422dd20 ("svm: Add support for dynamic APICv")
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://patch.msgid.link/20260203190711.458413-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/avic.c |    2 +-
 arch/x86/kvm/svm/svm.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -203,7 +203,7 @@ void avic_init_vmcb(struct vcpu_svm *svm
 	vmcb->control.avic_logical_id = lpa & AVIC_HPA_MASK;
 	vmcb->control.avic_physical_id = ppa & AVIC_HPA_MASK;
 	vmcb->control.avic_physical_id |= AVIC_MAX_PHYSICAL_ID_COUNT;
-	if (kvm_apicv_activated(svm->vcpu.kvm))
+	if (kvm_vcpu_apicv_active(&svm->vcpu))
 		vmcb->control.int_ctl |= AVIC_ENABLE_MASK;
 	else
 		vmcb->control.int_ctl &= ~AVIC_ENABLE_MASK;
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1230,7 +1230,7 @@ static void init_vmcb(struct vcpu_svm *s
 
 	svm_check_invpcid(svm);
 
-	if (kvm_vcpu_apicv_active(&svm->vcpu))
+	if (avic && irqchip_in_kernel(svm->vcpu.kvm))
 		avic_init_vmcb(svm);
 
 	/*



