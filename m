Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5034872C02C
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjFLKuf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbjFLKt6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9217EF5
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A7E6623F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D60CC433D2;
        Mon, 12 Jun 2023 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566046;
        bh=y1ls9yVThGHSWeAxmGINhyREKrialOO1zacee2PdI4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xBnzGfwe1IBUpPJNw0fwwTSBoCvaPCgp0AWZx3RnJe6siTMkoTrekVTvHFexTDqw4
         dwSIpXItkmNwNFht+aCIOFpGu8DwHGgDtp9mXjp992WGxYE9utRLuiLYFEwzxxP4J6
         ta2t5MX9lPlbqiFJzSCtl1EoOyliqvnvFrc/iEjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10 43/68] can: j1939: avoid possible use-after-free when j1939_can_rx_register fails
Date:   Mon, 12 Jun 2023 12:26:35 +0200
Message-ID: <20230612101700.200822358@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
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

From: Fedor Pchelkin <pchelkin@ispras.ru>

commit 9f16eb106aa5fce15904625661312623ec783ed3 upstream.

Syzkaller reports the following failure:

BUG: KASAN: use-after-free in kref_put include/linux/kref.h:64 [inline]
BUG: KASAN: use-after-free in j1939_priv_put+0x25/0xa0 net/can/j1939/main.c:172
Write of size 4 at addr ffff888141c15058 by task swapper/3/0

CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.10.144-syzkaller #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x167 lib/dump_stack.c:118
 print_address_description.constprop.0+0x1c/0x220 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x145/0x190 mm/kasan/generic.c:192
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 kref_put include/linux/kref.h:64 [inline]
 j1939_priv_put+0x25/0xa0 net/can/j1939/main.c:172
 j1939_sk_sock_destruct+0x44/0x90 net/can/j1939/socket.c:374
 __sk_destruct+0x4e/0x820 net/core/sock.c:1784
 rcu_do_batch kernel/rcu/tree.c:2485 [inline]
 rcu_core+0xb35/0x1a30 kernel/rcu/tree.c:2726
 __do_softirq+0x289/0x9a3 kernel/softirq.c:298
 asm_call_irq_on_stack+0x12/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xe0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu kernel/softirq.c:423 [inline]
 irq_exit_rcu+0x136/0x200 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1095
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:635

Allocated by task 1141:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc9/0xd0 mm/kasan/common.c:461
 kmalloc include/linux/slab.h:552 [inline]
 kzalloc include/linux/slab.h:664 [inline]
 j1939_priv_create net/can/j1939/main.c:131 [inline]
 j1939_netdev_start+0x111/0x860 net/can/j1939/main.c:268
 j1939_sk_bind+0x8ea/0xd30 net/can/j1939/socket.c:485
 __sys_bind+0x1f2/0x260 net/socket.c:1645
 __do_sys_bind net/socket.c:1656 [inline]
 __se_sys_bind net/socket.c:1654 [inline]
 __x64_sys_bind+0x6f/0xb0 net/socket.c:1654
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

Freed by task 1141:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0x112/0x170 mm/kasan/common.c:422
 slab_free_hook mm/slub.c:1542 [inline]
 slab_free_freelist_hook+0xad/0x190 mm/slub.c:1576
 slab_free mm/slub.c:3149 [inline]
 kfree+0xd9/0x3b0 mm/slub.c:4125
 j1939_netdev_start+0x5ee/0x860 net/can/j1939/main.c:300
 j1939_sk_bind+0x8ea/0xd30 net/can/j1939/socket.c:485
 __sys_bind+0x1f2/0x260 net/socket.c:1645
 __do_sys_bind net/socket.c:1656 [inline]
 __se_sys_bind net/socket.c:1654 [inline]
 __x64_sys_bind+0x6f/0xb0 net/socket.c:1654
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

It can be caused by this scenario:

CPU0					CPU1
j1939_sk_bind(socket0, ndev0, ...)
  j1939_netdev_start()
					j1939_sk_bind(socket1, ndev0, ...)
                                          j1939_netdev_start()
  mutex_lock(&j1939_netdev_lock)
  j1939_priv_set(ndev0, priv)
  mutex_unlock(&j1939_netdev_lock)
					  if (priv_new)
					    kref_get(&priv_new->rx_kref)
					    return priv_new;
					  /* inside j1939_sk_bind() */
					  jsk->priv = priv
  j1939_can_rx_register(priv) // fails
  j1939_priv_set(ndev, NULL)
  kfree(priv)
					j1939_sk_sock_destruct()
					j1939_priv_put() // <- uaf

To avoid this, call j1939_can_rx_register() under j1939_netdev_lock so
that a concurrent thread cannot process j1939_priv before
j1939_can_rx_register() returns.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20230526171910.227615-3-pchelkin@ispras.ru
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/j1939/main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -286,16 +286,18 @@ struct j1939_priv *j1939_netdev_start(st
 		return priv_new;
 	}
 	j1939_priv_set(ndev, priv);
-	mutex_unlock(&j1939_netdev_lock);
 
 	ret = j1939_can_rx_register(priv);
 	if (ret < 0)
 		goto out_priv_put;
 
+	mutex_unlock(&j1939_netdev_lock);
 	return priv;
 
  out_priv_put:
 	j1939_priv_set(ndev, NULL);
+	mutex_unlock(&j1939_netdev_lock);
+
 	dev_put(ndev);
 	kfree(priv);
 


