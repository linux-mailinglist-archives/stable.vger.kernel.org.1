Return-Path: <stable+bounces-158737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBADAEAFC0
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 09:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169261894962
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 07:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF34219A97;
	Fri, 27 Jun 2025 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Sv1tnpOd"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58EA1DF269;
	Fri, 27 Jun 2025 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007935; cv=fail; b=Rd1j+C5JcHbsl2qGWRdM32xfB+FZPKdWNpdszJbFEstoj3EHPrlAGGzKy7MGk5gihFq5jHRpJbQbIM4QB/UGEllPdNNmwEDAPMvUUo4QMXrGZ09TGo4hYfbjXr+VSwrSf+1rMihu5cch29KbPHaK8UA/pDc+8p9X8J6ejIf87IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007935; c=relaxed/simple;
	bh=XbzYEw5O53LR9PPbOFT2fXS+ghW/p/uuiW5hHkelMxM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qjdngAPS4DlASbncbV8XtzYiPROLvkT5Ju0lqH9zGsMOWD7XbJqfbVB2Hxvk8FT5GKkxEJ6n0rdkPibBHoRhxuFJ55XtF6fc6rjccCdfCKbxWlXwzZhg9yBX7fKr+PeHd2jeGncZvq8NpYxnCtshw704PsTWFFgvy6ykFReSBog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Sv1tnpOd; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0YEJRJt5Dq2eR9nx1WcdeSS3QpbELaaqxFE041MRl9+ExQ59G/lD95cHy6OgpnAgEuMY1gedLATzVel6rCmCCdoGbkWkrtAjFz80SbqHKAB7mN1t8/++N/xbbfopydrY9JjaPjxuHEcATciP0+NeE3KiQFLvXiUx3YdFSCJcWRX4Lu2QBs0Pyk2XvRqP3eGt4QaWu1P8N9ZgcBu9jFwI6u/sxSRod+bxVairwIGaKyOqCVNW0WHZXa/0VUacsrEAwY65SoDGW+Xs5DdYotKskjJsJXwggXpciqMH8iIYV8J97b3RNknV/amPmJXtMc6M2DdYljaTpk0s3p9YDvswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/imwmaZTFNOjIvgrNrZHbusTOOJiG49gZ5KaF+1N9Bg=;
 b=yiExd0q83eIr+xuWRG5BbZ+3jlTXcxQlW/7glcYX8FNEWx+W9tMJmyAE3NyKoH+/wI0K6TQiITRY2gwBpNgRD0kgsobsyTdEZnOKkvnz6GKWN4JcFHEbH3G5kVz2IVQTcZuvZSdejKo/JWzaUY0E0EQnZvH9gccz71EmwWIZusvap4d7wMrttxR59I6v+NasFwVQxI5qxD7KPHpOPP5eTXuYEylew2jHZpDzGfJNWrusv3i8uBTRvhnkUWw8celgwDmMz3tu8zDptqgf5eKqf9bSPwKbe6O5ZKAetXQzjm2kcq45TswYY4MkwJ27Y1WAY7cP/mGc4lFVNWq81jHDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/imwmaZTFNOjIvgrNrZHbusTOOJiG49gZ5KaF+1N9Bg=;
 b=Sv1tnpOdk50Y4UayBo1NcXvnvmpzNZ9RlnTV/VmcMlD2hOOyoFC//ZDMeAGMIWVSx3G5DQ3cDXNaz4fZ/i7/myCGFwsn1wAKtScnOrSnkmqxJPI1rIsdXWqlpQvspgW2TZdyJW2sVodc2jMIs9Jo4YtteHuSNThc4Pve++jU4Uk=
Received: from DUZP191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::7) by
 PA3PR03MB10962.eurprd03.prod.outlook.com (2603:10a6:102:4aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 07:05:21 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::eb) by DUZP191CA0026.outlook.office365.com
 (2603:10a6:10:4f8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 07:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 07:05:19 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 27 Jun
 2025 09:05:19 +0200
From: Christian Eggers <ceggers@arri.de>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	<stable@vger.kernel.org>
Subject: [PATCH v3] Bluetooth: HCI: Set extended advertising data synchronously
Date: Fri, 27 Jun 2025 09:05:08 +0200
Message-ID: <20250627070508.13780-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|PA3PR03MB10962:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf63368-dbe5-435e-0810-08ddb548fa69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ei/AsdUX+T6FqV+AmNLkH06tFbqkRhMBLUHo/c0SKtxb/GZGCjPYVqQtA1a?=
 =?us-ascii?Q?Q+nwAy1+tr0ynMc8YlOoR46cm+J/LQiW3DJJ99q1XlTeoOcV671xibYulBsf?=
 =?us-ascii?Q?FCEBzHSstuhy5x/vz/t3LVyDoPenYf/voQvLWDJ9UQTv7AL7X1VSvO4KooaY?=
 =?us-ascii?Q?8o5O6Oh9kDlIobzFDV4wfuJ1HF6a7nvXcswzGbKFQBr8eDRSbwLsAjpXA26q?=
 =?us-ascii?Q?p36GwkA4MODR2o9Fm1YHnJ7kdVUPhe1tQkV9WseU4Qe5fuL/zIzSLLSGx5hJ?=
 =?us-ascii?Q?bnzMkp+9Tl5PNtvbKi/fQqGlvZvBq5UINNU3wN5pfsFXkYeVD3e5Bee5E962?=
 =?us-ascii?Q?CP53Bf3uxu1k79HZ+kPryBNcVz2KZKUXgT+DD+foLyBrYcXU0OswGjpQQkFV?=
 =?us-ascii?Q?92Mp5vJibd5qKRgIw226HNAZ1DIqZAe4N4aDHqwY9aVl9UTKuT36qrrw/cuc?=
 =?us-ascii?Q?Puoa+jA1c/XsibB+jz6yXs/gaYMJZhif2/w2nqaNViGM5rn10v9lYiIA3gr6?=
 =?us-ascii?Q?+8DgExVbPEYoc8GdokT2r4PZro7+zif1ucGS7i/a5T2O8kOF2mTT09Jbvt/J?=
 =?us-ascii?Q?/hqOr7p6xc8uuHecJMHqG65qQCy1bLcfgAVoc4wYD59ZVg2g5ak3BfW45+jf?=
 =?us-ascii?Q?W5WftTQ0nXKBORTA450bFRimPoiUClaO5GEnqxqdVAmwPrjJ2tlsHdzZQ+ER?=
 =?us-ascii?Q?jJbBqS8SoSuadJEBkltFa6yvCWoIq+Nk/Lw6lIPtpf+yIIP0LZYmfPrPPD/F?=
 =?us-ascii?Q?kTiiC89D2UUUH5xbAGr2iyBOrZBG16b2H0WCFCjx9L7RZW/hxOatEgauorQJ?=
 =?us-ascii?Q?1v9C+wX6T65+OMQB6JuU+B2ZBy0NXLIZ6EFD+Ai9sicE/DE2YY8Lodx24GOH?=
 =?us-ascii?Q?Jz6lDGjSMMVc/LeLr/Pz+8AZQSQtzUXbhE1UYBkrxXnVG6Vca7WmlECQ8KY6?=
 =?us-ascii?Q?AhPJWjbuu50vbio0+kQq0PGnXwXIJ7iKj953rwXs2Cm+uPjIId18q2CxTzmG?=
 =?us-ascii?Q?0rU+6BCmHa23Pa34b9bNCpBCVAyuoc91ZqbqDO4Oym0arJSp9+VMg1Cbfito?=
 =?us-ascii?Q?mx8+5wqVtbCGoaoiY23e8xU+ZbnJidJmlKPi4TOh8BxBXZsmGmmggMyPgWFC?=
 =?us-ascii?Q?mfEEYb9593WuL48+28YcfNZTN7gNCBZ3FlinhTeHUaziy2DktkEJDQNEIMuq?=
 =?us-ascii?Q?A6LWDVFPkXnl6aediwpIFmyAhw9FaxR5xQr+iApgHrCN+nSD1MLeTo3tN0lr?=
 =?us-ascii?Q?H5feeDUbuuDqNe0A3yZWbf4IFWw1KHi/Ut60SHUhzCfNqhcad2MfAJCs6rDK?=
 =?us-ascii?Q?ptzNjOunqlhVdk5WZBPQ3PKHsc/qI4BhrcsBK0VdCP2i3YEQ0dabete2ZYAp?=
 =?us-ascii?Q?+OdTloI1tBsDlxgSPbC0j/xLlwL1TZB7N6PGQrx4heLK6OTVl9BNJx1VRXYz?=
 =?us-ascii?Q?IAiN3LK5KY8L79lwolFU1JSlegDTJZgtYLFeVbspnW/Dl3x9FwXDsMj0+4l+?=
 =?us-ascii?Q?oeLwKQucxNQoJv2NBXjatqV9ig3M5hmnfmimWjsm+DFm/VALCJlJHSmPgw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:05:19.9215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf63368-dbe5-435e-0810-08ddb548fa69
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR03MB10962

Currently, for controllers with extended advertising, the advertising
data is set in the asynchronous response handler for extended
adverstising params. As most advertising settings are performed in a
synchronous context, the (asynchronous) setting of the advertising data
is done too late (after enabling the advertising).

Move setting of adverstising data from asynchronous response handler
into synchronous context to fix ordering of HCI commands.

Signed-off-by: Christian Eggers <ceggers@arri.de>
Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if controller supports")
Cc: stable@vger.kernel.org
v2: https://lore.kernel.org/linux-bluetooth/20250626115209.17839-1-ceggers@arri.de/
---
v3: refactor: store adv_addr_type/tx_power within hci_set_ext_adv_params_sync()

v2: convert setting of adv data into synchronous context (rather than moving
more methods into asynchronous response handlers).
- hci_set_ext_adv_params_sync: new method
- hci_set_ext_adv_data_sync: move within source file (no changes)
- hci_set_adv_data_sync: dito
- hci_update_adv_data_sync: dito
- hci_cc_set_ext_adv_param: remove (performed synchronously now)

 net/bluetooth/hci_event.c |  36 -------
 net/bluetooth/hci_sync.c  | 207 ++++++++++++++++++++++++--------------
 2 files changed, 130 insertions(+), 113 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 66052d6aaa1d..4d5ace9d245d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2150,40 +2150,6 @@ static u8 hci_cc_set_adv_param(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
-static u8 hci_cc_set_ext_adv_param(struct hci_dev *hdev, void *data,
-				   struct sk_buff *skb)
-{
-	struct hci_rp_le_set_ext_adv_params *rp = data;
-	struct hci_cp_le_set_ext_adv_params *cp;
-	struct adv_info *adv_instance;
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
-
-	if (rp->status)
-		return rp->status;
-
-	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS);
-	if (!cp)
-		return rp->status;
-
-	hci_dev_lock(hdev);
-	hdev->adv_addr_type = cp->own_addr_type;
-	if (!cp->handle) {
-		/* Store in hdev for instance 0 */
-		hdev->adv_tx_power = rp->tx_power;
-	} else {
-		adv_instance = hci_find_adv_instance(hdev, cp->handle);
-		if (adv_instance)
-			adv_instance->tx_power = rp->tx_power;
-	}
-	/* Update adv data as tx power is known now */
-	hci_update_adv_data(hdev, cp->handle);
-
-	hci_dev_unlock(hdev);
-
-	return rp->status;
-}
-
 static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
 			   struct sk_buff *skb)
 {
@@ -4164,8 +4130,6 @@ static const struct hci_cc {
 	HCI_CC(HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
 	       hci_cc_le_read_num_adv_sets,
 	       sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
-	HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
-	       sizeof(struct hci_rp_le_set_ext_adv_params)),
 	HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
 		      hci_cc_le_set_ext_adv_enable),
 	HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1f8806dfa556..563614b53485 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1205,9 +1205,126 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+static int
+hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *adv,
+			    const struct hci_cp_le_set_ext_adv_params *cp,
+			    struct hci_rp_le_set_ext_adv_params *rp)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(*cp),
+			     cp, HCI_CMD_TIMEOUT);
+
+	/* If command return a status event, skb will be set to -ENODATA */
+	if (skb == ERR_PTR(-ENODATA))
+		return 0;
+
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld",
+			   HCI_OP_LE_SET_EXT_ADV_PARAMS, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*rp)) {
+		bt_dev_err(hdev, "Invalid response length for "
+			   "HCI_OP_LE_SET_EXT_ADV_PARAMS: %u", skb->len);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	memcpy(rp, skb->data, sizeof(*rp));
+	kfree_skb(skb);
+
+	if (!rp->status) {
+		hdev->adv_addr_type = cp->own_addr_type;
+		if (!cp->handle) {
+			/* Store in hdev for instance 0 */
+			hdev->adv_tx_power = rp->tx_power;
+		} else if (adv) {
+			adv->tx_power = rp->tx_power;
+		}
+	}
+
+	return rp->status;
+}
+
+static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
+		    HCI_MAX_EXT_AD_LENGTH);
+	u8 len;
+	struct adv_info *adv = NULL;
+	int err;
+
+	if (instance) {
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv || !adv->adv_data_changed)
+			return 0;
+	}
+
+	len = eir_create_adv_data(hdev, instance, pdu->data,
+				  HCI_MAX_EXT_AD_LENGTH);
+
+	pdu->length = len;
+	pdu->handle = adv ? adv->handle : instance;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
+				    struct_size(pdu, data, len), pdu,
+				    HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	/* Update data if the command succeed */
+	if (adv) {
+		adv->adv_data_changed = false;
+	} else {
+		memcpy(hdev->adv_data, pdu->data, len);
+		hdev->adv_data_len = len;
+	}
+
+	return 0;
+}
+
+static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct hci_cp_le_set_adv_data cp;
+	u8 len;
+
+	memset(&cp, 0, sizeof(cp));
+
+	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
+
+	/* There's nothing to do if the data hasn't changed */
+	if (hdev->adv_data_len == len &&
+	    memcmp(cp.data, hdev->adv_data, len) == 0)
+		return 0;
+
+	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+	hdev->adv_data_len = len;
+
+	cp.length = len;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return 0;
+
+	if (ext_adv_capable(hdev))
+		return hci_set_ext_adv_data_sync(hdev, instance);
+
+	return hci_set_adv_data_sync(hdev, instance);
+}
+
 int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
+	struct hci_rp_le_set_ext_adv_params rp;
 	bool connectable;
 	u32 flags;
 	bdaddr_t random_addr;
@@ -1316,8 +1433,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		cp.secondary_phy = HCI_ADV_PHY_1M;
 	}
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = hci_set_ext_adv_params_sync(hdev, adv, &cp, &rp);
+	if (err)
+		return err;
+
+	/* Update adv data as tx power is known now */
+	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
 	if (err)
 		return err;
 
@@ -1822,79 +1943,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
-{
-	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
-		    HCI_MAX_EXT_AD_LENGTH);
-	u8 len;
-	struct adv_info *adv = NULL;
-	int err;
-
-	if (instance) {
-		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv || !adv->adv_data_changed)
-			return 0;
-	}
-
-	len = eir_create_adv_data(hdev, instance, pdu->data,
-				  HCI_MAX_EXT_AD_LENGTH);
-
-	pdu->length = len;
-	pdu->handle = adv ? adv->handle : instance;
-	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
-	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
-
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
-				    struct_size(pdu, data, len), pdu,
-				    HCI_CMD_TIMEOUT);
-	if (err)
-		return err;
-
-	/* Update data if the command succeed */
-	if (adv) {
-		adv->adv_data_changed = false;
-	} else {
-		memcpy(hdev->adv_data, pdu->data, len);
-		hdev->adv_data_len = len;
-	}
-
-	return 0;
-}
-
-static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
-{
-	struct hci_cp_le_set_adv_data cp;
-	u8 len;
-
-	memset(&cp, 0, sizeof(cp));
-
-	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
-
-	/* There's nothing to do if the data hasn't changed */
-	if (hdev->adv_data_len == len &&
-	    memcmp(cp.data, hdev->adv_data, len) == 0)
-		return 0;
-
-	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
-	hdev->adv_data_len = len;
-
-	cp.length = len;
-
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
-}
-
-int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
-{
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-		return 0;
-
-	if (ext_adv_capable(hdev))
-		return hci_set_ext_adv_data_sync(hdev, instance);
-
-	return hci_set_adv_data_sync(hdev, instance);
-}
-
 int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 				   bool force)
 {
@@ -6269,6 +6317,7 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 						struct hci_conn *conn)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
+	struct hci_rp_le_set_ext_adv_params rp;
 	int err;
 	bdaddr_t random_addr;
 	u8 own_addr_type;
@@ -6310,8 +6359,12 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 	if (err)
 		return err;
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = hci_set_ext_adv_params_sync(hdev, NULL, &cp, &rp);
+	if (err)
+		return err;
+
+	/* Update adv data as tx power is known now */
+	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
 	if (err)
 		return err;
 
-- 
2.44.1


