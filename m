Return-Path: <stable+bounces-184958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8408BD481A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BA94261EF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D1C30C378;
	Mon, 13 Oct 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RmeMoGbJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1030F945;
	Mon, 13 Oct 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368928; cv=none; b=Iq+BEh8k7YyDY1zxqWs+CEOUNh6d67WPCo8I+IminPpNMjIhyEdYB/JzmoJBbBXGdw3HiAzMxqyd09ff/DHu2qNgPNf3m5o2Cp7nM01A3llljcR1m+PYJrYZ1F+KDorVC7PYzHYkwCSD5wft1fLh/KtD6ypnBajmPANr/e0PtiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368928; c=relaxed/simple;
	bh=R3uT9iV7vWNc5NCc6pV2x0pIyaVBYYC3ojHI7+Zn958=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmKr20tJa6dSP0MI6RBcYfoFPrx+B9ufxmg6GaGrGp2u6yTIIrkoS7Ev2fqXFb3YiIcDVOu58j3iYPEWUoabSCvrtRE8P+BsqFhty6KLnh0AZAPiPDvOjam3C2BurXb9AO7Rdqx/PFKcd0fJvyu2tMsbbZUtiFAFEPUS3kQPhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RmeMoGbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1921AC4CEFE;
	Mon, 13 Oct 2025 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368927;
	bh=R3uT9iV7vWNc5NCc6pV2x0pIyaVBYYC3ojHI7+Zn958=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmeMoGbJ1MLkNW58Hdrn3+tAGUdtBQcTBOOOFGJHUzwd5EXUUAv2AZGQSQ65eLU6k
	 0tyg7/imgmq9vjWubC6WTBdQ7+HU0GFcYyUSMYb2uuFc5kBhwGusc57i2ENwngVJgZ
	 gtae1EpiHpLzn7H3ZNeuDkut+KhE4J4Ngi9Pf5Wo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 068/563] PCI/MSI: Add startup/shutdown for per device domains
Date: Mon, 13 Oct 2025 16:38:49 +0200
Message-ID: <20251013144413.753811471@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Inochi Amaoto <inochiama@gmail.com>

[ Upstream commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b ]

As the RISC-V PLIC cannot apply affinity settings without invoking
irq_enable(), it will make the interrupt unavailble when used as an
underlying interrupt chip for the MSI controller.

Implement the irq_startup() and irq_shutdown() callbacks for the PCI MSI
and MSI-X templates.

For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, the parent startup
and shutdown functions are invoked. That allows the interrupt on the parent
chip to be enabled if the interrupt has not been enabled during
allocation. This is necessary for MSI controllers which use PLIC as
underlying parent interrupt chip.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250813232835.43458-3-inochiama@gmail.com
Stable-dep-of: 9d8c41816bac ("irqchip/sg2042-msi: Fix broken affinity setting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/msi/irqdomain.c | 52 +++++++++++++++++++++++++++++++++++++
 include/linux/msi.h         |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 0938ef7ebabf2..e0a800f918e81 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,6 +148,23 @@ static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d
 	arg->hwirq = desc->msi_index;
 }
 
+static void cond_shutdown_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
+		irq_chip_shutdown_parent(data);
+}
+
+static unsigned int cond_startup_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
+		return irq_chip_startup_parent(data);
+	return 0;
+}
+
 static __always_inline void cond_mask_parent(struct irq_data *data)
 {
 	struct msi_domain_info *info = data->domain->host_data;
@@ -164,6 +181,23 @@ static __always_inline void cond_unmask_parent(struct irq_data *data)
 		irq_chip_unmask_parent(data);
 }
 
+static void pci_irq_shutdown_msi(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+	cond_shutdown_parent(data);
+}
+
+static unsigned int pci_irq_startup_msi(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	unsigned int ret = cond_startup_parent(data);
+
+	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
+	return ret;
+}
+
 static void pci_irq_mask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
@@ -194,6 +228,8 @@ static void pci_irq_unmask_msi(struct irq_data *data)
 static const struct msi_domain_template pci_msi_template = {
 	.chip = {
 		.name			= "PCI-MSI",
+		.irq_startup		= pci_irq_startup_msi,
+		.irq_shutdown		= pci_irq_shutdown_msi,
 		.irq_mask		= pci_irq_mask_msi,
 		.irq_unmask		= pci_irq_unmask_msi,
 		.irq_write_msi_msg	= pci_msi_domain_write_msg,
@@ -210,6 +246,20 @@ static const struct msi_domain_template pci_msi_template = {
 	},
 };
 
+static void pci_irq_shutdown_msix(struct irq_data *data)
+{
+	pci_msix_mask(irq_data_get_msi_desc(data));
+	cond_shutdown_parent(data);
+}
+
+static unsigned int pci_irq_startup_msix(struct irq_data *data)
+{
+	unsigned int ret = cond_startup_parent(data);
+
+	pci_msix_unmask(irq_data_get_msi_desc(data));
+	return ret;
+}
+
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
@@ -234,6 +284,8 @@ EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
 static const struct msi_domain_template pci_msix_template = {
 	.chip = {
 		.name			= "PCI-MSIX",
+		.irq_startup		= pci_irq_startup_msix,
+		.irq_shutdown		= pci_irq_shutdown_msix,
 		.irq_mask		= pci_irq_mask_msix,
 		.irq_unmask		= pci_irq_unmask_msix,
 		.irq_write_msi_msg	= pci_msi_domain_write_msg,
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e5e86a8529fb6..3111ba95fbde4 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -568,6 +568,8 @@ enum {
 	MSI_FLAG_PARENT_PM_DEV		= (1 << 8),
 	/* Support for parent mask/unmask */
 	MSI_FLAG_PCI_MSI_MASK_PARENT	= (1 << 9),
+	/* Support for parent startup/shutdown */
+	MSI_FLAG_PCI_MSI_STARTUP_PARENT	= (1 << 10),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
-- 
2.51.0




