Return-Path: <stable+bounces-186241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3666ABE679C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 07:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 350BF4F6CF6
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 05:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2326F44C;
	Fri, 17 Oct 2025 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBVDvstF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1E211A05;
	Fri, 17 Oct 2025 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680213; cv=none; b=Xbazzg77zpObAlYPqWd/HkulDP4fnXX00iitdj1Zg1DdHq4p4IaGc/tX4tVXvfeBgqvAruhRy+tRuipGdu/L1rhIsi1I9mQ7qqbvyPYPTRmJJW85vYX9Xw2f6n6yr/O/GFaXti5d6O+G+C+nenbr5xn9z0zN0Dy3p97CTe+7640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680213; c=relaxed/simple;
	bh=0b95OKl2hALGPyNplOZPKf4Y7VYqH6zj/9WkuCLnrGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNSyq4SjHXs6GYdSc3mnLzMBajpg1NitSajmwCZzEDB4QHkn31gnpvgYktbgYWHy5kRAuw/HeHOnHyp+GZ8rRrjfemMwbiAImQXOachgHJi0ezLkVZs1uZEQEkniu1UN6fs0apU8aVdop38xP26+/LxkPBmf8SDv6SbbArIjw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBVDvstF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA559C4CEE7;
	Fri, 17 Oct 2025 05:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760680212;
	bh=0b95OKl2hALGPyNplOZPKf4Y7VYqH6zj/9WkuCLnrGw=;
	h=From:To:Cc:Subject:Date:From;
	b=vBVDvstFTg+zrgGzMzNvURZhdz3IYQ7KzKj0zYZDCqWFWjIpyNOCI5llSvoLOnIvw
	 3nIK8flcDR7UQcEPLXnXJvUteIsG47jrOCZhPFYnKZFKAJmA0s4S9Op/ZEjE6CgCQn
	 mcKAgXQEQYLZJuQsEa1lOd/VTKcRLyKbLQPin1aka6bXS06/Bk4T5MbBzcfEDVP2GT
	 LIXun7FrwsFChNP+1mqQORoes4e52C6oGA6jsEAgNMGr24Nvhe+nFQTSkz3phvC23u
	 iueXMl/OYhyJPZt1hvmf3rT6CzD2tVIcyDtuuY+M3zv3kfFw/lxx8SoD8p01IXArcb
	 stWtvaRoXgdBg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v9dLz-000000001so-16IQ;
	Fri, 17 Oct 2025 07:50:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] clocksource/drivers/stm: Fix section mismatches
Date: Fri, 17 Oct 2025 07:49:43 +0200
Message-ID: <20251017054943.7195-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform drivers can be probed after their init sections have been
discarded (e.g. on probe deferral or manual rebind through sysfs) so the
probe function must not live in init. Device managed resource actions
similarly cannot be discarded.

The "_probe" suffix of the driver structure name prevents modpost from
warning about this so replace it to catch any similar future issues.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
Cc: stable@vger.kernel.org	# 6.16
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clocksource/timer-nxp-stm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index bbc40623728f..ce10bdcfc76b 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -177,15 +177,15 @@ static void nxp_stm_clocksource_resume(struct clocksource *cs)
 	nxp_stm_clocksource_enable(cs);
 }
 
-static void __init devm_clocksource_unregister(void *data)
+static void devm_clocksource_unregister(void *data)
 {
 	struct stm_timer *stm_timer = data;
 
 	clocksource_unregister(&stm_timer->cs);
 }
 
-static int __init nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_timer,
-					   const char *name, void __iomem *base, struct clk *clk)
+static int nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_timer,
+				    const char *name, void __iomem *base, struct clk *clk)
 {
 	int ret;
 
@@ -298,9 +298,9 @@ static void nxp_stm_clockevent_resume(struct clock_event_device *ced)
 	nxp_stm_module_get(stm_timer);
 }
 
-static int __init nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_timer *stm_timer,
-						  const char *name, void __iomem *base, int irq,
-						  struct clk *clk, int cpu)
+static int nxp_stm_clockevent_per_cpu_init(struct device *dev, struct stm_timer *stm_timer,
+					   const char *name, void __iomem *base, int irq,
+					   struct clk *clk, int cpu)
 {
 	stm_timer->base = base;
 	stm_timer->rate = clk_get_rate(clk);
@@ -388,7 +388,7 @@ static irqreturn_t nxp_stm_module_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init nxp_stm_timer_probe(struct platform_device *pdev)
+static int nxp_stm_timer_probe(struct platform_device *pdev)
 {
 	struct stm_timer *stm_timer;
 	struct device *dev = &pdev->dev;
@@ -484,14 +484,14 @@ static const struct of_device_id nxp_stm_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, nxp_stm_of_match);
 
-static struct platform_driver nxp_stm_probe = {
+static struct platform_driver nxp_stm_driver = {
 	.probe	= nxp_stm_timer_probe,
 	.driver	= {
 		.name		= "nxp-stm",
 		.of_match_table	= nxp_stm_of_match,
 	},
 };
-module_platform_driver(nxp_stm_probe);
+module_platform_driver(nxp_stm_driver);
 
 MODULE_DESCRIPTION("NXP System Timer Module driver");
 MODULE_LICENSE("GPL");
-- 
2.49.1


