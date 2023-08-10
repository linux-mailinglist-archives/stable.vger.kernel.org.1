Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5081F777B2E
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 16:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjHJOpQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjHJOpP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 10:45:15 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF0D2709;
        Thu, 10 Aug 2023 07:45:12 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a7ca8720a0so772314b6e.2;
        Thu, 10 Aug 2023 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691678712; x=1692283512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rjkJeuVhwpYmerUZg6+H8//Urh09ziH3ZOgeiUCEQzI=;
        b=apRBe8cYG91FJb50kRWngSicYQuaLPZ+t1tIQMI35aKEraVpDuu7FqQPUyV84WMph2
         UlJP3i2BDUd5RnfqlkrSngvsGxDpcMMERxYvuGcGZk7v6QUu0+PupB0pO+bqs6xU5SSd
         sv6UZWV8CdHza9bj8yWwfFaGr2fm5h5EXpWqnr5KZJIGaCsMlZ3sKaPWWy6M9YzbK+QE
         bX8uHIpGH6Xoe7bHzZAVjbjU52GaFXPsSRPmlLtm4X6Bu/A2x+6QDGHaXZJruZov9w2/
         EKhl6IIzTFl9HEN3M9sDbs9mM6bbxTt35F9gh+BiJu5OQvM1l1+Qn+nhoebyLF1NF7Y4
         lKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678712; x=1692283512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjkJeuVhwpYmerUZg6+H8//Urh09ziH3ZOgeiUCEQzI=;
        b=VICSd1dyKurOziGGPIc+UyFlZi5xSxRle4AcHSg4GTDdChJDmbidoM7sXF96uzRKQT
         fMMmrYie+M9irfYiDRiE7CNlNVqPsJ0+3SlkHx1aeRnDmQZW9zqaYAbIWlP+PeiIhbIX
         WQa0gTzHGXxnfQJzCU1aFUu+mS/7MtjT6Qf7SJEZldw063g3W2t/JDd3B4JooqEVRV9b
         601dqrzYapnBiHCx6V5dcabflI8PciMrsimc1Ahat4+EHqsMzeaeLIdX0soiht44fYSm
         KpaetD853h/t/ddzVWPzjRLOq0Pt3Jp1ETkEZ8bjDTowQfbrglbhfhWOvs6z8aL9hu+n
         PnjA==
X-Gm-Message-State: AOJu0YwWmXfPAKJHfVq3PtClzjNVKCm5S6kMBrPWSE/N0yOJENUZq22w
        7RDwiBAkyzub1HWwK549WWg=
X-Google-Smtp-Source: AGHT+IEHu25GLPRipZrB9sku1nuH1UA63NNobR7w01LH5A1voBseoPgtJd8fEbbHSTb2J617QgrTrg==
X-Received: by 2002:a05:6808:190b:b0:3a7:215c:e34 with SMTP id bf11-20020a056808190b00b003a7215c0e34mr3749950oib.15.1691678711963;
        Thu, 10 Aug 2023 07:45:11 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l10-20020a54450a000000b003a79a5cc3bfsm723666oil.41.2023.08.10.07.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:45:11 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        stable@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Add device 0bda:4853 to blacklist/quirk table
Date:   Thu, 10 Aug 2023 09:45:07 -0500
Message-ID: <20230810144507.9599-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This new device is part of a Realtek RTW8852BE chip. Without this change
the device utilizes an obsolete version of the firmware that is encoded
in it rather than the updated Realtek firmware and config files from
the firmware directory. The latter files implement many new features.

The device table is as follows:

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
v3 - change "bluetooth" in subject to "Bluetooth"
     change subject to better explain what this patch accomplishes
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

