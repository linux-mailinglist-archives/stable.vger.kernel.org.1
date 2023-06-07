Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B817A726D0D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjFGUij (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjFGUid (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEFE1BF0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7F8D645B0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005FBC433D2;
        Wed,  7 Jun 2023 20:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170271;
        bh=GYqQAJOFnLzXwOUzChV2JbNtYmuiS+DJp8V8hjctYnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTL/wuyeKqZq88aiKZBz0FDiv0hLp6b/Hs7ddUYr1XPHH+RvZseTZi8piVHvPJt2g
         mKd1/C3qcVy8uOCp5Ch2Q1oGd1klXu6z/S131YIFIhCahqC4uGI8h5qDw0IcOYmPcN
         SdalkxHmwMYwZ3q8oQ39QnLG6/ni8tmBp2FOFEjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Firas Jahjah <firasj@amazon.com>,
        Michael Margolin <mrgolin@amazon.com>,
        Yonatan Nachum <ynachum@amazon.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/225] RDMA/efa: Fix unsupported page sizes in device
Date:   Wed,  7 Jun 2023 22:13:16 +0200
Message-ID: <20230607200913.455731891@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yonatan Nachum <ynachum@amazon.com>

[ Upstream commit 866422cdddcdf59d8c68e9472d49ba1be29b5fcf ]

Device uses 4KB size blocks for user pages indirect list while the
driver creates those blocks with the size of PAGE_SIZE of the kernel. On
kernels with PAGE_SIZE different than 4KB (ARM RHEL), this leads to a
failure on register MR with indirect list because of the miss
communication between driver and device.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Link: https://lore.kernel.org/r/20230511115103.13876-1-ynachum@amazon.com
Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 31454643f8c54..f9526a4c75b26 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1397,7 +1397,7 @@ static int pbl_continuous_initialize(struct efa_dev *dev,
  */
 static int pbl_indirect_initialize(struct efa_dev *dev, struct pbl_context *pbl)
 {
-	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, PAGE_SIZE);
+	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, EFA_CHUNK_PAYLOAD_SIZE);
 	struct scatterlist *sgl;
 	int sg_dma_cnt, err;
 
-- 
2.39.2



