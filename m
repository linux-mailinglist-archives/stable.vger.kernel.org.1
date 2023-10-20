Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AAE7D1462
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJTQvK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 12:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJTQvK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 12:51:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0BCCA
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 09:51:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA81C433C7;
        Fri, 20 Oct 2023 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697820668;
        bh=UxcsiI/3vFy6mHRMZguagYnbHlujibYrxAnFu2X46a4=;
        h=Subject:To:Cc:From:Date:From;
        b=R7fzOznlCh5NPvKa6gD3VSXL4WyP5CtHG9qvAEv3L1L49KIHnnK/w/li38GWl1/NR
         82A04VbLMW+uzRkKVVfXI+8N8a7kIQp5D9W6ynJWvwwbqNwP9TsVf428HXOhjCGl46
         391i+rMXOJIS24VyEx8OWXe+jTGHXcUr1X2A8dgQ=
Subject: FAILED: patch "[PATCH] Bluetooth: ISO: Fix invalid context error" failed to apply to 6.5-stable tree
To:     iulia.tanasescu@nxp.com, luiz.von.dentz@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 18:51:05 +0200
Message-ID: <2023102005-stomp-defy-0f8e@gregkh>
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


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x acab8ff29a2a226409cfe04e6d2e0896928c1b3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102005-stomp-defy-0f8e@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From acab8ff29a2a226409cfe04e6d2e0896928c1b3a Mon Sep 17 00:00:00 2001
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Date: Thu, 28 Sep 2023 10:52:57 +0300
Subject: [PATCH] Bluetooth: ISO: Fix invalid context error

This moves the hci_le_terminate_big_sync call from rx_work
to cmd_sync_work, to avoid calling sleeping function from
an invalid context.

Reported-by: syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com
Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 31d02b54eea1..e6cfc65abcb8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7021,6 +7021,14 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static int hci_iso_term_big_sync(struct hci_dev *hdev, void *data)
+{
+	u8 handle = PTR_UINT(data);
+
+	return hci_le_terminate_big_sync(hdev, handle,
+					 HCI_ERROR_LOCAL_HOST_TERM);
+}
+
 static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 					   struct sk_buff *skb)
 {
@@ -7065,16 +7073,17 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		rcu_read_lock();
 	}
 
+	rcu_read_unlock();
+
 	if (!ev->status && !i)
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
 		 * has completed.
 		 */
-		hci_le_terminate_big_sync(hdev, ev->handle,
-					  HCI_ERROR_LOCAL_HOST_TERM);
+		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
+				   UINT_PTR(ev->handle), NULL);
 
-	rcu_read_unlock();
 	hci_dev_unlock(hdev);
 }
 

