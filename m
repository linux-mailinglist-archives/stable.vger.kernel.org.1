Return-Path: <stable+bounces-215575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJrZBROCimlaLQAAu9opvQ
	(envelope-from <stable+bounces-215575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 01:55:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ECF115CF4
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 01:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49DE0300B8C4
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 00:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF52725B662;
	Tue, 10 Feb 2026 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cuQvDLCG"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F191F1315
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684920; cv=none; b=FDCU/oigBVDXEAVfVOvf2xcK5y8HRXMqbZOv4/bw3k7N2qGQqQRaFQr98RgzLE8eyFIkg+2lgVfsohZiO3zQ/W7Scu5PcmZ792hi1frNLFF13Wme4OtZV3tpP+fI7wCqJ8OQPBrC5AwPTyLSEARSPHZ967iDSo0Rr/eqcIwggwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684920; c=relaxed/simple;
	bh=0xYTA5O8n2Un7nIegn4K2tJVnxu5c3fQRxZ2nWTeMVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q72wXt9oblURLhuGVna2e1K7H1dKKxIHDOqD6d1++LdwhIp1AZ25BVNOWHTqX+5lQKI9dBLT73JM7zJ9JPnLHniNjcEvanfQyDl4LOe8KM4rPc7m7DVnJxJAmNeiKVg5LdG67szRGmclmAPzH0k4xoSMBKJ0kkCAK6gZhWCLm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cuQvDLCG; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770684916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojZz514RvzyouqbQnt4yvqck/hytcluQX/sLI1bmLEw=;
	b=cuQvDLCG8jNbQtONDjaeA868o012sFQs+ompDLcD/Lduo7vbDQU1NIb91Zy+riDbRM6Mcq
	zWjcdpHUmcDNJy/6e7KBluJSCyf4l0ABntpgJabATXKxwhhvIG4ONGjWF2WGiZh+J70lNm
	Xm8QIkFqSv3FHwkEKOjOao2s7/Hq+kU=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] KVM: nSVM: Sync next_rip to cached vmcb12 after VMRUN of L2
Date: Tue, 10 Feb 2026 00:54:46 +0000
Message-ID: <20260210005449.3125133-2-yosry.ahmed@linux.dev>
In-Reply-To: <20260210005449.3125133-1-yosry.ahmed@linux.dev>
References: <20260210005449.3125133-1-yosry.ahmed@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215575-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[yosry.ahmed@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: D9ECF115CF4
X-Rspamd-Action: no action

After VMRUN in guest mode, nested_sync_control_from_vmcb02() syncs
fields written by the CPU from vmcb02 to the cached vmcb12. This is
because the cached vmcb12 is used as the authoritative copy of some of
the controls, and is the payload when saving/restoring nested state.

next_rip is also written by the CPU (in some cases) after VMRUN, but is
not sync'd to cached vmcb12. As a result, it is corrupted after
save/restore (replaced by the original value written by L1 on nested
VMRUN). This could cause problems for both KVM (e.g. when injecting a
soft IRQ) or L1 (e.g. when using next_rip to advance RIP after emulating
an instruction).

Fix this by sync'ing next_rip in nested_sync_control_from_vmcb02(). Move
the call to nested_sync_control_from_vmcb02() (and the entire
is_guest_mode() block) after svm_complete_interrupts(), as it may update
next_rip in vmcb02.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
CC: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c |  6 ++++--
 arch/x86/kvm/svm/svm.c    | 26 +++++++++++++++-----------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index de90b104a0dd..70086ba6497f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -519,8 +519,10 @@ void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm)
 {
 	u32 mask;
-	svm->nested.ctl.event_inj      = svm->vmcb->control.event_inj;
-	svm->nested.ctl.event_inj_err  = svm->vmcb->control.event_inj_err;
+
+	svm->nested.ctl.event_inj	= svm->vmcb->control.event_inj;
+	svm->nested.ctl.event_inj_err	= svm->vmcb->control.event_inj_err;
+	svm->nested.ctl.next_rip	= svm->vmcb->control.next_rip;
 
 	/* Only a few fields of int_ctl are written by the processor.  */
 	mask = V_IRQ_MASK | V_TPR_MASK;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5f0136dbdde6..6d8d4d19455e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4399,17 +4399,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	sync_cr8_to_lapic(vcpu);
 
 	svm->next_rip = 0;
-	if (is_guest_mode(vcpu)) {
-		nested_sync_control_from_vmcb02(svm);
-
-		/* Track VMRUNs that have made past consistency checking */
-		if (svm->nested.nested_run_pending &&
-		    !svm_is_vmrun_failure(svm->vmcb->control.exit_code))
-                        ++vcpu->stat.nested_run;
-
-		svm->nested.nested_run_pending = 0;
-	}
-
 	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
 
 	/*
@@ -4435,6 +4424,21 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	svm_complete_interrupts(vcpu);
 
+	/*
+	 * svm_complete_interrupts() may update svm->vmcb->control.next_rip,
+	 * which is sync'd by nested_sync_control_from_vmcb02() below.
+	 */
+	if (is_guest_mode(vcpu)) {
+		nested_sync_control_from_vmcb02(svm);
+
+		/* Track VMRUNs that have made past consistency checking */
+		if (svm->nested.nested_run_pending &&
+		    !svm_is_vmrun_failure(svm->vmcb->control.exit_code))
+			++vcpu->stat.nested_run;
+
+		svm->nested.nested_run_pending = 0;
+	}
+
 	return svm_exit_handlers_fastpath(vcpu);
 }
 

base-commit: e944fe2c09f405a2e2d147145c9b470084bc4c9a
-- 
2.53.0.rc2.204.g2597b5adb4-goog


