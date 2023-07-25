Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDCA761496
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjGYLUu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjGYLUn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319CA187
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC7B06166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3ABC433C9;
        Tue, 25 Jul 2023 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284041;
        bh=ZVAjFBOIiZqTllOdsL2izGmL4Zv10JOIcoF7WTvg5tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBNZCnQuChYleXiTyFEvTUcMSRxFhEZcuP65UVvlskkcA7TOXk0HaEML0Mzzw9QxF
         PAO7t2b5I9hOv9oAKIfCEI66L+aHz7qcfAgGYygIFGlNP6ivFlRFodCOcSPSwaIjea
         nMdxx03f6uA8QNQfHpoylzZdBM78QPRucFcGmeQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Davide Tronchin <davide.tronchin.94@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.10 212/509] USB: serial: option: add LARA-R6 01B PIDs
Date:   Tue, 25 Jul 2023 12:42:31 +0200
Message-ID: <20230725104603.436808818@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Davide Tronchin <davide.tronchin.94@gmail.com>

commit ffa5f7a3bf28c1306eef85d4056539c2d4b8eb09 upstream.

The new LARA-R6 product variant identified by the "01B" string can be
configured (by AT interface) in three different USB modes:

* Default mode (Vendor ID: 0x1546 Product ID: 0x1311) with 4 serial
interfaces

* RmNet mode (Vendor ID: 0x1546 Product ID: 0x1312) with 4 serial
interfaces and 1 RmNet virtual network interface

* CDC-ECM mode (Vendor ID: 0x1546 Product ID: 0x1313) with 4 serial
interface and 1 CDC-ECM virtual network interface
The first 4 interfaces of all the 3 USB configurations (default, RmNet,
CDC-ECM) are the same.

In default mode LARA-R6 01B exposes the following interfaces:
If 0: Diagnostic
If 1: AT parser
If 2: AT parser
If 3: AT parser/alternative functions

In RmNet mode LARA-R6 01B exposes the following interfaces:
If 0: Diagnostic
If 1: AT parser
If 2: AT parser
If 3: AT parser/alternative functions
If 4: RMNET interface

In CDC-ECM mode LARA-R6 01B exposes the following interfaces:
If 0: Diagnostic
If 1: AT parser
If 2: AT parser
If 3: AT parser/alternative functions
If 4: CDC-ECM interface

Signed-off-by: Davide Tronchin <davide.tronchin.94@gmail.com>
Link: https://lore.kernel.org/r/20230622092921.12651-1-davide.tronchin.94@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/option.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1151,6 +1151,10 @@ static const struct usb_device_id option
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x90fa),
 	  .driver_info = RSVD(3) },
 	/* u-blox products */
+	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1311) },	/* u-blox LARA-R6 01B */
+	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1312),		/* u-blox LARA-R6 01B (RMNET) */
+	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(UBLOX_VENDOR_ID, 0x1313, 0xff) },	/* u-blox LARA-R6 01B (ECM) */
 	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1341) },	/* u-blox LARA-L6 */
 	{ USB_DEVICE(UBLOX_VENDOR_ID, 0x1342),		/* u-blox LARA-L6 (RMNET) */
 	  .driver_info = RSVD(4) },


