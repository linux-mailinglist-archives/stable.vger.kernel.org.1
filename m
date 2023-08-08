Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D96774A58
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 22:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjHHUZ3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 16:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjHHUZE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 16:25:04 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1331776A5;
        Tue,  8 Aug 2023 12:35:01 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bbaa549c82so4770864fac.0;
        Tue, 08 Aug 2023 12:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691523300; x=1692128100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=I4jmX6f3odZ4nHfZebc6/TcVEAAv4WJvJuplgi61v7I=;
        b=LrhoRfkDVR76vUadL5zLHCdDk9Mqly3jDtCCZl3YVhy/fSfGD0Jh+XIEp90BduDO0t
         JFkmOxtgi0dKU10NsPRnhPQaLiF32shxLAM6ss4Wsd5RpAw1Htn74pnaqa4IIA6lTwpA
         Ow4zgcLGXoowuf5ZX3HzlsPlj/LW1Gm+U2AMhUmzoAaGP74A5ilCcNLFLbcPG70tyL5K
         dN8ZLL2f+EcqRTYOTXhPknyTCKDw+Dbdt7S7BlZVmwUjGnrbqq/FfI+mad0bGruHTINZ
         Jq8dzeooHlsFxHjP3l+NU2Hvn7EOxMiE+jBubLyrYAsgatHTZlB0mCIX6zkENj1loHdD
         BGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691523300; x=1692128100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4jmX6f3odZ4nHfZebc6/TcVEAAv4WJvJuplgi61v7I=;
        b=DW1JTqo3AEm4EB94l4WpdF5H019yuOWk1whS8Rj0Gtfyqx/Kb24DMgyVYNkg/9S44z
         CrNBwJ8nab8Z9bqNzGlBYEkWN1odGKbJ6TzcvdR2f/Tj2MGAVuhTuL0NVh4hoNFXSL8Y
         WHYR2oo4L15TcuHm7JfGk4SLPIsdXUcoTrvflAJaBupDu2uxfJG3VtE385lR5AuheHry
         cTbZvVuVs1O++xtjxLjg4Osqte0fT+EkVGABE6gAELX/8op9CNFAirHtZD5F/rU9h9P2
         sgZJ4ClF0WVUoh4NWBUX7z2gPvHPNZeTyCjIlsoqcR/piVuvKQxBm7k3UEmuwKxDEUGt
         /qvw==
X-Gm-Message-State: AOJu0YyF73tXUEl5FbmBTUSeg4+mGkY7tiE2TZherjDN1YASG89I7tLC
        b5AR2UAK+vbtG3rHAga7/WA=
X-Google-Smtp-Source: AGHT+IErIa+QfvDosdkpjOtdJ6SbDMrCXt8JVuM6PfVYSdoZ/7NfcF+UMUeskadKohsK2dLWSlMo0w==
X-Received: by 2002:a05:6870:ac24:b0:1bf:df47:7b5e with SMTP id kw36-20020a056870ac2400b001bfdf477b5emr709421oab.16.1691523300298;
        Tue, 08 Aug 2023 12:35:00 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id a3-20020a056870b30300b001b390c6e00bsm6411195oao.56.2023.08.08.12.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:34:59 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        stable@vger.kernel.org
Subject: [PATCH] bluetooth: Add device 0bda:4853 to device tables
Date:   Tue,  8 Aug 2023 14:34:55 -0500
Message-ID: <20230808193455.11037-1-Larry.Finger@lwfinger.net>
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

This device is part of a Realtek RTW8852BE chip. The device table is as follows:

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

