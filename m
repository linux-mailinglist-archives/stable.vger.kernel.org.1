Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F000A799DDE
	for <lists+stable@lfdr.de>; Sun, 10 Sep 2023 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbjIJLZt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 10 Sep 2023 07:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjIJLZt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 10 Sep 2023 07:25:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0577C18B
        for <stable@vger.kernel.org>; Sun, 10 Sep 2023 04:25:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A5DC433C7;
        Sun, 10 Sep 2023 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694345144;
        bh=7UNlBcxZ49mihG+ioeUDXf4NLBpFsBLmhpvonmxMdiQ=;
        h=Subject:To:Cc:From:Date:From;
        b=yjmSOt53KuTIAzqEpZtX0gqhi6vlrxqhSh/vim4gRN6remzMXVPGy5f1VSOrU2qHu
         y9vGIHGx0Urm/6fAHFbbUvinQ/3ckmFAnIDOHUS0pxtWMaszJsDMA9QTEtSbS51rXq
         YFT/Nl58Pt4NSGIPZIPcIVg4VyPvm8pag+T5jvNI=
Subject: FAILED: patch "[PATCH] usb: typec: bus: verify partner exists in" failed to apply to 5.4-stable tree
To:     rdbabiera@google.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, linux@roeck-us.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 10 Sep 2023 12:20:13 +0100
Message-ID: <2023091013-thread-badass-2e0d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f23643306430f86e2f413ee2b986e0773e79da31
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091013-thread-badass-2e0d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

f23643306430 ("usb: typec: bus: verify partner exists in typec_altmode_attention")
95b4d51c96a8 ("usb: typec: tcpm: Refactor tcpm_handle_vdm_request")
8afe9a3548f9 ("usb: typec: tcpm: Refactor tcpm_handle_vdm_request payload handling")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f23643306430f86e2f413ee2b986e0773e79da31 Mon Sep 17 00:00:00 2001
From: RD Babiera <rdbabiera@google.com>
Date: Mon, 14 Aug 2023 18:05:59 +0000
Subject: [PATCH] usb: typec: bus: verify partner exists in
 typec_altmode_attention

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
index 5639b9a1e0bf..ab7e3d7249ab 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1877,7 +1877,8 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			}
 			break;
 		case ADEV_ATTENTION:
-			typec_altmode_attention(adev, p[1]);
+			if (typec_altmode_attention(adev, p[1]))
+				tcpm_log(port, "typec_altmode_attention no port partner altmode");
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

