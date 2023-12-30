Return-Path: <stable+bounces-8736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660CE82047C
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9860D1C20D1C
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3458C1FCF;
	Sat, 30 Dec 2023 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lv+73qpJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309D2561
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 11:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA10C433C7;
	Sat, 30 Dec 2023 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703934096;
	bh=a1dkY63ylQU1mm61kE2oGTJDR66g9kLQUqs+JYQ8BvQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Lv+73qpJP3VXR5g/lbnjqdZEmaZXW9jz4ap/BtfNIW0/eJ9kQqybxDrbKApLgqT91
	 DCPEhf2k63OMCEjlpmL32+CuGiy+jSyjYhlbCUhuK/MxI/RH7cfPuiN9M5vsclvbG4
	 NYvRCv7Z1vE0TE0QNDpawOTVC+7YKYHdpZpX04Ug=
Subject: FAILED: patch "[PATCH] gpio: dwapb: mask/unmask IRQ when disable/enale it" failed to apply to 4.14-stable tree
To: xiongxin@kylinos.cn,andy@kernel.org,bartosz.golaszewski@linaro.org,fancer.lancer@gmail.com,luriwen@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Dec 2023 11:01:29 +0000
Message-ID: <2023123029-spotted-drove-739f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 1cc3542c76acb5f59001e3e562eba672f1983355
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123029-spotted-drove-739f@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

1cc3542c76ac ("gpio: dwapb: mask/unmask IRQ when disable/enale it")
3c938cc5cebc ("gpio: use raw spinlock for gpio chip shadowed data")
2b725265cb08 ("gpio: mlxbf2: Introduce IRQ support")
603607e70e36 ("gpio: mlxbf2: Drop wrong use of ACPI_PTR()")
dabe57c3a32d ("gpio: mlxbf2: Convert to device PM ops")
4195926aedca ("gpio: Add support for IDT 79RC3243x GPIO controller")
5a5bc826fed1 ("gpio: dwapb: Drop redundant check in dwapb_irq_set_type()")
944dcbe84b8a ("gpio: intel-mid: Remove driver for deprecated platform")
93224edf0b9f ("gpio: msc313: MStar MSC313 GPIO driver")
588cc1a02633 ("dt-bindings: gpio: Add a binding header for the MSC313 GPIO driver")
0ea683931adb ("gpio: dwapb: Convert driver to using the GPIO-lib-based IRQ-chip")
f9f890ba2b13 ("gpio: dwapb: Add max GPIOs macro")
75c1236a4d7c ("gpio: dwapb: Move MFD-specific IRQ handler")
312b62b6610c ("ARM: mstar: Add machine for MStar/Sigmastar Armv7 SoCs")
343e8f7286e8 ("dt-bindings: arm: Add mstar YAML schema")
3f7e82379fc9 ("Merge tag 'gpio-v5.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cc3542c76acb5f59001e3e562eba672f1983355 Mon Sep 17 00:00:00 2001
From: xiongxin <xiongxin@kylinos.cn>
Date: Wed, 20 Dec 2023 10:29:01 +0800
Subject: [PATCH] gpio: dwapb: mask/unmask IRQ when disable/enale it

In the hardware implementation of the I2C HID driver based on DesignWare
GPIO IRQ chip, when the user continues to use the I2C HID device in the
suspend process, the I2C HID interrupt will be masked after the resume
process is finished.

This is because the disable_irq()/enable_irq() of the DesignWare GPIO
driver does not synchronize the IRQ mask register state. In normal use
of the I2C HID procedure, the GPIO IRQ irq_mask()/irq_unmask() functions
are called in pairs. In case of an exception, i2c_hid_core_suspend()
calls disable_irq() to disable the GPIO IRQ. With low probability, this
causes irq_unmask() to not be called, which causes the GPIO IRQ to be
masked and not unmasked in enable_irq(), raising an exception.

Add synchronization to the masked register state in the
dwapb_irq_enable()/dwapb_irq_disable() function. mask the GPIO IRQ
before disabling it. After enabling the GPIO IRQ, unmask the IRQ.

Fixes: 7779b3455697 ("gpio: add a driver for the Synopsys DesignWare APB GPIO block")
Cc: stable@kernel.org
Co-developed-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 4a4f61bf6c58..8c59332429c2 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -282,13 +282,15 @@ static void dwapb_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 val;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val |= BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTEN) | BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTEN, val);
+	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(hwirq);
+	dwapb_write(gpio, GPIO_INTMASK, val);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
@@ -296,12 +298,14 @@ static void dwapb_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 val;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val &= ~BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(hwirq);
+	dwapb_write(gpio, GPIO_INTMASK, val);
+	val = dwapb_read(gpio, GPIO_INTEN) & ~BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTEN, val);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }


