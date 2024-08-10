Return-Path: <stable+bounces-66306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9A94DB8C
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 10:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3BE1F21EAF
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F24714D444;
	Sat, 10 Aug 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ljiuYpet";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="74XQaywc"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF114C5B5;
	Sat, 10 Aug 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723279521; cv=none; b=UiCLAsn7jfoBo37Xj/LSpzHBsoG8xMIjFt8w6cDBU/P/eQtV4JKPGLr1m5MXf6kj9lNZwZrpbjmOyXkVkTvH6r7052RNA6Y2geAfHlhQjVGcwwXq/ppf6CNDZ8TRiP73Up3/cmrK0ESJ+QOra07v1+EZaAXh9tCyK6JFmLvTwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723279521; c=relaxed/simple;
	bh=ilpXUuTUXGs5exW2A+RhdHqgfWS/fpbIuz78AEWYgCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AfI+wx2+yW2QDKg9oUhFxRz+re+WPPB37Z13Efsa+5DWAJFGpP8SJG2tPy1Eqir7u0pOrhSLeAqrxpzazMyMIBYo2DeQ1s7LWnakzcMnUDf4ap3+X2PqlgsksSi2se5zpbXx2IlMwbPb+A0u2RQxzBb0IpsyHH/5CqLPdKNjI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ljiuYpet; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=74XQaywc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Aug 2024 08:45:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723279518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qoXMfZjLY0rWS4/ESdXfLyEJcJJFrL/q2UORtfRycsE=;
	b=ljiuYpetE2p7mxRqnsOu3CXVVv0wxW397kSTSYSrNzVc8x1ieagvsHcBkjtVMoS3Pa5+ze
	1Yu5Ayakpftf++5507xHyQK/mIA423gDw0TcyYRuot0zLR9x/ua8Zmb4u8ySF20+4sgJUY
	rHp6cxygrOLuopck+Cft17TUOPqPwaoX7r+Ph1HAuroYBhPze/4v+QIdMaH6MTGQ16e91D
	BS40BFZU2DGnz1s0vAoidrXZXEGwQGFBEd2P2BVItMwkJVKDHgKWwPTFVD1MpWCTt3Z5kk
	SRzTxLM0IMyWKrkT9LQwAQc5jwnUpn1URwcn2xIl5Qd7KHxGWL6ADYMFstTmbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723279518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qoXMfZjLY0rWS4/ESdXfLyEJcJJFrL/q2UORtfRycsE=;
	b=74XQaywcfwHVzMR3xL+MwKz50ZdbeBvkIjrBhiYt2tioElH3q8zFIzufyHxp4nsrzEZ34e
	IqwtUnlc0SeeMTAQ==
From: "tip-bot2 for Yong-Xuan Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-aplic: Retrigger MSI interrupt on
 source configuration
Cc: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <vincent.chen@sifive.com>,
 Anup Patel <anup@brainfault.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240809071049.2454-1-yongxuan.wang@sifive.com>
References: <20240809071049.2454-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172327951735.2215.9481646283292037219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     03f9885c60adf73488fe32aab628ee3d4a39598e
Gitweb:        https://git.kernel.org/tip/03f9885c60adf73488fe32aab628ee3d4a39598e
Author:        Yong-Xuan Wang <yongxuan.wang@sifive.com>
AuthorDate:    Fri, 09 Aug 2024 15:10:47 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 10 Aug 2024 10:42:04 +02:00

irqchip/riscv-aplic: Retrigger MSI interrupt on source configuration

The section 4.5.2 of the RISC-V AIA specification says that "any write
to a sourcecfg register of an APLIC might (or might not) cause the
corresponding interrupt-pending bit to be set to one if the rectified
input value is high (= 1) under the new source mode."

When the interrupt type is changed in the sourcecfg register, the APLIC
device might not set the corresponding pending bit, so the interrupt might
never become pending.

To handle sourcecfg register changes for level-triggered interrupts in MSI
mode, manually set the pending bit for retriggering interrupt so it gets
retriggered if it was already asserted.

Fixes: ca8df97fe679 ("irqchip/riscv-aplic: Add support for MSI-mode")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240809071049.2454-1-yongxuan.wang@sifive.com
---
 drivers/irqchip/irq-riscv-aplic-msi.c | 32 ++++++++++++++++++++------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 028444a..d7773f7 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -32,15 +32,10 @@ static void aplic_msi_irq_unmask(struct irq_data *d)
 	aplic_irq_unmask(d);
 }
 
-static void aplic_msi_irq_eoi(struct irq_data *d)
+static void aplic_msi_irq_retrigger_level(struct irq_data *d)
 {
 	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
 
-	/*
-	 * EOI handling is required only for level-triggered interrupts
-	 * when APLIC is in MSI mode.
-	 */
-
 	switch (irqd_get_trigger_type(d)) {
 	case IRQ_TYPE_LEVEL_LOW:
 	case IRQ_TYPE_LEVEL_HIGH:
@@ -59,6 +54,29 @@ static void aplic_msi_irq_eoi(struct irq_data *d)
 	}
 }
 
+static void aplic_msi_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * EOI handling is required only for level-triggered interrupts
+	 * when APLIC is in MSI mode.
+	 */
+	aplic_msi_irq_retrigger_level(d);
+}
+
+static int aplic_msi_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	int rc = aplic_irq_set_type(d, type);
+
+	if (rc)
+		return rc;
+	/*
+	 * Updating sourcecfg register for level-triggered interrupts
+	 * requires interrupt retriggering when APLIC is in MSI mode.
+	 */
+	aplic_msi_irq_retrigger_level(d);
+	return 0;
+}
+
 static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	unsigned int group_index, hart_index, guest_index, val;
@@ -130,7 +148,7 @@ static const struct msi_domain_template aplic_msi_template = {
 		.name			= "APLIC-MSI",
 		.irq_mask		= aplic_msi_irq_mask,
 		.irq_unmask		= aplic_msi_irq_unmask,
-		.irq_set_type		= aplic_irq_set_type,
+		.irq_set_type		= aplic_msi_irq_set_type,
 		.irq_eoi		= aplic_msi_irq_eoi,
 #ifdef CONFIG_SMP
 		.irq_set_affinity	= irq_chip_set_affinity_parent,

