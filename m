Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348567D33EE
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjJWLf1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbjJWLf0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:35:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620A7FD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:35:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B26C433C8;
        Mon, 23 Oct 2023 11:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060922;
        bh=0W9Ojx8qv04RsETUSRr0yXLq+o8eR60/tf6or81Asio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jz+aQcK3RrD8T2BGRTbYv0hztKeZz1OkJpcV1aL+AH4BLLbGEmwRL6bHxQQ5U3a0O
         Xoo+dHvXVfu2zjnAGpGM7Qfjnd6jxSmyZkrM59aTsqazXnvK3nVNiitlfza4tisfUh
         xF2ZwOqdb5pwb8UYSVU1tzeViJjVxNG8WQBcGRag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15 014/137] KVM: x86: Mask LVTPC when handling a PMI
Date:   Mon, 23 Oct 2023 12:56:11 +0200
Message-ID: <20231023104821.410522636@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit a16eb25b09c02a54c1c1b449d4b6cfa2cf3f013a upstream.

Per the SDM, "When the local APIC handles a performance-monitoring
counters interrupt, it automatically sets the mask flag in the LVT
performance counter register."  Add this behavior to KVM's local APIC
emulation.

Failure to mask the LVTPC entry results in spurious PMIs, e.g. when
running Linux as a guest, PMI handlers that do a "late_ack" spew a large
number of "dazed and confused" spurious NMI warnings.

Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")
Cc: stable@vger.kernel.org
Signed-off-by: Jim Mattson <jmattson@google.com>
Tested-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Link: https://lore.kernel.org/r/20230925173448.3518223-3-mizhang@google.com
[sean: massage changelog, correct Fixes]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/lapic.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2411,13 +2411,17 @@ int kvm_apic_local_deliver(struct kvm_la
 {
 	u32 reg = kvm_lapic_get_reg(apic, lvt_type);
 	int vector, mode, trig_mode;
+	int r;
 
 	if (kvm_apic_hw_enabled(apic) && !(reg & APIC_LVT_MASKED)) {
 		vector = reg & APIC_VECTOR_MASK;
 		mode = reg & APIC_MODE_MASK;
 		trig_mode = reg & APIC_LVT_LEVEL_TRIGGER;
-		return __apic_accept_irq(apic, mode, vector, 1, trig_mode,
-					NULL);
+
+		r = __apic_accept_irq(apic, mode, vector, 1, trig_mode, NULL);
+		if (r && lvt_type == APIC_LVTPC)
+			kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LVT_MASKED);
+		return r;
 	}
 	return 0;
 }


