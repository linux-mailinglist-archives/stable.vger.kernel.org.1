Return-Path: <stable+bounces-103483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D85C39EF848
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9012C1895A88
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6003121E086;
	Thu, 12 Dec 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qfmMXQ5l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75320A5EE;
	Thu, 12 Dec 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024706; cv=none; b=TAswVagwAvCdqzNB+TwPBu/l4de8Gywajfkd09u3Lj0YIe/eM8V8/gNqwOWhloriaOfHAJecRnofOmL4bOlJSwN8XJwEaJ09hVGgUtn7sb7yiScewVnGionAOfaZ+az6Pg9WZvKP/HtnB9nJhRr/uVuLOKIzFx9+k7YPrm0MDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024706; c=relaxed/simple;
	bh=AiEFlwi6E5zHBjovDL62fxFZO9MwKw71QReJjFq6BEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o94qtMcE6WhkuLqWQ3ZlK6rmTY5XxC8wqvMP5bbCO8vnweOwppTS4uUuNSUlHEASc88YVZW/48bwJCc3TxZ6uCjxJF8R17J10iXFX8dvOAgzgpaP9GFI1WPwybTDFHYzCAL0h1ljueqhrVAwmDaoNFb04YYD6alXi4SjQ7tp4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qfmMXQ5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC1CC4CECE;
	Thu, 12 Dec 2024 17:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024706;
	bh=AiEFlwi6E5zHBjovDL62fxFZO9MwKw71QReJjFq6BEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfmMXQ5lkznpTdr/VzSBSFHUhxJdJPbi6XPIuQJE/P9k3A8cx4fztsHuYYxMLgYd+
	 vbaWz/Eaq2uyIarfqbMKUd3f9/PecLpkwW1yUSaGsBXzGhr54ioyGx7xKNR140kZz8
	 U6g6XiWRfQ9BgYH4/mxSWVsr1+MDfWkzi6QV5XdQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 345/459] gpio: grgpio: use a helper variable to store the address of ofdev->dev
Date: Thu, 12 Dec 2024 16:01:23 +0100
Message-ID: <20241212144307.291280895@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit d036ae41cebdfae92666024163c109b8fef516fa ]

Instead of dereferencing the platform device pointer repeatedly, just
store its address in a helper variable.

Link: https://lore.kernel.org/r/20241015131832.44678-3-brgl@bgdev.pl
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Stable-dep-of: 050b23d081da ("gpio: grgpio: Add NULL check in grgpio_probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-grgpio.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index f954359c9544e..ca3bf8d51d5aa 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -328,6 +328,7 @@ static const struct irq_domain_ops grgpio_irq_domain_ops = {
 static int grgpio_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
+	struct device *dev = &ofdev->dev;
 	void  __iomem *regs;
 	struct gpio_chip *gc;
 	struct grgpio_priv *priv;
@@ -337,7 +338,7 @@ static int grgpio_probe(struct platform_device *ofdev)
 	int size;
 	int i;
 
-	priv = devm_kzalloc(&ofdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -346,29 +347,29 @@ static int grgpio_probe(struct platform_device *ofdev)
 		return PTR_ERR(regs);
 
 	gc = &priv->gc;
-	err = bgpio_init(gc, &ofdev->dev, 4, regs + GRGPIO_DATA,
+	err = bgpio_init(gc, dev, 4, regs + GRGPIO_DATA,
 			 regs + GRGPIO_OUTPUT, NULL, regs + GRGPIO_DIR, NULL,
 			 BGPIOF_BIG_ENDIAN_BYTE_ORDER);
 	if (err) {
-		dev_err(&ofdev->dev, "bgpio_init() failed\n");
+		dev_err(dev, "bgpio_init() failed\n");
 		return err;
 	}
 
 	priv->regs = regs;
 	priv->imask = gc->read_reg(regs + GRGPIO_IMASK);
-	priv->dev = &ofdev->dev;
+	priv->dev = dev;
 
 	gc->of_node = np;
 	gc->owner = THIS_MODULE;
 	gc->to_irq = grgpio_to_irq;
-	gc->label = devm_kasprintf(&ofdev->dev, GFP_KERNEL, "%pOF", np);
+	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
 	gc->base = -1;
 
 	err = of_property_read_u32(np, "nbits", &prop);
 	if (err || prop <= 0 || prop > GRGPIO_MAX_NGPIO) {
 		gc->ngpio = GRGPIO_MAX_NGPIO;
-		dev_dbg(&ofdev->dev,
-			"No or invalid nbits property: assume %d\n", gc->ngpio);
+		dev_dbg(dev, "No or invalid nbits property: assume %d\n",
+			gc->ngpio);
 	} else {
 		gc->ngpio = prop;
 	}
@@ -380,7 +381,7 @@ static int grgpio_probe(struct platform_device *ofdev)
 	irqmap = (s32 *)of_get_property(np, "irqmap", &size);
 	if (irqmap) {
 		if (size < gc->ngpio) {
-			dev_err(&ofdev->dev,
+			dev_err(dev,
 				"irqmap shorter than ngpio (%d < %d)\n",
 				size, gc->ngpio);
 			return -EINVAL;
@@ -390,7 +391,7 @@ static int grgpio_probe(struct platform_device *ofdev)
 						     &grgpio_irq_domain_ops,
 						     priv);
 		if (!priv->domain) {
-			dev_err(&ofdev->dev, "Could not add irq domain\n");
+			dev_err(dev, "Could not add irq domain\n");
 			return -EINVAL;
 		}
 
@@ -420,13 +421,13 @@ static int grgpio_probe(struct platform_device *ofdev)
 
 	err = gpiochip_add_data(gc, priv);
 	if (err) {
-		dev_err(&ofdev->dev, "Could not add gpiochip\n");
+		dev_err(dev, "Could not add gpiochip\n");
 		if (priv->domain)
 			irq_domain_remove(priv->domain);
 		return err;
 	}
 
-	dev_info(&ofdev->dev, "regs=0x%p, base=%d, ngpio=%d, irqs=%s\n",
+	dev_info(dev, "regs=0x%p, base=%d, ngpio=%d, irqs=%s\n",
 		 priv->regs, gc->base, gc->ngpio, priv->domain ? "on" : "off");
 
 	return 0;
-- 
2.43.0




