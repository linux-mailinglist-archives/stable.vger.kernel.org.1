Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7912C775B1E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjHILOa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjHILOa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA7010F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B03586315D
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EA0C433C8;
        Wed,  9 Aug 2023 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579669;
        bh=XekQKM47VaZbKiQUv8euQb4njyyF6lTVUxcDXC09kuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6KVQu7CK6m2QlxwluYIZFGYzNkAvv1NCaKYPhdqmppt4ZR1Y6wKZ++Kw1dLH+qsD
         jdR8Q59A3d6UurrYsWJeI2fCiTeBCJL7v1uC2gxdAGRUQjI4J7enuMEilGy688nvpl
         3u0cn9qzJRLgKKe5xDi4ez8DNvfx30mxGZ6KNYhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>,
        Nicolas Escande <nico.escande@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/323] wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()
Date:   Wed,  9 Aug 2023 12:38:03 +0200
Message-ID: <20230809103700.186260584@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Remi Pommarel <repk@triplefau.lt>

[ Upstream commit 75086cc6dee046e3fbb3dba148b376d8802f83bc ]

On EDMA capable hardware, ath9k_txq_list_has_key() can enter infinite
loop if it is called while all txq_fifos have packets that use different
key that the one we are looking for. Fix it by exiting the loop if all
txq_fifos have been checked already.

Because this loop is called under spin_lock_bh() (see ath_txq_lock) it
causes the following rcu stall:

rcu: INFO: rcu_sched self-detected stall on CPU
ath10k_pci 0000:01:00.0: failed to read temperature -11
rcu:    1-....: (5254 ticks this GP) idle=189/1/0x4000000000000002 softirq=8442983/8442984 fqs=2579
        (t=5257 jiffies g=17983297 q=334)
Task dump for CPU 1:
task:hostapd         state:R  running task     stack:    0 pid:  297 ppid:   289 flags:0x0000000a
Call trace:
 dump_backtrace+0x0/0x170
 show_stack+0x1c/0x24
 sched_show_task+0x140/0x170
 dump_cpu_task+0x48/0x54
 rcu_dump_cpu_stacks+0xf0/0x134
 rcu_sched_clock_irq+0x8d8/0x9fc
 update_process_times+0xa0/0xec
 tick_sched_timer+0x5c/0xd0
 __hrtimer_run_queues+0x154/0x320
 hrtimer_interrupt+0x120/0x2f0
 arch_timer_handler_virt+0x38/0x44
 handle_percpu_devid_irq+0x9c/0x1e0
 handle_domain_irq+0x64/0x90
 gic_handle_irq+0x78/0xb0
 call_on_irq_stack+0x28/0x38
 do_interrupt_handler+0x54/0x5c
 el1_interrupt+0x2c/0x4c
 el1h_64_irq_handler+0x14/0x1c
 el1h_64_irq+0x74/0x78
 ath9k_txq_has_key+0x1bc/0x250 [ath9k]
 ath9k_set_key+0x1cc/0x3dc [ath9k]
 drv_set_key+0x78/0x170
 ieee80211_key_replace+0x564/0x6cc
 ieee80211_key_link+0x174/0x220
 ieee80211_add_key+0x11c/0x300
 nl80211_new_key+0x12c/0x330
 genl_family_rcv_msg_doit+0xbc/0x11c
 genl_rcv_msg+0xd8/0x1c4
 netlink_rcv_skb+0x40/0x100
 genl_rcv+0x3c/0x50
 netlink_unicast+0x1ec/0x2c0
 netlink_sendmsg+0x198/0x3c0
 ____sys_sendmsg+0x210/0x250
 ___sys_sendmsg+0x78/0xc4
 __sys_sendmsg+0x4c/0x90
 __arm64_sys_sendmsg+0x28/0x30
 invoke_syscall.constprop.0+0x60/0x100
 do_el0_svc+0x48/0xd0
 el0_svc+0x14/0x50
 el0t_64_sync_handler+0xa8/0xb0
 el0t_64_sync+0x158/0x15c

This rcu stall is hard to reproduce as is, but changing ATH_TXFIFO_DEPTH
from 8 to 2 makes it reasonably easy to reproduce.

Fixes: ca2848022c12 ("ath9k: Postpone key cache entry deletion for TXQ frames reference it")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230609093744.1985-1-repk@triplefau.lt
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index ee1b9c39bad7a..e8e297a04d360 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -847,7 +847,7 @@ static bool ath9k_txq_list_has_key(struct list_head *txq_list, u32 keyix)
 static bool ath9k_txq_has_key(struct ath_softc *sc, u32 keyix)
 {
 	struct ath_hw *ah = sc->sc_ah;
-	int i;
+	int i, j;
 	struct ath_txq *txq;
 	bool key_in_use = false;
 
@@ -865,8 +865,9 @@ static bool ath9k_txq_has_key(struct ath_softc *sc, u32 keyix)
 		if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA) {
 			int idx = txq->txq_tailidx;
 
-			while (!key_in_use &&
-			       !list_empty(&txq->txq_fifo[idx])) {
+			for (j = 0; !key_in_use &&
+			     !list_empty(&txq->txq_fifo[idx]) &&
+			     j < ATH_TXFIFO_DEPTH; j++) {
 				key_in_use = ath9k_txq_list_has_key(
 					&txq->txq_fifo[idx], keyix);
 				INCR(idx, ATH_TXFIFO_DEPTH);
-- 
2.39.2



