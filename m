Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8059E79B0DB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245479AbjIKVK7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbjIKOhd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:37:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB830F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:37:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F77CC433C8;
        Mon, 11 Sep 2023 14:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443048;
        bh=giysoLaF5LxqrR/pFKBXSdqNwbBm/CQeeYYpCZSOV/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpbnEwC4zoYU7q47YTqrdGnZOq8kmLtxQFJIr+MKEUb0TXThOcddQ3CsIXXCm3Udr
         bXf+POA9tRoQK9c6cBLvhOcPV09ZnjtdWpgMQu+g7HL1Xi2+I+WFs41s+x/kCFj5nq
         lCPFk3Ch91d46zyYlfJXjrR6Fi8WAddXoi8epBD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Danilenko <al.b.danilenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 210/737] spi: tegra114: Remove unnecessary NULL-pointer checks
Date:   Mon, 11 Sep 2023 15:41:09 +0200
Message-ID: <20230911134656.459110109@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Danilenko <al.b.danilenko@gmail.com>

[ Upstream commit 373c36bf7914e3198ac2654dede499f340c52950 ]

cs_setup, cs_hold and cs_inactive points to fields of spi_device struct,
so there is no sense in checking them for NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 04e6bb0d6bb1 ("spi: modify set_cs_timing parameter")
Signed-off-by: Alexander Danilenko <al.b.danilenko@gmail.com>
Link: https://lore.kernel.org/r/20230815092058.4083-1-al.b.danilenko@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra114.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 488df681eaefc..2226d77a5d20a 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -723,27 +723,23 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 	struct spi_delay *setup = &spi->cs_setup;
 	struct spi_delay *hold = &spi->cs_hold;
 	struct spi_delay *inactive = &spi->cs_inactive;
-	u8 setup_dly, hold_dly, inactive_dly;
+	u8 setup_dly, hold_dly;
 	u32 setup_hold;
 	u32 spi_cs_timing;
 	u32 inactive_cycles;
 	u8 cs_state;
 
-	if ((setup && setup->unit != SPI_DELAY_UNIT_SCK) ||
-	    (hold && hold->unit != SPI_DELAY_UNIT_SCK) ||
-	    (inactive && inactive->unit != SPI_DELAY_UNIT_SCK)) {
+	if (setup->unit != SPI_DELAY_UNIT_SCK ||
+	    hold->unit != SPI_DELAY_UNIT_SCK ||
+	    inactive->unit != SPI_DELAY_UNIT_SCK) {
 		dev_err(&spi->dev,
 			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
 			SPI_DELAY_UNIT_SCK);
 		return -EINVAL;
 	}
 
-	setup_dly = setup ? setup->value : 0;
-	hold_dly = hold ? hold->value : 0;
-	inactive_dly = inactive ? inactive->value : 0;
-
-	setup_dly = min_t(u8, setup_dly, MAX_SETUP_HOLD_CYCLES);
-	hold_dly = min_t(u8, hold_dly, MAX_SETUP_HOLD_CYCLES);
+	setup_dly = min_t(u8, setup->value, MAX_SETUP_HOLD_CYCLES);
+	hold_dly = min_t(u8, hold->value, MAX_SETUP_HOLD_CYCLES);
 	if (setup_dly && hold_dly) {
 		setup_hold = SPI_SETUP_HOLD(setup_dly - 1, hold_dly - 1);
 		spi_cs_timing = SPI_CS_SETUP_HOLD(tspi->spi_cs_timing1,
@@ -755,7 +751,7 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 		}
 	}
 
-	inactive_cycles = min_t(u8, inactive_dly, MAX_INACTIVE_CYCLES);
+	inactive_cycles = min_t(u8, inactive->value, MAX_INACTIVE_CYCLES);
 	if (inactive_cycles)
 		inactive_cycles--;
 	cs_state = inactive_cycles ? 0 : 1;
-- 
2.40.1



