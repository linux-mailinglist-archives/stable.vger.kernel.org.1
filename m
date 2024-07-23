Return-Path: <stable+bounces-61184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E995593A739
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF11F23332
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E47158A01;
	Tue, 23 Jul 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B4c4Y/pQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812051581F4;
	Tue, 23 Jul 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760225; cv=none; b=cAtwY6ApmierQZC68zIqtWBLN62txAJkHrn4d8wpBiHyJBzrKv58BWKXl0fg3dMuU2mZwu44naTiNQbvbDRTIBBI1cdp1hmTQzy3Whv/26Sa6/GAGCukWw0Akml0tBsvkTsZtreS3K93tYuz2e18/bwgz5kAIdJQFz5AO0W++bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760225; c=relaxed/simple;
	bh=79YrUNLwj3hIx1ZD+m7wuXOxeKqMb/JnuktrVgBmpOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxChfnWwkZ3zNu8p2r4cwC4QSr0L6EjvLexwV16Ch43n+6Hy/D1I6ovGtocZqg9fGL53xMKOljhPX/NMQoSusoeyy1BNxwmbb8v0sOppEFl059Q5FMTt5onAjY72x8iaElLTg8fBaphoq4KE9U2xO3zo/fO1uV1RQnVSHVbYLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B4c4Y/pQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB39C4AF09;
	Tue, 23 Jul 2024 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721760225;
	bh=79YrUNLwj3hIx1ZD+m7wuXOxeKqMb/JnuktrVgBmpOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4c4Y/pQb7QgSrsQivjfBp/mvDqmwS2HleKJdI9Ct0shnhDPE+tHrCcxSxg4rAOwV
	 kphIT0BZBNY3lHN+Xz2fL4Afcp9AnsDysgfKSCXZH5w2yxIDhIFgLn/kx+Df+bjkxl
	 jHdFO9Y/pDksurEQjL306JiaEVbqWM0r39DKICb4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 145/163] spi: davinci: Unset POWERDOWN bit when releasing resources
Date: Tue, 23 Jul 2024 20:24:34 +0200
Message-ID: <20240723180149.074162992@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
References: <20240723180143.461739294@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bastien Curutchet <bastien.curutchet@bootlin.com>

[ Upstream commit 1762dc01fc78ef5f19693e9317eae7491c6c7e1b ]

On the OMAPL138, the SPI reference clock is provided by the Power and
Sleep Controller (PSC). The PSC's datasheet says that 'some peripherals
have special programming requirements and additional recommended steps
you must take before you can invoke the PSC module state transition'. I
didn't find more details in documentation but it appears that PSC needs
the SPI to clear the POWERDOWN bit before disabling the clock. Indeed,
when this bit is set, the PSC gets stuck in transitions from enable to
disable state.

Clear the POWERDOWN bit when releasing driver's resources

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
Link: https://patch.msgid.link/20240624071745.17409-1-bastien.curutchet@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-davinci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index be3998104bfbb..f7e8b5efa50e5 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -984,6 +984,9 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	return ret;
 
 free_dma:
+	/* This bit needs to be cleared to disable dpsi->clk */
+	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
@@ -1013,6 +1016,9 @@ static void davinci_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&dspi->bitbang);
 
+	/* This bit needs to be cleared to disable dpsi->clk */
+	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
+
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
-- 
2.43.0




