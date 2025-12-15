Return-Path: <stable+bounces-201087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D768CBF900
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 20:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9F6302B130
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E52A337B9F;
	Mon, 15 Dec 2025 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wyqkGlid"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E1337BA6
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826917; cv=none; b=CXmjpil3CvntETNiaeghvWf+3jG2Mu5QKI5+VIFdem/Bg4R6spdn6yDs0OZA3jH0HvFJ/CwoRSjS7appDHKcRuBNQrYoTtY+aelIUq7/+fAWaAZa8iITY+4O+jfry/x9jOfdkA0e1MJMvIWBCayTmSv5IjQ/MI3GUSZxyncv0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826917; c=relaxed/simple;
	bh=BUvQyWXuYEEYhxKhefZQGhzXIOloUBGKjN1sz2Ri48I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n89X26AtyKyFHB/JoNEiultGgMwlUwiUjeSKL0/e7UQxQv8/1xFTKDzG6an12EE35Ciiqwo4gKrlLi9+ZUP/w3o+U53qtjiOtP04mdkczwfedxHOu65RbJ5kWWdOfeyWhKHhVuGd4H+nPFPQPpgmPxnf+xD+sZHzuLn4wGn2JiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wyqkGlid; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765826909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cf8RFQ2S/w9aMyAhPvTtFAPK8oi2Ex0gGpKSV/SAR4=;
	b=wyqkGlidVqfFRsFfg8F4Uh442B740IxEQZmmTRUVJ2PHksMrkI4HB0Gt7HiVVfzGKYvEHM
	ZX6GQj+lV7b0e/9aAQibKvlsNjNpwasl6WG/YvFgR+EnIJl81EWmOTNkQCYRtQzUZSd0td
	RR+BgKcBccd1rorYSp+uk4aLJyjaL6Q=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3 08/26] KVM: nSVM: Call enter_guest_mode() before switching to VMCB02
Date: Mon, 15 Dec 2025 19:27:03 +0000
Message-ID: <20251215192722.3654335-10-yosry.ahmed@linux.dev>
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
index 512e377cfdec..384352365310 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -709,9 +709,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 
 	nested_svm_transition_tlb_flush(vcpu);
 
-	/* Enter Guest-Mode */
-	enter_guest_mode(vcpu);
-
 	/*
 	 * Filled at exit: exit_code, exit_code_hi, exit_info_1, exit_info_2,
 	 * exit_int_info, exit_int_info_err, next_rip, insn_len, insn_bytes.
@@ -899,6 +896,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 
 	WARN_ON(svm->vmcb == svm->nested.vmcb02.ptr);
 
+	enter_guest_mode(vcpu);
+
 	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
@@ -1846,6 +1845,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
+	enter_guest_mode(vcpu);
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
 	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip, svm->vmcb->save.cs.base);
 
-- 
2.52.0.239.gd5f0c6e74e-goog


