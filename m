Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD1774DCDA
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 19:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGJR4K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJR4K (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 13:56:10 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6EAAD
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 10:56:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689011763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+cvTDEYWhCf3jjN4GX5G49I3YGVQXATaDFQYZ+KXghc=;
        b=QKCFD6gkjtu/F4CBOG6JAhheBNjZ+UroLgQMBzRQ+Zl1TbFUJb6dOGFKBAQwiQCGJQowj4
        6PuHCxlgjOmPxYLPhUq+jsvLlcZ6hOo7Setm8snp40UJEnYJF9iR7MnnrJ7CZVifXPsDiJ
        lR5mQSkAhUlI2CHDRp6L/FynmFr7+So=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     kvmarm@lists.linux.dev
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Oliver Upton <oliver.upton@linux.dev>, stable@vger.kernel.org,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] KVM: arm64: vgic-v4: Consistently request doorbell irq for blocking vCPU
Date:   Mon, 10 Jul 2023 17:55:53 +0000
Message-ID: <20230710175553.1477762-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Xiang reports that VMs occasionally fail to boot on GICv4.1 systems when
running a preemptible kernel, as it is possible that a vCPU is blocked
without requesting a doorbell interrupt.

The issue is that any preemption that occurs between vgic_v4_put() and
schedule() on the block path will mark the vPE as nonresident and *not*
request a doorbell irq.

Fix it by consistently requesting a doorbell irq in the vcpu put path if
the vCPU is blocking. While this technically means we could drop the
early doorbell irq request in kvm_vcpu_wfi(), deliberately leave it
intact such that vCPU halt polling can properly detect the wakeup
condition before actually scheduling out a vCPU.

Cc: stable@vger.kernel.org
Fixes: 8e01d9a396e6 ("KVM: arm64: vgic-v4: Move the GICv4 residency flow to be driven by vcpu_load/put")
Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index c3b8e132d599..8c467e9f4f11 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -749,7 +749,7 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
 {
 	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
 
-	WARN_ON(vgic_v4_put(vcpu, false));
+	WARN_ON(vgic_v4_put(vcpu, kvm_vcpu_is_blocking(vcpu)));
 
 	vgic_v3_vmcr_sync(vcpu);
 
-- 
2.41.0.255.g8b1d071c50-goog

