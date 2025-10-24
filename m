Return-Path: <stable+bounces-189215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC946C052CF
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 10:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB0145827F6
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8DB305E24;
	Fri, 24 Oct 2025 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7bQn6Rr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074F23505E
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295260; cv=none; b=vECQoTo1J8/nQ9881h6sdeJ1L4U65L+du0R3edYTyxDpDfcBatCAx6F6MMqcKxLWHPB9LEvjR1dgu0DfIkv1VGARiQKxqCIM41EGuLxNS54dH3yul6WyZoz9FDztdUVEmBL3LPWoEEPBntwHyXcYTZCIr6lDQJPg/beeJOgZXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295260; c=relaxed/simple;
	bh=B7xgl3RP6gTgFk/aAJqRetM/dnMeClNGbVxvp+14Yuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s/ZVMKxPsVHJ2sRnnYfrCXf6XJ7fajPRC4J+R26aRWZlwWvoxMnLd7vSRNOT28w1IWUQR874Njup8xx2j4ST19n/dVX+LN7adDrh1zVCDbYWJb9wZp9nX8iabJctxNx/RTR2GvFZPp6Rh+KN8OrgxNQoiQNczID6VCO+1U1SWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t7bQn6Rr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-591c9934e0cso2598547e87.0
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761295256; x=1761900056; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXJW3n3etM05j9RI0cvZZLfNZoThbUxXAjQHh0dGK4w=;
        b=t7bQn6RrXKmo2LCAXENaT2NpuxBfjrJzNSUaeKPokxnjaX2QUv6pyEnZrUomYBSJh0
         xdqaDHtHuF+pOBJlbaZ9e+c9T0JFjKmIPRvn9Uci8ilMZDc2WWnpfQTq5goRenSFUqO4
         bDmM3mmptnQiq7Yx0Z5YxOHAkzTRAglZ/zV0AaU7bCVMpwrBVFfSbZWj9JimlaTOYe43
         lkGzWPT82tfZryh3edZAiq45PQPgaFNh/RaloZZHsjDJCQqJ/dZoObKU4AH8xfqy2fmz
         U0QuBDy4K+KdyE+xCtR0rVg2jQJ+VO9u2Jk9ln2zklG2NANZMZOOZtPH2ckQO/vsSu2G
         w7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295256; x=1761900056;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXJW3n3etM05j9RI0cvZZLfNZoThbUxXAjQHh0dGK4w=;
        b=GW/KW/pev9+fkoENdOqGDDpFqFek3yrMoaJLbHt0bj0y7tr8ULfGSLYCVQTCkQIOXa
         HF/Pt9IjTojYOHMzUM72CmFeJxthmWJ4m3S7YxT81GbRcU0A/XkkPd/8GCf7vAgn9oY7
         KZvNXFPm0kPwrzDmG4ZlFehUIk8PUqbBpdGk42Eswl3X+Ex4+AZJWGAa9XY/OSWYrIli
         WGZH0fhTokFWbnwhdCM6UbqYVDt4isYb1Zx07r5QFgeuADI0KBwdi7UXzub4oO19uS8C
         IrdJnWfTmDt5Cx1dswdQ4Id3fcVvDCmkCADcArDhnGZCRQ+ZkT5F3/laOPlBWqmkre8q
         nuZw==
X-Forwarded-Encrypted: i=1; AJvYcCUFDfougkib6TJkwIVFdmkMJbJip+Uhp5o6+/MinfvmRbyMIp0RzglLAiYWhsKa0NwbQVKbfpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBUSgpw/s4CNaghGT9xU7c6LcWAaaBr0qS/eJbS2MDD3+RduX
	p29Oqvt5M4POCuaHSVF4gXsq+N/EDsyWWu8fxaQulNIHzMbnF84nzUwMNMdrFHF7Dz0=
X-Gm-Gg: ASbGncvaPg7PT0MlVdKYU9EryR26zo4eHWmcbiuFun+WzHbTFU+hS+6XwrENR4KDLEt
	XrtUoV3ugJTbCIPH4Z3D6osOuw3BuN14RqUraaKTxrN07s4zMXMSMnZLLpWDlG4KJCPM6N7iqOl
	sk0ZqD973RybptujxIykUjw0Ze1LggahDNznWer0HhduRitzN55ry/pJ8oeBgAkhfBN9sNfDBc1
	MZbHuTl/zXrjA9C9gh3yQCxsn5ysD7mHO3rL/a0LtegBfuBKW0NqKSyMVVA8iuPVjgEm/SRW+10
	4TjDO+PhXC/6AzhRHuAV/dQ6sHJzqmIviGNOH2ed6rboF5u9igTeOJvkdemyT+7H1yvyOrqVy2P
	Vj35A9iYj2rUVUN0zExwKj6IOwu7SyxphUixeDICTYeGsPX70vLOWBULQrW1lJa2lAaCmLWQSWL
	QA3p2fmDu6uAMC4jtVa9iHSA==
X-Google-Smtp-Source: AGHT+IHZrVDU8LWymqgag5IlKymZCkYIFqwlXx+W2dwjEo7kWQLBkeDvba3FKuiZyFglheFWRSwmnA==
X-Received: by 2002:a05:6512:3ca4:b0:592:fc9c:7ad0 with SMTP id 2adb3069b0e04-592fc9c7b59mr508102e87.21.1761295255684;
        Fri, 24 Oct 2025 01:40:55 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4cd20b7sm1457958e87.31.2025.10.24.01.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:40:55 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 24 Oct 2025 10:40:55 +0200
Subject: [PATCH] mmc: sdhci: Disable bounce buffer on SDIO
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-sdhci-bb-regression-v1-1-b57a3d4dbc9f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJY7+2gC/x2MQQqAMAzAviI9W3DFifoV8aCzbr2otCCC+Henx
 0CSG4xV2KAvblA+xWTfMriygJCmLTLKkhmoIu8qqtGWFATnGZWjsn0+TtS0RME3nXeQy0N5leu
 /DuPzvCt8xRNlAAAA
X-Change-ID: 20251024-sdhci-bb-regression-a26822c56951
To: Michael Garofalo <officialtechflashyt@gmail.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, stable@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

As reported by Michael Garofalo, the b43 WLAN driver request
a strict 64 byte block size because of FIFO limitations.

When the bounce buffer is active, all requests will be coalesced
into bigger (up to 64KB) chunks, which breaks SDIO.

Fix this by checking if we are using an SDIO card, and in that
case do not use the bounce buffer.

Link: https://lore.kernel.org/linux-mmc/20251006013700.2272166-1-officialTechflashYT@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sdhci.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac7e11f37af71fa5a70eb579fd812227b9347f83..c349e5b507b63a5ee9a9dcb08ac95cae6b3d7075 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -650,6 +650,21 @@ static void sdhci_transfer_pio(struct sdhci_host *host)
 	DBG("PIO transfer complete.\n");
 }
 
+static bool sdhci_use_bounce_buffer(struct sdhci_host *host)
+{
+	/*
+	 * Don't bounce SDIO messages: these need the block size
+	 * to be strictly respected (FIFOs in the device).
+	 */
+	if (mmc_card_sdio(host->mmc->card))
+		return false;
+
+	if (host->bounce_buffer)
+		return true;
+
+	return false;
+}
+
 static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 				  struct mmc_data *data, int cookie)
 {
@@ -663,7 +678,7 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 		return data->sg_count;
 
 	/* Bounce write requests to the bounce buffer */
-	if (host->bounce_buffer) {
+	if (sdhci_use_bounce_buffer(host)) {
 		unsigned int length = data->blksz * data->blocks;
 
 		if (length > host->bounce_buffer_size) {
@@ -890,7 +905,7 @@ static void sdhci_set_adma_addr(struct sdhci_host *host, dma_addr_t addr)
 
 static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
 {
-	if (host->bounce_buffer)
+	if (sdhci_use_bounce_buffer(host))
 		return host->bounce_addr;
 	else
 		return sg_dma_address(host->data->sg);
@@ -3030,7 +3045,7 @@ static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 	 * for that we would need two bounce buffers since one buffer is
 	 * in flight when this is getting called.
 	 */
-	if (host->flags & SDHCI_REQ_USE_DMA && !host->bounce_buffer)
+	if (host->flags & SDHCI_REQ_USE_DMA && !sdhci_use_bounce_buffer(host))
 		sdhci_pre_dma_transfer(host, mrq->data, COOKIE_PRE_MAPPED);
 }
 
@@ -3104,7 +3119,7 @@ void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq)
 	struct mmc_data *data = mrq->data;
 
 	if (data && data->host_cookie == COOKIE_MAPPED) {
-		if (host->bounce_buffer) {
+		if (sdhci_use_bounce_buffer(host)) {
 			/*
 			 * On reads, copy the bounced data into the
 			 * sglist

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251024-sdhci-bb-regression-a26822c56951

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


