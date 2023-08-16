Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA1577E788
	for <lists+stable@lfdr.de>; Wed, 16 Aug 2023 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344431AbjHPRZw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 13:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbjHPRZT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 13:25:19 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC3E55;
        Wed, 16 Aug 2023 10:25:18 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56d0deeca09so1017081eaf.0;
        Wed, 16 Aug 2023 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692206717; x=1692811517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZwy11i+99etV1V2sEIzKf13b6QI8uwN0WmhEJWceLk=;
        b=AhxWs/stRhdT+/TEUBJ2p8WcMC9IQwXHQiT6Bo/l90IB1IWzjNfu+up6bi09+loub8
         4KjMunC8fLf+nzFV+gPL1eKItik9N9ScKWX5SuaKmSwfL1mosbSNRzuyEWWPd4ceBa5r
         z2sdupCvE1ScQLFKO1AZJG7NNZAfKKK3p84vksuAHQmRorrnUEu9LuyuTb9w6Gi1pRdp
         k/UyvRg3rRinzb4bRCwHtYFbJWj9bFcvBHMRrsSpXXSKMzh0lpaT/sJTrkI/Cz4rzx7N
         1TgKpK+YK1imXrBjkr2p8wPp0JsIzU81OhYfIhG1ES2fDAVeYBrmPIPM7s8ovEfWM9cB
         V+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692206717; x=1692811517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZwy11i+99etV1V2sEIzKf13b6QI8uwN0WmhEJWceLk=;
        b=kBGEKGKkjC/WGI6sAEWEBhWliY1f0EOsL2y7NH0Ph4numTZONmUsHLLJSmfkIqnyCR
         6k1mGN9rUmqp9X7ak2F6r6ewqSI9W1LDvaWQDN5swfALyxNVxw+WTNSORaC241xuE3TM
         e7mlbJebfjyOO0jsUL5zavH+pEh8qCfhKdA0Ay8GmwdKKmxDvnRfyi9psU7QxWXUEDN6
         aPFWgR5+uEv+P/UM6yF66OzJxzA2FuItfVBSh63s/rAvj+S+bAUTYkJ9/kKJUs6hJph/
         fFOnfHhq3QhTXChGIJdRFBDNuvPhqIk/0hVsv/ghcEeyQUiD73eb+JVwjSwZg+CdP3pU
         7AjQ==
X-Gm-Message-State: AOJu0YzzbOdcNeYLcZ4jQgDVmzQYVaaQCW8jMUw1M21CpTmwy9q4y4ec
        UQqexgOLcnTgfndYUUCR5bM=
X-Google-Smtp-Source: AGHT+IGuozZRbezEFJnG2QmPgsgXQU2/xieDIn0LWYTBq4sgh+w9fU9ua7sgEy3Au2DUdHeXtjykKA==
X-Received: by 2002:a4a:dec2:0:b0:569:a08a:d9c5 with SMTP id w2-20020a4adec2000000b00569a08ad9c5mr2372268oou.0.1692206717358;
        Wed, 16 Aug 2023 10:25:17 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:44e:4905:bf55:4568])
        by smtp.gmail.com with ESMTPSA id l2-20020a4ab0c2000000b0054f85f67f31sm6140859oon.46.2023.08.16.10.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 10:25:16 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     linux@roeck-us.net
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, m.felsch@pengutronix.de, jun.li@nxp.com,
        xu.yang_2@nxp.com, angus@akkea.ca, stable@vger.kernel.org,
        Christian Bach <christian.bach@scs.ch>,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3] usb: typec: tcpci: clear the fault status bit
Date:   Wed, 16 Aug 2023 14:25:02 -0300
Message-Id: <20230816172502.1155079-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

According the "USB Type-C Port Controller Interface Specification v2.0"
the TCPC sets the fault status register bit-7
(AllRegistersResetToDefault) once the registers have been reset to
their default values.

This triggers an alert(-irq) on PTN5110 devices albeit we do mask the
fault-irq, which may cause a kernel hang. Fix this generically by writing
a one to the corresponding bit-7.

Cc: stable@vger.kernel.org
Fixes: 74e656d6b055 ("staging: typec: Type-C Port Controller Interface driver (tcpci)")
Reported-by: Angus Ainslie (Purism) <angus@akkea.ca>
Closes: https://lore.kernel.org/all/20190508002749.14816-2-angus@akkea.ca/
Reported-by: Christian Bach <christian.bach@scs.ch>
Closes: https://lore.kernel.org/regressions/ZR0P278MB07737E5F1D48632897D51AC3EB329@ZR0P278MB0773.CHEP278.PROD.OUTLOOK.COM/t/
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Submitted it as a standalone patch.
- Explain that it may cause a kernel hang.
- Fixed typos in the commit log. (Guenter)
- Check the tcpci_write16() return value. (Guenter)
- Write to TCPC_FAULT_STATUS unconditionally. (Guenter)
- Added Fixes, Reported-by and Closes tags.
- CCed stable

 drivers/usb/typec/tcpm/tcpci.c | 4 ++++
 include/linux/usb/tcpci.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index fc708c289a73..0ee3e6e29bb1 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -602,6 +602,10 @@ static int tcpci_init(struct tcpc_dev *tcpc)
 	if (time_after(jiffies, timeout))
 		return -ETIMEDOUT;
 
+	ret = tcpci_write16(tcpci, TCPC_FAULT_STATUS, TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT);
+	if (ret < 0)
+		return ret;
+
 	/* Handle vendor init */
 	if (tcpci->data->init) {
 		ret = tcpci->data->init(tcpci, tcpci->data);
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 85e95a3251d3..83376473ac76 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -103,6 +103,7 @@
 #define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
 
 #define TCPC_FAULT_STATUS		0x1f
+#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
 
 #define TCPC_ALERT_EXTENDED		0x21
 
-- 
2.34.1

