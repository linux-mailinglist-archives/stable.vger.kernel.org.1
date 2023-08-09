Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48098775009
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 03:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHIBEK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 21:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHIBEJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 21:04:09 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D9FB;
        Tue,  8 Aug 2023 18:04:08 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5607cdb0959so3439385eaf.2;
        Tue, 08 Aug 2023 18:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691543048; x=1692147848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jGn47MFQ5cdYQxVHXHzFR9FnA1MOUkniifQd5U494N0=;
        b=CABdulQmDvgh93kNI+rOLjHR2I1lH/0CXlbUMnvdoGNsmVB5YTfs0UYeARg8sSi9om
         sJX0Gi8l3daxOw7VmqEAZOXi2lhm5nhF1Ia9aZT7Cqtq8darUQZNvWKGzcNq3cF6ghgV
         ZrRiIRhfqKOoV/+pfgHLFUgqtCYXtAduBu2stTVrGt4+qgwqhR2LGww5HEbPiFhnND60
         LbwG5DVKMiWXfbmLSqYzuUIH88Qa+yu/jsLceopHiLpiTvf9uifLl+csnPTVIjguuTx2
         Gjo4aUZqvJvZ1XmFrsbk0v6vYt8vacq2A62VbVrV9ExIaTvDXymVJnP3xefJRZfPrlJ8
         UOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543048; x=1692147848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGn47MFQ5cdYQxVHXHzFR9FnA1MOUkniifQd5U494N0=;
        b=ByDAX1N9a01zms+8kVA5kyrzAueuJPEuWn94nYIu/94dCOdNudtWl0r60GOotP/SAM
         9vAYd2O0tSUblgGXy37Yx3pYtgQDkM9nS1wxg0L7q1lCqAGo0Cw1NzbK6OP7BP4xT8+H
         8Wu/lPBJ52cl3uKD/zok3O9Ap/BH1WrRW3xQ0ufimd6RxC63HuqcE20anw6175YhTc4f
         d+N6jQSnZt6JMAVuBmNGOQabP8BtPvmKE4e2xxwzCLcFyCWn71Faon5ZFYAFh5JWwmoI
         8y/aim6knj0GETuPi+cpLPBd/GGK39/CiAtXaYgONyVK3msMSvIadOMG2uzVaDtn8HV1
         r6Xw==
X-Gm-Message-State: AOJu0Yz9R6nGyZh29w0zLZZQW8aP04rxi8L83znr10kNDCCKrt5GBj9j
        vvXpvZkx3xJVi4g2K5Giu6E=
X-Google-Smtp-Source: AGHT+IFshKHghpvcOi+9iDr7BSDtKWMg8C3bSX4FTPeNBmGbNdMqaTcaBJCVylcfOiem6ZVYaWr5bw==
X-Received: by 2002:aca:2b14:0:b0:3a1:df63:60cc with SMTP id i20-20020aca2b14000000b003a1df6360ccmr1283328oik.59.1691543048014;
        Tue, 08 Aug 2023 18:04:08 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808140200b0039ee0bd8a11sm6531589oiv.42.2023.08.08.18.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:04:07 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        stable@vger.kernel.org
Subject: [PATCH v2] bluetooth: Add device 0bda:4853 to device tables
Date:   Tue,  8 Aug 2023 20:04:03 -0500
Message-ID: <20230809010403.24612-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This device is part of a Realtek RTW8852BE chip. The device table
is as follows:

T: Bus=03 Lev=01 Prnt=01 Port=09 Cnt=03 Dev#= 4 Spd=12 MxCh= 0
D: Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0bda ProdID=4853 Rev= 0.00
S: Manufacturer=Realtek
S: Product=Bluetooth Radio
S: SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms

Cc: stable@vger.kernel.org
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - fix too long line in description
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 764d176e9735..1019f19d86a7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -540,6 +540,8 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Realtek 8852BE Bluetooth devices */
 	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0x4853), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3571), .driver_info = BTUSB_REALTEK |
-- 
2.41.0

