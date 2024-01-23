Return-Path: <stable+bounces-13294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA12837B4F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51EA1F281AF
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA314D423;
	Tue, 23 Jan 2024 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hezLnC3j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582CE14AD2B;
	Tue, 23 Jan 2024 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969275; cv=none; b=NENysCD+pmKyKCUbDvswuf3rrZsrfpTqSXNwDH7S3d8jMLzUxZv5jat5D6GbxKvtUCk7vlNREKq2QIoV5vHFP+KWyU3HtNo+IrpDHweE783EFZFZLS1S2sCJBz+L6EO678jSuBgcrc7MWoASokNeT6LVDKufsb3FZktSWHTpv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969275; c=relaxed/simple;
	bh=9KAPUj9mj48Dag7AwIUtFIObIG14ECuOWVJ55Thm+PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp76/HnepwQsHs2Le/bR1VThX6DP/56A94SURTHv4O+zX/8nFT0MT3Ncn81wHVe3zyyiRj/xbSbzANs0PQuz3TTCBU09LRS1H1IGz/VzYr4pLWaLs7zGqZe6Juz2dTLx4MmA/t8flIYR+X735pvHA3s9+s/SRkUhIibsckLWnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hezLnC3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EC9C433B1;
	Tue, 23 Jan 2024 00:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969275;
	bh=9KAPUj9mj48Dag7AwIUtFIObIG14ECuOWVJ55Thm+PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hezLnC3jv9+sIMrw7Y29xR+H1uYHsOyEDdaN1f6wuC0drCCmZKws7zR1dkP8BltZq
	 ls8KQYMu+2Q+ciIQSFwWaOcf8BvtjInSZC+aDhFQQXniF8B70rp2IljdIx+CiLh1fG
	 2iZoFsXY3MZx0pu5Rp8swbO2ZSfbtwDPBmcxdky8=
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
Subject: [PATCH 6.7 113/641] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Date: Mon, 22 Jan 2024 15:50:17 -0800
Message-ID: <20240122235821.572549489@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

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




