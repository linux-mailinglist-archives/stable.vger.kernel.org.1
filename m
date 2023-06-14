Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2F726B35
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjFGUXv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjFGUX3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:23:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1EA2691
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C653564400
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59F8C433EF;
        Wed,  7 Jun 2023 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169361;
        bh=DBg4dF8Dr1xM7cDQc2plJHzvAUgdd9D9KA/bs1zI+Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+kwFgZgSDLWBZ/cKRDb4IQrtFg1An8NtdfVaoaI/2CATL7MXm2/Yb0c7Z40JXkqL
         SMpbCzfBHxTJOpuVxj+SAaTyjsfXeodgj28MHacqRNibCg5VM5GVz7NFkuZeKrpOWx
         cgjQQcOopk3cJM12qWBZFxmnRyH7KDURfIw9RlNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wen Gu <guwen@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 051/286] net/smc: Dont use RMBs not mapped to new link in SMCRv2 ADD LINK
Date:   Wed,  7 Jun 2023 22:12:30 +0200
Message-ID: <20230607200924.712375347@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Wen Gu <guwen@linux.alibaba.com>

[ Upstream commit 71c6aa0305e3d2365d3bfd0134b4025d9e7ba388 ]

We encountered a crash when using SMCRv2. It is caused by a logical
error in smc_llc_fill_ext_v2().

 BUG: kernel NULL pointer dereference, address: 0000000000000014
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 7 PID: 453 Comm: kworker/7:4 Kdump: loaded Tainted: G        W   E      6.4.0-rc3+ #44
 Workqueue: events smc_llc_add_link_work [smc]
 RIP: 0010:smc_llc_fill_ext_v2+0x117/0x280 [smc]
 RSP: 0018:ffffacb5c064bd88 EFLAGS: 00010282
 RAX: ffff9a6bc1c3c02c RBX: ffff9a6be3558000 RCX: 0000000000000000
 RDX: 0000000000000002 RSI: 0000000000000002 RDI: 000000000000000a
 RBP: ffffacb5c064bdb8 R08: 0000000000000040 R09: 000000000000000c
 R10: ffff9a6bc0910300 R11: 0000000000000002 R12: 0000000000000000
 R13: 0000000000000002 R14: ffff9a6bc1c3c02c R15: ffff9a6be3558250
 FS:  0000000000000000(0000) GS:ffff9a6eefdc0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000014 CR3: 000000010b078003 CR4: 00000000003706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  smc_llc_send_add_link+0x1ae/0x2f0 [smc]
  smc_llc_srv_add_link+0x2c9/0x5a0 [smc]
  ? cc_mkenc+0x40/0x60
  smc_llc_add_link_work+0xb8/0x140 [smc]
  process_one_work+0x1e5/0x3f0
  worker_thread+0x4d/0x2f0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xe5/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2c/0x50
  </TASK>

When an alernate RNIC is available in system, SMC will try to add a new
link based on the RNIC for resilience. All the RMBs in use will be mapped
to the new link. Then the RMBs' MRs corresponding to the new link will be
filled into SMCRv2 LLC ADD LINK messages.

However, smc_llc_fill_ext_v2() mistakenly accesses to unused RMBs which
haven't been mapped to the new link and have no valid MRs, thus causing
a crash. So this patch fixes the logic.

Fixes: b4ba4652b3f8 ("net/smc: extend LLC layer for SMC-Rv2")
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_llc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 8423e8e0063f4..7a8d9163d186e 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -617,6 +617,8 @@ static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
 		goto out;
 	buf_pos = smc_llc_get_first_rmb(lgr, &buf_lst);
 	for (i = 0; i < ext->num_rkeys; i++) {
+		while (buf_pos && !(buf_pos)->used)
+			buf_pos = smc_llc_get_next_rmb(lgr, &buf_lst, buf_pos);
 		if (!buf_pos)
 			break;
 		rmb = buf_pos;
@@ -626,8 +628,6 @@ static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
 			cpu_to_be64((uintptr_t)rmb->cpu_addr) :
 			cpu_to_be64((u64)sg_dma_address(rmb->sgt[lnk_idx].sgl));
 		buf_pos = smc_llc_get_next_rmb(lgr, &buf_lst, buf_pos);
-		while (buf_pos && !(buf_pos)->used)
-			buf_pos = smc_llc_get_next_rmb(lgr, &buf_lst, buf_pos);
 	}
 	len += i * sizeof(ext->rt[0]);
 out:
-- 
2.39.2



