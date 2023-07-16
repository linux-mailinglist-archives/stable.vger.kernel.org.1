Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACE47556AE
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjGPUw4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjGPUwz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA74E41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38AA260EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44374C433C7;
        Sun, 16 Jul 2023 20:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540773;
        bh=mzqmqfhRMZTWcTbwYS/fjxUGQC08RlqhBlXG9X2gSeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/A+ZkzLf/Fed5z4xm0gQBih0vO1oecgXeirTBqcJlwtgp3dq5h6Zrg9+aKAeJF0U
         auhYioK3o75DFa35aJoYd2mtj/hman763qmYUhYjYYkA16wytkTi6lsm+scB4lw7L0
         PRPqBIqUsfS8lDa1f6TnYRC+HB5exfkpQEXeiMTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 482/591] Bluetooth: ISO: use hci_sync for setting CIG parameters
Date:   Sun, 16 Jul 2023 21:50:21 +0200
Message-ID: <20230716194936.369738456@linuxfoundation.org>
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

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 6b9545dc9f8ff01d8bc1229103960d9cd265343f ]

When reconfiguring CIG after disconnection of the last CIS, LE Remove
CIG shall be sent before LE Set CIG Parameters.  Otherwise, it fails
because CIG is in the inactive state and not configurable (Core v5.3
Vol 6 Part B Sec. 4.5.14.3). This ordering is currently wrong under
suitable timing conditions, because LE Remove CIG is sent via the
hci_sync queue and may be delayed, but Set CIG Parameters is via
hci_send_cmd.

Make the ordering well-defined by sending also Set CIG Parameters via
hci_sync.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 47 +++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ab9f00252dc2a..fef09d2121384 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -770,6 +770,11 @@ static void le_conn_timeout(struct work_struct *work)
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 }
 
+struct iso_cig_params {
+	struct hci_cp_le_set_cig_params cp;
+	struct hci_cis_params cis[0x1f];
+};
+
 struct iso_list_data {
 	union {
 		u8  cig;
@@ -781,10 +786,7 @@ struct iso_list_data {
 		u16 sync_handle;
 	};
 	int count;
-	struct {
-		struct hci_cp_le_set_cig_params cp;
-		struct hci_cis_params cis[0x11];
-	} pdu;
+	struct iso_cig_params pdu;
 };
 
 static void bis_list(struct hci_conn *conn, void *data)
@@ -1705,10 +1707,33 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 	return hci_send_cmd(hdev, HCI_OP_LE_CREATE_BIG, sizeof(cp), &cp);
 }
 
+static void set_cig_params_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct iso_cig_params *pdu = data;
+
+	bt_dev_dbg(hdev, "");
+
+	if (err)
+		bt_dev_err(hdev, "Unable to set CIG parameters: %d", err);
+
+	kfree(pdu);
+}
+
+static int set_cig_params_sync(struct hci_dev *hdev, void *data)
+{
+	struct iso_cig_params *pdu = data;
+	u32 plen;
+
+	plen = sizeof(pdu->cp) + pdu->cp.num_cis * sizeof(pdu->cis[0]);
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_CIG_PARAMS, plen, pdu,
+				     HCI_CMD_TIMEOUT);
+}
+
 static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
+	struct iso_cig_params *pdu;
 
 	memset(&data, 0, sizeof(data));
 
@@ -1779,12 +1804,18 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 	if (qos->cis == BT_ISO_QOS_CIS_UNSET || !data.pdu.cp.num_cis)
 		return false;
 
-	if (hci_send_cmd(hdev, HCI_OP_LE_SET_CIG_PARAMS,
-			 sizeof(data.pdu.cp) +
-			 (data.pdu.cp.num_cis * sizeof(*data.pdu.cis)),
-			 &data.pdu) < 0)
+	pdu = kzalloc(sizeof(*pdu), GFP_KERNEL);
+	if (!pdu)
 		return false;
 
+	memcpy(pdu, &data.pdu, sizeof(*pdu));
+
+	if (hci_cmd_sync_queue(hdev, set_cig_params_sync, pdu,
+			       set_cig_params_complete) < 0) {
+		kfree(pdu);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.39.2



