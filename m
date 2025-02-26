Return-Path: <stable+bounces-119637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4A9A458F5
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC2016AAD7
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CCD226D17;
	Wed, 26 Feb 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obSQ4zZM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3F226D09;
	Wed, 26 Feb 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559941; cv=none; b=BFGUJ16XHkk3TUbAJkP9iPl/4xnJ8hSAJMJlUhdXKdjR4ky2U2tZAleTqKJbYHfE+e6HqmG/P5Dkmqy3qjXkN8Kxw6WG7FYESAW/JI9gMtzBkAFlqZqCg31mugVlCqPMiH45vECTxqNrqcazgVcu3E+f6mfhUwrWi5lATesFQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559941; c=relaxed/simple;
	bh=+/YStbRSbQvqWX6FrcGaK/ABRAx1YiR43FPrBdwUogA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXOY0xRLVyelFU3rTAIa3XpCd3lnnq/7mNZjGmgafrAxzQ3OnlqVNNJtCKTaps4zawEayDgkcaJjHdg5I2d0Cz1LHWx6QrrUZxE7B1Gu92GpxY1BA3jZA7Er4RtEye2dNouF06R+RQZneao27GVtcv25UyGSEu8rZkLxReul6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obSQ4zZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A407C4CEEB;
	Wed, 26 Feb 2025 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559939;
	bh=+/YStbRSbQvqWX6FrcGaK/ABRAx1YiR43FPrBdwUogA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obSQ4zZMoM8f9+kp4aNKpG6+JTwjXkDNI0nA/ytLMbN1jFMvVMr3+XdGSPen/MgWz
	 WSQ/3zxkwzlQDzUji0uXc9hQcrcoBYMHTZB7EiNUCgiev4sjJgYQTE0MANghEqFclP
	 zbtsxY6Yfkl7yBA1qgifrM8WOjC63qmGk8Z+Kw6pi2n1qIIWMl1EGDTP2Wr7JQ7tk6
	 p+PWqsycEKxoaGq4VzsJ1bwwZlVEZ9d58WoVNK7XJ0nr4kMstZy0Dzmh6sPdbS714m
	 osgJDWAqYTrSioMBQASj/KBYZWOMnw8ABGvUORxbzj4OwAtUSBl4Fl+0Z3nwAJkAS4
	 0nUj0Y7iC5tMw==
From: Philipp Stanner <phasta@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Henry Chen <chenx97@aosc.io>
Subject: [PATCH net-next v4 1/4] stmmac: loongson: Pass correct arg to PCI function
Date: Wed, 26 Feb 2025 09:52:05 +0100
Message-ID: <20250226085208.97891-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226085208.97891-1-phasta@kernel.org>
References: <20250226085208.97891-1-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() should receive the driver's name as its third
parameter, not the PCI device's name.

Define the driver name with a macro and use it at the appropriate
places, including pcim_iomap_regions().

Cc: stable@vger.kernel.org # v5.14+
Fixes: 30bba69d7db4 ("stmmac: pci: Add dwmac support for Loongson")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Tested-by: Henry Chen <chenx97@aosc.io>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index bfe6e2d631bd..73a6715a93e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -11,6 +11,8 @@
 #include "dwmac_dma.h"
 #include "dwmac1000.h"
 
+#define DRIVER_NAME "dwmac-loongson-pci"
+
 /* Normal Loongson Tx Summary */
 #define DMA_INTR_ENA_NIE_TX_LOONGSON	0x00040000
 /* Normal Loongson Rx Summary */
@@ -555,7 +557,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
 			continue;
-		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+		ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
 		if (ret)
 			goto err_disable_device;
 		break;
@@ -673,7 +675,7 @@ static const struct pci_device_id loongson_dwmac_id_table[] = {
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
 
 static struct pci_driver loongson_dwmac_driver = {
-	.name = "dwmac-loongson-pci",
+	.name = DRIVER_NAME,
 	.id_table = loongson_dwmac_id_table,
 	.probe = loongson_dwmac_probe,
 	.remove = loongson_dwmac_remove,
-- 
2.48.1


