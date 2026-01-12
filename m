Return-Path: <stable+bounces-208190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18812D14752
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60FE30173A7
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0C37BE8B;
	Mon, 12 Jan 2026 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4uDe3IN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA83570AE
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239884; cv=none; b=vCvwussoa6A0BiiwYyXXWS2ToxCpQ+TjyXYI8dn52cnexk5LOmHMxtI8cUHcp63k80f7z2lvkrLlEl/bns823kejAFp2cvVQiTQqeWppUhgRwLou8Ely0YVMct9L4R1Yg51a14zAr2jJ3YYKNODv6u64tykGvg799MV+cc84IfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239884; c=relaxed/simple;
	bh=UB08BAQAV0zDtBW98LMYKOhvxi76Ci948hPN45dY5u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxbUXjZ3UAfs3pHMYuQV3EQvQb0wcm2O9X+yJP0lumoNS0iMBLBnSZNH++SXI6P4FmYCdzXoNjGxtXevN9BjHsAzXy8KAGl1l1jQviAXvhoPRq33M4U0ubUZjm+0rXNqGyN5AEkx39z2Ayiyif4NsKw+2FupmcpH16aFV9fMHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4uDe3IN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D11C19424;
	Mon, 12 Jan 2026 17:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768239884;
	bh=UB08BAQAV0zDtBW98LMYKOhvxi76Ci948hPN45dY5u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4uDe3IN4kCyEaDzWS2YMnJG+WPgkzsfbjJvtSCxbLothvRsJIKti6Sk+MuU1OM0d
	 fO/7oGfZ3VRa1JWjDRFEcoGI9ix3LfK4MGfPywATeGCH0xOU+oJ9sbfm9zcf6f94ne
	 4j+8k+y9SkcpuPvPrnE4Ip9SScDGAWjcu5Sfa9Dg/O1a8EO+SbARz6xnPSaeu3q8wz
	 yCVFkQVPjF0hMwAE2dtO3DaA9Z64AVlyEOs8+BFkktRBD+0aClgvKHZHokgqIN++NI
	 xWUi6yoFFF1odGtp3gUYNiWESywzum06ZZ5jBZeAavinJ7j/0SpKBttF6wMPPxcMd9
	 v1HbFy6ZMtZPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mary Strodl <mstrodl@csh.rit.edu>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] gpio: mpsse: add quirk support
Date: Mon, 12 Jan 2026 12:44:40 -0500
Message-ID: <20260112174441.830780-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112174441.830780-1-sashal@kernel.org>
References: <2026011202-scheming-operating-3cbb@gregkh>
 <20260112174441.830780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mary Strodl <mstrodl@csh.rit.edu>

[ Upstream commit f13b0f72af238d63bb9a2e417657da8b45d72544 ]

Builds out a facility for specifying compatible lines directions and
labels for MPSSE-based devices.

* dir_in/out are bitmask of lines that can go in/out. 1 means
  compatible, 0 means incompatible.
* names is an array of line names which will be exposed to userspace.

Also changes the chip label format to include some more useful
information about the device to help identify it from userspace.

Signed-off-by: Mary Strodl <mstrodl@csh.rit.edu>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20251014133530.3592716-4-mstrodl@csh.rit.edu
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Stable-dep-of: 1e876e5a0875 ("gpio: mpsse: fix reference leak in gpio_mpsse_probe() error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mpsse.c | 109 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index 8147b3ddb4a27..e68179caafa62 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -29,6 +29,9 @@ struct mpsse_priv {
 	u8 gpio_outputs[2];	     /* Output states for GPIOs [L, H] */
 	u8 gpio_dir[2];		     /* Directions for GPIOs [L, H] */
 
+	unsigned long dir_in;        /* Bitmask of valid input pins  */
+	unsigned long dir_out;       /* Bitmask of valid output pins */
+
 	u8 *bulk_in_buf;	     /* Extra recv buffer to grab status bytes */
 
 	struct usb_endpoint_descriptor *bulk_in;
@@ -54,6 +57,14 @@ struct bulk_desc {
 	int timeout;
 };
 
+#define MPSSE_NGPIO 16
+
+struct mpsse_quirk {
+	const char   *names[MPSSE_NGPIO]; /* Pin names, if applicable     */
+	unsigned long dir_in;             /* Bitmask of valid input pins  */
+	unsigned long dir_out;            /* Bitmask of valid output pins */
+};
+
 static const struct usb_device_id gpio_mpsse_table[] = {
 	{ USB_DEVICE(0x0c52, 0xa064) },   /* SeaLevel Systems, Inc. */
 	{ }                               /* Terminating entry */
@@ -171,6 +182,32 @@ static int gpio_mpsse_get_bank(struct mpsse_priv *priv, u8 bank)
 	return buf;
 }
 
+static int mpsse_ensure_supported(struct gpio_chip *chip,
+				  unsigned long mask, int direction)
+{
+	unsigned long supported, unsupported;
+	char *type = "input";
+	struct mpsse_priv *priv = gpiochip_get_data(chip);
+
+	supported = priv->dir_in;
+	if (direction == GPIO_LINE_DIRECTION_OUT) {
+		supported = priv->dir_out;
+		type = "output";
+	}
+
+	/* An invalid bit was in the provided mask */
+	unsupported = mask & ~supported;
+	if (unsupported) {
+		dev_err(&priv->udev->dev,
+			"mpsse: GPIO %lu doesn't support %s\n",
+			find_first_bit(&unsupported, sizeof(unsupported) * 8),
+			type);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int gpio_mpsse_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 				   unsigned long *bits)
 {
@@ -178,6 +215,10 @@ static int gpio_mpsse_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 	int ret;
 	struct mpsse_priv *priv = gpiochip_get_data(chip);
 
+	ret = mpsse_ensure_supported(chip, *mask, GPIO_LINE_DIRECTION_OUT);
+	if (ret)
+		return ret;
+
 	guard(mutex)(&priv->io_mutex);
 	for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
 		bank = i / 8;
@@ -205,6 +246,10 @@ static int gpio_mpsse_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	int ret;
 	struct mpsse_priv *priv = gpiochip_get_data(chip);
 
+	ret = mpsse_ensure_supported(chip, *mask, GPIO_LINE_DIRECTION_IN);
+	if (ret)
+		return ret;
+
 	guard(mutex)(&priv->io_mutex);
 	for_each_set_clump8(i, bank_mask, mask, chip->ngpio) {
 		bank = i / 8;
@@ -253,10 +298,15 @@ static int gpio_mpsse_gpio_set(struct gpio_chip *chip, unsigned int offset,
 static int gpio_mpsse_direction_output(struct gpio_chip *chip,
 				       unsigned int offset, int value)
 {
+	int ret;
 	struct mpsse_priv *priv = gpiochip_get_data(chip);
 	int bank = (offset & 8) >> 3;
 	int bank_offset = offset & 7;
 
+	ret = mpsse_ensure_supported(chip, BIT(offset), GPIO_LINE_DIRECTION_OUT);
+	if (ret)
+		return ret;
+
 	scoped_guard(mutex, &priv->io_mutex)
 		priv->gpio_dir[bank] |= BIT(bank_offset);
 
@@ -266,10 +316,15 @@ static int gpio_mpsse_direction_output(struct gpio_chip *chip,
 static int gpio_mpsse_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
+	int ret;
 	struct mpsse_priv *priv = gpiochip_get_data(chip);
 	int bank = (offset & 8) >> 3;
 	int bank_offset = offset & 7;
 
+	ret = mpsse_ensure_supported(chip, BIT(offset), GPIO_LINE_DIRECTION_IN);
+	if (ret)
+		return ret;
+
 	guard(mutex)(&priv->io_mutex);
 	priv->gpio_dir[bank] &= ~BIT(bank_offset);
 	gpio_mpsse_set_bank(priv, bank);
@@ -483,18 +538,49 @@ static void gpio_mpsse_ida_remove(void *data)
 	ida_free(&gpio_mpsse_ida, priv->id);
 }
 
+static int mpsse_init_valid_mask(struct gpio_chip *chip,
+				 unsigned long *valid_mask,
+				 unsigned int ngpios)
+{
+	struct mpsse_priv *priv = gpiochip_get_data(chip);
+
+	if (WARN_ON(priv == NULL))
+		return -ENODEV;
+
+	*valid_mask = priv->dir_in | priv->dir_out;
+
+	return 0;
+}
+
+static void mpsse_irq_init_valid_mask(struct gpio_chip *chip,
+				      unsigned long *valid_mask,
+				      unsigned int ngpios)
+{
+	struct mpsse_priv *priv = gpiochip_get_data(chip);
+
+	if (WARN_ON(priv == NULL))
+		return;
+
+	/* Can only use IRQ on input capable pins */
+	*valid_mask = priv->dir_in;
+}
+
 static int gpio_mpsse_probe(struct usb_interface *interface,
 			    const struct usb_device_id *id)
 {
 	struct mpsse_priv *priv;
 	struct device *dev;
+	char *serial;
 	int err;
+	struct mpsse_quirk *quirk = (void *)id->driver_info;
 
 	dev = &interface->dev;
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&priv->workers);
+
 	priv->udev = usb_get_dev(interface_to_usbdev(interface));
 	priv->intf = interface;
 	priv->intf_id = interface->cur_altsetting->desc.bInterfaceNumber;
@@ -521,9 +607,15 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 
 	raw_spin_lock_init(&priv->irq_spin);
 
+	serial = priv->udev->serial;
+	if (!serial)
+		serial = "NONE";
+
 	priv->gpio.label = devm_kasprintf(dev, GFP_KERNEL,
-					  "gpio-mpsse.%d.%d",
-					  priv->id, priv->intf_id);
+					  "MPSSE%04x:%04x.%d.%d.%s",
+					  id->idVendor, id->idProduct,
+					  priv->intf_id, priv->id,
+					  serial);
 	if (!priv->gpio.label)
 		return -ENOMEM;
 
@@ -537,10 +629,20 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 	priv->gpio.get_multiple = gpio_mpsse_get_multiple;
 	priv->gpio.set_multiple = gpio_mpsse_set_multiple;
 	priv->gpio.base = -1;
-	priv->gpio.ngpio = 16;
+	priv->gpio.ngpio = MPSSE_NGPIO;
 	priv->gpio.offset = priv->intf_id * priv->gpio.ngpio;
 	priv->gpio.can_sleep = 1;
 
+	if (quirk) {
+		priv->dir_out = quirk->dir_out;
+		priv->dir_in = quirk->dir_in;
+		priv->gpio.names = quirk->names;
+		priv->gpio.init_valid_mask = mpsse_init_valid_mask;
+	} else {
+		priv->dir_in = U16_MAX;
+		priv->dir_out = U16_MAX;
+	}
+
 	err = usb_find_common_endpoints(interface->cur_altsetting,
 					&priv->bulk_in, &priv->bulk_out,
 					NULL, NULL);
@@ -579,6 +681,7 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 	priv->gpio.irq.parents = NULL;
 	priv->gpio.irq.default_type = IRQ_TYPE_NONE;
 	priv->gpio.irq.handler = handle_simple_irq;
+	priv->gpio.irq.init_valid_mask = mpsse_irq_init_valid_mask;
 
 	err = devm_gpiochip_add_data(dev, &priv->gpio, priv);
 	if (err)
-- 
2.51.0


