Return-Path: <stable+bounces-131010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E160A8071D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CA27AEEC2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7B826B093;
	Tue,  8 Apr 2025 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="FVIgvj1C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AECC20330
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115251; cv=none; b=sZ9JfjOj/6NNIm+jJSag+kCxvaSug6xHqYM6eqdOju+iLOyGS5g+aPDysxOc4ZYqtvavMm2GXPeXw0orRKp8/pesPMTJJ7Fof7ZbrERw9FQ9lrIgWzMqA/W10QikwDbGQMf9EZyhYLry0+cz0YSLm3+ZUUdm4SGKsiTulWqo2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115251; c=relaxed/simple;
	bh=7pDXX5qKEpqWR6owJbZ0J2s5gS1nguyi3j8agn/MuKY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ij9tTJDR2HzuSeSOI3wa8+ddQbnIIkhsfmzPQSXyXTeV6Ej++f3OzN7bxyCjg84jcHQCg1nk/B8Ipxzr2JDz2IUWu6KJPWX96DyDwSeeAj4Ph87+PLvm+zNCRgekiZpa/gZJTAi3gmTE6FezZBx7gwfJQdrHH9doOPswTAAeKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=FVIgvj1C; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-22409077c06so66395585ad.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1744115249; x=1744720049; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9r4DUUNNJ+VOtRF5XOf0EAFuamIHUakC9yRXxooLb0=;
        b=FVIgvj1CqRSgKpzWdDdLIrgXGeXrPYk8mf+yqgKaYC29GtXRPkRqGPHUibkZsv3Uvu
         JHlUI9Wrf8YQpxyNJ5JOzSTx8lD1eH0SDE0K0NnNqhX289AAJijfP3/26nam71LQODqS
         T63bmq6Gj9+zwa/dWZEqFq3akmMF5FZ/XDOU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744115249; x=1744720049;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9r4DUUNNJ+VOtRF5XOf0EAFuamIHUakC9yRXxooLb0=;
        b=cKzlduxSJROx0xKlvZdzINwtsBkFkxZgWMbxQqxZX34OwM3tLriOu6SQyc24EgWIH+
         /h9QlVG9a/fwaJ70xmJShoFhFTztTRx46i4TqYbRR44i/qbP8G2eVLHZ+sZLDgqNoCRs
         5DuKRxnG1+neiBMPoPQ0D3DK34aRS/ZMvvNTGWnIsAsyoHkTfIC8rdad6szxtMXr13fR
         dOqK80YD8Kjt5Nk4UOBo/c6QG7ksIrwM5oe30MXTzs5OJMr01dVA0nVCeb02lSV1DJCc
         fY/K5LHUhQBaIijfUpbjUb9s4u2WrGs0PuiFv7zKxTErOv2N4QoI4AZcs/04q4FT7kAg
         6upg==
X-Gm-Message-State: AOJu0YwpVa9jmeXaBFDpaVtyCR2z6ozzdzyTSEWfUGggB7hsBBejMqJ/
	tbcR+WEzZovc/HxXUTwCm4n6JOUM1zeySbSS0Aar77D/0IhCSz8rlA2LupiZi+as8C/8ICLiOao
	gOKpACA==
X-Gm-Gg: ASbGncujwg96WI3tKSw62LlZZtu1Br/UQsaigX91KTPkssLhWHt4eloB0hxhNUnfrjE
	y0VAvHd9Z82iTBBmX/jrjQCkUaYzjBnPmBciJSKmSkJA6MIUbRDPc71/31/gd6q5e9HAlgaw3+Y
	HGEQuZOEO5vBOg//MUmnGz8Adu6GbANsoaEVms6k1TbERtxy9q6tjLmMV6GvV+iX1NHLj/MdUSx
	WBwp2pTFH1oikF9DLy5eYfjh9krPDLEAkyVUWipyNI1GRYYG2dHq/WoC1FngqJPNoOMCnJOvmdI
	PYiXmFJNuzB66+oHc6MeQSP0uU5UzMb//N4M99/j7ttbwA==
X-Google-Smtp-Source: AGHT+IGCLFZ2rEqFf7yxUtFhEq8vAryPSRjYrjWbOyHOs2SflSBGFDsOVVhmB7sRtEOXuY/1/TkXAg==
X-Received: by 2002:a17:902:cec1:b0:21d:dfae:300c with SMTP id d9443c01a7336-22a8a84ecc6mr184094435ad.3.1744115249124;
        Tue, 08 Apr 2025 05:27:29 -0700 (PDT)
Received: from jupiter.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785bfe40sm98762625ad.72.2025.04.08.05.27.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Apr 2025 05:27:28 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: christophe.kerello@foss.st.com,
	sashal@kernel.org,
	ulf.hansson@linaro.org,
	Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 1/2 v5.4.y] mmc: mmci: stm32: use a buffer for unaligned DMA requests
Date: Tue,  8 Apr 2025 17:57:20 +0530
Message-Id: <1744115241-28452-1-git-send-email-hgohil@mvista.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Yann Gautier <yann.gautier@foss.st.com>

[ Upstream commit 970dc9c11a17994ab878016b536612ab00d1441d ]

In SDIO mode, the sg list for requests can be unaligned with what the
STM32 SDMMC internal DMA can support. In that case, instead of failing,
use a temporary bounce buffer to copy from/to the sg list.
This buffer is limited to 1MB. But for that we need to also limit
max_req_size to 1MB. It has not shown any throughput penalties for
SD-cards or eMMC.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
Link: https://lore.kernel.org/r/20220328145114.334577-1-yann.gautier@foss.st.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 6b1ba3f9040b ("mmc: mmci: stm32: fix DMA API overlapping mappings warning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Tested-by: Hardik A Gohil <hgohil@mvista.com>
---
This fix was not backported to v5.4

Patch 1 and Patch 2 there were only line change.

Tested build successfully

dependend patch for this 2 patches
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.235&id=bdbf9faf5f2e6bb0c0243350428c908ac85c16b2

 drivers/mmc/host/mmci_stm32_sdmmc.c | 88 ++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index aa8c0ab..cab3a52 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -23,11 +23,16 @@ struct sdmmc_lli_desc {
 struct sdmmc_idma {
 	dma_addr_t sg_dma;
 	void *sg_cpu;
+	dma_addr_t bounce_dma_addr;
+	void *bounce_buf;
+	bool use_bounce_buffer;
 };
 
 int sdmmc_idma_validate_data(struct mmci_host *host,
 			     struct mmc_data *data)
 {
+	struct sdmmc_idma *idma = host->dma_priv;
+	struct device *dev = mmc_dev(host->mmc);
 	struct scatterlist *sg;
 	int i;
 
@@ -35,41 +40,69 @@ int sdmmc_idma_validate_data(struct mmci_host *host,
 	 * idma has constraints on idmabase & idmasize for each element
 	 * excepted the last element which has no constraint on idmasize
 	 */
+	idma->use_bounce_buffer = false;
 	for_each_sg(data->sg, sg, data->sg_len - 1, i) {
 		if (!IS_ALIGNED(sg->offset, sizeof(u32)) ||
 		    !IS_ALIGNED(sg->length, SDMMC_IDMA_BURST)) {
-			dev_err(mmc_dev(host->mmc),
+			dev_dbg(mmc_dev(host->mmc),
 				"unaligned scatterlist: ofst:%x length:%d\n",
 				data->sg->offset, data->sg->length);
-			return -EINVAL;
+			goto use_bounce_buffer;
 		}
 	}
 
 	if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
-		dev_err(mmc_dev(host->mmc),
+		dev_dbg(mmc_dev(host->mmc),
 			"unaligned last scatterlist: ofst:%x length:%d\n",
 			data->sg->offset, data->sg->length);
-		return -EINVAL;
+		goto use_bounce_buffer;
+	}
+
+	return 0;
+
+use_bounce_buffer:
+	if (!idma->bounce_buf) {
+		idma->bounce_buf = dmam_alloc_coherent(dev,
+						       host->mmc->max_req_size,
+						       &idma->bounce_dma_addr,
+						       GFP_KERNEL);
+		if (!idma->bounce_buf) {
+			dev_err(dev, "Unable to map allocate DMA bounce buffer.\n");
+			return -ENOMEM;
+		}
 	}
 
+	idma->use_bounce_buffer = true;
+
 	return 0;
 }
 
 static int _sdmmc_idma_prep_data(struct mmci_host *host,
 				 struct mmc_data *data)
 {
-	int n_elem;
+	struct sdmmc_idma *idma = host->dma_priv;
 
-	n_elem = dma_map_sg(mmc_dev(host->mmc),
-			    data->sg,
-			    data->sg_len,
-			    mmc_get_dma_dir(data));
+	if (idma->use_bounce_buffer) {
+		if (data->flags & MMC_DATA_WRITE) {
+			unsigned int xfer_bytes = data->blksz * data->blocks;
 
-	if (!n_elem) {
-		dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
-		return -EINVAL;
-	}
+			sg_copy_to_buffer(data->sg, data->sg_len,
+					  idma->bounce_buf, xfer_bytes);
+			dma_wmb();
+		}
+	} else {
+		int n_elem;
 
+		n_elem = dma_map_sg(mmc_dev(host->mmc),
+				    data->sg,
+				    data->sg_len,
+				    mmc_get_dma_dir(data));
+
+		if (!n_elem) {
+			dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
+			return -EINVAL;
+		}
+	}
 	return 0;
 }
 
@@ -86,8 +119,19 @@ static int sdmmc_idma_prep_data(struct mmci_host *host,
 static void sdmmc_idma_unprep_data(struct mmci_host *host,
 				   struct mmc_data *data, int err)
 {
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-		     mmc_get_dma_dir(data));
+	struct sdmmc_idma *idma = host->dma_priv;
+
+	if (idma->use_bounce_buffer) {
+		if (data->flags & MMC_DATA_READ) {
+			unsigned int xfer_bytes = data->blksz * data->blocks;
+
+			sg_copy_from_buffer(data->sg, data->sg_len,
+					    idma->bounce_buf, xfer_bytes);
+		}
+	} else {
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+	}
 }
 
 static int sdmmc_idma_setup(struct mmci_host *host)
@@ -112,6 +156,8 @@ static int sdmmc_idma_setup(struct mmci_host *host)
 		host->mmc->max_segs = SDMMC_LLI_BUF_LEN /
 			sizeof(struct sdmmc_lli_desc);
 		host->mmc->max_seg_size = host->variant->stm32_idmabsize_mask;
+
+		host->mmc->max_req_size = SZ_1M;
 	} else {
 		host->mmc->max_segs = 1;
 		host->mmc->max_seg_size = host->mmc->max_req_size;
@@ -129,8 +175,16 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 	struct scatterlist *sg;
 	int i;
 
-	if (!host->variant->dma_lli || data->sg_len == 1) {
-		writel_relaxed(sg_dma_address(data->sg),
+	if (!host->variant->dma_lli || data->sg_len == 1 ||
+	    idma->use_bounce_buffer) {
+		u32 dma_addr;
+
+		if (idma->use_bounce_buffer)
+			dma_addr = idma->bounce_dma_addr;
+		else
+			dma_addr = sg_dma_address(data->sg);
+
+		writel_relaxed(dma_addr,
 			       host->base + MMCI_STM32_IDMABASE0R);
 		writel_relaxed(MMCI_STM32_IDMAEN,
 			       host->base + MMCI_STM32_IDMACTRLR);
-- 
2.7.4


