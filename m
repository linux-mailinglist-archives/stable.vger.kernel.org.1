Return-Path: <stable+bounces-186129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC37BE3A32
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512DE3B8059
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6051A9FBE;
	Thu, 16 Oct 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R+rd/opS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53C433A0
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620589; cv=none; b=f3jM24BYmhYyVGNl6cYQ+5502250owPVQqBV7VmNM3nWjTu6yKLglMRcdz3JVizwAdiKabO3W2+xD5DBnbUsuNoq6hQ75s2nyU/NM86A1eHnCNxSLvhF9W3GTRdTKKFkZLU1xgNlasYwmKP0w6RGNOhwmCqIe7iBQQSFCjNg+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620589; c=relaxed/simple;
	bh=85/czp1CrNvrfLJmJ3GFw4gIrQI4QzjNEA4StXdNrx4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g3ySZk6GGMo1M1priegnm9strHMvmoq0oz4Ci96daFDLBxZxT4JWWNcYyDxO3Y30gmlleIsFfsfLjtTWa8xhTDY4YbSyFhk01gzNBlQ9MF8I+kHBmteF15wXOtd6alAUE7sLqCJXYTAPLPKmYA8xMFir0wyB8ovYVVjIJHRNmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R+rd/opS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD892C113D0;
	Thu, 16 Oct 2025 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760620589;
	bh=85/czp1CrNvrfLJmJ3GFw4gIrQI4QzjNEA4StXdNrx4=;
	h=Subject:To:Cc:From:Date:From;
	b=R+rd/opSb1Yu0BIt64WLlcmJ5ERgol73ghgI0xRmdhD0zlEJwowxhqigPPKmcQIFX
	 7RibHzQRPmpoCGGebbpje0wdL4DusbMzgdk/J+kA+xULA9b02FaHW6WiEEfZwQHRRe
	 NUZReEfF7E+WBMsg86iP6qbf9l9uBcgtwUaXZwP4=
Subject: FAILED: patch "[PATCH] PCI: tegra: Convert struct tegra_msi mask_lock into raw" failed to apply to 5.15-stable tree
To: marek.vasut+renesas@mailbox.org,bhelgaas@google.com,geert+renesas@glider.be,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:16:12 +0200
Message-ID: <2025101612-yahoo-uncurled-d9e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 26fda92d3b56bf44a02bcb4001c5a5548e0ae8ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101612-yahoo-uncurled-d9e5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26fda92d3b56bf44a02bcb4001c5a5548e0ae8ee Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
Date: Mon, 22 Sep 2025 17:07:48 +0200
Subject: [PATCH] PCI: tegra: Convert struct tegra_msi mask_lock into raw
 spinlock

The tegra_msi_irq_unmask() function may be called from a PCI driver
request_threaded_irq() function. This triggers kernel/irq/manage.c
__setup_irq() which locks raw spinlock &desc->lock descriptor lock
and with that descriptor lock held, calls tegra_msi_irq_unmask().

Since the &desc->lock descriptor lock is a raw spinlock, and the tegra_msi
.mask_lock is not a raw spinlock, this setup triggers 'BUG: Invalid wait
context' with CONFIG_PROVE_RAW_LOCK_NESTING=y.

Use scoped_guard() to simplify the locking.

Fixes: 2c99e55f7955 ("PCI: tegra: Convert to MSI domains")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://patchwork.kernel.org/project/linux-pci/patch/20250909162707.13927-2-marek.vasut+renesas@mailbox.org/#26574451
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250922150811.88450-1-marek.vasut+renesas@mailbox.org

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index bb88767a3797..942ddfca3bf6 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/export.h>
@@ -270,7 +271,7 @@ struct tegra_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
 	struct mutex map_lock;
-	spinlock_t mask_lock;
+	raw_spinlock_t mask_lock;
 	void *virt;
 	dma_addr_t phys;
 	int irq;
@@ -1581,14 +1582,13 @@ static void tegra_msi_irq_mask(struct irq_data *d)
 	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
 	struct tegra_pcie *pcie = msi_to_pcie(msi);
 	unsigned int index = d->hwirq / 32;
-	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
-	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
-	value &= ~BIT(d->hwirq % 32);
-	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
+		value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
+		value &= ~BIT(d->hwirq % 32);
+		afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
+	}
 }
 
 static void tegra_msi_irq_unmask(struct irq_data *d)
@@ -1596,14 +1596,13 @@ static void tegra_msi_irq_unmask(struct irq_data *d)
 	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
 	struct tegra_pcie *pcie = msi_to_pcie(msi);
 	unsigned int index = d->hwirq / 32;
-	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
-	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
-	value |= BIT(d->hwirq % 32);
-	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &msi->mask_lock) {
+		value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
+		value |= BIT(d->hwirq % 32);
+		afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
+	}
 }
 
 static void tegra_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
@@ -1711,7 +1710,7 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 	int err;
 
 	mutex_init(&msi->map_lock);
-	spin_lock_init(&msi->mask_lock);
+	raw_spin_lock_init(&msi->mask_lock);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = tegra_allocate_domains(msi);


