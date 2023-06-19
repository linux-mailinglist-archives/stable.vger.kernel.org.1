Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203257354B5
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjFSK6f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjFSK6S (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:58:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB3C19BE
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22B4360B88
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8E1C433C8;
        Mon, 19 Jun 2023 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172183;
        bh=NhizRRzADbd1FUD2ncofJYapn+yHkNolWV52v9y0wxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uq4tgMC9UT9PYYT7qJJPdFoo79gtFCh/CCA6yUdbzAH6mlRWz/Vpfb6PD40rfVYpj
         mAke6vsWzM3K15jHRVKO8z7AMirCxp+CDy+w0vLErKl1bno6B44ew+efLuhjLib+QJ
         YoOZKCG+0I/nnmR9hd2bEnhUIaxJLX1LQgl50JKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sagi Grimberg <sagi@grimberg.me>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 59/89] IB/isert: Fix dead lock in ib_isert
Date:   Mon, 19 Jun 2023 12:30:47 +0200
Message-ID: <20230619102140.951423156@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

[ Upstream commit 691b0480933f0ce88a81ed1d1a0aff340ff6293a ]

- When a iSER session is released, ib_isert module is taking a mutex
  lock and releasing all pending connections. As part of this, ib_isert
  is destroying rdma cm_id. To destroy cm_id, rdma_cm module is sending
  CM events to CMA handler of ib_isert. This handler is taking same
  mutex lock. Hence it leads to deadlock between ib_isert & rdma_cm
  modules.

- For fix, created local list of pending connections and release the
  connection outside of mutex lock.

Calltrace:
---------
[ 1229.791410] INFO: task kworker/10:1:642 blocked for more than 120 seconds.
[ 1229.791416]       Tainted: G           OE    --------- -  - 4.18.0-372.9.1.el8.x86_64 #1
[ 1229.791418] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1229.791419] task:kworker/10:1    state:D stack:    0 pid:  642 ppid:     2 flags:0x80004000
[ 1229.791424] Workqueue: ib_cm cm_work_handler [ib_cm]
[ 1229.791436] Call Trace:
[ 1229.791438]  __schedule+0x2d1/0x830
[ 1229.791445]  ? select_idle_sibling+0x23/0x6f0
[ 1229.791449]  schedule+0x35/0xa0
[ 1229.791451]  schedule_preempt_disabled+0xa/0x10
[ 1229.791453]  __mutex_lock.isra.7+0x310/0x420
[ 1229.791456]  ? select_task_rq_fair+0x351/0x990
[ 1229.791459]  isert_cma_handler+0x224/0x330 [ib_isert]
[ 1229.791463]  ? ttwu_queue_wakelist+0x159/0x170
[ 1229.791466]  cma_cm_event_handler+0x25/0xd0 [rdma_cm]
[ 1229.791474]  cma_ib_handler+0xa7/0x2e0 [rdma_cm]
[ 1229.791478]  cm_process_work+0x22/0xf0 [ib_cm]
[ 1229.791483]  cm_work_handler+0xf4/0xf30 [ib_cm]
[ 1229.791487]  ? move_linked_works+0x6e/0xa0
[ 1229.791490]  process_one_work+0x1a7/0x360
[ 1229.791491]  ? create_worker+0x1a0/0x1a0
[ 1229.791493]  worker_thread+0x30/0x390
[ 1229.791494]  ? create_worker+0x1a0/0x1a0
[ 1229.791495]  kthread+0x10a/0x120
[ 1229.791497]  ? set_kthread_struct+0x40/0x40
[ 1229.791499]  ret_from_fork+0x1f/0x40

[ 1229.791739] INFO: task targetcli:28666 blocked for more than 120 seconds.
[ 1229.791740]       Tainted: G           OE    --------- -  - 4.18.0-372.9.1.el8.x86_64 #1
[ 1229.791741] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1229.791742] task:targetcli       state:D stack:    0 pid:28666 ppid:  5510 flags:0x00004080
[ 1229.791743] Call Trace:
[ 1229.791744]  __schedule+0x2d1/0x830
[ 1229.791746]  schedule+0x35/0xa0
[ 1229.791748]  schedule_preempt_disabled+0xa/0x10
[ 1229.791749]  __mutex_lock.isra.7+0x310/0x420
[ 1229.791751]  rdma_destroy_id+0x15/0x20 [rdma_cm]
[ 1229.791755]  isert_connect_release+0x115/0x130 [ib_isert]
[ 1229.791757]  isert_free_np+0x87/0x140 [ib_isert]
[ 1229.791761]  iscsit_del_np+0x74/0x120 [iscsi_target_mod]
[ 1229.791776]  lio_target_np_driver_store+0xe9/0x140 [iscsi_target_mod]
[ 1229.791784]  configfs_write_file+0xb2/0x110
[ 1229.791788]  vfs_write+0xa5/0x1a0
[ 1229.791792]  ksys_write+0x4f/0xb0
[ 1229.791794]  do_syscall_64+0x5b/0x1a0
[ 1229.791798]  entry_SYSCALL_64_after_hwframe+0x65/0xca

Fixes: bd3792205aae ("iser-target: Fix pending connections handling in target stack shutdown sequnce")
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Link: https://lore.kernel.org/r/20230606102531.162967-2-saravanan.vajravel@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 2d0d966fba2c8..988b957107cc1 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2421,6 +2421,7 @@ isert_free_np(struct iscsi_np *np)
 {
 	struct isert_np *isert_np = np->np_context;
 	struct isert_conn *isert_conn, *n;
+	LIST_HEAD(drop_conn_list);
 
 	if (isert_np->cm_id)
 		rdma_destroy_id(isert_np->cm_id);
@@ -2440,7 +2441,7 @@ isert_free_np(struct iscsi_np *np)
 					 node) {
 			isert_info("cleaning isert_conn %p state (%d)\n",
 				   isert_conn, isert_conn->state);
-			isert_connect_release(isert_conn);
+			list_move_tail(&isert_conn->node, &drop_conn_list);
 		}
 	}
 
@@ -2451,11 +2452,16 @@ isert_free_np(struct iscsi_np *np)
 					 node) {
 			isert_info("cleaning isert_conn %p state (%d)\n",
 				   isert_conn, isert_conn->state);
-			isert_connect_release(isert_conn);
+			list_move_tail(&isert_conn->node, &drop_conn_list);
 		}
 	}
 	mutex_unlock(&isert_np->mutex);
 
+	list_for_each_entry_safe(isert_conn, n, &drop_conn_list, node) {
+		list_del_init(&isert_conn->node);
+		isert_connect_release(isert_conn);
+	}
+
 	np->np_context = NULL;
 	kfree(isert_np);
 }
-- 
2.39.2



