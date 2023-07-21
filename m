Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4957175D385
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGUTLk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjGUTLj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06F30E3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3F5A61D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D5AC433C7;
        Fri, 21 Jul 2023 19:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966697;
        bh=feuRd42kuwmVphIpYFZbb+hWpPxK+OEA5J6/gXED/8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AI9ofzuOZJXc7quy11KcZCOqp5EQi3HqbUaOREg4XGBnkF9eWbd/g2kZqem5ifKK9
         Q4giSuR4j+tSGZAoRFeXRDip3ioS68okndaj5vKDH2C/mi3iBpnNRuFrjeJ48ohOSM
         m9G5DidB4Yx2na4qrbktgM8OTcWSxDSo4exP+bzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pu Lehui <pulehui@huawei.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Hou Tao <houtao1@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 435/532] bpf: cpumap: Fix memory leak in cpu_map_update_elem
Date:   Fri, 21 Jul 2023 18:05:39 +0200
Message-ID: <20230721160638.160260362@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pu Lehui <pulehui@huawei.com>

[ Upstream commit 4369016497319a9635702da010d02af1ebb1849d ]

Syzkaller reported a memory leak as follows:

BUG: memory leak
unreferenced object 0xff110001198ef748 (size 192):
  comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
  hex dump (first 32 bytes):
    00 00 00 00 4a 19 00 00 80 ad e3 e4 fe ff c0 00  ....J...........
    00 b2 d3 0c 01 00 11 ff 28 f5 8e 19 01 00 11 ff  ........(.......
  backtrace:
    [<ffffffffadd28087>] __cpu_map_entry_alloc+0xf7/0xb00
    [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
    [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
    [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
    [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
    [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
    [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

BUG: memory leak
unreferenced object 0xff110001198ef528 (size 192):
  comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffadd281f0>] __cpu_map_entry_alloc+0x260/0xb00
    [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
    [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
    [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
    [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
    [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
    [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

BUG: memory leak
unreferenced object 0xff1100010fd93d68 (size 8):
  comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffffade5db3e>] kvmalloc_node+0x11e/0x170
    [<ffffffffadd28280>] __cpu_map_entry_alloc+0x2f0/0xb00
    [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
    [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
    [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
    [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
    [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
    [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

In the cpu_map_update_elem flow, when kthread_stop is called before
calling the threadfn of rcpu->kthread, since the KTHREAD_SHOULD_STOP bit
of kthread has been set by kthread_stop, the threadfn of rcpu->kthread
will never be executed, and rcpu->refcnt will never be 0, which will
lead to the allocated rcpu, rcpu->queue and rcpu->queue->queue cannot be
released.

Calling kthread_stop before executing kthread's threadfn will return
-EINTR. We can complete the release of memory resources in this state.

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20230711115848.2701559-1-pulehui@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/cpumap.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 585b2b77ccc4f..db6221773e43f 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -126,22 +126,6 @@ static void get_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 	atomic_inc(&rcpu->refcnt);
 }
 
-/* called from workqueue, to workaround syscall using preempt_disable */
-static void cpu_map_kthread_stop(struct work_struct *work)
-{
-	struct bpf_cpu_map_entry *rcpu;
-
-	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
-
-	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
-	 * as it waits until all in-flight call_rcu() callbacks complete.
-	 */
-	rcu_barrier();
-
-	/* kthread_stop will wake_up_process and wait for it to complete */
-	kthread_stop(rcpu->kthread);
-}
-
 static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 {
 	/* The tear-down procedure should have made sure that queue is
@@ -169,6 +153,30 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 	}
 }
 
+/* called from workqueue, to workaround syscall using preempt_disable */
+static void cpu_map_kthread_stop(struct work_struct *work)
+{
+	struct bpf_cpu_map_entry *rcpu;
+	int err;
+
+	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
+
+	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
+	 * as it waits until all in-flight call_rcu() callbacks complete.
+	 */
+	rcu_barrier();
+
+	/* kthread_stop will wake_up_process and wait for it to complete */
+	err = kthread_stop(rcpu->kthread);
+	if (err) {
+		/* kthread_stop may be called before cpu_map_kthread_run
+		 * is executed, so we need to release the memory related
+		 * to rcpu.
+		 */
+		put_cpu_map_entry(rcpu);
+	}
+}
+
 static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 				     struct list_head *listp,
 				     struct xdp_cpumap_stats *stats)
-- 
2.39.2



