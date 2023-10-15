Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB77C9AD5
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJOSp3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSp2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:45:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE2AB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:45:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA16C433C7;
        Sun, 15 Oct 2023 18:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697395527;
        bh=pQFIlPp0DXBdDOJVkiMGUJcizkDy5SsT+kAkFWX5RiA=;
        h=Subject:To:Cc:From:Date:From;
        b=hk+XDbknhuAzpZAeg1N+89Y7pPCgk9QgZ+kDRNNtlHD/p6CMsVZNOcTYf6a1MB0Jg
         cMq1j9C/GWnhATgf0FrpZFaMX7kTlF30fLbg2oBhlI3SVXKzQwffFLj1oMczMMzcux
         VUSjgfvSNFSKKYtX/UIm83HqBN/dap+JjnWkuaKw=
Subject: FAILED: patch "[PATCH] usb: typec: altmodes/displayport: Signal hpd low when exiting" failed to apply to 5.10-stable tree
To:     rdbabiera@google.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:45:23 +0200
Message-ID: <2023101523-subsystem-ultimatum-64e9@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 89434b069e460967624903b049e5cf5c9e6b99b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101523-subsystem-ultimatum-64e9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89434b069e460967624903b049e5cf5c9e6b99b9 Mon Sep 17 00:00:00 2001
From: RD Babiera <rdbabiera@google.com>
Date: Mon, 9 Oct 2023 21:00:58 +0000
Subject: [PATCH] usb: typec: altmodes/displayport: Signal hpd low when exiting
 mode

Upon receiving an ACK for a sent EXIT_MODE message, the DisplayPort
driver currently resets the status and configuration of the port partner.
The hpd signal is not updated despite being part of the status, so the
Display stack can still transmit video despite typec_altmode_exit placing
the lanes in a Safe State.

Set hpd to low when a sent EXIT_MODE message is ACK'ed.

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20231009210057.3773877-2-rdbabiera@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 426c88a516e5..59e0218a8bc5 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -304,6 +304,11 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 			typec_altmode_update_active(alt, false);
 			dp->data.status = 0;
 			dp->data.conf = 0;
+			if (dp->hpd) {
+				drm_connector_oob_hotplug_event(dp->connector_fwnode);
+				dp->hpd = false;
+				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
+			}
 			break;
 		case DP_CMD_STATUS_UPDATE:
 			dp->data.status = *vdo;

