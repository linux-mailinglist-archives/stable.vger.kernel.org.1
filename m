Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035957A8072
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjITMhW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbjITMhW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:37:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5DEC6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:37:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D39C433C8;
        Wed, 20 Sep 2023 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213436;
        bh=+WJ/q8666m8m9cFBEH6AUgE1YPSfdxtUi/Nba3Z+kWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0EXlgOXFMGdfUx1TCI+hxDl2xu9SlYjRAcVAuMMAACtlfDfddiPGqZFHx61ngDzY
         JH2mk+T2qDo4o+G+oBk2j1k1prHlG4cCmAeGhjYSYJwAgfA4rkV8jizjQHgvAZRi8y
         bB+IINXa/5o/SlrsDFbiVSed2bjK+1XBQeYxEVvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Christian Bach <christian.bach@scs.ch>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Fabio Estevam <festevam@denx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 236/367] usb: typec: tcpci: clear the fault status bit
Date:   Wed, 20 Sep 2023 13:30:13 +0200
Message-ID: <20230920112904.679639645@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpci.c | 4 ++++
 drivers/usb/typec/tcpm/tcpci.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 84b23ae48aeec..ccb72875c8ee5 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -379,6 +379,10 @@ static int tcpci_init(struct tcpc_dev *tcpc)
 	if (time_after(jiffies, timeout))
 		return -ETIMEDOUT;
 
+	ret = tcpci_write16(tcpci, TCPC_FAULT_STATUS, TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT);
+	if (ret < 0)
+		return ret;
+
 	/* Handle vendor init */
 	if (tcpci->data->init) {
 		ret = tcpci->data->init(tcpci, tcpci->data);
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 303ebde265465..dcf60399f161f 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -72,6 +72,7 @@
 #define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
 
 #define TCPC_FAULT_STATUS		0x1f
+#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
 
 #define TCPC_COMMAND			0x23
 #define TCPC_CMD_WAKE_I2C		0x11
-- 
2.40.1



