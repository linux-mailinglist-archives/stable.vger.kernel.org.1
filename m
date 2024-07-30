Return-Path: <stable+bounces-64615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77804941EAA
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2288C1F210DE
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2968166315;
	Tue, 30 Jul 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rl1c0ZhD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8951A76A5;
	Tue, 30 Jul 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360700; cv=none; b=nU8nX7tvkhb2lOSXc3xYOnscUY06VTIDmBtaQtRToUir2H88N8efF1EQI7IB4KgNe8IzooJTRtee8EEzASB3LBT8dtZoehWmOiOrMYuxv1Ix9glTScArXYgzah4RdYKAnLTiRwu8W+8vw8Kl7XvJ38qSUkL3E6b66SzQrTP51x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360700; c=relaxed/simple;
	bh=zb8ZWoFCSQA3l8yeb68h5dVAhiF5CueWw6Rtw+JdVdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1wx57lYX1gnBQ1TXki4jSWC3yz+RGKzgAKNpaRKUBKHVTCFH+Q/ak4+XskcKBBxZMppt4HGo5keYKlGxot82M1W2Ce2l2yxdBfZBB0x6G0ahSVm1feTiSvDHvvElQPfQ5CAqzVMpgIcS663f9x0dhBF6O4s/EKyStBNggCQJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rl1c0ZhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108E2C4AF0E;
	Tue, 30 Jul 2024 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360700;
	bh=zb8ZWoFCSQA3l8yeb68h5dVAhiF5CueWw6Rtw+JdVdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rl1c0ZhDzUKUG8VMVEb/xK0e3L7nO0vcR4CF0wY9e+qaTVaWfaq2FJO3GqWXkvcbp
	 d4AIlLO2sUfUJolbjWrqRXv7DIwmEM0a16EaBA/l5jmz5YzhTG1cRlQS7NtDet8YVg
	 cjlk9s6XKFBp9LDNPzIqwnHG1V7MfDG5x9ntjyFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve Wilkins <steve.wilkins@raymarine.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 780/809] spi: microchip-core: defer asserting chip select until just before write to TX FIFO
Date: Tue, 30 Jul 2024 17:50:56 +0200
Message-ID: <20240730151755.775502291@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Wilkins <steve.wilkins@raymarine.com>

[ Upstream commit 22fd98c107c792e35db7abe45298bc3a29bf4723 ]

Setting up many of the registers for a new SPI transfer requires the
SPI controller to be disabled after set_cs() has been called to assert
the chip select line. However, disabling the controller results in the
SCLK and MOSI output pins being tristate, which can cause clock
transitions to be seen by a slave device whilst SS is active. To fix
this, the CS is only set to inactive inline, whilst setting it active
is deferred until all registers are set up and the any controller
disables have been completed.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Steve Wilkins <steve.wilkins@raymarine.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20240715-sanitizer-recant-dd96b7a97048@wendy
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-microchip-core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 003a2bc3cfd1b..8043a18e7c3bd 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -103,6 +103,7 @@ struct mchp_corespi {
 	u8 *rx_buf;
 	u32 clk_gen; /* divider for spi output clock generated by the controller */
 	u32 clk_mode;
+	u32 pending_slave_select;
 	int irq;
 	int tx_len;
 	int rx_len;
@@ -249,8 +250,18 @@ static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
 	reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
 	reg &= ~BIT(spi_get_chipselect(spi, 0));
 	reg |= !disable << spi_get_chipselect(spi, 0);
+	corespi->pending_slave_select = reg;
 
-	mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
+	/*
+	 * Only deassert chip select immediately. Writing to some registers
+	 * requires the controller to be disabled, which results in the
+	 * output pins being tristated and can cause the SCLK and MOSI lines
+	 * to transition. Therefore asserting the chip select is deferred
+	 * until just before writing to the TX FIFO, to ensure the device
+	 * doesn't see any spurious clock transitions whilst CS is enabled.
+	 */
+	if (((spi->mode & SPI_CS_HIGH) == 0) == disable)
+		mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
 }
 
 static int mchp_corespi_setup(struct spi_device *spi)
@@ -266,6 +277,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
 	if (spi->mode & SPI_CS_HIGH) {
 		reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
 		reg |= BIT(spi_get_chipselect(spi, 0));
+		corespi->pending_slave_select = reg;
 		mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
 	}
 	return 0;
@@ -307,7 +319,8 @@ static void mchp_corespi_init(struct spi_controller *host, struct mchp_corespi *
 	 * select is relinquished to the hardware. SSELOUT is enabled too so we
 	 * can deal with active high targets.
 	 */
-	mchp_corespi_write(spi, REG_SLAVE_SELECT, SSELOUT | SSEL_DIRECT);
+	spi->pending_slave_select = SSELOUT | SSEL_DIRECT;
+	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
 
 	control = mchp_corespi_read(spi, REG_CONTROL);
 
@@ -476,6 +489,8 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 	mchp_corespi_set_xfer_size(spi, (spi->tx_len > FIFO_DEPTH)
 				   ? FIFO_DEPTH : spi->tx_len);
 
+	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
+
 	while (spi->tx_len)
 		mchp_corespi_write_fifo(spi);
 
-- 
2.43.0




