Return-Path: <stable+bounces-169831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53257B28828
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 00:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3CA1C80579
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27502153C7;
	Fri, 15 Aug 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPjdPRe4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151A28399
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295707; cv=none; b=sPDJKzLyUsa91RnzjzSqmcj5I8c0K7xxBHO0IrZN4DYzXvGICDHPu9kjMXTwaN/QA1184VyNiYc4DCIYMBhekMegNxaBmQUZolBdjuuBBR59tx0D9/H00sCziyekDL8ly+kiyhoGrKd8Ey4vmUSD8BJfli51VNTPhvc37WVedMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295707; c=relaxed/simple;
	bh=BxDPMeP1KR1Ur8GraMUP6WpBqvf8/rhSp/lDLAVFbRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eg+FzVnCnOFm1xFTiQw1ao034UbTy7RMYpihMPDTnpp4pJSiOAeSthNETouSAiCEvMYeCyDeN+4/k5CH4YNVZ2JPjy/u8+o1Vd8okKQa15xKwyvHWHMoTiecefUmnadx+2KPlsIUXNqehQMO7GnPyHkspdcjL2z8h+0/t9ppPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPjdPRe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA9DC4CEEB;
	Fri, 15 Aug 2025 22:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755295707;
	bh=BxDPMeP1KR1Ur8GraMUP6WpBqvf8/rhSp/lDLAVFbRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPjdPRe4Z9YAC7rzNjRlAWkK7M80SA5C8ZyMB9iUEP1+BcN6eoDDb08rldSMVJ4DZ
	 CbB9JXfDf4QOptkZwg4GDJGoOMj2PpEfxaVajZAsmFyW5H+SxhmRDGs8tUe+XdPBL1
	 zVQhdxqT4f3dom/eZEKUClUZjU9zuyIobcYF9rPMbgLHo9n2iJgOalicrlOxczuJLd
	 gKWC+e46zKTpftx4FnhQQDRc5eR2Wcpj9gNvH/9Q9otxpmZz4iyBbK3DpLs9k/My+t
	 SZ5YkziBpcREOAdm4RAI7XnEVQLWFKVoXzqu3r1SNTC9XJGuSMvCni7xBWOIhR6OzE
	 BYDW3fFgBxXww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] PCI: Store all PCIe Supported Link Speeds
Date: Fri, 15 Aug 2025 18:08:22 -0400
Message-ID: <20250815220824.248963-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081508-ultra-derived-f72d@gregkh>
References: <2025081508-ultra-derived-f72d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit d2bd39c0456b75be9dfc7d774b8d021355c26ae3 ]

The PCIe bandwidth controller added by a subsequent commit will require
selecting PCIe Link Speeds that are lower than the Maximum Link Speed.

The struct pci_bus only stores max_bus_speed. Even if PCIe r6.1 sec 8.2.1
currently disallows gaps in supported Link Speeds, the Implementation Note
in PCIe r6.1 sec 7.5.3.18, recommends determining supported Link Speeds
using the Supported Link Speeds Vector in the Link Capabilities 2 Register
(when available) to "avoid software being confused if a future
specification defines Links that do not require support for all slower
speeds."

Reuse code in pcie_get_speed_cap() to add pcie_get_supported_speeds() to
query the Supported Link Speeds Vector of a PCIe device. The value is taken
directly from the Supported Link Speeds Vector or synthesized from the Max
Link Speed in the Link Capabilities Register when the Link Capabilities 2
Register is not available.

The Supported Link Speeds Vector in the Link Capabilities Register 2
corresponds to the bus below on Root Ports and Downstream Ports, whereas it
corresponds to the bus above on Upstream Ports and Endpoints (PCIe r6.1 sec
7.5.3.18):

  Supported Link Speeds Vector - This field indicates the supported Link
  speed(s) of the associated Port.

Add supported_speeds into the struct pci_dev that caches the
Supported Link Speeds Vector.

supported_speeds contains a set of Link Speeds only in the case where PCIe
Link Speed can be determined. Root Complex Integrated Endpoints do not have
a well-defined Link Speed because they do not implement either of the Link
Capabilities Registers, which is allowed by PCIe r6.1 sec 7.5.3 (the same
limitation applies to determining cur_bus_speed and max_bus_speed that are
PCI_SPEED_UNKNOWN in such case). This is of no concern from PCIe bandwidth
controller point of view because such devices are not attached into a PCIe
Root Port that could be controlled.

The supported_speeds field keeps the extra reserved zero at the least
significant bit to match the Link Capabilities 2 Register layout.

An attempt was made to store supported_speeds field into the struct pci_bus
as an intersection of both ends of the Link, however, the subordinate
struct pci_bus is not available early enough. The Target Speed quirk (in
pcie_failed_link_retrain()) can run either during initial scan or later,
requiring it to use the API provided by the PCIe bandwidth controller to
set the Target Link Speed in order to co-exist with the bandwidth
controller. When the Target Speed quirk is calling the bandwidth controller
during initial scan, the struct pci_bus is not yet initialized. As such,
storing supported_speeds into the struct pci_bus is not viable.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Link: https://lore.kernel.org/r/20241018144755.7875-4-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[bhelgaas: move pcie_get_supported_speeds() decl to drivers/pci/pci.h]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 6cff20ce3b92 ("PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c             | 58 +++++++++++++++++++++++++----------
 drivers/pci/pci.h             |  1 +
 drivers/pci/probe.c           |  3 ++
 include/linux/pci.h           | 10 +++++-
 include/uapi/linux/pci_regs.h |  1 +
 5 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 51a09e48967f..e52299229b52 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6199,38 +6199,64 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 EXPORT_SYMBOL(pcie_bandwidth_available);
 
 /**
- * pcie_get_speed_cap - query for the PCI device's link speed capability
+ * pcie_get_supported_speeds - query Supported Link Speed Vector
  * @dev: PCI device to query
  *
- * Query the PCI device speed capability.  Return the maximum link speed
- * supported by the device.
+ * Query @dev supported link speeds.
+ *
+ * Implementation Note in PCIe r6.0 sec 7.5.3.18 recommends determining
+ * supported link speeds using the Supported Link Speeds Vector in the Link
+ * Capabilities 2 Register (when available).
+ *
+ * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.
+ *
+ * Without Link Capabilities 2, i.e., prior to PCIe r3.0, Supported Link
+ * Speeds field in Link Capabilities is used and only 2.5 GT/s and 5.0 GT/s
+ * speeds were defined.
+ *
+ * For @dev without Supported Link Speed Vector, the field is synthesized
+ * from the Max Link Speed field in the Link Capabilities Register.
+ *
+ * Return: Supported Link Speeds Vector (+ reserved 0 at LSB).
  */
-enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
+u8 pcie_get_supported_speeds(struct pci_dev *dev)
 {
 	u32 lnkcap2, lnkcap;
+	u8 speeds;
 
 	/*
-	 * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.  The
-	 * implementation note there recommends using the Supported Link
-	 * Speeds Vector in Link Capabilities 2 when supported.
-	 *
-	 * Without Link Capabilities 2, i.e., prior to PCIe r3.0, software
-	 * should use the Supported Link Speeds field in Link Capabilities,
-	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
+	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
+	 * Speeds Vector to allow using SLS Vector bit defines directly.
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
+	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
 
 	/* PCIe r3.0-compliant */
-	if (lnkcap2)
-		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
+	if (speeds)
+		return speeds;
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+
+	/* Synthesize from the Max Link Speed field */
 	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
-		return PCIE_SPEED_5_0GT;
+		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
 	else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
-		return PCIE_SPEED_2_5GT;
+		speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
 
-	return PCI_SPEED_UNKNOWN;
+	return speeds;
+}
+
+/**
+ * pcie_get_speed_cap - query for the PCI device's link speed capability
+ * @dev: PCI device to query
+ *
+ * Query the PCI device speed capability.
+ *
+ * Return: the maximum link speed supported by the device.
+ */
+enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
+{
+	return PCIE_LNKCAP2_SLS2SPEED(dev->supported_speeds);
 }
 EXPORT_SYMBOL(pcie_get_speed_cap);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 65df6d2ac003..b65868e70951 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -390,6 +390,7 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 	return -EINVAL;
 }
 
+u8 pcie_get_supported_speeds(struct pci_dev *dev);
 const char *pci_speed_string(enum pci_bus_speed speed);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cf7c7886b642..b777e1b01839 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1972,6 +1972,9 @@ int pci_setup_device(struct pci_dev *dev)
 
 	set_pcie_untrusted(dev);
 
+	if (pci_is_pcie(dev))
+		dev->supported_speeds = pcie_get_supported_speeds(dev);
+
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ade889ded4e1..f611837f1989 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -320,7 +320,14 @@ struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
 
-/* The pci_dev structure describes PCI devices */
+/* struct pci_dev - describes a PCI device
+ *
+ * @supported_speeds:	PCIe Supported Link Speeds Vector (+ reserved 0 at
+ *			LSB). 0 when the supported speeds cannot be
+ *			determined (e.g., for Root Complex Integrated
+ *			Endpoints without the relevant Capability
+ *			Registers).
+ */
 struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
 	struct pci_bus	*bus;		/* Bus this device is on */
@@ -524,6 +531,7 @@ struct pci_dev {
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
+	u8		supported_speeds; /* Supported Link Speeds Vector */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	/*
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 12323b3334a9..f3c9de0a497c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -678,6 +678,7 @@
 #define PCI_EXP_DEVSTA2		0x2a	/* Device Status 2 */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2 0x2c	/* end of v2 EPs w/o link */
 #define PCI_EXP_LNKCAP2		0x2c	/* Link Capabilities 2 */
+#define  PCI_EXP_LNKCAP2_SLS		0x000000fe /* Supported Link Speeds Vector */
 #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
-- 
2.50.1


