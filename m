Return-Path: <stable+bounces-161403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B85AFE38A
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A43B169631
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1D0283686;
	Wed,  9 Jul 2025 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="ASy6l183"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC9235072;
	Wed,  9 Jul 2025 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051990; cv=fail; b=WseB5hf5c7rvmugwU7/LBEsJrb9GsnuwOlRJB6cmSRk35vVRcRoqZP6IdaknKIHpZqwr2CbqI97jC73kD6eTczy+a3VRZgyz2YL3PMGzp8JruzG8BzuOEsnNu+TJ/GmQhQOZqwPJX+xR+ec5EFsIfL7aS1KTps3mO3Bq9ylWqUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051990; c=relaxed/simple;
	bh=+rTVssBGG+tEYCNNP6i5KAMsfXa6BqpXFYGOKJ4TtVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqYs8TV3g/ivelNBg/BrxQY+Kw6bb1bZGIr9lA3p4+twO39blsoykrNXsupN8Fv1tyXl9d8EgUlkWSe+2eg2qUvQD6qe1Cr6PA/nud+6PtvL6akgc9GeSQ5BePUTkMpBbxeZ/ZdKZUO1jRm6xQMto4azmcBQucgo1x7iPpJhe2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=ASy6l183; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sESd9X58Y+eeOn07i1t+n2oxSd1+aZ4fVLPX8c9oPacMo3DlOa0axNxdOAU5ApOXuCZpcsfZ1LI+LFzC1J3ZbRQNuA/RGKXU6gF7iXXZETbRsjGzGUuQ8Gn7QVC7oA2T/4fHtm1fWOxJzAF3oNWmwfHHyUvc+Qtz8FVJLrFmqmaCFVc68xScg1IebuhrIV+36db5PVpcY146y4jecqJgeDhEdBcsvH2E7RMp0n7aiJA8Se2gLbh2ICWDjVNt3LsjWbXOiRQq9+4uEkJNI6RCz5PJS/RPygG00lDyGXG6TxLJR67s/U2RWuCrtWR37OqRwuu+KPeZ6VS/Ck8pERNKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayD7aKWOTH57U/nQ0uzMmeWag7/GE6s08+Nn7ND/mf8=;
 b=oFyXAPtuHl+UqcMJc69RAx5kd7y5vSB2J1Giz4GwMi+GW3c/Mxc/IzE7O35qsHlUvXn0enZ5rm0bNNtQdyZWA1vB+VR7wUyyPxjLG2Mcj4YIO2g4wsqg+Fav/gGTVPVNAGIUdwgHsIbDbhE3fzEnRYo4CVrGSCGtywHgAXwBNfxgiaTG9cvDsK1EqvTnkcEIAOHO9D1YwRqnTrgbhT1CVvNfPCCnouDDX+8iSDMXzKipYqFYvfAnWsloimaNiCA4/fmJqR7W6RsxH8HQWJ+dTKLdBb4WQ/7WhCLgt2yS571RwZsJAcO7d/FHJoBIaeiruw1YMq3LIuMwN4Suv0JJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayD7aKWOTH57U/nQ0uzMmeWag7/GE6s08+Nn7ND/mf8=;
 b=ASy6l183xDc6gvoerEe9vbzdYLf+JGn4IAZ+TGfnPJhQ65zTnp/RWIsa4wYpxinjVJW2YMJkfFv7TAiMHlCC9yHAEVnVpm3u0LrMCPUTBMb10ZssiWUdy4jQKxEAO3mPBO8ZYdsGhqY+lY6EwS5RckXkBo2BbZcEipQMBTRLy6g=
Received: from DU7P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::30)
 by DU0PR03MB8219.eurprd03.prod.outlook.com (2603:10a6:10:314::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 09:06:21 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::14) by DU7P190CA0002.outlook.office365.com
 (2603:10a6:10:550::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 09:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Wed, 9 Jul 2025 09:06:20 +0000
Received: from N9W6SW14.arri.de (192.168.54.89) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 9 Jul
 2025 11:06:20 +0200
From: Christian Eggers <ceggers@arri.de>
To: <stable@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	<linux-bluetooth@vger.kernel.org>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH 6.6.y v2] Bluetooth: HCI: Set extended advertising data synchronously
Date: Wed, 9 Jul 2025 11:05:52 +0200
Message-ID: <20250709090551.9089-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025070625-wafer-speed-20c1@gregkh>
References: <2025070625-wafer-speed-20c1@gregkh>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E5:EE_|DU0PR03MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 79001de8-6f47-4e9e-fb8e-08ddbec7df35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xda3cN6Hk1Xr4FqEmHQ9QXP6WwUXhwsRbZ/FVe4pD/l1ym682cqs9kbaQSIz?=
 =?us-ascii?Q?qprqLbc4lVaZ3vcz0fjAb67+MN0f94I7fdGU/EVA1Byj2Ru95WBZGKL6R2/Y?=
 =?us-ascii?Q?8NZfS8Mhld4DTe0H4KMhhtYH7aQfCdSCDd6wJ/Mssygc/8iBxkhsQ/rbnEUj?=
 =?us-ascii?Q?lteOvqa9kj9/9QnTxLsGf9PORilHKzQoUSfKxYJWxJU0eftDNZhhy9ke6l/N?=
 =?us-ascii?Q?6fxAIJgi3IrqUSsyuxSih6gbwDKt9NaxLmOLha5oTkhlDMlgbwTNqK7UZSNu?=
 =?us-ascii?Q?6oONvrW8KCfBWKF4IA3Cc6buOLygxbd5OnNzCTPW0fYxj5dvtAWPSjUEPwVi?=
 =?us-ascii?Q?brIkHRE1FKjct2McUw5MFOrZumG+SLrkDelelbWhRwKmbU8cK8zJRN6dM5gV?=
 =?us-ascii?Q?lQZweVMfnAVoVYO69Zu5Y53EMv4MZLxT/exUNGxq60D940PKMMcOjw0aDREU?=
 =?us-ascii?Q?0N4/HxajoSUrR1r1mh+PCsjjBt31+YrztJh+oDAupMb+kIDmKChGGq3Yz64x?=
 =?us-ascii?Q?OJG6KnbpAPKEZdvBzD3AHRYrUAwYF8n8XTrBs/pB2rHYCJpaw0UxbCjJvQph?=
 =?us-ascii?Q?6oJpMs34b4ILNqR/hx+31ASLKb/15nzB/Fg9+SXIyPSZztwELnWD1tjLDgQV?=
 =?us-ascii?Q?uljrEMq0DV+krVAELBQB0of917sGJ0M9TXJhXZvbQdUz7CYdYBomBL9GGpk0?=
 =?us-ascii?Q?BH/EJS6ODK2n38ZyRPh+yGOXucXZKhg9Ex6EAjKMidbI3/hSgIwB+hify+Vz?=
 =?us-ascii?Q?HoCL50wtoywhPOPSn1V10Vu65wK9qZKnfnGCLb07SWYDj+MruOG2VXLqDLrs?=
 =?us-ascii?Q?i/jrhbGSZ0+KuyGqUraIc+Dh1fFNgk64tMwgLBvwcqt3X7MncaFh6LQz3iqe?=
 =?us-ascii?Q?9OCo1Dz+lHX//JqX/mVZNRYbhxqhtaDpAdvEOSx2wNk70A7KaFggGaOmD747?=
 =?us-ascii?Q?B4JwonGeFt2C9+ANCfKGai1yR71yKAcbgLLTNCEpJL6uAhG4AftRl+QSN2m0?=
 =?us-ascii?Q?jtXZa74KwiGn+eqMVon/YMMN6jWQ/++71VfCsJV1+X+jjGOvA6zZmIsYPazw?=
 =?us-ascii?Q?46pAegL/ilWwqER0ryi4RQNn+OJOet0HsBSWtGLP/VD/9IpqqxJ4/OQxyrd2?=
 =?us-ascii?Q?pTAkBDdmR+dZQCoBCXhwjkhNFM6hRQJlHtxcVfuo86bCDO45sQPaJ8YteOVG?=
 =?us-ascii?Q?1QcM5xoBlUhLTifBC9UVFOhOHCs9NrNGt85vQsaVtMTSxp3Mxfo+y18mDGoA?=
 =?us-ascii?Q?JqvcmB7XfNzFN6q9hniJT0Vp0kUXVUBwhWLd48tItIQ3PUZxc/O6woDE6w2P?=
 =?us-ascii?Q?QX56rWUABJ/zghB9z0VRcN9jfueefG/LUmp5iuVBDbxMy8VEDCq11vKffPkI?=
 =?us-ascii?Q?K3xqL0voet8JfEEXXgkB52k7rCl51cWktozvsDMHfKYn/2PNT10ZRsnnn2Kn?=
 =?us-ascii?Q?W3yd05oSMYOk4/5M1wPMsHjYLHiRyAJppR7dhUvemSnckYFWBDhW7qwZKnlV?=
 =?us-ascii?Q?UL1OSOnBAYRjCSw5eK9V/aqNQlzoIqhsxwuMux9hghE+/cjLuao917tUqw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 09:06:20.8383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79001de8-6f47-4e9e-fb8e-08ddbec7df35
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8219

commit 89fb8acc38852116d38d721ad394aad7f2871670 upstream.

[This patch deviates from the upstream version because 3 functions in
hci_sync.c (hci_set_ext_adv_data_sync, hci_set_adv_data_sync and
hci_update_adv_data_sync) had to be moved up within the file. The
content of these functions differs between 6.6 and newer kernels.]

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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2:
- Document deviations from the mainline version of the patch in the 
  patch description

 net/bluetooth/hci_event.c |  36 -------
 net/bluetooth/hci_sync.c  | 213 ++++++++++++++++++++++++--------------
 2 files changed, 133 insertions(+), 116 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 008d14b3d8b8..147766458a6c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2139,40 +2139,6 @@ static u8 hci_cc_set_adv_param(struct hci_dev *hdev, void *data,
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
@@ -4153,8 +4119,6 @@ static const struct hci_cc {
 	HCI_CC(HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
 	       hci_cc_le_read_num_adv_sets,
 	       sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
-	HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
-	       sizeof(struct hci_rp_le_set_ext_adv_params)),
 	HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
 		      hci_cc_le_set_ext_adv_enable),
 	HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e92bc4ceb5ad..7b6c8f53e334 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1224,9 +1224,129 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
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
+		bt_dev_err(hdev, "Invalid response length for 0x%4.4x: %u",
+			   HCI_OP_LE_SET_EXT_ADV_PARAMS, skb->len);
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
+	struct {
+		struct hci_cp_le_set_ext_adv_data cp;
+		u8 data[HCI_MAX_EXT_AD_LENGTH];
+	} pdu;
+	u8 len;
+	struct adv_info *adv = NULL;
+	int err;
+
+	memset(&pdu, 0, sizeof(pdu));
+
+	if (instance) {
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv || !adv->adv_data_changed)
+			return 0;
+	}
+
+	len = eir_create_adv_data(hdev, instance, pdu.data);
+
+	pdu.cp.length = len;
+	pdu.cp.handle = instance;
+	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
+				    sizeof(pdu.cp) + len, &pdu.cp,
+				    HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	/* Update data if the command succeed */
+	if (adv) {
+		adv->adv_data_changed = false;
+	} else {
+		memcpy(hdev->adv_data, pdu.data, len);
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
+	len = eir_create_adv_data(hdev, instance, cp.data);
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
@@ -1333,8 +1453,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
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
 
@@ -1859,82 +1983,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
-{
-	struct {
-		struct hci_cp_le_set_ext_adv_data cp;
-		u8 data[HCI_MAX_EXT_AD_LENGTH];
-	} pdu;
-	u8 len;
-	struct adv_info *adv = NULL;
-	int err;
-
-	memset(&pdu, 0, sizeof(pdu));
-
-	if (instance) {
-		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv || !adv->adv_data_changed)
-			return 0;
-	}
-
-	len = eir_create_adv_data(hdev, instance, pdu.data);
-
-	pdu.cp.length = len;
-	pdu.cp.handle = instance;
-	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
-
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
-				    sizeof(pdu.cp) + len, &pdu.cp,
-				    HCI_CMD_TIMEOUT);
-	if (err)
-		return err;
-
-	/* Update data if the command succeed */
-	if (adv) {
-		adv->adv_data_changed = false;
-	} else {
-		memcpy(hdev->adv_data, pdu.data, len);
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
-	len = eir_create_adv_data(hdev, instance, cp.data);
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
@@ -6257,6 +6305,7 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 						struct hci_conn *conn)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
+	struct hci_rp_le_set_ext_adv_params rp;
 	int err;
 	bdaddr_t random_addr;
 	u8 own_addr_type;
@@ -6298,8 +6347,12 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
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
2.43.0


