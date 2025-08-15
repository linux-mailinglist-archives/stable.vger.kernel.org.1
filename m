Return-Path: <stable+bounces-169648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BED2B2737C
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3561CE112B
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F6E1F8723;
	Fri, 15 Aug 2025 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpVcUAZo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69961F03EF
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216754; cv=none; b=aelp8X5SCO9HcUZx38oj1qbzH3LhX06m4546fxA0+90q/092NFAz6MoysvdeNPu+Q+R957KgwqrjkZ7n4VWbnWqG2u2vu1XbO6z8ax5cgce1D1tcsDuMWF1IwlZ6bXqvrXk+ixWqnA+S5xy5nZoz+Jt7QQKk8vTEYlqCApf8Bvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216754; c=relaxed/simple;
	bh=LCntfj91WO8jUz7s5IHbhKB5AC6FTcDEfOnPfQM51s0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DKW319pf1N4hCRDrMCV3wFdFtWlU5Wb+hTTsLCTItUtZuicAvgA1McFZbb/dUP81pdz+dat4QsdawC5XimjPbKX1M6UvmUDivc2JKb76J5YYwVyzrTZMsAJILfwcqHEbmXpi+m1IZqJs+ZetqH2zFAqrzWxHEPRYqP9xeUbnpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RpVcUAZo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47173ae5b9so1008409a12.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216752; x=1755821552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yKPV7LpuHxf54DscfDg8szYhzWL5y/uRD3gLziYibUE=;
        b=RpVcUAZooJRyNam/5TaanJYubJp2VutesV4Be8wudSHmmwDkQqmkZ89wrfsNzCOIVj
         tPDLUqrNyKHC9Ku0MP99T7mRp4/A6x40izHuSammaqNWrLpyeDcR78UVYJrbp/fDdgnB
         i7XiEFQcHxGInA37xpeWgYBp6skhNTHMyzV38vCiGbAXCaQRmpxBgtjxUTeaGFiRay+q
         IMhd2OwkBE2I9V6pZqsJdCo6WRhwAeHx3S8xB0QfOeIHDSUdp/ab1FW37hWN+qJZd8gw
         WfOLeYaRBgaRSC1JlbRcS2zHNBKMlvJMcgytRp54bpKE/j8pdA4Gzw3+XvyOeH46fw6e
         rQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216752; x=1755821552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKPV7LpuHxf54DscfDg8szYhzWL5y/uRD3gLziYibUE=;
        b=fHpP7AXj9nHWgx/FY9ywXjy60aKjS43ffARuSTVq07j59sS6v26tQZZFutr2n/RGRf
         M0J6p4fC4fS/iWlg0A/YXaaKEw7t3gbMmhrLLneSrb9NXvkVAcleSr9iLk6ao4+/P/vY
         wpV9SDjwWFx0JDC3ZtAvHdcdZvcXsNiEH93Fh3F55rdIXoFvDIvdxhzl6Df8pQeEI9OF
         6udhyEhVPT/VRMu/NUoG6IilwdYmF2Xgl8tSQLPA+ExwOLl99rGS7jgiqJRxEVtoAJmd
         0Zc3DdvlsjjzYwVauphqjto75g1oBiP2W7w5Zl5AuoE4YDJA0U8XZbNjBE4ujj1WvVWu
         JsEg==
X-Gm-Message-State: AOJu0Yzn+k8EPQmfFdjliOkrA/hwLdzUqXe3RhtXouktxz2/qFTZeytc
	qU39vohSUPfaYkrm3Kq28mnczVHxQUk+gsuxhX1apzq4l+XeW8T4cBUez3JjOfznaNy1diVM80A
	GxZXF/10gCmLD4KOWWRJdRFUm39v4SZykO7BLxPxWsJ5CHAhr1kg8n09oymRpllYImVCtEzEccp
	WJBhp/DgTR1RldiRWosfvIQwbdEgugcBTOV6MJ
X-Google-Smtp-Source: AGHT+IHx6QGco7q/Svyh1zldivJ2YnlH9/HCz3WBRxb7BjTBtbIgCAz0ycOEnw++JSEa9trdl9BE0YwnK9E=
X-Received: from pjbsl16.prod.google.com ([2002:a17:90b:2e10:b0:31f:b2f:aeed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:394e:b0:31e:3bbc:e9e6
 with SMTP id 98e67ed59e1d1-3234213f914mr241081a91.19.1755216751796; Thu, 14
 Aug 2025 17:12:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:55 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-12-seanjc@google.com>
Subject: [PATCH 6.1.y 11/21] KVM: VMX: Handle forced exit due to preemption
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
index 96bbccd9477c..c804ad001a79 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5941,12 +5941,15 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
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


