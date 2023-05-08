Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004876FB44B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjEHPtV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjEHPtJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 11:49:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6EDAD17
        for <stable@vger.kernel.org>; Mon,  8 May 2023 08:48:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso9163201a12.3
        for <stable@vger.kernel.org>; Mon, 08 May 2023 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1683560902; x=1686152902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pD5x1DjcMgFYaj5G2kx0WTtEGNyMWKMqFSuUrLVWxw=;
        b=FqU4ODoQp3xzxgaIe+u1IFFLJrkbuDLu9hbQg5f1TDJO8uVRmuSISJtEI4w9RSmjen
         gGIr/GhHQfILOqYzQiPw+cKm2mq4nrjzb1I2aa7A3eWlsUQXvgDq9csS5ox25jDoYl+p
         YgqTpiTyR+PQXDhvQS8BlxlHZsl2DXUjBlOD2+szsdkAd64Pitno20/+vmikeZD+U8N+
         yC66aSixLRDdcpNkh8HYvIeYT2bHTQq2/7ORvwCmSCN2bpIpllYwjEMMkQ9ziwZXD4FJ
         DgN0smDW1H42RjXv6nge4CPfMrkYQBo9ex+JXvIsrdtl0A399YR3/yNiCtotkSUn0ECl
         TnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560902; x=1686152902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pD5x1DjcMgFYaj5G2kx0WTtEGNyMWKMqFSuUrLVWxw=;
        b=blbwtn9+wUKZp0Nvg1pU9XgxywZ8O7cS3hnQlh5eVoTwS0y692l+24sW/JGbvW0lf+
         z2KfTVRdnpIgIP5JmYWxIP6XYXfFKO6s7B5wAm5xtridOnp1gFq44bSfL+0dTCu0Kywj
         Ga9E5pa3rmpjFmxCvf99SAQvn2+zCeFQsf/M3AzQNRd7aEeRtCv8/+dGAowcLDKoge8x
         nCzdbMU7ZJdceD/gwdzE0eLoRyNzgzsCuxWKliE8R7pPCy6Irz22FKK2pgp2SbriR9IC
         GybVxAEeSFR/GsLrAn94mhQH9mHclDJOUqoyTRMqxCc9+Zcq4CtNO9FVtZr9GCEoycKM
         DO/w==
X-Gm-Message-State: AC+VfDwztB/CgVacli7VOymVgoHLrJOyGOWqAPCylqGNPqN8JOU+lp4Y
        fTP98GVUmGW9l9TSK7Yl9hJoEYS/93ig3sW4JGicOg==
X-Google-Smtp-Source: ACHHUZ59C70Jwt1HM/c0qziYA6xiq9AcSYQ2l5zjAU3mbhfmLrgFgqvrIqdSWZT5bBWkvyCRy5V8Bg==
X-Received: by 2002:a17:907:2d9f:b0:94e:e3c3:aebe with SMTP id gt31-20020a1709072d9f00b0094ee3c3aebemr10203858ejc.0.1683560901836;
        Mon, 08 May 2023 08:48:21 -0700 (PDT)
Received: from localhost.localdomain (p549211c7.dip0.t-ipconnect.de. [84.146.17.199])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906055500b009584c5bcbc7sm126316eja.49.2023.05.08.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:48:21 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH 5.10 05/10] KVM: x86: Read and pass all CR0/CR4 role bits to shadow MMU helper
Date:   Mon,  8 May 2023 17:47:59 +0200
Message-Id: <20230508154804.30078-6-minipli@grsecurity.net>
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

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 20f632bd0060e12fca083adc44b097231e2f4649 ]

Grab all CR0/CR4 MMU role bits from current vCPU state when initializing
a non-nested shadow MMU.  Extract the masks from kvm_post_set_cr{0,4}(),
as the CR0/CR4 update masks must exactly match the mmu_role bits, with
one exception (see below).  The "full" CR0/CR4 will be used by future
commits to initialize the MMU and its role, as opposed to the current
approach of pulling everything from vCPU, which is incorrect for certain
flows, e.g. nested NPT.

CR4.LA57 is an exception, as it can be toggled on VM-Exit (for L1's MMU)
but can't be toggled via MOV CR4 while long mode is active.  I.e. LA57
needs to be in the mmu_role, but technically doesn't need to be checked
by kvm_post_set_cr4().  However, the extra check is completely benign as
the hardware restrictions simply mean LA57 will never be _the_ cause of
a MMU reset during MOV CR4.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210622175739.3610207-18-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>	# backport to v5.10.x
---
- prerequisite for Lai Jiangshan's follow-up patches
- only visible change is that changes to CR4.SMEP and CR4.LA57 are taken
  into account as well now to trigger a MMU reset in kvm_set_cr4() 

 arch/x86/kvm/mmu.h     | 6 ++++++
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 arch/x86/kvm/x86.c     | 6 ++----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index dcbd882545b4..0d73e8b45642 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -44,6 +44,12 @@
 #define PT32_ROOT_LEVEL 2
 #define PT32E_ROOT_LEVEL 3
 
+#define KVM_MMU_CR4_ROLE_BITS (X86_CR4_PGE | X86_CR4_PSE | X86_CR4_PAE | \
+			       X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE | \
+			       X86_CR4_LA57)
+
+#define KVM_MMU_CR0_ROLE_BITS (X86_CR0_PG | X86_CR0_WP)
+
 static inline u64 rsvd_bits(int s, int e)
 {
 	if (e < s)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index da9e7cea475a..e1107723ffdc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4714,8 +4714,8 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu)
 	struct kvm_mmu *context = &vcpu->arch.root_mmu;
 
 	kvm_init_shadow_mmu(vcpu,
-			    kvm_read_cr0_bits(vcpu, X86_CR0_PG),
-			    kvm_read_cr4_bits(vcpu, X86_CR4_PAE),
+			    kvm_read_cr0_bits(vcpu, KVM_MMU_CR0_ROLE_BITS),
+			    kvm_read_cr4_bits(vcpu, KVM_MMU_CR4_ROLE_BITS),
 			    vcpu->arch.efer);
 
 	context->get_guest_pgd     = get_guest_cr3;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bd4d64c1bdf9..d6bb2c300e16 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -829,7 +829,6 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	unsigned long old_cr0 = kvm_read_cr0(vcpu);
 	unsigned long pdptr_bits = X86_CR0_CD | X86_CR0_NW | X86_CR0_PG;
-	unsigned long update_bits = X86_CR0_PG | X86_CR0_WP;
 
 	cr0 |= X86_CR0_ET;
 
@@ -885,7 +884,7 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 		kvm_async_pf_hash_reset(vcpu);
 	}
 
-	if ((cr0 ^ old_cr0) & update_bits)
+	if ((cr0 ^ old_cr0) & KVM_MMU_CR0_ROLE_BITS)
 		kvm_mmu_reset_context(vcpu);
 
 	if (((cr0 ^ old_cr0) & X86_CR0_CD) &&
@@ -1017,7 +1016,6 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	unsigned long old_cr4 = kvm_read_cr4(vcpu);
 	unsigned long pdptr_bits = X86_CR4_PGE | X86_CR4_PSE | X86_CR4_PAE |
 				   X86_CR4_SMEP;
-	unsigned long mmu_role_bits = pdptr_bits | X86_CR4_SMAP | X86_CR4_PKE;
 
 	if (kvm_valid_cr4(vcpu, cr4))
 		return 1;
@@ -1044,7 +1042,7 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 
 	kvm_x86_ops.set_cr4(vcpu, cr4);
 
-	if (((cr4 ^ old_cr4) & mmu_role_bits) ||
+	if (((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS) ||
 	    (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)))
 		kvm_mmu_reset_context(vcpu);
 
-- 
2.39.2

