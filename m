Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A8F7924BD
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjIEP7f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353726AbjIEHhy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 03:37:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4820CCB;
        Tue,  5 Sep 2023 00:37:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a1de3417acso656846066b.0;
        Tue, 05 Sep 2023 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693899467; x=1694504267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xBrp9r817wKKAMfR9Mj+PoM3I6buWn6veoU7C1fA/8=;
        b=RnGez9v7HmIkfhVJbtOwGSl6ISibrWoz+gJIuHBtPGKDyPbeCKZpko/yxt05HKOddy
         iv/BmrAvnLld4tjJpgQLe3UcwaOvxIzez+EdsGcsyTLkHlfDTJbiAjNl3I9xkinZ9cCX
         G0/TNu+6k1XCoL9MnDqupmszl2CBkGB7qUipy+Cm+ivlTarmS6t3sqabqOvVMnz0x2hz
         yB3PVa34lHNaOPx7XLQnYVs9iHucOB1l6dijJo3z48WLyl2d9cvHhrU1gGACkI7CMtlL
         8CQHMeiMwt4zFrce0Hc73Re9okzgxGsH/+lHRJUtTgNhaYlCC+gx9kCzLbg2TWqF1rgL
         asoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693899467; x=1694504267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xBrp9r817wKKAMfR9Mj+PoM3I6buWn6veoU7C1fA/8=;
        b=ib0nPDWhUeyAniL3eTCP/1nNEM5B4yT3jfWOG9/VSpJ7P9nVfRp0GOXE5v7D0L9k9V
         vHPTOrUOVUvAWAsAM8xD50xgbAqd8PAH661nwJOw7uK4l54z2CMGyn/B4VfmfuYsrbiv
         Hw/xh5Re4M31tTGCaLKMiXSk6HlMdynOMkRFv6hYQ3GR21zCjO0sGfS+PTeE8QQ8IGX5
         sw6re0tQLYu4Fgn15SOT3JT+mmWZluXErptUAOEdy0FgcXVFdsiq9Mc7dufAYiTq7y71
         cWPZwjWri6HOi/UdWgOHw3DtjQS8R5q9gtv22JlpTmZj7nxny8ocaRnkdiphFw8xMqaD
         SCGQ==
X-Gm-Message-State: AOJu0YyK0Lt5e/pXXhDhRfG8dLY0dAg7qmukBgQgXAhuR5xxk8qaBHmj
        Wq7XyP+RtRrdFxdNJij6cqhRla2t2Mc=
X-Google-Smtp-Source: AGHT+IGe2WvdHmD1qbnq9RHRDIRs44Cc6gKEuq159HR84qjJtzm/0F/zO/Yq4l6l0Pc/goMugl1M3g==
X-Received: by 2002:a17:907:7804:b0:99b:4210:cc76 with SMTP id la4-20020a170907780400b0099b4210cc76mr12516418ejc.28.1693899467067;
        Tue, 05 Sep 2023 00:37:47 -0700 (PDT)
Received: from labdl-itc-sw06.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id vi18-20020a170907d41200b0098ec690e6d7sm7206197ejc.73.2023.09.05.00.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:37:46 -0700 (PDT)
From:   Fabio Porcedda <fabio.porcedda@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Fabio Porcedda <fabio.porcedda@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] USB: serial: option: add Telit LE910C4-WWX 0x1035 composition
Date:   Tue,  5 Sep 2023 09:37:24 +0200
Message-ID: <20230905073724.52272-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Add support for the following Telit LE910C4-WWX composition:

0x1035: TTY, TTY, ECM

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: stable@vger.kernel.org
---

Output of usb-devices:

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1035 Rev=00.00
S:  Manufacturer=Telit
S:  Product=LE910C4-WWX
S:  SerialNumber=e1b117c7
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
I:  If#= 3 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

---
 drivers/usb/serial/option.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8ac98e60fff5..50c5fbe1c69c 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1287,6 +1287,7 @@ static const struct usb_device_id option_ids[] = {
 	 .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1033, 0xff),	/* Telit LE910C1-EUX (ECM) */
 	 .driver_info = NCTRL(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1035, 0xff) }, /* Telit LE910C4-WWX (ECM) */
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG0),
 	  .driver_info = RSVD(0) | RSVD(1) | NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG1),
-- 
2.42.0

