Return-Path: <stable+bounces-132845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0ACA8B945
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF973AB033
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 12:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B51AAC4;
	Wed, 16 Apr 2025 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ULIcGC2Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ztfLpq2x"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7261FF2;
	Wed, 16 Apr 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806972; cv=none; b=XPQ43Ty2jdi3n4IuYQ2bHBmfMjWsa8H5AkqxC0boMitzKoiyiMmr5n/jX3GzMOOq2OYxuDWb5hmHGl2a+fQBDU+i3phByoRpdFKJ8WFoUNi2s0mA4BXWUwJNwgs1kr8kO3Dqb3fRGe1WkJYxw0vJ3GQAfXKL/0STTDotzEPQrQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806972; c=relaxed/simple;
	bh=xXW/qIC73ZXQc5SKwZ/3O9okzsn3uszkku216Ss9isM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=j5Wz2V7RMKsvjm0BhOcTowJrKIvNWXEMphWD/4DLAkAzjwdyg1PCknGxz1rWVGiO8erkOXWzE+YLQThOFpO7Y4XC/yAu+RzeFe4yrK4UQzmxb5zst/TQ0UVV5tIZcLNsWrugx8Y51uhkKcvEBovZ/C5jTgzVWD8YoE6VEoGIl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ULIcGC2Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ztfLpq2x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 12:36:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744806967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xbACqIsXLtfUSVUbKTROzSJSZ+vitTem3Z1K2PxpO9Q=;
	b=ULIcGC2Yj7eMb4b2ovSJPAZOn+VX9PdpbbxvEtptJbIZeu81yLqhezhQSCAJDdpcipKPf+
	pxzKi/0rlZQb0OBkt/uQ8Tax6hVIyT50vR2ALsbIfUndyoa6PWWjWmLjmcqc3hR9QrICpL
	Mi4/TU1zuWbF26RcvS1PinllrgR7tUCHfbm8+HAIoXmJOKOgymkCXvcSJCs5bU1N3PFuwR
	Gs9CaRXYcdzEwvAk3jmDfyNqn7udZuzrMQoedy7n2hQd64LpxzyvzssiuJB5XixDskAOqX
	5cix6Iso7yZeNHtLP+oXd0KoZWJPRU/QxtSfwIpzLxrQaHj6nVBshyh18rZ/zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744806967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xbACqIsXLtfUSVUbKTROzSJSZ+vitTem3Z1K2PxpO9Q=;
	b=ztfLpq2x5T2RwBXoKTwmD9dCLiF1UVj6hfyJnoY0XmUs+dXX188zZIsocJD2G0s9fWSWeJ
	h8YiFWZXtCk+1iBQ==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174480696622.31282.14198794613441313236.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     28e89cdac6482f3c980df3e2e245db7366269124
Gitweb:        https://git.kernel.org/tip/28e89cdac6482f3c980df3e2e245db7366269124
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Tue, 15 Apr 2025 11:33:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Apr 2025 14:29:38 +02:00

irqchip/renesas-rzv2h: Prevent TINT spurious interrupt

A spurious TINT interrupt is seen during boot on RZ/G3E SMARC EVK.

A glitch in the edge detection circuit can cause a spurious interrupt.

Clear the status flag after setting the ICU_TSSRk registers, which is
recommended in the hardware manual as a countermeasure.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org

---
 drivers/irqchip/irq-renesas-rzv2h.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 3d5b5fd..0f0fd7d 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -170,6 +170,14 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
 	else
 		tssr &= ~ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
+
+	/*
+	 * A glitch in the edge detection circuit can cause a spurious
+	 * interrupt. Clear the status flag after setting the ICU_TSSRk
+	 * registers, which is recommended by the hardware manual as a
+	 * countermeasure.
+	 */
+	writel_relaxed(BIT(tint_nr), priv->base + priv->info->t_offs + ICU_TSCLR);
 }
 
 static void rzv2h_icu_irq_disable(struct irq_data *d)

