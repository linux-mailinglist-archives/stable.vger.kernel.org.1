Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3F7ED411
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjKOU4j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbjKOU4h (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:56:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C2EB7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:56:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C81C4E77B;
        Wed, 15 Nov 2023 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081793;
        bh=jjHloCXp1N/YaCkfvBGc+nOXJHMFXQMO8LWjkRlOCTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2WPQoP7hThZmUtzU6aWCaAHnbnKtP8zNTChaEiFo6jkq1C3hlPRMifWH2ccqG2ZG
         N9NXIyf3UfrukuMLUYxfpudIpvZh3qvGl6zLTpWVYrtIJRu+tWeG19XtmEvKeux9x4
         NzwdNhGAtpjUu9MCr9bdqR+sExKCiPCQqdWr3ORA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 128/191] dmaengine: ti: edma: handle irq_of_parse_and_map() errors
Date:   Wed, 15 Nov 2023 15:46:43 -0500
Message-ID: <20231115204652.208856375@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 14f6d317913f634920a640e9047aa2e66f5bdcb7 ]

Zero is not a valid IRQ for in-kernel code and the irq_of_parse_and_map()
function returns zero on error.  So this check for valid IRQs should only
accept values > 0.

Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/f15cb6a7-8449-4f79-98b6-34072f04edbc@moroto.mountain
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ti/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 35d81bd857f11..a1adc8d91fd8d 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2459,7 +2459,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 0);
 
-	if (irq >= 0) {
+	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
@@ -2475,7 +2475,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 2);
 
-	if (irq >= 0) {
+	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
-- 
2.42.0



