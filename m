Return-Path: <stable+bounces-164327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E5B0E78E
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 02:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB9C7AD453
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865E9156CA;
	Wed, 23 Jul 2025 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYtA2NZ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D32E36FA
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230012; cv=none; b=DZI4iWQ+fjNgFRfYwmjgX1BEKI7yCHfmHEgjrDCb0smnDLXyK+OcBh3IC2yJfqK+Q5lS/y2iMzc0L+at974X++euljIkUwV0+HRfCEv52ySKofE8outZfR4PnSt+U7ujl0SFqRiah2dhXRPb1zUwOVszfmDnvGI13ECqL7yxvag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230012; c=relaxed/simple;
	bh=VQSzGUec2qiLeKvNfKYOBiMGj+udNHkpr/YvSkY51Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzneF6keKOZuyvEGRuJ2FNn47dmuYA2soeioMTSyirwBZV1khBzYdiHuziULFCQfC0LJKIxPxV2z5lr7odHNGhlM4EjcfYzufatRQEyalB0TKlvt3YqxBA0C+uZfzDs3e9P/IZLvijKyzBPDwa9sSOP1lNOg/V3x1HNB48PSrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYtA2NZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B6BC4CEF6;
	Wed, 23 Jul 2025 00:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753230011;
	bh=VQSzGUec2qiLeKvNfKYOBiMGj+udNHkpr/YvSkY51Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYtA2NZ3ZBOSJTlJb/z2yq6B6H5nxpBeJkHmvg57P1zOUO/bQoD7iwYzy/EOGS7NN
	 ty9YJcJWcHwq4okTMiOl8dLc78dnZ4bfPvkpAkgCGD28gfflgQpzYWJCrLaW0mt7Ig
	 IiTT+1WdGj2c9gqNO2RBHCWmtylKglr96fcOT3VnmMqpjpegFE5sgj9dEwTtGTkhFw
	 UDytnf795kCNX2xJohCEEB9tOEuLm40JyfboLj1woWZsOfXMIbRjnLQ5C3JRILDhvg
	 fvo5b1hCNV374OHWi6ahJSSVUFh0DYBvKtDRMfya/cQw1tbjC6clt3pDhlc4LtzQkH
	 tOFgnJycUAO3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/6] i2c: stm32: fix the device used for the DMA map
Date: Tue, 22 Jul 2025 20:19:41 -0400
Message-Id: <20250723001942.1010722-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723001942.1010722-1-sashal@kernel.org>
References: <2025072104-bacteria-resend-dcff@gregkh>
 <20250723001942.1010722-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Clément Le Goffic <clement.legoffic@foss.st.com>

[ Upstream commit c870cbbd71fccda71d575f0acd4a8d2b7cd88861 ]

If the DMA mapping failed, it produced an error log with the wrong
device name:
"stm32-dma3 40400000.dma-controller: rejecting DMA map of vmalloc memory"
Fix this issue by replacing the dev with the I2C dev.

Fixes: bb8822cbbc53 ("i2c: i2c-stm32: Add generic DMA API")
Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Cc: <stable@vger.kernel.org> # v4.18+
Acked-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20250704-i2c-upstream-v4-1-84a095a2c728@foss.st.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-stm32.c   | 8 +++-----
 drivers/i2c/busses/i2c-stm32f7.c | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32.c b/drivers/i2c/busses/i2c-stm32.c
index 157c64e27d0bd..f84ec056e36df 100644
--- a/drivers/i2c/busses/i2c-stm32.c
+++ b/drivers/i2c/busses/i2c-stm32.c
@@ -102,7 +102,6 @@ int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
 			    void *dma_async_param)
 {
 	struct dma_async_tx_descriptor *txdesc;
-	struct device *chan_dev;
 	int ret;
 
 	if (rd_wr) {
@@ -116,11 +115,10 @@ int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
 	}
 
 	dma->dma_len = len;
-	chan_dev = dma->chan_using->device->dev;
 
-	dma->dma_buf = dma_map_single(chan_dev, buf, dma->dma_len,
+	dma->dma_buf = dma_map_single(dev, buf, dma->dma_len,
 				      dma->dma_data_dir);
-	if (dma_mapping_error(chan_dev, dma->dma_buf)) {
+	if (dma_mapping_error(dev, dma->dma_buf)) {
 		dev_err(dev, "DMA mapping failed\n");
 		return -EINVAL;
 	}
@@ -150,7 +148,7 @@ int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
 	return 0;
 
 err:
-	dma_unmap_single(chan_dev, dma->dma_buf, dma->dma_len,
+	dma_unmap_single(dev, dma->dma_buf, dma->dma_len,
 			 dma->dma_data_dir);
 	return ret;
 }
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 5aec7bed109eb..cc76c71666e5d 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -728,10 +728,10 @@ static void stm32f7_i2c_dma_callback(void *arg)
 {
 	struct stm32f7_i2c_dev *i2c_dev = (struct stm32f7_i2c_dev *)arg;
 	struct stm32_i2c_dma *dma = i2c_dev->dma;
-	struct device *dev = dma->chan_using->device->dev;
 
 	stm32f7_i2c_disable_dma_req(i2c_dev);
-	dma_unmap_single(dev, dma->dma_buf, dma->dma_len, dma->dma_data_dir);
+	dma_unmap_single(i2c_dev->dev, dma->dma_buf, dma->dma_len,
+			 dma->dma_data_dir);
 	complete(&dma->dma_complete);
 }
 
-- 
2.39.5


