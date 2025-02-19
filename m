Return-Path: <stable+bounces-116945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDE3A3AF47
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 03:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA67E3A7A59
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 02:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9376026;
	Wed, 19 Feb 2025 02:07:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997E2AD0C;
	Wed, 19 Feb 2025 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930848; cv=none; b=rNkLln9PeF0aGnRSrGhdYFQ9yCP1JHxW6q2pXiYKZ37IH7DNIfdIhdZKqXoO6b/zWxW3JzOO/P1vBef0KEMr4sQ39ySMX92WCYxPSvx4fj2d1uf2Md30i2ARZWrxpdGJwYStWJvvm9GKjuAosfaqpDnNys+tSCHB3858C3yI98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930848; c=relaxed/simple;
	bh=eH5O8KaYYXSUFfUViuNUADyVTtGUD5lDV/wqTK/e2Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvO+ZFfVY5rclGGSZ29vaJOhUrIEE5Gu8DI2VwVGe1MvMPK2epYxE5dIT8bLlVTHm70EtRGV4ecPLQnofFkxhhXWU1iN0GmyTYjkOXNG/iq7HJzQtLdGp98LqWKme7mWlJ0H9wZ2ImbAGiqJIYwEVq8ADpWg7BxGRNyIEmELqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8AxaeHaPLVnn3R6AA--.36439S3;
	Wed, 19 Feb 2025 10:07:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMBxn8XYPLVnP1UbAA--.38364S2;
	Wed, 19 Feb 2025 10:07:21 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: chenhuacai@kernel.org,
	si.yanteng@linux.dev,
	fancer.lancer@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH net V3] net: stmmac: dwmac-loongson: Add fix_soc_reset() callback
Date: Wed, 19 Feb 2025 10:07:01 +0800
Message-Id: <20250219020701.15139-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxn8XYPLVnP1UbAA--.38364S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1Uuw47GF18Xw15uFWDZFc_yoW8uw15pr
	43Aa4agrySqrySyan8ArZ8AFyrurWrKrsrWFWIywna9a9Yya4jqrWYqFWYkr47CrWkKF13
	ZFyjkr18uF1DC3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

Loongson's DWMAC device may take nearly two seconds to complete DMA reset,
however, the default waiting time for reset is 200 milliseconds.
Therefore, the following error message may appear:

[14.427169] dwmac-loongson-pci 0000:00:03.2: Failed to reset the dma

Fixes: 803fc61df261 ("net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
v3: Added "Cc: stable@vger.kernel.org" tag.
    Added error message to commit message.

v2: Added comments. Changed callback name to loongson_dwmac_fix_reset.

 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index bfe6e2d631bd..f5acfb7d4ff6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -516,6 +516,19 @@ static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
 	return 0;
 }
 
+/* Loongson's DWMAC device may take nearly two seconds to complete DMA reset */
+static int loongson_dwmac_fix_reset(void *priv, void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr + DMA_BUS_MODE);
+
+	value |= DMA_BUS_MODE_SFT_RESET;
+	writel(value, ioaddr + DMA_BUS_MODE);
+
+	return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
+				  !(value & DMA_BUS_MODE_SFT_RESET),
+				  10000, 2000000);
+}
+
 static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct plat_stmmacenet_data *plat;
@@ -566,6 +579,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	plat->bsp_priv = ld;
 	plat->setup = loongson_dwmac_setup;
+	plat->fix_soc_reset = loongson_dwmac_fix_reset;
 	ld->dev = &pdev->dev;
 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
 

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.43.0


