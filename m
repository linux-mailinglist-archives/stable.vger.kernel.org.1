Return-Path: <stable+bounces-75080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3B973302
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097A0B2B98F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA6190685;
	Tue, 10 Sep 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mq5tIBt7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6A18E77C;
	Tue, 10 Sep 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963691; cv=none; b=nMbij6R0zLUAhxvOfVtX9f41nG/2XtQggStd7Q1iZZOdtJDP2LRKB28wY3BH/p2JUvqrrowXvZJd29BSfgBCMVbY0bY46yUlkxgVlcIAfNYMEWraUbG5pWhbn2JA0FDBMHwe04F1yQ8Gkb7TmLRWNFH/0XoSJhJ3/rh2RpKSV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963691; c=relaxed/simple;
	bh=y+gDmlmgBfWOnHh/EG1Yg7UT+JwUMRVoRdXw72bvDXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsU7UleuPBf7CL437RmfN+JujfpXZNpKV08Ej0+Ql9ZnsrRjXrHCVtfjP9cF1uexblttfSGlHXf5yfNPCU1p02Yk9kv/Zn0k57QWpwfqB2BsVaf359TCa1gOO3vbaLgFHnX5uKuLghH08kkICQ4sK74pknFO5/EGsQv5s8QA9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mq5tIBt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8150C4CEC3;
	Tue, 10 Sep 2024 10:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963691;
	bh=y+gDmlmgBfWOnHh/EG1Yg7UT+JwUMRVoRdXw72bvDXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mq5tIBt79hPa2WWrg0ZzSfUd2+V37KebiCtkMgStRSiY4I4ReLSqj6nIJxjFcWAd5
	 pM7khFx5IW24eIaata1oqihBlIe4hKWtY75beH48HunpQlWhf4B+jWmLMKKFOIWIVD
	 hhBZw1ZqSruaxULgkK54WyCqZkF6Uih04hpXRLMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Achal Verma <a-verma1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 116/214] PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)
Date: Tue, 10 Sep 2024 11:32:18 +0200
Message-ID: <20240910092603.536893258@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 86f271f22bbb6391410a07e08d6ca3757fda01fa ]

Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
(SPRZ452D_July 2018_Revised December 2019 [1]) mentions when an
inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
the bus may corrupt the packet payload and the corrupt data may
cause associated applications or the processor to hang.

The workaround for Errata #i2037 is to limit the maximum read
request size and maximum payload size to 128 bytes. Add workaround
for Errata #i2037 here.

The errata and workaround is applicable only to AM65x SR 1.0 and
later versions of the silicon will have this fixed.

[1] -> https://www.ti.com/lit/er/sprz452i/sprz452i.pdf

Link: https://lore.kernel.org/linux-pci/16e1fcae-1ea7-46be-b157-096e05661b15@siemens.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 44 ++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 09379e5f7724..24031123a550 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -35,6 +35,11 @@
 #define PCIE_DEVICEID_SHIFT	16
 
 /* Application registers */
+#define PID				0x000
+#define RTL				GENMASK(15, 11)
+#define RTL_SHIFT			11
+#define AM6_PCI_PG1_RTL_VER		0x15
+
 #define CMD_STATUS			0x004
 #define LTSSM_EN_VAL		        BIT(0)
 #define OB_XLAT_EN_VAL		        BIT(1)
@@ -105,6 +110,8 @@
 
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
+#define PCI_DEVICE_ID_TI_AM654X		0xb00c
+
 struct ks_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct dw_pcie_host_ops *host_ops;
@@ -528,7 +535,11 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
 static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
+	struct keystone_pcie *ks_pcie;
+	struct device *bridge_dev;
 	struct pci_dev *bridge;
+	u32 val;
+
 	static const struct pci_device_id rc_pci_devids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
 		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
@@ -540,6 +551,11 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
 		{ 0, },
 	};
+	static const struct pci_device_id am6_pci_devids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654X),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ 0, },
+	};
 
 	if (pci_is_root_bus(bus))
 		bridge = dev;
@@ -561,10 +577,36 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 	 */
 	if (pci_match_id(rc_pci_devids, bridge)) {
 		if (pcie_get_readrq(dev) > 256) {
-			dev_info(&dev->dev, "limiting MRRS to 256\n");
+			dev_info(&dev->dev, "limiting MRRS to 256 bytes\n");
 			pcie_set_readrq(dev, 256);
 		}
 	}
+
+	/*
+	 * Memory transactions fail with PCI controller in AM654 PG1.0
+	 * when MRRS is set to more than 128 bytes. Force the MRRS to
+	 * 128 bytes in all downstream devices.
+	 */
+	if (pci_match_id(am6_pci_devids, bridge)) {
+		bridge_dev = pci_get_host_bridge_device(dev);
+		if (!bridge_dev && !bridge_dev->parent)
+			return;
+
+		ks_pcie = dev_get_drvdata(bridge_dev->parent);
+		if (!ks_pcie)
+			return;
+
+		val = ks_pcie_app_readl(ks_pcie, PID);
+		val &= RTL;
+		val >>= RTL_SHIFT;
+		if (val != AM6_PCI_PG1_RTL_VER)
+			return;
+
+		if (pcie_get_readrq(dev) > 128) {
+			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
+			pcie_set_readrq(dev, 128);
+		}
+	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
-- 
2.43.0




