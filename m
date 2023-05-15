Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4470340C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbjEOQoR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242966AbjEOQoK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4957A49F2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D34E8628C4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96402C433D2;
        Mon, 15 May 2023 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169046;
        bh=xTKCrg0WMvS1Hn7DNYoegB5i5SwlzJRn2QaOuFljvTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdK4cwY+lScxfQP+xBMDxIHIHWH+HZcBqJQZa4Z1ib01uompQWqeOZ+UDgJZ0tGXo
         nWP+OxR5asmAQnvPo0kkZfCcpeSX15bW57xIZOkF8Wwdq0sI9o3NTe2ptjn/f8fGYW
         QMMhoKTcObAgd68Rw33EgtUhJfP8ikdDq/yzbPjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/191] mtd: spi-nor: cadence-quadspi: Dont initialize rx_dma_complete on failure
Date:   Mon, 15 May 2023 18:25:31 +0200
Message-Id: <20230515161710.688805502@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Vignesh Raghavendra <vigneshr@ti.com>

[ Upstream commit 48aae57f0f9f57797772bd462b4d64902b1b4ae1 ]

If driver fails to acquire DMA channel then don't initialize
rx_dma_complete struct as it won't be used.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20200601070444.16923-4-vigneshr@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implementations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index cdebe6853e6c3..bd62ed8710315 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -1173,6 +1173,7 @@ static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 	if (IS_ERR(cqspi->rx_chan)) {
 		dev_err(&cqspi->pdev->dev, "No Rx DMA available\n");
 		cqspi->rx_chan = NULL;
+		return;
 	}
 	init_completion(&cqspi->rx_dma_complete);
 }
-- 
2.39.2



