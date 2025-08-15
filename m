Return-Path: <stable+bounces-169649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B2BB27380
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F319E50C2
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D72202960;
	Fri, 15 Aug 2025 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0pm1d25"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF81F5847
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216755; cv=none; b=mTk6B7JM3ynFB8UJ3Cf5TVoQnrTR7Jbe47wT6Msg+P4QgAiAJa6gBikPtllgBvpvwro9oGrnwdhrGyi8GmyPgOuuWkuyeAXka8UEKGjBV30gQSQhP45w8VN4ZEbhZt6gQlHFGKNIMuJTfD4WhmPbTPIUyYcAMmFW+UjWMXVyrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216755; c=relaxed/simple;
	bh=J5bjGgVJv9hmsbY0pSYL5E2uFR0Opy+IWAryQkIYkd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qetrvaIrweOkacnLGEFt3Jx+a/wCtleefPbNMUGzwbPA++22etPT4ZXYgMcvORqt04epN73+Es41oalfVnfyduXVcpqdHbaEkWrPpZA4f3u620HyrRBCdeSlEik9sXoYAjzU567H5JJgJy5NDK56kYkw4OC4iMcJQtNOdBNBNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0pm1d25; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f440f0so14969325ad.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216754; x=1755821554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2wMy9TJhpZES3QcM2QFYJyQalMsJ3q38AGM7XgsPeU0=;
        b=x0pm1d25D9//fOFJBt5hEv0tsXw43BvTuxsXo7ueo7On2EXOqzEzMcWbIiL5uxeaW+
         9GoQ4JXsgNVv2Jh30uB05pjeKc45+iUd9g+M9ypkZekGtyVuw2MrdfKq9Ay6BdsHT/gM
         9WI9bnL/VF7bVA4LeQaQmRSvnck6Qv9vYyCcpfc9mIkL1JZWdrPqwejYmlWA1jCvNTlF
         nfksVCN1B3uBHjeqSifFT6Y+5VBNidtJ+QD8iHlWyjTcXgtyArikc9vkNrP/JAwnok7X
         QwvYLiSfAtNlFSCh7alwR30M13OiWdzn2kT2VxR8OTODMguRrxZzXFHdgKFTkxd6eTe8
         Sb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216754; x=1755821554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wMy9TJhpZES3QcM2QFYJyQalMsJ3q38AGM7XgsPeU0=;
        b=wWBAyckZpwD77IklZikd8S6PhKjdx2zGmZi6jfUkpULLc636MlJmzvmfOUrCnoTWGt
         bCFVyYbPGu3PwkPWBzfi8rymlJ+N+SGxTcqloWrOwGxB+8l8AqRAWnjI+CXKLzGsilHo
         qRCyihlBZkvbpS8v+zG03XMzki83bh85yaIHLhX70/6bKf8QtbrF8A/h53GALO/kFlV9
         ZCOcPpA4kYH171i5LYNHYIy9kuddGSfCjiOK+3oF0XdkqG0RTxW1uYfHmMvYU7W2PrlN
         KpMbWIzY9bGNHOQptPLf6m964JjJxFXXR8fglLd+tdAH/3xxCH4W7slqyKQq6M878mkT
         kQuw==
X-Gm-Message-State: AOJu0Yy/ZmBVPNDbrmg7mZd0sC6Six4Vt0UTaTw97qGmj2D5MBl5pQOB
	KpAtf7t3IVin8hzfb4O30c+Qa5db06SHXOp5AgAZTX05yDQNEi0KRLcrnOTKe7yxNlktXSzFW2E
	wa6B/XM93Wtis4PQYMNHVwSXN7tj+N1cxHEZ+YtMAucbxi5tzJoo6tHY77nVqUfSpP1qJajYJkO
	Ezy9ptj6Tlb7OgmRLf6X6dgbgb4Sa+kdRFIinp
X-Google-Smtp-Source: AGHT+IEgo7vJgzcLT1RHaYoSqGTHO6Al4/b0zR+cP3g/V7QzZ9vp0b/qWYdJWt1FD0Lbuih760/NY1kEXkU=
X-Received: from pjbnc16.prod.google.com ([2002:a17:90b:37d0:b0:312:dbc:f731])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c6f:b0:23f:df56:c74c
 with SMTP id d9443c01a7336-2446d715b0bmr1607785ad.14.1755216753639; Thu, 14
 Aug 2025 17:12:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:56 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-13-seanjc@google.com>
Subject: [PATCH 6.1.y 12/21] KVM: x86: Move handling of is_guest_mode() into
 fastpath exit handlers
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit bf1a49436ea37b98dd2f37c57608951d0e28eecc ]

Let the fastpath code decide which exits can/can't be handled in the
fastpath when L2 is active, e.g. when KVM generates a VMX preemption
timer exit to forcefully regain control, there is no "work" to be done and
so such exits can be handled in the fastpath regardless of whether L1 or
L2 is active.

Moving the is_guest_mode() check into the fastpath code also makes it
easier to see that L2 isn't allowed to use the fastpath in most cases,
e.g. it's not immediately obvious why handle_fastpath_preemption_timer()
is called from the fastpath and the normal path.

Link: https://lore.kernel.org/r/20240110012705.506918-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[sean: resolve syntactic conflict in svm_exit_handlers_fastpath()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 6 +++---
 arch/x86/kvm/vmx/vmx.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b4283c2358a6..337a304d211b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3964,6 +3964,9 @@ static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
 	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
 
+	if (is_guest_mode(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	/*
 	 * Note, the next RIP must be provided as SRCU isn't held, i.e. KVM
 	 * can't read guest memory (dereference memslots) to decode the WRMSR.
@@ -4127,9 +4130,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 
 	svm_complete_interrupts(vcpu);
 
-	if (is_guest_mode(vcpu))
-		return EXIT_FASTPATH_NONE;
-
 	return svm_exit_handlers_fastpath(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c804ad001a79..18ceed9046a9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7138,6 +7138,9 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 
 static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
+	if (is_guest_mode(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	switch (to_vmx(vcpu)->exit_reason.basic) {
 	case EXIT_REASON_MSR_WRITE:
 		return handle_fastpath_set_msr_irqoff(vcpu);
@@ -7337,9 +7340,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	vmx_recover_nmi_blocking(vmx);
 	vmx_complete_interrupts(vmx);
 
-	if (is_guest_mode(vcpu))
-		return EXIT_FASTPATH_NONE;
-
 	return vmx_exit_handlers_fastpath(vcpu);
 }
 
-- 
2.51.0.rc1.163.g2494970778-goog


