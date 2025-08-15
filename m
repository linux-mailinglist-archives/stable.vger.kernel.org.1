Return-Path: <stable+bounces-169650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B773B2737F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 977F57BE9AA
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C552116E7;
	Fri, 15 Aug 2025 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvqmdVpv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B12046BA
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216758; cv=none; b=VVRwGf6jafLSaBKuiA5DvyWlLn+c7yz8VXFDigS1ugNw4Vf7cBIyOWph/ydxzO7wS65bMG2rALofQGRs0nbo1Uvyd43LoyACkU2QoZp78Orhdkxiv3eOMhXg/mtBSJCDoDqGHYNtfG/UArntg2TktNXvVepugtl1PiSpz7mkCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216758; c=relaxed/simple;
	bh=K45y4oY618XxqPpW0fSd+M48YvCVJ5OhxcpoKJCPJLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EPfJI9qEEae1XNTkH5yiyVmPQJu9wyu3THBH5Q3eHKbhY2EgqllcTW2WBV/3dtmxSpEfEvrUKE9FbMxESd06H1sGHWduPI/K0Ox4mTwXZep5RxPcRcLYIRVC6+SRQFsKywvjL8rKuMGbhzhfqyGWYq1JjiotvSSe+I/0eUmH8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvqmdVpv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e6d8a9so1583320a91.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216755; x=1755821555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=A081K7Vxl6mjJzXEGmaHtEMcM0O3QUXdDAu/aDF05mY=;
        b=TvqmdVpvY/zWAxyxp+LBS78F/dqrCLAIpPNVxEBDvgOtf27t6irErUMg0vqp7BHHym
         XQBtVNP3raT1m7x3iu7VHCA+kbchYgOkOLU6JTgaGKofTjcn8Ns5E46Edq0/SKd1C+oj
         WlURRKFt/OLJFmlWIekzk2svqgB+QACHkunewOINHnyWebx+MT9ngR15A97nzGzp6mkx
         cNjDnDOCBw54pSg4oSAqDSXapefr+jMb5BUjuXm+7Noe/SI0TGBVMwmEjU1IzGJNVEcG
         +VfCF3HRYZKP4icpnDbpo6mOFULGhqs3rGe3jP+gI2P4Z4AAvM+2606i/9Qe3+l6pPPy
         RClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216755; x=1755821555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A081K7Vxl6mjJzXEGmaHtEMcM0O3QUXdDAu/aDF05mY=;
        b=YP/uu1St7Z4GJX6Rlb0KPXBFQ6Njxvv4FZDCZc/xFrJbmxwKG0LejkbgfmJ0Rd9+r0
         xsUSAIf/J7YKRZZRJBHP4Xu/ITdqIXQU1TfmVFidMfU8dbbQJ5t2iQSDCcwSP6om1L0H
         OJsjwF2nWLCrE++WuX5pCW/zULet6ohAwuBmYM4EHZ67969vfpyYqG6hOxjJqtqk+/4b
         yhuE20JyJufeLeRVeNhVWE4WeuozWRN9c5n5utGRYxSTB98PW+3PhiB389ivLgv4jc5X
         yngAzzOI+5irIPqGJrxWRPijjA9QUFWGBFLm+KTYCeJusy/F9HgxUQMmr/E+W4+jiify
         jdhg==
X-Gm-Message-State: AOJu0YzJSrxa9Y6+S1NeO5qGviuXwx80WkzODd3vtkAEyQbZHgZOCaua
	y30TBo6qtMPuQGCg8HtpmTUhh9GE6jPdWlDCddh/lTgU0ynn9hlAvBxdDN9TZzTR63UEBHbE0nh
	RPdOPhQQbgXnQmui4p+kO2t34nPuDb0qYdAn7g50KsbG02b1QnKMbV5uxVkcoZKmv2COGA5K9Yw
	WQYW01upg6y15L5Vn87jcSZXBw6BLpay4sD2DZ
X-Google-Smtp-Source: AGHT+IHyQTBLqAZEkEEr74CWBCFhJKsIaas1PzPmgFEdWLst5iOyF6eTrA8Q7itvt8DfCaBEBiBohqtDZ/4=
X-Received: from pjbst7.prod.google.com ([2002:a17:90b:1fc7:b0:321:6ddc:33a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:278a:b0:323:28ac:3c59
 with SMTP id 98e67ed59e1d1-32341ec4ad6mr240224a91.13.1755216755117; Thu, 14
 Aug 2025 17:12:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:57 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-14-seanjc@google.com>
Subject: [PATCH 6.1.y 13/21] KVM: VMX: Handle KVM-induced preemption timer
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
index 18ceed9046a9..4db9d41d988c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5948,13 +5948,26 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
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
 
@@ -7138,7 +7151,12 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 
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


