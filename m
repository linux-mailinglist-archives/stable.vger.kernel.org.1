Return-Path: <stable+bounces-243253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIroFFap+GmdxgIAu9opvQ
	(envelope-from <stable+bounces-243253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7544BECC6
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB94307377A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9263DA5C7;
	Mon,  4 May 2026 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dq80el8c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62375801;
	Mon,  4 May 2026 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903411; cv=none; b=uvGlLHCy1tThiVH0EYC8au3iRN5jRaUyXOOCO6I6ONbk2F0loHTUrTQiMDxjWHrlfBF5ZTHuj01M9Y6tJRxddEKCWLtHGNWVYC7dKGlaZLnEx/V+mFqZ0qOR2AlYsxZKzhxp8509mODa8HLA+3o3UEaTk0PcCfTJ5lZ9x5h8VPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903411; c=relaxed/simple;
	bh=OCJVewSj9F+kWWJMmwJLfxG/SxCYDrny/pPncbM0B9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJLGGieGngteB8MLLOrOfVJNuq/bmvJB9Wa62770uqBhL8CvjxgGyFCb8dlaAm7leL4k8jAFTxn41FCPRFVMN/V4Rj3kr8VxELj/oVQqIv1OftHsjU7VXyW+zGBJFaKCEd4HNcEgSqGiYe4OF4hJIO12foWbkg0HrtOZQt9IM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dq80el8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A81AC2BCB8;
	Mon,  4 May 2026 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903411;
	bh=OCJVewSj9F+kWWJMmwJLfxG/SxCYDrny/pPncbM0B9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dq80el8ccp91OodSWtPDEONQpZPiUDcW/t5lDlymtMcBs+M4SGeyFV1l0YIDM6ZbD
	 mspd2O5oZjWdplrpajQF4RG4hvI5DHSBo2Xfrqo5xws4y1TjutbSbbP6cQ7bijUd6q
	 xm3mXpIYrMX6WJI6oWa/+Qp94t8tBbJKKoHrKgak=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 7.0 223/307] KVM: nSVM: Clear tracking of L1->L2 NMI and soft IRQ on nested #VMEXIT
Date: Mon,  4 May 2026 15:51:48 +0200
Message-ID: <20260504135151.252348070@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5B7544BECC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243253-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yosry Ahmed <yosry@kernel.org>

commit 8998e1d012f3f45d0456f16706682cef04c3c436 upstream.

KVM clears tracking of L1->L2 injected NMIs (i.e. nmi_l1_to_l2) and soft
IRQs (i.e. soft_int_injected) on a synthesized #VMEXIT(INVALID) due to
failed VMRUN. However, they are not explicitly cleared in other
synthesized #VMEXITs.

soft_int_injected is always cleared after the first VMRUN of L2 when
completing interrupts, as any re-injection is then tracked by KVM
(instead of purely in vmcb02).

nmi_l1_to_l2 is not cleared after the first VMRUN if NMI injection
failed, as KVM still needs to keep track that the NMI originated from L1
to avoid blocking NMIs for L1. It is only cleared when the NMI injection
succeeds.

KVM could synthesize a #VMEXIT to L1 before successfully injecting the
NMI into L2 (e.g. due to a #NPF on L2's NMI handler in L1's NPTs). In
this case, nmi_l1_to_l2 will remain true, and KVM may not correctly mask
NMIs and intercept IRET when injecting an NMI into L1.

Clear both nmi_l1_to_l2 and soft_int_injected in nested_svm_vmexit(), i.e.
for all #VMEXITs except those that occur due to failed consistency checks,
as those happen before nmi_l1_to_l2 or soft_int_injected are set.

Fixes: 159fc6fa3b7d ("KVM: nSVM: Transparently handle L1 -> L2 NMI re-injection")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-13-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1074,8 +1074,6 @@ int nested_svm_vmrun(struct kvm_vcpu *vc
 
 out_exit_err:
 	svm->nested.nested_run_pending = 0;
-	svm->nmi_l1_to_l2 = false;
-	svm->soft_int_injected = false;
 
 	svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
 	svm->vmcb->control.exit_info_1  = 0;
@@ -1331,6 +1329,10 @@ void nested_svm_vmexit(struct vcpu_svm *
 	if (nested_svm_load_cr3(vcpu, vmcb01->save.cr3, false, true))
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
+	/* Drop tracking for L1->L2 injected NMIs and soft IRQs */
+	svm->nmi_l1_to_l2 = false;
+	svm->soft_int_injected = false;
+
 	/*
 	 * Drop what we picked up for L2 via svm_complete_interrupts() so it
 	 * doesn't end up in L1.



