Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB5578DB08
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjH3SiT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245585AbjH3Ph2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 11:37:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9C8122
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 08:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BA98B81F54
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 15:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553F0C433C7;
        Wed, 30 Aug 2023 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693409842;
        bh=3+l9YGQnV+S5TDUK8XWZckiUMR0xE9/Sxnj0T2QUsPY=;
        h=Subject:To:Cc:From:Date:From;
        b=iEUqu7+hI8Nb9VuhHA9kgVlq++4cpXh9K2ujfB/+1ITO9Ct0UD1ZgUQAbKqwqToW7
         VmpUWj2Lxx2E41S5KGYI5+NxevonJUyCqe0P6v8RUIAo3Z1Gh5d5JDwFZnYyYMje8n
         opV6hn1cZY6vNpO10wdBqvg8ITsrcrei/4tT7rGE=
Subject: FAILED: patch "[PATCH] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED" failed to apply to 6.4-stable tree
To:     luiz.von.dentz@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 30 Aug 2023 17:37:03 +0200
Message-ID: <2023083002-unguarded-radiance-bab8@gregkh>
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


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 253f3399f4c09ce6f4e67350f839be0361b4d5ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023083002-unguarded-radiance-bab8@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 253f3399f4c09ce6f4e67350f839be0361b4d5ff Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Tue, 22 Aug 2023 12:02:03 -0700
Subject: [PATCH] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED

This introduces HCI_QUIRK_BROKEN_LE_CODED which is used to indicate
that LE Coded PHY shall not be used, it is then set for some Intel
models that claim to support it but when used causes many problems.

Cc: stable@vger.kernel.org # 6.4.y+
Link: https://github.com/bluez/bluez/issues/577
Link: https://github.com/bluez/bluez/issues/582
Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgwwSz-S=GZ=dZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#
Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 9b239ce96fa4..2462796a512a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2787,6 +2787,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 				&hdev->quirks);
 
+			/* These variants don't seem to support LE Coded PHY */
+			set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
+
 			/* Setup MSFT Extension support */
 			btintel_set_msft_opcode(hdev, ver.hw_variant);
 
@@ -2858,6 +2861,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
+		/* These variants don't seem to support LE Coded PHY */
+		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
+
 		/* Set Valid LE States quirk */
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c58425d4c592..87d92accc26e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -319,6 +319,16 @@ enum {
 	 * This quirk must be set before hci_register_dev is called.
 	 */
 	HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER,
+
+	/*
+	 * When this quirk is set, LE Coded PHY shall not be used. This is
+	 * required for some Intel controllers which erroneously claim to
+	 * support it but it causes problems with extended scanning.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BROKEN_LE_CODED,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6e2988b11f99..e6359f7346f1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1817,7 +1817,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_2m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_2M) || \
 		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_2M))
 
-#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED))
+#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED) && \
+			       !test_bit(HCI_QUIRK_BROKEN_LE_CODED, \
+					 &(dev)->quirks))
 
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0cb780817198..9b93653c6197 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4668,7 +4668,10 @@ static const struct {
 			 "advertised, but not supported."),
 	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
 			 "HCI LE Set Random Private Address Timeout command is "
-			 "advertised, but not supported.")
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(LE_CODED,
+			 "HCI LE Coded PHY feature bit is set, "
+			 "but its usage is not supported.")
 };
 
 /* This function handles hdev setup stage:

