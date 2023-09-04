Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14769791899
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjIDNiR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 09:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjIDNiR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 09:38:17 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55F71715
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 06:37:54 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bc57401cb9so166430a34.0
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693834658; x=1694439458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1Q50ejcBDmGNOjUFiVlD23SEhPI5z1gittyT0cAzig=;
        b=D6zChJ7uDm02G2zdR4NoCWXYiz4kIPtK4I9MJqKEvpf7ZU7A6rpWgbEpzzP155vfRg
         zEI0AcAxa7snGtFXtWL4In8SkPtpnr7Gv4TYe8262k8D3LcpW2YGjGeUU7CkaKYSFvZi
         9jMrelZkbGZP40jTNvX133KIf1WmqAbONu/uiaQty3iPaDFp0hl8bfqiKBYzgzC6klgl
         RBim5lSthfqKptxjtiKqhW1JgTKjvDARa2VRLKKwggPSsOX5tvWa9MOEPAqhyNKWBQ6W
         PRmDhx48AuBab7FQwoaz1f6But7Hz24rlM7gZiV2mL8pw2OBp3xR8wpuSvY64qHID/3y
         nLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834658; x=1694439458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1Q50ejcBDmGNOjUFiVlD23SEhPI5z1gittyT0cAzig=;
        b=lkeSlLqKvaWGUR1wZhbV0s0BBpJWC8G9E0JPdq7zGyBKKcqIjxVIEX9B6pOs9FDW9W
         Lg2xlTf0zN08eYjcgnh3kudomdBcbBuO+57aPfVOUzFK2bmbR9gAgDyBIgCxSw5BOu5V
         FBdQkpSQBk/hxxa8bTVI0lgaFtz4al8kOG+w1+07Xd7FnhLuK9P2YdNdLgVo5TmqFWSG
         IuHtEeCUuPmyr1olLDHPTb+xRKrbjv1Z9thtaziDLTdP4JKahnpLblnbB5VmUuftv1iG
         HBR78YOdiw0DBHKgBPghULl5QYyLA521xKHuApE71uik36gUUU+z5OEiPgY+VvSdj0BH
         loUA==
X-Gm-Message-State: AOJu0Yzqeg2IOCKmFVs9DROv+TKLsiI9x/Iu26pQU/jBKO0vez4nrlgY
        DuDRVc+cYKC7VKI/Sy+Fdi0744vElnE=
X-Google-Smtp-Source: AGHT+IE+QRz7YlyfqwNInHnd4BeZLk/rBtGqnJKOCsW/ohLmiO7L20JWGbPSNcHuSdQO0VA4K8IBhA==
X-Received: by 2002:a05:6830:c85:b0:6b9:b987:1337 with SMTP id bn5-20020a0568300c8500b006b9b9871337mr8706629otb.1.1693834657638;
        Mon, 04 Sep 2023 06:37:37 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a484:cd7:1d2:583])
        by smtp.gmail.com with ESMTPSA id l18-20020a056830155200b006b95392cf09sm4537504otp.33.2023.09.04.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:37:37 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     stable@vger.kernel.org
Cc:     Xin Ji <xji@analogixsemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH 5.15.y 1/2] usb: typec: tcpci: move tcpci.h to include/linux/usb/
Date:   Mon,  4 Sep 2023 10:37:20 -0300
Message-Id: <20230904133721.3011025-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023090314-headroom-doorbell-3ac8@gregkh>
References: <2023090314-headroom-doorbell-3ac8@gregkh>
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

From: Xin Ji <xji@analogixsemi.com>

[ Upstream commit 7963d4d710112bc457f99bdb56608211e561190e ]

USB PD controllers which consisting of a microcontroller (acting as the TCPM)
and a port controller (TCPC) - may require that the driver for the PD
controller accesses directly also the on-chip port controller in some cases.

Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Xin Ji <xji@analogixsemi.com>

Link: https://lore.kernel.org/r/20220706083433.2415524-1-xji@analogixsemi.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 23e60c8daf5e ("usb: typec: tcpci: clear the fault status bit")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
 drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
 drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
 {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
 5 files changed, 5 insertions(+), 7 deletions(-)
 rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 5340a3a3a81b..1a6aea9edc78 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -13,11 +13,10 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 
-#include "tcpci.h"
-
 #define	PD_RETRY_COUNT_DEFAULT			3
 #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
 #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index df2505570f07..4b6705f3d7b7 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -11,11 +11,10 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 
-#include "tcpci.h"
-
 #define PD_ACTIVITY_TIMEOUT_MS				10000
 
 #define TCPC_VENDOR_ALERT				0x80
diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
index 8a952eaf9016..1b7c31278ebb 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
@@ -11,10 +11,9 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 
-#include "tcpci.h"
-
 #define MT6360_REG_PHYCTRL1	0x80
 #define MT6360_REG_PHYCTRL3	0x82
 #define MT6360_REG_PHYCTRL7	0x86
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index b56a0880a044..3291ca4948da 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -10,9 +10,9 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
+#include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/regmap.h>
-#include "tcpci.h"
 
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/include/linux/usb/tcpci.h
similarity index 99%
rename from drivers/usb/typec/tcpm/tcpci.h
rename to include/linux/usb/tcpci.h
index b2edd45f13c6..20c0bedb8ec8 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -9,6 +9,7 @@
 #define __LINUX_USB_TCPCI_H
 
 #include <linux/usb/typec.h>
+#include <linux/usb/tcpm.h>
 
 #define TCPC_VENDOR_ID			0x0
 #define TCPC_PRODUCT_ID			0x2
-- 
2.34.1

