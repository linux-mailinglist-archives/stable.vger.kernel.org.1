Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E46A755246
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGPUFz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGPUFy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:05:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D969D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 819B960EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E92C433C7;
        Sun, 16 Jul 2023 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537953;
        bh=DXBFB8b7I1gNu5U6JT125siuhuEcka/+R66P857G60I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zB7rhIpKZyw+dFTDZ68sd1Q5BncfQbOLj/27KPC7EGPGit0PWPD+f0h/UFfe/wgR8
         46sfulhkNttk6zZ1MloEifz8vgZxJNynqL4XTM0EfABwdvdF7zxDatuh9i3WJ6V9kv
         32LeJMfLoiav+7m0wJZMQGsHjr52K1B9sOvnKIQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 272/800] RDMA/bnxt_re: Fix to remove an unnecessary log
Date:   Sun, 16 Jul 2023 21:42:05 +0200
Message-ID: <20230716194955.411734130@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 43774bc156614346fe5dacabc8e8c229167f2536 ]

During destroy_qp, driver sets the qp handle in the existing CQEs
belonging to the QP being destroyed to NULL. As a result, a poll_cq after
destroy_qp can report unnecessary messages.  Remove this noise from system
logs.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Link: https://lore.kernel.org/r/1684478897-12247-6-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 607ed69386b45..55f092c2c8a88 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2799,11 +2799,8 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
 
 	qp = (struct bnxt_qplib_qp *)((unsigned long)
 				      le64_to_cpu(hwcqe->qp_handle));
-	if (!qp) {
-		dev_err(&cq->hwq.pdev->dev,
-			"FP: CQ Process terminal qp is NULL\n");
+	if (!qp)
 		return -EINVAL;
-	}
 
 	/* Must block new posting of SQ and RQ */
 	qp->state = CMDQ_MODIFY_QP_NEW_STATE_ERR;
-- 
2.39.2



