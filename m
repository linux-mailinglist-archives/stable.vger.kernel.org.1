Return-Path: <stable+bounces-158686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E04AE9CE3
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 13:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067643B4F40
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 11:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA684169AE6;
	Thu, 26 Jun 2025 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="utXnEQnO"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE54C81;
	Thu, 26 Jun 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750938758; cv=fail; b=Wwl0ee+6DGyTfJ+T4j86z9YUfSqJALRnY/zeBdaYgi4zCPi0eObBg3dULP/kAlLdzgqOXA0wfgn+PI/PT6Hrtd4lvWtYZeaA+sMAuH/mnZay4n+rNlctbyoxpbpW6cmJ8tDiq9XIWjR05sFFSxCgig/D3gWS1snsv6IITLE+Fxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750938758; c=relaxed/simple;
	bh=v60pAHgQF9p8BwK4KxOcttdB+fkOUn2RWM1ZxYuJBF0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eIdCMT+z+kKTHC249KxaEpkQE0cuU3VPRX1kDb5gEuH79Dm6rbNqmT0KiO8Xd6d1E5UsmEv1oB4QJPaUNgKTtvbNZk7dDUrAWIbiKad6lgkoMcyp8TgvcTN9bf7SzC7c6PQYLpapUH2opf95weD1+2l4BiPXQeaqYmnREU54TPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=utXnEQnO; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nH6JWDmwj5/RCtJ72xyufBvqoNZxNHY2TYDJXtvPHj1yC8kFzpzSs4G75eef+PfU4j4A7wQZwFwi51kavmqndz5ALz25+0maUALlVo44W84fdpqsrqJz90GJVeM/6Ujfwfirvg00p2HhCr9XF3GgqVFZKRNz/D5+ZqfKDIAttiAm5WfQGi7TtQmOuwO72bauLKsjXeG4xJNwoXz98YWVHKwG6QvdEcZxkK8fI4lhj1Ka4dXakC1BRvJRjp2wPCKpBnlWTvA9waiXELzmakwuKyidxoVXhh/PVDaHR+XLVor5amedHZXuRwEYSnRTpJJYNAJs28eOuI1MWLFSzsKFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88wpuiJEIZFceLk091o/GhGyAD3IYNyqpPsypgndQ0g=;
 b=VNiTzdC52mDkAtPNuz4ts9JPcayYJKBAh3pjjv+D7zskOa8ZKpiHz9qMbqgbdqfprFTeD9XRgfkaePnnS3ug0vjIjsTY94R7bZjaJvgdeth5QdzNCaBTR510Jl0VestGlcdmNaTmOARzCRx5exMO8Y6c1xo/5G7v2ZVd508ECUfWEmvqGdDmVPDZeTMUC0LD58M/XiDYFqPsFkGa+EGHVikS02SpNvdNHN689jKjyWlKfb+oH1z3wktlIGwSvWmlq44QXopUGMdyTpwXoCdFzFFvwUTKGEmBsHgEVVdnf5MuYjav/j2BXKU6x8RrGjGxsjb/m+HHUnhhpRGf1lijUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88wpuiJEIZFceLk091o/GhGyAD3IYNyqpPsypgndQ0g=;
 b=utXnEQnOhN3qBZ58gOPBlG00moO+gqnS+8jR9i+BB1p62u7Y2i+EZMgkOYXau/EOjZC5BzIjN9p8fokgD7vgAf8g5ZFTQNRhsuNqdXaN/z7TbVqLoZrkqVRSNETwTRUu4JF2D1p8zzo2q6KsPXZFlC1zt2OPbTW/0kBF6GSjE0w=
Received: from AM0PR02CA0193.eurprd02.prod.outlook.com (2603:10a6:20b:28e::30)
 by GV1PR03MB8688.eurprd03.prod.outlook.com (2603:10a6:150:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Thu, 26 Jun
 2025 11:52:29 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::cc) by AM0PR02CA0193.outlook.office365.com
 (2603:10a6:20b:28e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 11:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:52:28 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Thu, 26 Jun
 2025 13:52:28 +0200
From: Christian Eggers <ceggers@arri.de>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: HCI: Set extended advertising data synchronously
Date: Thu, 26 Jun 2025 13:52:08 +0200
Message-ID: <20250626115209.17839-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|GV1PR03MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: 8504c419-f96f-4d22-6663-08ddb4a7ed22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VTPEIFspmamzt5ZJS+WGxTkTBuuHZiZwxFtoeV7On3Qnobis/h5mDKAfcIz1?=
 =?us-ascii?Q?TvlagH2XAtdz9WugZNvCflYDuaWYYqmlhmfCOQYMEJ6cMKyst5wVnbd1YPbh?=
 =?us-ascii?Q?2QoKbz3R4CoqQUQEik7ZCLRmabeaVFu8iV5Y20aN7bKW5gJ0YQ+uS3bMBORw?=
 =?us-ascii?Q?KaTwB7b/eVde3S/YVSMAEW0fW0uebJ703W3/343EcK5V9pH4tYtaG5NBlpM3?=
 =?us-ascii?Q?WDpGNcWbsTuXVd/TkOMYvte/D3IE97FRBuKaC7yHnuAUFiENFrJ3lHgTyooo?=
 =?us-ascii?Q?dAUnNpFFy10DWJ4rVE6MB56fttKhKYc4kBOJQ5Vckbw8d7mFqlHhOxuFDNSz?=
 =?us-ascii?Q?VBt+q2Gamd93GxryixpfeIv2XjH+quBH1q1tcWyHuLfaFq0yATB6ieam/byw?=
 =?us-ascii?Q?4vxkVfxOV6Fvstyg30qgnDf1xeRpLi6cZV2jrX1nTzB6AgaXkYkUL8+f5Saj?=
 =?us-ascii?Q?BXrmx6lm4C/mtSkMaGvQI0pouEka8WUVwzLBgDnKmm2gJKgQT6Q+m3tKDlNP?=
 =?us-ascii?Q?Cnkg7hQszn9GtxcWwwhoyoe/n1lhvab3OSnXcBxm+nxYFiR3BOry9bdTKuzI?=
 =?us-ascii?Q?4tTMJxbqsCHLw5d3/TNEsyiWu7MYyTNAOtLIJkd0zsIV4tTenDh9HXitxFN+?=
 =?us-ascii?Q?rXQBF9XM/Hwqkjnor4PkKvl5NndCNLF5yLspeAngvoXnAHld/B4lGv+5vDoE?=
 =?us-ascii?Q?OQcbrIYlw0NGL7S4kDs57jaJnEMWcXSSylxzEHPN7pEojy+U6vU6rpA//dGu?=
 =?us-ascii?Q?njPCE3IqA8YHeF/9OMVSsiRTmby8L2g76DTRKGsswWVSY92hMDvSkmokkZFz?=
 =?us-ascii?Q?gf2DExIIJoQ43pZ1TuZjUGTsgMKXr4rI+AO4h0wdr2YwASXwBssaxhnyFx4Y?=
 =?us-ascii?Q?/BVYgwyTAmqfeOFD30XksS7whIJ0w5ucoqEjEIFTZWgcdqsJ7LJEJP2SvJ7Z?=
 =?us-ascii?Q?QssckBXlz2dBDvE10SYxlzwabfaCju6YvXyS0ELKP2koIcAIA59qnjLHclUK?=
 =?us-ascii?Q?+9F1KbqXV8t0DOPC85GUbc7+fjumTSBTW0Xq97ZS0Iq2VoMyNt4NKGDnUfUn?=
 =?us-ascii?Q?02MBIoXC6DVAE9vpQjBZd3bC0nC9h4/inu57/IXulDgCTdj4Dv6WT1p66YRc?=
 =?us-ascii?Q?WlrLOEqFg61u3BZuAWDxnSKPfSjK9fX+JYozsH2XLBUkwQrXIt6986REDj3X?=
 =?us-ascii?Q?5XflcXhz+a8/zXsKp4o2Eu0n3/ghqBSvyvaptdW5hN0x2epC2Eb5+5OtTc6U?=
 =?us-ascii?Q?AQ8C0sEyt9jVxNvaVsT7BZ4BKVXlbhDsyMAyCVqcnj/cpGiWFSGdJ5kQRZEN?=
 =?us-ascii?Q?vu7O2KhmDPdmdWpbtCsfEe3x/XKbsG6xtTJZEhvCtWdXY5sH85xNdMEc7RWe?=
 =?us-ascii?Q?bBvmt9S7EP64aWB82ZITsv11GenpY7In5MxnYuHG3W8QzicQLGzNuKtP6Sku?=
 =?us-ascii?Q?4Yc1bUxRfJN3iY4f4KT7ZiLc9dgybFoyvHa7ulSLN7SviGBJTYGCwuFjp07h?=
 =?us-ascii?Q?w8f+fhm/qWPV9P38J9Pmwyw+vOxcwFd5FfR6jfQMAiHRNzkCwnRvpvg+gw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:52:28.7096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8504c419-f96f-4d22-6663-08ddb4a7ed22
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8688

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
v1: https://lore.kernel.org/linux-bluetooth/20250625130510.18382-1-ceggers@arri.de/
---
v2: convert setting of adv data into synchronous context (rather than moving
more methods into asynchronous response handlers).
- hci_set_ext_adv_params_sync: new method
- hci_set_ext_adv_data_sync: move within source file (no changes)
- hci_set_adv_data_sync: dito
- hci_update_adv_data_sync: dito
- hci_cc_set_ext_adv_param: remove (performed synchronously now)

On Wednesday, 25 June 2025, 15:26:58 CEST, Luiz Augusto von Dentz wrote:
> That said for the likes of MGMT_OP_ADD_EXT_ADV_DATA you will still
> need to detect if the instance has already been enabled then do
> disable/re-enable logic if the quirk is set.

The critical opcode (HCI_OP_LE_SET_EXT_ADV_DATA) is only used in
hci_set_ext_adv_data_sync(). Two of the callers already ensure that
the advertising instance is disabled, so only hci_update_adv_data_sync()
may need a quirk. I suggest doing this in a separate patch.

regards,
Christian

 net/bluetooth/hci_event.c |  36 -------
 net/bluetooth/hci_sync.c  | 209 ++++++++++++++++++++++++--------------
 2 files changed, 132 insertions(+), 113 deletions(-)

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
index 1f8806dfa556..2a09b2cb983e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1205,9 +1205,116 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+static int
+hci_set_ext_adv_params_sync(struct hci_dev *hdev,
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
@@ -1316,8 +1423,20 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		cp.secondary_phy = HCI_ADV_PHY_1M;
 	}
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = hci_set_ext_adv_params_sync(hdev, &cp, &rp);
+	if (err)
+		return err;
+
+	hdev->adv_addr_type = own_addr_type;
+	if (!cp.handle) {
+		/* Store in hdev for instance 0 */
+		hdev->adv_tx_power = rp.tx_power;
+	} else if (adv) {
+		adv->tx_power = rp.tx_power;
+	}
+
+	/* Update adv data as tx power is known now */
+	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
 	if (err)
 		return err;
 
@@ -1822,79 +1941,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
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
@@ -6269,6 +6315,7 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 						struct hci_conn *conn)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
+	struct hci_rp_le_set_ext_adv_params rp;
 	int err;
 	bdaddr_t random_addr;
 	u8 own_addr_type;
@@ -6310,8 +6357,16 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 	if (err)
 		return err;
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = hci_set_ext_adv_params_sync(hdev, &cp, &rp);
+	if (err)
+		return err;
+
+	hdev->adv_addr_type = own_addr_type;
+	/* Store in hdev for instance 0 */
+	hdev->adv_tx_power = rp.tx_power;
+
+	/* Update adv data as tx power is known now */
+	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
 	if (err)
 		return err;
 
-- 
2.44.1


