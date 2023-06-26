Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84873E7C6
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjFZSTG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjFZSTB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:19:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1110D5
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82B3060F4F
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885BFC433C0;
        Mon, 26 Jun 2023 18:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803521;
        bh=16V4H6Wq+emRL2D9kUckP9PavZ9dpDIi62ehlHajSu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxeYTeImU0ghM8GU05hRHqEEPYTWZxwZA/xUKPnyjulON1TZrxyYdkntqil2244aH
         /QPPNt5IiCDyrSfrD6eKIfF6AzBXd/OMbD4bAoRm3vwqFuf2RSjUu6rfijNJ7HeCeg
         6VfnqMPA74DmeyI6QioYz0DcIrRo+sWn6AjCp2fE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 088/199] spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan()
Date:   Mon, 26 Jun 2023 20:09:54 +0200
Message-ID: <20230626180809.453424293@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit 9d7054fb3ac2e8d252aae1268f20623f244e644f ]

Now spi_geni_grab_gpi_chan() errors are correctly reported, the
-EPROBE_DEFER error should be returned from probe in case the
GPI dma driver is built as module and/or not probed yet.

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Fixes: 6532582c353f ("spi: spi-geni-qcom: fix error handling in spi_geni_grab_gpi_chan()")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-v2-1-670c3d9e8c9c@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index b106faf21a723..baf477383682d 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -646,6 +646,8 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			geni_se_select_mode(se, GENI_GPI_DMA);
 			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
 			break;
+		} else if (ret == -EPROBE_DEFER) {
+			goto out_pm;
 		}
 		/*
 		 * in case of failure to get gpi dma channel, we can still do the
-- 
2.39.2



