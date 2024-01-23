Return-Path: <stable+bounces-13220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC76837B4E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6189B2E9CE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C321487E7;
	Tue, 23 Jan 2024 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TF8uFnZ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415131487E6;
	Tue, 23 Jan 2024 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969159; cv=none; b=Q/rHwv9pIZYyg5gHJDVCOH2AkXznA+TXUuhQ0Dg40FMpz7yXX2vpBpqvZ6gATbj7Fm6t+hMvg6nApkGQpwHnPNZ9Qq9u4vEaYXXh8bb5OPUELrePNa2ys2rarXDfFd6xAkzBymL3CfofCvmajJkTxF60qpN1KGfgs/4f6B55f1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969159; c=relaxed/simple;
	bh=9ogwh6bVYcdPmgBoFpJSGihdN0dWbvDmYx5fv1kVD3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUo7mQ9FRfzkTBMnhO67z7NG/EMB0tZ3MbE5nHdO8lkrHiwcNx4pX7CMFo/PDQzRVhzC3198B9q95a0Wd/r6v0BcxQAg9jfMsEmFUSVGWvgC8GGzuirsOMkCosj4ofZ0PQ6y5RzqwOwK+n2INx7pnab+RMOKD2ISzO82tvkPMh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TF8uFnZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07626C43394;
	Tue, 23 Jan 2024 00:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969159;
	bh=9ogwh6bVYcdPmgBoFpJSGihdN0dWbvDmYx5fv1kVD3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TF8uFnZ/60vxvjlgwYwWSzr+aURtBDORjlMcCO76chfn6+3z/ZYsFOSHRvHeEIyeP
	 KkYowrtdWVzqNZRIKa5YVhy6yffq7M+dEaObIXTlqZMMZCVa+s2pH+t1Qdw9MlrkPp
	 YhLF20seEGgzRB+tQ5omQpBod6FHOyEaQb47BX9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 063/641] crypto: hisilicon/zip - add zip comp high perf mode configuration
Date: Mon, 22 Jan 2024 15:49:27 -0800
Message-ID: <20240122235820.027021976@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenghai Huang <huangchenghai2@huawei.com>

[ Upstream commit a9864bae1806499ebf3757a9e71dddde5b9c48c6 ]

To meet specific application scenarios, the function of switching between
the high performance mode and the high compression mode is added.

Use the perf_mode=0/1 configuration to set the compression high perf mode,
0(default, high compression mode), 1(high performance mode). These two
modes only apply to the compression direction and are compatible with
software algorithm in both directions.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: cf8b5156bbc8 ("crypto: hisilicon/hpre - save capability registers in probe process")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 65 +++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index db4c964cd649..85576f818278 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -107,6 +107,14 @@
 #define HZIP_CLOCK_GATED_EN		(HZIP_CORE_GATED_EN | \
 					 HZIP_CORE_GATED_OOO_EN)
 
+/* zip comp high performance */
+#define HZIP_HIGH_PERF_OFFSET		0x301208
+
+enum {
+	HZIP_HIGH_COMP_RATE,
+	HZIP_HIGH_COMP_PERF,
+};
+
 static const char hisi_zip_name[] = "hisi_zip";
 static struct dentry *hzip_debugfs_root;
 
@@ -352,6 +360,37 @@ static int hzip_diff_regs_show(struct seq_file *s, void *unused)
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(hzip_diff_regs);
+
+static int perf_mode_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+	u32 n;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = kstrtou32(val, 10, &n);
+	if (ret != 0 || (n != HZIP_HIGH_COMP_PERF &&
+			 n != HZIP_HIGH_COMP_RATE))
+		return -EINVAL;
+
+	return param_set_int(val, kp);
+}
+
+static const struct kernel_param_ops zip_com_perf_ops = {
+	.set = perf_mode_set,
+	.get = param_get_int,
+};
+
+/*
+ * perf_mode = 0 means enable high compression rate mode,
+ * perf_mode = 1 means enable high compression performance mode.
+ * These two modes only apply to the compression direction.
+ */
+static u32 perf_mode = HZIP_HIGH_COMP_RATE;
+module_param_cb(perf_mode, &zip_com_perf_ops, &perf_mode, 0444);
+MODULE_PARM_DESC(perf_mode, "ZIP high perf mode 0(default), 1(enable)");
+
 static const struct kernel_param_ops zip_uacce_mode_ops = {
 	.set = uacce_mode_set,
 	.get = param_get_int,
@@ -417,6 +456,28 @@ bool hisi_zip_alg_support(struct hisi_qm *qm, u32 alg)
 	return false;
 }
 
+static int hisi_zip_set_high_perf(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	val = readl_relaxed(qm->io_base + HZIP_HIGH_PERF_OFFSET);
+	if (perf_mode == HZIP_HIGH_COMP_PERF)
+		val |= HZIP_HIGH_COMP_PERF;
+	else
+		val &= ~HZIP_HIGH_COMP_PERF;
+
+	/* Set perf mode */
+	writel(val, qm->io_base + HZIP_HIGH_PERF_OFFSET);
+	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_HIGH_PERF_OFFSET,
+					 val, val == perf_mode, HZIP_DELAY_1_US,
+					 HZIP_POLL_TIMEOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to set perf mode\n");
+
+	return ret;
+}
+
 static int hisi_zip_set_qm_algs(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
@@ -1115,6 +1176,10 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 	if (ret)
 		return ret;
 
+	ret = hisi_zip_set_high_perf(qm);
+	if (ret)
+		return ret;
+
 	hisi_zip_open_sva_prefetch(qm);
 	hisi_qm_dev_err_init(qm);
 	hisi_zip_debug_regs_clear(qm);
-- 
2.43.0




