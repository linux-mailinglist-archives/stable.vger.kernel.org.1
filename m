Return-Path: <stable+bounces-169647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B30B2737B
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1469E470C
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523D71E9B3D;
	Fri, 15 Aug 2025 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgSVV3qi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EE1E260A
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216752; cv=none; b=K1TqRT1++rJhvg8HyBr5hF48YaKSkpj9CWV8t+zp+qfwWVLCFE5xAp1cEN5CYCqBHWasoPspk0uPvJowFibTLlI7N9gpYuN3rEfspBj3XZn2u5eyjQJQPMphCiv3K15YB+/EIlJvVuCtFYrUWckeMS3wAorXuAhIbeFSp7mjOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216752; c=relaxed/simple;
	bh=bvDp4MOWnvUg7G9Pwr/XZYkF2LA55VcOt3qLgd8IQvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ndBBa6awZjUoDPKFy9CuTNbIJjg6CTAtMSMefsZ2lfsSQl28RnNfybfdIUoxJs3q0g55ym1c50DGSAYQgqNLYEO+EL0Aflqz5mr9S/aCB5HjrgQYD7c8YFexXIWkmFweishmj4dh7bk5fpclrxvPWiBhY+F+EWuxq0SE5aUyl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgSVV3qi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244582bc5e4so16391075ad.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216750; x=1755821550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BqNFRdZp4dZOuhcg+tVI2WIxCzfFJg3qux8SRQQatZg=;
        b=ZgSVV3qiulTNeH5/itel50oP2lVOq3E3lm/pQ3Wgxy9TnNXMM22KFJXI4jjs7dYTuB
         puJYvLma2WWF+POCRCr8svbkF/l5F54wU9SOzRE+j0dRLHa3anjqztVkoMXX4dmaX6wh
         u+0e2X15Vb1cXIx3t42rvUBt1eDaeU4le4tn7hHMlD/OCibta3c+nx9eARZt9fWTB1vI
         q70MwMGl7BFWdTyMNe8cuiUWd/IlzhZkI/CqoRE3ns+MwKFniAgAa7P4z8c55o/HNBkm
         Ms/VSkCmffmJOD/z2VkRc2FJJBIkedzc7etA6FaPcCDwhZIoeT6gXAxjBB8vqKj7rckB
         QI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216750; x=1755821550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqNFRdZp4dZOuhcg+tVI2WIxCzfFJg3qux8SRQQatZg=;
        b=pYxz849vwGko34YUYIawTgNkf2WlkW9LDaWRldv65T18B+/o3/6IQK1Y6oRxA6fu/n
         uB2+rHmX+qIrzaSv5xpybWugA0YS6kt10UmpIrfcB3LbNmMO+ULHXc6Vb7WI8uP3Fc4u
         UsZQtwZ0BrM/MIq+9gujRDhCP92XufTrKecgGKbrRo8H6OzHBX1fjHSOt7O7yiIRFpxh
         G0nVBePdmBgpl7gKSG4bvozkBnFRouRARY47MK4lifMKwa/OeqD31smgSNJu6jXnu2c/
         sr5hQLictzaIy/6Pex627RKt22QdBfT3xBxMKp8h7Q7kNnEBqJ42aBgcN6vofBx+Yq3K
         xHNQ==
X-Gm-Message-State: AOJu0Yxn2ohfp/xNbhqBOsiWUf1wajnoRHh+R/DtglceUbp/4bSE3Yw3
	GLeAi+MgKe2vHi+7ZDI9I/Hy7mqy/1lersACRg6xd/Cp+hwcZ/g0GQBikP9FpI+IxsTJnvOcRjD
	ZCJzpQdJmyFUrBbOFpX/zxHwoV1pMpmITDAPSljdBHsqBCCfSh2hILuG1LHj/ZqBEkMcVDqpBpS
	yxYRTo7Wb0GaJHH55MGn6Oi7Zb+Y1OlVPlhfvj
X-Google-Smtp-Source: AGHT+IHsUD4IEXcOJDddmNyAVMtxzUdZNE4LwkwjB6Xni2icG5GH9wBulaAHQkFDZ2ytKoB6uP5ydyFou3Y=
X-Received: from plbkc6.prod.google.com ([2002:a17:903:33c6:b0:240:7619:64aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac6:b0:243:ead:f694
 with SMTP id d9443c01a7336-2446d6f6e46mr1645445ad.17.1755216749987; Thu, 14
 Aug 2025 17:12:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:54 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-11-seanjc@google.com>
Subject: [PATCH 6.1.y 10/21] KVM: VMX: Re-enter guest in fastpath for
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
index 0b495979a02b..96bbccd9477c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5933,8 +5933,15 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
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


