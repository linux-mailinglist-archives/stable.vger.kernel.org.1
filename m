Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0129F7352A0
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFSKgx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjFSKgf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E431E77
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:36:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1640360B58
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D528C433CA;
        Mon, 19 Jun 2023 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170988;
        bh=btHY0qjNkqimHtKI1YMt2kc/+llHmXaN1CoD539hs2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWoi4FK2/o/nUWYgX3/lO/mZvwU7L0H2as/tJXwi3RfFyl2Pv0J/DgymJzSpQVhsc
         W+3Bqsu8qUiE35DVPHTAkHm4ZnF5Yr+R9zLsq/5c+TCEcKbZax5vEU9eOowcjn1e5q
         NceBOq3QkKWxpWgZLM69XJpTUv1QoBXMjpnV1yHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Zhijian <lizhijian@fujitsu.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 108/187] RDMA/rtrs: Fix the last iu->buf leak in err path
Date:   Mon, 19 Jun 2023 12:28:46 +0200
Message-ID: <20230619102202.796427230@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Zhijian <lizhijian@fujitsu.com>

[ Upstream commit 3bf3a7c6985c625f64e73baefdaa36f1c2045a29 ]

The last iu->buf will leak if ib_dma_mapping_error() fails.

Fixes: c0894b3ea69d ("RDMA/rtrs: core: lib functions shared between client and server modules")
Link: https://lore.kernel.org/r/1682384563-2-3-git-send-email-lizhijian@fujitsu.com
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 4bf9d868cc522..3696f367ff515 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -37,8 +37,10 @@ struct rtrs_iu *rtrs_iu_alloc(u32 iu_num, size_t size, gfp_t gfp_mask,
 			goto err;
 
 		iu->dma_addr = ib_dma_map_single(dma_dev, iu->buf, size, dir);
-		if (ib_dma_mapping_error(dma_dev, iu->dma_addr))
+		if (ib_dma_mapping_error(dma_dev, iu->dma_addr)) {
+			kfree(iu->buf);
 			goto err;
+		}
 
 		iu->cqe.done  = done;
 		iu->size      = size;
-- 
2.39.2



