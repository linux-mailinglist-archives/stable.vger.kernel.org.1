Return-Path: <stable+bounces-14837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129788382D7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379801C29539
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C955FBA9;
	Tue, 23 Jan 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FrwQBv7S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448F75FBA4;
	Tue, 23 Jan 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974639; cv=none; b=JlMYbNYrfaclQ8nXeZHlleLdJTG5L63S7DlSjbsTaqARdnvQpvDx9XtQcQpXEHhbIrixFXgDr6gN82cMkMK3QMPLIeM4p2qgB3bYacVR0s2spa6bSyeOCvGGaRdyyvJcujzK55syZkSi+C4fsKVWMX9rGYKXofx72FI2uyMzkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974639; c=relaxed/simple;
	bh=su8HHnhplTb68sKyeisS9sVU0vikvo1TZs2cAUGBDsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmIheffBftkyvVo9ISEM1FVcCBKEfXNrXvSxsFqExCKzIvegmYnl+7CoZ9YIaF789pH3vjNiP6bKut0ALCq92hld6jr4PVzEwX2v+SGBXDKYEDyLF1tTrkfHC8Ayb0IhrubyByee3DqtAPfEb4ZMZ53pCFfgHWywaXMkfSpCxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FrwQBv7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0762AC433A6;
	Tue, 23 Jan 2024 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974639;
	bh=su8HHnhplTb68sKyeisS9sVU0vikvo1TZs2cAUGBDsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrwQBv7SJpma3AyollNtQv1s8dxxeWtv3ZeljMrr6wONdMeOwbn6KWus2sUjcg/ff
	 Vcnck7Y9ZBp4YaH0UhBG7ehi/M54C45sErlOlD31BAHqfPyVBlENh3J/fPMzkkssXX
	 JSn6T+T5nAzACwWzftWovxOdxniR66mFhfclL8aU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Lukas F. Hartmann" <lukas@mntre.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 100/583] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Date: Mon, 22 Jan 2024 15:52:31 -0800
Message-ID: <20240122235815.239584415@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 00384f565a91c08c4bedae167f749b093d10e3fe ]

Lukas reports skb_over_panic errors on his Banana Pi BPI-CM4 which comes
with an Amlogic A311D (G12B) SoC and a RTL8822CS SDIO wifi/Bluetooth
combo card. The error he observed is identical to what has been fixed
in commit e967229ead0e ("wifi: rtw88: sdio: Check the HISR RX_REQUEST
bit in rtw_sdio_rx_isr()") but that commit didn't fix Lukas' problem.

Lukas found that disabling or limiting RX aggregation works around the
problem for some time (but does not fully fix it). In the following
discussion a few key topics have been discussed which have an impact on
this problem:
- The Amlogic A311D (G12B) SoC has a hardware bug in the SDIO controller
  which prevents DMA transfers. Instead all transfers need to go through
  the controller SRAM which limits transfers to 1536 bytes
- rtw88 chips don't split incoming (RX) packets, so if a big packet is
  received this is forwarded to the host in it's original form
- rtw88 chips can do RX aggregation, meaning more multiple incoming
  packets can be pulled by the host from the card with one MMC/SDIO
  transfer. This Depends on settings in the REG_RXDMA_AGG_PG_TH
  register (BIT_RXDMA_AGG_PG_TH limits the number of packets that will
  be aggregated, BIT_DMA_AGG_TO_V1 configures a timeout for aggregation
  and BIT_EN_PRE_CALC makes the chip honor the limits more effectively)

Use multiple consecutive reads in rtw_sdio_read_port() and limit the
number of bytes which are copied by the host from the card in one
MMC/SDIO transfer. This allows receiving a buffer that's larger than
the hosts max_req_size (number of bytes which can be transferred in
one MMC/SDIO transfer). As a result of this the skb_over_panic error
is gone as the rtw88 driver is now able to receive more than 1536 bytes
from the card (either because the incoming packet is larger than that
or because multiple packets have been aggregated).

In case of an receive errors (-EILSEQ has been observed by Lukas) we
need to drain the remaining data from the card's buffer, otherwise the
card will return corrupt data for the next rtw_sdio_read_port() call.

Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Reported-by: Lukas F. Hartmann <lukas@mntre.com>
Closes: https://lore.kernel.org/linux-wireless/CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com/
Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Lukas F. Hartmann <lukas@mntre.com>
Reported-by: Lukas F. Hartmann <lukas@mntre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Lukas F. Hartmann <lukas@mntre.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231120115726.1569323-1-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 35 ++++++++++++++++++-----
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 2c1fb2dabd40..0cae5746f540 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -500,19 +500,40 @@ static u32 rtw_sdio_get_tx_addr(struct rtw_dev *rtwdev, size_t size,
 static int rtw_sdio_read_port(struct rtw_dev *rtwdev, u8 *buf, size_t count)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	struct mmc_host *host = rtwsdio->sdio_func->card->host;
 	bool bus_claim = rtw_sdio_bus_claim_needed(rtwsdio);
 	u32 rxaddr = rtwsdio->rx_addr++;
-	int ret;
+	int ret = 0, err;
+	size_t bytes;
 
 	if (bus_claim)
 		sdio_claim_host(rtwsdio->sdio_func);
 
-	ret = sdio_memcpy_fromio(rtwsdio->sdio_func, buf,
-				 RTW_SDIO_ADDR_RX_RX0FF_GEN(rxaddr), count);
-	if (ret)
-		rtw_warn(rtwdev,
-			 "Failed to read %zu byte(s) from SDIO port 0x%08x",
-			 count, rxaddr);
+	while (count > 0) {
+		bytes = min_t(size_t, host->max_req_size, count);
+
+		err = sdio_memcpy_fromio(rtwsdio->sdio_func, buf,
+					 RTW_SDIO_ADDR_RX_RX0FF_GEN(rxaddr),
+					 bytes);
+		if (err) {
+			rtw_warn(rtwdev,
+				 "Failed to read %zu byte(s) from SDIO port 0x%08x: %d",
+				 bytes, rxaddr, err);
+
+			 /* Signal to the caller that reading did not work and
+			  * that the data in the buffer is short/corrupted.
+			  */
+			ret = err;
+
+			/* Don't stop here - instead drain the remaining data
+			 * from the card's buffer, else the card will return
+			 * corrupt data for the next rtw_sdio_read_port() call.
+			 */
+		}
+
+		count -= bytes;
+		buf += bytes;
+	}
 
 	if (bus_claim)
 		sdio_release_host(rtwsdio->sdio_func);
-- 
2.43.0




