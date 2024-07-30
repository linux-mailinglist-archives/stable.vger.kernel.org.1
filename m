Return-Path: <stable+bounces-62672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37511940CF8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC73E2872CF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8A194099;
	Tue, 30 Jul 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u/w3Dt/H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F07194A61
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330419; cv=none; b=BFdAQJHXNdkR3zRwZ0UQqkG0GvspD4xggnZesONGcxyekWz9lJ5OwOeIzsuEYkKiuT2n6Rdqh2TX6rQsglZMgZFyM0a6Tmqp2TA09msQhIr7/pA3oC/7f40eieQnMXRvdLmVeapYb4z7sn2L/QpMz4pHg1SyBTGvDlrJxluvV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330419; c=relaxed/simple;
	bh=a7qMJWvbYO1/j/R8eYAhw8csTOGC1rVlxOqXUEDBRik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=otERj/Yfq/0Zk9qwYvG59iiw7xxlmTE1rk7vsn7ZZP2fifr0by5dqtXDLbV1111Rm3yHkpWVA2i/BpLgbcnVCkA8BtCX+yaFUtmgnB1VWLCLkyyWKzhVp4g4KFSRDE2kZqWYP1Qz4iXZZxL0P9gNV6uiSERySniOuvURdNPJ7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u/w3Dt/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE402C4AF09;
	Tue, 30 Jul 2024 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722330419;
	bh=a7qMJWvbYO1/j/R8eYAhw8csTOGC1rVlxOqXUEDBRik=;
	h=Subject:To:Cc:From:Date:From;
	b=u/w3Dt/HJ1JuAbi1SzBIu0bNKaanDBdG4UUYyLA4EBvhOF4ajWO8Fc3D2Ot73GJe4
	 qnXi2FfBXUWI3NwNc8uEa7PgJCewPALz/R+NdGHatwV8TRcMM40OiqHOfV0AeQjCJr
	 Td4ao9cOufwiHARApophNd6IAxOAmscRAjPtWSCM=
Subject: FAILED: patch "[PATCH] irqchip/imx-irqsteer: Handle runtime power management" failed to apply to 5.4-stable tree
To: shenwei.wang@nxp.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:06:45 +0200
Message-ID: <2024073045-unsettled-food-6a9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 33b1c47d1fc0b5f06a393bb915db85baacba18ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073045-unsettled-food-6a9c@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

33b1c47d1fc0 ("irqchip/imx-irqsteer: Handle runtime power management correctly")
e9a50f12e579 ("irqchip/imx-irqsteer: Constify irq_chip struct")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33b1c47d1fc0b5f06a393bb915db85baacba18ea Mon Sep 17 00:00:00 2001
From: Shenwei Wang <shenwei.wang@nxp.com>
Date: Wed, 3 Jul 2024 11:32:50 -0500
Subject: [PATCH] irqchip/imx-irqsteer: Handle runtime power management
 correctly

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

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 20cf7a9e9ece..75a0e980ff35 100644
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


