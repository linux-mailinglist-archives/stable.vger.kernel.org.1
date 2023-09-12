Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53DF79B0B3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353861AbjIKVvN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbjIKN6B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:58:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1FECD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:57:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4088C433C7;
        Mon, 11 Sep 2023 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440676;
        bh=iPjC94JNS1lrJ/T3Vtdk6vI7y2TJt4Rt2RXJsgDFMbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o79B0kpekgoX6p39brbtMBMvLdDx0YFoB8fHhMI44uGX1PH8rgA1WMp1zQzRFs4r6
         /zNcTsm7HeC12I95fMhXQd5BEPVCMwYWfhV8rdWv61z3SV6Ak1Rrw/vt7Pu7ogVMlK
         XEsrFsVUAC0+LAB5zF1CGnSKJlesA7BVL61iBsfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, RD Babiera <rdbabiera@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.5 146/739] usb: typec: bus: verify partner exists in typec_altmode_attention
Date:   Mon, 11 Sep 2023 15:39:05 +0200
Message-ID: <20230911134655.199518588@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: RD Babiera <rdbabiera@google.com>

commit f23643306430f86e2f413ee2b986e0773e79da31 upstream.

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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230814180559.923475-1-rdbabiera@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/bus.c           |   12 ++++++++++--
 drivers/usb/typec/tcpm/tcpm.c     |    3 ++-
 include/linux/usb/typec_altmode.h |    2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

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
 
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1877,7 +1877,8 @@ static void tcpm_handle_vdm_request(stru
 			}
 			break;
 		case ADEV_ATTENTION:
-			typec_altmode_attention(adev, p[1]);
+			if (typec_altmode_attention(adev, p[1]))
+				tcpm_log(port, "typec_altmode_attention no port partner altmode");
 			break;
 		}
 	}
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


