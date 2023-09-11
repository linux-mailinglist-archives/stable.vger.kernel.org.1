Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE1779BDB3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbjIKUxr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbjIKN5f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:57:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB69CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:57:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2584C433C7;
        Mon, 11 Sep 2023 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440650;
        bh=iswAMcoCAAGBJXZjq2asG4Lp6Q5qFhlNwPnSyXa5psU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpAblfExeJGkaUlUiB1rhZllYK3ho4rCISgQ1jXYTPY8Dk6sY0nwDx4owUobsp029
         UQorFH+Xwh01Fp8OfL+7XqvZy+7lWARq/rmH8IA+ziQobg3IN0TKcmkrZbNVaAL9qV
         N18M8+y2Y+bLDjWMQXiaGRf0Fe7VqLcEmvBiH5Qc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Zetao <lizetao1@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 109/739] spi: mpc5xxx-psc: Fix unsigned expression compared with zero
Date:   Mon, 11 Sep 2023 15:38:28 +0200
Message-ID: <20230911134654.145046336@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Zetao <lizetao1@huawei.com>

[ Upstream commit de5e92cb5cefd2968b96075995a36e28298edf71 ]

There is two warnings reported by coccinelle:

./drivers/spi/spi-mpc512x-psc.c:493:5-13: WARNING:
	Unsigned expression compared with zero: mps -> irq     <     0
./drivers/spi/spi-mpc52xx-psc.c:332:5-13: WARNING:
	Unsigned expression compared with zero: mps -> irq     <     0

The commit "208ee586f862"
("spi: mpc5xxx-psc: Return immediately if IRQ resource is unavailable")
was to check whether the IRQ resource is unavailable. When the IRQ
resource is unavailable, an error code is returned, however, the type
of "mps->irq" is "unsigned int", causing the error code to flip. Modify
the type of "mps->irq" to solve this problem.

Fixes: 208ee586f862 ("spi: mpc5xxx-psc: Return immediately if IRQ resource is unavailable")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
Link: https://lore.kernel.org/r/20230803134805.1037251-1-lizetao1@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mpc512x-psc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 99aeef28a4774..5cecca1bef026 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -53,7 +53,7 @@ struct mpc512x_psc_spi {
 	int type;
 	void __iomem *psc;
 	struct mpc512x_psc_fifo __iomem *fifo;
-	unsigned int irq;
+	int irq;
 	u8 bits_per_word;
 	u32 mclk_rate;
 
-- 
2.40.1



