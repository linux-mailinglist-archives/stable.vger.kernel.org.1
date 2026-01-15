Return-Path: <stable+bounces-208397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 950BCD21F50
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 02:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB3D4305991A
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6533526CE23;
	Thu, 15 Jan 2026 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="he2lkuv2"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8B23DEB6
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768439628; cv=none; b=eV8E9L26Of6owhLc0dHrhDYh98FdRgGcI02CEmpdRcwURQcDoP0T/pNKjr/8kTjNKH4BPokrg72ZTnKBCXExxEmnHejuzP9jnnKFCVPM9FPjv+qXcvuKcMP/JCMQd2FIuyjBVNdQbgl0ANgYl5QRt4uxZLq0meybJYvvWnAyg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768439628; c=relaxed/simple;
	bh=SvnJl/Qx7YbdnzpkzADENdnbM03g9c0nYE5AAk8vbss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmJucy3HQrVJu+aEKA/PeJ/jmKOpGZ8jIsj1BHChGwfTyjZ5SBxLdvlBKGVZnK4gNMo6ncxiecDRWc4FsXymazHYfvJ870MFgXrEz0lqpbBsZgszIRVrPUWpJqZlNfjOtUAePt0f+4YFr4gtSQIUzIs5WmNbkJaV1vQfQIHl1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=he2lkuv2; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768439620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWBKYRKqLR3Sf/6YuZ+mDu1Cr+lCy9BRdjKjJqfC+Js=;
	b=he2lkuv2PI2iBHlLj/ETD6DAB4YhoksK0vSlKS793awCQDgpDSHdTFYFVDAKSQ2kRv8qxi
	2V5M7SzE/Zm0E6b1GUdcDeOyPd3HlLadoLpBk8Sso926MfwrHYURgRK5CMkIxSlkT+WAWa
	4mkQ+cmUCP3pSnq2L6zMmkTqrLKJH+8=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v4 08/26] KVM: nSVM: Call enter_guest_mode() before switching to VMCB02
Date: Thu, 15 Jan 2026 01:12:54 +0000
Message-ID: <20260115011312.3675857-9-yosry.ahmed@linux.dev>
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
index 8515ff81508a..536ca8e1d29f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -745,9 +745,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 
 	nested_svm_transition_tlb_flush(vcpu);
 
-	/* Enter Guest-Mode */
-	enter_guest_mode(vcpu);
-
 	/*
 	 * Filled at exit: exit_code, exit_code_hi, exit_info_1, exit_info_2,
 	 * exit_int_info, exit_int_info_err, next_rip, insn_len, insn_bytes.
@@ -948,6 +945,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 
 	WARN_ON(svm->vmcb == svm->nested.vmcb02.ptr);
 
+	enter_guest_mode(vcpu);
+
 	nested_svm_copy_common_state(svm->vmcb01.ptr, svm->nested.vmcb02.ptr);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
@@ -1901,6 +1900,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	svm_copy_vmrun_state(&svm->vmcb01.ptr->save, save);
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
+	enter_guest_mode(vcpu);
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
 	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip, svm->vmcb->save.cs.base);
 
-- 
2.52.0.457.g6b5491de43-goog


