Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE970C9E7
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjEVTxA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbjEVTww (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F6188
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D611162B2F
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F333EC433D2;
        Mon, 22 May 2023 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785170;
        bh=uuO2L/NIq/nMVZPZi7LFumN8mAwh2IvzP50feO5GFoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJqu56nzhOfNGAQrSzVZwLLPH4ytTYw3nETPWCRy2dA163VLuBeL5bOMDLOUFBLoe
         6pEyvrwzqJztCxdGZFGm60GP9rbDT0W1TcKNdGULiJPbrXGy3qYtDxuj/Xpmv1Exoc
         bSxS4sox5g1/qsBpyucceXTmOjQEHwLIS6BlROPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Davis <afd@ti.com>,
        stable <stable@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 6.3 332/364] serial: 8250_exar: Add support for USR298x PCI Modems
Date:   Mon, 22 May 2023 20:10:37 +0100
Message-Id: <20230522190421.078443971@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrew Davis <afd@ti.com>

commit 95d698869b404772cc8b72560df71548491c10bc upstream.

Possibly the last PCI controller-based (i.e. not a soft/winmodem)
dial-up modem one can still buy.

Looks to have a stock XR17C154 PCI UART chip for communication, but for
some reason when provisioning the PCI IDs they swapped the vendor and
subvendor IDs. Otherwise this card would have worked out of the box.

Searching online, some folks seem to not have this issue and others do,
so it is possible only some batches of cards have this error.

Create a new macro to handle the switched IDs and add support here.

Signed-off-by: Andrew Davis <afd@ti.com>
Cc: stable <stable@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230420160209.28221-1-afd@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_exar.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -40,9 +40,13 @@
 #define PCI_DEVICE_ID_COMMTECH_4224PCIE		0x0020
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE		0x0021
 #define PCI_DEVICE_ID_COMMTECH_4222PCIE		0x0022
+
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
 
+#define PCI_SUBDEVICE_ID_USR_2980		0x0128
+#define PCI_SUBDEVICE_ID_USR_2981		0x0129
+
 #define PCI_DEVICE_ID_SEALEVEL_710xC		0x1001
 #define PCI_DEVICE_ID_SEALEVEL_720xC		0x1002
 #define PCI_DEVICE_ID_SEALEVEL_740xC		0x1004
@@ -829,6 +833,15 @@ static const struct exar8250_board pbn_e
 		(kernel_ulong_t)&bd			\
 	}
 
+#define USR_DEVICE(devid, sdevid, bd) {			\
+	PCI_DEVICE_SUB(					\
+		PCI_VENDOR_ID_USR,			\
+		PCI_DEVICE_ID_EXAR_##devid,		\
+		PCI_VENDOR_ID_EXAR,			\
+		PCI_SUBDEVICE_ID_USR_##sdevid), 0, 0,	\
+		(kernel_ulong_t)&bd			\
+	}
+
 static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
 	EXAR_DEVICE(ACCESSIO, COM_4S, pbn_exar_XR17C15x),
@@ -853,6 +866,10 @@ static const struct pci_device_id exar_p
 
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
 
+	/* USRobotics USR298x-OEM PCI Modems */
+	USR_DEVICE(XR17C152, 2980, pbn_exar_XR17C15x),
+	USR_DEVICE(XR17C152, 2981, pbn_exar_XR17C15x),
+
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
 	EXAR_DEVICE(EXAR, XR17C152, pbn_exar_XR17C15x),
 	EXAR_DEVICE(EXAR, XR17C154, pbn_exar_XR17C15x),


