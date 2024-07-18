Return-Path: <stable+bounces-60549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E141934CD6
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 13:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB381F22138
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 11:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D2413AD3F;
	Thu, 18 Jul 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ckuThTXe"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEBD136E0E;
	Thu, 18 Jul 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303750; cv=none; b=WSvYZwUJvIDTkAHCqvdGCe3b7UCSQgZNEcrwUxcJNxiFgZP1p0Vohla6mjwyPlxo62d/FYSxDvPiktsrznU7TI4NaBvpbrJ5cJMmgi9vlxAjO+5t2oXDF4xpui8BNMiQhL/jHVpvLVSWAQtcoKBZvrdenmOq8KXCs47sw32khZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303750; c=relaxed/simple;
	bh=029LAo/pYKr35+tfCs0piM+iVcIGrKRcZIYKEHMEQFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLffVvWcVrmbxfiClJ4kRZ65JzCcIDUyFIGWc4ogsk2milVWlrPpjJPtC9LUpFjiBRvjUMg9X8OmbUeCfeggBaNZu3UQNq1anyLi/rJoR9wHuymdQldYmb6M2uu5QZ2PXN3AABR5C1rXjF7SF+6MCDcvV6Kkm20Jkv9vxpVfLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ckuThTXe; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B8916FF80D;
	Thu, 18 Jul 2024 11:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721303739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+UjG9y/mBegZG+JDojXdJxow1fhyw1O/olkRn6CLmGs=;
	b=ckuThTXeYm+mnHLisQk40c3sQqjwBRt4pI0wZByC3xJHL1aCsmdlFhXMaJG+1M1NUGD6uo
	TEimUtgnSZN33ShpRNLqVt57Qr9yQRfr9cn7iFwxxZa0gACtqu9BjKLgnkh9ikHJl56WfK
	GaWVl1JOt5j8eEo5uwgqDQXZRyS5Tcny4BOImma4XdNmdqx7Qidy5yPUcnntOPIXb1Qg0j
	TQVg6GkEPKPJoIlpuwPpg5u3QVWYj1+TeZucWGgVx5yGyRS1Qyev8Ck7ZfY2tLPPApzXVZ
	wRPLH3YLGu05aN5jZCsmdYPRJhrb2xNHcqgV0M0BP4bPP+yZIzqnoBYWx9Ra/Q==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] clk: davinci: da8xx-cfgchip: Initialize clk_init_data before use
Date: Thu, 18 Jul 2024 13:55:34 +0200
Message-ID: <20240718115534.41513-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The flag attribute of the struct clk_init_data isn't initialized before
the devm_clk_hw_register() call. This can lead to unexpected behavior
during registration.

Initialize the entire clk_init_data to zero at declaration.

Cc: stable@vger.kernel.org
Fixes: 58e1e2d2cd89 ("clk: davinci: cfgchip: Add TI DA8XX USB PHY clocks")
Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
Changes in v2:
	Add Cc and Fixes tags
	Add Reviewed-by David

v1: https://lore.kernel.org/all/20240717141201.64125-1-bastien.curutchet@bootlin.com/

 drivers/clk/davinci/da8xx-cfgchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index ad2d0df43dc6..ec60ecb517f1 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -508,7 +508,7 @@ da8xx_cfgchip_register_usb0_clk48(struct device *dev,
 	const char * const parent_names[] = { "usb_refclkin", "pll0_auxclk" };
 	struct clk *fck_clk;
 	struct da8xx_usb0_clk48 *usb0;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	fck_clk = devm_clk_get(dev, "fck");
@@ -583,7 +583,7 @@ da8xx_cfgchip_register_usb1_clk48(struct device *dev,
 {
 	const char * const parent_names[] = { "usb0_clk48", "usb_refclkin" };
 	struct da8xx_usb1_clk48 *usb1;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	usb1 = devm_kzalloc(dev, sizeof(*usb1), GFP_KERNEL);
-- 
2.45.0


