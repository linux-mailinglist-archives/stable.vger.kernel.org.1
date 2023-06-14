Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5F572C0CA
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjFLKym (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbjFLKyS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF3D2717
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E6C160F87
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D81C433D2;
        Mon, 12 Jun 2023 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566395;
        bh=NlSh3LnmlvThLA+x7dnAq2TM/Z73fkIxBnri572cEss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrW0w2ovAcBEf9ONH1rI/J62FetgboQK9/YU7DsyK6nkdcOVFfW+aUG6MMdnBLtrT
         gCnrbJ0MxKuAn3vLuj8+qVec2NTfORUujgO73cnXwRaldSe0F760kVOheu0SDzGVt+
         JlFXbFjjam5Lfabijo1NSKBesaZIrR6IQFxHtt8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wen Gu <guwen@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 016/132] net/smc: Avoid to access invalid RMBs MRs in SMCRv1 ADD LINK CONT
Date:   Mon, 12 Jun 2023 12:25:50 +0200
Message-ID: <20230612101711.013173077@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Wen Gu <guwen@linux.alibaba.com>

[ Upstream commit c308e9ec004721a656c193243eab61a8be324657 ]

SMCRv1 has a similar issue to SMCRv2 (see link below) that may access
invalid MRs of RMBs when construct LLC ADD LINK CONT messages.

 BUG: kernel NULL pointer dereference, address: 0000000000000014
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 5 PID: 48 Comm: kworker/5:0 Kdump: loaded Tainted: G W   E      6.4.0-rc3+ #49
 Workqueue: events smc_llc_add_link_work [smc]
 RIP: 0010:smc_llc_add_link_cont+0x160/0x270 [smc]
 RSP: 0018:ffffa737801d3d50 EFLAGS: 00010286
 RAX: ffff964f82144000 RBX: ffffa737801d3dd8 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff964f81370c30
 RBP: ffffa737801d3dd4 R08: ffff964f81370000 R09: ffffa737801d3db0
 R10: 0000000000000001 R11: 0000000000000060 R12: ffff964f82e70000
 R13: ffff964f81370c38 R14: ffffa737801d3dd3 R15: 0000000000000001
 FS:  0000000000000000(0000) GS:ffff9652bfd40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000014 CR3: 000000008fa20004 CR4: 00000000003706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  smc_llc_srv_rkey_exchange+0xa7/0x190 [smc]
  smc_llc_srv_add_link+0x3ae/0x5a0 [smc]
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
to the new link. Then the RMBs' MRs corresponding to the new link will
be filled into LLC messages. For SMCRv1, they are ADD LINK CONT messages.

However smc_llc_add_link_cont() may mistakenly access to unused RMBs which
haven't been mapped to the new link and have no valid MRs, thus causing a
crash. So this patch fixes it.

Fixes: 87f88cda2128 ("net/smc: rkey processing for a new link as SMC client")
Link: https://lore.kernel.org/r/1685101741-74826-3-git-send-email-guwen@linux.alibaba.com
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_llc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 3008dfdf7c55e..760f8bbff822e 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -851,6 +851,8 @@ static int smc_llc_add_link_cont(struct smc_link *link,
 	addc_llc->num_rkeys = *num_rkeys_todo;
 	n = *num_rkeys_todo;
 	for (i = 0; i < min_t(u8, n, SMC_LLC_RKEYS_PER_CONT_MSG); i++) {
+		while (*buf_pos && !(*buf_pos)->used)
+			*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
 		if (!*buf_pos) {
 			addc_llc->num_rkeys = addc_llc->num_rkeys -
 					      *num_rkeys_todo;
@@ -867,8 +869,6 @@ static int smc_llc_add_link_cont(struct smc_link *link,
 
 		(*num_rkeys_todo)--;
 		*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
-		while (*buf_pos && !(*buf_pos)->used)
-			*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
 	}
 	addc_llc->hd.common.llc_type = SMC_LLC_ADD_LINK_CONT;
 	addc_llc->hd.length = sizeof(struct smc_llc_msg_add_link_cont);
-- 
2.39.2



