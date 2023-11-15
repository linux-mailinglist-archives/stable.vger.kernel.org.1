Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F417ED6B5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjKOWDK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbjKOWDH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:03:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855691A1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:02:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064DAC433CC;
        Wed, 15 Nov 2023 22:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085778;
        bh=u8ghjVz9LHMlWg0zRcg+0hqcAKg4RLRqHV4hb/AB0Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlJR9CgKGHVSUw1zs8Unw8qSBOlPVeWwf7shKe2q8QZMID+0XBQoWlL6MpFBCre7P
         gt+sR8oYRIi8u1nobKowM1UQb/kXzrVASH57DEOfdyPiVmvbXJF1XtgrZcHiSbca+/
         LN1FfC2bUlzBXM0rCOiF6sMhoZt25nU4Px0X1LrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Rob Herring <robh@kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 048/119] firmware: ti_sci: Replace HTTP links with HTTPS ones
Date:   Wed, 15 Nov 2023 17:00:38 -0500
Message-ID: <20231115220134.124761526@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander A. Klimov <grandmaster@al2klimov.de>

[ Upstream commit a6df49f4224324dd8588f6a0d9cff53cd61a196b ]

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Stable-dep-of: 7b7a224b1ba1 ("firmware: ti_sci: Mark driver as non removable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/ti,sci-intr.txt    | 2 +-
 drivers/firmware/ti_sci.c                                       | 2 +-
 drivers/firmware/ti_sci.h                                       | 2 +-
 drivers/irqchip/irq-ti-sci-inta.c                               | 2 +-
 drivers/irqchip/irq-ti-sci-intr.c                               | 2 +-
 drivers/reset/reset-ti-sci.c                                    | 2 +-
 include/linux/soc/ti/ti_sci_inta_msi.h                          | 2 +-
 include/linux/soc/ti/ti_sci_protocol.h                          | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
index 1a8718f8855d6..178fca08278fe 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
@@ -55,7 +55,7 @@ Required Properties:
 			corresponds to a range of host irqs.
 
 For more details on TISCI IRQ resource management refer:
-http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
+https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
 
 Example:
 --------
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 4126be9e32160..53cee17d01158 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface Protocol Driver
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  */
 
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index f0d068c039444..57cd040629940 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -6,7 +6,7 @@
  * The system works in a message response protocol
  * See: http://processors.wiki.ti.com/index.php/TISCI for details
  *
- * Copyright (C)  2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C)  2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __TI_SCI_H
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 0a35499c46728..94cba59147883 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 Interrupt Aggregator irqchip driver
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index 7d0163d85fb9b..6b366d98fe3c2 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 Interrupt Router irqchip driver
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
index bf68729ab7292..b799aefad547d 100644
--- a/drivers/reset/reset-ti-sci.c
+++ b/drivers/reset/reset-ti-sci.c
@@ -1,7 +1,7 @@
 /*
  * Texas Instrument's System Control Interface (TI-SCI) reset driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/include/linux/soc/ti/ti_sci_inta_msi.h b/include/linux/soc/ti/ti_sci_inta_msi.h
index 11fb5048f5f6e..e3aa8b14612ee 100644
--- a/include/linux/soc/ti/ti_sci_inta_msi.h
+++ b/include/linux/soc/ti/ti_sci_inta_msi.h
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 TI SCI INTA MSI helper
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 9531ec8232988..0fc452dd96d49 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface Protocol
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  */
 
-- 
2.42.0



