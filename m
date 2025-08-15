Return-Path: <stable+bounces-169669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B726AB273DB
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF68602456
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0F204F99;
	Fri, 15 Aug 2025 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uF9B6J0t"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6741F5434
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217566; cv=none; b=bUGWnXsUfgT/IaHD9ChXIKR70c5ffakU5c1QNIKlx/Jc1qOyokIvCQrHGlFCdkrnqw+oVLoOGyUpnQvj4et5T6+rrs7b/MEf6QmK8IOzYEU0hHTvzmCcrFmHdTxyPVq69Kxb28qUZ7a6WBLhGYqsXu6QijzJIC/rd3emBG/No5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217566; c=relaxed/simple;
	bh=YkeK0+sBHNvehHuXgNtAfc5wNbib/MDo60witDlyAkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=is59N9ui1ETfoBu+Sb5YBOUeUmbOuGkFQeiI5ToG7uanZb7e0BC6uFY7nymtuxqiVyrZbsJrl8ppMjRuW4PkIaIqT+UsXOLTGlVJUpvWDPXDvDkIPRTdkUfbJyklACFaYLTMvm5uUk6J99MUCkqTXkk5XRm30ksV+nGnrMEqBrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uF9B6J0t; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458274406so30605535ad.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217563; x=1755822363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PYvY2Sr9Oc1f4jEaee72DUuWJudzSEujeEG9ujSrm7g=;
        b=uF9B6J0t6SIqZAaYkSShyzgbqDWOmIzTExRGcU78MzF2vMi399dDxZcUjj8gSLGHhK
         vjWGEjwI0sG343M322JH8oC6mxf9ztEXd17qpNxaCQGci5y5KQZdjej+zdqlCWeDYrTt
         dejyRG1baqfICGlbM6c6vmIra/ah5yFyoR2LSk4Y2b1eMCkbYBk1uUgwJrGMINBp0lae
         4Yg8zzN3xu7jBr0e/yPZN93EFwXh6Kw17qaVzy1T3l23D69EQ+RkyRCVfFy5oIkBz1JH
         q0q5HjeJV5yyzqFPe4cFDdzTeOYl61xOUxVucHjKrwB0jR0hQQaLaWqrt85+VovAT8Vy
         riNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217563; x=1755822363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYvY2Sr9Oc1f4jEaee72DUuWJudzSEujeEG9ujSrm7g=;
        b=IFG5ACNqNBZSFDKpqsF7GWxrMOP/weTKItcH7p+ZjB3Jg73lKAx7mvvGY37bhCp1Gi
         OmNDiJOgoT5PHf15xgK0kM+utsxAGzRjV5ykVajwHmI8RooiV5kSsxlUImwE/W9soJ7N
         qXctyJnQCoTak9HJT5J6FRw2BPzQrFaYol15AYug7mNEBr/vCfuf3kzdxlqLtJ65gBbd
         4e0Ppn00DlD1dAoGA1AePbU0er3eUSFsVySq5dJBW9Hi3sFHm9RBG2o8tCFz7jwkhCwb
         QJu364RWBkQXXvr1QQZZGPXzU44l4Ksn3A5AMYsv75BVAeAf99gA2I0mfeBE8m2b/c8t
         MX/A==
X-Gm-Message-State: AOJu0Yw5e0bUimVohDRFBuepVDpQeTD/WJs3I50cz/RUkgSf/nQGfMy8
	RxN/q+OK3NvZ7Q+O0HzmYSVcug3mwOHPJvcDnxKk4W4pwIYKi9BEF1fGhS30eh4UBIt3UsPqv39
	y9hCO6Z6hyDLSayaJ1DvxlFUiQBg/BxyvPT7EiR7MHuGCZUMBbFFPytYkmbYjhG6YUs7cS2DTlx
	YTEA/TgWNhqFPquDXyUdDh/+zxFGWGUWhu0gOL
X-Google-Smtp-Source: AGHT+IHsjF30T9KKGUIEbxZ0Ho5Yny/Gtu6qUWgWc0dpfdUesJGzLVo8k9vpXMQxwjUaaSSe7yJ3zq8qLk0=
X-Received: from pjc7.prod.google.com ([2002:a17:90b:2f47:b0:313:274d:3007])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b4c:b0:23f:f3e1:7363
 with SMTP id d9443c01a7336-2446d73e7c9mr1820395ad.23.1755217562684; Thu, 14
 Aug 2025 17:26:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:30 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-11-seanjc@google.com>
Subject: [PATCH 6.6.y 10/20] KVM: VMX: Handle forced exit due to preemption
 timer in fastpath
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 11776aa0cfa7d007ad1799b1553bdcbd830e5010 ]

Handle VMX preemption timer VM-Exits due to KVM forcing an exit in the
exit fastpath, i.e. avoid calling back into handle_preemption_timer() for
the same exit.  There is no work to be done for forced exits, as the name
suggests the goal is purely to get control back in KVM.

In addition to shaving a few cycles, this will allow cleanly separating
handle_fastpath_preemption_timer() from handle_preemption_timer(), e.g.
it's not immediately obvious why _apparently_ calling
handle_fastpath_preemption_timer() twice on a "slow" exit is necessary:
the "slow" call is necessary to handle exits from L2, which are excluded
from the fastpath by vmx_vcpu_run().

Link: https://lore.kernel.org/r/20240110012705.506918-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 32b792387271..631fdd4a575a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6027,12 +6027,15 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
 	if (unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled))
 		return EXIT_FASTPATH_REENTER_GUEST;
 
-	if (!vmx->req_immediate_exit) {
-		kvm_lapic_expired_hv_timer(vcpu);
-		return EXIT_FASTPATH_REENTER_GUEST;
-	}
+	/*
+	 * If the timer expired because KVM used it to force an immediate exit,
+	 * then mission accomplished.
+	 */
+	if (vmx->req_immediate_exit)
+		return EXIT_FASTPATH_EXIT_HANDLED;
 
-	return EXIT_FASTPATH_NONE;
+	kvm_lapic_expired_hv_timer(vcpu);
+	return EXIT_FASTPATH_REENTER_GUEST;
 }
 
 static int handle_preemption_timer(struct kvm_vcpu *vcpu)
-- 
2.51.0.rc1.163.g2494970778-goog


