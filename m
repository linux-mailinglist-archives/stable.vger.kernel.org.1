Return-Path: <stable+bounces-143956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11592AB431F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419E78C62FC
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5329A334;
	Mon, 12 May 2025 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S8MYT/DH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337F29A32F;
	Mon, 12 May 2025 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073413; cv=none; b=Hl4metX0b/OxXwmw0wx72wT8UUIv5kzYmiiEnKgVsEGxQ9hCXq081urzziHAixKKFOHfbDJla4Dw0cDfZ8WmwfYzOMI3ImxMZVveqElnpAXZ7N2wJT8AES/7iZ5SaDZIcMkEWaigoE1og7LVa44p8UqrMpNlsUboDNhK8eWTjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073413; c=relaxed/simple;
	bh=3ZH/C8gRVoMbxJVZVNgDqBRKUKUcPpeqZWPhB5eNszQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iixe9OURkd2i+XApeKlP7btddSYYW2I+U/I8BY/Aq8bUaNAusRyb4lUVSns/ZJ7WKzeo40bHM6p1y9B9VqMoZI1fT+3cFL/RnzVQfi4n3kqaeC8o03g3nQvx5bgz9IZRJtBhDnsigK/2ve5KgIGw091PMk3FFjW+JMMD8nXcNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S8MYT/DH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90135C4CEE7;
	Mon, 12 May 2025 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073413;
	bh=3ZH/C8gRVoMbxJVZVNgDqBRKUKUcPpeqZWPhB5eNszQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8MYT/DHFGRdcZIqefIpmRxlmga5ekMa/nNrAYhfH37LKQenuYvvqMWCbXYWep+zP
	 zFnpV8o6Hd+XNc4n7UKOEzVPYeUkDSd5MpboFNSkZy+TTcZ8Uvn1rD71aRIoQpHZgH
	 iu/QqYNk5T38T7HvukcPVS9lXtXETbgxlkhilJmU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.6 067/113] usb: cdnsp: Fix issue with resuming from L1
Date: Mon, 12 May 2025 19:45:56 +0200
Message-ID: <20250512172030.409783395@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
References: <20250512172027.691520737@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1801,6 +1821,15 @@ static int cdnsp_gen_setup(struct cdnsp_
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



