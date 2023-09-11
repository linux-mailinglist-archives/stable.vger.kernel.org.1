Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8129D79ADDD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbjIKVKt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbjIKO2M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:28:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C705F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:28:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7761FC433C7;
        Mon, 11 Sep 2023 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442487;
        bh=pByJnEpJkuOFskfOzfMAM/XaXtSQA3RDP5hidfrbqP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8r/ZK+lHzz1mXUABHTVMG60LvYTflOw7otkiWE7NZgJ3IocbqHbc8pFV0whE5FxG
         BbDasEFqCC9O3cb+/LUEiYXsg08yUrvmz7DvQoNHgR1AAE8j0MOMxh3e05DWaO0Upv
         yuXlberad9o4xD6qmZz/Ij+jGXVhKIZoOFcHTiQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Minjie Du <duminjie@vivo.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 042/737] ata: pata_arasan_cf: Use dev_err_probe() instead dev_err() in data_xfer()
Date:   Mon, 11 Sep 2023 15:38:21 +0200
Message-ID: <20230911134651.611815709@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minjie Du <duminjie@vivo.com>

[ Upstream commit 4139f992c49356391fb086c0c8ce51f66c26d623 ]

It is possible for dma_request_chan() to return EPROBE_DEFER, which
means acdev->host->dev is not ready yet. At this point dev_err() will
have no output. Use dev_err_probe() instead.

Signed-off-by: Minjie Du <duminjie@vivo.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/pata_arasan_cf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 6ab294322e792..314eaa1679540 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -529,7 +529,8 @@ static void data_xfer(struct work_struct *work)
 	/* dma_request_channel may sleep, so calling from process context */
 	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
 	if (IS_ERR(acdev->dma_chan)) {
-		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
+		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
+			      "Unable to get dma_chan\n");
 		acdev->dma_chan = NULL;
 		goto chan_request_fail;
 	}
-- 
2.40.1



