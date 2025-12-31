Return-Path: <stable+bounces-204350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 541F5CEC159
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C14573010286
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988525F78F;
	Wed, 31 Dec 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX5HvU3f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA21BD035
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191542; cv=none; b=dvMN7j2+1Z70/LQ3fRadi8AsWj4G+UCUIlVQlzMzyJo28rOM3pw+hcl4v0Ni4qL8NcZFTPspxdZRiZRFJ6yW4VjaIAuZFRI61yUToaogo6W3mDqN8EVO6gPkdkAQzu9l7RClqWWs5eCzO9l9IoEhce4sEsMgM0rtzbfj8IHsnjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191542; c=relaxed/simple;
	bh=hA//rAPrT6Yu9CfrDfoejLbX2/rvVWWaUU8h7lVIp7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NV7qhKyKfpL6Wd3Y1XBBdZNDc0Yy1XKTKHgrKn/x5qoKmsRODGglk6eia8ASemAUKFWPh1dJAc45t+XigaXmNN/V8K5OUjnSsTtqQbaiqSLtVmsaQhSLo7vnvMud7FeEd/2mi7gyxPtFTxl+KrTYNE+LeIgvwNp9yNvt4hoyiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX5HvU3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76875C19421;
	Wed, 31 Dec 2025 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767191542;
	bh=hA//rAPrT6Yu9CfrDfoejLbX2/rvVWWaUU8h7lVIp7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IX5HvU3fG6VeHCoTnoRZHJSeUbYfpHzUwyyg7RuHcflJ1D+/97+F9einzxf2W/xrs
	 jSrxOoFD//NRYPE10j0JH2hvjtzHYu58YlrCKa3nC2dDEoFrpb4/rS/sZPbsqhJO55
	 bEVCcfp4vFdj+vYYvNMReKt6yc+igwYuPRmSfOFf4vOGmhiSG8Laz1NRO+iwFcYz9/
	 UznaxhTKqUnlAZ5ZKq5pR+Cwp9ILCvMOQQSNOzv8aQXFnA2rsr5QKNoHevoV6cNkh+
	 sZrgAzjlOi9gL3vwRQzUL5Ostg3nUY7gOFgDogieyStQncDWBNNHVzUgufsf96i+9Z
	 yaU4B/qGKDBsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/7] gpiolib: acpi: Handle deferred list via new API
Date: Wed, 31 Dec 2025 09:32:13 -0500
Message-ID: <20251231143218.3042757-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231143218.3042757-1-sashal@kernel.org>
References: <2025122946-rotunda-passenger-2915@gregkh>
 <20251231143218.3042757-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit a594877663d1e3d5cf57ec8af739582fc5c47cec ]

Introduce a new API and handle deferred list via it which moves
towards isolating the GPIO ACPI and quirk APIs. It will helps
splitting them completely in the next changes.

No functional changes.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Stable-dep-of: 2d967310c49e ("gpiolib: acpi: Add quirk for Dell Precision 7780")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-acpi.c | 52 +++++++++++++++++++++++--------------
 drivers/gpio/gpiolib-acpi.h |  5 ++++
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 6b6f6a82b82d..7f2f3a686bf1 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -350,6 +350,27 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 	return desc;
 }
 
+bool acpi_gpio_add_to_deferred_list(struct list_head *list)
+{
+	bool defer;
+
+	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+	defer = !acpi_gpio_deferred_req_irqs_done;
+	if (defer)
+		list_add(list, &acpi_gpio_deferred_req_irqs_list);
+	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+
+	return defer;
+}
+
+void acpi_gpio_remove_from_deferred_list(struct list_head *list)
+{
+	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+	if (!list_empty(list))
+		list_del_init(list);
+	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+}
+
 bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list, const char *controller_in,
 			      unsigned int pin_in)
 {
@@ -536,7 +557,6 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
 	struct acpi_gpio_chip *acpi_gpio;
 	acpi_handle handle;
 	acpi_status status;
-	bool defer;
 
 	if (!chip->parent || !chip->to_irq)
 		return;
@@ -555,14 +575,7 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
 	acpi_walk_resources(handle, METHOD_NAME__AEI,
 			    acpi_gpiochip_alloc_event, acpi_gpio);
 
-	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
-	defer = !acpi_gpio_deferred_req_irqs_done;
-	if (defer)
-		list_add(&acpi_gpio->deferred_req_irqs_list_entry,
-			 &acpi_gpio_deferred_req_irqs_list);
-	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
-
-	if (defer)
+	if (acpi_gpio_add_to_deferred_list(&acpi_gpio->deferred_req_irqs_list_entry))
 		return;
 
 	acpi_gpiochip_request_irqs(acpi_gpio);
@@ -594,10 +607,7 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
 	if (ACPI_FAILURE(status))
 		return;
 
-	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
-	if (!list_empty(&acpi_gpio->deferred_req_irqs_list_entry))
-		list_del_init(&acpi_gpio->deferred_req_irqs_list_entry);
-	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+	acpi_gpio_remove_from_deferred_list(&acpi_gpio->deferred_req_irqs_list_entry);
 
 	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
 		if (event->irq_requested) {
@@ -615,6 +625,14 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
 }
 EXPORT_SYMBOL_GPL(acpi_gpiochip_free_interrupts);
 
+void __init acpi_gpio_process_deferred_list(struct list_head *list)
+{
+	struct acpi_gpio_chip *acpi_gpio, *tmp;
+
+	list_for_each_entry_safe(acpi_gpio, tmp, list, deferred_req_irqs_list_entry)
+		acpi_gpiochip_request_irqs(acpi_gpio);
+}
+
 int acpi_dev_add_driver_gpios(struct acpi_device *adev,
 			      const struct acpi_gpio_mapping *gpios)
 {
@@ -1505,14 +1523,8 @@ int acpi_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
 /* Run deferred acpi_gpiochip_request_irqs() */
 static int __init acpi_gpio_handle_deferred_request_irqs(void)
 {
-	struct acpi_gpio_chip *acpi_gpio, *tmp;
-
 	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
-	list_for_each_entry_safe(acpi_gpio, tmp,
-				 &acpi_gpio_deferred_req_irqs_list,
-				 deferred_req_irqs_list_entry)
-		acpi_gpiochip_request_irqs(acpi_gpio);
-
+	acpi_gpio_process_deferred_list(&acpi_gpio_deferred_req_irqs_list);
 	acpi_gpio_deferred_req_irqs_done = true;
 	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
 
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index ef0b1a3c85d7..8249977e6140 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -58,6 +58,11 @@ static inline int acpi_gpio_count(const struct fwnode_handle *fwnode,
 }
 #endif
 
+void acpi_gpio_process_deferred_list(struct list_head *list);
+
+bool acpi_gpio_add_to_deferred_list(struct list_head *list);
+void acpi_gpio_remove_from_deferred_list(struct list_head *list);
+
 enum acpi_gpio_ignore_list {
 	ACPI_GPIO_IGNORE_WAKE,
 	ACPI_GPIO_IGNORE_INTERRUPT,
-- 
2.51.0


