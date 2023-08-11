Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21BD7799A3
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbjHKVhy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbjHKVhw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:37:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67F30D6
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:37:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583c49018c6so28273487b3.0
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691789859; x=1692394659;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bMZsVZSnTwxLBUZ0gFEh6Z7YIIkBHuiAxRukuullP64=;
        b=72OZU8nCPwmXMWau/bDePSdndzSri29uvu09IJBTIwz9ICBVapeWg+SDFxS7gpRIBd
         +zoymg8oFyxYMMo4M9G0obTzeT639Wm5c+nZxA2PPVoPx6nSJ7X5SeuHxeU+U+RlN9U1
         hjbl+ZBBf4O19aItCQ1LkQTdOQR8LZoFzMJwgXYMgGdLoymniI0bFQUGGlBoH+WYmuHb
         uP7n+nRe8wFb8HC7UzjnjPJiAaRlFzCvpVufqlCtPkzJvmGntJ6WVu3PaNLJIwAlmwyg
         HcwoXb2r6JaBHuENjKDKAu+9OBarskuwun5cAk4THv3SdbEQ6o/arCQw+XEJtDCebTqC
         LXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789859; x=1692394659;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMZsVZSnTwxLBUZ0gFEh6Z7YIIkBHuiAxRukuullP64=;
        b=C5endbZ1xQdkev171Kz0RhspxgTsZQBxTlbiCqRcpaHtWRBYdokZw54C688vkDH1ih
         jaDbAmGt+E0ajoCwnDW599xthvqpShjKYMZ21inq1AUUVK9Tm3RxxXiB2mA+MdassRE8
         DttWrcTGJnsdVkpAhu/WJdlVMe3w7KKhLSfBahOwSwP3HalSIEShcoc8MM1FzHiR3H4m
         hYAcPXaoXS1wHgsYZPrHFom7nvcDbDSUGfUIKBkr5vVkHA9YOMbI+c6HfF2eRO640ys4
         wUDwcUKp4RPp2Mzs3/6uwSut3aBfRQJx9IIst4qFXMwSSiHGFF9Su/tIlfEvp5Or4qwN
         dJsw==
X-Gm-Message-State: AOJu0YztjugP9C62SVpX6YJjKqgjzwLYHMNwcyo1siU9s+Jb2EjS7/6w
        oynJKg+iH2qLrwdwKyBnAIM74oSuC1yAIS0=
X-Google-Smtp-Source: AGHT+IFP1TLkOnN0mXKWfJp/bqh9cjlj0kJRsKyzdyvggLP4N2xzIVCKSkVK86ZkSomHRWVcdvm5Y14/oZ6JJ58=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a81:ae12:0:b0:584:41b7:30e7 with SMTP id
 m18-20020a81ae12000000b0058441b730e7mr52742ywh.0.1691789859770; Fri, 11 Aug
 2023 14:37:39 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:37:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811213732.3325896-1-rdbabiera@google.com>
Subject: [PATCH v3] usb: typec: bus: verify partner exists in typec_altmode_attention
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux@roeck-us.net
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Some usb hubs will negotiate DisplayPort Alt mode with the device
but will then negotiate a data role swap after entering the alt
mode. The data role swap causes the device to unregister all alt
modes, however the usb hub will still send Attention messages
even after failing to reregister the Alt Mode. type_altmode_attention
currently does not verify whether or not a device's altmode partner
exists, which results in a NULL pointer error when dereferencing
the typec_altmode and typec_altmode_ops belonging to the altmode
partner.

Verify the presence of a device's altmode partner before sending
the Attention message to the Alt Mode driver.

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
Changes since v1:
* Only assigns pdev if altmode partner exists in typec_altmode_attention
* Removed error return in typec_altmode_attention if Alt Mode does
  not implement Attention messages.
* Changed tcpm_log message to indicate that altmode partner does not exist,
  as it only logs in that case.
---
Changes since v2:
* Changed tcpm_log message to accurately reflect error
* Revised commit message
---
 drivers/usb/typec/bus.c           | 12 ++++++++++--
 drivers/usb/typec/tcpm/tcpm.c     |  5 ++++-
 include/linux/usb/typec_altmode.h |  2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index fe5b9a2e61f5..e95ec7e382bb 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -183,12 +183,20 @@ EXPORT_SYMBOL_GPL(typec_altmode_exit);
  *
  * Notifies the partner of @adev about Attention command.
  */
-void typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
+int typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
 {
-	struct typec_altmode *pdev = &to_altmode(adev)->partner->adev;
+	struct altmode *partner = to_altmode(adev)->partner;
+	struct typec_altmode *pdev;
+
+	if (!partner)
+		return -ENODEV;
+
+	pdev = &partner->adev;
 
 	if (pdev->ops && pdev->ops->attention)
 		pdev->ops->attention(pdev, vdo);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(typec_altmode_attention);
 
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 5a7d8cc04628..97b7b22e9cf1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1791,6 +1791,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 	u32 p[PD_MAX_PAYLOAD];
 	u32 response[8] = { };
 	int i, rlen = 0;
+	int ret;
 
 	for (i = 0; i < cnt; i++)
 		p[i] = le32_to_cpu(payload[i]);
@@ -1877,7 +1878,9 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			}
 			break;
 		case ADEV_ATTENTION:
-			typec_altmode_attention(adev, p[1]);
+			ret = typec_altmode_attention(adev, p[1]);
+			if (ret)
+				tcpm_log(port, "typec_altmode_attention NULL port partner altmode");
 			break;
 		}
 	}
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 350d49012659..28aeef8f9e7b 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -67,7 +67,7 @@ struct typec_altmode_ops {
 
 int typec_altmode_enter(struct typec_altmode *altmode, u32 *vdo);
 int typec_altmode_exit(struct typec_altmode *altmode);
-void typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
+int typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
 int typec_altmode_vdm(struct typec_altmode *altmode,
 		      const u32 header, const u32 *vdo, int count);
 int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,

base-commit: f176638af476c6d46257cc3303f5c7cf47d5967d
-- 
2.41.0.640.ga95def55d0-goog

