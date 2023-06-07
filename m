Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4418E726F36
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbjFGU4X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjFGU4W (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32F6FC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3459664844
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D98C433D2;
        Wed,  7 Jun 2023 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171379;
        bh=7s73vs/YZ8FRztctnfZ4aEM/BYXTrdu1ejkZVUgfaPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHArfhQgbpn6RiM38ZylopIRRx+g0MteJ+5kiKv2t5Kb0eN7ENvfaYfeVHReCG4d3
         E0AQCbSl350XXblObzGSSyA8dPFkn4D/LB4x8jRDXWry+71E5uZwNWJslpFVhxFkoK
         n3wg0EgFw9Uru9mvdKbM2K4cv33h3m/6BDQYg8+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 95/99] RDMA/bnxt_re: Remove set but not used variable dev_attr
Date:   Wed,  7 Jun 2023 22:17:27 +0200
Message-ID: <20230607200903.229887396@linuxfoundation.org>
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

From: YueHaibing <yuehaibing@huawei.com>

commit a0b404a98e274b5fc0cfb7c108d99127d482e5ff upstream.

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_create_gsi_qp':
drivers/infiniband/hw/bnxt_re/ib_verbs.c:1283:30: warning:
 variable 'dev_attr' set but not used [-Wunused-but-set-variable]

commit 8dae419f9ec7 ("RDMA/bnxt_re: Refactor queue pair creation code")
involved this, but not used, so remove it.

Link: https://lore.kernel.org/r/20200227064542.91205-1-yuehaibing@huawei.com
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1286,14 +1286,12 @@ out:
 static int bnxt_re_create_gsi_qp(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 				 struct ib_qp_init_attr *init_attr)
 {
-	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_qp *qplqp;
 	int rc = 0;
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
 
 	qplqp->rq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_RQ_HDR_SIZE_V2;
 	qplqp->sq_hdr_buf_size = BNXT_QPLIB_MAX_QP1_SQ_HDR_SIZE_V2;


