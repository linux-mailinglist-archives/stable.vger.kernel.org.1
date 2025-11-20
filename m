Return-Path: <stable+bounces-195396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C69BC76009
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 34FB12A1D3
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E8368DF2;
	Thu, 20 Nov 2025 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf0uA2nw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69905368DE1
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665632; cv=none; b=aLmemlq17D2+059+ajjTgQTJCi4bvJ0hIOOv1jSHGOSu8GxsUPFW7p3gsxe9IY6//EX2xc3P0bCesvHcc19EMM0Ides0g0lPzBTLqVeWvBclcwMhmIfFhxBjhpbRfzYeDsfyPD8tN4+8uvB9yj9z2E8WNRcPA5Imoh26iCG3d1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665632; c=relaxed/simple;
	bh=rt9iMUi+Zpvp76cvkmi85jvprMdSNF0sunbMOL5C2Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSMHaqltQcg70wwg86wwqsEgfFsJh0jh/yTZqHoQ0I1ND49s30cyp6uWhTstQgaNjiZ26D3BQrXmpU70l9adUk8a0wrrUBCNp++Soix78PKpnvEh6Mn0vbi+/+oqMXiQOfDHWfFrLXCbB+RwFDaoa8gCWT8SxZdAymDSeBDayks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf0uA2nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A91C4CEF1;
	Thu, 20 Nov 2025 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763665631;
	bh=rt9iMUi+Zpvp76cvkmi85jvprMdSNF0sunbMOL5C2Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cf0uA2nw9LHFnvIz/g2jy66ESnn8eX4ofwj3Gvxl6jrP97A5KIzx6NZXSc1GD4tq1
	 pporIdAaSoJEkVz1YNrdbJhiYuksc/RRL3PtckArmuXm9hycRAap5fkoH9xGrrGtIv
	 smByKV/OAWZ3pdgLyLfxHDxyNLdPIq5sVqN3FLdfQ6L7UhxXM/3932Iub2hvrPt1vc
	 QSYHJjyM7l/plVZE3Tbk6+Fr/riCmFaczDEdeqNIShXd1j3ePs7kRE5CNLQBl9TjFk
	 WwCSzDK4FRm4yZ7nDMJUSKEv8QhlQDWNnb0XlqaWc7JpB2qIIiJcH4oWx8kOuel98k
	 xTgpQ2LhSAWWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/3] KVM: x86: Rename local "ecx" variables to "msr" and "pmc" as appropriate
Date: Thu, 20 Nov 2025 14:07:05 -0500
Message-ID: <20251120190708.2275081-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112027-ranch-retool-efaa@gregkh>
References: <2025112027-ranch-retool-efaa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit ec400f6c2f2703cb6c698dd00b28cfdb8ee5cdcc ]

Rename "ecx" variables in {RD,WR}MSR and RDPMC helpers to "msr" and "pmc"
respectively, in anticipation of adding support for the immediate variants
of RDMSR and WRMSRNS, and to better document what the variables hold
(versus where the data originated).

No functional change intended.

Link: https://lore.kernel.org/r/20250805202224.1475590-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: 9d7dfb95da2c ("KVM: VMX: Inject #UD if guest tries to execute SEAMCALL or TDCALL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0affe0ec34dc0..f98b801d9efdf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1579,10 +1579,10 @@ EXPORT_SYMBOL_GPL(kvm_get_dr);
 
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 {
-	u32 ecx = kvm_rcx_read(vcpu);
+	u32 pmc = kvm_rcx_read(vcpu);
 	u64 data;
 
-	if (kvm_pmu_rdpmc(vcpu, ecx, &data)) {
+	if (kvm_pmu_rdpmc(vcpu, pmc, &data)) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
@@ -2033,23 +2033,23 @@ static int kvm_msr_user_space(struct kvm_vcpu *vcpu, u32 index,
 
 int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
 {
-	u32 ecx = kvm_rcx_read(vcpu);
+	u32 msr = kvm_rcx_read(vcpu);
 	u64 data;
 	int r;
 
-	r = kvm_get_msr_with_filter(vcpu, ecx, &data);
+	r = kvm_get_msr_with_filter(vcpu, msr, &data);
 
 	if (!r) {
-		trace_kvm_msr_read(ecx, data);
+		trace_kvm_msr_read(msr, data);
 
 		kvm_rax_write(vcpu, data & -1u);
 		kvm_rdx_write(vcpu, (data >> 32) & -1u);
 	} else {
 		/* MSR read failed? See if we should ask user space */
-		if (kvm_msr_user_space(vcpu, ecx, KVM_EXIT_X86_RDMSR, 0,
+		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_RDMSR, 0,
 				       complete_fast_rdmsr, r))
 			return 0;
-		trace_kvm_msr_read_ex(ecx);
+		trace_kvm_msr_read_ex(msr);
 	}
 
 	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
@@ -2058,23 +2058,23 @@ EXPORT_SYMBOL_GPL(kvm_emulate_rdmsr);
 
 int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
 {
-	u32 ecx = kvm_rcx_read(vcpu);
+	u32 msr = kvm_rcx_read(vcpu);
 	u64 data = kvm_read_edx_eax(vcpu);
 	int r;
 
-	r = kvm_set_msr_with_filter(vcpu, ecx, data);
+	r = kvm_set_msr_with_filter(vcpu, msr, data);
 
 	if (!r) {
-		trace_kvm_msr_write(ecx, data);
+		trace_kvm_msr_write(msr, data);
 	} else {
 		/* MSR write failed? See if we should ask user space */
-		if (kvm_msr_user_space(vcpu, ecx, KVM_EXIT_X86_WRMSR, data,
+		if (kvm_msr_user_space(vcpu, msr, KVM_EXIT_X86_WRMSR, data,
 				       complete_fast_msr_access, r))
 			return 0;
 		/* Signal all other negative errors to userspace */
 		if (r < 0)
 			return r;
-		trace_kvm_msr_write_ex(ecx, data);
+		trace_kvm_msr_write_ex(msr, data);
 	}
 
 	return kvm_x86_call(complete_emulated_msr)(vcpu, r);
-- 
2.51.0


