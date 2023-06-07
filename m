Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5737F726F37
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjFGU4c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjFGU4Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610A5E46
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D11DC64847
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E75C433EF;
        Wed,  7 Jun 2023 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171382;
        bh=DXKYenYdSWxtwyD1QRt1YWy78/9bQJeaHNDT2wi5D/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fd6Nlo3eyGCn7tMeG6leW2mbjjCoSYh5pWdLOh+qLB7iGOD4CuKmwAPa4W5KZAC3k
         +KM2nQADNkRycN/pKHVIz5XKgHEhbMj8nwqowWIZCZmcntLa63oKA56SDt/FuzrBUv
         ZeqcgpLwPxTCqKqqH2eP+SWhZA1qz0OepSgJqx+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 5.4 96/99] RDMA/bnxt_re: Remove the qp from list only if the qp destroy succeeds
Date:   Wed,  7 Jun 2023 22:17:28 +0200
Message-ID: <20230607200903.260142409@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
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

From: Selvin Xavier <selvin.xavier@broadcom.com>

commit 097a9d23b7250355b182c5fd47dd4c55b22b1c33 upstream.

Driver crashes when destroy_qp is re-tried because of an error
returned. This is because the qp entry was removed from the qp list during
the first call.

Remove qp from the list only if destroy_qp returns success.

The driver will still trigger a WARN_ON due to the memory leaking, but at
least it isn't corrupting memory too.

Fixes: 8dae419f9ec7 ("RDMA/bnxt_re: Refactor queue pair creation code")
Link: https://lore.kernel.org/r/1598292876-26529-2-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -771,12 +771,6 @@ static int bnxt_re_destroy_gsi_sqp(struc
 	gsi_sqp = rdev->gsi_ctx.gsi_sqp;
 	gsi_sah = rdev->gsi_ctx.gsi_sah;
 
-	/* remove from active qp list */
-	mutex_lock(&rdev->qp_lock);
-	list_del(&gsi_sqp->list);
-	mutex_unlock(&rdev->qp_lock);
-	atomic_dec(&rdev->qp_count);
-
 	dev_dbg(rdev_to_dev(rdev), "Destroy the shadow AH\n");
 	bnxt_qplib_destroy_ah(&rdev->qplib_res,
 			      &gsi_sah->qplib_ah,
@@ -791,6 +785,12 @@ static int bnxt_re_destroy_gsi_sqp(struc
 	}
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
 
+	/* remove from active qp list */
+	mutex_lock(&rdev->qp_lock);
+	list_del(&gsi_sqp->list);
+	mutex_unlock(&rdev->qp_lock);
+	atomic_dec(&rdev->qp_count);
+
 	kfree(rdev->gsi_ctx.sqp_tbl);
 	kfree(gsi_sah);
 	kfree(gsi_sqp);
@@ -811,11 +811,6 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_
 	unsigned int flags;
 	int rc;
 
-	mutex_lock(&rdev->qp_lock);
-	list_del(&qp->list);
-	mutex_unlock(&rdev->qp_lock);
-	atomic_dec(&rdev->qp_count);
-
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
 
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
@@ -838,6 +833,11 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_
 			goto sh_fail;
 	}
 
+	mutex_lock(&rdev->qp_lock);
+	list_del(&qp->list);
+	mutex_unlock(&rdev->qp_lock);
+	atomic_dec(&rdev->qp_count);
+
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
 


