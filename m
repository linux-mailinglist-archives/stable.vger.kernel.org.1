Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF97E7CA1F9
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjJPIoA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjJPIn7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:43:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3100DC
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:43:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3155C433CA;
        Mon, 16 Oct 2023 08:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445837;
        bh=ccDAiy6tSYOlmUjcBGi3yuwIAAAzO01paigHvvnLsTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L79r1oSsGTVGSvI46c/0aIYBMcurPwuu+yxqnad9/tbZowY7pIvi6XRe06VyTeD8R
         k3i1iB642IuvcaTMc6N/IH5bSYDh17voqjwImMmgOnCgpDRC7goO1O0hrJ9uEq2jQo
         K7bvfhwikzyeVvQ6656DMrYrRw1I23x4RquFnF6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 004/102] scsi: ib_srp: Call scsi_done() directly
Date:   Mon, 16 Oct 2023 10:40:03 +0200
Message-ID: <20231016083953.807221451@linuxfoundation.org>
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

[ Upstream commit 5f9ae9eecb15ef00d89a5884add1117a8e634e7f ]

Conditional statements are faster than indirect calls. Hence call
scsi_done() directly.

Link: https://lore.kernel.org/r/20211007202923.2174984-6-bvanassche@acm.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: e193b7955dfa ("RDMA/srp: Do not call scsi_done() from srp_abort()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 7701204fe5423..df7c740e26338 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1266,7 +1266,7 @@ static void srp_finish_req(struct srp_rdma_ch *ch, struct srp_request *req,
 	if (scmnd) {
 		srp_free_req(ch, req, scmnd, 0);
 		scmnd->result = result;
-		scmnd->scsi_done(scmnd);
+		scsi_done(scmnd);
 	}
 }
 
@@ -1984,7 +1984,7 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 		srp_free_req(ch, req, scmnd,
 			     be32_to_cpu(rsp->req_lim_delta));
 
-		scmnd->scsi_done(scmnd);
+		scsi_done(scmnd);
 	}
 }
 
@@ -2236,7 +2236,7 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 
 err:
 	if (scmnd->result) {
-		scmnd->scsi_done(scmnd);
+		scsi_done(scmnd);
 		ret = 0;
 	} else {
 		ret = SCSI_MLQUEUE_HOST_BUSY;
@@ -2806,7 +2806,7 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 	if (ret == SUCCESS) {
 		srp_free_req(ch, req, scmnd, 0);
 		scmnd->result = DID_ABORT << 16;
-		scmnd->scsi_done(scmnd);
+		scsi_done(scmnd);
 	}
 
 	return ret;
-- 
2.40.1



