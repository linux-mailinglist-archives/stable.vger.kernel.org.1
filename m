Return-Path: <stable+bounces-140624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 458FCAAAE71
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2CD166F64
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2C0381EA0;
	Mon,  5 May 2025 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxPr68KW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289A2D0ADC;
	Mon,  5 May 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485454; cv=none; b=fXmBtZ8w6XNqbHgAs+Fga89Bu0AnLIEIUcdx/CJp+JXXppiUUuFsTJdSjTun5qGOl8rsHz7EIfifOa6nN7MFj+fGeYhbHWN4OgXKjlhnnEyCBcdL+MK0eMI8RfxUpJQtuCtm6IU2EwVHmx6/gTx0JKMOPnVEAgBzVVCeqBmvwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485454; c=relaxed/simple;
	bh=WG6h0YozOTRuKa/hRcDZ+ntlBYNJHMUhoxiLBf1qQVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0XKy08Ef+gUBJ27lPK38r/YVqxgZnKEQjO6FKMCxCdz/ifDMVrwjU0Pg7a4zskgODTqJH328Z1N7DJ9NWfDs/MWaKRW0yWcg5g7850l5y8Q/lEweTVxdiN+SGW4Coe9ztKaXG5yBwcm3HE711ieeTj3BAk0msig3FoPGTUZkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxPr68KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F0CC4CEEE;
	Mon,  5 May 2025 22:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485453;
	bh=WG6h0YozOTRuKa/hRcDZ+ntlBYNJHMUhoxiLBf1qQVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxPr68KW7lBV2ZqgriVyy2JqPGULTNHlUTPn0q/N20pBs4GYCZK3S9aE57XblJhVj
	 /s6cMnTMwFIvb5NcLM/ivuF1j2LsHt0oQQiuB+h1Gw/zhbIM6WjKPd3KrXNN7zyjo0
	 AHD2g3t4+sgxEq1AcEtiCE1B/5xYWh1H37mdO0JP88jMPyQHjzU8WgNRjRr+NjyxUF
	 fjU4QKsfI58IRDrhQAD8/hyyaDsL6FP4zYirdATsC0j1tb2VqcKVhKTzcW22tdhcVn
	 /omIhMJDUcBJcd1K0Q2eqb/AMTjrgOOzJYznjdIKBkooJaWk88A3QsOEBeKBgWKEfC
	 MCf+QcDj6GSGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	anup@brainfault.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 319/486] irqchip/riscv-imsic: Set irq_set_affinity() for IMSIC base
Date: Mon,  5 May 2025 18:36:35 -0400
Message-Id: <20250505223922.2682012-319-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Andrew Jones <ajones@ventanamicro.com>

[ Upstream commit 999f458c1771354371ba367dd84f55f9a62a4233 ]

The IMSIC driver assigns the IMSIC domain specific imsic_irq_set_affinity()
callback to the per device leaf MSI domain. That's a layering violation as
it is called with the leaf domain data and not with the IMSIC domain
data. This prevents moving the IMSIC driver to the common MSI library which
uses the generic msi_domain_set_affinity() callback for device MSI domains.

Instead of using imsic_irq_set_affinity() for leaf MSI domains, use
imsic_irq_set_affinity() for the non-leaf IMSIC base domain and use
irq_chip_set_affinity_parent() for leaf MSI domains.

[ tglx: Massaged change log ]

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250217085657.789309-2-apatel@ventanamicro.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index c708780e8760f..5d7c30ad8855b 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -96,9 +96,8 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 				  bool force)
 {
 	struct imsic_vector *old_vec, *new_vec;
-	struct irq_data *pd = d->parent_data;
 
-	old_vec = irq_data_get_irq_chip_data(pd);
+	old_vec = irq_data_get_irq_chip_data(d);
 	if (WARN_ON(!old_vec))
 		return -ENOENT;
 
@@ -116,13 +115,13 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 		return -ENOSPC;
 
 	/* Point device to the new vector */
-	imsic_msi_update_msg(d, new_vec);
+	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
 
 	/* Update irq descriptors with the new vector */
-	pd->chip_data = new_vec;
+	d->chip_data = new_vec;
 
-	/* Update effective affinity of parent irq data */
-	irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
+	/* Update effective affinity */
+	irq_data_update_effective_affinity(d, cpumask_of(new_vec->cpu));
 
 	/* Move state of the old vector to the new vector */
 	imsic_vector_move(old_vec, new_vec);
@@ -135,6 +134,9 @@ static struct irq_chip imsic_irq_base_chip = {
 	.name			= "IMSIC",
 	.irq_mask		= imsic_irq_mask,
 	.irq_unmask		= imsic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= imsic_irq_set_affinity,
+#endif
 	.irq_retrigger		= imsic_irq_retrigger,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE |
@@ -245,7 +247,7 @@ static bool imsic_init_dev_msi_info(struct device *dev,
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
 #ifdef CONFIG_SMP
-		info->chip->irq_set_affinity = imsic_irq_set_affinity;
+		info->chip->irq_set_affinity = irq_chip_set_affinity_parent;
 #endif
 		break;
 	default:
-- 
2.39.5


