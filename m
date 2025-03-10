Return-Path: <stable+bounces-122705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DE5A5A0D3
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6893AC937
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F33232787;
	Mon, 10 Mar 2025 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XNHTNsCZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56EE2D023;
	Mon, 10 Mar 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629261; cv=none; b=krzMREYG+6ktz6ELAt1/pU79GU79d0/l/K/HBoOyfRAGNyoG2X+FwEE18hXCV5gesq4X7qWIX96kNtH+vnU6cONWQc+Px9K7Y6k8UleviEjWiUnmqVwtmntyktZ6tLJpM5MRWP2j3hlyL40uBLE/Hr35hTL/OPmlsVvsr1FyWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629261; c=relaxed/simple;
	bh=bj1a3w0RXrUzgboBwPhxH1ocw6Jd8HOFfBAdmAgevso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRJni/cLmb8ZOE8ugYb8kORvrymAWnL6XpqNHe54PqqiRxzdQnnQdGtjB6an8C2IHWoTmTqDSw244SbRqBjzCaHE76SH9Hud2FpR/xUaHDc/MbUWabb2g75jh7KTMZ6idlqL4dGORbJje3nznuPZFVXqnNrtbWvZMBAYx2hYVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XNHTNsCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA05C4CEE5;
	Mon, 10 Mar 2025 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629261;
	bh=bj1a3w0RXrUzgboBwPhxH1ocw6Jd8HOFfBAdmAgevso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNHTNsCZqXtpZBRGVfBZRlYiQMz0h4jS+WLHRedOKm6NDBds/d/alrJsJdvbo3HAs
	 jCpNSxXx3QmUxYBqFbPJB6hlqx1P019Tp5MFkanWQgHZ36iGU59IYlZ1r/ZOSVJAQl
	 HrO7FFohp1L6mTFfACc3aHSRGai9/rEUHM+lvfh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 233/620] gpio: Add helpers to ease the transition towards immutable irq_chip
Date: Mon, 10 Mar 2025 18:01:19 +0100
Message-ID: <20250310170554.832103440@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 36b78aae4bfee749bbde73be570796bfd0f56bec ]

Add a couple of new helpers to make it slightly simpler to convert
drivers to immutable irq_chip structures:

- GPIOCHIP_IRQ_RESOURCE_HELPERS populates the irq_chip structure
  with the resource management callbacks

- gpio_irq_chip_set_chip() populates the gpio_irq_chip.chip
  structure, avoiding the proliferation of ugly casts

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-4-maz@kernel.org
Stable-dep-of: 9860370c2172 ("gpio: xilinx: Convert gpio_lock to raw spinlock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gpio/driver.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b241fc23ff3a2..91f60d1e3eb31 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -599,6 +599,18 @@ void gpiochip_enable_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_irq_reqres(struct irq_data *data);
 void gpiochip_irq_relres(struct irq_data *data);
 
+/* Paste this in your irq_chip structure  */
+#define	GPIOCHIP_IRQ_RESOURCE_HELPERS					\
+		.irq_request_resources  = gpiochip_irq_reqres,		\
+		.irq_release_resources  = gpiochip_irq_relres
+
+static inline void gpio_irq_chip_set_chip(struct gpio_irq_chip *girq,
+					  const struct irq_chip *chip)
+{
+	/* Yes, dropping const is ugly, but it isn't like we have a choice */
+	girq->chip = (struct irq_chip *)chip;
+}
+
 /* Line status inquiry for drivers */
 bool gpiochip_line_is_open_drain(struct gpio_chip *gc, unsigned int offset);
 bool gpiochip_line_is_open_source(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.5




