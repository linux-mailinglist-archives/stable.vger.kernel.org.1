Return-Path: <stable+bounces-43534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5518C2568
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 15:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADAF286EAC
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666DA127E01;
	Fri, 10 May 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="av6cL/ER"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97365128376
	for <stable@vger.kernel.org>; Fri, 10 May 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346624; cv=none; b=d30l0QsRHW7/KH+g5RcmXGi4ALMyJoc0p4YO1RKz0lgIdTGk1qVL6uKQHcQZTS6nCeRudaQ+61IuFpXHu2u+496w3p/3kYPCkQd8TZa9/x4ttgsqt4aZbA2YgR/n3YGQLfnPB9yYtm5wcGjZRpCClc1BAwvmjGUHxG6YGxX5YCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346624; c=relaxed/simple;
	bh=YPh8afcVw92+X6XisXBWRgmBMjos/0M0yl5N0WmX0DE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKSl5wA234UpUceBi0hIWjvWtf3AGNHha8QGh7Q0dcvf/JIbkMjIoGIpuS/6vFO4r7SPh+L95VGPV12NzHN3n1REQO1qr75h1XD7AsqN4kTURt5JIu7vCgqwg7TcuBKsxiqyfPCaIxogzWA5zwiGY1g6T5FOrNNgR+jcgpMJ9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=av6cL/ER; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715346622; x=1746882622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pMGul3kdFFQtFeV/gdPftc+VZ0/er+VIB8MbJtDJ988=;
  b=av6cL/EROaOuu1jzQI7r1bm8KH4+zl36OEW3tzPiAswYxFRNJExR+NxQ
   tzQ5I5aJENAgYrBgPPCz5tTui4bYVk4QwTdwQnXqulgtDlI1EINA5YUVE
   BlwGWEqqJJIu4hKv/S78nJwxgKFjDMAsRbMDr9lTqX1+aeHstfqqwFirI
   E=;
X-IronPort-AV: E=Sophos;i="6.08,151,1712620800"; 
   d="scan'208";a="88394371"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 13:10:20 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:38242]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.206:2525] with esmtp (Farcaster)
 id c5596967-743c-41f7-8693-4bc076bb6bdf; Fri, 10 May 2024 13:10:18 +0000 (UTC)
X-Farcaster-Flow-ID: c5596967-743c-41f7-8693-4bc076bb6bdf
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 13:10:18 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 13:10:16 +0000
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: <stable@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Maxim Levitsky
	<mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Nicolas Saenz
 Julienne" <nsaenz@amazon.com>
Subject: [PATCH 5.15.y] KVM: x86: Clear "has_error_code", not "error_code", for RM exception injection
Date: Fri, 10 May 2024 13:10:02 +0000
Message-ID: <20240510131002.19689-1-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023041134-curvature-campsite-e51b@gregkh>
References: <2023041134-curvature-campsite-e51b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

From: Sean Christopherson <seanjc@google.com>

When injecting an exception into a vCPU in Real Mode, suppress the error
code by clearing the flag that tracks whether the error code is valid, not
by clearing the error code itself.  The "typo" was introduced by recent
fix for SVM's funky Paged Real Mode.

Opportunistically hoist the logic above the tracepoint so that the trace
is coherent with respect to what is actually injected (this was also the
behavior prior to the buggy commit).

Fixes: b97f07458373 ("KVM: x86: determine if an exception has an error code only when injecting it.")
Cc: stable@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20230322143300.2209476-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 6c41468c7c12d74843bb414fc00307ea8a6318c3)
[nsaenz: backport to 5.15.y]
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>

Conflicts:
	arch/x86/kvm/x86.c: Patch offsets had to be corrected.
---
Testing: Kernel build and VM launch with KVM.
Unfortunately I don't have a repro for the issue this solves, but the
patch is straightforwards, so I believe the testing above is good
enough.

 arch/x86/kvm/x86.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f781ba5d421d..7bfc037022ad 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9134,13 +9134,20 @@ int kvm_check_nested_events(struct kvm_vcpu *vcpu)
 
 static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * Suppress the error code if the vCPU is in Real Mode, as Real Mode
+	 * exceptions don't report error codes.  The presence of an error code
+	 * is carried with the exception and only stripped when the exception
+	 * is injected as intercepted #PF VM-Exits for AMD's Paged Real Mode do
+	 * report an error code despite the CPU being in Real Mode.
+	 */
+	vcpu->arch.exception.has_error_code &= is_protmode(vcpu);
+
 	trace_kvm_inj_exception(vcpu->arch.exception.nr,
 				vcpu->arch.exception.has_error_code,
 				vcpu->arch.exception.error_code,
 				vcpu->arch.exception.injected);
 
-	if (vcpu->arch.exception.error_code && !is_protmode(vcpu))
-		vcpu->arch.exception.error_code = false;
 	static_call(kvm_x86_queue_exception)(vcpu);
 }
 
-- 
2.40.1


