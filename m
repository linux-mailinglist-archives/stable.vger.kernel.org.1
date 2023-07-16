Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE27556B1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjGPUxE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjGPUxD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAECE9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 850EE60EA2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E1FC433C7;
        Sun, 16 Jul 2023 20:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540782;
        bh=I7j5rnv/HC4Qm/5j1txqUuzvZgeySl2Sn3VtHTJcavQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPQQV3VQ4QDpX7ftAiJn9oHzrjJImX1DTylb8BvfqU/SgzJDV0jh9Z/K9Vbkrn/YB
         MqLF2D6CH3+A5xGghv3QUUltuwcMMmrUkMDdY1aMxr97EN378KQJofr9AhTqJicyQs
         qsW/NYQztSKlGfWcawvYtRuw029oyP1ONcLHAPpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 485/591] Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable
Date:   Sun, 16 Jul 2023 21:50:24 +0200
Message-ID: <20230716194936.444421942@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 73f55453ea5236a586a7f1b3d5e2ee051d655351 ]

When receiving a scan response there is no way to know if the remote
device is connectable or not, so when it cannot be merged don't
make any assumption and instead just mark it with a new flag defined as
MGMT_DEV_FOUND_SCAN_RSP so userspace can tell it is a standalone
SCAN_RSP.

Link: https://lore.kernel.org/linux-bluetooth/CABBYNZ+CYMsDSPTxBn09Js3BcdC-x7vZFfyLJ3ppZGGwJKmUTw@mail.gmail.com/
Fixes: c70a7e4cc8d2 ("Bluetooth: Add support for Not Connectable flag for Device Found events")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/mgmt.h |  1 +
 net/bluetooth/hci_event.c    | 15 +++++----------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a5801649f6196..5e68b3dd44222 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -979,6 +979,7 @@ struct mgmt_ev_auth_failed {
 #define MGMT_DEV_FOUND_NOT_CONNECTABLE		BIT(2)
 #define MGMT_DEV_FOUND_INITIATED_CONN		BIT(3)
 #define MGMT_DEV_FOUND_NAME_REQUEST_FAILED	BIT(4)
+#define MGMT_DEV_FOUND_SCAN_RSP			BIT(5)
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 21416ccc30ab2..b272cc1f36481 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6307,23 +6307,18 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		return;
 	}
 
-	/* When receiving non-connectable or scannable undirected
-	 * advertising reports, this means that the remote device is
-	 * not connectable and then clearly indicate this in the
-	 * device found event.
-	 *
-	 * When receiving a scan response, then there is no way to
+	/* When receiving a scan response, then there is no way to
 	 * know if the remote device is connectable or not. However
 	 * since scan responses are merged with a previously seen
 	 * advertising report, the flags field from that report
 	 * will be used.
 	 *
-	 * In the really unlikely case that a controller get confused
-	 * and just sends a scan response event, then it is marked as
-	 * not connectable as well.
+	 * In the unlikely case that a controller just sends a scan
+	 * response event that doesn't match the pending report, then
+	 * it is marked as a standalone SCAN_RSP.
 	 */
 	if (type == LE_ADV_SCAN_RSP)
-		flags = MGMT_DEV_FOUND_NOT_CONNECTABLE;
+		flags = MGMT_DEV_FOUND_SCAN_RSP;
 
 	/* If there's nothing pending either store the data from this
 	 * event or send an immediate device found event if the data
-- 
2.39.2



