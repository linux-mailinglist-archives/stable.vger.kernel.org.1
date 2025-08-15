Return-Path: <stable+bounces-169668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CABB273DE
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5335AA03CA8
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CBE1F4717;
	Fri, 15 Aug 2025 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoCoTso/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387A1F0984
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217562; cv=none; b=Md55YJMrYgXm/Lib1u2UlUeDoUyW9WiLfU+kg3nOz06eRhammICuHJcMvf3vaZzgJpurRmef0wCHClLOWHZVWudQRUpMdo3W4ZMw8hoiIP8Xj1jkpq2GjH5Ga487sz0ghPBiPqwEqxixFW5lQ/YnYgsZOqqeY8CJFXhKU36nfCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217562; c=relaxed/simple;
	bh=Q/JHGW57EuoJgXK91IfmuNQ8KxhAOb1XQxaQXnOBkn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fPQuyCc78ThtM/3e216rRlTkhNZJaiFGn76FTVS9Xo1tJR6woEe1onVTitkBDsEIf400H4XJWTt0nekDodMtMksdt2d7WR454Lykyt0HnKi3C/PnLJ3XJN3d8utbk26pKor/omVbRduIvM9rceMZC16LiX0vo8z/0ONl9AG8Hlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SoCoTso/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e09c5fso1543244a91.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217561; x=1755822361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4mlGOKyaWuNfcpdQevvY9rMQD5UW3bPI01VSmQ330+0=;
        b=SoCoTso/kPh5Rnq6hzbd7AC05BnKXDsD8GVAycP+SjKHw/RtELMuZDMMfIhOI9yQ41
         jfHFkm4vQ0doL+reYbVJAfY9G7n2ykwwRPDLP8RUT6HcWHiLu3Zr+EI7oi5NBQZyLBo0
         K6GR+6unqhedbV1F98WMe/fCFKihzo4lEiznwVdVo/qL4xovro3TjTZlNGcPnhbNCAY6
         Q/F/MEpjpwrGHPzku9CyRFCtkPW7C9r3jUq89+SuKT1Nf3c7fsRC7OLP+xi/Tz7As/ER
         hz/esk9amG+YFL5Hb2rF2dLGmkMq3qJs4ZN7HXiwYHRM/XsLao2bkIoE/FHTiteVQFl2
         SF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217561; x=1755822361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mlGOKyaWuNfcpdQevvY9rMQD5UW3bPI01VSmQ330+0=;
        b=p7c7QjSXFbfwwkN82iotESxMRHX8uFQVk1n/ElRMK33+WzlZ9U26Iryq5bI0aL5AVf
         hqdQmQoUyiDpM19A5v/uFZ8IdXIcRIu2Ek9aHSli7o6csg7OCj7AZqfBlLGbxhSOKlCx
         f39UnivzGoTHw2nOXYJiGRiYeBKZiOrfjH9IbJfg030QJ19bKK/xPFeiZVQ8L0AsVAbO
         Q5dqBYXy5swGlIi3fJKRP3sxRF8M5Alk89WgRPaxbMl63Lb6PjdJMnCEcFP4V0fwTz3c
         ZmRAqBdGUPXt8d+tzoST1aRkQXPPR1DyzxJO7HXpebOfRRxO3/oP9NHkH2NDljE/bk/4
         R3Aw==
X-Gm-Message-State: AOJu0YwkH8w+DA86ITKRWdGvaexb6DeqN+8sflX6XfUYqIcUyOCFiR1e
	W56LswoeK0clJ00K1nokZUHYbu8vdTxWXa4SlsMZEcXa1FQOpRCISK3xxxrHTIlc9q84Kln+pLQ
	y5BZW3xkXpWOrsiFwTC/HitDscqlTd0b0FbdpiTWQVs4EiYzL3N41wUcL5d25IWs3Z8QDq3kUXY
	FKFxeIhANxCE+y0A7PDu2LKaHB7Cj7Wrf6Uy9w
X-Google-Smtp-Source: AGHT+IFjfpyiGFmFU4A8fVbY8HVbYLaMXLnxr98ykfXT3ShMDpAtm6QKzQ4bmfCIms/Lng092ujyzrsTcVs=
X-Received: from pjuw7.prod.google.com ([2002:a17:90a:d607:b0:31f:6965:f3e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3948:b0:31f:12f:ffaa
 with SMTP id 98e67ed59e1d1-32342163830mr293347a91.6.1755217560575; Thu, 14
 Aug 2025 17:26:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:29 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-10-seanjc@google.com>
Subject: [PATCH 6.6.y 09/20] KVM: VMX: Re-enter guest in fastpath for
 "spurious" preemption timer exits
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit e6b5d16bbd2d4c8259ad76aa33de80d561aba5f9 ]

Re-enter the guest in the fast path if VMX preeemption timer VM-Exit was
"spurious", i.e. if KVM "soft disabled" the timer by writing -1u and by
some miracle the timer expired before any other VM-Exit occurred.  This is
just an intermediate step to cleaning up the preemption timer handling,
optimizing these types of spurious VM-Exits is not interesting as they are
extremely rare/infrequent.

Link: https://lore.kernel.org/r/20240110012705.506918-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ee501871ddb0..32b792387271 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6019,8 +6019,15 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	if (!vmx->req_immediate_exit &&
-	    !unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled)) {
+	/*
+	 * In the *extremely* unlikely scenario that this is a spurious VM-Exit
+	 * due to the timer expiring while it was "soft" disabled, just eat the
+	 * exit and re-enter the guest.
+	 */
+	if (unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled))
+		return EXIT_FASTPATH_REENTER_GUEST;
+
+	if (!vmx->req_immediate_exit) {
 		kvm_lapic_expired_hv_timer(vcpu);
 		return EXIT_FASTPATH_REENTER_GUEST;
 	}
-- 
2.51.0.rc1.163.g2494970778-goog


