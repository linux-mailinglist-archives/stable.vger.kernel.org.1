Return-Path: <stable+bounces-71198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EBE96123D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAEC281EDD
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835C1CDA3F;
	Tue, 27 Aug 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u5ve4y8c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C881C57AB;
	Tue, 27 Aug 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772422; cv=none; b=iAi8HH7leV996keYwSuQ9/xH/pA/z3Ki1M5LvQaZOSNtzjgz3pjII5CuYs18WceIbbpOOmecjxhV3+FVUIIRuPh4KxkOP2kzxbd101niIQtAB2xn/1da1x9QJG2hChODdXGPMtiSCslpo9uEM8y2ZgcA4zrplruMVEx5v9mgyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772422; c=relaxed/simple;
	bh=2g0dmbYt8PYNu4X3vGoD/8gR1E5/4v0rD8jl6/Jcdoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfJPqCVKTbWjaFRmzsZZxCNsKvUepcrqAvxK+y1ywdXic+tEMM7o9m1eXkWc+oBLfWt6KuavK71ybzxH8dhBBW9151w5s4WDcrPFC1WacF3j46SGqkie1zUgM65csujFFDU7E+SgWKqvJW7DJLPTycX4iJxbOpHm/Vgv8ejzUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u5ve4y8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31259C4DE18;
	Tue, 27 Aug 2024 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772422;
	bh=2g0dmbYt8PYNu4X3vGoD/8gR1E5/4v0rD8jl6/Jcdoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5ve4y8cvdRVT91PBc1bAdoas+ST9asE8vqUQ8hEynC4FvBeegx7/ROcYjzwvAiyG
	 jkY6v5ortpACpJK2g9oVERvxrafl8H5WDb1xJZA/TZfilo0T72+rT6qPLNTZsqUfV/
	 QIzl4nwnh/q7WZq7zoBATwF64kTpamsftP5TsiYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Dmitry Osipenko <digetx@gmail.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 211/321] i2c: tegra: allow VI support to be compiled out
Date: Tue, 27 Aug 2024 16:38:39 +0200
Message-ID: <20240827143846.264090215@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

[ Upstream commit 4f5d68c8591498c3955dc0228ed6606c1b138278 ]

Save a bit of code for older Tegra platforms by compiling out
VI's I2C mode support that's used only for Tegra210.

$ size i2c-tegra.o
   text    data     bss     dec     hex filename
  11381     292       8   11681    2da1 i2c-tegra.o (full)
  10193     292       8   10493    28fd i2c-tegra.o (no-dvc)
   9145     292       8    9445    24e5 i2c-tegra.o (no-vi,no-dvc)

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 14d069d92951 ("i2c: tegra: Do not mark ACPI devices as irq safe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-tegra.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index cc9dfd4f6c362..3792531b7ab7f 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -299,6 +299,7 @@ struct tegra_i2c_dev {
 };
 
 #define IS_DVC(dev) (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && (dev)->is_dvc)
+#define IS_VI(dev)  (IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC) && (dev)->is_vi)
 
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
 		       unsigned int reg)
@@ -319,7 +320,7 @@ static u32 tegra_i2c_reg_addr(struct tegra_i2c_dev *i2c_dev, unsigned int reg)
 {
 	if (IS_DVC(i2c_dev))
 		reg += (reg >= I2C_TX_FIFO) ? 0x10 : 0x40;
-	else if (i2c_dev->is_vi)
+	else if (IS_VI(i2c_dev))
 		reg = 0xc00 + (reg << 2);
 
 	return reg;
@@ -332,7 +333,7 @@ static void i2c_writel(struct tegra_i2c_dev *i2c_dev, u32 val, unsigned int reg)
 	/* read back register to make sure that register writes completed */
 	if (reg != I2C_TX_FIFO)
 		readl_relaxed(i2c_dev->base + tegra_i2c_reg_addr(i2c_dev, reg));
-	else if (i2c_dev->is_vi)
+	else if (IS_VI(i2c_dev))
 		readl_relaxed(i2c_dev->base + tegra_i2c_reg_addr(i2c_dev, I2C_INT_STATUS));
 }
 
@@ -448,7 +449,7 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 	u32 *dma_buf;
 	int err;
 
-	if (i2c_dev->is_vi)
+	if (IS_VI(i2c_dev))
 		return 0;
 
 	if (i2c_dev->hw->has_apb_dma) {
@@ -653,7 +654,7 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 	i2c_writel(i2c_dev, val, I2C_CNFG);
 	i2c_writel(i2c_dev, 0, I2C_INT_MASK);
 
-	if (i2c_dev->is_vi)
+	if (IS_VI(i2c_dev))
 		tegra_i2c_vi_init(i2c_dev);
 
 	switch (t->bus_freq_hz) {
@@ -705,7 +706,7 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 		return err;
 	}
 
-	if (!IS_DVC(i2c_dev) && !i2c_dev->is_vi) {
+	if (!IS_DVC(i2c_dev) && !IS_VI(i2c_dev)) {
 		u32 sl_cfg = i2c_readl(i2c_dev, I2C_SL_CNFG);
 
 		sl_cfg |= I2C_SL_CNFG_NACK | I2C_SL_CNFG_NEWSL;
@@ -848,7 +849,7 @@ static int tegra_i2c_fill_tx_fifo(struct tegra_i2c_dev *i2c_dev)
 		i2c_dev->msg_buf_remaining = buf_remaining;
 		i2c_dev->msg_buf = buf + words_to_transfer * BYTES_PER_FIFO_WORD;
 
-		if (i2c_dev->is_vi)
+		if (IS_VI(i2c_dev))
 			i2c_writesl_vi(i2c_dev, buf, I2C_TX_FIFO, words_to_transfer);
 		else
 			i2c_writesl(i2c_dev, buf, I2C_TX_FIFO, words_to_transfer);
@@ -1656,7 +1657,9 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
 static const struct of_device_id tegra_i2c_of_match[] = {
 	{ .compatible = "nvidia,tegra194-i2c", .data = &tegra194_i2c_hw, },
 	{ .compatible = "nvidia,tegra186-i2c", .data = &tegra186_i2c_hw, },
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC)
 	{ .compatible = "nvidia,tegra210-i2c-vi", .data = &tegra210_i2c_hw, },
+#endif
 	{ .compatible = "nvidia,tegra210-i2c", .data = &tegra210_i2c_hw, },
 	{ .compatible = "nvidia,tegra124-i2c", .data = &tegra124_i2c_hw, },
 	{ .compatible = "nvidia,tegra114-i2c", .data = &tegra114_i2c_hw, },
@@ -1683,7 +1686,8 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
 	    of_device_is_compatible(np, "nvidia,tegra20-i2c-dvc"))
 		i2c_dev->is_dvc = true;
 
-	if (of_device_is_compatible(np, "nvidia,tegra210-i2c-vi"))
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC) &&
+	    of_device_is_compatible(np, "nvidia,tegra210-i2c-vi"))
 		i2c_dev->is_vi = true;
 }
 
@@ -1712,7 +1716,7 @@ static int tegra_i2c_init_clocks(struct tegra_i2c_dev *i2c_dev)
 	if (i2c_dev->hw == &tegra20_i2c_hw || i2c_dev->hw == &tegra30_i2c_hw)
 		i2c_dev->clocks[i2c_dev->nclocks++].id = "fast-clk";
 
-	if (i2c_dev->is_vi)
+	if (IS_VI(i2c_dev))
 		i2c_dev->clocks[i2c_dev->nclocks++].id = "slow";
 
 	err = devm_clk_bulk_get(i2c_dev->dev, i2c_dev->nclocks,
@@ -1830,7 +1834,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	 * VI I2C device shouldn't be marked as IRQ-safe because VI I2C won't
 	 * be used for atomic transfers.
 	 */
-	if (!i2c_dev->is_vi)
+	if (!IS_VI(i2c_dev))
 		pm_runtime_irq_safe(i2c_dev->dev);
 
 	pm_runtime_enable(i2c_dev->dev);
@@ -1903,7 +1907,7 @@ static int __maybe_unused tegra_i2c_runtime_resume(struct device *dev)
 	 * power ON/OFF during runtime PM resume/suspend, meaning that
 	 * controller needs to be re-initialized after power ON.
 	 */
-	if (i2c_dev->is_vi) {
+	if (IS_VI(i2c_dev)) {
 		err = tegra_i2c_init(i2c_dev);
 		if (err)
 			goto disable_clocks;
-- 
2.43.0




