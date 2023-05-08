Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5506FB444
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 17:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbjEHPtP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbjEHPtG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 11:49:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51B2A5C1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 08:48:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-965f7bdab6bso636473966b.3
        for <stable@vger.kernel.org>; Mon, 08 May 2023 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1683560897; x=1686152897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBg5T5mpAb8M0jAPS52CYiPxwJ9/YpcwxA5FtnhL5qA=;
        b=KzwWbzl9W8H8agODh0VgfjDPGYBD2m7HDw/ylQgf7zD+u1O9/Q4MtNfKUr1YYV5rcf
         SFNSSULFwI2r8NYMvSP5L5pgAGmZNbTMzMDmJz2GjnJARt1Tcx4qUDJr97QPhx4NNEtg
         Ph5lmhovNcLgMooZLOGong18ZKI9kNIFfDPbcOLCF+IfIr21L92LnoGM5xus3NCal2bx
         JgfpNpDCritl0oNiIgGCPqEPkCxdkVIJ701VlLIyaROnqUYslD+ewb5m2ntELuCyNVJV
         8zV/wtK26a3SucJ6Uhbl0tEn51yl11uygDf6X0BagiEWafCx6PZT6pLT6hP8hcuGjMSA
         QHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560897; x=1686152897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBg5T5mpAb8M0jAPS52CYiPxwJ9/YpcwxA5FtnhL5qA=;
        b=DkJJJDzLxFbteZLnM/axdexvLkYzhSTXnzKTC/qIH+fgHZ8Cx9IMZ9mx7SavwMMRhu
         zr787x+tqr7h3/xlhaTj8nv823hTJSWPwNQyOYcF124MqQef8Ko0ZZshV8llsejhVC01
         5h0Ymh1sLYfGe5FU+TIEMIgrQT+jNecj+wijRLnj0IlIVJOuVu8p7MUojUTZl2MSOOG/
         y7niZSUVOCq0aYbIc3iWjrqkha6mvqLm1Yu8xOpbOr140Stjtkr+zqHX0Iuz1NqPFor3
         rYrg3jcg/yj8dTZ8CJBh/xAbjCvzyYK9qh6OfL+feZbcjCfRGGsS9v/pSXC4pBDI7+at
         tgwA==
X-Gm-Message-State: AC+VfDwFK/jDVvaEsSY58eRQsu6O2gwbMJ0039Gc8ux5b7sVWXi6MUMU
        tlyuW4BQzG9TJpCafx/uhfqhaNWVcr42kryjgeBVww==
X-Google-Smtp-Source: ACHHUZ6DFmf/PThcyPNey14p0+/PgsjodVy8TbMr3Ermew4WsWGW6tfFV0mFgY0L3hXXmzwbY46fEw==
X-Received: by 2002:a17:906:4fce:b0:965:a414:7cd6 with SMTP id i14-20020a1709064fce00b00965a4147cd6mr10968243ejw.17.1683560897400;
        Mon, 08 May 2023 08:48:17 -0700 (PDT)
Received: from localhost.localdomain (p549211c7.dip0.t-ipconnect.de. [84.146.17.199])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906055500b009584c5bcbc7sm126316eja.49.2023.05.08.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:48:17 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH 5.10 01/10] KVM: x86/mmu: Avoid indirect call for get_cr3
Date:   Mon,  8 May 2023 17:47:55 +0200
Message-Id: <20230508154804.30078-2-minipli@grsecurity.net>
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

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 2fdcc1b324189b5fb20655baebd40cd82e2bdf0c ]

Most of the time, calls to get_guest_pgd result in calling
kvm_read_cr3 (the exception is only nested TDP).  Hardcode
the default instead of using the get_cr3 function, avoiding
a retpoline if they are enabled.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Link: https://lore.kernel.org/r/20230322013731.102955-2-minipli@grsecurity.net
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>	# backport to v5.10.x
---
 arch/x86/kvm/mmu.h             | 11 +++++++++++
 arch/x86/kvm/mmu/mmu.c         | 12 ++++++------
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/x86.c             |  2 +-
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 581925e476d6..dcbd882545b4 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -99,6 +99,17 @@ static inline void kvm_mmu_load_pgd(struct kvm_vcpu *vcpu)
 				 vcpu->arch.mmu->shadow_root_level);
 }
 
+unsigned long get_guest_cr3(struct kvm_vcpu *vcpu);
+
+static inline unsigned long kvm_mmu_get_guest_pgd(struct kvm_vcpu *vcpu,
+						  struct kvm_mmu *mmu)
+{
+	if (IS_ENABLED(CONFIG_RETPOLINE) && mmu->get_guest_pgd == get_guest_cr3)
+		return kvm_read_cr3(vcpu);
+
+	return mmu->get_guest_pgd(vcpu);
+}
+
 int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		       bool prefault);
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 13bf3198d0ce..da9e7cea475a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3278,7 +3278,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	hpa_t root;
 	int i;
 
-	root_pgd = vcpu->arch.mmu->get_guest_pgd(vcpu);
+	root_pgd = kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
 
 	if (mmu_check_root(vcpu, root_gfn))
@@ -3652,7 +3652,7 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	arch.token = alloc_apf_token(vcpu);
 	arch.gfn = gfn;
 	arch.direct_map = vcpu->arch.mmu->direct_map;
-	arch.cr3 = vcpu->arch.mmu->get_guest_pgd(vcpu);
+	arch.cr3 = kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu);
 
 	return kvm_setup_async_pf(vcpu, cr2_or_gpa,
 				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
@@ -3934,7 +3934,7 @@ void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd, bool skip_tlb_flush,
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_new_pgd);
 
-static unsigned long get_cr3(struct kvm_vcpu *vcpu)
+unsigned long get_guest_cr3(struct kvm_vcpu *vcpu)
 {
 	return kvm_read_cr3(vcpu);
 }
@@ -4523,7 +4523,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 	context->invlpg = NULL;
 	context->shadow_root_level = kvm_mmu_get_tdp_level(vcpu);
 	context->direct_map = true;
-	context->get_guest_pgd = get_cr3;
+	context->get_guest_pgd = get_guest_cr3;
 	context->get_pdptr = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 
@@ -4718,7 +4718,7 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu)
 			    kvm_read_cr4_bits(vcpu, X86_CR4_PAE),
 			    vcpu->arch.efer);
 
-	context->get_guest_pgd     = get_cr3;
+	context->get_guest_pgd     = get_guest_cr3;
 	context->get_pdptr         = kvm_pdptr_read;
 	context->inject_page_fault = kvm_inject_page_fault;
 }
@@ -4756,7 +4756,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
 		return;
 
 	g_context->mmu_role.as_u64 = new_role.as_u64;
-	g_context->get_guest_pgd     = get_cr3;
+	g_context->get_guest_pgd     = get_guest_cr3;
 	g_context->get_pdptr         = kvm_pdptr_read;
 	g_context->inject_page_fault = kvm_inject_page_fault;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index c6daeeff1d9c..3d84fc56caca 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -330,7 +330,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	trace_kvm_mmu_pagetable_walk(addr, access);
 retry_walk:
 	walker->level = mmu->root_level;
-	pte           = mmu->get_guest_pgd(vcpu);
+	pte           = kvm_mmu_get_guest_pgd(vcpu, mmu);
 	have_ad       = PT_HAVE_ACCESSED_DIRTY(mmu);
 
 #if PTTYPE == 64
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0ccc8d1b972c..7464ca3806fa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11080,7 +11080,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 		return;
 
 	if (!vcpu->arch.mmu->direct_map &&
-	      work->arch.cr3 != vcpu->arch.mmu->get_guest_pgd(vcpu))
+	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
 		return;
 
 	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
-- 
2.39.2

