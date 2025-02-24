Return-Path: <stable+bounces-118935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DDDA42224
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE90189D370
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1E25485D;
	Mon, 24 Feb 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPbo1OhM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FEB252904;
	Mon, 24 Feb 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405217; cv=none; b=bWFLaJ3RzvoIQG/tDZdQqw+9wkvZOhuoZfDs3/54ihM8eWJRadztNa33wCqmik+nXphDGxJky6i5/HP7PGKqNEkJdjOMA1s6GgoQzj3gPIK80MBLb3IilAsIFjR1FIgS0tLi1gus1/vPbKHIUN3XDBPE11eJ8DhV/w6zabyc+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405217; c=relaxed/simple;
	bh=6P8m8bVx+JzTIQzT+IMsyVq8vQFZmn0P+wFQph1uxrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2r8eLFfv6yNBcd4jO8MKsKgSVGfNWEu+1weoiwwcZnwO0GcGVpIkvlOW911mwUAvoAkEiPKWvAqSgESxa29oCgAroag368aQ488zTbuRkvUW+RW2xrsUht6RRP99J9M0mkXyWbMfie06KzpSh1dC5hDsjQpPxcOCrbwVymb38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPbo1OhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72245C4CED6;
	Mon, 24 Feb 2025 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405217;
	bh=6P8m8bVx+JzTIQzT+IMsyVq8vQFZmn0P+wFQph1uxrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPbo1OhMtjDcn+xXqfpJq64mkI0wdd7zDpUSFRVcLW1noFvsCWBJdvT0W86vzEAC7
	 ayR9BPBZI6XNWuJV5daUMmilifpzmi6OeUoMzjrh6AnsJjVFJCv2NyObrTWX/UizLA
	 N0fAt+7IJmoY7JA/h0e/8KvF7CFopYteZQaIEnJ1iuiEadLjDeByTAWpV4P8cGfFP5
	 9SiGHnuSZR/vCuGnxXTh5aqgW4NqNlEKI1Ufg5wduBHtsVUrWk4mvz1AmqnIs4uMGY
	 sZy7tzTf+0DUG6LOx2tBIPVCLwfZ5wjwcaz4G/zg5jyuHru4BBYYWQ3j9dYKiec5Oh
	 883uH/cqgSLqA==
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
	stable@vger.kernel.org
Subject: [PATCH net-next v3 1/4] stmmac: loongson: Pass correct arg to PCI function
Date: Mon, 24 Feb 2025 14:53:19 +0100
Message-ID: <20250224135321.36603-3-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224135321.36603-2-phasta@kernel.org>
References: <20250224135321.36603-2-phasta@kernel.org>
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


