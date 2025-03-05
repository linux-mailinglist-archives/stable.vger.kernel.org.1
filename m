Return-Path: <stable+bounces-121031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 203AEA50989
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F841658C3
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0013254AFD;
	Wed,  5 Mar 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UI4oLdsu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5C254AF3;
	Wed,  5 Mar 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198680; cv=none; b=n9MXCcv75nDgCgN7Abs0ewgzf55veRqNccdry2phPmOpQx6+Nsj/NMVeK9BcZz71I+xjKa5sTpvkJoQqbq7dllBiYZnRFGoKVZV2rofDjsoRTXWDFszdKerDVuB8GJSmQ+uf86Ld9r/0naOQ2SGejQ0ASr9RKMqL8m3n6Z2mEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198680; c=relaxed/simple;
	bh=Zsmr1Xewnvu3jbT2D5rnkWceTZD3tMTonPDH6owNeg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHPHdqlJE47ZE4xhEl73xOIYFYRKBErChsvj0IZQ6ON2zbsj3erMR158ELS6niMvfJZ8oVfSiWKnye09W5D7VS9FPTfkpZRP40AcdyR4a5W59LJNluLI6+uH6ZrPUBx62xzpWkAuaTtQqYN+ojM0kO92eZpwpFq9JwNAOIJwA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UI4oLdsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DA5C4CED1;
	Wed,  5 Mar 2025 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198680;
	bh=Zsmr1Xewnvu3jbT2D5rnkWceTZD3tMTonPDH6owNeg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UI4oLdsuR1lcOIxCtuJkvQhXiE+M484Pxd+Y05fi3cEGhSaaVFT20CkCITk22FC4D
	 OO7P0afxhrhbgyJ6Yw3vrH1oYt9EJlRiMXVdRWE8p/gcMIS9BznWYGBu7vA/w8bpgZ
	 i9PdCT4BFX9DbtgYsgLExSMYlfEs9fxBMg769VDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.13 111/157] net: stmmac: dwmac-loongson: Add fix_soc_reset() callback
Date: Wed,  5 Mar 2025 18:49:07 +0100
Message-ID: <20250305174509.774475992@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qunqin Zhao <zhaoqunqin@loongson.cn>

commit f06e4bfd010faefa637689d2df2c727dbf6e1d27 upstream.

Loongson's DWMAC device may take nearly two seconds to complete DMA reset,
however, the default waiting time for reset is 200 milliseconds.
Therefore, the following error message may appear:

[14.427169] dwmac-loongson-pci 0000:00:03.2: Failed to reset the dma

Fixes: 803fc61df261 ("net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Yanteng Si <si.yanteng@linux.dev>
Link: https://patch.msgid.link/20250219020701.15139-1-zhaoqunqin@loongson.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -516,6 +516,19 @@ static int loongson_dwmac_acpi_config(st
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
@@ -566,6 +579,7 @@ static int loongson_dwmac_probe(struct p
 
 	plat->bsp_priv = ld;
 	plat->setup = loongson_dwmac_setup;
+	plat->fix_soc_reset = loongson_dwmac_fix_reset;
 	ld->dev = &pdev->dev;
 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
 



