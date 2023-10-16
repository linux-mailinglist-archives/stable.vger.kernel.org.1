Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577547CA337
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjJPJCd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjJPJCY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:02:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D816FE
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:02:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30FEC433C9;
        Mon, 16 Oct 2023 09:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446942;
        bh=FOPVgJ0iDm/wxOVvpo87H/ff+aUwGBJ81yZ995h/KO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gam0k1RPqki/mxMhzj9w1gRbdnHplR7Uv8Xpmh8OQk8Cif9ln1I6ZFvcrq9tr542k
         ARUmsXl6OBT/xoN4oFJCY/+1bin0fIMDYa7kRpDE7LCMgfKQn2zsv+1p38xM1xHdvi
         4NwfPkoc68Jv9PlrXmzwvxEQEH+r0spGNMgvxrPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Balcanquall <alex@alexbal.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.1 101/131] thunderbolt: Restart XDomain discovery handshake after failure
Date:   Mon, 16 Oct 2023 10:41:24 +0200
Message-ID: <20231016084002.573466487@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 308092d080852f8997126e5b3507536162416f4a upstream.

Alex reported that after rebooting the other host the peer-to-peer link
does not come up anymore. The reason for this is that the host that was
not rebooted tries to send the UUID request only 10 times according to
the USB4 Inter-Domain spec and gives up if it does not get reply. Then
when the other side is actually ready it cannot get the link established
anymore. The USB4 Inter-Domain spec requires that the discovery protocol
is restarted in that case so implement this now.

Reported-by: Alex Balcanquall <alex@alexbal.com>
Fixes: 8e1de7042596 ("thunderbolt: Add support for XDomain lane bonding")
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/xdomain.c |   58 +++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 17 deletions(-)

--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -704,6 +704,27 @@ out_unlock:
 	mutex_unlock(&xdomain_lock);
 }
 
+static void start_handshake(struct tb_xdomain *xd)
+{
+	xd->state = XDOMAIN_STATE_INIT;
+	queue_delayed_work(xd->tb->wq, &xd->state_work,
+			   msecs_to_jiffies(XDOMAIN_SHORT_TIMEOUT));
+}
+
+/* Can be called from state_work */
+static void __stop_handshake(struct tb_xdomain *xd)
+{
+	cancel_delayed_work_sync(&xd->properties_changed_work);
+	xd->properties_changed_retries = 0;
+	xd->state_retries = 0;
+}
+
+static void stop_handshake(struct tb_xdomain *xd)
+{
+	cancel_delayed_work_sync(&xd->state_work);
+	__stop_handshake(xd);
+}
+
 static void tb_xdp_handle_request(struct work_struct *work)
 {
 	struct xdomain_request_work *xw = container_of(work, typeof(*xw), work);
@@ -766,6 +787,15 @@ static void tb_xdp_handle_request(struct
 	case UUID_REQUEST:
 		tb_dbg(tb, "%llx: received XDomain UUID request\n", route);
 		ret = tb_xdp_uuid_response(ctl, route, sequence, uuid);
+		/*
+		 * If we've stopped the discovery with an error such as
+		 * timing out, we will restart the handshake now that we
+		 * received UUID request from the remote host.
+		 */
+		if (!ret && xd && xd->state == XDOMAIN_STATE_ERROR) {
+			dev_dbg(&xd->dev, "restarting handshake\n");
+			start_handshake(xd);
+		}
 		break;
 
 	case LINK_STATE_STATUS_REQUEST:
@@ -1522,6 +1552,13 @@ static void tb_xdomain_queue_properties_
 			   msecs_to_jiffies(XDOMAIN_SHORT_TIMEOUT));
 }
 
+static void tb_xdomain_failed(struct tb_xdomain *xd)
+{
+	xd->state = XDOMAIN_STATE_ERROR;
+	queue_delayed_work(xd->tb->wq, &xd->state_work,
+			   msecs_to_jiffies(XDOMAIN_DEFAULT_TIMEOUT));
+}
+
 static void tb_xdomain_state_work(struct work_struct *work)
 {
 	struct tb_xdomain *xd = container_of(work, typeof(*xd), state_work.work);
@@ -1548,7 +1585,7 @@ static void tb_xdomain_state_work(struct
 		if (ret) {
 			if (ret == -EAGAIN)
 				goto retry_state;
-			xd->state = XDOMAIN_STATE_ERROR;
+			tb_xdomain_failed(xd);
 		} else {
 			tb_xdomain_queue_properties_changed(xd);
 			if (xd->bonding_possible)
@@ -1613,7 +1650,7 @@ static void tb_xdomain_state_work(struct
 		if (ret) {
 			if (ret == -EAGAIN)
 				goto retry_state;
-			xd->state = XDOMAIN_STATE_ERROR;
+			tb_xdomain_failed(xd);
 		} else {
 			xd->state = XDOMAIN_STATE_ENUMERATED;
 		}
@@ -1624,6 +1661,8 @@ static void tb_xdomain_state_work(struct
 		break;
 
 	case XDOMAIN_STATE_ERROR:
+		dev_dbg(&xd->dev, "discovery failed, stopping handshake\n");
+		__stop_handshake(xd);
 		break;
 
 	default:
@@ -1793,21 +1832,6 @@ static void tb_xdomain_release(struct de
 	kfree(xd);
 }
 
-static void start_handshake(struct tb_xdomain *xd)
-{
-	xd->state = XDOMAIN_STATE_INIT;
-	queue_delayed_work(xd->tb->wq, &xd->state_work,
-			   msecs_to_jiffies(XDOMAIN_SHORT_TIMEOUT));
-}
-
-static void stop_handshake(struct tb_xdomain *xd)
-{
-	cancel_delayed_work_sync(&xd->properties_changed_work);
-	cancel_delayed_work_sync(&xd->state_work);
-	xd->properties_changed_retries = 0;
-	xd->state_retries = 0;
-}
-
 static int __maybe_unused tb_xdomain_suspend(struct device *dev)
 {
 	stop_handshake(tb_to_xdomain(dev));


