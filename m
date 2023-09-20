Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77B7A7B67
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjITLvw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjITLvt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:51:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D34811A
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:51:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E029C433C7;
        Wed, 20 Sep 2023 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210700;
        bh=3kFXHyKJLtJckE7AYjZclprN6av7GcuL5IgQ3oREVO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YaIVSNUU0Z1HtD2umD9FRr0vZBj9hcvPkTBiAr6e33bzEluM8bD9CsJ0ynGRi2S9W
         WZ7/kdQ7o+E3DzGx4jKo3Ujqar5nf38B+gUSfUtUrAvc0x3kZgnNmT9LHZevYiYM5g
         NP1I9/k9vpZFvftSosc8yzL/ZNeKYFCxELCDpflc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6.5 173/211] Revert "firewire: core: obsolete usage of GFP_ATOMIC at building node tree"
Date:   Wed, 20 Sep 2023 13:30:17 +0200
Message-ID: <20230920112851.248239541@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 3c70de9b580998e5d644f4e80a9944c30aa1197b upstream.

This reverts commit 06f45435d985d60d7d2fe2424fbb9909d177a63d.

John Ogness reports the case that the allocation is in atomic context under
acquired spin-lock.

[   12.555784] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[   12.555808] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 70, name: kworker/1:2
[   12.555814] preempt_count: 1, expected: 0
[   12.555820] INFO: lockdep is turned off.
[   12.555824] irq event stamp: 208
[   12.555828] hardirqs last  enabled at (207): [<c00000000111e414>] ._raw_spin_unlock_irq+0x44/0x80
[   12.555850] hardirqs last disabled at (208): [<c00000000110ff94>] .__schedule+0x854/0xfe0
[   12.555859] softirqs last  enabled at (188): [<c000000000f73504>] .addrconf_verify_rtnl+0x2c4/0xb70
[   12.555872] softirqs last disabled at (182): [<c000000000f732b0>] .addrconf_verify_rtnl+0x70/0xb70
[   12.555884] CPU: 1 PID: 70 Comm: kworker/1:2 Tainted: G S                 6.6.0-rc1 #1
[   12.555893] Hardware name: PowerMac7,2 PPC970 0x390202 PowerMac
[   12.555898] Workqueue: firewire_ohci .bus_reset_work [firewire_ohci]
[   12.555939] Call Trace:
[   12.555944] [c000000009677830] [c0000000010d83c0] .dump_stack_lvl+0x8c/0xd0 (unreliable)
[   12.555963] [c0000000096778b0] [c000000000140270] .__might_resched+0x320/0x340
[   12.555978] [c000000009677940] [c000000000497600] .__kmem_cache_alloc_node+0x390/0x460
[   12.555993] [c000000009677a10] [c0000000003fe620] .__kmalloc+0x70/0x310
[   12.556007] [c000000009677ac0] [c0003d00004e2268] .fw_core_handle_bus_reset+0x2c8/0xba0 [firewire_core]
[   12.556060] [c000000009677c20] [c0003d0000491190] .bus_reset_work+0x330/0x9b0 [firewire_ohci]
[   12.556079] [c000000009677d10] [c00000000011d0d0] .process_one_work+0x280/0x6f0
[   12.556094] [c000000009677e10] [c00000000011d8a0] .worker_thread+0x360/0x500
[   12.556107] [c000000009677ef0] [c00000000012e3b4] .kthread+0x154/0x160
[   12.556120] [c000000009677f90] [c00000000000bfa8] .start_kernel_thread+0x10/0x14

Cc: stable@kernel.org
Reported-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzsuv1xk.fsf@jogness.linutronix.de/raw
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firewire/core-device.c   |    2 +-
 drivers/firewire/core-topology.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -1211,7 +1211,7 @@ void fw_node_event(struct fw_card *card,
 		 * without actually having a link.
 		 */
  create:
-		device = kzalloc(sizeof(*device), GFP_KERNEL);
+		device = kzalloc(sizeof(*device), GFP_ATOMIC);
 		if (device == NULL)
 			break;
 
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -101,7 +101,7 @@ static struct fw_node *fw_node_create(u3
 {
 	struct fw_node *node;
 
-	node = kzalloc(struct_size(node, ports, port_count), GFP_KERNEL);
+	node = kzalloc(struct_size(node, ports, port_count), GFP_ATOMIC);
 	if (node == NULL)
 		return NULL;
 


