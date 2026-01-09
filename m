Return-Path: <stable+bounces-206490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 530A2D09017
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEE123007C15
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140D33987D;
	Fri,  9 Jan 2026 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y5ybX2cl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46FE318EFA;
	Fri,  9 Jan 2026 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959353; cv=none; b=ZYdr9ZWuQl0MlUVNjfohDAek4Cn2vwwnsqF29GDORivdpSv2iGazhQ2FtkS4Kvwq5ATqb4xdw84JGgJonKi6mHD7792VEbl2aTSjbnJrxqOKwpwUQtZ918yVWdX1CBqRTfm5epM4kR/wI84ryYyZ3ecusn4c13RFGC5dQrq2JSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959353; c=relaxed/simple;
	bh=S4FheoAMGZzDQYPjUa9ZUVY7m+kholirD2TRK14Kmxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naPHwnVZJpriXY4nRP6Bz6Y4DO+iuEX6hK1pHypkdji1LM650uScQWgDt5sKyoR23eHz1xccp0ZjdViqTqdp6pauK1DAKceJy+l/g4iEeReC/6RqiTyJJNdMJ49dC+oe2qyLR07ceAq22iD9tOhpKg/eKWuno/TngiqEYUrsXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y5ybX2cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065B6C4CEF1;
	Fri,  9 Jan 2026 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767959353;
	bh=S4FheoAMGZzDQYPjUa9ZUVY7m+kholirD2TRK14Kmxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5ybX2clCDrh0NIwcwk7hKp/u54AYMKjEpQm9t9zc73yZtQP+7UsnIUaaaEy9MQSP
	 6xbHoBoSP/dWBSNNTh1q8yktwUmFNdzAS/w/GaNfpLKKrZS4yNtftjIjbRf9k9blUM
	 ha5pgxtipxQFfwbax4Pt7vI8Bu9ylJNurQR0Y/Zs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alvaro Gamez Machado <alvaro.gamez@hazent.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 022/737] spi: xilinx: increase number of retries before declaring stall
Date: Fri,  9 Jan 2026 12:32:41 +0100
Message-ID: <20260109112134.830886825@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Alvaro Gamez Machado <alvaro.gamez@hazent.com>

[ Upstream commit 939edfaa10f1d22e6af6a84bf4bd96dc49c67302 ]

SPI devices using a (relative) slow frequency need a larger time.

For instance, microblaze running at 83.25MHz and performing a
3 bytes transaction using a 10MHz/16 = 625kHz needed this stall
value increased to at least 20. The SPI device is quite slow, but
also is the microblaze, so set this value to 32 to give it even
more margin.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://patch.msgid.link/20251106134545.31942-1-alvaro.gamez@hazent.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 8e6e3876aa9af..b5405d9974ba6 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -299,7 +299,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		/* Read out all the data from the Rx FIFO */
 		rx_words = n_words;
-		stalled = 10;
+		stalled = 32;
 		while (rx_words) {
 			if (rx_words == n_words && !(stalled--) &&
 			    !(sr & XSPI_SR_TX_EMPTY_MASK) &&
-- 
2.51.0




