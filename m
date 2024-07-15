Return-Path: <stable+bounces-59352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB75B93159B
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 15:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6520E1F222A8
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7918E762;
	Mon, 15 Jul 2024 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="005uXhEI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmoErXPa"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E618D4D6;
	Mon, 15 Jul 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049642; cv=none; b=ByGLGZaJgnvCT/YCmHZB2YD37V90Llgza69D6ztpK//mIZsAMh9O41pd947kkvzezBvZ95keYF+YHGGLvUPi6GEfKL7fMCzhrM22nnpV6J9F3CUjw5pR0gvkXNSzumYgJKnK+DxveZKrimYJ41Qx6NwlVUq3JKVvI3Iy5VhFYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049642; c=relaxed/simple;
	bh=wLGdLu0qQckiDICmhDi1Ji4Yn3PhMPDZS1VRG/8F1y8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XYucYEsiXX7p65d/0tSyNksyD87usq3YW7fRi7K53jMhMcsc3ZIGOM/9eASSXWYyY3p3sQ1F38jRy+AQ1+LEpar+XOqYH9lFGEYCeZQTWHrOO+yIJIiUpjU3vwaeDJDMCbP3wmke+snwS8vq6LR9DwGMqfJUj+Tl8ezSjpgqDYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=005uXhEI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmoErXPa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jul 2024 13:20:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721049638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYaCVeE0wi2yZEzqFtnuUE0nbRMql5G/XocG4zSx27k=;
	b=005uXhEIzV+E/mke/Iw9c84d0CTXMcsKdgzN3VgeaCeIMixFbDXDZr8KZQVNVPDOSJecZk
	phpz/HTtvSGM1m/PqP/KBdmb/LIL3GnkAWhR5VNCr0Cql9toEuRmKgq/ZrHzyRmUAAsz05
	84nF9iTp9VtM63gKRb9HcY3Avf6cV3HGmln7dXziOnNQ5m1JDtRY/G38k0Js+3133HqfCe
	knDc1a16Qt3jak1u+ys5aTeenIuq47rEi1Z0IG7W9UFu1emfYCR3V87bf7bKfxWhGhzZ78
	EDUnplt/8w4ltEE7W50aPchCCB3hBfrnTkiv3Ltfsk2wxalH9NwMPz3IvNq3dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721049638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYaCVeE0wi2yZEzqFtnuUE0nbRMql5G/XocG4zSx27k=;
	b=wmoErXPajs29JdzZHoz/yLdku2RCKNAmn/zkOv6pxMq/bbBW4uf6wTiDRbOWo8+aXuGvme
	SvEPn2D3QA1GCBCA==
From: "tip-bot2 for Shenwei Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/imx-irqsteer: Handle runtime power management
 correctly
Cc: Shenwei Wang <shenwei.wang@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240703163250.47887-1-shenwei.wang@nxp.com>
References: <20240703163250.47887-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172104963751.2215.3695875382290467494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     33b1c47d1fc0b5f06a393bb915db85baacba18ea
Gitweb:        https://git.kernel.org/tip/33b1c47d1fc0b5f06a393bb915db85baacba18ea
Author:        Shenwei Wang <shenwei.wang@nxp.com>
AuthorDate:    Wed, 03 Jul 2024 11:32:50 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Jul 2024 15:13:56 +02:00

irqchip/imx-irqsteer: Handle runtime power management correctly

The power domain is automatically activated from clk_prepare(). However, on
certain platforms like i.MX8QM and i.MX8QXP, the power-on handling invokes
sleeping functions, which triggers the 'scheduling while atomic' bug in the
context switch path during device probing:

 BUG: scheduling while atomic: kworker/u13:1/48/0x00000002
 Call trace:
  __schedule_bug+0x54/0x6c
  __schedule+0x7f0/0xa94
  schedule+0x5c/0xc4
  schedule_preempt_disabled+0x24/0x40
  __mutex_lock.constprop.0+0x2c0/0x540
  __mutex_lock_slowpath+0x14/0x20
  mutex_lock+0x48/0x54
  clk_prepare_lock+0x44/0xa0
  clk_prepare+0x20/0x44
  imx_irqsteer_resume+0x28/0xe0
  pm_generic_runtime_resume+0x2c/0x44
  __genpd_runtime_resume+0x30/0x80
  genpd_runtime_resume+0xc8/0x2c0
  __rpm_callback+0x48/0x1d8
  rpm_callback+0x6c/0x78
  rpm_resume+0x490/0x6b4
  __pm_runtime_resume+0x50/0x94
  irq_chip_pm_get+0x2c/0xa0
  __irq_do_set_handler+0x178/0x24c
  irq_set_chained_handler_and_data+0x60/0xa4
  mxc_gpio_probe+0x160/0x4b0

Cure this by implementing the irq_bus_lock/sync_unlock() interrupt chip
callbacks and handle power management in them as they are invoked from
non-atomic context.

[ tglx: Rewrote change log, added Fixes tag ]

Fixes: 0136afa08967 ("irqchip: Add driver for imx-irqsteer controller")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240703163250.47887-1-shenwei.wang@nxp.com
---
 drivers/irqchip/irq-imx-irqsteer.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 20cf7a9..75a0e98 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -36,6 +36,7 @@ struct irqsteer_data {
 	int			channel;
 	struct irq_domain	*domain;
 	u32			*saved_reg;
+	struct device		*dev;
 };
 
 static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
@@ -72,10 +73,26 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
+static void imx_irqsteer_irq_bus_lock(struct irq_data *d)
+{
+	struct irqsteer_data *data = d->chip_data;
+
+	pm_runtime_get_sync(data->dev);
+}
+
+static void imx_irqsteer_irq_bus_sync_unlock(struct irq_data *d)
+{
+	struct irqsteer_data *data = d->chip_data;
+
+	pm_runtime_put_autosuspend(data->dev);
+}
+
 static const struct irq_chip imx_irqsteer_irq_chip = {
-	.name		= "irqsteer",
-	.irq_mask	= imx_irqsteer_irq_mask,
-	.irq_unmask	= imx_irqsteer_irq_unmask,
+	.name			= "irqsteer",
+	.irq_mask		= imx_irqsteer_irq_mask,
+	.irq_unmask		= imx_irqsteer_irq_unmask,
+	.irq_bus_lock		= imx_irqsteer_irq_bus_lock,
+	.irq_bus_sync_unlock	= imx_irqsteer_irq_bus_sync_unlock,
 };
 
 static int imx_irqsteer_irq_map(struct irq_domain *h, unsigned int irq,
@@ -150,6 +167,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->dev = &pdev->dev;
 	data->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->regs)) {
 		dev_err(&pdev->dev, "failed to initialize reg\n");

