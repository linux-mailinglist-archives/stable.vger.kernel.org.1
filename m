Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4273EA38
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjFZSoo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjFZSok (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F2F10C9
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA75760F51
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC0BC433C8;
        Mon, 26 Jun 2023 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805075;
        bh=2RZtmDk2SyXASr82iwKKz2hQF1xgDQxd3Mn3ekykuWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWfA1ciRsiMM0Iao4c/ZVxI+8ggcwq3rhIy5qeV1YyvBqyW0DgRdul7I4pV/N8oJ5
         PKlPwirzHtU4MNXsrNS+QgaWTeASpqU/lOoK29ttWN5/AoUtLnP8HMSVhmj7zMcY59
         CaKBBkSbrJLFEnBwicHq1CZR0PS5QNuEUAecE5yw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 42/81] mmc: mtk-sd: fix deferred probing
Date:   Mon, 26 Jun 2023 20:12:24 +0200
Message-ID: <20230626180746.188117585@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
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

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit 0c4dc0f054891a2cbde0426b0c0fdf232d89f47f ]

The driver overrides the error codes returned by platform_get_irq() to
-EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
permanently instead of the deferred probing. Switch to propagating the
error codes upstream.

Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20230617203622.6812-4-s.shtylyov@omp.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index d71c113f428f6..2c9ea5ed0b2fc 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2443,7 +2443,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		ret = -EINVAL;
+		ret = host->irq;
 		goto host_free;
 	}
 
-- 
2.39.2



