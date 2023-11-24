Return-Path: <stable+bounces-910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9527F7D1A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3F3B21684
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014313A8C3;
	Fri, 24 Nov 2023 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ifowRLJ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B933063;
	Fri, 24 Nov 2023 18:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34412C433C8;
	Fri, 24 Nov 2023 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850083;
	bh=mRCq2o40ZoqCOw+6u5zz2kqA54fTtldLV1Uxg5KWKDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifowRLJ4xJz4i3JIcMRl0Jwhlmn7p7WZcQsN+qdKT+wg0aXKCxEkSQFXC6U+2T5aV
	 80Gg3ZKadHWrDTZNSdd0R0XDu7C4LsVxuiotyzGeyc64tXMYAqDrVia5oz4bxYqbfH
	 NCK58mgQFcKLTojvw5GKx9aW0qblCEB3Wf6JpZ+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Marko <robert.marko@sartura.hr>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 6.6 439/530] Revert "i2c: pxa: move to generic GPIO recovery"
Date: Fri, 24 Nov 2023 17:50:05 +0000
Message-ID: <20231124172041.449524255@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Marko <robert.marko@sartura.hr>

commit 7b211c7671212cad0b83603c674838c7e824d845 upstream.

This reverts commit 0b01392c18b9993a584f36ace1d61118772ad0ca.

Conversion of PXA to generic I2C recovery, makes the I2C bus completely
lock up if recovery pinctrl is present in the DT and I2C recovery is
enabled.

So, until the generic I2C recovery can also work with PXA lets revert
to have working I2C and I2C recovery again.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: stable@vger.kernel.org # 5.11+
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-pxa.c |   76 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 8 deletions(-)

--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -264,6 +264,9 @@ struct pxa_i2c {
 	u32			hs_mask;
 
 	struct i2c_bus_recovery_info recovery;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pinctrl_default;
+	struct pinctrl_state	*pinctrl_recovery;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -1300,12 +1303,13 @@ static void i2c_pxa_prepare_recovery(str
 	 */
 	gpiod_set_value(i2c->recovery.scl_gpiod, ibmr & IBMR_SCLS);
 	gpiod_set_value(i2c->recovery.sda_gpiod, ibmr & IBMR_SDAS);
+
+	WARN_ON(pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_recovery));
 }
 
 static void i2c_pxa_unprepare_recovery(struct i2c_adapter *adap)
 {
 	struct pxa_i2c *i2c = adap->algo_data;
-	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
 	u32 isr;
 
 	/*
@@ -1319,7 +1323,7 @@ static void i2c_pxa_unprepare_recovery(s
 		i2c_pxa_do_reset(i2c);
 	}
 
-	WARN_ON(pinctrl_select_state(bri->pinctrl, bri->pins_default));
+	WARN_ON(pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_default));
 
 	dev_dbg(&i2c->adap.dev, "recovery: IBMR 0x%08x ISR 0x%08x\n",
 	        readl(_IBMR(i2c)), readl(_ISR(i2c)));
@@ -1341,20 +1345,76 @@ static int i2c_pxa_init_recovery(struct
 	if (IS_ENABLED(CONFIG_I2C_PXA_SLAVE))
 		return 0;
 
-	bri->pinctrl = devm_pinctrl_get(dev);
-	if (PTR_ERR(bri->pinctrl) == -ENODEV) {
-		bri->pinctrl = NULL;
+	i2c->pinctrl = devm_pinctrl_get(dev);
+	if (PTR_ERR(i2c->pinctrl) == -ENODEV)
+		i2c->pinctrl = NULL;
+	if (IS_ERR(i2c->pinctrl))
+		return PTR_ERR(i2c->pinctrl);
+
+	if (!i2c->pinctrl)
+		return 0;
+
+	i2c->pinctrl_default = pinctrl_lookup_state(i2c->pinctrl,
+						    PINCTRL_STATE_DEFAULT);
+	i2c->pinctrl_recovery = pinctrl_lookup_state(i2c->pinctrl, "recovery");
+
+	if (IS_ERR(i2c->pinctrl_default) || IS_ERR(i2c->pinctrl_recovery)) {
+		dev_info(dev, "missing pinmux recovery information: %ld %ld\n",
+			 PTR_ERR(i2c->pinctrl_default),
+			 PTR_ERR(i2c->pinctrl_recovery));
+		return 0;
+	}
+
+	/*
+	 * Claiming GPIOs can influence the pinmux state, and may glitch the
+	 * I2C bus. Do this carefully.
+	 */
+	bri->scl_gpiod = devm_gpiod_get(dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
+	if (bri->scl_gpiod == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+	if (IS_ERR(bri->scl_gpiod)) {
+		dev_info(dev, "missing scl gpio recovery information: %pe\n",
+			 bri->scl_gpiod);
+		return 0;
+	}
+
+	/*
+	 * We have SCL. Pull SCL low and wait a bit so that SDA glitches
+	 * have no effect.
+	 */
+	gpiod_direction_output(bri->scl_gpiod, 0);
+	udelay(10);
+	bri->sda_gpiod = devm_gpiod_get(dev, "sda", GPIOD_OUT_HIGH_OPEN_DRAIN);
+
+	/* Wait a bit in case of a SDA glitch, and then release SCL. */
+	udelay(10);
+	gpiod_direction_output(bri->scl_gpiod, 1);
+
+	if (bri->sda_gpiod == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+
+	if (IS_ERR(bri->sda_gpiod)) {
+		dev_info(dev, "missing sda gpio recovery information: %pe\n",
+			 bri->sda_gpiod);
 		return 0;
 	}
-	if (IS_ERR(bri->pinctrl))
-		return PTR_ERR(bri->pinctrl);
 
 	bri->prepare_recovery = i2c_pxa_prepare_recovery;
 	bri->unprepare_recovery = i2c_pxa_unprepare_recovery;
+	bri->recover_bus = i2c_generic_scl_recovery;
 
 	i2c->adap.bus_recovery_info = bri;
 
-	return 0;
+	/*
+	 * Claiming GPIOs can change the pinmux state, which confuses the
+	 * pinctrl since pinctrl's idea of the current setting is unaffected
+	 * by the pinmux change caused by claiming the GPIO. Work around that
+	 * by switching pinctrl to the GPIO state here. We do it this way to
+	 * avoid glitching the I2C bus.
+	 */
+	pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_recovery);
+
+	return pinctrl_select_state(i2c->pinctrl, i2c->pinctrl_default);
 }
 
 static int i2c_pxa_probe(struct platform_device *dev)



