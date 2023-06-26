Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153AE73E952
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjFZSer (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjFZSek (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F24187
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD0C260F4B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BB0C433C0;
        Mon, 26 Jun 2023 18:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804471;
        bh=zDkmCzoJ4gm1dJ3VkRsGn50ZQ7htLUi14Cd3SrW/GRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpZ1In1YukyOqb22qfRZwqwb1AHGosTYO//hq1l70rouVj2Z4XUt+2pDAUDqegJbK
         gNL7TEjMS85JtFaozPFtsz4lpi+VZryj30M07HOyGH0+fosGohj2DOycNchdDAqZ+R
         O8TEaSw6rH70M0VYReIoimjDHrsYkQU9OV0kYmXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.1 167/170] KVM: arm64: Restore GICv2-on-GICv3 functionality
Date:   Mon, 26 Jun 2023 20:12:16 +0200
Message-ID: <20230626180807.958296521@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

commit 1caa71a7a600f7781ce05ef1e84701c459653663 upstream.

When reworking the vgic locking, the vgic distributor registration
got simplified, which was a very good cleanup. But just a tad too
radical, as we now register the *native* vgic only, ignoring the
GICv2-on-GICv3 that allows pre-historic VMs (or so I thought)
to run.

As it turns out, QEMU still defaults to GICv2 in some cases, and
this breaks Nathan's setup!

Fix it by propagating the *requested* vgic type rather than the
host's version.

Fixes: 59112e9c390b ("KVM: arm64: vgic: Fix a circular locking issue")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
link: https://lore.kernel.org/r/20230606221525.GA2269598@dev-arch.thelio-3990X
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/vgic/vgic-init.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -446,6 +446,7 @@ int vgic_lazy_init(struct kvm *kvm)
 int kvm_vgic_map_resources(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
+	enum vgic_type type;
 	gpa_t dist_base;
 	int ret = 0;
 
@@ -460,10 +461,13 @@ int kvm_vgic_map_resources(struct kvm *k
 	if (!irqchip_in_kernel(kvm))
 		goto out;
 
-	if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2)
+	if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2) {
 		ret = vgic_v2_map_resources(kvm);
-	else
+		type = VGIC_V2;
+	} else {
 		ret = vgic_v3_map_resources(kvm);
+		type = VGIC_V3;
+	}
 
 	if (ret) {
 		__kvm_vgic_destroy(kvm);
@@ -473,8 +477,7 @@ int kvm_vgic_map_resources(struct kvm *k
 	dist_base = dist->vgic_dist_base;
 	mutex_unlock(&kvm->arch.config_lock);
 
-	ret = vgic_register_dist_iodev(kvm, dist_base,
-				       kvm_vgic_global_state.type);
+	ret = vgic_register_dist_iodev(kvm, dist_base, type);
 	if (ret) {
 		kvm_err("Unable to register VGIC dist MMIO regions\n");
 		kvm_vgic_destroy(kvm);


