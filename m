Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE275CF22
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjGUQ1q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjGUQ12 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD0449D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C340C61D19
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DCEC433C8;
        Fri, 21 Jul 2023 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956598;
        bh=QreyUmuCgMpDQIBdIKNqgKy0OO0NOav7QSgdFiiWNYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qm8nwZZ+PeHWkMJrhp4+ou8rGi4ZcBv2ycpiJGdMH1B5k0pL26C6R1zri0KW+sU5c
         0WyTC6iVK0d/D+iiVKQVjf1gKIbnrSSPM8mVQIqmzEQbQy6bum0XOv3/BDWmML19Pr
         40YMtPMMaZZgMTx8owyQVFFasvnotnDPk1BHp5P4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 6.4 233/292] Revert "8250: add support for ASIX devices with a FIFO bug"
Date:   Fri, 21 Jul 2023 18:05:42 +0200
Message-ID: <20230721160538.872058969@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>

commit a82d62f708545d22859584e0e0620da8e3759bbc upstream.

This reverts commit eb26dfe8aa7eeb5a5aa0b7574550125f8aa4c3b3.

Commit eb26dfe8aa7e ("8250: add support for ASIX devices with a FIFO
bug") merged on Jul 13, 2012 adds a quirk for PCI_VENDOR_ID_ASIX
(0x9710). But that ID is the same as PCI_VENDOR_ID_NETMOS defined in
1f8b061050c7 ("[PATCH] Netmos parallel/serial/combo support") merged
on Mar 28, 2005. In pci_serial_quirks array, the NetMos entry always
takes precedence over the ASIX entry even since it was initially
merged, code in that commit is always unreachable.

In my tests, adding the FIFO workaround to pci_netmos_init() makes no
difference, and the vendor driver also does not have such workaround.
Given that the code was never used for over a decade, it's safe to
revert it.

Also, the real PCI_VENDOR_ID_ASIX should be 0x125b, which is used on
their newer AX99100 PCIe serial controllers released on 2016. The FIFO
workaround should not be intended for these newer controllers, and it
was never implemented in vendor driver.

Fixes: eb26dfe8aa7e ("8250: add support for ASIX devices with a FIFO bug")
Cc: stable <stable@kernel.org>
Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230619155743.827859-1-jiaqing.zhao@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250.h      |    1 -
 drivers/tty/serial/8250/8250_pci.c  |   19 -------------------
 drivers/tty/serial/8250/8250_port.c |   11 +++--------
 include/linux/serial_8250.h         |    1 -
 4 files changed, 3 insertions(+), 29 deletions(-)

--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -91,7 +91,6 @@ struct serial8250_config {
 #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
 #define UART_BUG_NOMSR	BIT(2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	BIT(3)	/* UART has buggy THRE reassertion */
-#define UART_BUG_PARITY	BIT(4)	/* UART mishandles parity if FIFO enabled */
 #define UART_BUG_TXRACE	BIT(5)	/* UART Tx fails to set remote DR */
 
 
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1232,14 +1232,6 @@ static int pci_oxsemi_tornado_setup(stru
 	return pci_default_setup(priv, board, up, idx);
 }
 
-static int pci_asix_setup(struct serial_private *priv,
-		  const struct pciserial_board *board,
-		  struct uart_8250_port *port, int idx)
-{
-	port->bugs |= UART_BUG_PARITY;
-	return pci_default_setup(priv, board, port, idx);
-}
-
 #define QPCR_TEST_FOR1		0x3F
 #define QPCR_TEST_GET1		0x00
 #define QPCR_TEST_FOR2		0x40
@@ -1955,7 +1947,6 @@ pci_moxa_setup(struct serial_private *pr
 #define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
-#define PCI_VENDOR_ID_ASIX		0x9710
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
@@ -2601,16 +2592,6 @@ static struct pci_serial_quirk pci_seria
 		.setup          = pci_wch_ch38x_setup,
 	},
 	/*
-	 * ASIX devices with FIFO bug
-	 */
-	{
-		.vendor		= PCI_VENDOR_ID_ASIX,
-		.device		= PCI_ANY_ID,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_asix_setup,
-	},
-	/*
 	 * Broadcom TruManage (NetXtreme)
 	 */
 	{
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2636,11 +2636,8 @@ static unsigned char serial8250_compute_
 
 	if (c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
-	if (c_cflag & PARENB) {
+	if (c_cflag & PARENB)
 		cval |= UART_LCR_PARITY;
-		if (up->bugs & UART_BUG_PARITY)
-			up->fifo_bug = true;
-	}
 	if (!(c_cflag & PARODD))
 		cval |= UART_LCR_EPAR;
 	if (c_cflag & CMSPAR)
@@ -2801,8 +2798,7 @@ serial8250_do_set_termios(struct uart_po
 	up->lcr = cval;					/* Save computed LCR */
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
-		/* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
-		if ((baud < 2400 && !up->dma) || up->fifo_bug) {
+		if (baud < 2400 && !up->dma) {
 			up->fcr &= ~UART_FCR_TRIGGER_MASK;
 			up->fcr |= UART_FCR_TRIGGER_1;
 		}
@@ -3138,8 +3134,7 @@ static int do_set_rxtrig(struct tty_port
 	struct uart_8250_port *up = up_to_u8250p(uport);
 	int rxtrig;
 
-	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1 ||
-	    up->fifo_bug)
+	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1)
 		return -EINVAL;
 
 	rxtrig = bytes_to_fcr_rxtrig(up, bytes);
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -98,7 +98,6 @@ struct uart_8250_port {
 	struct list_head	list;		/* ports on this IRQ */
 	u32			capabilities;	/* port capabilities */
 	unsigned short		bugs;		/* port bugs */
-	bool			fifo_bug;	/* min RX trigger if enabled */
 	unsigned int		tx_loadsz;	/* transmit fifo load size */
 	unsigned char		acr;
 	unsigned char		fcr;


