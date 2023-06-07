Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F946726E31
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjFGUs5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjFGUsh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:48:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FD7272B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF44A6436B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56D5C4339C;
        Wed,  7 Jun 2023 20:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170898;
        bh=lFnLa+lFea0xfypeewzUtt1fvRUSOmjE8qVH/6loqJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKYwyfO64GbgZMY4wD0ewjQB82yWkKpjj+BeFDwnNpeBEUXGPoaarg3niGVjzhYNM
         Da9mVHBRtyZtGihwRpaMu9lZ1m/tEwKfQKRMiJN6n0pa9xHLvq6ILRWaB2QmU25j94
         PWwO6lrNOhHNDbFr1Zq3ZpF0Mr9jpTFUg3gqgzag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 007/120] dmaengine: at_xdmac: fix potential Oops in at_xdmac_prep_interleaved()
Date:   Wed,  7 Jun 2023 22:15:23 +0200
Message-ID: <20230607200901.151144050@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 4d43acb145c363626d76f49febb4240c488cd1cf ]

There are two place if the at_xdmac_interleaved_queue_desc() fails which
could lead to a NULL dereference where "first" is NULL and we call
list_add_tail(&first->desc_node, ...).  In the first caller, the return
is not checked so add a check for that.  In the next caller, the return
is checked but if it fails on the first iteration through the loop then
it will lead to a NULL pointer dereference.

Fixes: 4e5385784e69 ("dmaengine: at_xdmac: handle numf > 1")
Fixes: 62b5cb757f1d ("dmaengine: at_xdmac: fix memory leak in interleaved mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/r/21282b66-9860-410a-83df-39c17fcf2f1b@kili.mountain
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 96559c5df944d..861be862a775a 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -970,6 +970,8 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							NULL,
 							src_addr, dst_addr,
 							xt, xt->sgl);
+		if (!first)
+			return NULL;
 
 		/* Length of the block is (BLEN+1) microblocks. */
 		for (i = 0; i < xt->numf - 1; i++)
@@ -1000,8 +1002,9 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							       src_addr, dst_addr,
 							       xt, chunk);
 			if (!desc) {
-				list_splice_tail_init(&first->descs_list,
-						      &atchan->free_descs_list);
+				if (first)
+					list_splice_tail_init(&first->descs_list,
+							      &atchan->free_descs_list);
 				return NULL;
 			}
 
-- 
2.39.2



