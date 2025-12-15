Return-Path: <stable+bounces-201083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE000CBF8DC
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 20:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C160B30762FE
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 19:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97BB334698;
	Mon, 15 Dec 2025 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Scz2GknJ"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4C332ED1
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826892; cv=none; b=NQzZEG2WabiZIqWsoXxWEFvR7zq6t8OWLijguGqaW3jUCEv0kPoir4uoxjDE8TRKXOXw7BhqxKXLv1XtKLotm8QdhrMb4tBOFucOrieyWxlYcD23+l6H62OOcz8ZPthLcOp4EhjB2CLxOsdLRKWjwWBBZIVwzDmFSVqmGBzgHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826892; c=relaxed/simple;
	bh=PCU7J39rp8nyOjifzmmlq8LO/BIuNXHhgP8FlSRrsXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYl/fqXFFIudCd1A8OFK0n3ihuvaeDJ3aLVMZKiqUtciMwQglr9A6nvk1Nb1CpxDSDkdUKYxlaUP9uvzTDvFTFNOs67SmVCWxLglAJtjYbDJh4d5vjjkbixSGU44hfgX37n1vkOQubqcAOFKWUOjvHpau2N2qZIEyeiX5WKtUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Scz2GknJ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765826883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOGmAEGQWx3Ejj7aS+2SEZbs+ajT25m/ukb19Dgs5RI=;
	b=Scz2GknJheZU7LeS7Qf0gZ0KwDsQcYO/Ym4y9WiN+6tS4/Qzt+xpHD9aw+49RgHYblABTV
	aTRC8y6z9osni8apt8uEHfD6ETSKGtDLlCi6cbCdAC0TTihr2famJ7R6bHI042g5qNkl2X
	3SLEdYas4TE6Rb6lNVfLat9UNveHBvI=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3 04/26] KVM: nSVM: Always inject a #GP if mapping VMCB12 fails on nested VMRUN
Date: Mon, 15 Dec 2025 19:26:59 +0000
Message-ID: <20251215192722.3654335-6-yosry.ahmed@linux.dev>
In-Reply-To: <20251215192722.3654335-1-yosry.ahmed@linux.dev>
References: <20251215192722.3654335-1-yosry.ahmed@linux.dev>
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
index 53b149dbc930..a5a367fd8bb1 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -966,12 +966,9 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
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
2.52.0.239.gd5f0c6e74e-goog


