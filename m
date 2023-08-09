Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87011775D60
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjHILgt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjHILgt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:36:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3F41FD7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:36:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 639596353F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7855BC433C7;
        Wed,  9 Aug 2023 11:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581007;
        bh=9ONyQ4ihBn7mfC8UgUwyjEKAdvj/wr1Iu5ByNyvxK8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAoJLf/dhTXOOR/1ZzXmXyMOWO/5ofckIUYNkpw7NywRtAxmIOTyxNBYDsYB5RMhw
         E5sxQpU5k3T8coeG5Ku+9X44y/Z9LDNFgj7+ACpDEGvJIk0kV8uyop2W7tGBYs5HyY
         VuBcNY6R2kyr1BbjHODph0MhGQg9Ui0ffbZZ/hq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kaufmann Automotive GmbH <info@kaufmann-automotive.ch>,
        Oliver Neukum <oneukum@suse.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.10 072/201] USB: serial: simple: add Kaufmann RKS+CAN VCP
Date:   Wed,  9 Aug 2023 12:41:14 +0200
Message-ID: <20230809103646.227110454@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit dd92c8a1f99bcd166204ffc219ea5a23dd65d64f upstream.

Add the device and product ID for this CAN bus interface / license
dongle. The device is usable either directly from user space or can be
attached to a kernel CAN interface with slcan_attach.

Reported-by: Kaufmann Automotive GmbH <info@kaufmann-automotive.ch>
Tested-by: Kaufmann Automotive GmbH <info@kaufmann-automotive.ch>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
[ johan: amend commit message and move entries in sort order ]
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/usb-serial-simple.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -63,6 +63,11 @@ DEVICE(flashloader, FLASHLOADER_IDS);
 					0x01) }
 DEVICE(google, GOOGLE_IDS);
 
+/* KAUFMANN RKS+CAN VCP */
+#define KAUFMANN_IDS()			\
+	{ USB_DEVICE(0x16d0, 0x0870) }
+DEVICE(kaufmann, KAUFMANN_IDS);
+
 /* Libtransistor USB console */
 #define LIBTRANSISTOR_IDS()			\
 	{ USB_DEVICE(0x1209, 0x8b00) }
@@ -124,6 +129,7 @@ static struct usb_serial_driver * const
 	&funsoft_device,
 	&flashloader_device,
 	&google_device,
+	&kaufmann_device,
 	&libtransistor_device,
 	&vivopay_device,
 	&moto_modem_device,
@@ -142,6 +148,7 @@ static const struct usb_device_id id_tab
 	FUNSOFT_IDS(),
 	FLASHLOADER_IDS(),
 	GOOGLE_IDS(),
+	KAUFMANN_IDS(),
 	LIBTRANSISTOR_IDS(),
 	VIVOPAY_IDS(),
 	MOTO_IDS(),


