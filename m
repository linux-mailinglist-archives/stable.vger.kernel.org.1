Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA479B245
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjIKUvK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241049AbjIKPAg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:00:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4AB1B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:00:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2577C433C7;
        Mon, 11 Sep 2023 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444431;
        bh=0mZ/xn5DqkctqDZZe1gsf/kmjLuE6RbNhcI4t8bf73w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkLmZiDSDsF5bZeYpTGJoo3dCSVK9hmUr0be4qok/6GZCUEzcC/C0HQm/9XtMfk30
         XihM0NgcHerRvbMtRCvCQNcRK2HGLHdbN6gopEaEfbR96Ql4jXfSTH4o5PmhSzvH0l
         WnHldFaqrRyzRrXCbZ/IMKlw+yVKslX+KsmBCnPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 727/737] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
Date:   Mon, 11 Sep 2023 15:49:46 +0200
Message-ID: <20230911134710.818646115@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 253f3399f4c09ce6f4e67350f839be0361b4d5ff ]

This introduces HCI_QUIRK_BROKEN_LE_CODED which is used to indicate
that LE Coded PHY shall not be used, it is then set for some Intel
models that claim to support it but when used causes many problems.

Cc: stable@vger.kernel.org # 6.4.y+
Link: https://github.com/bluez/bluez/issues/577
Link: https://github.com/bluez/bluez/issues/582
Link: https://lore.kernel.org/linux-bluetooth/CABBYNZKco-v7wkjHHexxQbgwwSz-S=GZ=dZKbRE1qxT1h4fFbQ@mail.gmail.com/T/#
Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel.c      |  6 ++++++
 include/net/bluetooth/hci.h      | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  4 +++-
 net/bluetooth/hci_sync.c         |  5 ++++-
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d9349ba48281e..7ba60151a16a6 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2658,6 +2658,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 				&hdev->quirks);
 
+			/* These variants don't seem to support LE Coded PHY */
+			set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
+
 			/* Setup MSFT Extension support */
 			btintel_set_msft_opcode(hdev, ver.hw_variant);
 
@@ -2729,6 +2732,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
+		/* These variants don't seem to support LE Coded PHY */
+		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
+
 		/* Set Valid LE States quirk */
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9ae6f60c96bf2..3ff822ebb3a47 100644
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
index a4b3a95e531a4..3190ca493bd18 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1772,7 +1772,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_2m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_2M) || \
 		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_2M))
 
-#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED))
+#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED) && \
+			       !test_bit(HCI_QUIRK_BROKEN_LE_CODED, \
+					 &(dev)->quirks))
 
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 570909425618d..3177a38ef4d60 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4684,7 +4684,10 @@ static const struct {
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
-- 
2.40.1



