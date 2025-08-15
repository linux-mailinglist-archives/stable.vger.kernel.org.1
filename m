Return-Path: <stable+bounces-169671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D905AB273E7
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E61A05EA3
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB321322F;
	Fri, 15 Aug 2025 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utoFyZjD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F420C477
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217569; cv=none; b=dPPPHDB5Ez/g0hReBCXIOGvJ2AjwQPsFlkj/iaeW4aK5FWCBZwJ/qaNzWlNVPyIViOPXLsGQQW2w8X65k6dWLJdOo/ew5f4gvqmm9perooXchbKKr37QdWAhvdq8RnFcAaQqEbhsB19IDWKuvXXbxOW729aokbuaXCPhVRYlrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217569; c=relaxed/simple;
	bh=VztUK3cHn4S41Id+RLhikf3i5GOn/hYUcLl1EXozI3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=riMwx4kN3tneLg3cteWTHtwq9+miA2zw6pZVZ0dlBS+MIYOyO1mF9XPnRfLK2e8Tc8txiN50Ntce+dIvZvaHXtJ/zyTMwC/2geIU2/ZXJPVfMlhPRuB7bO2VgpBiY5qvrJEy7LOqc3QBAXWrppHXSakLyl/hUWa2YQVAlPgGXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utoFyZjD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266aaaadso1345096a91.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217567; x=1755822367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=j1EiiIuXzEcLgmSMmRJCG/oZIaaJYFDTMiB+4WGMfiE=;
        b=utoFyZjD0WuMFLSewnubw4yuLPoOncj7Z9+s9vPpqzJYkN5aaVfN0Mh5cGr9gM8AS7
         7z75O6+DWN0y3mh9sZL0Oltj+PfN8faAs+7JxPiGbLsLQ+eiOr3eYsdNwAKHv8VnwPhE
         xqtRCqMtaigIyV1hvdh+MdZ3kesESVLYWEKgFto1i0FUsqu2lqkMfvYZarI1UH/j40cM
         0Yy/NgsBvVsZ/84gDO/GT3VZARnD6TRedYiv/iy3JptoGYzkrw0cGqhPyDP54lacI/Is
         qn5HyfEYAd/KP1ciqyR4vyEyQo8lZDW+9LQMqgocFZneNhRUY3BIfT4zf1ga/WKgFccu
         oMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217567; x=1755822367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1EiiIuXzEcLgmSMmRJCG/oZIaaJYFDTMiB+4WGMfiE=;
        b=TWbXgrcMETbZqTi1M4wWiZrWwnjkqDPlFUNTeglcHU+/ZMozI6LqJS4qU+WYe7vSAq
         CpNupYMlduXMbpU7fBKkzGg8hFLJEXT4ztGvMZxefCYX2aSgkcsTsMmxwaFpUp5zn0Jh
         cgNylap5Vw7CTzMl/GQru2H/T8ldfQMa9ApsHmxWY7DZmFHutbr6g4vrb1ZWwE1wihJz
         Gz/Xh1tibS0/mvJsljVp9VevO+/eCxwcsVH0AYKdejRLfQQYuEbw7z39k3KEe3vlxWa+
         EYx8vyigmLKpE+/noxgWvJlG/MK0GX38DZei5sue5Dw/UNLlIaCw2caERmHthsJGDiqE
         BXVw==
X-Gm-Message-State: AOJu0Yw+7ZRyILq1kK4+XJ9c9DcVLobA133wSNx64k6Gavha9j6wp3F3
	P7NiqXrHeGYBfxcRQi6yRB/cVZ6viwByis0f8geqNCtOM6QGzCV+WChIgYUWDdFLJ+D3I2wr5UE
	8jDarz6s9qkcDZBzn4tBZRCtWkEJNkpnSKwQUkvc5RtKXd6n6OxY574bMThJVEpIBsuB2ZUXRhe
	Qibvo/5hGgfLnwAlbo0kklnb+xJr8UmGjv4TXc
X-Google-Smtp-Source: AGHT+IG3kNEPHVCTNCK6yFSl3v8wik71a42TL6j71aEhPq+q7dxE8jY14oeYIuRYtUdjc7Whn45/mLCZPpo=
X-Received: from pjbsc9.prod.google.com ([2002:a17:90b:5109:b0:31f:6644:4725])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ad2:b0:312:2bb:aa89
 with SMTP id 98e67ed59e1d1-32341ee92abmr346654a91.20.1755217566760; Thu, 14
 Aug 2025 17:26:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:32 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-13-seanjc@google.com>
Subject: [PATCH 6.6.y 12/20] KVM: VMX: Handle KVM-induced preemption timer
 exits in fastpath for L2
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 7b3d1bbf8d68d76fb21210932a5e8ed8ea80dbcc ]

Eat VMX treemption timer exits in the fastpath regardless of whether L1 or
L2 is active.  The VM-Exit is 100% KVM-induced, i.e. there is nothing
directly related to the exit that KVM needs to do on behalf of the guest,
thus there is no reason to wait until the slow path to do nothing.

Opportunistically add comments explaining why preemption timer exits for
emulating the guest's APIC timer need to go down the slow path.

Link: https://lore.kernel.org/r/20240110012705.506918-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4c991d514015..0ecc0e996386 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6034,13 +6034,26 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
 	if (vmx->req_immediate_exit)
 		return EXIT_FASTPATH_EXIT_HANDLED;
 
+	/*
+	 * If L2 is active, go down the slow path as emulating the guest timer
+	 * expiration likely requires synthesizing a nested VM-Exit.
+	 */
+	if (is_guest_mode(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	kvm_lapic_expired_hv_timer(vcpu);
 	return EXIT_FASTPATH_REENTER_GUEST;
 }
 
 static int handle_preemption_timer(struct kvm_vcpu *vcpu)
 {
-	handle_fastpath_preemption_timer(vcpu);
+	/*
+	 * This non-fastpath handler is reached if and only if the preemption
+	 * timer was being used to emulate a guest timer while L2 is active.
+	 * All other scenarios are supposed to be handled in the fastpath.
+	 */
+	WARN_ON_ONCE(!is_guest_mode(vcpu));
+	kvm_lapic_expired_hv_timer(vcpu);
 	return 1;
 }
 
@@ -7258,7 +7271,12 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 
 static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
-	if (is_guest_mode(vcpu))
+	/*
+	 * If L2 is active, some VMX preemption timer exits can be handled in
+	 * the fastpath even, all other exits must use the slow path.
+	 */
+	if (is_guest_mode(vcpu) &&
+	    to_vmx(vcpu)->exit_reason.basic != EXIT_REASON_PREEMPTION_TIMER)
 		return EXIT_FASTPATH_NONE;
 
 	switch (to_vmx(vcpu)->exit_reason.basic) {
-- 
2.51.0.rc1.163.g2494970778-goog


