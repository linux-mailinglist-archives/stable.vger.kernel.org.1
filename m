Return-Path: <stable+bounces-207926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0FD0CA5A
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 01:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9ED23047914
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 00:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D820C490;
	Sat, 10 Jan 2026 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZOA4y8r"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9D13D8B1
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006127; cv=none; b=GUestHARdxAPl7ojlVltpqdsZD4+fICIduijl/MUjxrvrsIEBJUfE41BebUu712QH5wyYxLJ2YnYeuEkUM6Cp/mn24FwrD+tFUcxz3Y+l0SiauotBLGGzZmeDGUB77BVd4rW7w82A15qCsObtxZgQUPWqEooz+khUnjuaOClKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006127; c=relaxed/simple;
	bh=FJzmaB4ntWmqyKtFbkyHlSUO1/xoZrNN5rnPXBB6b8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ke4nVPzFBVDK/2t5O0rotSCbOR/xYz1rRAEVZuWk9FPmtfOECPhJPQtvnCpvsYPok7ZLYkDsBNpRkyHR19BgQRpNQtYJ9arLdMTM3dqB+DYsXAa4fQYiVofFk8qzehCYXfHDtHc+DiL7e/JDjhwPe7y21MIFXUxquOIR5911OrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZOA4y8r; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768006123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDgt+ECmMkXAmQuSwl6mDbmVPT38/lyN/PXVzf05jSg=;
	b=MZOA4y8rzWIm/x4hJwN8QkGQFBzJWzpmB3XbH7BBWwXNvj/+1RgbmfuZcp96Rc92z96MIP
	z9jlw8fpN9mtUwN2IpaYfrcqAXwlLfH75WUuBJbmMfp90CHPiochSEjJooz+u02fYV/Hfu
	qywhLPccjla3PgYVS+fTTEo00R9p1xI=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Kevin Cheng <chengkev@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] KVM: nSVM: Always use vmcb01 in VMLOAD/VMSAVE emulation
Date: Sat, 10 Jan 2026 00:48:18 +0000
Message-ID: <20260110004821.3411245-2-yosry.ahmed@linux.dev>
In-Reply-To: <20260110004821.3411245-1-yosry.ahmed@linux.dev>
References: <20260110004821.3411245-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit cc3ed80ae69f ("KVM: nSVM: always use vmcb01 to for vmsave/vmload
of guest state") made KVM always use vmcb01 for the fields controlled by
VMSAVE/VMLOAD, but it missed updating the VMLOAD/VMSAVE emulation code
to always use vmcb01.

As a result, if VMSAVE/VMLOAD is executed by an L2 guest and is not
intercepted by L1, KVM will mistakenly use vmcb02. Always use vmcb01
instead of the current VMCB.

Fixes: cc3ed80ae69f ("KVM: nSVM: always use vmcb01 to for vmsave/vmload of guest state")
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7041498a8091..4e4439a01828 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2165,12 +2165,13 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 
 	ret = kvm_skip_emulated_instruction(vcpu);
 
+	/* KVM always performs VMLOAD/VMSAVE on VMCB01 (see __svm_vcpu_run()) */
 	if (vmload) {
-		svm_copy_vmloadsave_state(svm->vmcb, vmcb12);
+		svm_copy_vmloadsave_state(svm->vmcb01.ptr, vmcb12);
 		svm->sysenter_eip_hi = 0;
 		svm->sysenter_esp_hi = 0;
 	} else {
-		svm_copy_vmloadsave_state(vmcb12, svm->vmcb);
+		svm_copy_vmloadsave_state(vmcb12, svm->vmcb01.ptr);
 	}
 
 	kvm_vcpu_unmap(vcpu, &map);
-- 
2.52.0.457.g6b5491de43-goog


