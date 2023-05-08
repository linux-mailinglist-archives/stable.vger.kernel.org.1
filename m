Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F016FA56B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjEHKJP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjEHKJO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1D93292F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 805966239A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA17C4339B;
        Mon,  8 May 2023 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540552;
        bh=GpG8hSh5jrqMumWvj/AK/UdBrWxwNmAJiBHpYRTBAQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kw9Fn6/d66uxhCeGN1NfWwR7Ri/+RbkWUGn8SZiAkPc161UdIDrn17MJMzsRFxVcQ
         Rtel0reZMkIV2qNIpyQT9D9/INOo3C3SzMcWrr8zr8taPZQwDXcZd+PpVeHh57HKCV
         YC1BFTHy2iVCoruQtE0MNoVU7VeTQNx2TrYkVN0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 408/611] spi: atmel-quadspi: Dont leak clk enable count in pm resume
Date:   Mon,  8 May 2023 11:44:10 +0200
Message-Id: <20230508094435.516087827@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit c18bbac353ffed50be134b0a2a059a2bd540c503 ]

The pm resume call is supposed to enable two clocks. If the second enable
fails the callback reports failure but doesn't undo the first enable.

So call clk_disable() for the first clock when clk_enable() for the second
one fails.

Fixes: 4a2f83b7f780 ("spi: atmel-quadspi: add runtime pm support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/r/20230317084232.142257-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 976a217e356d5..f480c7ae93fab 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -752,7 +752,11 @@ static int __maybe_unused atmel_qspi_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	return clk_enable(aq->qspick);
+	ret = clk_enable(aq->qspick);
+	if (ret)
+		clk_disable(aq->pclk);
+
+	return ret;
 }
 
 static const struct dev_pm_ops __maybe_unused atmel_qspi_pm_ops = {
-- 
2.39.2



