Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8927CA1F8
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjJPInz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjJPIny (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:43:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF2B9B
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:43:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0672C433C8;
        Mon, 16 Oct 2023 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445832;
        bh=CpKEZxQcYPLi2S7ZqI9hIVWZ2nRZ0kju7NVCZyMzqzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHfXd6DLGG/rU3Um0FED8p/MLeMm/ZoaweRSS5LDSn+dBPHRdZvmjKWbLutPmQ6pu
         mrcNkZ5+ubG9d3oMhu5o/BckOUuMLXhANPW5ee/R95WuAY0aIhQgLslQBrwlbjjwXA
         NgDuPkL4zaBoalezu8la9GnhaBIixS5QB33TvX7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Block <bblock@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 003/102] scsi: core: Rename scsi_mq_done() into scsi_done() and export it
Date:   Mon, 16 Oct 2023 10:40:02 +0200
Message-ID: <20231016083953.782206819@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit a710eacb9d13cb5d9eb5341ebc6fc8f7b96f8c6f ]

Since the removal of the legacy block layer there is only one completion
function left in the SCSI core, namely scsi_mq_done(). Rename it into
scsi_done(). Export that function to allow SCSI LLDs to call it directly.

Link: https://lore.kernel.org/r/20211007202923.2174984-3-bvanassche@acm.org
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: e193b7955dfa ("RDMA/srp: Do not call scsi_done() from srp_abort()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_lib.c  | 5 +++--
 include/scsi/scsi_cmnd.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 7bdaa6b757cd4..3dbfd15e6fe79 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1576,7 +1576,7 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 	return scsi_cmd_to_driver(cmd)->init_command(cmd);
 }
 
-static void scsi_mq_done(struct scsi_cmnd *cmd)
+void scsi_done(struct scsi_cmnd *cmd)
 {
 	switch (cmd->submitter) {
 	case SUBMITTED_BY_BLOCK_LAYER:
@@ -1594,6 +1594,7 @@ static void scsi_mq_done(struct scsi_cmnd *cmd)
 	trace_scsi_dispatch_cmd_done(cmd);
 	blk_mq_complete_request(scsi_cmd_to_rq(cmd));
 }
+EXPORT_SYMBOL(scsi_done);
 
 static void scsi_mq_put_budget(struct request_queue *q, int budget_token)
 {
@@ -1694,7 +1695,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	scsi_set_resid(cmd, 0);
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 	cmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
-	cmd->scsi_done = scsi_mq_done;
+	cmd->scsi_done = scsi_done;
 
 	blk_mq_start_request(req);
 	reason = scsi_dispatch_cmd(cmd);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 0823bad7b0c90..e1180771604d7 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -172,6 +172,8 @@ static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 	return *(struct scsi_driver **)rq->rq_disk->private_data;
 }
 
+void scsi_done(struct scsi_cmnd *cmd);
+
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
 
 extern void *scsi_kmap_atomic_sg(struct scatterlist *sg, int sg_count,
-- 
2.40.1



