Return-Path: <stable+bounces-31891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAD2889957
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 11:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CB41F33189
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD028DFAA;
	Mon, 25 Mar 2024 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYbFzwWg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB36179654;
	Sun, 24 Mar 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323610; cv=none; b=XNa/pwLYG0obvW+gBAEUXshKbHJvHLJTht+zSX9lspxhwbcvjj+GRkBf7QgD2Ya7aXRQhPIVuh4nsXpvjifQPyp48lTp6WmjhiuKC3Ul5Dc7Vp5+vyDkcDPdRAxxeYn8H4l4TTXUO2++1HfKu2h+YkJYynjKPP7d6tojK8zUP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323610; c=relaxed/simple;
	bh=o6El1tKnt4Ehg7Yqmasp327IhVWwumJhRElCNUA259s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gipFdpuh4vTSx1gtqgYjDKLHoBX2dXsF9Ex0IUGCLvm4U84TPFPzIJSqhz4rvFO0+CsTNpoa4Z+x3WQ9FCHrW35uY3c+8r1uaKizqTHNS5LaAQCrmUTvN3NCTUOYvvSwOtj87nPx4CLOFQ4ZB53oCgnj/7s4go4SZ+XWylAHikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYbFzwWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCA6C43390;
	Sun, 24 Mar 2024 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323608;
	bh=o6El1tKnt4Ehg7Yqmasp327IhVWwumJhRElCNUA259s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYbFzwWgNlq0sUGgqTHR013/SZDWDlXXAuEpOvSshppJ/QUT3x6Vf9QJoq4BB47r2
	 kA4Dp3Pts0/VF16XM2xvWUHKUJmqOaZQ+K6XTiQoQpGhOXuYsIf+py8X4uFdfLEjfs
	 Y+IuLUxeOxLIQ6zPn17zU+rvwRjC6+2OJEiWfuZuvB73V+/VFLLCNksAgRLlZkXdsh
	 fAkFEUtWEH8wfPDb+BLS+Iuf2YCTaF/uUqUTzUn+/lcn4GkkhVLnu67IHducFipOl8
	 sWQMlI30fmTljPdDTzh2sthl6iTmawkPpncGHK+vHjS7bqsEuw1gU06vFWCm2XHh7S
	 SVI3FjBdOFbmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 315/317] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
Date: Sun, 24 Mar 2024 19:34:55 -0400
Message-ID: <20240324233458.1352854-316-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Fei Shao <fshao@chromium.org>

[ Upstream commit a20ad45008a7c82f1184dc6dee280096009ece55 ]

The TX buffer in spi_transfer can be a NULL pointer, so the interrupt
handler may end up writing to the invalid memory and cause crashes.

Add a check to trans->tx_buf before using it.

Fixes: 1ce24864bff4 ("spi: mediatek: Only do dma for 4-byte aligned buffers")
Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://msgid.link/r/20240321070942.1587146-2-fshao@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 49acba1dea1e7..30aac6f093b21 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -659,17 +659,19 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(master);
 
-		cnt = mdata->xfer_len / 4;
-		iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
-				trans->tx_buf + mdata->num_xfered, cnt);
+		if (trans->tx_buf) {
+			cnt = mdata->xfer_len / 4;
+			iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
+					trans->tx_buf + mdata->num_xfered, cnt);
 
-		remainder = mdata->xfer_len % 4;
-		if (remainder > 0) {
-			reg_val = 0;
-			memcpy(&reg_val,
-				trans->tx_buf + (cnt * 4) + mdata->num_xfered,
-				remainder);
-			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+			remainder = mdata->xfer_len % 4;
+			if (remainder > 0) {
+				reg_val = 0;
+				memcpy(&reg_val,
+					trans->tx_buf + (cnt * 4) + mdata->num_xfered,
+					remainder);
+				writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+			}
 		}
 
 		mtk_spi_enable_transfer(master);
-- 
2.43.0


