Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0CB73553A
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjFSLCs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjFSLCZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:02:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872571700
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 088A760B78
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 11:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D91C433C9;
        Mon, 19 Jun 2023 11:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172483;
        bh=fJYtNUTrKpxSDduNMmQSvvjvZJv/a64T8f9SHv7ZNTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwDmiHS6/E07go7PG0iL++f4GrxxSFqopjiU5ViI4qLny7AYV16U9AcVb5YHL1lFu
         Ju625CxTUOBT9rZA+lYXFmaUFl7KVVzj7UF26sOon2pS2lbWw94oiPc1Nen2xcYWkK
         925CqraaQX/uDmEkujDum/BlRQCRPtZkMqwcy2Jk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Zhijian <lizhijian@fujitsu.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 059/107] RDMA/rtrs: Fix rxe_dealloc_pd warning
Date:   Mon, 19 Jun 2023 12:30:43 +0200
Message-ID: <20230619102144.308478757@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
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

From: Li Zhijian <lizhijian@fujitsu.com>

[ Upstream commit 9c29c8c7df0688f358d2df5ddd16c97c2f7292b4 ]

In current design:
1. PD and clt_path->s.dev are shared among connections.
2. every con[n]'s cleanup phase will call destroy_con_cq_qp()
3. clt_path->s.dev will be always decreased in destroy_con_cq_qp(), and
   when clt_path->s.dev become zero, it will destroy PD.
4. when con[1] failed to create, con[1] will not take clt_path->s.dev,
   but it try to decreased clt_path->s.dev

So, in case create_cm(con[0]) succeeds but create_cm(con[1]) fails,
destroy_con_cq_qp(con[1]) will be called first which will destroy the PD
while this PD is still taken by con[0].

Here, we refactor the error path of create_cm() and init_conns(), so that
we do the cleanup in the order they are created.

The warning occurs when destroying RXE PD whose reference count is not
zero.

 rnbd_client L597: Mapping device /dev/nvme0n1 on session client, (access_mode: rw, nr_poll_queues: 0)
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 26407 at drivers/infiniband/sw/rxe/rxe_pool.c:256 __rxe_cleanup+0x13a/0x170 [rdma_rxe]
 Modules linked in: rpcrdma rdma_ucm ib_iser rnbd_client libiscsi rtrs_client scsi_transport_iscsi rtrs_core rdma_cm iw_cm ib_cm crc32_generic rdma_rxe udp_tunnel ib_uverbs ib_core kmem device_dax nd_pmem dax_pmem nd_vme crc32c_intel fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod
 CPU: 0 PID: 26407 Comm: rnbd-client.sh Kdump: loaded Not tainted 6.2.0-rc6-roce-flush+ #53
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 RIP: 0010:__rxe_cleanup+0x13a/0x170 [rdma_rxe]
 Code: 45 84 e4 0f 84 5a ff ff ff 48 89 ef e8 5f 18 71 f9 84 c0 75 90 be c8 00 00 00 48 89 ef e8 be 89 1f fa 85 c0 0f 85 7b ff ff ff <0f> 0b 41 bc ea ff ff ff e9 71 ff ff ff e8 84 7f 1f fa e9 d0 fe ff
 RSP: 0018:ffffb09880b6f5f0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff99401f15d6a8 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: ffffffffbac8234b RDI: 00000000ffffffff
 RBP: ffff99401f15d6d0 R08: 0000000000000001 R09: 0000000000000001
 R10: 0000000000002d82 R11: 0000000000000000 R12: 0000000000000001
 R13: ffff994101eff208 R14: ffffb09880b6f6a0 R15: 00000000fffffe00
 FS:  00007fe113904740(0000) GS:ffff99413bc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007ff6cde656c8 CR3: 000000001f108004 CR4: 00000000001706f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  rxe_dealloc_pd+0x16/0x20 [rdma_rxe]
  ib_dealloc_pd_user+0x4b/0x80 [ib_core]
  rtrs_ib_dev_put+0x79/0xd0 [rtrs_core]
  destroy_con_cq_qp+0x8a/0xa0 [rtrs_client]
  init_path+0x1e7/0x9a0 [rtrs_client]
  ? __pfx_autoremove_wake_function+0x10/0x10
  ? lock_is_held_type+0xd7/0x130
  ? rcu_read_lock_sched_held+0x43/0x80
  ? pcpu_alloc+0x3dd/0x7d0
  ? rtrs_clt_init_stats+0x18/0x40 [rtrs_client]
  rtrs_clt_open+0x24f/0x5a0 [rtrs_client]
  ? __pfx_rnbd_clt_link_ev+0x10/0x10 [rnbd_client]
  rnbd_clt_map_device+0x6a5/0xe10 [rnbd_client]

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Link: https://lore.kernel.org/r/1682384563-2-4-git-send-email-lizhijian@fujitsu.com
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 55 +++++++++++---------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 54eb6556c63db..afe8670f9e555 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2028,6 +2028,7 @@ static int rtrs_clt_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	return 0;
 }
 
+/* The caller should do the cleanup in case of error */
 static int create_cm(struct rtrs_clt_con *con)
 {
 	struct rtrs_path *s = con->c.path;
@@ -2050,14 +2051,14 @@ static int create_cm(struct rtrs_clt_con *con)
 	err = rdma_set_reuseaddr(cm_id, 1);
 	if (err != 0) {
 		rtrs_err(s, "Set address reuse failed, err: %d\n", err);
-		goto destroy_cm;
+		return err;
 	}
 	err = rdma_resolve_addr(cm_id, (struct sockaddr *)&clt_path->s.src_addr,
 				(struct sockaddr *)&clt_path->s.dst_addr,
 				RTRS_CONNECT_TIMEOUT_MS);
 	if (err) {
 		rtrs_err(s, "Failed to resolve address, err: %d\n", err);
-		goto destroy_cm;
+		return err;
 	}
 	/*
 	 * Combine connection status and session events. This is needed
@@ -2072,29 +2073,15 @@ static int create_cm(struct rtrs_clt_con *con)
 		if (err == 0)
 			err = -ETIMEDOUT;
 		/* Timedout or interrupted */
-		goto errr;
-	}
-	if (con->cm_err < 0) {
-		err = con->cm_err;
-		goto errr;
+		return err;
 	}
-	if (READ_ONCE(clt_path->state) != RTRS_CLT_CONNECTING) {
+	if (con->cm_err < 0)
+		return con->cm_err;
+	if (READ_ONCE(clt_path->state) != RTRS_CLT_CONNECTING)
 		/* Device removal */
-		err = -ECONNABORTED;
-		goto errr;
-	}
+		return -ECONNABORTED;
 
 	return 0;
-
-errr:
-	stop_cm(con);
-	mutex_lock(&con->con_mutex);
-	destroy_con_cq_qp(con);
-	mutex_unlock(&con->con_mutex);
-destroy_cm:
-	destroy_cm(con);
-
-	return err;
 }
 
 static void rtrs_clt_path_up(struct rtrs_clt_path *clt_path)
@@ -2331,7 +2318,7 @@ static void rtrs_clt_close_work(struct work_struct *work)
 static int init_conns(struct rtrs_clt_path *clt_path)
 {
 	unsigned int cid;
-	int err;
+	int err, i;
 
 	/*
 	 * On every new session connections increase reconnect counter
@@ -2347,10 +2334,8 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 			goto destroy;
 
 		err = create_cm(to_clt_con(clt_path->s.con[cid]));
-		if (err) {
-			destroy_con(to_clt_con(clt_path->s.con[cid]));
+		if (err)
 			goto destroy;
-		}
 	}
 	err = alloc_path_reqs(clt_path);
 	if (err)
@@ -2361,15 +2346,21 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 	return 0;
 
 destroy:
-	while (cid--) {
-		struct rtrs_clt_con *con = to_clt_con(clt_path->s.con[cid]);
+	/* Make sure we do the cleanup in the order they are created */
+	for (i = 0; i <= cid; i++) {
+		struct rtrs_clt_con *con;
 
-		stop_cm(con);
+		if (!clt_path->s.con[i])
+			break;
 
-		mutex_lock(&con->con_mutex);
-		destroy_con_cq_qp(con);
-		mutex_unlock(&con->con_mutex);
-		destroy_cm(con);
+		con = to_clt_con(clt_path->s.con[i]);
+		if (con->c.cm_id) {
+			stop_cm(con);
+			mutex_lock(&con->con_mutex);
+			destroy_con_cq_qp(con);
+			mutex_unlock(&con->con_mutex);
+			destroy_cm(con);
+		}
 		destroy_con(con);
 	}
 	/*
-- 
2.39.2



