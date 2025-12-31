Return-Path: <stable+bounces-204349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42676CEC152
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F593009834
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75F24A07C;
	Wed, 31 Dec 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDvBaDIO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D01BD035
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191541; cv=none; b=iqftinEJ4FowI8Kmt2hz35TUumYmmHbg5RUKbsoQhi2rQhvRWr+/wU5yWK0U7/lyZjBZ/DD+aWhnAEYt5UbscvJERrjuJ6e51+UDGyBcYbyCOa84GrLPbYdjoPaQsZX1XtcW9v0gZRTUTlu/qV2n8xYDsYpQd9KUyZt+lTDw9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191541; c=relaxed/simple;
	bh=kG+6CS/QSMYyLrWD/5UX+eBmpxEWIE2FzuIcBc1Zb7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnZUIfJ0OeyO8ZPaHSmcCIqXjxYpOW9M5+4taHgbMArwO9AHb2MJf6qGff79Gj3u0sseFwsusTewyQ1cag8gNGvoqERMED7MqDk/hcyc4/n9FX5OxWmbZLruFN6oO2pau+lsWUEuu/LHhpgpKJKira0OSVJuJPN7sSJwxGd/C20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDvBaDIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9823CC113D0;
	Wed, 31 Dec 2025 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767191541;
	bh=kG+6CS/QSMYyLrWD/5UX+eBmpxEWIE2FzuIcBc1Zb7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDvBaDIO92ZcfoQAru2ITSFJMtgWbeOtOWEY2NJrNDXmDBGDrO9jexULmdKVuX4mn
	 XxJhD4B+amIGKWmREGGER8xQId4vHktnkYnUZkCJfGADMgYm1Io3JNaOJuiHswiym1
	 k+UwXPZm7VHDHKH+rnbjaNqdGK4I+yrGJVg8EESczgjSmBcPrFAUnNWhjfhYPsFKM+
	 cGQ93AXgpZpvSWzad3xi0G0dAv1UtmAVwE80BwHT8cp3comjyjVRYyhjy5Vd0WDClk
	 hDE3bUqntq6s8k05jAPabukKTKQ9bsAB1AX+bHVye9BZ8M8x2fY83Ves6pHOnUKfc4
	 qd489theP4UIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/7] gpiolib: acpi: Switch to use enum in acpi_gpio_in_ignore_list()
Date: Wed, 31 Dec 2025 09:32:12 -0500
Message-ID: <20251231143218.3042757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122946-rotunda-passenger-2915@gregkh>
References: <2025122946-rotunda-passenger-2915@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit b24fd5bc8e6d6b6006db65b5956c2c2cd0ee5a7b ]

Switch to use enum instead of pointers in acpi_gpio_in_ignore_list()
which moves towards isolating the GPIO ACPI and quirk APIs. It will
helps splitting them completely in the next changes.

No functional changes.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Stable-dep-of: 2d967310c49e ("gpiolib: acpi: Add quirk for Dell Precision 7780")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-acpi.c | 21 ++++++++++++++++-----
 drivers/gpio/gpiolib-acpi.h |  8 ++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 148b4d1788a2..6b6f6a82b82d 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -350,14 +350,25 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 	return desc;
 }
 
-static bool acpi_gpio_in_ignore_list(const char *ignore_list, const char *controller_in,
-				     unsigned int pin_in)
+bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list, const char *controller_in,
+			      unsigned int pin_in)
 {
-	const char *controller, *pin_str;
+	const char *ignore_list, *controller, *pin_str;
 	unsigned int pin;
 	char *endp;
 	int len;
 
+	switch (list) {
+	case ACPI_GPIO_IGNORE_WAKE:
+		ignore_list = ignore_wake;
+		break;
+	case ACPI_GPIO_IGNORE_INTERRUPT:
+		ignore_list = ignore_interrupt;
+		break;
+	default:
+		return false;
+	}
+
 	controller = ignore_list;
 	while (controller) {
 		pin_str = strchr(controller, '@');
@@ -394,7 +405,7 @@ static bool acpi_gpio_irq_is_wake(struct device *parent,
 	if (agpio->wake_capable != ACPI_WAKE_CAPABLE)
 		return false;
 
-	if (acpi_gpio_in_ignore_list(ignore_wake, dev_name(parent), pin)) {
+	if (acpi_gpio_in_ignore_list(ACPI_GPIO_IGNORE_WAKE, dev_name(parent), pin)) {
 		dev_info(parent, "Ignoring wakeup on pin %u\n", pin);
 		return false;
 	}
@@ -437,7 +448,7 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	if (!handler)
 		return AE_OK;
 
-	if (acpi_gpio_in_ignore_list(ignore_interrupt, dev_name(chip->parent), pin)) {
+	if (acpi_gpio_in_ignore_list(ACPI_GPIO_IGNORE_INTERRUPT, dev_name(chip->parent), pin)) {
 		dev_info(chip->parent, "Ignoring interrupt on pin %u\n", pin);
 		return AE_OK;
 	}
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 7e1c51d04040..ef0b1a3c85d7 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -58,4 +58,12 @@ static inline int acpi_gpio_count(const struct fwnode_handle *fwnode,
 }
 #endif
 
+enum acpi_gpio_ignore_list {
+	ACPI_GPIO_IGNORE_WAKE,
+	ACPI_GPIO_IGNORE_INTERRUPT,
+};
+
+bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list,
+			      const char *controller_in, unsigned int pin_in);
+
 #endif /* GPIOLIB_ACPI_H */
-- 
2.51.0


