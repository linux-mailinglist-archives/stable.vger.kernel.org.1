Return-Path: <stable+bounces-66836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8DA94F2AF
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E9A1F20C27
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241418733D;
	Mon, 12 Aug 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pMhNA+ch"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393018732A;
	Mon, 12 Aug 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478945; cv=none; b=paSgIFniYc4tc0NJSqugcVBykL4euYFRQ+pOR+aod4y+rQViaLbGdUfOm6V2JK9+DnC4kXeF+nkxzIDV4D/tvOwBzNpoa4BWHogPeSiDp+rTOOF1hghA8IHJGNf3+Jhqq5cuVESzTEKj0KYkSlO2TunCIOvJlHlLp2SPYSYjj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478945; c=relaxed/simple;
	bh=Hn9thRNbujhyQ8t9kHn+xxUOB0Am9yNqPPhKAyqP6EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDjIexa3BoYj7c6wZqcKbcEzDYL+Us1ZNjUN7D0CuJNCChFZXx/Po3vOkHOzzdlNd5sE8OXJmqlgHqhfhdZhjn7XNcv/ft3ucHJuy/+Zk+JYyIXhwN1nKQMwssiKKoEez2zPaF5AT87/8ljupjk2T9n2Ntb6zq/Rh9EW7F0CohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pMhNA+ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18705C32782;
	Mon, 12 Aug 2024 16:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723478944;
	bh=Hn9thRNbujhyQ8t9kHn+xxUOB0Am9yNqPPhKAyqP6EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMhNA+chIFzkoN5OZci++yicqOgkKEKvQGR+68rGddueeI7BdoaUeR0NwZ6OqdeQm
	 oR5F5R2Dt0+NtEzzNtPbsuv6HOQHTPVupSyD5++ThrxHWwq/orIpOAMNVwMbqgJDYs
	 UZ9JcXcHaaG9u9xdP2ktHmle2AiJQ6YA2Dwhn8Yg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Wahren <wahrenst@gmx.net>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 084/150] spi: spi-fsl-lpspi: Fix scldiv calculation
Date: Mon, 12 Aug 2024 18:02:45 +0200
Message-ID: <20240812160128.411923488@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 730bbfaf7d4890bd99e637db7767dc68cfeb24e7 ]

The effective SPI clock frequency should never exceed speed_hz
otherwise this might result in undefined behavior of the SPI device.

Currently the scldiv calculation could violate this constraint.
For the example parameters perclk_rate = 24 MHz and speed_hz = 7 MHz,
the function fsl_lpspi_set_bitrate will determine perscale = 0 and
scldiv = 1, which is a effective SPI clock of 8 MHz.

So fix this by rounding up the quotient of perclk_rate and speed_hz.
While this never change within the loop, we can pull this out.

Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://patch.msgid.link/20240804113611.83613-1-wahrenst@gmx.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 9e324d72596af..dd2381ac27f67 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -297,7 +297,7 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 {
 	struct lpspi_config config = fsl_lpspi->config;
-	unsigned int perclk_rate, scldiv;
+	unsigned int perclk_rate, scldiv, div;
 	u8 prescale;
 
 	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
@@ -308,8 +308,10 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 		return -EINVAL;
 	}
 
+	div = DIV_ROUND_UP(perclk_rate, config.speed_hz);
+
 	for (prescale = 0; prescale < 8; prescale++) {
-		scldiv = perclk_rate / config.speed_hz / (1 << prescale) - 2;
+		scldiv = div / (1 << prescale) - 2;
 		if (scldiv < 256) {
 			fsl_lpspi->config.prescale = prescale;
 			break;
-- 
2.43.0




