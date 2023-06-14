Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E667F72700C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjFGVEI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjFGVDx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:03:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9312119
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 386D164997
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3BEC433EF;
        Wed,  7 Jun 2023 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171809;
        bh=//9mgdWRGFYLa/L8ayJCpmcXqOgUIwOJgYovWo5CYLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mP/ueTHBqQYw3LRp0aRKmsUnwjh8q6qgOAc8ykMHRVRgTf5bPgQDEttCS6nnCE7d6
         Lkpl+RxEPNDSc0MIYlPt1nXxSSfeRBxUjKkIobnDFSETZQenFp3jseQYPNH46tggw5
         PPaSFqFNCbv2EOZ1fqA6GKSj+jrVST2Xt/EAxgw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kamal Heib <kamalheib1@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.15 158/159] RDMA/irdma: Fix drain SQ hang with no completion
Date:   Wed,  7 Jun 2023 22:17:41 +0200
Message-ID: <20230607200908.831116397@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
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

From: Shiraz Saleem <shiraz.saleem@intel.com>

commit ead54ced6321099978d30d62dc49c282a6e70574 upstream.

SW generated completions for outstanding WRs posted on SQ
after QP is in error target the wrong CQ. This causes the
ib_drain_sq to hang with no completion.

Fix this to generate completions on the right CQ.

[  863.969340] INFO: task kworker/u52:2:671 blocked for more than 122 seconds.
[  863.979224]       Not tainted 5.14.0-130.el9.x86_64 #1
[  863.986588] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  863.996997] task:kworker/u52:2   state:D stack:    0 pid:  671 ppid:     2 flags:0x00004000
[  864.007272] Workqueue: xprtiod xprt_autoclose [sunrpc]
[  864.014056] Call Trace:
[  864.017575]  __schedule+0x206/0x580
[  864.022296]  schedule+0x43/0xa0
[  864.026736]  schedule_timeout+0x115/0x150
[  864.032185]  __wait_for_common+0x93/0x1d0
[  864.037717]  ? usleep_range_state+0x90/0x90
[  864.043368]  __ib_drain_sq+0xf6/0x170 [ib_core]
[  864.049371]  ? __rdma_block_iter_next+0x80/0x80 [ib_core]
[  864.056240]  ib_drain_sq+0x66/0x70 [ib_core]
[  864.062003]  rpcrdma_xprt_disconnect+0x82/0x3b0 [rpcrdma]
[  864.069365]  ? xprt_prepare_transmit+0x5d/0xc0 [sunrpc]
[  864.076386]  xprt_rdma_close+0xe/0x30 [rpcrdma]
[  864.082593]  xprt_autoclose+0x52/0x100 [sunrpc]
[  864.088718]  process_one_work+0x1e8/0x3c0
[  864.094170]  worker_thread+0x50/0x3b0
[  864.099109]  ? rescuer_thread+0x370/0x370
[  864.104473]  kthread+0x149/0x170
[  864.109022]  ? set_kthread_struct+0x40/0x40
[  864.114713]  ret_from_fork+0x22/0x30

Fixes: 81091d7696ae ("RDMA/irdma: Add SW mechanism to generate completions on error")
Link: https://lore.kernel.org/r/20220824154358.117-1-shiraz.saleem@intel.com
Reported-by: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/irdma/utils.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2660,7 +2660,7 @@ void irdma_generate_flush_completions(st
 		spin_unlock_irqrestore(&iwqp->lock, flags2);
 		spin_unlock_irqrestore(&iwqp->iwscq->lock, flags1);
 		if (compl_generated)
-			irdma_comp_handler(iwqp->iwrcq);
+			irdma_comp_handler(iwqp->iwscq);
 	} else {
 		spin_unlock_irqrestore(&iwqp->iwscq->lock, flags1);
 		mod_delayed_work(iwqp->iwdev->cleanup_wq, &iwqp->dwork_flush,


