Return-Path: <stable+bounces-97634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C36F9E2AE0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861E3BE373C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9CE1F75BC;
	Tue,  3 Dec 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pjofjm0p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC31362;
	Tue,  3 Dec 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241193; cv=none; b=eGSrnwskE6YpefYyodIUfbBUmuH8dbQa2vI2kFusyOCNSn+MG4OP86FAtA3dmPxqN+KbRtuiZ9f2SndzI5AWH+5kXOBFWZYlthOTcJE4Vyw7/gr86Wyw7PHaoAeh9C8YcIXXLPK0BuVgOfGV/uAAITIKUFmLQxD9dlgxMSK9jAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241193; c=relaxed/simple;
	bh=UFD5fdA5VirO1jlOXr3ibowLdyX/almkeC6VeAhL5zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZJSoJANfElPt0/6qdfOy9MQ30FjTm1QrnJ0oJ+9v14gnZN97jWfIiQk917Hev2WBUL06GKCND664n7BKv8LFBPzjNRPb746imx0kOZXF9l1YCrzyUcvEQrNibXw57yJ7H2XAONipZfnNlHE3fxde6y5V2Blm17/vEGxDTn9RIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pjofjm0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8B2C4CECF;
	Tue,  3 Dec 2024 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241192;
	bh=UFD5fdA5VirO1jlOXr3ibowLdyX/almkeC6VeAhL5zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pjofjm0pVHgl8XFUlKcJQQ16fG1VcqlAGtQuD5wwug4tEryHKg7Hggcuxx2D7FPdf
	 L6MDOYfKXQz0zGFCOo1xV1k+JUFWQjzeBcttFXowSlh2goiCwVs1PDEdCyaM9gRk67
	 wvODA+eJSqH3hI4LmqPC5iyTy/uMMxn1xUWZwgYU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 352/826] net: txgbe: remove GPIO interrupt controller
Date: Tue,  3 Dec 2024 15:41:19 +0100
Message-ID: <20241203144757.493006664@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiawen Wu <jiawenwu@trustnetic.com>

[ Upstream commit e867ed3ac8aa50945170723a450b5c068a56339a ]

Since the GPIO interrupt controller is always not working properly, we need
to constantly add workaround to cope with hardware deficiencies. So just
remove GPIO interrupt controller, and let the SFP driver poll the GPIO
status.

Fixes: b4a2496c17ed ("net: txgbe: fix GPIO interrupt blocking")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Link: https://patch.msgid.link/20241115071527.1129458-1-jiawenwu@trustnetic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  24 +--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   1 -
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 166 ------------------
 .../net/ethernet/wangxun/txgbe/txgbe_phy.h    |   2 -
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   7 +-
 5 files changed, 4 insertions(+), 196 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index a4cf682dca650..0ee73a265545c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -72,14 +72,6 @@ int txgbe_request_queue_irqs(struct wx *wx)
 	return err;
 }
 
-static int txgbe_request_gpio_irq(struct txgbe *txgbe)
-{
-	txgbe->gpio_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
-	return request_threaded_irq(txgbe->gpio_irq, NULL,
-				    txgbe_gpio_irq_handler,
-				    IRQF_ONESHOT, "txgbe-gpio-irq", txgbe);
-}
-
 static int txgbe_request_link_irq(struct txgbe *txgbe)
 {
 	txgbe->link_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_LINK);
@@ -149,11 +141,6 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 	u32 eicr;
 
 	eicr = wx_misc_isb(wx, WX_ISB_MISC);
-	if (eicr & TXGBE_PX_MISC_GPIO) {
-		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
-		handle_nested_irq(sub_irq);
-		nhandled++;
-	}
 	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
 		    TXGBE_PX_MISC_ETH_AN)) {
 		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_LINK);
@@ -179,7 +166,6 @@ static void txgbe_del_irq_domain(struct txgbe *txgbe)
 
 void txgbe_free_misc_irq(struct txgbe *txgbe)
 {
-	free_irq(txgbe->gpio_irq, txgbe);
 	free_irq(txgbe->link_irq, txgbe);
 	free_irq(txgbe->misc.irq, txgbe);
 	txgbe_del_irq_domain(txgbe);
@@ -191,7 +177,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
-	txgbe->misc.nirqs = 2;
+	txgbe->misc.nirqs = 1;
 	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
 						   &txgbe_misc_irq_domain_ops, txgbe);
 	if (!txgbe->misc.domain)
@@ -216,20 +202,14 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	if (err)
 		goto del_misc_irq;
 
-	err = txgbe_request_gpio_irq(txgbe);
-	if (err)
-		goto free_msic_irq;
-
 	err = txgbe_request_link_irq(txgbe);
 	if (err)
-		goto free_gpio_irq;
+		goto free_msic_irq;
 
 	wx->misc_irq_domain = true;
 
 	return 0;
 
-free_gpio_irq:
-	free_irq(txgbe->gpio_irq, txgbe);
 free_msic_irq:
 	free_irq(txgbe->misc.irq, txgbe);
 del_misc_irq:
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 93180225a6f14..f774502680364 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -82,7 +82,6 @@ static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
-	txgbe_reinit_gpio_intr(wx);
 	wx_control_hw(wx, true);
 	wx_configure_vectors(wx);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 67b61afdde96c..2bfe41339c1cd 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -358,169 +358,8 @@ static int txgbe_gpio_direction_out(struct gpio_chip *chip, unsigned int offset,
 	return 0;
 }
 
-static void txgbe_gpio_irq_ack(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	struct wx *wx = gpiochip_get_data(gc);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-	wr32(wx, WX_GPIO_EOI, BIT(hwirq));
-	raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-}
-
-static void txgbe_gpio_irq_mask(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	struct wx *wx = gpiochip_get_data(gc);
-	unsigned long flags;
-
-	gpiochip_disable_irq(gc, hwirq);
-
-	raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-	wr32m(wx, WX_GPIO_INTMASK, BIT(hwirq), BIT(hwirq));
-	raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-}
-
-static void txgbe_gpio_irq_unmask(struct irq_data *d)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	struct wx *wx = gpiochip_get_data(gc);
-	unsigned long flags;
-
-	gpiochip_enable_irq(gc, hwirq);
-
-	raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-	wr32m(wx, WX_GPIO_INTMASK, BIT(hwirq), 0);
-	raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-}
-
-static void txgbe_toggle_trigger(struct gpio_chip *gc, unsigned int offset)
-{
-	struct wx *wx = gpiochip_get_data(gc);
-	u32 pol, val;
-
-	pol = rd32(wx, WX_GPIO_POLARITY);
-	val = rd32(wx, WX_GPIO_EXT);
-
-	if (val & BIT(offset))
-		pol &= ~BIT(offset);
-	else
-		pol |= BIT(offset);
-
-	wr32(wx, WX_GPIO_POLARITY, pol);
-}
-
-static int txgbe_gpio_set_type(struct irq_data *d, unsigned int type)
-{
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
-	struct wx *wx = gpiochip_get_data(gc);
-	u32 level, polarity, mask;
-	unsigned long flags;
-
-	mask = BIT(hwirq);
-
-	if (type & IRQ_TYPE_LEVEL_MASK) {
-		level = 0;
-		irq_set_handler_locked(d, handle_level_irq);
-	} else {
-		level = mask;
-		irq_set_handler_locked(d, handle_edge_irq);
-	}
-
-	if (type == IRQ_TYPE_EDGE_RISING || type == IRQ_TYPE_LEVEL_HIGH)
-		polarity = mask;
-	else
-		polarity = 0;
-
-	raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-
-	wr32m(wx, WX_GPIO_INTEN, mask, mask);
-	wr32m(wx, WX_GPIO_INTTYPE_LEVEL, mask, level);
-	if (type == IRQ_TYPE_EDGE_BOTH)
-		txgbe_toggle_trigger(gc, hwirq);
-	else
-		wr32m(wx, WX_GPIO_POLARITY, mask, polarity);
-
-	raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-
-	return 0;
-}
-
-static const struct irq_chip txgbe_gpio_irq_chip = {
-	.name = "txgbe-gpio-irq",
-	.irq_ack = txgbe_gpio_irq_ack,
-	.irq_mask = txgbe_gpio_irq_mask,
-	.irq_unmask = txgbe_gpio_irq_unmask,
-	.irq_set_type = txgbe_gpio_set_type,
-	.flags = IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
-};
-
-irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
-{
-	struct txgbe *txgbe = data;
-	struct wx *wx = txgbe->wx;
-	irq_hw_number_t hwirq;
-	unsigned long gpioirq;
-	struct gpio_chip *gc;
-	unsigned long flags;
-
-	gpioirq = rd32(wx, WX_GPIO_INTSTATUS);
-
-	gc = txgbe->gpio;
-	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
-		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
-		struct irq_data *d = irq_get_irq_data(gpio);
-		u32 irq_type = irq_get_trigger_type(gpio);
-
-		txgbe_gpio_irq_ack(d);
-		handle_nested_irq(gpio);
-
-		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
-			raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-			txgbe_toggle_trigger(gc, hwirq);
-			raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
-void txgbe_reinit_gpio_intr(struct wx *wx)
-{
-	struct txgbe *txgbe = wx->priv;
-	irq_hw_number_t hwirq;
-	unsigned long gpioirq;
-	struct gpio_chip *gc;
-	unsigned long flags;
-
-	/* for gpio interrupt pending before irq enable */
-	gpioirq = rd32(wx, WX_GPIO_INTSTATUS);
-
-	gc = txgbe->gpio;
-	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
-		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
-		struct irq_data *d = irq_get_irq_data(gpio);
-		u32 irq_type = irq_get_trigger_type(gpio);
-
-		txgbe_gpio_irq_ack(d);
-
-		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
-			raw_spin_lock_irqsave(&wx->gpio_lock, flags);
-			txgbe_toggle_trigger(gc, hwirq);
-			raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
-		}
-	}
-}
-
 static int txgbe_gpio_init(struct txgbe *txgbe)
 {
-	struct gpio_irq_chip *girq;
 	struct gpio_chip *gc;
 	struct device *dev;
 	struct wx *wx;
@@ -550,11 +389,6 @@ static int txgbe_gpio_init(struct txgbe *txgbe)
 	gc->direction_input = txgbe_gpio_direction_in;
 	gc->direction_output = txgbe_gpio_direction_out;
 
-	girq = &gc->irq;
-	gpio_irq_chip_set_chip(girq, &txgbe_gpio_irq_chip);
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_bad_irq;
-
 	ret = devm_gpiochip_add_data(dev, gc, wx);
 	if (ret)
 		return ret;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
index 8a026d804fe24..3938985355ed6 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
@@ -4,8 +4,6 @@
 #ifndef _TXGBE_PHY_H_
 #define _TXGBE_PHY_H_
 
-irqreturn_t txgbe_gpio_irq_handler(int irq, void *data);
-void txgbe_reinit_gpio_intr(struct wx *wx);
 irqreturn_t txgbe_link_irq_handler(int irq, void *data);
 int txgbe_init_phy(struct txgbe *txgbe);
 void txgbe_remove_phy(struct txgbe *txgbe);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 959102c4c3797..8ea413a7abe9d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -75,8 +75,7 @@
 #define TXGBE_PX_MISC_IEN_MASK                            \
 	(TXGBE_PX_MISC_ETH_LKDN | TXGBE_PX_MISC_DEV_RST | \
 	 TXGBE_PX_MISC_ETH_EVENT | TXGBE_PX_MISC_ETH_LK | \
-	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR |   \
-	 TXGBE_PX_MISC_GPIO)
+	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR)
 
 /* Port cfg registers */
 #define TXGBE_CFG_PORT_ST                       0x14404
@@ -313,8 +312,7 @@ struct txgbe_nodes {
 };
 
 enum txgbe_misc_irqs {
-	TXGBE_IRQ_GPIO = 0,
-	TXGBE_IRQ_LINK,
+	TXGBE_IRQ_LINK = 0,
 	TXGBE_IRQ_MAX
 };
 
@@ -335,7 +333,6 @@ struct txgbe {
 	struct clk_lookup *clock;
 	struct clk *clk;
 	struct gpio_chip *gpio;
-	unsigned int gpio_irq;
 	unsigned int link_irq;
 
 	/* flow director */
-- 
2.43.0




