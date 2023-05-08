Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDD26FA4C9
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjEHKDN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjEHKDK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E2B18916
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6483D61E63
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E89C433EF;
        Mon,  8 May 2023 10:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540186;
        bh=rKxa6za2E3Ax6EuEdZlSGaFfMGzEoKJwAYaUArXmzAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZroncoU3nPj5ngcMXYxL1Z4NIiOxWof44kye/NLt1/B1hzhzW3Un2m4X15g3fdqe
         56fKue0GSFI7IXOcnYMJMEsGhFmSxFjA3lwICsDbtV4PLA32uLRZW+eEItcg+q83Jg
         SEcBmuiDlQYmcbVCa1SsFJrHvef8gxJgdciHzpVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 269/611] wifi: ath5k: Use platform_get_irq() to get the interrupt
Date:   Mon,  8 May 2023 11:41:51 +0200
Message-Id: <20230508094431.132593091@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 95c95251d0547b46d6571e4fbd51b42865c15a4a ]

As of commit a1a2b7125e10 ("of/platform: Drop static setup of IRQ
resource from DT core"), we need to use platform_get_irq() instead of
platform_get_resource() to get our IRQs because
platform_get_resource() simply won't get them anymore.

This was already fixed in several other Atheros WiFi drivers,
apparently in response to Zeal Robot reports. An example of another
fix is commit 9503a1fc123d ("ath9k: Use platform_get_irq() to get the
interrupt"). ath5k seems to have been missed in this effort, though.

Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230201084131.v2.2.Ic4f8542b0588d7eb4bc6e322d4af3d2064e84ff0@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath5k/ahb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/ahb.c b/drivers/net/wireless/ath/ath5k/ahb.c
index 2c9cec8b53d9e..28a1e5eff204e 100644
--- a/drivers/net/wireless/ath/ath5k/ahb.c
+++ b/drivers/net/wireless/ath/ath5k/ahb.c
@@ -113,15 +113,13 @@ static int ath_ahb_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
-		ret = -ENXIO;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no IRQ resource found: %d\n", irq);
+		ret = irq;
 		goto err_iounmap;
 	}
 
-	irq = res->start;
-
 	hw = ieee80211_alloc_hw(sizeof(struct ath5k_hw), &ath5k_hw_ops);
 	if (hw == NULL) {
 		dev_err(&pdev->dev, "no memory for ieee80211_hw\n");
-- 
2.39.2



