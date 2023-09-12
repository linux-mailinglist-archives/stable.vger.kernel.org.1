Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1998379AF20
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376692AbjIKWUQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbjIKN4z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:56:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA3CCD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:56:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51518C433C7;
        Mon, 11 Sep 2023 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440610;
        bh=/4rRWVIGwnP8zHtrAE72AUtMqX+eJ9mewmhJBIsmY+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RF4+aty5Cq9VwGf3fip9HqjbjQCXp6tFmzLAiMubylm+FZJJVq6shyYbKluo3zFpN
         SHu80+Whjs5xpFu4NqE27SsQXwfU2WdBavW3JycCWtUTBwKU4uRX3dlTb82D/+Plzl
         Vi6yaWnt2vF0GzFqIBzhRscUeBqS9fudiQuhlUlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 123/739] Bluetooth: hci_conn: Fix hci_le_set_cig_params
Date:   Mon, 11 Sep 2023 15:38:42 +0200
Message-ID: <20230911134654.530484101@linuxfoundation.org>
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

[ Upstream commit a091289218202bc09d9b9caa8afcde1018584aec ]

When running with concurrent task only one CIS was being assigned so
this attempts to rework the way the PDU is constructed so it is handled
later at the callback instead of in place.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 157 ++++++++++++++++-----------------------
 1 file changed, 63 insertions(+), 94 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b338e2585144e..a746f01659621 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -791,7 +791,6 @@ struct iso_list_data {
 		u16 sync_handle;
 	};
 	int count;
-	struct iso_cig_params pdu;
 	bool big_term;
 };
 
@@ -1719,42 +1718,6 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return sco;
 }
 
-static void cis_add(struct iso_list_data *d, struct bt_iso_qos *qos)
-{
-	struct hci_cis_params *cis = &d->pdu.cis[d->pdu.cp.num_cis];
-
-	cis->cis_id = qos->ucast.cis;
-	cis->c_sdu  = cpu_to_le16(qos->ucast.out.sdu);
-	cis->p_sdu  = cpu_to_le16(qos->ucast.in.sdu);
-	cis->c_phy  = qos->ucast.out.phy ? qos->ucast.out.phy : qos->ucast.in.phy;
-	cis->p_phy  = qos->ucast.in.phy ? qos->ucast.in.phy : qos->ucast.out.phy;
-	cis->c_rtn  = qos->ucast.out.rtn;
-	cis->p_rtn  = qos->ucast.in.rtn;
-
-	d->pdu.cp.num_cis++;
-}
-
-static void cis_list(struct hci_conn *conn, void *data)
-{
-	struct iso_list_data *d = data;
-
-	/* Skip if broadcast/ANY address */
-	if (!bacmp(&conn->dst, BDADDR_ANY))
-		return;
-
-	if (d->cig != conn->iso_qos.ucast.cig || d->cis == BT_ISO_QOS_CIS_UNSET ||
-	    d->cis != conn->iso_qos.ucast.cis)
-		return;
-
-	d->count++;
-
-	if (d->pdu.cp.cig_id == BT_ISO_QOS_CIG_UNSET ||
-	    d->count >= ARRAY_SIZE(d->pdu.cis))
-		return;
-
-	cis_add(d, &conn->iso_qos);
-}
-
 static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -1787,25 +1750,62 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 	return hci_send_cmd(hdev, HCI_OP_LE_CREATE_BIG, sizeof(cp), &cp);
 }
 
-static void set_cig_params_complete(struct hci_dev *hdev, void *data, int err)
+static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 {
-	struct iso_cig_params *pdu = data;
+	u8 cig_id = PTR_ERR(data);
+	struct hci_conn *conn;
+	struct bt_iso_qos *qos;
+	struct iso_cig_params pdu;
+	u8 cis_id;
 
-	bt_dev_dbg(hdev, "");
+	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
+	if (!conn)
+		return 0;
 
-	if (err)
-		bt_dev_err(hdev, "Unable to set CIG parameters: %d", err);
+	memset(&pdu, 0, sizeof(pdu));
 
-	kfree(pdu);
-}
+	qos = &conn->iso_qos;
+	pdu.cp.cig_id = cig_id;
+	hci_cpu_to_le24(qos->ucast.out.interval, pdu.cp.c_interval);
+	hci_cpu_to_le24(qos->ucast.in.interval, pdu.cp.p_interval);
+	pdu.cp.sca = qos->ucast.sca;
+	pdu.cp.packing = qos->ucast.packing;
+	pdu.cp.framing = qos->ucast.framing;
+	pdu.cp.c_latency = cpu_to_le16(qos->ucast.out.latency);
+	pdu.cp.p_latency = cpu_to_le16(qos->ucast.in.latency);
 
-static int set_cig_params_sync(struct hci_dev *hdev, void *data)
-{
-	struct iso_cig_params *pdu = data;
-	u32 plen;
+	/* Reprogram all CIS(s) with the same CIG, valid range are:
+	 * num_cis: 0x00 to 0x1F
+	 * cis_id: 0x00 to 0xEF
+	 */
+	for (cis_id = 0x00; cis_id < 0xf0 &&
+	     pdu.cp.num_cis < ARRAY_SIZE(pdu.cis); cis_id++) {
+		struct hci_cis_params *cis;
+
+		conn = hci_conn_hash_lookup_cis(hdev, NULL, 0, cig_id, cis_id);
+		if (!conn)
+			continue;
 
-	plen = sizeof(pdu->cp) + pdu->cp.num_cis * sizeof(pdu->cis[0]);
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_CIG_PARAMS, plen, pdu,
+		qos = &conn->iso_qos;
+
+		cis = &pdu.cis[pdu.cp.num_cis++];
+		cis->cis_id = cis_id;
+		cis->c_sdu  = cpu_to_le16(conn->iso_qos.ucast.out.sdu);
+		cis->p_sdu  = cpu_to_le16(conn->iso_qos.ucast.in.sdu);
+		cis->c_phy  = qos->ucast.out.phy ? qos->ucast.out.phy :
+			      qos->ucast.in.phy;
+		cis->p_phy  = qos->ucast.in.phy ? qos->ucast.in.phy :
+			      qos->ucast.out.phy;
+		cis->c_rtn  = qos->ucast.out.rtn;
+		cis->p_rtn  = qos->ucast.in.rtn;
+	}
+
+	if (!pdu.cp.num_cis)
+		return 0;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_CIG_PARAMS,
+				     sizeof(pdu.cp) +
+				     pdu.cp.num_cis * sizeof(pdu.cis[0]), &pdu,
 				     HCI_CMD_TIMEOUT);
 }
 
@@ -1813,7 +1813,6 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct iso_list_data data;
-	struct iso_cig_params *pdu;
 
 	memset(&data, 0, sizeof(data));
 
@@ -1840,61 +1839,31 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 		qos->ucast.cig = data.cig;
 	}
 
-	data.pdu.cp.cig_id = qos->ucast.cig;
-	hci_cpu_to_le24(qos->ucast.out.interval, data.pdu.cp.c_interval);
-	hci_cpu_to_le24(qos->ucast.in.interval, data.pdu.cp.p_interval);
-	data.pdu.cp.sca = qos->ucast.sca;
-	data.pdu.cp.packing = qos->ucast.packing;
-	data.pdu.cp.framing = qos->ucast.framing;
-	data.pdu.cp.c_latency = cpu_to_le16(qos->ucast.out.latency);
-	data.pdu.cp.p_latency = cpu_to_le16(qos->ucast.in.latency);
-
 	if (qos->ucast.cis != BT_ISO_QOS_CIS_UNSET) {
-		data.count = 0;
-		data.cig = qos->ucast.cig;
-		data.cis = qos->ucast.cis;
-
-		hci_conn_hash_list_state(hdev, cis_list, ISO_LINK, BT_BOUND,
-					 &data);
-		if (data.count)
+		if (hci_conn_hash_lookup_cis(hdev, NULL, 0, qos->ucast.cig,
+					     qos->ucast.cis))
 			return false;
-
-		cis_add(&data, qos);
+		goto done;
 	}
 
-	/* Reprogram all CIS(s) with the same CIG, valid range are:
-	 * num_cis: 0x00 to 0x1F
-	 * cis_id: 0x00 to 0xEF
-	 */
-	for (data.cig = qos->ucast.cig, data.cis = 0x00; data.cis < 0xf0 &&
-	     data.pdu.cp.num_cis < ARRAY_SIZE(data.pdu.cis); data.cis++) {
-		data.count = 0;
-
-		hci_conn_hash_list_state(hdev, cis_list, ISO_LINK, BT_BOUND,
-					 &data);
-		if (data.count)
-			continue;
-
-		/* Allocate a CIS if not set */
-		if (qos->ucast.cis == BT_ISO_QOS_CIS_UNSET) {
+	/* Allocate first available CIS if not set */
+	for (data.cig = qos->ucast.cig, data.cis = 0x00; data.cis < 0xf0;
+	     data.cis++) {
+		if (!hci_conn_hash_lookup_cis(hdev, NULL, 0, data.cig,
+					      data.cis)) {
 			/* Update CIS */
 			qos->ucast.cis = data.cis;
-			cis_add(&data, qos);
+			break;
 		}
 	}
 
-	if (qos->ucast.cis == BT_ISO_QOS_CIS_UNSET || !data.pdu.cp.num_cis)
+	if (qos->ucast.cis == BT_ISO_QOS_CIS_UNSET)
 		return false;
 
-	pdu = kmemdup(&data.pdu, sizeof(*pdu), GFP_KERNEL);
-	if (!pdu)
-		return false;
-
-	if (hci_cmd_sync_queue(hdev, set_cig_params_sync, pdu,
-			       set_cig_params_complete) < 0) {
-		kfree(pdu);
+done:
+	if (hci_cmd_sync_queue(hdev, set_cig_params_sync,
+			       ERR_PTR(qos->ucast.cig), NULL) < 0)
 		return false;
-	}
 
 	return true;
 }
-- 
2.40.1



