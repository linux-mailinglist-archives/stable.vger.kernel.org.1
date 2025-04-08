Return-Path: <stable+bounces-131019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CA4A8080A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C12A8A68C4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712C26B0B8;
	Tue,  8 Apr 2025 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="VnEYWnMc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617326B2A1
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115273; cv=none; b=ayetWHBUb/rl81duTvXHI3MFW2stSXR7XAkJ5qfDPPTUo6LdINdfTvp8HM27kfUART0L6pzOfaglRERqOW1+lPr7VhV3sr6fKmJKDX83rJCwfD5bEhKZJYdr+jVKP7dKVf0aw/Rai9DvQpl8VbWoA5m2GhPRH8a53y4o3xf+KZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115273; c=relaxed/simple;
	bh=8tfHHXERWhavjGCyhOM4p0iFR+kjj42nA12sUQ42u/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=is09OMkfL3KQC8KNH2wQRkw20l5BEG83I2uidZ7yjV0BOlaMLeSub72Fdt+9P27PgkgC87IV+eJGxfCciibPvi2VVNPP01wOMBTVzRpAQxm3dA2mxUd7hrI3fcDykCeWBPoSpnDiVIpRgmLkUXLYIKjA0SvBUyi05KhbFAGUjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=VnEYWnMc; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2264aefc45dso68654055ad.0
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1744115271; x=1744720071; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=InQm/PelFnrcLOtT9tGevwdgylg6sFypDuFX42y1sJE=;
        b=VnEYWnMctqUAD4yf6WX37dUqqWWcK7D0qRw9E1e6Q3eLBOZWgdmGRMyjtSU/4veHfc
         O3uFfunqbneV/ZRqfAK9R6HxeGZWa119ovdL4NzodZzagmgtF+Q5z2hFa0RM9jjtBCOj
         GSTM7YInS3fgCJ8eoOd6EfsDHRWj6exPJgB2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744115271; x=1744720071;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InQm/PelFnrcLOtT9tGevwdgylg6sFypDuFX42y1sJE=;
        b=UX1AgFZBVHQ1zmGVLbzYgKZUF7Ic9KBTNMB1fYQPHCv/j5MIxJnB6KUNjiPo02/cFR
         wB+8k3BGSE/eAdlTlUar37CLqQoLUvQAgfMu1BYjB5KIlZz+uv96JFgv9t4mb6/2ZgDh
         +MsEO+Wum5lE2yMt4ITEVec7y4qZcPUrvi4deQ9nB2d7VEf+MeMNeYjozMT7icszb0y8
         41fzbNDbZseRucWa03/HQ5SO18Zd1uoG80Cdcqu2zJVdAirGs0wAj3HAN3Uppqnf7Oqb
         l66oFOjBSnvl1JEnbPozlhmyf7O9EVHjp9mJV7LslzdGYW75tWIQGE0RM2bbY1GbwgV9
         SWKQ==
X-Gm-Message-State: AOJu0Ywpgnk/xyoLCTyJb7ib2LFSSkhKdgeYMoMRD3YJ3e7Ewpqn8ne9
	nefTvYK3SxvDeTEMQfQ8seqhhe57nld1ue+Ma/YM8yKBGGQAduJ98ljYPxCescfrwBP3KBF0ZwH
	yjYjAtQ==
X-Gm-Gg: ASbGncvSTEwwquQdCFYFMy5qwQK3MRjU/HV5lb1NXgi16HY7or1ZQLLf9SESjEMxWmg
	dYzNWwPrCpi5P1FAu2GSDVWQNeNlVNUhITrY4UpOhbQVcNuC5+/XrIi9FzqBBRdD0tcGhSx2aze
	RvcehFi3yrNK+QEAKX00iGOvxdZc4TrmBKxEBOqhcgyUN3ogHycP5Qag+QPNcBVxuFAu/kgMSBa
	dpqs8O68PEZHP7/UTMimC+Jb0FSg8J+V1AzIf889NmbzkQsW/t0sSaG1yKirwneF//zleZ6mvvl
	LpWf5Xrn5Oe7Z6xD/5XSCuZtEpqZOOcq4qMq/qzfSOxg8w==
X-Google-Smtp-Source: AGHT+IGiGHwlOWueoKXcrBUnmOqsmzDLiFGpTiJyt3EMWpX/S2j2FZkU4FFGo0MfCD45ZkozDW3oTQ==
X-Received: by 2002:a17:902:f541:b0:223:536d:f67b with SMTP id d9443c01a7336-22a8a8b7938mr244867565ad.38.1744115271214;
        Tue, 08 Apr 2025 05:27:51 -0700 (PDT)
Received: from jupiter.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785bfe40sm98762625ad.72.2025.04.08.05.27.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Apr 2025 05:27:50 -0700 (PDT)
From: Hardik Gohil <hgohil@mvista.com>
To: stable@vger.kernel.org
Cc: christophe.kerello@foss.st.com,
	sashal@kernel.org,
	ulf.hansson@linaro.org
Subject: [PATCH 2/2] mmc: mmci: stm32: fix DMA API overlapping mappings warning
Date: Tue,  8 Apr 2025 17:57:21 +0530
Message-Id: <1744115241-28452-2-git-send-email-hgohil@mvista.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1744115241-28452-1-git-send-email-hgohil@mvista.com>
References: <1744115241-28452-1-git-send-email-hgohil@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Christophe Kerello <christophe.kerello@foss.st.com>

[ Upstream commit 6b1ba3f9040be5efc4396d86c9752cdc564730be ]

Turning on CONFIG_DMA_API_DEBUG_SG results in the following warning:

DMA-API: mmci-pl18x 48220000.mmc: cacheline tracking EEXIST,
overlapping mappings aren't supported
WARNING: CPU: 1 PID: 51 at kernel/dma/debug.c:568
add_dma_entry+0x234/0x2f4
Modules linked in:
CPU: 1 PID: 51 Comm: kworker/1:2 Not tainted 6.1.28 #1
Hardware name: STMicroelectronics STM32MP257F-EV1 Evaluation Board (DT)
Workqueue: events_freezable mmc_rescan
Call trace:
add_dma_entry+0x234/0x2f4
debug_dma_map_sg+0x198/0x350
__dma_map_sg_attrs+0xa0/0x110
dma_map_sg_attrs+0x10/0x2c
sdmmc_idma_prep_data+0x80/0xc0
mmci_prep_data+0x38/0x84
mmci_start_data+0x108/0x2dc
mmci_request+0xe4/0x190
__mmc_start_request+0x68/0x140
mmc_start_request+0x94/0xc0
mmc_wait_for_req+0x70/0x100
mmc_send_tuning+0x108/0x1ac
sdmmc_execute_tuning+0x14c/0x210
mmc_execute_tuning+0x48/0xec
mmc_sd_init_uhs_card.part.0+0x208/0x464
mmc_sd_init_card+0x318/0x89c
mmc_attach_sd+0xe4/0x180
mmc_rescan+0x244/0x320

DMA API debug brings to light leaking dma-mappings as dma_map_sg and
dma_unmap_sg are not correctly balanced.

If an error occurs in mmci_cmd_irq function, only mmci_dma_error
function is called and as this API is not managed on stm32 variant,
dma_unmap_sg is never called in this error path.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240207143951.938144-1-christophe.kerello@foss.st.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index cab3a52..dd52546 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -175,6 +175,8 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 	struct scatterlist *sg;
 	int i;
 
+	host->dma_in_progress = true;
+
 	if (!host->variant->dma_lli || data->sg_len == 1 ||
 	    idma->use_bounce_buffer) {
 		u32 dma_addr;
@@ -213,9 +215,30 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 	return 0;
 }
 
+static void sdmmc_idma_error(struct mmci_host *host)
+{
+	struct mmc_data *data = host->data;
+	struct sdmmc_idma *idma = host->dma_priv;
+
+	if (!dma_inprogress(host))
+		return;
+
+	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+	host->dma_in_progress = false;
+	data->host_cookie = 0;
+
+	if (!idma->use_bounce_buffer)
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+}
+
 static void sdmmc_idma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
+	if (!dma_inprogress(host))
+		return;
+
 	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+	host->dma_in_progress = false;
 
 	if (!data->host_cookie)
 		sdmmc_idma_unprep_data(host, data, 0);
@@ -347,6 +370,7 @@ static struct mmci_host_ops sdmmc_variant_ops = {
 	.dma_setup = sdmmc_idma_setup,
 	.dma_start = sdmmc_idma_start,
 	.dma_finalize = sdmmc_idma_finalize,
+	.dma_error = sdmmc_idma_error,
 	.set_clkreg = mmci_sdmmc_set_clkreg,
 	.set_pwrreg = mmci_sdmmc_set_pwrreg,
 };
-- 
2.7.4


