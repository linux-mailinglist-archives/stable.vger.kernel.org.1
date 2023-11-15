Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B984F7ED484
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344835AbjKOU6S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbjKOU5j (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688D173B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8B3C16ABD;
        Wed, 15 Nov 2023 20:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081314;
        bh=Vb/xqebh2R6pWP3NbSXJS1XDDWyOYmqwSC/r1XO5Bts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qr63LJtYdEjJXwNHdQ6UwdqP1qZ0fbbHERAyPVGYnxXxltM8IgWRnCjQ9vyC3BRzQ
         72BeHyfXIyC++LDlnP7ItiA7XOZqZyHeWuIYE6P5tgGk0Kjs3fpH66zIWnaCFX9FOB
         3/Xs7uNGO+O9wB+u1F3woHxbY1aRN+f3Y2b+Ce6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhang Shurong <zhang_shurong@foxmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 052/244] spi: tegra: Fix missing IRQ check in tegra_slink_probe()
Date:   Wed, 15 Nov 2023 15:34:04 -0500
Message-ID: <20231115203551.487933944@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index cf61bf302a059..c611fedda7de9 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1087,6 +1087,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 
 	spi_irq = platform_get_irq(pdev, 0);
+	if (spi_irq < 0)
+		return spi_irq;
 	tspi->irq = spi_irq;
 	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
 				   tegra_slink_isr_thread, IRQF_ONESHOT,
-- 
2.42.0



