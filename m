Return-Path: <stable+bounces-177934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 667CDB468A9
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 05:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451831BC7132
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2526B24634F;
	Sat,  6 Sep 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnTnmvs1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF0244691
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757129833; cv=none; b=j6SQtpkYtNPGdeksXIM9A5LW8Pfxk8/gplcGt4ehE/jpSMueULzePzl/qkkVOfPIUpIZ6iRk5VjIfruVElGufSIai4UpC0hRKFMYyqLqM49C9lgoVlOJS5w6CkkW0xiRDUKgF8ECgAOitsKCtr2n00bOzLObZji79uwQorgryEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757129833; c=relaxed/simple;
	bh=+CwmTZ0QsjTNnWyegLbP7kcDF/DV7wTNoEbXdgwWAf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwX9qd3hipxCH4y2FHljN+S4xQ8MXvr3MC4JF5ONQumY+8rPwKgU+4/JM5c226YkEqgV2VpI9NVC6rMCIFLYc3I/syZxRkKk1SbLLGjnEhbqswcbrcJmUQOwyjcBlK+zUHWa8JcEkuLrBSA71ewA///j52YRnZl5107WaObioGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnTnmvs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150AAC4CEF1;
	Sat,  6 Sep 2025 03:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757129832;
	bh=+CwmTZ0QsjTNnWyegLbP7kcDF/DV7wTNoEbXdgwWAf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnTnmvs1HZX9F/eWbumNg9hmtDYueqNMz9sYa/cnUNhPUFiyDbaxSnk6nHBI5bQe/
	 me/ugSS0vL96tfI8PYnHR+8iWgCMqiXY+xqPR5yK9cAmkAYVZ+5u+8qhnoyrF/SFG1
	 4iHNsTbigsPm1VjDoBW3yGbiQarHpB/mvjNCtCS87GQErpyRNDNR9Lrl+CBNwRmbk0
	 AEqXflqQWxOWxoyJsJHeWGVdg/1cku4CYw+NBigFEmLjFhnMhpcb0fTkp1/PH09Ju9
	 AQa0n7S6GZfHw0SKdZZnUXxZX1SMgxsHvyRX/AOxxvCMvQxxiJmb6C1Fjax/TFnr91
	 zWlvDPEaGTcrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Danilenko <al.b.danilenko@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] spi: tegra114: Remove unnecessary NULL-pointer checks
Date: Fri,  5 Sep 2025 23:37:09 -0400
Message-ID: <20250906033710.3692213-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025050535-slider-herbicide-e70d@gregkh>
References: <2025050535-slider-herbicide-e70d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Danilenko <al.b.danilenko@gmail.com>

[ Upstream commit 373c36bf7914e3198ac2654dede499f340c52950 ]

cs_setup, cs_hold and cs_inactive points to fields of spi_device struct,
so there is no sense in checking them for NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 04e6bb0d6bb1 ("spi: modify set_cs_timing parameter")
Signed-off-by: Alexander Danilenko <al.b.danilenko@gmail.com>
Link: https://lore.kernel.org/r/20230815092058.4083-1-al.b.danilenko@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 4426e6b4ecf6 ("spi: tegra114: Don't fail set_cs_timing when delays are zero")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra114.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index d9be80e3e1bcb..6b56108308fc5 100644
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
2.50.1


