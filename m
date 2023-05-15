Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40C57039DF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244581AbjEORqa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244693AbjEORqL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:46:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D715521
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:44:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01E7B62E9D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB902C4339B;
        Mon, 15 May 2023 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172660;
        bh=Kh0HAgpPQ2heXkTvKlyZ97RZnQ+syQ00mk60/2k7oJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjERPSFped6eYxmzVxkQDyWGJgqe2kBhZNYW6SLxkcyWncHph+BuUEids4GKLUcF0
         ox+nkSsaLnhPKc/JLbrmibU+yKfVOriT4bkPhsVHLthXoW4GnJv1OToyNC3aRGDJuR
         fkUAa7oBuaFbYGquXllIE7r7Q/15bVv1Win9kyzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zeal Robot <zealci@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 198/381] spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 15 May 2023 18:27:29 +0200
Message-Id: <20230515161745.767762867@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

[ Upstream commit 7d34ff58f35c82207698f43af79817a05e1342e5 ]

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Link: https://lore.kernel.org/r/20220414085343.2541608-1-chi.minghao@zte.com.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 11951c9e3f36 ("spi: imx: Don't skip cleanup in remove's error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 74b3b6ca15efb..66b568de96af6 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1554,9 +1554,8 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_get_sync(spi_imx->dev);
+	ret = pm_runtime_resume_and_get(spi_imx->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(spi_imx->dev);
 		dev_err(spi_imx->dev, "failed to enable clock\n");
 		return ret;
 	}
@@ -1765,9 +1764,8 @@ static int spi_imx_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&spi_imx->bitbang);
 
-	ret = pm_runtime_get_sync(spi_imx->dev);
+	ret = pm_runtime_resume_and_get(spi_imx->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(spi_imx->dev);
 		dev_err(spi_imx->dev, "failed to enable clock\n");
 		return ret;
 	}
-- 
2.39.2



