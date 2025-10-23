Return-Path: <stable+bounces-189169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E3C039B4
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 23:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 227F6354EA5
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 21:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467A191F91;
	Thu, 23 Oct 2025 21:47:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AAA13790B
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256073; cv=none; b=Ha2TDGmQXaZsVpHBbzsagbuflHqIECeXNuM+aDmdVnlbovSY9lzbauJ8saWDXOMEbRrLWowy97rhg/NIxYE79NF0btj8ulpdftPyr6WwwWQR0ej5Lx+t3724FHeui3NhlX1HKkFOecC00ruF3WGSzozGtX5L+fSW9a5whEPpweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256073; c=relaxed/simple;
	bh=mJpOqNCTvzTBHwdN370dGYMUzPzecvsrw4ANCkvgjtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bQhwUZkVgyc9ertR4WupGxG5bINcdtqTnECrnoU+mzYv1lNyWThZz3gZ3Y20NFC5PqpAce+dPWjQUwsji00jV25v2bumd2G44EDnuR/7UXAjXKdcCRIl85eXVNPv4SpC0Yy8PIu4zHaUC3gyMAQWqshO2tTU+e4pY/ddLDbfKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 5891623372;
	Fri, 24 Oct 2025 00:47:40 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y] spi-rockchip: Fix register out of bounds access
Date: Fri, 24 Oct 2025 00:47:39 +0300
Message-Id: <20251023214739.247289-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luis de Arquer <luis.dearquer@inertim.com>

commit 7a874e8b54ea21094f7fd2d428b164394c6cb316 upstream.

Do not write native chip select stuff for GPIO chip selects.
GPIOs can be numbered much higher than native CS.
Also, it makes no sense.

Fixes: 736b81e07517 ("spi: rockchip: Support SPI_CS_HIGH")
Signed-off-by: Luis de Arquer <luis.dearquer@inertim.com>
Link: https://patch.msgid.link/365ccddfba110549202b3520f4401a6a936e82a8.camel@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ kovalev: bp to fix CVE-2025-38081; added Fixes tag ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/spi/spi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index dbefc7e77313..cba858a7b4f9 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -540,8 +540,8 @@ static int rockchip_spi_config(struct rockchip_spi *rs,
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 	if (spi->mode & SPI_LSB_FIRST)
 		cr0 |= CR0_FBM_LSB << CR0_FBM_OFFSET;
-	if (spi->mode & SPI_CS_HIGH)
-		cr0 |= BIT(spi->chip_select) << CR0_SOI_OFFSET;
+	if ((spi->mode & SPI_CS_HIGH) && !(spi_get_csgpiod(spi, 0)))
+		cr0 |= BIT(spi_get_chipselect(spi, 0)) << CR0_SOI_OFFSET;
 
 	if (xfer->rx_buf && xfer->tx_buf)
 		cr0 |= CR0_XFM_TR << CR0_XFM_OFFSET;
-- 
2.50.1


