Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6613775B2B
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjHILPB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjHILPB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:15:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993D4ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:15:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A0A262347
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E510C433C8;
        Wed,  9 Aug 2023 11:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579699;
        bh=ZVAjFBOIiZqTllOdsL2izGmL4Zv10JOIcoF7WTvg5tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rzs5lGyNrp81fx4Gif0fv3+DDg7//QAIkz5Vb/7QslRtw9Brd8rursfKhC4KzgWie
         U9QEBqFudHPc2HpOY2hzM/m7CiJtQa3ScoHSz5755Mnq4QRxJUtN/I+6BkIHN1bhl1
         d6mwq3skNepNgZ0bzoGY81woeiIi4Gfwa9QVC0ic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Davide Tronchin <davide.tronchin.94@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 085/323] USB: serial: option: add LARA-R6 01B PIDs
Date:   Wed,  9 Aug 2023 12:38:43 +0200
Message-ID: <20230809103701.995118637@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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


