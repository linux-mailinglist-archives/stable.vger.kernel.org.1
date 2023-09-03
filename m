Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5E790CF8
	for <lists+stable@lfdr.de>; Sun,  3 Sep 2023 18:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343527AbjICQ5f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 3 Sep 2023 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbjICQ5f (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 3 Sep 2023 12:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289CBEA
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 09:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B27A860DCF
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 16:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1443C433C7;
        Sun,  3 Sep 2023 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693760251;
        bh=be1Cy2oCPhC9n4wOj1HCgURKBlnjbS8zy68uKEa1siQ=;
        h=Subject:To:Cc:From:Date:From;
        b=PWQ5fUrn7vxV5/5VFUNrSIaPUukiigoV6859Mw0uAiuX936Zev0PbhD5jo4LgHHHr
         /2GzJusoN/yvT8PmKTWYLMqbOtmeffRW14LRyrfYQyt21UUfXt/H6WsfuFbv8cvVv3
         Qylgje9bh6ik54sm1L+kPBuLowDdeJWeXh5DGIXQ=
Subject: FAILED: patch "[PATCH] usb: typec: tcpci: clear the fault status bit" failed to apply to 4.14-stable tree
To:     m.felsch@pengutronix.de, angus@akkea.ca, christian.bach@scs.ch,
        festevam@denx.de, gregkh@linuxfoundation.org, linux@roeck-us.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 03 Sep 2023 18:57:19 +0200
Message-ID: <2023090319-zone-occupier-984e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 23e60c8daf5ec2ab1b731310761b668745fcf6ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090319-zone-occupier-984e@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

23e60c8daf5e ("usb: typec: tcpci: clear the fault status bit")
ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
4ab8c18d4d67 ("usb: typec: Register a device for every mode")
0bc263149575 ("usb: update for tcpci drivers moving out of staging")
990da41530b3 ("staging: typec: tcpci: move tcpci drivers out of staging")
eafdca4d7010 ("Merge tag 'staging-4.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23e60c8daf5ec2ab1b731310761b668745fcf6ed Mon Sep 17 00:00:00 2001
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 16 Aug 2023 14:25:02 -0300
Subject: [PATCH] usb: typec: tcpci: clear the fault status bit

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
 

