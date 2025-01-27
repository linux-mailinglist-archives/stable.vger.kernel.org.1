Return-Path: <stable+bounces-110850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FBCA1D437
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD383A7446
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36BA1FDA8A;
	Mon, 27 Jan 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbTufEtI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vXfLpQm1"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07381FCF74;
	Mon, 27 Jan 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972841; cv=none; b=mN2UePb4qAU08Y9mC8UPWZinTkHu5Z0yalHUu1O4QKYx6xPwN6YP8KEOCs4RIGrfIggMqZpzMS182EFTsvtZiur8emdSizMmR9I9GteNLwrB1iZTIMYjDzEnj5+BBM2A28xaYa4S1ed7p850LeMVjNwHJokDa+a1XyBo2yBO8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972841; c=relaxed/simple;
	bh=RU4GtH9PoHSei3GKlD+7r1QiWt9NWbnq5ep6r3EZiRQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wn3+MD2cPXBcmW5AQTc5JUOgr5GtZJbW4F6gan7Y7Zg5KVnNsdpXRCizLHX2WFOlO1Rgy4/eAYvpAut5Buk1JS2gXmJ3FGmn5ESL9YqCC8Pl8jtv22W7DF+RVLNc0Y8xeBeQysfPWygfNluvPsnQ89XeHRQhtWJx4lvFK4WdXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbTufEtI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vXfLpQm1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Jan 2025 10:13:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737972837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8RPJdnOLYb1VV70pyejfcDZRQCb2sW1Kaz3Xi4liIs=;
	b=BbTufEtIXCWbVHpyPHTdfcUO4Fu+89V1LDuAyXlDAXuWE3XbMp9e7GMVZsBkczCUVcRCMf
	I5LfK578CI8MiJBBJEzNa863Sw2uFXsAGCwbe/WwfussMhYfmiRrfl9wmJvOHzIKc6Ybpx
	URdmF6WVSufgEQLq8frGpOXqZbdzqZldJfXZHJOMzCQE0irOYKnLRPLhPEWj1twenE8dFH
	VucT6iYJCyHsrZrCK+ZkbVzlOakLtTM+AW0cHZtW65++Me0oBwKcfqxLJmfE5VcoDzfdTI
	mCJm3+kMxq/xo29PmfaAxBQOJLCdMCBPnhfJ4O4df+7ssrJT5LIDwfZ7ue7CdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737972837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8RPJdnOLYb1VV70pyejfcDZRQCb2sW1Kaz3Xi4liIs=;
	b=vXfLpQm1/GvFRK2M7Vt/Ar7rWdI+w7FLUYLNoLfYCsddxviZIk7y5GBk44FwfCmoxHmA1W
	ihwMbc5JwqwEZKCw==
From: "tip-bot2 for Stefan Eichenberger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-mvebu-icu: Fix access to msi_data from
 irq_domain::host_data
Cc: Stefan Eichenberger <eichest@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250124085140.44792-1-eichest@gmail.com>
References: <20250124085140.44792-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173797283644.31546.7475280911630632901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     987f379b54091cc1b1db986bde71cee1081350b3
Gitweb:        https://git.kernel.org/tip/987f379b54091cc1b1db986bde71cee1081350b3
Author:        Stefan Eichenberger <eichest@gmail.com>
AuthorDate:    Fri, 24 Jan 2025 09:50:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Jan 2025 11:07:03 +01:00

irqchip/irq-mvebu-icu: Fix access to msi_data from irq_domain::host_data

mvebu_icu_translate() incorrectly casts irq_domain::host_data directly to
mvebu_icu_msi_data. However, host_data actually points to a structure of
type msi_domain_info.

This incorrect cast causes issues such as the thermal sensors of the
CP110 platform malfunctioning. Specifically, the translation of the SEI
interrupt to IRQ_TYPE_EDGE_RISING fails, preventing proper interrupt
handling. The following error was observed:

  genirq: Setting trigger mode 4 for irq 85 failed (irq_chip_set_type_parent+0x0/0x34)
  armada_thermal f2400000.system-controller:thermal-sensor@70: Cannot request threaded IRQ 85

Resolve the issue by first casting host_data to msi_domain_info and then
accessing mvebu_icu_msi_data through msi_domain_info::chip_data.

Fixes: d929e4db22b6 ("irqchip/irq-mvebu-icu: Prepare for real per device MSI")
Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250124085140.44792-1-eichest@gmail.com
---
 drivers/irqchip/irq-mvebu-icu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index b337f6c..4eebed3 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -68,7 +68,8 @@ static int mvebu_icu_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
 	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
-	struct mvebu_icu_msi_data *msi_data = d->host_data;
+	struct msi_domain_info *info = d->host_data;
+	struct mvebu_icu_msi_data *msi_data = info->chip_data;
 	struct mvebu_icu *icu = msi_data->icu;
 
 	/* Check the count of the parameters in dt */

