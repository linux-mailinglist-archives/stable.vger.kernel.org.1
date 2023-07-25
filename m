Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C97761760
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjGYLrw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjGYLrf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5946712C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC2DE61648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03EEC433C7;
        Tue, 25 Jul 2023 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285651;
        bh=DnrOXR0TKMzAOf7o+KQ20lEK2e6hnduqo3p/IhGjV1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=la/Py/45oENUtsazCQzoMoui4OqR0XSlX20+CSz/SEU0v0JWXtax/yzKjTlwzyGJv
         ZRa2bzBPvyS7zUkaRos8P/jvIwTMklY6RIf1v5yW4bwCLbTipzB1/UvdxJy+vymRNo
         pvy9a0mTiSuP6UzzyPe9WMAWuIEA4nFC6C6+2L7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, YueHaibing <yuehaibing@huawei.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.4 280/313] can: bcm: Fix UAF in bcm_proc_show()
Date:   Tue, 25 Jul 2023 12:47:13 +0200
Message-ID: <20230725104533.179065403@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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

From: YueHaibing <yuehaibing@huawei.com>

commit 55c3b96074f3f9b0aee19bf93cd71af7516582bb upstream.

BUG: KASAN: slab-use-after-free in bcm_proc_show+0x969/0xa80
Read of size 8 at addr ffff888155846230 by task cat/7862

CPU: 1 PID: 7862 Comm: cat Not tainted 6.5.0-rc1-00153-gc8746099c197 #230
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xd5/0x150
 print_report+0xc1/0x5e0
 kasan_report+0xba/0xf0
 bcm_proc_show+0x969/0xa80
 seq_read_iter+0x4f6/0x1260
 seq_read+0x165/0x210
 proc_reg_read+0x227/0x300
 vfs_read+0x1d5/0x8d0
 ksys_read+0x11e/0x240
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Allocated by task 7846:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 __kasan_kmalloc+0x9e/0xa0
 bcm_sendmsg+0x264b/0x44e0
 sock_sendmsg+0xda/0x180
 ____sys_sendmsg+0x735/0x920
 ___sys_sendmsg+0x11d/0x1b0
 __sys_sendmsg+0xfa/0x1d0
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 7846:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x27/0x40
 ____kasan_slab_free+0x161/0x1c0
 slab_free_freelist_hook+0x119/0x220
 __kmem_cache_free+0xb4/0x2e0
 rcu_core+0x809/0x1bd0

bcm_op is freed before procfs entry be removed in bcm_release(),
this lead to bcm_proc_show() may read the freed bcm_op.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/all/20230715092543.15548-1-yuehaibing@huawei.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/bcm.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1523,6 +1523,12 @@ static int bcm_release(struct socket *so
 
 	lock_sock(sk);
 
+#if IS_ENABLED(CONFIG_PROC_FS)
+	/* remove procfs entry */
+	if (net->can.bcmproc_dir && bo->bcm_proc_read)
+		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
+#endif /* CONFIG_PROC_FS */
+
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
 		bcm_remove_op(op);
 
@@ -1558,12 +1564,6 @@ static int bcm_release(struct socket *so
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
 		bcm_remove_op(op);
 
-#if IS_ENABLED(CONFIG_PROC_FS)
-	/* remove procfs entry */
-	if (net->can.bcmproc_dir && bo->bcm_proc_read)
-		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
-#endif /* CONFIG_PROC_FS */
-
 	/* remove device reference */
 	if (bo->bound) {
 		bo->bound   = 0;


