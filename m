Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF93F7611B6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjGYKzO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjGYKyX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:54:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00C0423B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5425B6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634ABC433C7;
        Tue, 25 Jul 2023 10:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282354;
        bh=rSFQ1xLahHluvNFx65yFm/FlHeeNMohiNQymhUOOcGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNRi6UDLbEYkatslMXhmUsbvnLJeACsbwI5tSBbFhq8UDHO2Y+or/oWIlIvNLb6GN
         tkIaHo55aAKX+AKbz/tPpnzdL+YK035zGfLwtUgTMyWYMPRO69CeimxjJT4UFo2SQW
         m8kC9JTLcTNqa/yZOf1gFNpIn8LCF4nNvXED7bGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 6.4 071/227] KVM: arm64: timers: Use CNTHCTL_EL2 when setting non-CNTKCTL_EL1 bits
Date:   Tue, 25 Jul 2023 12:43:58 +0200
Message-ID: <20230725104517.705792043@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

commit fe769e6c1f80f542d6f4e7f7c8c6bf20c1307f99 upstream.

It recently appeared that, when running VHE, there is a notable
difference between using CNTKCTL_EL1 and CNTHCTL_EL2, despite what
the architecture documents:

- When accessed from EL2, bits [19:18] and [16:10] of CNTKCTL_EL1 have
  the same assignment as CNTHCTL_EL2
- When accessed from EL1, bits [19:18] and [16:10] are RES0

It is all OK, until you factor in NV, where the EL2 guest runs at EL1.
In this configuration, CNTKCTL_EL11 doesn't trap, nor ends up in
the VNCR page. This means that any write from the guest affecting
CNTHCTL_EL2 using CNTKCTL_EL1 ends up losing some state. Not good.

The fix it obvious: don't use CNTKCTL_EL1 if you want to change bits
that are not part of the EL1 definition of CNTKCTL_EL1, and use
CNTHCTL_EL2 instead. This doesn't change anything for a bare-metal OS,
and fixes it when running under NV. The NV hypervisor will itself
have to work harder to merge the two accessors.

Note that there is a pending update to the architecture to address
this issue by making the affected bits UNKNOWN when CNTKCTL_EL1 is
used from EL2 with VHE enabled.

Fixes: c605ee245097 ("KVM: arm64: timers: Allow physical offset without CNTPOFF_EL2")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org # v6.4
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20230627140557.544885-1-maz@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/arch_timer.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -827,8 +827,8 @@ static void timer_set_traps(struct kvm_v
 	assign_clear_set_bit(tpt, CNTHCTL_EL1PCEN << 10, set, clr);
 	assign_clear_set_bit(tpc, CNTHCTL_EL1PCTEN << 10, set, clr);
 
-	/* This only happens on VHE, so use the CNTKCTL_EL1 accessor */
-	sysreg_clear_set(cntkctl_el1, clr, set);
+	/* This only happens on VHE, so use the CNTHCTL_EL2 accessor. */
+	sysreg_clear_set(cnthctl_el2, clr, set);
 }
 
 void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
@@ -1559,7 +1559,7 @@ no_vgic:
 void kvm_timer_init_vhe(void)
 {
 	if (cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF))
-		sysreg_clear_set(cntkctl_el1, 0, CNTHCTL_ECV);
+		sysreg_clear_set(cnthctl_el2, 0, CNTHCTL_ECV);
 }
 
 int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)


