Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537346FA737
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjEHK2h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjEHK2Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C23D860
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C41461D6D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41939C433D2;
        Mon,  8 May 2023 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541680;
        bh=E/mjO3w316du/4NCN5FEqQc8cNavz00WxbU33FV8TRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkvJIOfBHHcp+N7tsNkQ3a29WJdjxZ+rGvQ3GKjjrsnOLOW1Km1bEyrz8LHFm2wxO
         F3s4nrzdg8hsb8S6o96yfHl12r2LR60J7xX4SataLygmbZQ8XBAngOQW0rUIH+xeUz
         tOzQQb2ujgzzsg50zuZWZcLniPEqWylFsO4UuLe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Georgii Kruglov <georgy.kruglov@yandex.ru>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 192/663] mmc: sdhci-of-esdhc: fix quirk to ignore command inhibit for data
Date:   Mon,  8 May 2023 11:40:18 +0200
Message-Id: <20230508094434.638955553@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Georgii Kruglov <georgy.kruglov@yandex.ru>

[ Upstream commit 0dd8316037a2a6d85b2be208bef9991de7b42170 ]

If spec_reg is equal to 'SDHCI_PRESENT_STATE', esdhc_readl_fixup()
fixes up register value and returns it immediately. As a result, the
further block
(spec_reg == SDHCI_PRESENT_STATE)
    &&(esdhc->quirk_ignore_data_inhibit == true),
is never executed.

The patch merges the second block into the first one.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1f1929f3f2fa ("mmc: sdhci-of-esdhc: add quirk to ignore command inhibit for data")
Signed-off-by: Georgii Kruglov <georgy.kruglov@yandex.ru>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20230321203715.3975-1-georgy.kruglov@yandex.ru
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4712adac7f7c0..48ca1cf15b199 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -133,6 +133,7 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 			return ret;
 		}
 	}
+
 	/*
 	 * The DAT[3:0] line signal levels and the CMD line signal level are
 	 * not compatible with standard SDHC register. The line signal levels
@@ -144,6 +145,16 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 		ret = value & 0x000fffff;
 		ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
 		ret |= (value << 1) & SDHCI_CMD_LVL;
+
+		/*
+		 * Some controllers have unreliable Data Line Active
+		 * bit for commands with busy signal. This affects
+		 * Command Inhibit (data) bit. Just ignore it since
+		 * MMC core driver has already polled card status
+		 * with CMD13 after any command with busy siganl.
+		 */
+		if (esdhc->quirk_ignore_data_inhibit)
+			ret &= ~SDHCI_DATA_INHIBIT;
 		return ret;
 	}
 
@@ -158,19 +169,6 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 		return ret;
 	}
 
-	/*
-	 * Some controllers have unreliable Data Line Active
-	 * bit for commands with busy signal. This affects
-	 * Command Inhibit (data) bit. Just ignore it since
-	 * MMC core driver has already polled card status
-	 * with CMD13 after any command with busy siganl.
-	 */
-	if ((spec_reg == SDHCI_PRESENT_STATE) &&
-	(esdhc->quirk_ignore_data_inhibit == true)) {
-		ret = value & ~SDHCI_DATA_INHIBIT;
-		return ret;
-	}
-
 	ret = value;
 	return ret;
 }
-- 
2.39.2



