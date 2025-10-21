Return-Path: <stable+bounces-188378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91FCBF7C0B
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187B3543038
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D83345CA9;
	Tue, 21 Oct 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfzbTiWt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D773B34A76E
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065036; cv=none; b=mfawv3Qhf75zJAayvSxDaadq2O5aDoECXfQNtBpt/wDKx2tWRWEhxKtEJ7f1sDurZ8dxw5EEj+XN0jHZEULHZstaJPw9MwtcAec+XAOxkdePUmqRbkWXS9E+VcAseTU9rjITM8WhM79A7ck4+4AqkIq07IAEDRD1QazTLr2NGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065036; c=relaxed/simple;
	bh=oLkF+w6D+rP0eyLeXfzsFkoyxsj/TGPfH8JidpRfbFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vhch8YQjH+gBNGPwcNF0S2/gtcG+gPxCEX1NJGiiWVCk3Agn2neDC6sQ8SHAtHwRVmLWHu2hKQJHlDaT7Oum8fWdfy8l0Jsxbliz2DrouHnleD5rOxHGW+AfOKy6u9yqZMxde1j0ILUvR1Uz2lX6sqViBrvjTGsU18miN7iO29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfzbTiWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEC5C4CEF5;
	Tue, 21 Oct 2025 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761065036;
	bh=oLkF+w6D+rP0eyLeXfzsFkoyxsj/TGPfH8JidpRfbFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfzbTiWthIcdWGBYz2agS5U92pl0sHl1GOY9rRebjINEUkG5Sh/SKXduz9iQlG88B
	 jhSE0jkvC8Dbju1h8lMpWHumTkdkRMY9SpsdaBL6bIEwnXiikjhz80Vg3+P9kI/XZl
	 OhxAJYSEB1f5LI08JavR8xJnFrMG1S+56g2djceyGleKZnQDB5IzXyWzEKTRCUd+Rz
	 d4/ZqvrgVWEtt/eNjhTTWyL1hRceaVzzi63V6JJ1G1RMM562fqH8uJmbWwbkf3o18H
	 pn6UkPm+EmZ99UDqGJ/pHsLyUKQy6QNPL7FvV6necWvcCKdKBwqyY+rYtZC+jwcg6y
	 vrz15P0COEBjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] PCI: rcar-host: Convert struct rcar_msi mask_lock into raw spinlock
Date: Tue, 21 Oct 2025 12:43:52 -0400
Message-ID: <20251021164352.2381251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101634-immunity-sinuous-afc9@gregkh>
References: <2025101634-immunity-sinuous-afc9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

[ Upstream commit 5ed35b4d490d8735021cce9b715b62a418310864 ]

The rcar_msi_irq_unmask() function may be called from a PCI driver
request_threaded_irq() function. This triggers kernel/irq/manage.c
__setup_irq() which locks raw spinlock &desc->lock descriptor lock
and with that descriptor lock held, calls rcar_msi_irq_unmask().

Since the &desc->lock descriptor lock is a raw spinlock, and the rcar_msi
.mask_lock is not a raw spinlock, this setup triggers 'BUG: Invalid wait
context' with CONFIG_PROVE_RAW_LOCK_NESTING=y.

Use scoped_guard() to simplify the locking.

Fixes: 83ed8d4fa656 ("PCI: rcar: Convert to MSI domains")
Reported-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Reported-by: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250909162707.13927-2-marek.vasut+renesas@mailbox.org
[ replaced scoped_guard() with explicit raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rcar-host.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index bfb13f358d073..3ceed9866de28 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -38,7 +38,7 @@ struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
 	struct mutex map_lock;
-	spinlock_t mask_lock;
+	raw_spinlock_t mask_lock;
 	int irq1;
 	int irq2;
 };
@@ -559,11 +559,11 @@ static void rcar_msi_irq_mask(struct irq_data *d)
 	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
+	raw_spin_lock_irqsave(&msi->mask_lock, flags);
 	value = rcar_pci_read_reg(pcie, PCIEMSIIER);
 	value &= ~BIT(d->hwirq);
 	rcar_pci_write_reg(pcie, value, PCIEMSIIER);
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	raw_spin_unlock_irqrestore(&msi->mask_lock, flags);
 }
 
 static void rcar_msi_irq_unmask(struct irq_data *d)
@@ -573,11 +573,11 @@ static void rcar_msi_irq_unmask(struct irq_data *d)
 	unsigned long flags;
 	u32 value;
 
-	spin_lock_irqsave(&msi->mask_lock, flags);
+	raw_spin_lock_irqsave(&msi->mask_lock, flags);
 	value = rcar_pci_read_reg(pcie, PCIEMSIIER);
 	value |= BIT(d->hwirq);
 	rcar_pci_write_reg(pcie, value, PCIEMSIIER);
-	spin_unlock_irqrestore(&msi->mask_lock, flags);
+	raw_spin_unlock_irqrestore(&msi->mask_lock, flags);
 }
 
 static int rcar_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
@@ -693,7 +693,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 	int err;
 
 	mutex_init(&msi->map_lock);
-	spin_lock_init(&msi->mask_lock);
+	raw_spin_lock_init(&msi->mask_lock);
 
 	err = of_address_to_resource(dev->of_node, 0, &res);
 	if (err)
-- 
2.51.0


