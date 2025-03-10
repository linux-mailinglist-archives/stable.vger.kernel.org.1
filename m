Return-Path: <stable+bounces-122181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7AA59E50
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E881687C8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF17230BFC;
	Mon, 10 Mar 2025 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qvufOCN1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874822CBED;
	Mon, 10 Mar 2025 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627758; cv=none; b=Mv6gQ954lewKxaIQrcmyneIDAQFWw0muj++ceG3oT9YgafHPoPtF9SvxDMktW2d8q1lHNoNW4ovlWGTx70aSgTJElGim0Vus5oQ25OEbNOhXh4pBT4H+7heTG6uJWInE+QNBq+Jga6kotpPgWoDJN1MkeXjTXK28WoEkfmU7elg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627758; c=relaxed/simple;
	bh=M4ZnvdaR1hpiaVx9uWd7oBPASmZ166K6y75XaWw1DDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaMY6zFOYlc5ERNNaEJa1R5QJp4rSqZivfQ+cskN4EE+d1tNJG76JND81XepEmtYg80jEsRG2iDDFBMMiJUL6a1iWflBEuuJBOxZgHHqIKikHVNLRYvZvgvdx0x/bgHaSa64G8T6VM/YME5k9eUNQkx0YZvjyu76BUR1HUa1EgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qvufOCN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4DEC4CEE5;
	Mon, 10 Mar 2025 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627758;
	bh=M4ZnvdaR1hpiaVx9uWd7oBPASmZ166K6y75XaWw1DDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvufOCN1VuXvf3Q1XJk48+Ggowjh2n71cSh0wiQOu65jUfXOzMfo/cthEPGbMWknS
	 BpMdgJBlLyV84wV2A78HbowJCYAF127hmT2NkZphsAlt0eVG20ss48VtgsTlmGgYhs
	 yb3FrvE5zH8/z5urf+YRmC1QvDxkRUGs/8G0D4f0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.12 239/269] mei: vsc: Use "wakeuphostint" when getting the host wakeup GPIO
Date: Mon, 10 Mar 2025 18:06:32 +0100
Message-ID: <20250310170507.324072044@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit fdb1ada57cf8b8752cdf54f08709d76d74999544 upstream.

The _CRS ACPI resources table has 2 entries for the host wakeup GPIO,
the first one being a regular GpioIo () resource while the second one
is a GpioInt () resource for the same pin.

The acpi_gpio_mapping table used by vsc-tp.c maps the first Gpio ()
resource to "wakeuphost-gpios" where as the second GpioInt () entry
is mapped to "wakeuphostint-gpios".

Using "wakeuphost" to request the GPIO as was done until now, means
that the gpiolib-acpi code does not know that the GPIO is active-low
as that info is only available in the GpioInt () entry.

Things were still working before due to the following happening:

1. Since the 2 entries point to the same pin they share a struct gpio_desc
2. The SPI core creates the SPI device vsc-tp.c binds to and calls
   acpi_dev_gpio_irq_get(). This does use the second entry and sets
   FLAG_ACTIVE_LOW in gpio_desc.flags .
3. vsc_tp_probe() requests the "wakeuphost" GPIO and inherits the
   active-low flag set by acpi_dev_gpio_irq_get()

But there is a possible scenario where things do not work:

1. - 3. happen as above
4. After requesting the "wakeuphost" GPIO, the "resetfw" GPIO is requested
   next, but its USB GPIO controller is not available yet, so this call
   returns -EPROBE_DEFER.
5. The gpio_desc for "wakeuphost" is put() and during this the active-low
   flag is cleared from gpio_desc.flags .
6. Later on vsc_tp_probe() requests the "wakeuphost" GPIO again, but now it
   is not marked active-low.

The difference can also be seen in /sys/kernel/debug/gpio, which contains
the following line for this GPIO:

 gpio-535 (                    |wakeuphost          ) in  hi IRQ ACTIVE LOW

If the second scenario is hit the "ACTIVE LOW" at the end disappears and
things do not work.

Fix this by requesting the GPIO through the "wakeuphostint" mapping instead
which provides active-low info without relying on acpi_dev_gpio_irq_get()
pre-populating this info in the gpio_desc.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2316918
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20250214212425.84021-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/vsc-tp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -504,7 +504,7 @@ static int vsc_tp_probe(struct spi_devic
 	if (ret)
 		return ret;
 
-	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphost", GPIOD_IN);
+	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphostint", GPIOD_IN);
 	if (IS_ERR(tp->wakeuphost))
 		return PTR_ERR(tp->wakeuphost);
 



