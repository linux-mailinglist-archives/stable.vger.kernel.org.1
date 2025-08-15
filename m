Return-Path: <stable+bounces-169670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D5BB273DC
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EE85E754A
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384E1F5434;
	Fri, 15 Aug 2025 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4BO9ag9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42362202960
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217566; cv=none; b=c6nqtjk0WjJAtpElpWUoUc7u/4RUjuSord/LZpzqiyUq28abLRYB+kfZfEzaZPpNwVU8FKQZCGrvkhlaLr0rP/0WsomHlZ5FHg3IgL7vhFfUkxEAV6IJJIeFGDdsDBA0NzuuHNtXi/cO0oEaYXxQZbG5HUZtgN3Ras4B6JmNtp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217566; c=relaxed/simple;
	bh=4HLcCjbausA3eoVQrOGl1gO2kwc168ccN7lc3Po/lf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e5fCjKNWKJb5OlMTg8HwFQDu4gpGFSPzLTVY8UDapMRkztflDoK11ym3+9UWXi0ESQiVRSq+cR3JB1TCQ5KI0ax6i5JBsJ576Re83mPEvKtaaF/e4GZPwdZK2RdujlwYpWtemOmHBayZ+yXhYvRTPTAkbaEOjrRFK45MuoS6+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4BO9ag9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3232669f95eso1469048a91.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217564; x=1755822364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IMEGPXNdBJlGJ8bO8wbUcUjLikv8xvB0yfWaV9VU0Go=;
        b=h4BO9ag9sxLQ8qJ3HC9HZDSwXzBKDMB1nvsG5x/Eb/6RmV3kzyVYCTLgaQ6Y5dbFQy
         QYEPdh7MDtQgNVTP0mZBkVR8fylb34V3jWN9BHnyOQnhcoXRgM9Y20aRdScT5RUPzPjD
         jsIEnLvpv7DZqKalT6n/bn8m9LlGid3lZkdipxf0Jms6fw7LvZQleaDmqRgrrhDkbbLP
         dYY2O3nL+rtqgIWCJFOwwvbsQ6w+KEHzr18M55gWfU7OaFqIS9mtFXzDJcI0jYwxmhPZ
         u+J0rN3E8vHlOlpMRDu546TbNmkSYLHq69CPXmRufMiJ+/IToURY9K1swz7HHbOiaOHq
         jxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217564; x=1755822364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMEGPXNdBJlGJ8bO8wbUcUjLikv8xvB0yfWaV9VU0Go=;
        b=mABS4KElaP+xiF7hLzHYLPKIWbxN3GIKZh9zxMMXr9NveQs0OlJLN283gODox1xJZ0
         PFaz5A0Eq/QvU3IW6RW9/LmVqb4fZd4x3i829sokLpOmtIi3z3jD8NehIs3nWQRWzp0/
         bHZqhM+Df5FLsHB3MhXlfa9MAvZFa4Nu9Dp9MiyjK0JnoQrWqyzSRBpFNt0HoOVlko+M
         FmVs8OB+vHxcg469b55/HtE1+dJdwYOvwxteTsC0m4nxnrUoIBHnLnS9yOK20JBRa+Qw
         GrvPWdpEddIc79bYEWNfaLAcgybzyim5XDkut67mtticusta+Ow1NSpLcGXd4gp5Q5Ci
         r5Ug==
X-Gm-Message-State: AOJu0YxKDeM9XLm9eOIzEJ/JA8EAHlwN/rHYxJR2m6ja2BSGEPSZGUi6
	9vUtMKsdcHRPtSpCgfyAXlklfV9W2tiyzdyTJcSuNtGkUc10W2nSiDHgX7IwBHIf9nfw36qDoNy
	9LiUzboLgtEGaJ8P1ZqdMQsok+R7GjB9+BUyX89vMqPgj73KPkS6rrRRIr3E0b8zkhI/nhWdaus
	o9TC4Wgw7WPAJRBOdHZ+4hwompDT7RUmWJHQnJ
X-Google-Smtp-Source: AGHT+IEa5l9DZtDfSQ2yyw8HyBbrhYk/nGXUVV1TCU+KUfQUicM7eFfRl07ZUYWp5hXfhJ/1H+E8hTPVXRA=
X-Received: from pjv7.prod.google.com ([2002:a17:90b:5647:b0:321:a6cc:51c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:254a:b0:31f:335d:3424
 with SMTP id 98e67ed59e1d1-3234215b4c2mr294304a91.27.1755217564473; Thu, 14
 Aug 2025 17:26:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:31 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-12-seanjc@google.com>
Subject: [PATCH 6.6.y 11/20] KVM: x86: Move handling of is_guest_mode() into
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
---
 arch/x86/kvm/svm/svm.c | 6 +++---
 arch/x86/kvm/vmx/vmx.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5a230be224d1..f42c6ef7dc20 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4157,6 +4157,9 @@ static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
 
 static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
+	if (is_guest_mode(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	if (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_MSR &&
 	    to_svm(vcpu)->vmcb->control.exit_info_1)
 		return handle_fastpath_set_msr_irqoff(vcpu);
@@ -4315,9 +4318,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 
 	svm_complete_interrupts(vcpu);
 
-	if (is_guest_mode(vcpu))
-		return EXIT_FASTPATH_NONE;
-
 	return svm_exit_handlers_fastpath(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 631fdd4a575a..4c991d514015 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7258,6 +7258,9 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 
 static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
+	if (is_guest_mode(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	switch (to_vmx(vcpu)->exit_reason.basic) {
 	case EXIT_REASON_MSR_WRITE:
 		return handle_fastpath_set_msr_irqoff(vcpu);
@@ -7468,9 +7471,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	vmx_recover_nmi_blocking(vmx);
 	vmx_complete_interrupts(vmx);
 
-	if (is_guest_mode(vcpu))
-		return EXIT_FASTPATH_NONE;
-
 	return vmx_exit_handlers_fastpath(vcpu);
 }
 
-- 
2.51.0.rc1.163.g2494970778-goog


