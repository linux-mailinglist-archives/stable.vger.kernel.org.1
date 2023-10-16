Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1279F7CA1AC
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJPIc5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjJPIc4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:32:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E8A1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:32:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEDBC433BB;
        Mon, 16 Oct 2023 08:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445174;
        bh=VUrILTsse2O0WmcgiDIjNovagz1SjPqN8tvMYT+EgX8=;
        h=Subject:To:Cc:From:Date:From;
        b=KLA3cvYp+3ivwcxLO+VTxJ5Z2U/0U4bQATs2XcxtBE4Xa8VqUe0xN+UiwxiZuOjoq
         e10PoIROY8jlhb+H2AaIQhOcZ9sZm+2sUIhHF3BPnNrNAYDMhG90virreyRwXlrpqP
         JCyno6/bMjwnqvJfv41NxknPw5/6ITdAu/JofhFQ=
Subject: FAILED: patch "[PATCH] RDMA/srp: Fix srp_abort()" failed to apply to 5.10-stable tree
To:     bvanassche@acm.org, leon@kernel.org, yangx.jy@fujitsu.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 16 Oct 2023 10:32:50 +0200
Message-ID: <2023101650-makeshift-gorged-fd92@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6dbe4a8dead84de474483910b02ec9e6a10fc1a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101650-makeshift-gorged-fd92@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

6dbe4a8dead8 ("RDMA/srp: Fix srp_abort()")
9c5274eec75b ("scsi: RDMA/srp: Use scsi_cmd_to_rq() instead of scsi_cmnd.request")
ad215aaea4f9 ("RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent")
7ec2e27a3aff ("RDMA/srp: Fix a recently introduced memory leak")
2b5715fc1738 ("RDMA/srp: Fix support for unpopulated and unbalanced NUMA nodes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6dbe4a8dead84de474483910b02ec9e6a10fc1a9 Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Thu, 8 Sep 2022 16:31:39 -0700
Subject: [PATCH] RDMA/srp: Fix srp_abort()

Fix the code for converting a SCSI command pointer into an SRP request
pointer.

Cc: Xiao Yang <yangx.jy@fujitsu.com>
Fixes: ad215aaea4f9 ("RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20220908233139.3042628-1-bvanassche@acm.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 1e777b2043d6..9d593445d436 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2788,7 +2788,7 @@ static int srp_send_tsk_mgmt(struct srp_rdma_ch *ch, u64 req_tag, u64 lun,
 static int srp_abort(struct scsi_cmnd *scmnd)
 {
 	struct srp_target_port *target = host_to_target(scmnd->device->host);
-	struct srp_request *req = (struct srp_request *) scmnd->host_scribble;
+	struct srp_request *req = scsi_cmd_priv(scmnd);
 	u32 tag;
 	u16 ch_idx;
 	struct srp_rdma_ch *ch;
@@ -2796,8 +2796,6 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 
 	shost_printk(KERN_ERR, target->scsi_host, "SRP abort called\n");
 
-	if (!req)
-		return SUCCESS;
 	tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmnd));
 	ch_idx = blk_mq_unique_tag_to_hwq(tag);
 	if (WARN_ON_ONCE(ch_idx >= target->ch_count))

