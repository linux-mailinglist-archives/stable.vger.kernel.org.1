Return-Path: <stable+bounces-160347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADF1AFAE5C
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 10:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F6D4A0095
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFA828B3F3;
	Mon,  7 Jul 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="UfvXjUSo"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC03597A;
	Mon,  7 Jul 2025 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876160; cv=fail; b=OQ3oQQRsU0JncdowhYFXioIhFcsOWMig5xgqnMB1uJVBgVvO0qpdH3kl7QmiaT9fGoh3EGB/Gl/Hyg5S8odvN7RiaVikJNrVtOwPAZ3kY/87PZsDIbrF1XrtjaE+OAUMDEcjE9+YGlMytcHZFXRdeOxPrB7FqeyqBm1mODQlgis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876160; c=relaxed/simple;
	bh=si9NFHkkEGtvUYWJ2rtUa1UPCB9jBM4D+x+k3w4lo+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvFPQQxboHIPdPPaZF8b0lUsEtWT5aQcEGDbsdE6t9N1UUNdPncAsvF0vsqVWbmwVU91E5Dofe8MZSufNJiPQmUuwq6h9QBxoIPPB35MRKQjWx61oCoAFf1+YXl5CnETgRp/Q3UMuoJYlj+MZUeQ1pXPRrceKQVEiCbgSElXe7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=UfvXjUSo; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izfYmIBYaOGhmuZJYvGkwfDsfid+Y3BjuKat7C8oFXmRvYawIW8b3QGgUwvPbRvY2G46Xsvfv1LGWwkX02tOmL+osRUAR/8J/c3+cYmtMnKtuX3Up48JJD9hUoP8gpoHPsNSv/6ooP0pSAtnoJF8SvcXhlLhYFbhpHChYqg489TLRpn9562axik3p4kd7JQjM0TcLeNLi3lRN9YfWgnsFtdKD2OwC0iHlHqeJ3gMBMChy37HjKkPmrIFlOQplR2erS+4599lMyFR0w/tg1aS6t4PMxBeg7SxAU3UNtwXD8243sKuzwInUD6mPMUWPkyDNLfi7+MDut9GNWUx5I2uVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGJXcTsyHdTX17PGW7syaual3cb2bZXLo3biu3y/YPY=;
 b=UmP3s8zf5E8vL735VtRKThp3339UYx5B8x9PToFECVRuMy+/2D0Fyac41JH8FVYAkAfdpge7atZqCj1z4VOjnf36JhZPFc0ZEXBlQ4/aDc6Sd6r/B0zaCbCt6tIPwQNi8g40kQXt8beuFpfa2FskgSiRf0AD9SwBtay/LnHy0U0aLe4k8zZm2N7e0Sk7XEASGpih9QQvCOOLl+VeV30Cc0vmj7+HGyRPfe7SEl7u3Eh/LgQf8Cm5h+UImb3ZYXpAOkZve7o1C3If6VgNZtHzXtM+wv6RFMy7Rz18WrLyPZsm1auvgknWTtIHAqS4XR8G+3zW6fh4q6ucAIVtoWStfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGJXcTsyHdTX17PGW7syaual3cb2bZXLo3biu3y/YPY=;
 b=UfvXjUSo19nVThSpDfuol0r3X2LqMNY1IoPBG9PbAiUtxvy5T1TwczvfQVIHWaujWVA8wjw8qNvRpdl003LSOXpIm9sm2aQtoM0ib22G34I8+CFXQIRWk2Aowgu20sHdVZ9lRr2q8g2nOlbWrzCFcPIu6+1HIvJbjzNNz2+F668=
Received: from DU2PR04CA0329.eurprd04.prod.outlook.com (2603:10a6:10:2b5::34)
 by DBBPR03MB6891.eurprd03.prod.outlook.com (2603:10a6:10:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 08:15:49 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::a1) by DU2PR04CA0329.outlook.office365.com
 (2603:10a6:10:2b5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 08:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 08:15:48 +0000
Received: from N9W6SW14.arri.de (192.168.54.53) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 7 Jul
 2025 10:15:48 +0200
From: Christian Eggers <ceggers@arri.de>
To: <stable@vger.kernel.org>
CC: <linux-bluetooth@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6.y] Bluetooth: HCI: Set extended advertising data synchronously
Date: Mon, 7 Jul 2025 10:13:07 +0200
Message-ID: <20250707081306.22624-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|DBBPR03MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d61d5f-8424-4a67-7ebc-08ddbd2e7b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Om9HmRutSCIy6yY65beXHSnwTFbBr2MemLpVEGHXva0/Ce106GfDKOsnB3VC?=
 =?us-ascii?Q?nxaC92R5eF/FOZ4F7SPofjPsxqlNB+jfTG5PHfmelrAWeKyWtjFS+pm0XpZK?=
 =?us-ascii?Q?f1C9Jkdaemrt6F/6CTwBWLPhJXrj/YukyENzztmyuD62+knfwq4dpS35G64A?=
 =?us-ascii?Q?8K/yIyDK5u9SBTfGONpMj2frdBjh3/S/ZRAkk8B4vUGxCwMhgAj4wkKBiwu2?=
 =?us-ascii?Q?XmBSBOOVMFd/4Llf3uh2cL6XSjp+nM23ki4Hsn/M9Saj7HTY74H8sores/V1?=
 =?us-ascii?Q?nYfJZX4pw9nAn/XCUEd8Xalb1aEe0RN2VIFFJGEDhfeTGRw+IhkjOli9YNU1?=
 =?us-ascii?Q?4boYruCuBhr66NULaRWPBDfVayN8Ize3eOYBgZZTOaOyUN/h8oc6lDmNJIAO?=
 =?us-ascii?Q?mTVS72x04qOMQB3zH1TgJOdai61xlq01AWq0xLuIQet/cH9ohCo9QZQaDEps?=
 =?us-ascii?Q?f8W+3hXQSa4aCFBbL0MT/ZuHyg7atAhqKntqf8LVTgEHjvWoAD6grEw7X+Sk?=
 =?us-ascii?Q?jHQAHasigPQ/B9UgSR0B8zSuH/r2PMC0/2Jmm06LdMrVZayADkqLXrei9Qbb?=
 =?us-ascii?Q?HyGpvgVonLJbx7cVDnVNNheCSj0ndrc4mBOiPLW03yfnHE/opmRkkDV4guz6?=
 =?us-ascii?Q?jlas86SODcLKEaShKLvWUnm37Pdi2yvSQ1+z3wnqaZDywI8qbsDZwu7iJ/S8?=
 =?us-ascii?Q?Zq7PyuXvOwecDhwv0dMHjXo9dCd6ts7UtAHICU7zDCgnCCaPGePmbeEKlsGm?=
 =?us-ascii?Q?/IwO3g+Ym9tuZIGfedp9yvxag67wUQg7j/XYJ/1PqWVHuCpMusHqXTXxotWO?=
 =?us-ascii?Q?TWUvssj+5crj8aqJUG1MQKscnP8IBBMXNTnk7jGyMNWM4V1sTBICmx05kIRZ?=
 =?us-ascii?Q?O1YzlvYrYkvbv7aOw43gCPjCVuOqMMWhLHtFyXQavOGjbbWqsq3rmyNiODm+?=
 =?us-ascii?Q?GMvr04k+r/19OJ6W2ZSOfespPMONvQ0fFsvizsSOqns4EfvNz6FnMEIVdDX7?=
 =?us-ascii?Q?JSM9e1M3gfnTM1B8sj2MqgCjBwc9NAzjVEWddAoRQ5VfYvv5lyo6d22oSQC7?=
 =?us-ascii?Q?Ms9+kg+alwGgqFP+leoIH9CadyyeY3NAvXqKaBYCC3z3MmourmWy/BP0EU4t?=
 =?us-ascii?Q?zkb9yiUF7npZr92aaf0miK1fP5nM6NDolWc5uGMuZ0N2JsVh1Xzuw9mBpAVA?=
 =?us-ascii?Q?B9CJVdri59dwag2fyVAjBSjXhMP2zuf5ZQ2bazL4bujj5nwuUOqZPG0SmTxQ?=
 =?us-ascii?Q?0gKmuXdMBMIoyF1c2U9f2Ai2YQNSQzyYzjNfuE2ZACMZl5XdjdhHDTSM1W6V?=
 =?us-ascii?Q?u5XE/FvXcWAoejGn6MVNjxuHfPg6wJXSslRMYNlKlOMj3KOA61zIFgHBkkJd?=
 =?us-ascii?Q?Lf9a4jATJaJIkOj65uJDr0d427ouzndb4Eb7LMSAofBM3b0mk8nBm78e9/HR?=
 =?us-ascii?Q?6nwXSB2xfy4F+55VeEzbW11AIC8R4W0tNA8l7O1h1V6iy/2YIUkMC0HZ7+Uo?=
 =?us-ascii?Q?He5smtylH6wGFRTonRJSfxcbwTRGW4msW/FK4xKVGy3qWCjOV7DmJdslxA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:15:48.8743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d61d5f-8424-4a67-7ebc-08ddbd2e7b31
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6891

Upstream commit 89fb8acc38852116d38d721ad394aad7f2871670

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
[Resend, upstream commit id was missing]

Hi Greg,

I've backported this patch for 6.6. There were some trivial merge 
conflicts due to moved coded sections.

Please try it also for older trees. If I get any FAILED notices,
I'll try to prepare patches for specific trees.

regards,
Christian

2.43.0


