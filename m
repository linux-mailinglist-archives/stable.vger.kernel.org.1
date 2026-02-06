Return-Path: <stable+bounces-214712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MKBF+g9hmnzLAQAu9opvQ
	(envelope-from <stable+bounces-214712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 20:15:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E82EA1028E2
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 20:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A92630B1FF3
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFF542EEDA;
	Fri,  6 Feb 2026 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a4gul3kQ"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7B42885D
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404965; cv=none; b=qxjHk+V3g4oSf88qdNb7p4aPJV5Tuhpoyw8yefPwaFiS+5idhsUVSwl7EiPRfOk7klx4fa6a2xrovJClDxyZqO0Awv7vTUzRNLTAOPUWYVXBdH6n+Bxyoj7w+oVEsh3FgQn3pE1xoIgj3BRJngXFssZbG0Ko03fg+1tOuTxMIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404965; c=relaxed/simple;
	bh=aFbbE1mXIIfwFOvI+A1BZSivVcixs1P5aMa3QZelj1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFqhNBq1wG711/osSh5snTf6LNVM6ZUNqKxH0sABwwczVs8/ZQ4JgIcDwjvzpb7IqnmzB85pCHxk31K1EkoHoexbs1Lmc6eTbnRu4JxaXmWUJ6y6MdiI91m63w0WuafrGeoQsxURPFakz+laaNwtXVHnr+iOIcRovFc2dkdQOe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a4gul3kQ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770404963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eFD0yh8gByHsKvBqdBWwO0lKqyxFdc3ADbFbDOMW+c=;
	b=a4gul3kQEYygRMo6Z2mkbFDspLs3RN7nVa5IMWp7D/upcAodgiyc8wGyCAQNLzc4X5IFrW
	wlAijZpez8mo1FcPRVr2VhZTm08ICjLi1DNRUgLs5heabWWc9Ra7yKU0purgX8nTbScGVa
	jMPf3zKHFSXrkkw6bV7ZgOrNMUiZLHg=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v5 09/26] KVM: nSVM: Call enter_guest_mode() before switching to VMCB02
Date: Fri,  6 Feb 2026 19:08:34 +0000
Message-ID: <20260206190851.860662-10-yosry.ahmed@linux.dev>
In-Reply-To: <20260206190851.860662-1-yosry.ahmed@linux.dev>
References: <20260206190851.860662-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214712-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry.ahmed@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E82EA1028E2
X-Rspamd-Action: no action

In preparation for moving more changes that rely on is_guest_mode()
before switching to VMCB02, move entering guest mode a bit earlier.

Nothing between the new callsite(s) and the old ones rely on
is_guest_mode(), so this should be safe.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 29069fc5e8cb..607d99172e2b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -741,9 +741,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 
 	nested_svm_transition_tlb_flush(vcpu);
 
-	/* Enter Guest-Mode */
-	enter_guest_mode(vcpu);
-
 	/*
 	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
 	 * exit_int_info_err, next_rip, insn_len, insn_bytes.
@@ -944,6 +941,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 
 	WARN_ON(svm->vmcb == svm->nested.vmcb02.ptr);
 
+	enter_guest_mode(vcpu);
+
 	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
@@ -1890,6 +1889,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
+	enter_guest_mode(vcpu);
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
 	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip, svm->vmcb->save.cs.base);
 
-- 
2.53.0.rc2.204.g2597b5adb4-goog


