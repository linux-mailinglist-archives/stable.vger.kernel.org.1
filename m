Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231326FB460
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjEHPvR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjEHPvG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 11:51:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574901BFA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 08:50:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-956ff2399b1so883993666b.3
        for <stable@vger.kernel.org>; Mon, 08 May 2023 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1683560991; x=1686152991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IitU9c4tf9dt0ERwg1tcoCiv6Eix1HabG4a6CRnRpFc=;
        b=ixTNBoys9toVbXsiw9eKzZgtvwSn1Xp5L0GwzCnXIVUvzkpNduZd1+8zVQFQiW11MD
         U/P26R14v4c59zchuLaC6d9KYbYjalBzO+2THFrLSDFoBM0saNxxBK0SAPE19S7eannP
         GJBFB6Y/W6KxYrdMWJHxkaACesOGFiWK5wPOkPZ6LJKUIoPuEpcNCdZVVm5MY7IhygmE
         SzLVGJ2cO50bGF15/AkaN/Fl+yHq4ieHZ2Q6a4Jj/NNpKbY+JWfGhujv/wYocfzLEaHu
         kQp3HAZDL/C+sMQBxn7nMn5JCoiotVbv0AZWMcH8mKq6C0HNM0rPrz0Dh5JVKWH7qp5d
         taAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560991; x=1686152991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IitU9c4tf9dt0ERwg1tcoCiv6Eix1HabG4a6CRnRpFc=;
        b=g32wINVbupMJR4sc8K1Q4Xt6gEz9aupC2HmlIHsfEZGtcDznOyvax/AQlMeYL4LGXe
         MFj8v1avvI2tFcBtNha/EB5Ckk0X22ai0KuiiqhsiFIO7qSa//8skp03+Bk6dtqg9kfQ
         M45M04wOJDLE/py9Uik5LED53wGpHK3HNppP0OKravsSbxRI7nRWElMd8JVXo3D0Qsjq
         x/TV7zOl2rKaRvbbqp0KWFpJ4gqf/vxhhVaNqNETplz+zC5389EBZb8m834lCdVTO6ZI
         Z3JGU0fR8u3We4sEJjvIqSbn8kahYpYdK5gu6CZMKRwNATOXC6CnwnZ0LUXT3OsfBlw8
         27Nw==
X-Gm-Message-State: AC+VfDyXx7U0w7FuBuZgKk/3XPdDt4Ag+RkeQ6DAVdXF90qaWTt1p5qB
        5a3eFg9R8j9dre8yeSP4ymC5vhrS/Asx/MkNH2A0Dw==
X-Google-Smtp-Source: ACHHUZ6BQE1T/sVLfxIhIGaWL96gl7t6frXSByBX3nO8DBsFTaBOTd9bkI3fVyJH08PGwWov7B2J0A==
X-Received: by 2002:a17:907:7f87:b0:965:d7c7:24d4 with SMTP id qk7-20020a1709077f8700b00965d7c724d4mr12477200ejc.77.1683560990946;
        Mon, 08 May 2023 08:49:50 -0700 (PDT)
Received: from localhost.localdomain (p549211c7.dip0.t-ipconnect.de. [84.146.17.199])
        by smtp.gmail.com with ESMTPSA id bu2-20020a170906a14200b0096654fdbe34sm117550ejb.142.2023.05.08.08.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:49:50 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH 5.4 3/3] KVM: x86: Make use of kvm_read_cr*_bits() when testing bits
Date:   Mon,  8 May 2023 17:49:43 +0200
Message-Id: <20230508154943.30113-4-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508154943.30113-1-minipli@grsecurity.net>
References: <20230508154943.30113-1-minipli@grsecurity.net>
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

[ Upstream commit 74cdc836919bf34684ef66f995273f35e2189daf ]

Make use of the kvm_read_cr{0,4}_bits() helper functions when we only
want to know the state of certain bits instead of the whole register.

This not only makes the intent cleaner, it also avoids a potential
VMREAD in case the tested bits aren't guest owned.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Link: https://lore.kernel.org/r/20230322013731.102955-5-minipli@grsecurity.net
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>	# backport to 5.4.x
---
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e6dd6a7e8689..9bbbb201bab5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4970,7 +4970,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		break;
 	case 3: /* lmsw */
 		val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
-		trace_kvm_cr_write(0, (kvm_read_cr0(vcpu) & ~0xful) | val);
+		trace_kvm_cr_write(0, (kvm_read_cr0_bits(vcpu, ~0xful) | val));
 		kvm_lmsw(vcpu, val);
 
 		return kvm_skip_emulated_instruction(vcpu);
@@ -6982,7 +6982,7 @@ static u64 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 		goto exit;
 	}
 
-	if (kvm_read_cr0(vcpu) & X86_CR0_CD) {
+	if (kvm_read_cr0_bits(vcpu, X86_CR0_CD)) {
 		ipat = VMX_EPT_IPAT_BIT;
 		if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_CD_NW_CLEARED))
 			cache = MTRR_TYPE_WRBACK;
-- 
2.39.2

