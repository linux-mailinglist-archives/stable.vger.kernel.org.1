Return-Path: <stable+bounces-197030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53323C8A649
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 15:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDC8135837A
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7E8306B25;
	Wed, 26 Nov 2025 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PlbHt0X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MeKU58dz"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374343054FE;
	Wed, 26 Nov 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168047; cv=none; b=VDDRj+aH3uClZ7Yrhb94NFsrHRLVaLgBwcpim0I8k7GsJEpDrwIOF4TTdmchJOBKIbridp8n8v7FaGNyyxUpij++npFY3nfYQRfQdJF8v6Pao37ZAJDfgHwZ2P2lY5TsvSM6/jPsYiLPBNDqouJfXWLQOxj2U0xtrwgr0Ss06gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168047; c=relaxed/simple;
	bh=NzBdlCRgfSjrjDvboRdGEfSsOavaguFv7rWV71gf1ik=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VvteEmg95/meawnNRU5vc3jCf4+SGTsA2wqvOuD4VrzfeSmK6L+yW77/hJH0XmxF2uubCrHFN//68mQmZd2Nz3kKr2dOkBGExfKvONPGw6zwTIf5k3qU3aCCcv3lx/v3UHgMWNwBUKYuXPd1w1zUfPrGtIryH9cCvxVd1QIDil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PlbHt0X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MeKU58dz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CvF5y+5X+O/E3EWQ2F2V+F40TihEJQU6I5+eunHGow=;
	b=0PlbHt0X/Yl/7bgn+noVWliQB0m5L9aoeGUF9EDpfgk25Uw1MqDVboiw84bnSlqrRPHpPq
	DpSKFGS1uFKC/qJanOalrafEjrpzuBdkVpnBpVWQZZPBiQiekMn1n715XO/AZPn1PJUo66
	jBTPQx6phvDI911qmq2MnL78FMC09brHjErWPwT4x9z7W5tKtGmFvnPazM51/1B8O3mUQL
	m+Xd8iuFUuB9MXEWtuDdfW/+PuB24AFNAJEqtCkDpsK+AYQ2ZnspNK5jPQuox7Sbnkc1D3
	z7oxOqhdyO/+EPF5wU/HENjujPlFuwOXoyWehUCr2O8JjLHeAMXErqcPAB8HRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CvF5y+5X+O/E3EWQ2F2V+F40TihEJQU6I5+eunHGow=;
	b=MeKU58dzX65JtDqRjVNMYsmJr2JDXFecBcQ66G6vR63SM9i9IB071Zj7rj2i9hczGF670h
	vrp+6HNlHZefhQDw==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/nxp-stm: Fix section mismatches
Cc: Johan Hovold <johan@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.16@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251017054943.7195-1-johan@kernel.org>
References: <20251017054943.7195-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416804241.498.1076034337490505591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     b452d2c97eeccbf9c7ac5b3d2d9e80bf6d8a23db
Gitweb:        https://git.kernel.org/tip/b452d2c97eeccbf9c7ac5b3d2d9e80bf6d8=
a23db
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Fri, 17 Oct 2025 07:49:43 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:24:44 +01:00

clocksource/drivers/nxp-stm: Fix section mismatches

Platform drivers can be probed after their init sections have been
discarded (e.g. on probe deferral or manual rebind through sysfs) so the
probe function must not live in init. Device managed resource actions
similarly cannot be discarded.

The "_probe" suffix of the driver structure name prevents modpost from
warning about this so replace it to catch any similar future issues.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Mod=
ule for the s32gx platforms")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: stable@vger.kernel.org	# 6.16
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20251017054943.7195-1-johan@kernel.org
---
 drivers/clocksource/timer-nxp-stm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-=
nxp-stm.c
index 16d5216..c320d76 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -177,15 +177,15 @@ static void nxp_stm_clocksource_resume(struct clocksour=
ce *cs)
 	nxp_stm_clocksource_enable(cs);
 }
=20
-static void __init devm_clocksource_unregister(void *data)
+static void devm_clocksource_unregister(void *data)
 {
 	struct stm_timer *stm_timer =3D data;
=20
 	clocksource_unregister(&stm_timer->cs);
 }
=20
-static int __init nxp_stm_clocksource_init(struct device *dev, struct stm_ti=
mer *stm_timer,
-					   const char *name, void __iomem *base, struct clk *clk)
+static int nxp_stm_clocksource_init(struct device *dev, struct stm_timer *st=
m_timer,
+				    const char *name, void __iomem *base, struct clk *clk)
 {
 	int ret;
=20
@@ -296,9 +296,9 @@ static void nxp_stm_clockevent_resume(struct clock_event_=
device *ced)
 	nxp_stm_module_get(stm_timer);
 }
=20
-static int __init nxp_stm_clockevent_per_cpu_init(struct device *dev, struct=
 stm_timer *stm_timer,
-						  const char *name, void __iomem *base, int irq,
-						  struct clk *clk, int cpu)
+static int nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_ti=
mer *stm_timer,
+					   const char *name, void __iomem *base, int irq,
+					   struct clk *clk, int cpu)
 {
 	stm_timer->base =3D base;
 	stm_timer->rate =3D clk_get_rate(clk);
@@ -386,7 +386,7 @@ static irqreturn_t nxp_stm_module_interrupt(int irq, void=
 *dev_id)
 	return IRQ_HANDLED;
 }
=20
-static int __init nxp_stm_timer_probe(struct platform_device *pdev)
+static int nxp_stm_timer_probe(struct platform_device *pdev)
 {
 	struct stm_timer *stm_timer;
 	struct device *dev =3D &pdev->dev;
@@ -482,14 +482,14 @@ static const struct of_device_id nxp_stm_of_match[] =3D=
 {
 };
 MODULE_DEVICE_TABLE(of, nxp_stm_of_match);
=20
-static struct platform_driver nxp_stm_probe =3D {
+static struct platform_driver nxp_stm_driver =3D {
 	.probe	=3D nxp_stm_timer_probe,
 	.driver	=3D {
 		.name		=3D "nxp-stm",
 		.of_match_table	=3D nxp_stm_of_match,
 	},
 };
-module_platform_driver(nxp_stm_probe);
+module_platform_driver(nxp_stm_driver);
=20
 MODULE_DESCRIPTION("NXP System Timer Module driver");
 MODULE_LICENSE("GPL");

