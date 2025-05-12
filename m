Return-Path: <stable+bounces-143329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC81AB3F22
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2157819E52C3
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403AC29614E;
	Mon, 12 May 2025 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xaPzxx06"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676C78F52;
	Mon, 12 May 2025 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071088; cv=none; b=FDFMqycyylFgWEuRkC3msUdLnUF4asmSKrqVa07fySbTXi++CsgXARFwuv55taHKheok9QVFFrOnqcOUagRuAZjOaIcYctbO+Q9FlqXQvN+zoFvau1MXv2LjSLMnZkiEYlQsWwTfzZtYGcdQDUV1C96eEtpl0blbV+pYuZrUM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071088; c=relaxed/simple;
	bh=s/q//hndQLLun3+mPJynDkCmvleFK6gpAKIis0qZEdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9t2GakcuPpXF8FRLt8CSeKIKSxlmGL2bOkkEpUKAlK9HpMog5MMh8QOdthHENq3AKtnhSYM1jbByPqLzN2nnfNS9RNykgUo8mbsjV4R8KaIAEN1atnoxunh9UsA0TfbuUL4LBIi9JXKAlZX4RsgRqvzO3YoCqF0UkIDLJjQAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xaPzxx06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9951C4CEE7;
	Mon, 12 May 2025 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747071087;
	bh=s/q//hndQLLun3+mPJynDkCmvleFK6gpAKIis0qZEdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xaPzxx06QaNV//FSCzab4K0BPCGi54LGBNSc3NC2R7xcQBGgeAPbXAWyV+7X9NmnD
	 dvGLizvN//VZkcusiYQCCEmTHPWLN63twRRPXCP9zo3I6AFBQwrtNf/OuiAWVhNVDL
	 zJ+qy1xrdeMVrj/AAC6NxgGbv4QX8yo4HPjyBjS4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 5.15 35/54] usb: cdnsp: Fix issue with resuming from L1
Date: Mon, 12 May 2025 19:29:47 +0200
Message-ID: <20250512172017.054769585@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172015.643809034@linuxfoundation.org>
References: <20250512172015.643809034@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawel Laszczak <pawell@cadence.com>

commit 241e2ce88e5a494be7a5d44c0697592f1632fbee upstream.

In very rare cases after resuming controller from L1 to L0 it reads
registers before the clock UTMI have been enabled and as the result
driver reads incorrect value.
Most of registers are in APB domain clock but some of them (e.g. PORTSC)
are in UTMI domain clock.
After entering to L1 state the UTMI clock can be disabled.
When controller transition from L1 to L0 the port status change event is
reported and in interrupt runtime function driver reads PORTSC.
During this read operation controller synchronize UTMI and APB domain
but UTMI clock is still disabled and in result it reads 0xFFFFFFFF value.
To fix this issue driver increases APB timeout value.

The issue is platform specific and if the default value of APB timeout
is not sufficient then this time should be set Individually for each
platform.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/PH7PR07MB953846C57973E4DB134CAA71DDBF2@PH7PR07MB9538.namprd07.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdnsp-gadget.c |   29 +++++++++++++++++++++++++++++
 drivers/usb/cdns3/cdnsp-gadget.h |    3 +++
 drivers/usb/cdns3/cdnsp-pci.c    |   12 ++++++++++--
 drivers/usb/cdns3/core.h         |    3 +++
 4 files changed, 45 insertions(+), 2 deletions(-)

--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -138,6 +138,26 @@ static void cdnsp_clear_port_change_bit(
 	       (portsc & PORT_CHANGE_BITS), port_regs);
 }
 
+static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev)
+{
+	struct cdns *cdns = dev_get_drvdata(pdev->dev);
+	__le32 __iomem *reg;
+	void __iomem *base;
+	u32 offset = 0;
+	u32 val;
+
+	if (!cdns->override_apb_timeout)
+		return;
+
+	base = &pdev->cap_regs->hc_capbase;
+	offset = cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
+	reg = base + offset + REG_CHICKEN_BITS_3_OFFSET;
+
+	val  = le32_to_cpu(readl(reg));
+	val = CHICKEN_APB_TIMEOUT_SET(val, cdns->override_apb_timeout);
+	writel(cpu_to_le32(val), reg);
+}
+
 static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32 bit)
 {
 	__le32 __iomem *reg;
@@ -1804,6 +1824,15 @@ static int cdnsp_gen_setup(struct cdnsp_
 	pdev->hci_version = HC_VERSION(pdev->hcc_params);
 	pdev->hcc_params = readl(&pdev->cap_regs->hcc_params);
 
+	/*
+	 * Override the APB timeout value to give the controller more time for
+	 * enabling UTMI clock and synchronizing APB and UTMI clock domains.
+	 * This fix is platform specific and is required to fixes issue with
+	 * reading incorrect value from PORTSC register after resuming
+	 * from L1 state.
+	 */
+	cdnsp_set_apb_timeout_value(pdev);
+
 	cdnsp_get_rev_cap(pdev);
 
 	/* Make sure the Device Controller is halted. */
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -520,6 +520,9 @@ struct cdnsp_rev_cap {
 #define REG_CHICKEN_BITS_2_OFFSET	0x48
 #define CHICKEN_XDMA_2_TP_CACHE_DIS	BIT(28)
 
+#define REG_CHICKEN_BITS_3_OFFSET       0x4C
+#define CHICKEN_APB_TIMEOUT_SET(p, val) (((p) & ~GENMASK(21, 0)) | (val))
+
 /* XBUF Extended Capability ID. */
 #define XBUF_CAP_ID			0xCB
 #define XBUF_RX_TAG_MASK_0_OFFSET	0x1C
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -33,6 +33,8 @@
 #define CDNS_DRD_ID		0x0100
 #define CDNS_DRD_IF		(PCI_CLASS_SERIAL_USB << 8 | 0x80)
 
+#define CHICKEN_APB_TIMEOUT_VALUE       0x1C20
+
 static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
 {
 	/*
@@ -144,6 +146,14 @@ static int cdnsp_pci_probe(struct pci_de
 		cdnsp->otg_irq = pdev->irq;
 	}
 
+	/*
+	 * Cadence PCI based platform require some longer timeout for APB
+	 * to fixes domain clock synchronization issue after resuming
+	 * controller from L1 state.
+	 */
+	cdnsp->override_apb_timeout = CHICKEN_APB_TIMEOUT_VALUE;
+	pci_set_drvdata(pdev, cdnsp);
+
 	if (pci_is_enabled(func)) {
 		cdnsp->dev = dev;
 		cdnsp->gadget_init = cdnsp_gadget_init;
@@ -153,8 +163,6 @@ static int cdnsp_pci_probe(struct pci_de
 			goto free_cdnsp;
 	}
 
-	pci_set_drvdata(pdev, cdnsp);
-
 	device_wakeup_enable(&pdev->dev);
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -79,6 +79,8 @@ struct cdns3_platform_data {
  * @pdata: platform data from glue layer
  * @lock: spinlock structure
  * @xhci_plat_data: xhci private data structure pointer
+ * @override_apb_timeout: hold value of APB timeout. For value 0 the default
+ *                        value in CHICKEN_BITS_3 will be preserved.
  * @gadget_init: pointer to gadget initialization function
  */
 struct cdns {
@@ -117,6 +119,7 @@ struct cdns {
 	struct cdns3_platform_data	*pdata;
 	spinlock_t			lock;
 	struct xhci_plat_priv		*xhci_plat_data;
+	u32                             override_apb_timeout;
 
 	int (*gadget_init)(struct cdns *cdns);
 };



