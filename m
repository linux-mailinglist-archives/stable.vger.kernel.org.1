Return-Path: <stable+bounces-134293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9012A92A72
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E403B794D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76DD1A3178;
	Thu, 17 Apr 2025 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VMq1Gf32"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A31DE885;
	Thu, 17 Apr 2025 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915686; cv=none; b=aC+uTSFZW5B7+sEiQ7rMp2ZUL2YmnuSo/uxtmxRNAD8nXdDkHxWKD3Ejk091Q/mLPiuuScJVgIAcB31QSWEfckcLyIJB1OJhJY4gPEF2dfvTh/fM5k4YrerMp/OAgppIRnK8fmxyy2xEy3UqW2VhscqCluHf8DwyzRwMjBHEUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915686; c=relaxed/simple;
	bh=H+bFoehqvL7TzmIzG1ZvOqjIMECpwHKFi3da2WDncH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1QEtfRsov1VoDFRkQnsoC4puDuXs+OxEQ0jky7WKRPaloONRA83MlGe6WHIM4xsd2EW6nEk4lTkjvWo9iAiOUcJf8N7fErj1GrFqetkdgbEMVETdgbN6h0iPkwkM5zXZI3pBsclA3/wUqMtOvd5c7IJPeZUyGdAD6w1L6bbMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VMq1Gf32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20214C4CEE4;
	Thu, 17 Apr 2025 18:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915686;
	bh=H+bFoehqvL7TzmIzG1ZvOqjIMECpwHKFi3da2WDncH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMq1Gf32DGj5fqMnwK20zAx+Hzrpb302XDj56JUwU7Z6zY1lzXLRowcGcZsqEtHd0
	 CaQ2U6B/Sz7clTKcoXiufIbp9So7FBQEaxcyi/7YeZp82YN/yjEl6DX3PZ6jsHqSk2
	 +uUVF3rcDp2GgabO8HZRD2lXjd0ikxJA0iX6rs3c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 207/393] spi: cadence-qspi: Fix probe on AM62A LP SK
Date: Thu, 17 Apr 2025 19:50:16 +0200
Message-ID: <20250417175115.907813923@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit b8665a1b49f5498edb7b21d730030c06b7348a3c upstream.

In 2020, there's been an unnoticed change which rightfully attempted to
report probe deferrals upon DMA absence by checking the return value of
dma_request_chan_by_mask(). By doing so, it also reported errors which
were simply ignored otherwise, likely on purpose.

This change actually turned a void return into an error code. Hence, not
only the -EPROBE_DEFER error codes but all error codes got reported to
the callers, now failing to probe in the absence of Rx DMA channel,
despite the fact that DMA seems to not be supported natively by many
implementations.

Looking at the history, this change probably led to:
ad2775dc3fc5 ("spi: cadence-quadspi: Disable the DAC for Intel LGM SoC")
f724c296f2f2 ("spi: cadence-quadspi: fix Direct Access Mode disable for SoCFPGA")

In my case, the AM62A LP SK core octo-SPI node from TI does not
advertise any DMA channel, hinting that there is likely no support for
it, but yet when the support for the am654 compatible was added, DMA
seemed to be used, so just discarding its use with the
CQSPI_DISABLE_DAC_MODE quirk for this compatible does not seem the
correct approach.

Let's get change the return condition back to:
- return a probe deferral error if we get one
- ignore the return value otherwise
The "error" log level was however likely too high for something that is
expected to fail, so let's lower it arbitrarily to the info level.

Fixes: 935da5e5100f ("mtd: spi-nor: cadence-quadspi: Handle probe deferral while requesting DMA channel")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20250305200933.2512925-2-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-cadence-quadspi.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1634,6 +1634,12 @@ static int cqspi_request_mmap_dma(struct
 		int ret = PTR_ERR(cqspi->rx_chan);
 
 		cqspi->rx_chan = NULL;
+		if (ret == -ENODEV) {
+			/* DMA support is not mandatory */
+			dev_info(&cqspi->pdev->dev, "No Rx DMA available\n");
+			return 0;
+		}
+
 		return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
 	}
 	init_completion(&cqspi->rx_dma_complete);



