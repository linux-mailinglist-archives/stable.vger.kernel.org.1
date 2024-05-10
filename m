Return-Path: <stable+bounces-43535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD38C8C256C
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 15:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8F11C21082
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CDE129A8D;
	Fri, 10 May 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zb5EiwBx"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB088376
	for <stable@vger.kernel.org>; Fri, 10 May 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346750; cv=none; b=kOA3iPxeQodMRP1+nGVqQoNX1utFyScVkObTHXZBrA2ksuIchxg6EeYjKRLKGgYC4Og+cl4kdG/0RWUFVTLXVUEyxxbR1SB3kFbmmDKR0jyGl1SFExI6r/9w1K+n0z1UsZheHjme7U5K5kXBwEDl/ULm1Op8pRdNqWhPHoBVrSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346750; c=relaxed/simple;
	bh=/x7i5SEvsx6cocA5ZuRUW9PFSvTE9jk5Xwy1lNLXUzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obJrsWHBAHCIWOn4zry/1LMnFEtHijLwPa4gg+KPM8r6x40q9yNk+XP1mR73FPIv9vnBdoD+LybjQQ63vNYupeogl2vJaMRGvVPyeli9fazqxQ7lTzsZvK70ehuw05JhuQSWLLJc4XjGnYTLo0gojB6u00wbdgYL+Pbyvr79X7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Zb5EiwBx; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715346749; x=1746882749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j6OIvQmd7lgl7f2SPakgTVK2FW+8tLakVHzc9UelY74=;
  b=Zb5EiwBxgCfcRrXsuZFJyj/J3XIgQE3hp2N8QEqIb/LlRSyBPcRHkyMV
   sS3NUjsT81QUnzrTlJd6Xi2AHqTKsZYB6jhspOyWNqZry4DFBGl+frz18
   XdcmHJhdQoWJGoUnig/FUMg7mDOYVZOyF8sIvtHZUAUU06B/xfy8w4t9A
   g=;
X-IronPort-AV: E=Sophos;i="6.08,151,1712620800"; 
   d="scan'208";a="725613172"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 13:12:22 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:17651]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.206:2525] with esmtp (Farcaster)
 id 2795dce3-0802-41ef-81cb-58f4913aab40; Fri, 10 May 2024 13:12:20 +0000 (UTC)
X-Farcaster-Flow-ID: 2795dce3-0802-41ef-81cb-58f4913aab40
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 13:12:20 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 13:12:18 +0000
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: <stable@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Maxim Levitsky
	<mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Nicolas Saenz
 Julienne" <nsaenz@amazon.com>
Subject: [PATCH 5.10.y] KVM: x86: Clear "has_error_code", not "error_code", for RM exception injection
Date: Fri, 10 May 2024 13:12:13 +0000
Message-ID: <20240510131213.21633-1-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023041135-yippee-shabby-b9ad@gregkh>
References: <2023041135-yippee-shabby-b9ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
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
[nsaenz: backport to 5.10.y]
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>

Conflicts:
	arch/x86/kvm/x86.c: Patch offsets had to be corrected.
---
Testing: Kernel build and VM launch with KVM.
Unfortunately I don't have a repro for the issue this solves, but the
patch is straightforward, so I believe the testing above is good enough.

 arch/x86/kvm/x86.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8e0b957c6219..bc295439360e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8501,13 +8501,20 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
 
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
 	kvm_x86_ops.queue_exception(vcpu);
 }
 
-- 
2.40.1


