Return-Path: <stable+bounces-164472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3D7B0F6D7
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167C03BD53D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87152E8885;
	Wed, 23 Jul 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHd2R20i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC62E4277
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283663; cv=none; b=hAYP/Ka7K5PyHTsB6dki1NiE2feZLBfz6TMK6EfRcMJk2oaCzcUY2j7JisBJH5EoTwZPMH/rdlTAhYMizmK+8ERB8WQA7H2XwLZ/Fmwwc4WRmPTA6Ihok+STzfjiOqyzFKWMfBGSzTlr3IUYZbrrgDWGmAPAslBSxj6Dx1B8+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283663; c=relaxed/simple;
	bh=MTYq3XPbhpd+Sd2wG6TraSfrzRrEMv7uce9Dvfec1IA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obNPIYPqZIhKU9t625iTRAjeRrJ0lTw5AXVzpeEdQwGhmV3qEL1CXgO8kTqsJybbfUsCoQzC/L692wrCPlow5tWjVhu/T4fZVjc4vB5UD0fhEE2apvjibf41AFsWIKIEw4ilFvCLncWjuoVdCa5eX687eCQYg5dXKFowHvC5e2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHd2R20i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D26C4CEEF;
	Wed, 23 Jul 2025 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753283662;
	bh=MTYq3XPbhpd+Sd2wG6TraSfrzRrEMv7uce9Dvfec1IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHd2R20ikJjt+7Sykxv/mjqQxwIlodqSrdWBZ43QJB/XP8S/pNz1JKfO/H2od+jmd
	 UCsP2swfnZWehZG3MTEciFXlNhiiIxLwaN6jrn4Fc1x0ddNeLmfs2M2HZZpSxCY+68
	 crMQDlnZWGAwBSEzOdKvautGzAkrLwROCGwPRnX7LmcNbgnw0HP9eLfyrrme0MSsvc
	 vJUMfmCgWiUdR8oksx54b9/qk8EO1mLN3406NeV/0Dq+eLEuBjCkcmKvAP+cnQhI2q
	 09loPhM6GCJisqm40UrjYjPFzsk64OU+zYEJl+x5x3mTlcwI74Sdt9gE88cj+Grtup
	 SzwKjgSn/stkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] KVM: x86: Route non-canonical checks in emulator through emulate_ops
Date: Wed, 23 Jul 2025 11:14:13 -0400
Message-Id: <20250723151416.1092631-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723151416.1092631-1-sashal@kernel.org>
References: <2025071240-phoney-deniable-545a@gregkh>
 <20250723151416.1092631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Levitsky <mlevitsk@redhat.com>

[ Upstream commit 16ccadefa295af434ca296e566f078223ecd79ca ]

Add emulate_ops.is_canonical_addr() to perform (non-)canonical checks in
the emulator, which will allow extending is_noncanonical_address() to
support different flavors of canonical checks, e.g. for descriptor table
bases vs. MSRs, without needing duplicate logic in the emulator.

No functional change is intended.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20240906221824.491834-3-mlevitsk@redhat.com
[sean: separate from additional of flags, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: fa787ac07b3c ("KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/emulate.c     | 2 +-
 arch/x86/kvm/kvm_emulate.h | 2 ++
 arch/x86/kvm/x86.c         | 7 +++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index e72aed25d7212..3ce83f57d267d 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -653,7 +653,7 @@ static inline u8 ctxt_virt_addr_bits(struct x86_emulate_ctxt *ctxt)
 static inline bool emul_is_noncanonical_address(u64 la,
 						struct x86_emulate_ctxt *ctxt)
 {
-	return !__is_canonical_address(la, ctxt_virt_addr_bits(ctxt));
+	return !ctxt->ops->is_canonical_addr(ctxt, la);
 }
 
 /*
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 55a18e2f2dcd9..1b1843ff210fd 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -235,6 +235,8 @@ struct x86_emulate_ops {
 
 	gva_t (*get_untagged_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
 				   unsigned int flags);
+
+	bool (*is_canonical_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr);
 };
 
 /* Type, address-of, and value of an instruction's operand. */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f378d479fea3f..d7416dc7f4974 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8608,6 +8608,12 @@ static gva_t emulator_get_untagged_addr(struct x86_emulate_ctxt *ctxt,
 					       addr, flags);
 }
 
+static bool emulator_is_canonical_addr(struct x86_emulate_ctxt *ctxt,
+				       gva_t addr)
+{
+	return !is_noncanonical_address(addr, emul_to_vcpu(ctxt));
+}
+
 static const struct x86_emulate_ops emulate_ops = {
 	.vm_bugged           = emulator_vm_bugged,
 	.read_gpr            = emulator_read_gpr,
@@ -8654,6 +8660,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.triple_fault        = emulator_triple_fault,
 	.set_xcr             = emulator_set_xcr,
 	.get_untagged_addr   = emulator_get_untagged_addr,
+	.is_canonical_addr   = emulator_is_canonical_addr,
 };
 
 static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
-- 
2.39.5


