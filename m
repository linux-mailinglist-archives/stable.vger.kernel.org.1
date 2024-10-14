Return-Path: <stable+bounces-83857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B997799CCDE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C1EB20FE0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2D71A0BE7;
	Mon, 14 Oct 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UpmDhuwQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77FE571;
	Mon, 14 Oct 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915961; cv=none; b=swGWDYI15lob1AeEhvuCG55Jf7xpEx9R1kH7L2bkSBE0VVLTmtfT1J4LL1rpK1dD34wcWuCqVYPi6B0SIJtiwAWbZzrH5vHxFC5TjdLwcRhG9bL4ucxjZ5Fm8ii/4J/OYffREqtmdl4jBKEfGjXiu/v+3IlQWioOr3lxqrfhu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915961; c=relaxed/simple;
	bh=5PHwQoNNoTBPZWRDubw235MPPDcCQuWB3H60cpzB9yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWIU765g5e2KhQoJNuq20668OMwxIN6YSYvzoUvxzgY1r0sTVEbmulz5xYyULje3FcdU3QEYcFDUoAkjeqO8mNTyYrPBmoj/KhV2rY03mF7Dpkmp57jWGzhgi0DZXeBNnQAJEjtUWjXHWlcgdl4a2OA6rk7hPiMkxgHBAHxQ3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UpmDhuwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED389C4CEC3;
	Mon, 14 Oct 2024 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728915961;
	bh=5PHwQoNNoTBPZWRDubw235MPPDcCQuWB3H60cpzB9yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UpmDhuwQ5vxSs9FMtyD2cmlWUK6E+HxXOxfyWTVY8eKjfdo8yKXtRz/qMWYi0zdoI
	 knmZIG70bQUbC61MApo2yQr5KxhBBc7knbE2S7YSA72SKv0hikjiuBEmy2pfzUGXku
	 OSnpXtZcAdmBUcS0dZ7lOYRT9bMOwARUZLEYIUs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Mayank Rana <quic_mrana@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 047/214] PCI: qcom: Disable mirroring of DBI and iATU register space in BAR region
Date: Mon, 14 Oct 2024 16:18:30 +0200
Message-ID: <20241014141046.826627659@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

[ Upstream commit 10ba0854c5e6165b58e17bda5fb671e729fecf9e ]

PARF hardware block which is a wrapper on top of DWC PCIe controller
mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
register to get the size of the memory block to be mirrored and uses
PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
address of DBI and ATU space inside the memory block that is being
mirrored.

When a memory region which is located above the SLV_ADDR_SPACE_SIZE
boundary is used for BAR region then there could be an overlap of DBI and
ATU address space that is getting mirrored and the BAR region. This
results in DBI and ATU address space contents getting updated when a PCIe
function driver tries updating the BAR/MMIO memory region. Reference
memory map of the PCIe memory region with DBI and ATU address space
overlapping BAR region is as below.

                        |---------------|
                        |               |
                        |               |
        ------- --------|---------------|
           |       |    |---------------|
           |       |    |       DBI     |
           |       |    |---------------|---->DBI_BASE_ADDR
           |       |    |               |
           |       |    |               |
           |    PCIe    |               |---->2*SLV_ADDR_SPACE_SIZE
           |    BAR/MMIO|---------------|
           |    Region  |       ATU     |
           |       |    |---------------|---->ATU_BASE_ADDR
           |       |    |               |
        PCIe       |    |---------------|
        Memory     |    |       DBI     |
        Region     |    |---------------|---->DBI_BASE_ADDR
           |       |    |               |
           |    --------|               |
           |            |               |---->SLV_ADDR_SPACE_SIZE
           |            |---------------|
           |            |       ATU     |
           |            |---------------|---->ATU_BASE_ADDR
           |            |               |
           |            |---------------|
           |            |       DBI     |
           |            |---------------|---->DBI_BASE_ADDR
           |            |               |
           |            |               |
        ----------------|---------------|
                        |               |
                        |               |
                        |               |
                        |---------------|

Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
used for BAR region which is why the above mentioned issue is not
encountered. This issue is discovered as part of internal testing when we
tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
we are trying to fix this.

As PARF hardware block mirrors DBI and ATU register space after every
PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, program
maximum possible size to this register by writing 0x80000000 to it(it
considers only powers of 2 as values) to avoid mirroring DBI and ATU to
BAR/MMIO region. Write the physical base address of DBI and ATU register
blocks to PARF_DBI_BASE_ADDR (default 0x0) and PARF_ATU_BASE_ADDR (default
0x1000) respectively to make sure DBI and ATU blocks are at expected
memory locations.

The register offsets PARF_DBI_BASE_ADDR_V2, PARF_SLV_ADDR_SPACE_SIZE_V2
and PARF_ATU_BASE_ADDR are applicable for platforms that use Qcom IP
rev 1.9.0, 2.7.0 and 2.9.0. PARF_DBI_BASE_ADDR_V2 and
PARF_SLV_ADDR_SPACE_SIZE_V2 are applicable for Qcom IP rev 2.3.3.
PARF_DBI_BASE_ADDR and PARF_SLV_ADDR_SPACE_SIZE are applicable for Qcom
IP rev 1.0.0, 2.3.2 and 2.4.0. Update init()/post_init() functions of the
respective Qcom IP versions to program applicable PARF_DBI_BASE_ADDR,
PARF_SLV_ADDR_SPACE_SIZE and PARF_ATU_BASE_ADDR register offsets. Update
the SLV_ADDR_SPACE_SZ macro to 0x80000000 to set highest bit in
PARF_SLV_ADDR_SPACE_SIZE register.

Cache DBI and iATU physical addresses in 'struct dw_pcie' so that
pcie_qcom.c driver can program these addresses in the PARF_DBI_BASE_ADDR
and PARF_ATU_BASE_ADDR registers.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/linux-pci/20240814220338.1969668-1-quic_pyarlaga@quicinc.com
Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c |  2 +
 drivers/pci/controller/dwc/pcie-designware.h |  2 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 72 ++++++++++++++++----
 3 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 1b5aba1f0c92f..bc3a5d6b01779 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
 		if (IS_ERR(pci->dbi_base))
 			return PTR_ERR(pci->dbi_base);
+		pci->dbi_phys_addr = res->start;
 	}
 
 	/* DBI2 is mainly useful for the endpoint controller */
@@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->atu_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->atu_base))
 				return PTR_ERR(pci->atu_base);
+			pci->atu_phys_addr = res->start;
 		} else {
 			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
 		}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 53c4c8f399c88..e518f81ea80cd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -407,8 +407,10 @@ struct dw_pcie_ops {
 struct dw_pcie {
 	struct device		*dev;
 	void __iomem		*dbi_base;
+	resource_size_t		dbi_phys_addr;
 	void __iomem		*dbi_base2;
 	void __iomem		*atu_base;
+	resource_size_t		atu_phys_addr;
 	size_t			atu_size;
 	u32			num_ib_windows;
 	u32			num_ob_windows;
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6f953e32d9907..0b3020c7a50a4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -45,6 +45,7 @@
 #define PARF_PHY_REFCLK				0x4c
 #define PARF_CONFIG_BITS			0x50
 #define PARF_DBI_BASE_ADDR			0x168
+#define PARF_SLV_ADDR_SPACE_SIZE		0x16c
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
@@ -52,8 +53,13 @@
 #define PARF_LTSSM				0x1b0
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
-#define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PARF_DBI_BASE_ADDR_V2			0x350
+#define PARF_DBI_BASE_ADDR_V2_HI		0x354
+#define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
+#define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
 #define PARF_NO_SNOOP_OVERIDE			0x3d4
+#define PARF_ATU_BASE_ADDR			0x634
+#define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 #define PARF_BDF_TO_SID_CFG			0x2c00
@@ -108,7 +114,7 @@
 #define PHY_RX0_EQ(x)				FIELD_PREP(GENMASK(26, 24), x)
 
 /* PARF_SLV_ADDR_SPACE_SIZE register value */
-#define SLV_ADDR_SPACE_SZ			0x10000000
+#define SLV_ADDR_SPACE_SZ			0x80000000
 
 /* PARF_MHI_CLOCK_RESET_CTRL register fields */
 #define AHB_CLK_EN				BIT(0)
@@ -325,6 +331,50 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
+static void qcom_pcie_configure_dbi_base(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+
+	if (pci->dbi_phys_addr) {
+		/*
+		 * PARF_DBI_BASE_ADDR register is in CPU domain and require to
+		 * be programmed with CPU physical address.
+		 */
+		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
+							PARF_DBI_BASE_ADDR);
+		writel(SLV_ADDR_SPACE_SZ, pcie->parf +
+						PARF_SLV_ADDR_SPACE_SIZE);
+	}
+}
+
+static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+
+	if (pci->dbi_phys_addr) {
+		/*
+		 * PARF_DBI_BASE_ADDR_V2 and PARF_ATU_BASE_ADDR registers are
+		 * in CPU domain and require to be programmed with CPU
+		 * physical addresses.
+		 */
+		writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf +
+							PARF_DBI_BASE_ADDR_V2);
+		writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf +
+						PARF_DBI_BASE_ADDR_V2_HI);
+
+		if (pci->atu_phys_addr) {
+			writel(lower_32_bits(pci->atu_phys_addr), pcie->parf +
+							PARF_ATU_BASE_ADDR);
+			writel(upper_32_bits(pci->atu_phys_addr), pcie->parf +
+							PARF_ATU_BASE_ADDR_HI);
+		}
+
+		writel(0x0, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_V2);
+		writel(SLV_ADDR_SPACE_SZ, pcie->parf +
+					PARF_SLV_ADDR_SPACE_SIZE_V2_HI);
+	}
+}
+
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -541,8 +591,7 @@ static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 {
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_base(pcie);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		u32 val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
@@ -629,8 +678,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_base(pcie);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
@@ -812,13 +860,11 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
-	writel(SLV_ADDR_SPACE_SZ, pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
-
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_atu_base(pcie);
 
 	writel(MST_WAKEUP_EN | SLV_WAKEUP_EN | MSTR_ACLK_CGC_DIS
 		| SLV_ACLK_CGC_DIS | CORE_CLK_CGC_DIS |
@@ -914,8 +960,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	/* change DBI base address */
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_atu_base(pcie);
 
 	/* MAC PHY_POWERDOWN MUX DISABLE  */
 	val = readl(pcie->parf + PARF_SYS_CTRL);
@@ -1124,14 +1169,11 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 	u32 val;
 	int i;
 
-	writel(SLV_ADDR_SPACE_SZ,
-		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
-
 	val = readl(pcie->parf + PARF_PHY_CTRL);
 	val &= ~PHY_TEST_PWR_DOWN;
 	writel(val, pcie->parf + PARF_PHY_CTRL);
 
-	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
+	qcom_pcie_configure_dbi_atu_base(pcie);
 
 	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 	writel(BYPASS | MSTR_AXI_CLK_EN | AHB_CLK_EN,
-- 
2.43.0




