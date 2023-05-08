Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A966FB44D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjEHPtV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjEHPtK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 11:49:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DE0AD22
        for <stable@vger.kernel.org>; Mon,  8 May 2023 08:48:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9659f452148so829757466b.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1683560903; x=1686152903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RYegx694beL5KeyUErKjz07xtwHsu2z4x0/sf2I1+o=;
        b=tthoCc1wLGExjibFIebm0G4HoLnKNsn9GVOAZa0hyYrJT3QSeNGclV83+IOv+WoK0x
         9hDPzlRgyj2yiSKYIrspxo1c0NoB7RAs3Ni+1RwZOxGSR91HDB2Lc+UNWqlQe060JeEg
         bSZ6/lyP0T7Df+os/IfDHPisAbrMdWuJGNlulr9QuBHXhlL8F6lnru+e7eF3f7AAvKUh
         93VZgd8wYUlB+GEzCsFEOOGiWhpLPnKxwRZJttqlwSjrWUdFpEeZdhxbaxOc9vPecez6
         u0/leQyA5nYk/yDWkgF5r9eZ72Fz/bo/BWlgPjhrida2Tgy8EPdMHdGtn+UmSJw71+uP
         4gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560903; x=1686152903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RYegx694beL5KeyUErKjz07xtwHsu2z4x0/sf2I1+o=;
        b=BuW05pj7QGsPv2HJ/UgSBFcr5+pLofS4Hh83rvMVNo9ZSVnoUfBYuIfiOWLnuzvhVe
         AjOgyq8yEyGdZwiJITys9NSwZMr4fJWd5hSLfVQdV7kIWMuk4277snpqlTyAMLumcdAV
         1ZjpewtrAcrcpj6B5cS8UTvezIZ1aw4K8PdEBsJDyN6p4QEZgpnnIP9uDUySSefRvTOj
         Vw1SvxgNJGQPzmsBd9sXKYRo4f6ZJC3AIvj8XBlC/ek23CtvhEdtkIGO61fCo5agatYO
         w33ZHcglUAtsnzWpS6jOciBgJkKOCPLV84oOCkJ/9TCFPVaoYbtOJ0FGW6bmv8Yonmbd
         l+Yw==
X-Gm-Message-State: AC+VfDyk6Xd1NtGRuJe7EqdzJPhX22Ksfig9zydPXDyl4ielV9x8D1WI
        4WfKUbmEF6Lm/fOcxJHskutpLmpw25iRMFki3CZkMw==
X-Google-Smtp-Source: ACHHUZ6AZ+9CAV1RIXeLs9ZmXAzxI9ojrRgPVN3Usx1PgpQ45grC6eVGcj4P/WrdfDPrNECwtp2FVw==
X-Received: by 2002:a17:907:6e8d:b0:961:be96:b0dd with SMTP id sh13-20020a1709076e8d00b00961be96b0ddmr11185551ejc.38.1683560902841;
        Mon, 08 May 2023 08:48:22 -0700 (PDT)
Received: from localhost.localdomain (p549211c7.dip0.t-ipconnect.de. [84.146.17.199])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906055500b009584c5bcbc7sm126316eja.49.2023.05.08.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:48:22 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 5.10 06/10] KVM: X86: Don't reset mmu context when X86_CR4_PCIDE 1->0
Date:   Mon,  8 May 2023 17:48:00 +0200
Message-Id: <20230508154804.30078-7-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508154804.30078-1-minipli@grsecurity.net>
References: <20230508154804.30078-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

[ Upstream commit 552617382c197949ff965a3559da8952bf3c1fa5 ]

X86_CR4_PCIDE doesn't participate in kvm_mmu_role, so the mmu context
doesn't need to be reset.  It is only required to flush all the guest
tlb.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210919024246.89230-2-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>	# backport to v5.10.x
---
- no kvm_post_set_cr4() in this kernel yet, it's part of kvm_set_cr4()

 arch/x86/kvm/x86.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d6bb2c300e16..952281f18987 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1042,9 +1042,10 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 
 	kvm_x86_ops.set_cr4(vcpu, cr4);
 
-	if (((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS) ||
-	    (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)))
+	if ((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS)
 		kvm_mmu_reset_context(vcpu);
+	else if (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE))
+		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 
 	if ((cr4 ^ old_cr4) & (X86_CR4_OSXSAVE | X86_CR4_PKE))
 		kvm_update_cpuid_runtime(vcpu);
-- 
2.39.2

