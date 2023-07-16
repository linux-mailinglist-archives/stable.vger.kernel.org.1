Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9067553E8
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjGPUYV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGPUYU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEEF126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D60FE60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6335C433C7;
        Sun, 16 Jul 2023 20:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539058;
        bh=ofxnNPxg1Dz2c/XBDrVZUlQx598lE5SQnxNntU8iBXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KORuKg+gP6/QU2iX5d7Orx7pXo1ijuVlCM5VIy2Ca4l1OkEODZ19yiLH5hWmnTXVQ
         wulBiEQZU+3E5IYSl9AaotYS/ypeLuW4pPk7SzDl0L+AfIC4nv09NSnI45vFae3SqP
         u29L4lya2kUtYWLdLt6oR7vZGfvfyVi3RCJFZn+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 673/800] Bluetooth: ISO: use hci_sync for setting CIG parameters
Date:   Sun, 16 Jul 2023 21:48:46 +0200
Message-ID: <20230716195004.755743180@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 1ef952bda97d8..2275e0d9f8419 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -775,6 +775,11 @@ static void le_conn_timeout(struct work_struct *work)
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
@@ -786,10 +791,7 @@ struct iso_list_data {
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
@@ -1764,10 +1766,33 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
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
 
@@ -1837,12 +1862,18 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 	if (qos->ucast.cis == BT_ISO_QOS_CIS_UNSET || !data.pdu.cp.num_cis)
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



