Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5680B7E2328
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjKFNJU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjKFNJT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:09:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B4691
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:09:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1C9C433C7;
        Mon,  6 Nov 2023 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276157;
        bh=nnr8fvpKBxgQ3UN65rmjivZEC1giELQlNkHGYW3keKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ou7slfrRJDz0ytRVcfDuBX0pcKjtsafk3k0SwxWuVfgyctNA7s8ERyywGtWyduqW/
         FDcSg7kn+5Z003FFv97rDY9ntv+GSGAXyc3/j3HO8JSuRCyaijo2T5+VU89PZgLiBv
         19aVhfFpvKA4emKDisQfmgsgqgOLehKV3EhUtM30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 01/61] mmc: sdio: Dont re-initialize powered-on removable SDIO cards at resume
Date:   Mon,  6 Nov 2023 14:02:57 +0100
Message-ID: <20231106130259.620572008@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 6ebc581c3f9e6fd11a1c9da492a5e05bbe96885a ]

It looks like the original idea behind always doing a re-initialization of
a removable SDIO card during system resume in mmc_sdio_resume(), is to try
to play safe to detect whether the card has been removed.

However, this seems like a really a bad idea as it will most likely screw
things up, especially when the card is expected to remain powered on during
system suspend by the SDIO func driver.

Let's fix this, simply by trusting that the detect work checks if the card
is alive and inserted, which is being scheduled at the PM_POST_SUSPEND
notification anyway.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Stable-dep-of: 32a9cdb8869d ("mmc: core: sdio: hold retuning if sdio in 1-bit mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/sdio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5f1ee88aa7615..5f6865717c9b4 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -963,7 +963,11 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
 
-	/* Restore power if needed */
+	/*
+	 * Restore power and reinitialize the card when needed. Note that a
+	 * removable card is checked from a detect work later on in the resume
+	 * process.
+	 */
 	if (!mmc_card_keep_power(host)) {
 		mmc_power_up(host, host->card->ocr);
 		/*
@@ -977,12 +981,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 			pm_runtime_set_active(&host->card->dev);
 			pm_runtime_enable(&host->card->dev);
 		}
-	}
-
-	/* No need to reinitialize powered-resumed nonremovable cards */
-	if (mmc_card_is_removable(host) || !mmc_card_keep_power(host)) {
-		err = mmc_sdio_reinit_card(host, mmc_card_keep_power(host));
-	} else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
+		err = mmc_sdio_reinit_card(host, 0);
+	} else if (mmc_card_wake_sdio_irq(host)) {
 		/* We may have switched to 1-bit mode during suspend */
 		err = sdio_enable_4bit_bus(host->card);
 	}
-- 
2.42.0



