Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC5879189A
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjIDNiS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjIDNiR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 09:38:17 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61591719
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 06:37:55 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bb1133b063so161565a34.1
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693834660; x=1694439460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWuAyEqWPFAtbmzk6hyUl+NiyX1XtPJzlUJvhmURwa0=;
        b=chgzthl/yEmDVfazQiNKoTqwHxgbZ7NFxrTYxqXxAL9y+vHNGdaT3Myh6lL/L2ydJE
         vROwPpgvjpY2YydgtfStL80yXndtBE8Q1LOhmgQJ3o3eGGE+rawWUvYhjeDaOu1bhu/+
         fjY3ZP8NYzqRr5NJIKWvyk0pWunlJh1cJ98oPGW5y9n3YLRIqMZznIJqwyQ97rqnNFXH
         hhfsN5MDOEtSA0lodY1/94Aj1yCJv7zyqgsaXaPR6EQjJxOPvAuXeQ0LAjZGtsQihyle
         EPK93BF+ZI7Y83PHPQgLD/N2CN+TSOuxaUBXodie85lRG1rtITbDVug8ozNaL3/hLwa6
         kkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834660; x=1694439460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWuAyEqWPFAtbmzk6hyUl+NiyX1XtPJzlUJvhmURwa0=;
        b=FoPFxeTajOz0sTjdFjIfccx8quXG/i7snoeVL1S71l/idKlxrEMLDss98+dBiq1sgt
         rcaTSi0gPiB4UVhODsqB0JPFhAjhiPrqWYprUw+RV8Ob/RJrSRuKsku/YgkixSf78vIE
         wpybkuGuh3/zBLN573FiRPKRqKcyxyVHEpzeUrephHks5M1eqqpEm3EbQrWbyg6s3CM6
         Vy8xdQi5X1lA32WRGl4NfxPkvaAj4tZnW1UkyowPFf47JGw76Trfx2ERnA1N22opiwWv
         HYMPBCUO3RT3uMi1z7zRQ+U0JrPPyZbstxFzGTRtsXMBAuS54qQnk4ZvjUlHtXGZXbRZ
         ANAw==
X-Gm-Message-State: AOJu0YxWmjmdQ3bPUAexbjMychqSwYgktRkaBwjlPL7OPZBCCEmiz0JJ
        eZcnupR/u7XlDD/C4geuL5S5nXXcsgc=
X-Google-Smtp-Source: AGHT+IGDuLJ0oZolxPxPUmcFRmFgaFPDfIQ3n/h4K9kiEqNS1NruOw7ATEmpJI4x/OaO7+c/LER5ng==
X-Received: by 2002:a05:6830:c85:b0:6b9:b987:1337 with SMTP id bn5-20020a0568300c8500b006b9b9871337mr8706738otb.1.1693834660293;
        Mon, 04 Sep 2023 06:37:40 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a484:cd7:1d2:583])
        by smtp.gmail.com with ESMTPSA id l18-20020a056830155200b006b95392cf09sm4537504otp.33.2023.09.04.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:37:39 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     stable@vger.kernel.org
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Christian Bach <christian.bach@scs.ch>,
        Fabio Estevam <festevam@denx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y 2/2] usb: typec: tcpci: clear the fault status bit
Date:   Mon,  4 Sep 2023 10:37:21 -0300
Message-Id: <20230904133721.3011025-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904133721.3011025-1-festevam@gmail.com>
References: <2023090314-headroom-doorbell-3ac8@gregkh>
 <20230904133721.3011025-1-festevam@gmail.com>
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

[ Upstream commit 23e60c8daf5ec2ab1b731310761b668745fcf6ed ]

According the "USB Type-C Port Controller Interface Specification v2.0"
the TCPC sets the fault status register bit-7
(AllRegistersResetToDefault) once the registers have been reset to
their default values.

This triggers an alert(-irq) on PTN5110 devices albeit we do mask the
fault-irq, which may cause a kernel hang. Fix this generically by writing
a one to the corresponding bit-7.

Cc: stable@vger.kernel.org
Fixes: 74e656d6b055 ("staging: typec: Type-C Port Controller Interface driver (tcpci)")
Reported-by: "Angus Ainslie (Purism)" <angus@akkea.ca>
Closes: https://lore.kernel.org/all/20190508002749.14816-2-angus@akkea.ca/
Reported-by: Christian Bach <christian.bach@scs.ch>
Closes: https://lore.kernel.org/regressions/ZR0P278MB07737E5F1D48632897D51AC3EB329@ZR0P278MB0773.CHEP278.PROD.OUTLOOK.COM/t/
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230816172502.1155079-1-festevam@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpci.c | 4 ++++
 include/linux/usb/tcpci.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 1a6aea9edc78..a7b0134d382b 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -615,6 +615,10 @@ static int tcpci_init(struct tcpc_dev *tcpc)
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
index 20c0bedb8ec8..f7c01ce879a2 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -103,6 +103,7 @@
 #define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
 
 #define TCPC_FAULT_STATUS		0x1f
+#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
 
 #define TCPC_ALERT_EXTENDED		0x21
 
-- 
2.34.1

