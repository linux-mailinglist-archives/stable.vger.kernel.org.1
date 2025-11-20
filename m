Return-Path: <stable+bounces-195431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F46BC76A1C
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 00:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 772254E3158
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C7E2D8399;
	Thu, 20 Nov 2025 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G877RGl7"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29719E97A
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681997; cv=none; b=SB8Sh2+os5+aXHdAvc4JjVLxonLA9IOdBGJL/puFZOjIZ/vd6h0hHuEI5ymIY0rULH30Vawio8HtoEadqnE9MRcXYA6s6fz/0oJ1osZ4m3bmU3PIbZZCdPU+k3dFi91ea/MyWcZ/0RtUpWjgsVqKIOZA9J2wZ4In78kzktD1ZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681997; c=relaxed/simple;
	bh=y9GaSnaDzHMzFi6BrD+S3k5+UEqAUHpnh3MsoNhz7sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsuwITDHXOKVHUVloucCDOIMPIPpoSXSfGnf6gKFs3/sjQWdj+bywaLvj18ZmN9lCPNQxkgqtFeiWt6ZhPXuWkr8OQjZbUKVilkJvtCfHXrnWsFDZs00am8Xx2Y14CBD5uv2zugkPMMdUHMJkpQeI0F+Qb7mM4z1c0/uXLpXYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G877RGl7; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763681993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fuq2TxBUp6Ba+WJkLzKnaG9xq+Kxcp2wOeyrjtqpRjE=;
	b=G877RGl7Z6ZD0ob9u4vY1cILG5x10AwgAiOXau6Up7MQIoKK/EWuRmLGjjhLoCCEwLGInG
	N5UtMhzqiaSV4gWPlx2RhfUnCQ5/Fn/hg2EeapLoFCJailYYfqR2uw5t2JoiiYHIVbYtOp
	jz0iT6wCj0/ytHcZR9kJqas8SGIrmlY=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 6.12.y 1/5] KVM: SVM: Introduce svm_recalc_lbr_msr_intercepts()
Date: Thu, 20 Nov 2025 23:39:32 +0000
Message-ID: <20251120233936.2407119-2-yosry.ahmed@linux.dev>
In-Reply-To: <20251120233936.2407119-1-yosry.ahmed@linux.dev>
References: <2025112046-confider-smelting-6296@gregkh>
 <20251120233936.2407119-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce a helper updating the intercepts for LBR MSRs, similar to the
one introduced upstream by commit 160f143cc131 ("KVM: SVM: Manually
recalc all MSR intercepts on userspace MSR filter change"). The main
difference is that this version uses set_msr_interception(), which has
inverted polarity compared to svm_set_intercept_for_msr().

This is intended to simplify incoming backports. No functional changes
intended.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/svm.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c48a466db0c3..6deccc1b1669 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -995,18 +995,31 @@ void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 	vmcb_mark_dirty(to_vmcb, VMCB_LBR);
 }
 
-void svm_enable_lbrv(struct kvm_vcpu *vcpu)
+static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	bool intercept = !(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK);
 
-	svm->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHFROMIP, 1, 1);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP, 1, 1);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTFROMIP, 1, 1);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP, 1, 1);
+	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHFROMIP,
+			     !intercept, !intercept);
+	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP,
+			     !intercept, !intercept);
+	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTFROMIP,
+			     !intercept, !intercept);
+	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP,
+			     !intercept, !intercept);
 
 	if (sev_es_guest(vcpu->kvm))
-		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_DEBUGCTLMSR, 1, 1);
+		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_DEBUGCTLMSR,
+				     !intercept, !intercept);
+}
+
+void svm_enable_lbrv(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	svm->vmcb->control.virt_ext |= LBR_CTL_ENABLE_MASK;
+	svm_recalc_lbr_msr_intercepts(vcpu);
 
 	/* Move the LBR msrs to the vmcb02 so that the guest can see them. */
 	if (is_guest_mode(vcpu))
@@ -1020,10 +1033,7 @@ static void svm_disable_lbrv(struct kvm_vcpu *vcpu)
 	KVM_BUG_ON(sev_es_guest(vcpu->kvm), vcpu->kvm);
 
 	svm->vmcb->control.virt_ext &= ~LBR_CTL_ENABLE_MASK;
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHFROMIP, 0, 0);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTBRANCHTOIP, 0, 0);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTFROMIP, 0, 0);
-	set_msr_interception(vcpu, svm->msrpm, MSR_IA32_LASTINTTOIP, 0, 0);
+	svm_recalc_lbr_msr_intercepts(vcpu);
 
 	/*
 	 * Move the LBR msrs back to the vmcb01 to avoid copying them
-- 
2.52.0.rc2.455.g230fcf2819-goog


