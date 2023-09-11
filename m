Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29779B585
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbjIKWjy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbjIKONy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE82DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:13:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C51C433C8;
        Mon, 11 Sep 2023 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441629;
        bh=CFixSLalqK3HW0X6AxOUd60nlL57UNmh+1ah0w7VWT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1pVKv+FBP2WArEXfHvOgjYWOY/C1x06sDCMXPmDUn920QEU5nJPmPFul6l5+d76U
         gFHK4ET9czyq9o1ZUQnwqcqS0b6xWB5NLsKgxyEUwWBHaKKkvwcEOEBCd4sPzYFr04
         sWj7T6uyWizFDLm0mdQzL3IuZHeEEB3EheUu7L3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 481/739] scsi: RDMA/srp: Fix residual handling
Date:   Mon, 11 Sep 2023 15:44:40 +0200
Message-ID: <20230911134704.575952302@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 89e637c19b2441aabc8dbf22a8745b932fd6996e ]

Although the code for residual handling in the SRP initiator follows the
SCSI documentation, that documentation has never been correct. Because
scsi_finish_command() starts from the data buffer length and subtracts the
residual, scsi_set_resid() must not be called if a residual overflow
occurs. Hence remove the scsi_set_resid() calls from the SRP initiator if a
residual overflow occurrs.

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Fixes: 9237f04e12cc ("scsi: core: Fix scsi_get/set_resid() interface")
Fixes: e714531a349f ("IB/srp: Fix residual handling")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230724200843.3376570-3-bvanassche@acm.org
Acked-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 0e513a7e5ac80..1574218764e0a 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1979,12 +1979,8 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 
 		if (unlikely(rsp->flags & SRP_RSP_FLAG_DIUNDER))
 			scsi_set_resid(scmnd, be32_to_cpu(rsp->data_in_res_cnt));
-		else if (unlikely(rsp->flags & SRP_RSP_FLAG_DIOVER))
-			scsi_set_resid(scmnd, -be32_to_cpu(rsp->data_in_res_cnt));
 		else if (unlikely(rsp->flags & SRP_RSP_FLAG_DOUNDER))
 			scsi_set_resid(scmnd, be32_to_cpu(rsp->data_out_res_cnt));
-		else if (unlikely(rsp->flags & SRP_RSP_FLAG_DOOVER))
-			scsi_set_resid(scmnd, -be32_to_cpu(rsp->data_out_res_cnt));
 
 		srp_free_req(ch, req, scmnd,
 			     be32_to_cpu(rsp->req_lim_delta));
-- 
2.40.1



