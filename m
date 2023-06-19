Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498A273549B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjFSK5k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjFSK5X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5053A86
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95AD460B7C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F7EC433C8;
        Mon, 19 Jun 2023 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172123;
        bh=bBlsloy4R55f2DCmtZ00OXtKPmo1SF/fgtg0noUw1Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S98xcrFeGBltxCf2t/ampGUHvH8QzIi0tjN3mGhDhWKsFBUr5eYyXFg6Yjjjyb/kb
         YSvF/RzrfTKcdtdlRQD97onrdWGoSGcGAHmgvImzrXe3cROj3il81PvrVAblXe3KQ8
         TNLYYRCWY+oPOWIrQtIzjR+Pko+J83HDGI1h5qu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Zhijian <lizhijian@fujitsu.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 45/89] RDMA/rtrs: Fix the last iu->buf leak in err path
Date:   Mon, 19 Jun 2023 12:30:33 +0200
Message-ID: <20230619102140.337140254@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
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
index 4629bb758126a..76b993e8d672f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -37,8 +37,10 @@ struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
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



