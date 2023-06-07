Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE87D726E2C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjFGUsf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjFGUsW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9052326A3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EFC4646D0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724DDC433EF;
        Wed,  7 Jun 2023 20:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170887;
        bh=u7cy8HaOMQAPe80l3o85eA8aEHWRS6IKOM4djiaGeRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y0G6IBCbEAVWoOefdcRiCNu0vbdfHK5aGU186WWDlWsvS/aEouMIeMOFQDA/Tm86B
         6IgSVjTj5oo86L0Bnv6160lYb1jrASt1r6JRB43MMRkJrZtGvI5LaapYzoDovQK8/i
         /cITiWEJui74TPkXOrDFo9x8zFDVvegabWuGRQTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Firas Jahjah <firasj@amazon.com>,
        Michael Margolin <mrgolin@amazon.com>,
        Yonatan Nachum <ynachum@amazon.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 003/120] RDMA/efa: Fix unsupported page sizes in device
Date:   Wed,  7 Jun 2023 22:15:19 +0200
Message-ID: <20230607200901.027229705@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
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
index 2ece682c7835b..9cf051818725c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1328,7 +1328,7 @@ static int pbl_continuous_initialize(struct efa_dev *dev,
  */
 static int pbl_indirect_initialize(struct efa_dev *dev, struct pbl_context *pbl)
 {
-	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, PAGE_SIZE);
+	u32 size_in_pages = DIV_ROUND_UP(pbl->pbl_buf_size_in_bytes, EFA_CHUNK_PAYLOAD_SIZE);
 	struct scatterlist *sgl;
 	int sg_dma_cnt, err;
 
-- 
2.39.2



