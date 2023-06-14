Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ADE713EC4
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjE1Tij (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjE1Tii (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C64DAB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D6C61E85
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49750C433EF;
        Sun, 28 May 2023 19:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302716;
        bh=2KTXx0KVhpiWM2O+92LYwy5IlGeQ2CIJ6S24A0Coeps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nEMcXG2n57lbK9aszZGQdX5OljzO3Me2X5sknW7J7rnumxBfJgrEeYCdunzWw4y+p
         cnCTSD8rctO5ssKU/7s0FKWsC9wMyORDBM03cCPMv2YXAdGBCf2lofKSoi5maWbYxN
         GX9wgD/raBO+709OHCAUy+wFlKulLdqMq+Z8V6Pc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wen Gu <guwen@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 117/119] net/smc: Reset connection when trying to use SMCRv2 fails.
Date:   Sun, 28 May 2023 20:11:57 +0100
Message-Id: <20230528190839.351327617@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wen Gu <guwen@linux.alibaba.com>

commit 35112271672ae98f45df7875244a4e33aa215e31 upstream.

We found a crash when using SMCRv2 with 2 Mellanox ConnectX-4. It
can be reproduced by:

- smc_run nginx
- smc_run wrk -t 32 -c 500 -d 30 http://<ip>:<port>

 BUG: kernel NULL pointer dereference, address: 0000000000000014
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 8000000108713067 P4D 8000000108713067 PUD 151127067 PMD 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 4 PID: 2441 Comm: kworker/4:249 Kdump: loaded Tainted: G        W   E      6.4.0-rc1+ #42
 Workqueue: smc_hs_wq smc_listen_work [smc]
 RIP: 0010:smc_clc_send_confirm_accept+0x284/0x580 [smc]
 RSP: 0018:ffffb8294b2d7c78 EFLAGS: 00010a06
 RAX: ffff8f1873238880 RBX: ffffb8294b2d7dc8 RCX: 0000000000000000
 RDX: 00000000000000b4 RSI: 0000000000000001 RDI: 0000000000b40c00
 RBP: ffffb8294b2d7db8 R08: ffff8f1815c5860c R09: 0000000000000000
 R10: 0000000000000400 R11: 0000000000000000 R12: ffff8f1846f56180
 R13: ffff8f1815c5860c R14: 0000000000000001 R15: 0000000000000001
 FS:  0000000000000000(0000) GS:ffff8f1aefd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000014 CR3: 00000001027a0001 CR4: 00000000003706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? mlx5_ib_map_mr_sg+0xa1/0xd0 [mlx5_ib]
  ? smcr_buf_map_link+0x24b/0x290 [smc]
  ? __smc_buf_create+0x4ee/0x9b0 [smc]
  smc_clc_send_accept+0x4c/0xb0 [smc]
  smc_listen_work+0x346/0x650 [smc]
  ? __schedule+0x279/0x820
  process_one_work+0x1e5/0x3f0
  worker_thread+0x4d/0x2f0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xe5/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2c/0x50
  </TASK>

During the CLC handshake, server sequentially tries available SMCRv2
and SMCRv1 devices in smc_listen_work().

If an SMCRv2 device is found. SMCv2 based link group and link will be
assigned to the connection. Then assumed that some buffer assignment
errors happen later in the CLC handshake, such as RMB registration
failure, server will give up SMCRv2 and try SMCRv1 device instead. But
the resources assigned to the connection won't be reset.

When server tries SMCRv1 device, the connection creation process will
be executed again. Since conn->lnk has been assigned when trying SMCRv2,
it will not be set to the correct SMCRv1 link in
smcr_lgr_conn_assign_link(). So in such situation, conn->lgr points to
correct SMCRv1 link group but conn->lnk points to the SMCRv2 link
mistakenly.

Then in smc_clc_send_confirm_accept(), conn->rmb_desc->mr[link->link_idx]
will be accessed. Since the link->link_idx is not correct, the related
MR may not have been initialized, so crash happens.

 | Try SMCRv2 device first
 |     |-> conn->lgr:	assign existed SMCRv2 link group;
 |     |-> conn->link:	assign existed SMCRv2 link (link_idx may be 1 in SMC_LGR_SYMMETRIC);
 |     |-> sndbuf & RMB creation fails, quit;
 |
 | Try SMCRv1 device then
 |     |-> conn->lgr:	create SMCRv1 link group and assign;
 |     |-> conn->link:	keep SMCRv2 link mistakenly;
 |     |-> sndbuf & RMB creation succeed, only RMB->mr[link_idx = 0]
 |         initialized.
 |
 | Then smc_clc_send_confirm_accept() accesses
 | conn->rmb_desc->mr[conn->link->link_idx, which is 1], then crash.
 v

This patch tries to fix this by cleaning conn->lnk before assigning
link. In addition, it is better to reset the connection and clean the
resources assigned if trying SMCRv2 failed in buffer creation or
registration.

Fixes: e49300a6bf62 ("net/smc: add listen processing for SMC-Rv2")
Link: https://lore.kernel.org/r/20220523055056.2078994-1-liuyacan@corp.netease.com/
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c   |    9 +++++++--
 net/smc/smc_core.c |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1987,8 +1987,10 @@ static int smc_listen_rdma_init(struct s
 		return rc;
 
 	/* create send buffer and rmb */
-	if (smc_buf_create(new_smc, false))
+	if (smc_buf_create(new_smc, false)) {
+		smc_conn_abort(new_smc, ini->first_contact_local);
 		return SMC_CLC_DECL_MEM;
+	}
 
 	return 0;
 }
@@ -2204,8 +2206,11 @@ static void smc_find_rdma_v2_device_serv
 	smcr_version = ini->smcr_version;
 	ini->smcr_version = SMC_V2;
 	rc = smc_listen_rdma_init(new_smc, ini);
-	if (!rc)
+	if (!rc) {
 		rc = smc_listen_rdma_reg(new_smc, ini->first_contact_local);
+		if (rc)
+			smc_conn_abort(new_smc, ini->first_contact_local);
+	}
 	if (!rc)
 		return;
 	ini->smcr_version = smcr_version;
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -127,6 +127,7 @@ static int smcr_lgr_conn_assign_link(str
 	int i, j;
 
 	/* do link balancing */
+	conn->lnk = NULL;	/* reset conn->lnk first */
 	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 		struct smc_link *lnk = &conn->lgr->lnk[i];
 


