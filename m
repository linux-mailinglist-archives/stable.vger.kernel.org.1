Return-Path: <stable+bounces-138964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC51AA3D24
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5AA188754D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562912DAF95;
	Tue, 29 Apr 2025 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/wDWzzX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A652DAF88;
	Tue, 29 Apr 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970622; cv=none; b=F1JZ20wh5kj0gdoGdwntrHDcI1uH7nBEdkilQl0LyuuVAJE7YGHVhd+kirrxyACX5OHjRu7rd/Q5hbzn7mExpXkyDL2vFOH0XUux2ebTRR4XRMYNTp42Ri99jD+FsQQ3vpym2xBQTN10ZKgARDF1+Sf5fnJtyh/DCIeIKOjTvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970622; c=relaxed/simple;
	bh=CAdi08RiNenFcq0C/quHTapGbgDaCIUTxSFZYUZ3nS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/p9agI3basmchbpE0MuqfQFL6/t6/oq0RfvpkVrFaZ84/X1Dl6m7vyKrmAvrI59+7FQcfzhHNcSq+nlyizOYgsy26kdGGrmmSwh8Q3qkIQZtYbqh8ohAIEQUDNNghVcvBpUx1MsVf1xYx+Gz9bAez1uP8sK6SnKdEHsMw4wAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/wDWzzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD478C4CEED;
	Tue, 29 Apr 2025 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970621;
	bh=CAdi08RiNenFcq0C/quHTapGbgDaCIUTxSFZYUZ3nS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/wDWzzXukoL6DuYifCdhfjT1KyU0LF/uhGsgzb2Y+6GyRZThhTafFsCX0pMLq5Bn
	 8S+AtedhUKbq2w16No7oA0idG3gyZA40BbRD+ZmqJloUdYs4FVqmjmU9PozH9wqAV5
	 E3zr3/kpk21GpR8IUPV4u2IFP2Imla0AW7q0qC1ifxwMApCjW86HICVCapjaeg4NcD
	 Fh9tRRYRGpnt6H0x0q6fo9V3U6/y+SMeZqWlID9kS1eaidmCzY2Z6QLEsuCYiFGdLh
	 lnprzsA/kAw4vgRlu+qcxsJ4N+QO+pYCPpphdkzz4jTGmr4tEnRe1CZ1x7n/pLZI0h
	 403WktSB18rbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	srini@kernel.org
Subject: [PATCH AUTOSEL 6.14 08/39] nvmem: qfprom: switch to 4-byte aligned reads
Date: Tue, 29 Apr 2025 19:49:35 -0400
Message-Id: <20250429235006.536648-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 3566a737db87a9bf360c2fd36433c5149f805f2e ]

All platforms since Snapdragon 8 Gen1 (SM8450) require using 4-byte
reads to access QFPROM data. While older platforms were more than happy
with 1-byte reads, change the qfprom driver to use 4-byte reads for all
the platforms. Specify stride and word size of 4 bytes. To retain
compatibility with the existing DT and to simplify porting data from
vendor kernels, use fixup_dt_cell_info in order to bump alignment
requirements.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20250411112251.68002-12-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/qfprom.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 116a39e804c70..a872c640b8c5a 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -321,19 +321,32 @@ static int qfprom_reg_read(void *context,
 			unsigned int reg, void *_val, size_t bytes)
 {
 	struct qfprom_priv *priv = context;
-	u8 *val = _val;
-	int i = 0, words = bytes;
+	u32 *val = _val;
 	void __iomem *base = priv->qfpcorrected;
+	int words = DIV_ROUND_UP(bytes, sizeof(u32));
+	int i;
 
 	if (read_raw_data && priv->qfpraw)
 		base = priv->qfpraw;
 
-	while (words--)
-		*val++ = readb(base + reg + i++);
+	for (i = 0; i < words; i++)
+		*val++ = readl(base + reg + i * sizeof(u32));
 
 	return 0;
 }
 
+/* Align reads to word boundary */
+static void qfprom_fixup_dt_cell_info(struct nvmem_device *nvmem,
+				      struct nvmem_cell_info *cell)
+{
+	unsigned int byte_offset = cell->offset % sizeof(u32);
+
+	cell->bit_offset += byte_offset * BITS_PER_BYTE;
+	cell->offset -= byte_offset;
+	if (byte_offset && !cell->nbits)
+		cell->nbits = cell->bytes * BITS_PER_BYTE;
+}
+
 static void qfprom_runtime_disable(void *data)
 {
 	pm_runtime_disable(data);
@@ -358,10 +371,11 @@ static int qfprom_probe(struct platform_device *pdev)
 	struct nvmem_config econfig = {
 		.name = "qfprom",
 		.add_legacy_fixed_of_cells = true,
-		.stride = 1,
-		.word_size = 1,
+		.stride = 4,
+		.word_size = 4,
 		.id = NVMEM_DEVID_AUTO,
 		.reg_read = qfprom_reg_read,
+		.fixup_dt_cell_info = qfprom_fixup_dt_cell_info,
 	};
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-- 
2.39.5


