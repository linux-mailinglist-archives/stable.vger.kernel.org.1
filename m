Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8AB7ECE27
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjKOTlH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjKOTk4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C415F1B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:40:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9F9C433C9;
        Wed, 15 Nov 2023 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077253;
        bh=pUz03s7MmfuRFkf/PonQVu8gTGmwQHok7C32vGfDe0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJVGL4JvZ0YGDceYgaG4H0ZA1bG53xMN5MN4a26Ydytb8pvC+YKEKWUXN31dVzY8O
         3POEDX6kkZrIF9wprM24wViGEieCuh6+uXlkw0xSES0yh3gkQ9uxSJmmwiEgSq40a5
         mOPTFFsrvdpd7xUTMTiTnwJhLnDFYWtizsWqYeOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 159/603] spi: tegra: Fix missing IRQ check in tegra_slink_probe()
Date:   Wed, 15 Nov 2023 14:11:44 -0500
Message-ID: <20231115191624.196463004@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit eb9913b511f10968a02cfa5329a896855dd152a3 ]

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.

Fix this by stop calling request_irq() with invalid IRQ #s.

Fixes: dc4dc3605639 ("spi: tegra: add spi driver for SLINK controller")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Reviewed-by: Helen Koike <helen.koike@collabora.com>
Link: https://lore.kernel.org/r/tencent_73FCC06A3D1C14EE5175253C6FB46A07B709@qq.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra20-slink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 4d6db6182c5ed..f5cd365c913a8 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1086,6 +1086,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 
 	spi_irq = platform_get_irq(pdev, 0);
+	if (spi_irq < 0)
+		return spi_irq;
 	tspi->irq = spi_irq;
 	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
 				   tegra_slink_isr_thread, IRQF_ONESHOT,
-- 
2.42.0



