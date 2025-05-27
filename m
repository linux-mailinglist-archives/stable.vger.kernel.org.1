Return-Path: <stable+bounces-147866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E4AC59AE
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 20:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632013A4EA2
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93DB27FD4C;
	Tue, 27 May 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pdMkne8H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6537428032E;
	Tue, 27 May 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368678; cv=none; b=F7QJmahB34FNjb26lDAwGouulQdIEG2/G11AjuGckabQVYqn8i8MTVU5plz0Fua/72vKZ83RXVVgUa8Erh8S+l1Z1JopF4vPudE+iaL/5pmDNyIOVoaIBJhdI6PVZ1qaa+HRzmN3YZ2+WsdFN3Ui1uSOLv1TagFIj/VN1Mefxkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368678; c=relaxed/simple;
	bh=jEZn4ts+dRcpt/Xa21vVgv1mSKNHKPsSEDDUPNkCwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2xBYbZn8OdhTnOhS8eAeETZqsCYU8YKnTvqMp07icJdZD9cwBDTo8y5KJd144dXTIbLxNegLPzg9AoQsXhfm5rCmCUkc/mD5hBroyay8hZ+FXWhkMwCCDYVLWb8mbrP8k+jbuV3x9j8z2ETy5OlMjonzfGEIXBDbL8+r9/Nrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pdMkne8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE00EC4CEE9;
	Tue, 27 May 2025 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368678;
	bh=jEZn4ts+dRcpt/Xa21vVgv1mSKNHKPsSEDDUPNkCwDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdMkne8HT5Rcz3Fdvezo7MX4eK7R4NP9n10irsY7LjyGomhSYOlDZoFZ93gmUodD2
	 UTiH3Uyd/RbLCxxb3qm1/bR49b6vl2xOXxuKGwIjGU6Zstfy7y8iLwA1ki5BgQKpWR
	 tzqsLwfR5VI3FhGUawvcy8ELoxykUBrQTiE5OOAc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Larisa Grigore <larisa.grigore@nxp.com>,
	James Clark <james.clark@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 774/783] spi: spi-fsl-dspi: Reset SR flags before sending a new message
Date: Tue, 27 May 2025 18:29:31 +0200
Message-ID: <20250527162544.650964225@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larisa Grigore <larisa.grigore@nxp.com>

[ Upstream commit 7aba292eb15389073c7f3bd7847e3862dfdf604d ]

If, in a previous transfer, the controller sends more data than expected
by the DSPI target, SR.RFDF (RX FIFO is not empty) will remain asserted.
When flushing the FIFOs at the beginning of a new transfer (writing 1
into MCR.CLR_TXF and MCR.CLR_RXF), SR.RFDF should also be cleared.
Otherwise, when running in target mode with DMA, if SR.RFDF remains
asserted, the DMA callback will be fired before the controller sends any
data.

Take this opportunity to reset all Status Register fields.

Fixes: 5ce3cc567471 ("spi: spi-fsl-dspi: Provide support for DSPI slave mode operation (Vybryd vf610)")
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
Link: https://patch.msgid.link/20250522-james-nxp-spi-v2-3-bea884630cfb@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 1fa96e8189cfa..863781ba6c160 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -975,6 +975,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
 
+		regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
+
 		spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
 				       dspi->progress, !dspi->irq);
 
-- 
2.39.5




