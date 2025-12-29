Return-Path: <stable+bounces-203505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0D0CE68E2
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEBDB3004CF5
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8322230C359;
	Mon, 29 Dec 2025 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JXGnabRg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9D2E62A4
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008268; cv=none; b=E9TIXdvukLgLVtmsq9/YuQ5N0m05PdhGny79IbVKMheqe9hZFOcjo/C9Me8xtS0h2Zy424Ze3z9rhI1GeGn21pyoJgAhsE2Mn6S/wiu7JlmoZSKlvPGEsgs0Lr6GCGHv5ihJdPaTx7Kfap6vtPLMsbPs9fnmqinN+ZZSEs1qRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008268; c=relaxed/simple;
	bh=y6QwFqrRf2+X/4+nD7SO7lHE6+so5Hu3jOztyRdbclo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cvmhcjgAa3SEmkq8Pu316yNOfvpTs5walgFB/dNIvkILn18rBEXKYPOb8KaxrNwHCNYOPh0bm27es1a17pTgehwoZkry0IVrP8ekj2O9tG4kj3vtna4+rXlLhKudJyOFaYZbEdsBrCeGyBW6Ws2Ag5jtohxDeGWhv1TBFQxopHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JXGnabRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787B2C4CEF7;
	Mon, 29 Dec 2025 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008265;
	bh=y6QwFqrRf2+X/4+nD7SO7lHE6+so5Hu3jOztyRdbclo=;
	h=Subject:To:Cc:From:Date:From;
	b=JXGnabRg+1T2sk9ebZxu5u/VesTJjhqHz2bm0+IysXKcuW4Ic8o8Yj4nVGRrDCKOb
	 AOEl1H1dbcxMDWoX+YfAJGwtgdRcT4KVfa58l9MDQc9D4fdZDr50XPSfLOzggzXjSx
	 QWK7llkr/mClUlBEEKzqpkX9b4xqT/jhVuqcGlHc=
Subject: FAILED: patch "[PATCH] clocksource/drivers/nxp-stm: Fix section mismatches" failed to apply to 6.18-stable tree
To: johan@kernel.org,daniel.lezcano@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:37:43 +0100
Message-ID: <2025122943-snowbound-unpack-801e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b452d2c97eeccbf9c7ac5b3d2d9e80bf6d8a23db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122943-snowbound-unpack-801e@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b452d2c97eeccbf9c7ac5b3d2d9e80bf6d8a23db Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 17 Oct 2025 07:49:43 +0200
Subject: [PATCH] clocksource/drivers/nxp-stm: Fix section mismatches

Platform drivers can be probed after their init sections have been
discarded (e.g. on probe deferral or manual rebind through sysfs) so the
probe function must not live in init. Device managed resource actions
similarly cannot be discarded.

The "_probe" suffix of the driver structure name prevents modpost from
warning about this so replace it to catch any similar future issues.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: stable@vger.kernel.org	# 6.16
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20251017054943.7195-1-johan@kernel.org

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index 16d52167e949..c320d764b12e 100644
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
 
@@ -296,9 +296,9 @@ static void nxp_stm_clockevent_resume(struct clock_event_device *ced)
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
@@ -386,7 +386,7 @@ static irqreturn_t nxp_stm_module_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init nxp_stm_timer_probe(struct platform_device *pdev)
+static int nxp_stm_timer_probe(struct platform_device *pdev)
 {
 	struct stm_timer *stm_timer;
 	struct device *dev = &pdev->dev;
@@ -482,14 +482,14 @@ static const struct of_device_id nxp_stm_of_match[] = {
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


