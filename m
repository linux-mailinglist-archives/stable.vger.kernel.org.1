Return-Path: <stable+bounces-8738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C9820480
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB0B1F21727
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363AB5699;
	Sat, 30 Dec 2023 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vPWmKd2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0230779CC
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 11:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D344C433C7;
	Sat, 30 Dec 2023 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703934809;
	bh=X3OZhof2YTqs5TxpIo/ibTflwI9VxHFUR5+ts1R1wHc=;
	h=Subject:To:Cc:From:Date:From;
	b=vPWmKd2clwLt/SwufzA6UwJ2I4sEvf9OXY8NN2WEAhSReZh7ZydcD1sI9jlDuG1ew
	 WjMibNJ54g6VTpP1jIndDYYgqM/5kzaBic0EFDC6X5bTrnk7PGrwLs/vNmdKgQUbwO
	 TjXBa56g+A0MD0qXmVnIxTxsZqni3rX4USUMmbgc=
Subject: FAILED: patch "[PATCH] spi: atmel: Fix clock issue when using devices with different" failed to apply to 6.1-stable tree
To: louis.chauvet@bootlin.com,broonie@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Dec 2023 11:13:27 +0000
Message-ID: <2023123026-print-hydrogen-51d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fc70d643a2f6678cbe0f5c86433c1aeb4d613fcc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123026-print-hydrogen-51d9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

fc70d643a2f6 ("spi: atmel: Fix clock issue when using devices with different polarities")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc70d643a2f6678cbe0f5c86433c1aeb4d613fcc Mon Sep 17 00:00:00 2001
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 4 Dec 2023 16:49:03 +0100
Subject: [PATCH] spi: atmel: Fix clock issue when using devices with different
 polarities

The current Atmel SPI controller driver (v2) behaves incorrectly when
using two SPI devices with different clock polarities and GPIO CS.

When switching from one device to another, the controller driver first
enables the CS and then applies whatever configuration suits the targeted
device (typically, the polarities). The side effect of such order is the
apparition of a spurious clock edge after enabling the CS when the clock
polarity needs to be inverted wrt. the previous configuration of the
controller.

This parasitic clock edge is problematic when the SPI device uses that edge
for internal processing, which is perfectly legitimate given that its CS
was asserted. Indeed, devices such as HVS8080 driven by driver gpio-sr in
the kernel are shift registers and will process this first clock edge to
perform a first register shift. In this case, the first bit gets lost and
the whole data block that will later be read by the kernel is all shifted
by one.

    Current behavior:
      The actual switching of the clock polarity only occurs after the CS
      when the controller sends the first message:

    CLK ------------\   /-\ /-\
                    |   | | | |    . . .
                    \---/ \-/ \
    CS  -----\
             |
             \------------------

             ^      ^   ^
             |      |   |
             |      |   Actual clock of the message sent
             |      |
             |      Change of clock polarity, which occurs with the first
             |      write to the bus. This edge occurs when the CS is
             |      already asserted, and can be interpreted as
             |      the first clock edge by the receiver.
             |
             GPIO CS toggle

This issue is specific to this controller because while the SPI core
performs the operations in the right order, the controller however does
not. In practice, the controller only applies the clock configuration right
before the first transmission.

So this is not a problem when using the controller's dedicated CS, as the
controller does things correctly, but it becomes a problem when you need to
change the clock polarity and use an external GPIO for the CS.

One possible approach to solve this problem is to send a dummy message
before actually activating the CS, so that the controller applies the clock
polarity beforehand.

New behavior:

CLK     ------\      /-\     /-\      /-\     /-\
              |      | | ... | |      | | ... | |
              \------/ \-   -/ \------/ \-   -/ \------

CS      -\/-----------------------\
         ||                       |
         \/                       \---------------------
         ^    ^       ^           ^    ^
         |    |       |           |    |
         |    |       |           |    Expected clock cycles when
         |    |       |           |    sending the message
         |    |       |           |
         |    |       |           Actual GPIO CS activation, occurs inside
         |    |       |           the driver
         |    |       |
         |    |       Dummy message, to trigger clock polarity
         |    |       reconfiguration. This message is not received and
         |    |       processed by the device because CS is low.
         |    |
         |    Change of clock polarity, forced by the dummy message. This
         |    time, the edge is not detected by the receiver.
         |
         This small spike in CS activation is due to the fact that the
         spi-core activates the CS gpio before calling the driver's
         set_cs callback, which deactivates this gpio again until the
         clock polarity is correct.

To avoid having to systematically send a dummy packet, the driver keeps
track of the clock's current polarity. In this way, it only sends the dummy
packet when necessary, ensuring that the clock will have the correct
polarity when the CS is toggled.

There could be two hardware problems with this patch:
1- Maybe the small CS activation peak can confuse SPI devices
2- If on a design, a single wire is used to select two devices depending
on its state, the dummy message may disturb them.

Fixes: 5ee36c989831 ("spi: atmel_spi update chipselect handling")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://msgid.link/r/20231204154903.11607-1-louis.chauvet@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 54277de30161..bad34998454a 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -22,6 +22,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/iopoll.h>
 #include <trace/events/spi.h>
 
 /* SPI register offsets */
@@ -276,6 +277,7 @@ struct atmel_spi {
 	bool			keep_cs;
 
 	u32			fifo_size;
+	bool			last_polarity;
 	u8			native_cs_free;
 	u8			native_cs_for_gpio;
 };
@@ -288,6 +290,22 @@ struct atmel_spi_device {
 #define SPI_MAX_DMA_XFER	65535 /* true for both PDC and DMA */
 #define INVALID_DMA_ADDRESS	0xffffffff
 
+/*
+ * This frequency can be anything supported by the controller, but to avoid
+ * unnecessary delay, the highest possible frequency is chosen.
+ *
+ * This frequency is the highest possible which is not interfering with other
+ * chip select registers (see Note for Serial Clock Bit Rate configuration in
+ * Atmel-11121F-ATARM-SAMA5D3-Series-Datasheet_02-Feb-16, page 1283)
+ */
+#define DUMMY_MSG_FREQUENCY	0x02
+/*
+ * 8 bits is the minimum data the controller is capable of sending.
+ *
+ * This message can be anything as it should not be treated by any SPI device.
+ */
+#define DUMMY_MSG		0xAA
+
 /*
  * Version 2 of the SPI controller has
  *  - CR.LASTXFER
@@ -301,6 +319,43 @@ static bool atmel_spi_is_v2(struct atmel_spi *as)
 	return as->caps.is_spi2;
 }
 
+/*
+ * Send a dummy message.
+ *
+ * This is sometimes needed when using a CS GPIO to force clock transition when
+ * switching between devices with different polarities.
+ */
+static void atmel_spi_send_dummy(struct atmel_spi *as, struct spi_device *spi, int chip_select)
+{
+	u32 status;
+	u32 csr;
+
+	/*
+	 * Set a clock frequency to allow sending message on SPI bus.
+	 * The frequency here can be anything, but is needed for
+	 * the controller to send the data.
+	 */
+	csr = spi_readl(as, CSR0 + 4 * chip_select);
+	csr = SPI_BFINS(SCBR, DUMMY_MSG_FREQUENCY, csr);
+	spi_writel(as, CSR0 + 4 * chip_select, csr);
+
+	/*
+	 * Read all data coming from SPI bus, needed to be able to send
+	 * the message.
+	 */
+	spi_readl(as, RDR);
+	while (spi_readl(as, SR) & SPI_BIT(RDRF)) {
+		spi_readl(as, RDR);
+		cpu_relax();
+	}
+
+	spi_writel(as, TDR, DUMMY_MSG);
+
+	readl_poll_timeout_atomic(as->regs + SPI_SR, status,
+				  (status & SPI_BIT(TXEMPTY)), 1, 1000);
+}
+
+
 /*
  * Earlier SPI controllers (e.g. on at91rm9200) have a design bug whereby
  * they assume that spi slave device state will not change on deselect, so
@@ -317,11 +372,17 @@ static bool atmel_spi_is_v2(struct atmel_spi *as)
  * Master on Chip Select 0.")  No workaround exists for that ... so for
  * nCS0 on that chip, we (a) don't use the GPIO, (b) can't support CS_HIGH,
  * and (c) will trigger that first erratum in some cases.
+ *
+ * When changing the clock polarity, the SPI controller waits for the next
+ * transmission to enforce the default clock state. This may be an issue when
+ * using a GPIO as Chip Select: the clock level is applied only when the first
+ * packet is sent, once the CS has already been asserted. The workaround is to
+ * avoid this by sending a first (dummy) message before toggling the CS state.
  */
-
 static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 {
 	struct atmel_spi_device *asd = spi->controller_state;
+	bool new_polarity;
 	int chip_select;
 	u32 mr;
 
@@ -350,6 +411,25 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
+
+		/*
+		 * Ensures the clock polarity is valid before we actually
+		 * assert the CS to avoid spurious clock edges to be
+		 * processed by the spi devices.
+		 */
+		if (spi_get_csgpiod(spi, 0)) {
+			new_polarity = (asd->csr & SPI_BIT(CPOL)) != 0;
+			if (new_polarity != as->last_polarity) {
+				/*
+				 * Need to disable the GPIO before sending the dummy
+				 * message because it is already set by the spi core.
+				 */
+				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), 0);
+				atmel_spi_send_dummy(as, spi, chip_select);
+				as->last_polarity = new_polarity;
+				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), 1);
+			}
+		}
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
 		int i;


