Return-Path: <stable+bounces-137252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC1AA1266
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F9188EA06
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603A9248878;
	Tue, 29 Apr 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlwF7C6A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55E21772B;
	Tue, 29 Apr 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945514; cv=none; b=FLcuAXkAYYtpuYEwvNwUdImsnJfYqXgg2568+tE8vJxAIVUj/HZwUmNAq6D4pE5RdLSO1X2Vt2pdVhYT0TRJAOo7OhkrR/x6kl058S34AKQoeyyHPnbL8v+P6eRjsNB9xzZRYOdMdgoC4Y6fEpyJugbTW0ZitR3wthaxhJU2Zw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945514; c=relaxed/simple;
	bh=uJg60AbQ+ZzMNbrgCrpTZkESrAqAFl1Q7RqrhsxpJgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6mx6Uy9vOMVUqBkIAe0h/+DPRRBADYaeYuwb8/mx/4ZD4AI3jyEsBuRTdc3mb0Djt/vMyfmB4buBNtT+qiSETo04S554/BY+RylYv3Lq1VYQcF1/JoELaBBwrUuyNA67XPOPr2InZaszbOPhzYF9NsxWY32lbAIiVtF8a6L/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlwF7C6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5E1C4CEE3;
	Tue, 29 Apr 2025 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945514;
	bh=uJg60AbQ+ZzMNbrgCrpTZkESrAqAFl1Q7RqrhsxpJgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlwF7C6A12+iFsktzWMF2tWM56Ln8PNNSNHQzdktx42JAFROp33pv8EROn+etB0nq
	 nrWNuibeVd5Sl7VjLf+l0/V4eV1HIWu0UCaFSLAAJyftw/RBAnK+a7ejTUHdSPGwZb
	 IkzsjowcKfszMhwhWzYfeSxsBObWOnbLahSYzXPw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 138/179] misc: pci_endpoint_test: Use INTX instead of LEGACY
Date: Tue, 29 Apr 2025 18:41:19 +0200
Message-ID: <20250429161054.979163820@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit acd288666979a49538d70e0c0d86e1118b445058 ]

In the root complex pci endpoint test function driver, change macros and
functions names using the term "legacy" to use "intx" instead to
match the term used in the PCI specifications.

Link: https://lore.kernel.org/r/20231122060406.14695-6-dlemoal@kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 919d14603dab ("misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 30 +++++++++++++++---------------
 include/uapi/linux/pcitest.h     |  3 ++-
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index f9dd3e6546a50..fcb7dc8e79d43 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -27,14 +27,14 @@
 #define DRV_MODULE_NAME				"pci-endpoint-test"
 
 #define IRQ_TYPE_UNDEFINED			-1
-#define IRQ_TYPE_LEGACY				0
+#define IRQ_TYPE_INTX				0
 #define IRQ_TYPE_MSI				1
 #define IRQ_TYPE_MSIX				2
 
 #define PCI_ENDPOINT_TEST_MAGIC			0x0
 
 #define PCI_ENDPOINT_TEST_COMMAND		0x4
-#define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
+#define COMMAND_RAISE_INTX_IRQ			BIT(0)
 #define COMMAND_RAISE_MSI_IRQ			BIT(1)
 #define COMMAND_RAISE_MSIX_IRQ			BIT(2)
 #define COMMAND_READ				BIT(3)
@@ -170,8 +170,8 @@ static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 	bool res = true;
 
 	switch (type) {
-	case IRQ_TYPE_LEGACY:
-		irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
+	case IRQ_TYPE_INTX:
+		irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
 		if (irq < 0)
 			dev_err(dev, "Failed to get Legacy interrupt\n");
 		break;
@@ -231,7 +231,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 
 fail:
 	switch (irq_type) {
-	case IRQ_TYPE_LEGACY:
+	case IRQ_TYPE_INTX:
 		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
 			pci_irq_vector(pdev, i));
 		break;
@@ -281,15 +281,15 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	return true;
 }
 
-static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
+static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
 {
 	u32 val;
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
-				 IRQ_TYPE_LEGACY);
+				 IRQ_TYPE_INTX);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 0);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_RAISE_LEGACY_IRQ);
+				 COMMAND_RAISE_INTX_IRQ);
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
@@ -344,7 +344,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	if (size > SIZE_MAX - alignment)
 		goto err;
 
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		goto err;
 	}
@@ -440,7 +440,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	if (size > SIZE_MAX - alignment)
 		goto err;
 
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		goto err;
 	}
@@ -509,7 +509,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	if (size > SIZE_MAX - alignment)
 		goto err;
 
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		goto err;
 	}
@@ -560,7 +560,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
 
-	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
+	if (req_irq_type < IRQ_TYPE_INTX || req_irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
 		return false;
 	}
@@ -607,8 +607,8 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 			goto ret;
 		ret = pci_endpoint_test_bar(test, bar);
 		break;
-	case PCITEST_LEGACY_IRQ:
-		ret = pci_endpoint_test_legacy_irq(test);
+	case PCITEST_INTX_IRQ:
+		ret = pci_endpoint_test_intx_irq(test);
 		break;
 	case PCITEST_MSI:
 	case PCITEST_MSIX:
@@ -668,7 +668,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	test->irq_type = IRQ_TYPE_UNDEFINED;
 
 	if (no_msi)
-		irq_type = IRQ_TYPE_LEGACY;
+		irq_type = IRQ_TYPE_INTX;
 
 	data = (struct pci_endpoint_test_data *)ent->driver_data;
 	if (data) {
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index cbf422e566962..1f358a135de04 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -11,7 +11,8 @@
 #define __UAPI_LINUX_PCITEST_H
 
 #define PCITEST_BAR		_IO('P', 0x1)
-#define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
+#define PCITEST_INTX_IRQ	_IO('P', 0x2)
+#define PCITEST_LEGACY_IRQ	PCITEST_INTX_IRQ
 #define PCITEST_MSI		_IOW('P', 0x3, int)
 #define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
 #define PCITEST_READ		_IOW('P', 0x5, unsigned long)
-- 
2.39.5




