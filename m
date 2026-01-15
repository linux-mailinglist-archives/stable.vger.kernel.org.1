Return-Path: <stable+bounces-208393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2675ED21F74
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 02:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3871530A7BE7
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 01:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E00256C84;
	Thu, 15 Jan 2026 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SHcI4Ojk"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261023E25B
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768439625; cv=none; b=NKkgh1Ime3hnxw1HZ1vcdDdQdd+nZQggDL0g66wD5JqiRklG1Pmyb5Hfa87r0Dxz/K7NeHvP8kZBQRMA95/XuBa/JZF51FLwaGlYLDEmlhmWrl4pHrNviByscJZ2+LgkWJUtsZFLw6CLtsy4nTEBkPDZ9F24cIwpfyQlJD7a+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768439625; c=relaxed/simple;
	bh=ChBGH0EIeAQB4+XYtp32lQzDWmZ2qjzvmHmcPEp31bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfzS1vhE/LIUBTfs7eWAinYVTcXShqUTIr6KDmeAHMNmkWSR4sgmGFC3gXNzkhgPjnmK7hhACzak8jLTZwtKa6G4N0iUvB4Sj+EAIfLv/CzUTvQ6EGzJyxSosxysqP3BwkW2q36W0BGL+uo2BbMp5bP5F6MDstHr3VJDSlXLk0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SHcI4Ojk; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768439614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQZKrV5jtvMOu7N9t4ncabozUsO3LP1NQaZvmuk0EHw=;
	b=SHcI4Ojk4so0EpLbpdpU7IeEMuWJWwWrSw3LUxWcpBXKwvyaMIoqueXTXP4fxfYWcCQFWh
	ceWqclXyIhOpRUIUMn81MGACU+oSCLexeMUzBUWYkW3FMjZOQA1l2dSrcCl5nzk4sqP/Y5
	K7F1j6EyhvqfTsz7Wokw4cJq3Cgj2jU=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v4 04/26] KVM: nSVM: Always inject a #GP if mapping VMCB12 fails on nested VMRUN
Date: Thu, 15 Jan 2026 01:12:50 +0000
Message-ID: <20260115011312.3675857-5-yosry.ahmed@linux.dev>
In-Reply-To: <20260115011312.3675857-1-yosry.ahmed@linux.dev>
References: <20260115011312.3675857-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

nested_svm_vmrun() currently only injects a #GP if kvm_vcpu_map() fails
with -EINVAL. But it could also fail with -EFAULT if creating a host
mapping failed. Inject a #GP in all cases, no reason to treat failure
modes differently.

Fixes: 8c5fbf1a7231 ("KVM/nSVM: Use the new mapping API for mapping guest memory")
CC: stable@vger.kernel.org
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 03a2c4390676..5f9c5ccc4783 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1015,12 +1015,9 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	}
 
 	vmcb12_gpa = svm->vmcb->save.rax;
-	ret = kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map);
-	if (ret == -EINVAL) {
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map)) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
-	} else if (ret) {
-		return kvm_skip_emulated_instruction(vcpu);
 	}
 
 	ret = kvm_skip_emulated_instruction(vcpu);
-- 
2.52.0.457.g6b5491de43-goog


