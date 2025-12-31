Return-Path: <stable+bounces-204351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E073CEC15E
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD503013EC8
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E0269B01;
	Wed, 31 Dec 2025 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImCo/zIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B861BD035
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191543; cv=none; b=Yki154RJMulmIzTgzo0P5xxgeWRMnTWYS6alH3khqk5HphEEnTnyisaplZJxlRDvXxhz3XnlFJXWEoQYMPB4AN4f+rfJcgkwADXaga6C/VVYqb6EWdNf/SLvDK5U9HlhRVh5CmpZZ7yhNdmSPoZtQ0ay1aPrnddv/CH2NjsXHgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191543; c=relaxed/simple;
	bh=6MYKXYtTc6/OAkL7/kpO9n5U24qF/G1ywlPs8LHS02w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxIukGwb+mZyKbPv4VP+poSKCumD+Pg8HAS8qCRpuOZoJaAgPDQY+JslGbi5E1IBTUZuqxZWy/DNClygTEGpTUMuupjfLOS3ulgPKZvOgRzoFWkXfUFKE6FEnUB/6wh1+tEz6EafV2OUWmfrwrHosQvVkRZleMKTT0KBQK85xH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImCo/zIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B826C113D0;
	Wed, 31 Dec 2025 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767191542;
	bh=6MYKXYtTc6/OAkL7/kpO9n5U24qF/G1ywlPs8LHS02w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImCo/zIFgOJ879KNXExsDoC6+xTHJlmmsjdSrKo2Zn98Ql8EM7hy0nPWZ8D7SGV5X
	 5mak5H9UHqBSDc6OSAvHAdQTuYrQ4UwITE/ENZM6V/CkZz3nluh0C2Ic2aJ3BMFJTk
	 F3jM+ZH+Xnl2agAkbpLuq20IyNGnzeKtXodgYU9j2GN9wj16CnssgbKlR67W7b8+N6
	 Zi8aZZbAQgDrc9Ur/qs65f1DgA7ipEtc0yBl2wxbCeH9D7Eb1MNnRZy5ngJhMvUYwA
	 bQO9WkUFe8/Y8Kym7mDghz4SPHg8vbKh5Pg5hWDwxjuNSnN5Pt/vN6Oxo9PPoPwlJd
	 yPEzmmybxI4sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/7] gpiolib: acpi: Add acpi_gpio_need_run_edge_events_on_boot() getter
Date: Wed, 31 Dec 2025 09:32:14 -0500
Message-ID: <20251231143218.3042757-3-sashal@kernel.org>
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

[ Upstream commit 5666a8777add09d1167de308df2147983486a0af ]

Add acpi_gpio_need_run_edge_events_on_boot() getter which moves
towards isolating the GPIO ACPI and quirk APIs. It will helps
splitting them completely in the next changes.

No functional changes.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Stable-dep-of: 2d967310c49e ("gpiolib: acpi: Add quirk for Dell Precision 7780")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-acpi.c | 7 ++++++-
 drivers/gpio/gpiolib-acpi.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 7f2f3a686bf1..f64f28423fea 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -268,7 +268,7 @@ static void acpi_gpiochip_request_irq(struct acpi_gpio_chip *acpi_gpio,
 	event->irq_requested = true;
 
 	/* Make sure we trigger the initial state of edge-triggered IRQs */
-	if (run_edge_events_on_boot &&
+	if (acpi_gpio_need_run_edge_events_on_boot() &&
 	    (event->irqflags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))) {
 		value = gpiod_get_raw_value_cansleep(event->desc);
 		if (((event->irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
@@ -371,6 +371,11 @@ void acpi_gpio_remove_from_deferred_list(struct list_head *list)
 	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
 }
 
+int acpi_gpio_need_run_edge_events_on_boot(void)
+{
+	return run_edge_events_on_boot;
+}
+
 bool acpi_gpio_in_ignore_list(enum acpi_gpio_ignore_list list, const char *controller_in,
 			      unsigned int pin_in)
 {
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 8249977e6140..a90267470a4e 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -63,6 +63,8 @@ void acpi_gpio_process_deferred_list(struct list_head *list);
 bool acpi_gpio_add_to_deferred_list(struct list_head *list);
 void acpi_gpio_remove_from_deferred_list(struct list_head *list);
 
+int acpi_gpio_need_run_edge_events_on_boot(void);
+
 enum acpi_gpio_ignore_list {
 	ACPI_GPIO_IGNORE_WAKE,
 	ACPI_GPIO_IGNORE_INTERRUPT,
-- 
2.51.0


