Return-Path: <stable+bounces-39254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E8C8A260B
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 07:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5FFEB217A8
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 05:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7285F1C2B3;
	Fri, 12 Apr 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="MMbS1CJM"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3058168DE
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901412; cv=none; b=DWBNgXaLa1X/D0y0/qiprPqfDaeOVInxWTxK3eK2UW86ugVT1A8nFGwvC2KbrLZwmE7/jAsPCNvyMc0i9rYWdI8LCzUjFW/1uprS2Yzb9pnLnadfriHPPfNbsGAuziLHLaLAXzBpNDQLqlCqEHU0VFndg8Ke0/QiPz8d50Lhr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901412; c=relaxed/simple;
	bh=/hE2FZYdTR+XdTQ7s5naYHNbQz8h9iRavaSnlFEIPBc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZttxQWl227RF23X2TomX0jWAlv2j70LjFvm3LQHZDP4Ez+AwIqP/jvD+7eqxpM8ro/L7smpdhnl77klKAjP5iNh3NcWRWZovhDBl5X4XwMX4JtSX7oqsh0X6BlWQT+AcNr7nOu6IhOMuch2hlyVmUkAkJlRzzdJke2mRBE4nBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=MMbS1CJM; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1712901410;
	bh=/hE2FZYdTR+XdTQ7s5naYHNbQz8h9iRavaSnlFEIPBc=;
	h=From:To:Subject:Date:From;
	b=MMbS1CJMJjLTRFOCI6cqXxUZ1Qy56cb7CQKIeWhb2XHzsmldoPMzgdZYuInmCZm/h
	 1IaUsbvCJAUJ1CgY1LAa9G4z5k6HCcxDtsG0em1MzMQfGYFeiNw/gYkAG/IovddbYM
	 NQHiqmaG7Sv6jz7aBHyr65mf15VDE6RlEpQB0i4FCkbCVm+eW59M/PE+2GOBqlUPof
	 w1Xm8En2TOBDD3plNSfqoQToq9Ar9haNVnCRgRdE2vH/MGi1dCeevk7PLmr5lx1t5W
	 KMoHVAO2n9U79lU04fOWKBVJvcW8jWfs+IXQhnwhY2ug1BqtBi1B9Z39yqZfq5HdHM
	 d2svpDdlRpOYg==
Received: from sv-prius.atmark-techno.com (sodcd-04p2-40.ppp11.odn.ad.jp [203.139.65.40])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id F021D283
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 14:56:49 +0900 (JST)
Received: from PC-0139.atmark.tech (unknown [172.16.20.15])
	by sv-prius.atmark-techno.com (Postfix) with ESMTP id B697EDEDFB
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 14:56:49 +0900 (JST)
From: Daisuke Mizobuchi <mizo@atmark-techno.com>
To: stable@vger.kernel.org
Subject: [PATCH v2 5.10.y 1/1] mailbox: imx: fix suspend failure
Date: Fri, 12 Apr 2024 14:56:48 +0900
Message-Id: <20240412055648.1807780-1-mizo@atmark-techno.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_mu_isr() always calls pm_system_wakeup() even when it should not,
making the system unable to enter sleep.

Suspend fails as follows:
 armadillo:~# echo mem > /sys/power/state
 [ 2614.602432] PM: suspend entry (deep)
 [ 2614.610640] Filesystems sync: 0.004 seconds
 [ 2614.618016] Freezing user space processes ... (elapsed 0.001 seconds) done.
 [ 2614.626555] OOM killer disabled.
 [ 2614.629792] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
 [ 2614.638456] printk: Suspending console(s) (use no_console_suspend to debug)
 [ 2614.649504] PM: Some devices failed to suspend, or early wake event detected
 [ 2614.730103] PM: resume devices took 0.080 seconds
 [ 2614.741924] OOM killer enabled.
 [ 2614.745073] Restarting tasks ... done.
 [ 2614.754532] PM: suspend exit
 ash: write error: Resource busy
 armadillo:~#

Upstream commit 892cb524ae8a is correct, so this seems to be a
mistake during cherry-pick.

Cc: <stable@vger.kernel.org>
Fixes: a16f5ae8ade1 ("mailbox: imx: fix wakeup failure from freeze mode")
Signed-off-by: Daisuke Mizobuchi <mizo@atmark-techno.com>
Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
 drivers/mailbox/imx-mailbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index c5663398c6b7..28f5450e4130 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -331,8 +331,6 @@ static int imx_mu_startup(struct mbox_chan *chan)
 		break;
 	}
 
-	priv->suspend = true;
-
 	return 0;
 }
 
@@ -550,8 +548,6 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->clk);
 
-	priv->suspend = false;
-
 	return 0;
 
 disable_runtime_pm:
@@ -614,6 +610,8 @@ static int __maybe_unused imx_mu_suspend_noirq(struct device *dev)
 	if (!priv->clk)
 		priv->xcr = imx_mu_read(priv, priv->dcfg->xCR);
 
+	priv->suspend = true;
+
 	return 0;
 }
 
@@ -632,6 +630,8 @@ static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 	if (!imx_mu_read(priv, priv->dcfg->xCR) && !priv->clk)
 		imx_mu_write(priv, priv->xcr, priv->dcfg->xCR);
 
+	priv->suspend = false;
+
 	return 0;
 }
 
-- 
2.30.2


