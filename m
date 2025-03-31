Return-Path: <stable+bounces-127231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07B4A76A28
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B01164378
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41DD221DA2;
	Mon, 31 Mar 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLgwAJf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E820245023;
	Mon, 31 Mar 2025 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432995; cv=none; b=SHu7juvhQKIfkHHLsffdDgPYn/mihE3kMxOfinLCgoSubehpm+Vr22ffY6MDwTyWJc9ryKoDXo8yIunXsUAk0TQ7KCfHKCsfb6h/ATFOHXLmmKb3qDssFwMQHheGaPfn18hENSPGfrxmvN4rZv9lQu1N11YoF9kTQUmPVStv3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432995; c=relaxed/simple;
	bh=lA+QaQljiQesUN59WH5UKZFP3SkaRVPB8jSliZS6XzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=npJxyevyPV7z+MyS9rTHhcav0j+svmSitKFK89GaSzsIcZcMAWTpRUKSwa37q4fXtstpmM1b1VRlvk3u1NnDzEpAS6fNsvGJjiYN9ivbEQUIUeeh26EuLFqenJEdCMgfdSifDXN2iQJJXP+ne1wEDmtc50GWJ8llbOP/1GhYnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLgwAJf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D84BC4CEE9;
	Mon, 31 Mar 2025 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432994;
	bh=lA+QaQljiQesUN59WH5UKZFP3SkaRVPB8jSliZS6XzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLgwAJf9MavdkWCw9WlAoTKovSHpNwTBHsazeGaCFzM2kfjjHML+i3hoB0bKiop7o
	 XbXjTtsfoz9QPsAUTb51otaMwLmIoQzaAwjJ+AxxZtdT8PFU3Db/cfUZMEKnUg5Y5I
	 6OP/WA+RqVz2URLtHqjwDs2VGzNYf81+APGYXleaN5EYLF/xMXEAVjNZGDkfIK8Zls
	 pP20NcsE1SBgKvuxUhhDM1ZeNEAWV+kapBSFG46LSB3aiXT5iNcde7f3Kk2JQmO5T0
	 jiWnP9zDi2Peyih8xi70X79qGKc8yu7LATXKLNXzhbObwIc4ENAb2AXZmKQ/VMBIV3
	 RsjviSiAcm/og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	jh80.chung@samsung.com,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/19] mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves
Date: Mon, 31 Mar 2025 10:55:57 -0400
Message-Id: <20250331145601.1705784-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145601.1705784-1-sashal@kernel.org>
References: <20250331145601.1705784-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Kaustabh Chakraborty <kauschluss@disroot.org>

[ Upstream commit 57c0902f8bec51add5a1eb908d8b876592725d81 ]

In certain DW MMC implementations (such as in some Exynos7870
controllers), 64-bit read/write is not allowed from a 64-bit FIFO.
Add a quirk which facilitates accessing the 64-bit FIFO registers in two
32-bit halves.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Link: https://lore.kernel.org/r/20250219-exynos7870-mmc-v2-2-b4255a3e39ed@disroot.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/dw_mmc.c | 94 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/dw_mmc.h | 27 +++++++++++
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 02bee7afab37e..f97caaa829f70 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2574,6 +2574,91 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
 	}
 }
 
+static void dw_mci_push_data64_32(struct dw_mci *host, void *buf, int cnt)
+{
+	struct mmc_data *data = host->data;
+	int init_cnt = cnt;
+
+	/* try and push anything in the part_buf */
+	if (unlikely(host->part_buf_count)) {
+		int len = dw_mci_push_part_bytes(host, buf, cnt);
+
+		buf += len;
+		cnt -= len;
+
+		if (host->part_buf_count == 8) {
+			mci_fifo_l_writeq(host->fifo_reg, host->part_buf);
+			host->part_buf_count = 0;
+		}
+	}
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (unlikely((unsigned long)buf & 0x7)) {
+		while (cnt >= 8) {
+			u64 aligned_buf[16];
+			int len = min(cnt & -8, (int)sizeof(aligned_buf));
+			int items = len >> 3;
+			int i;
+			/* memcpy from input buffer into aligned buffer */
+			memcpy(aligned_buf, buf, len);
+			buf += len;
+			cnt -= len;
+			/* push data from aligned buffer into fifo */
+			for (i = 0; i < items; ++i)
+				mci_fifo_l_writeq(host->fifo_reg, aligned_buf[i]);
+		}
+	} else
+#endif
+	{
+		u64 *pdata = buf;
+
+		for (; cnt >= 8; cnt -= 8)
+			mci_fifo_l_writeq(host->fifo_reg, *pdata++);
+		buf = pdata;
+	}
+	/* put anything remaining in the part_buf */
+	if (cnt) {
+		dw_mci_set_part_bytes(host, buf, cnt);
+		/* Push data if we have reached the expected data length */
+		if ((data->bytes_xfered + init_cnt) ==
+		    (data->blksz * data->blocks))
+			mci_fifo_l_writeq(host->fifo_reg, host->part_buf);
+	}
+}
+
+static void dw_mci_pull_data64_32(struct dw_mci *host, void *buf, int cnt)
+{
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	if (unlikely((unsigned long)buf & 0x7)) {
+		while (cnt >= 8) {
+			/* pull data from fifo into aligned buffer */
+			u64 aligned_buf[16];
+			int len = min(cnt & -8, (int)sizeof(aligned_buf));
+			int items = len >> 3;
+			int i;
+
+			for (i = 0; i < items; ++i)
+				aligned_buf[i] = mci_fifo_l_readq(host->fifo_reg);
+
+			/* memcpy from aligned buffer into output buffer */
+			memcpy(buf, aligned_buf, len);
+			buf += len;
+			cnt -= len;
+		}
+	} else
+#endif
+	{
+		u64 *pdata = buf;
+
+		for (; cnt >= 8; cnt -= 8)
+			*pdata++ = mci_fifo_l_readq(host->fifo_reg);
+		buf = pdata;
+	}
+	if (cnt) {
+		host->part_buf = mci_fifo_l_readq(host->fifo_reg);
+		dw_mci_pull_final_bytes(host, buf, cnt);
+	}
+}
+
 static void dw_mci_pull_data(struct dw_mci *host, void *buf, int cnt)
 {
 	int len;
@@ -3374,8 +3459,13 @@ int dw_mci_probe(struct dw_mci *host)
 		width = 16;
 		host->data_shift = 1;
 	} else if (i == 2) {
-		host->push_data = dw_mci_push_data64;
-		host->pull_data = dw_mci_pull_data64;
+		if ((host->quirks & DW_MMC_QUIRK_FIFO64_32)) {
+			host->push_data = dw_mci_push_data64_32;
+			host->pull_data = dw_mci_pull_data64_32;
+		} else {
+			host->push_data = dw_mci_push_data64;
+			host->pull_data = dw_mci_pull_data64;
+		}
 		width = 64;
 		host->data_shift = 3;
 	} else {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 4ed81f94f7cab..af16dbb37f261 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -280,6 +280,8 @@ struct dw_mci_board {
 
 /* Support for longer data read timeout */
 #define DW_MMC_QUIRK_EXTENDED_TMOUT            BIT(0)
+/* Force 32-bit access to the FIFO */
+#define DW_MMC_QUIRK_FIFO64_32                 BIT(1)
 
 #define DW_MMC_240A		0x240a
 #define DW_MMC_280A		0x280a
@@ -471,6 +473,31 @@ struct dw_mci_board {
 #define mci_fifo_writel(__value, __reg)	__raw_writel(__reg, __value)
 #define mci_fifo_writeq(__value, __reg)	__raw_writeq(__reg, __value)
 
+/*
+ * Some dw_mmc devices have 64-bit FIFOs, but expect them to be
+ * accessed using two 32-bit accesses. If such controller is used
+ * with a 64-bit kernel, this has to be done explicitly.
+ */
+static inline u64 mci_fifo_l_readq(void __iomem *addr)
+{
+	u64 ans;
+	u32 proxy[2];
+
+	proxy[0] = mci_fifo_readl(addr);
+	proxy[1] = mci_fifo_readl(addr + 4);
+	memcpy(&ans, proxy, 8);
+	return ans;
+}
+
+static inline void mci_fifo_l_writeq(void __iomem *addr, u64 value)
+{
+	u32 proxy[2];
+
+	memcpy(proxy, &value, 8);
+	mci_fifo_writel(addr, proxy[0]);
+	mci_fifo_writel(addr + 4, proxy[1]);
+}
+
 /* Register access macros */
 #define mci_readl(dev, reg)			\
 	readl_relaxed((dev)->regs + SDMMC_##reg)
-- 
2.39.5


