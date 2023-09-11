Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6289F79B510
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbjIKWjD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbjIKO0M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:26:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0E1DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:26:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8995C433C7;
        Mon, 11 Sep 2023 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442368;
        bh=ciYGroQR3Iy9K/wZhr3sRhSgpbq8Tce3KzkAo2+zmXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WfS/UYxPVWLp5/8K+JpkO/I83rfuaVoS/oQGSCF2+b8PtwKLtB3vyiwX6UGmBXjtO
         f7L50ifMVPBJcW+e0MRV3IUL7ZPPGohrNvNXYpANWNKfP3n9X771QTElAcFVSNbUXj
         HRv4qS37yZamycmWlXCoVbhHqCk9y8sqlOpX84Ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 730/739] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
Date:   Mon, 11 Sep 2023 15:48:49 +0200
Message-ID: <20230911134711.455104155@linuxfoundation.org>
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
index 2a9cdbdb8a81e..c0a87558aea71 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1770,7 +1770,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_2m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_2M) || \
 		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_2M))
 
-#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED))
+#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED) && \
+			       !test_bit(HCI_QUIRK_BROKEN_LE_CODED, \
+					 &(dev)->quirks))
 
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bc84b4617e824..402b8522c2228 100644
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



