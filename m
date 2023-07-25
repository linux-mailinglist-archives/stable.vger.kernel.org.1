Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418677611D1
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjGYK4h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjGYK4N (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:56:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A6C35AD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B7AD6169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACB1C433C7;
        Tue, 25 Jul 2023 10:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282402;
        bh=jAp8mWG+a5X5KuvI4qyYtYYgwdNfhGImxiJ+pfJksXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBfT9V265UOHeTkwW5IcDmiq01RU/79+GdpmK1C2Lq1kMjAKoH71rILEYicsT3FNX
         i5NPhDRtRtSOn9+j0LdF+X4Rf+DDlC6WPhkgNqwbyjcXjMvTQ4ij5fcVy5n5gI0Fap
         dl3crKvQwFb1xTNW1C8+kGuYkI8mh1vwV/1dWO5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 116/227] wifi: rtw88: sdio: Check the HISR RX_REQUEST bit in rtw_sdio_rx_isr()
Date:   Tue, 25 Jul 2023 12:44:43 +0200
Message-ID: <20230725104519.599914857@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit e967229ead0e6c5047a1cfd5a0db58ceb930800b ]

rtw_sdio_rx_isr() is responsible for receiving data from the wifi chip
and is called from the SDIO interrupt handler when the interrupt status
register (HISR) has the RX_REQUEST bit set. After the first batch of
data has been processed by the driver the wifi chip may have more data
ready to be read, which is managed by a loop in rtw_sdio_rx_isr().

It turns out that there are cases where the RX buffer length (from the
REG_SDIO_RX0_REQ_LEN register) does not match the data we receive. The
following two cases were observed with a RTL8723DS card:
- RX length is smaller than the total packet length including overhead
  and actual data bytes (whose length is part of the buffer we read from
  the wifi chip and is stored in rtw_rx_pkt_stat.pkt_len). This can
  result in errors like:
    skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put:3341
  (one case observed was: RX buffer length = 1536 bytes but
   rtw_rx_pkt_stat.pkt_len = 1546 bytes, this is not valid as it means
   we need to read beyond the end of the buffer)
- RX length looks valid but rtw_rx_pkt_stat.pkt_len is zero

Check if the RX_REQUEST is set in the HISR register for each iteration
inside rtw_sdio_rx_isr(). This mimics what the RTL8723DS vendor driver
does and makes the driver only read more data if the RX_REQUEST bit is
set (which seems to be a way for the card's hardware or firmware to
tell the host that data is ready to be processed).

For RTW_WCPU_11AC chips this check is not needed. The RTL8822BS vendor
driver for example states that this check is unnecessary (but still uses
it) and the RTL8822CS drops this check entirely.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230522202425.1827005-2-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 24 ++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 06fce7c3addaa..2c1fb2dabd40a 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -998,9 +998,9 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 
 static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 {
-	u32 rx_len, total_rx_bytes = 0;
+	u32 rx_len, hisr, total_rx_bytes = 0;
 
-	while (total_rx_bytes < SZ_64K) {
+	do {
 		if (rtw_chip_wcpu_11n(rtwdev))
 			rx_len = rtw_read16(rtwdev, REG_SDIO_RX0_REQ_LEN);
 		else
@@ -1012,7 +1012,25 @@ static void rtw_sdio_rx_isr(struct rtw_dev *rtwdev)
 		rtw_sdio_rxfifo_recv(rtwdev, rx_len);
 
 		total_rx_bytes += rx_len;
-	}
+
+		if (rtw_chip_wcpu_11n(rtwdev)) {
+			/* Stop if no more RX requests are pending, even if
+			 * rx_len could be greater than zero in the next
+			 * iteration. This is needed because the RX buffer may
+			 * already contain data while either HW or FW are not
+			 * done filling that buffer yet. Still reading the
+			 * buffer can result in packets where
+			 * rtw_rx_pkt_stat.pkt_len is zero or points beyond the
+			 * end of the buffer.
+			 */
+			hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
+		} else {
+			/* RTW_WCPU_11AC chips have improved hardware or
+			 * firmware and can use rx_len unconditionally.
+			 */
+			hisr = REG_SDIO_HISR_RX_REQUEST;
+		}
+	} while (total_rx_bytes < SZ_64K && hisr & REG_SDIO_HISR_RX_REQUEST);
 }
 
 static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
-- 
2.39.2



