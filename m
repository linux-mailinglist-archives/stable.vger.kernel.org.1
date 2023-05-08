Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E076FB450
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 17:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjEHPtX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 11:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbjEHPtK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 11:49:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5BFAD2E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 08:48:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-965d2749e2eso614923066b.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1683560905; x=1686152905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blFZvUojr5dhE4Jx5u2uh9350JzTZAott5birNxEhcg=;
        b=pYG476BqfI0Rq7cQdmIWBYzsxMQ6qf4Bo97dMqri/IbahRLZlnrKi0gBYk4/Sqpo66
         Q3RlmmLFqrpAvHslTW31KUkKMBSpOPheRzUej3bUiYF9dybrdamzfCdAzqCdxFRbPyFJ
         bbr96HGSF/S2bh8NxsiVxZnK9NEpp8Y9NKvr1QwWUXTnwVc4V0OI1b2W2sLJb+/UbSQD
         Vt7n4ll21udaCfdxONJbLAPbDwKG4i9xpr/gJ5JmT847Adhmuw5tbzn5q+ax7Q/5kT5Z
         y8iyrQIsvbOKciCSmfVMNSqkXum61ae6xiyNSv/sp6Qkf08jmBB3m2eBdmfXXwZG3Sgm
         JA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560905; x=1686152905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blFZvUojr5dhE4Jx5u2uh9350JzTZAott5birNxEhcg=;
        b=CrqpASysTW2iPLkmxaMW2BUY07BmcALol0h26b5tBj6X+93R4NwNAUZTBDj8BA/IIw
         gYhFgDdnQZF6BDTsI4TuDgAanzi0XKR2ddt1HyoGYZegGoqhXIVGw1ANmKZvCJbjMADt
         xaLp2MaW65QD28x9yACanvg4AraZY4Ikrs9ojRBtf+NIilidhf4QL34GuGQ0nzqJaIvS
         5JDv6rm/TZgVCH4zUQfntnV+xICCiHxFJlF1FSoqHTvQEzKUz3qtxnjgonPZskv97f4w
         WmMV4Pkfm2Z+bKy2Rneotkf9jj/8QfC+HnmrLM6KCt2KQqaY6nLl4XAuYxnPVEgYdC+T
         t6oA==
X-Gm-Message-State: AC+VfDweOXngvP47MuHb1mVUyOHIlDnaqHPLCwykLpou7A8y7LDf8CQX
        IaGnXfEdvNELxDKB6q7bgqLXtojKKRCbH541Xz+Ojw==
X-Google-Smtp-Source: ACHHUZ6p97wsXEK2KKfsgqHjlyGpBe7C7EV/1INNvqFR8KwoZB1QZozqOGZJE90qgy29jP1yG9L2WQ==
X-Received: by 2002:a17:907:961a:b0:965:fd04:f76b with SMTP id gb26-20020a170907961a00b00965fd04f76bmr10216621ejc.55.1683560905013;
        Mon, 08 May 2023 08:48:25 -0700 (PDT)
Received: from localhost.localdomain (p549211c7.dip0.t-ipconnect.de. [84.146.17.199])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906055500b009584c5bcbc7sm126316eja.49.2023.05.08.08.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:48:24 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 5.10 08/10] KVM: X86: Ensure that dirty PDPTRs are loaded
Date:   Mon,  8 May 2023 17:48:02 +0200
Message-Id: <20230508154804.30078-9-minipli@grsecurity.net>
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

[ Upstream commit 2c5653caecc4807b8abfe9c41880ac38417be7bf ]

For VMX with EPT, dirty PDPTRs need to be loaded before the next vmentry
via vmx_load_mmu_pgd()

But not all paths that call load_pdptrs() will cause vmx_load_mmu_pgd()
to be invoked.  Normally, kvm_mmu_reset_context() is used to cause
KVM_REQ_LOAD_MMU_PGD, but sometimes it is skipped:

* commit d81135a57aa6("KVM: x86: do not reset mmu if CR0.CD and
CR0.NW are changed") skips kvm_mmu_reset_context() after load_pdptrs()
when changing CR0.CD and CR0.NW.

* commit 21823fbda552("KVM: x86: Invalidate all PGDs for the current
PCID on MOV CR3 w/ flush") skips KVM_REQ_LOAD_MMU_PGD after
load_pdptrs() when rewriting the CR3 with the same value.

* commit a91a7c709600("KVM: X86: Don't reset mmu context when
toggling X86_CR4_PGE") skips kvm_mmu_reset_context() after
load_pdptrs() when changing CR4.PGE.

Fixes: d81135a57aa6 ("KVM: x86: do not reset mmu if CR0.CD and CR0.NW are changed")
Fixes: 21823fbda552 ("KVM: x86: Invalidate all PGDs for the current PCID on MOV CR3 w/ flush")
Fixes: a91a7c709600 ("KVM: X86: Don't reset mmu context when toggling X86_CR4_PGE")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Message-Id: <20211108124407.12187-2-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>	# backport to v5.10.x
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b2378ec80305..038ac5bbdd19 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -794,6 +794,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
 
 	memcpy(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs));
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
+	kvm_make_request(KVM_REQ_LOAD_MMU_PGD, vcpu);
 
 out:
 
-- 
2.39.2

