Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDAE791CEB
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbjIDSdI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbjIDSdD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E640CCDA
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 868B56198B
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCA8C433C7;
        Mon,  4 Sep 2023 18:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852379;
        bh=hPby2hFyhHNVArWbIVUOVWbeA3xEzl1bNefD2B7+DkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xAQLnwILIGniCRzIXFYJAFE/deyr3hHD7zRf3cp+pfwG7Kk/oQz0+UHHcjDv/nLjJ
         qlmBBkOdbkin/+Hv8kBWWyaPbsaxJyOu33k9r8w0TNR2Oq4YwpqJJBwh1oG3IFyTq2
         lXTMaV9pAU+IGGPMFgWSC0UIr1uWlBMS9SNZNuT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Kohn <m.kohn@welotec.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.4 11/32] USB: serial: option: add Quectel EM05G variant (0x030e)
Date:   Mon,  4 Sep 2023 19:30:09 +0100
Message-ID: <20230904182948.405081224@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
References: <20230904182947.899158313@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kohn <m.kohn@welotec.com>

commit 873854c02364ebb991fc06f7148c14dfb5419e1b upstream.

Add Quectel EM05G with product ID 0x030e.
Interface 4 is used for qmi.

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=030e Rev= 3.18
S:  Manufacturer=Quectel
S:  Product=Quectel EM05-G
C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Martin Kohn <m.kohn@welotec.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/option.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -259,6 +259,7 @@ static void option_instat_callback(struc
 #define QUECTEL_PRODUCT_EM05G			0x030a
 #define QUECTEL_PRODUCT_EM060K			0x030b
 #define QUECTEL_PRODUCT_EM05G_CS		0x030c
+#define QUECTEL_PRODUCT_EM05GV2			0x030e
 #define QUECTEL_PRODUCT_EM05CN_SG		0x0310
 #define QUECTEL_PRODUCT_EM05G_SG		0x0311
 #define QUECTEL_PRODUCT_EM05CN			0x0312
@@ -1188,6 +1189,8 @@ static const struct usb_device_id option
 	  .driver_info = RSVD(6) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G, 0xff),
 	  .driver_info = RSVD(6) | ZLP },
+	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05GV2, 0xff),
+	  .driver_info = RSVD(4) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_CS, 0xff),
 	  .driver_info = RSVD(6) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_GR, 0xff),


