Return-Path: <stable+bounces-164473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35120B0F6D6
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9003B89B6
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E09B2E4277;
	Wed, 23 Jul 2025 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVaPITbS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3429C33C
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283665; cv=none; b=ro86iIkdNn8sfNlF0j9jCf6mGlM8w4Zp2cBzhE5xvKgHSlLy8qBg2V9h8Jx4l0ybNEu2OjiN4qJ51Ha+JrIaAULU0ufkvAza5LRuEbG0wBYNJlhIm6z5kddVxJ6EuIqZCUrEnpRb+InT1xZrOZ/xB+ZHe1pd47GFO491Tzhhqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283665; c=relaxed/simple;
	bh=V2shxoEt1wvGcWkAFgk9cMDQ1zLGaj1wRRjf1k6ulwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8YbqGLxMP5fB78mlkt4tLtYWezTR7YiVRIGVGFUdiz2fdF8BUgpKo2BJ5ZCPZW0hZOnvUZeQN8J9Lz59J59B56tQ1nHYe8sofUIwXvOjWPb+w+ehv78dTeLLAPABmZEqTvFk7fAqylqR0RW5CmTgCn/ovgGeJj3nI+L2WYPWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVaPITbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660E0C4CEE7;
	Wed, 23 Jul 2025 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753283664;
	bh=V2shxoEt1wvGcWkAFgk9cMDQ1zLGaj1wRRjf1k6ulwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVaPITbSP8LdkFBsNRT0JuvhRWIAR0+t0qUS54e6D2ke5aNZC0qcZ2hZvB8KBYp4m
	 1hZAhj3ygZH45cAGWn0pCcDhNDyhiBHkdarRZGLcOZvPjM/VIHNeIa/u7xLN+/EKHr
	 kLeHHYvf73aHxVKjJKsty6Aoi0RO91uT5mPzT/M/R0rAfyKoMXjcpg0sJFdV0+Tnhk
	 tjpXYsAcNF2pFmTUjkp5XvoYaAksOiH3rQ1jk749wkvklP0EMOruac72byf0OD8nVv
	 i/BmhHpXmaVCqiX11cAmx9IPCMNw5D6t3Zyovid4uPABPzCTe/koVeZebNOe3T8Bzn
	 hmFnmEKzfZ1Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] KVM: x86: Add X86EMUL_F_MSR and X86EMUL_F_DT_LOAD to aid canonical checks
Date: Wed, 23 Jul 2025 11:14:14 -0400
Message-Id: <20250723151416.1092631-3-sashal@kernel.org>
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

[ Upstream commit c534b37b7584e2abc5d487b4e017f61a61959ca9 ]

Add emulation flags for MSR accesses and Descriptor Tables loads, and pass
the new flags as appropriate to emul_is_noncanonical_address().  The flags
will be used to perform the correct canonical check, as the type of access
affects whether or not CR4.LA57 is consulted when determining the canonical
bit.

No functional change is intended.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20240906221824.491834-3-mlevitsk@redhat.com
[sean: split to separate patch, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: fa787ac07b3c ("KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/emulate.c     | 15 +++++++++------
 arch/x86/kvm/kvm_emulate.h |  5 ++++-
 arch/x86/kvm/x86.c         |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 3ce83f57d267d..60986f67c35a8 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -651,9 +651,10 @@ static inline u8 ctxt_virt_addr_bits(struct x86_emulate_ctxt *ctxt)
 }
 
 static inline bool emul_is_noncanonical_address(u64 la,
-						struct x86_emulate_ctxt *ctxt)
+						struct x86_emulate_ctxt *ctxt,
+						unsigned int flags)
 {
-	return !ctxt->ops->is_canonical_addr(ctxt, la);
+	return !ctxt->ops->is_canonical_addr(ctxt, la, flags);
 }
 
 /*
@@ -1733,7 +1734,8 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
 		if (emul_is_noncanonical_address(get_desc_base(&seg_desc) |
-						 ((u64)base3 << 32), ctxt))
+						 ((u64)base3 << 32), ctxt,
+						 X86EMUL_F_DT_LOAD))
 			return emulate_gp(ctxt, err_code);
 	}
 
@@ -2516,8 +2518,8 @@ static int em_sysexit(struct x86_emulate_ctxt *ctxt)
 		ss_sel = cs_sel + 8;
 		cs.d = 0;
 		cs.l = 1;
-		if (emul_is_noncanonical_address(rcx, ctxt) ||
-		    emul_is_noncanonical_address(rdx, ctxt))
+		if (emul_is_noncanonical_address(rcx, ctxt, 0) ||
+		    emul_is_noncanonical_address(rdx, ctxt, 0))
 			return emulate_gp(ctxt, 0);
 		break;
 	}
@@ -3494,7 +3496,8 @@ static int em_lgdt_lidt(struct x86_emulate_ctxt *ctxt, bool lgdt)
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 	if (ctxt->mode == X86EMUL_MODE_PROT64 &&
-	    emul_is_noncanonical_address(desc_ptr.address, ctxt))
+	    emul_is_noncanonical_address(desc_ptr.address, ctxt,
+					 X86EMUL_F_DT_LOAD))
 		return emulate_gp(ctxt, 0);
 	if (lgdt)
 		ctxt->ops->set_gdt(ctxt, &desc_ptr);
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 1b1843ff210fd..10495fffb8905 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -94,6 +94,8 @@ struct x86_instruction_info {
 #define X86EMUL_F_FETCH			BIT(1)
 #define X86EMUL_F_IMPLICIT		BIT(2)
 #define X86EMUL_F_INVLPG		BIT(3)
+#define X86EMUL_F_MSR			BIT(4)
+#define X86EMUL_F_DT_LOAD		BIT(5)
 
 struct x86_emulate_ops {
 	void (*vm_bugged)(struct x86_emulate_ctxt *ctxt);
@@ -236,7 +238,8 @@ struct x86_emulate_ops {
 	gva_t (*get_untagged_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
 				   unsigned int flags);
 
-	bool (*is_canonical_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr);
+	bool (*is_canonical_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
+				  unsigned int flags);
 };
 
 /* Type, address-of, and value of an instruction's operand. */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d7416dc7f4974..c25f8e016fc5c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8609,7 +8609,7 @@ static gva_t emulator_get_untagged_addr(struct x86_emulate_ctxt *ctxt,
 }
 
 static bool emulator_is_canonical_addr(struct x86_emulate_ctxt *ctxt,
-				       gva_t addr)
+				       gva_t addr, unsigned int flags)
 {
 	return !is_noncanonical_address(addr, emul_to_vcpu(ctxt));
 }
-- 
2.39.5


