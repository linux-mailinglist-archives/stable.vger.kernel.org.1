Return-Path: <stable+bounces-160345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7429AFAE3F
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 10:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C17189A36A
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EDA28D8C9;
	Mon,  7 Jul 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="W+mTYz6o"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C218028A70D;
	Mon,  7 Jul 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875553; cv=fail; b=dqMNcyrnPUFLYdKzhEmz8LH8VjF2kekuymfmM8rNB8itKRntzl2vHF1L/9SFkDxukV5+0KPQA/AdolpoIZkJz1EyifbN5LmwYg5Q/+/WKI+q160JPvleXcbddpiARb25nTwfzFh4/u5k2HdBixvrpwKCuEyDByJN8ZpLWlqsyOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875553; c=relaxed/simple;
	bh=Ex0v96PRagy6WvuBqnRQ42O7fOV7dX29gWUxhgA2Bag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Su4aD6uoAVfJEAvsFh9ruz25nQeA96/Ml6ZreduZI96O/c/GXRP3pXx+DZghGZdDgUiW9weU1XCfbPPf9bzgmmTQiBHbXl2pKO+J+ksBpl+u/k9Of1zFnLekOFSe03yJ1RPLyK++XwDYclGWI3YO9dbgqjsK7aKFifLlHO3ffkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=W+mTYz6o; arc=fail smtp.client-ip=40.107.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJIS4mUcciPSvt/9jIGqW0DFDA+f5hc09porQa4Xa0k6rBIo87MiJEGQlcLCRXL+Z5vBy+99MmcsZ9bqePtF/DxMCxbsUqqepC6HoobiN06k9PmSARRTseLVvUFKOnEfI+hufS4d8Bbq00UrzmxlEZur2bkWh7Xl6jcS/aoupv85JkQoyiPPUhNpZ71EUlxKveJOLg2Dev5s5Xv7ynUQfv/RDzn0DIL51LEYbyWAgBUHA5M+xOvPAEbyGAWQWnckXbaD63ceExfOD/6PGHd2pIkjFwqNiB09GG15QgZZsqyUsqx3QhGnNvWkguKiSyiWXLCglXyMY4w+IWg8buBMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69rvLjV/w8YqrlhYYKIux3NlvHxrZhkdJUH2W37EoRo=;
 b=kKgBP3lbvTJGBLGlIciDuJ7zoEMFFbpTwKAwrlaAfocaP7ZRzn+kvEas6PQLqQ1zdmlg3ku1NtU9TXZt1o+xlUPNsaS84uoD/d+6XRhAm1Jp5oIKvVccx6u7TQMBTHC3rO9PzI6AjIX2nSAxP750dOYfIBPel4W7h82mWXHYpQTiArKgCrhw1CB9Q4fer1OuF3i8Dd0da7QQ76PN7vmNZqQtPTjhYPJbuKD7+EHpK3ifqhABdo4foswNS/XnT5hqt3A9j3jO1zIVvNsqmDmgjDv7jcB7gQgCeGxvhPK3IPWxEZ9YeFqCS7pZprz9iuRxucSHp1pzPv9kJHwYEChlVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69rvLjV/w8YqrlhYYKIux3NlvHxrZhkdJUH2W37EoRo=;
 b=W+mTYz6oESkcp1tRoyXa/xL2E62Yf36+GMhm2Zrjm+sjO6NUnC+CVyY4PqzVjj2DV7Fhy1Q6kS4R+SbjSjyyq1bXKdDK8Mc8whU0XAY4EtPaeal1kfcZEjSt6ArmDun2grXj7yAPag9IgXWQV6SvoTR053Dpc4I/6p0iUdMTMz8=
Received: from DUZPR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::16) by PAWPR03MB8939.eurprd03.prod.outlook.com
 (2603:10a6:102:333::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 08:05:36 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::d2) by DUZPR01CA0009.outlook.office365.com
 (2603:10a6:10:3c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 08:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Mon, 7 Jul 2025 08:05:35 +0000
Received: from N9W6SW14.arri.de (192.168.54.53) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 7 Jul
 2025 10:05:34 +0200
From: Christian Eggers <ceggers@arri.de>
To: <stable@vger.kernel.org>
CC: <linux-bluetooth@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6.y] Bluetooth: HCI: Set extended advertising data synchronously
Date: Mon, 7 Jul 2025 10:02:05 +0200
Message-ID: <20250707080204.21335-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|PAWPR03MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aeba120-764e-4d66-122b-08ddbd2d0d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t8PaMxnBaeN8HwUBY9SSx32QQuR3Eyh21rYsmUUU/K3ue3kbM4LZa2Nz0tAD?=
 =?us-ascii?Q?t9q21VVK9xO2aP6oJgIx3C4Q8oYiYb3ojVkjM1Qe9pydDT1gCjFQPqAJ2shr?=
 =?us-ascii?Q?nUyEc+xuzHCqnaqLyA01wUBc03Qp+BJqV6YOgIraxE+f3U6wqQ1Vug23NYN1?=
 =?us-ascii?Q?xEdSri54wcdS0jWdEqIeCZ8FXS1C54qyfVS4tkH0jqiicS0SAOy+AjJe9lBm?=
 =?us-ascii?Q?TV53IuJQR3MXQaMmqgl29749FXqwAoFpxRvReghAgebYN9wJLRnrbLfYy4H2?=
 =?us-ascii?Q?oQAHBglrv6EaRgw2DKRi8rJUMQpyDPpbQyFDVqeSX4NMvErOCKXjQK8J6auF?=
 =?us-ascii?Q?sfCxrTv+uVa0C2VwCUyNUSt27hh2OVmQ5KmvoygEXbCiQ3P82kOGSIsD0RJn?=
 =?us-ascii?Q?3Sbd/seMLwC8xpxiycrwksqLDLekNITo58mbiO8WcfLb10OacbtZ3wuaC1BY?=
 =?us-ascii?Q?OtWeKDVj/vHKvurVtcQK/hjadhhv++6fzqgvSv3ji5V73IjFZgnY+L21V4Wm?=
 =?us-ascii?Q?luAaFAjjsnrzVnWjCrmKmWSSMqLlsCRQJYIscSRdCIMbjBUZvpB6Sc7kutW1?=
 =?us-ascii?Q?TMjfPN7y1P3QqBZytPFltgNaehBocsQw+FN3qJYABp4FOtlEK0/1N5WBvG4b?=
 =?us-ascii?Q?RG3PPxvekeJqm9WNn/hAHA1iRNaSIm1AQdx73w5acwgb8ShQ7r2xl0SBMLzS?=
 =?us-ascii?Q?MrPSTzl7tZ1dq+kKlli7WK5tKujIg92DdPgxaauhGUaeH/+7ixrcTdrXCLCi?=
 =?us-ascii?Q?nMp4d68eByTn8ixKZ209gUo+nJFlVo1DwmGVIxYYq0om6pdP0f7ybUvm1QS6?=
 =?us-ascii?Q?PSOl7hclXmY7zdb6DKC9QiIUsI3+CdmgnhkQrkw2h/WyszOmfyxflHlkCXZq?=
 =?us-ascii?Q?e6CyockAM93vrJVjx/IUv/4jlLyJQqQRLjx8L5swA1zE8qSfCAW32in+Hv+7?=
 =?us-ascii?Q?WI9lYqK/3hIcdGu5jOf32JsAUKfMmbkeBIb8dDZtgSbHQOOzikJH1U9u4ZsX?=
 =?us-ascii?Q?mLC+/HqEfkyzG+eFSgoioNFAeN2BuSC2eAI+Ss+X0XgdbKM5G1VhDbXWL4Ma?=
 =?us-ascii?Q?6w+x5Y4TVsla2QC/4+EkHj9HJgPjVRGsapevq8x5KnD1O+s5uf3aiNIlqPDU?=
 =?us-ascii?Q?yAVJebiMksIg63eNpZL8Muqc8C0aDY6kqHM3ZqSs3aLkzPcupQ+qAIL2Gn+1?=
 =?us-ascii?Q?E2hl1tDMtDF9Ix/v471tcoccIshM7nRbhOMG6SnVccRP55pFqIL4RW7WjNpD?=
 =?us-ascii?Q?42cnE5vwePhu9KIdwdajFmSqrjTMyGJ10b056UajaaRgBpl5ZcJnHptIDKS2?=
 =?us-ascii?Q?DdN27Yih448YTBs1TugUcjjjnPsyHa6Set5GRqeTP4Qy5v8HM41XUg81hEu4?=
 =?us-ascii?Q?9Lb4Y7k5rdqxIdUfcy1z9J9HITYTdt1lFCG3omgSQlvv20OW0EaHHr6itzPm?=
 =?us-ascii?Q?Seshl5bvuI4nd+GHxX5D0vZ7eLBm0Cw0+9d8Jo/fclBxYiaAfw4ZhI4lg5hi?=
 =?us-ascii?Q?xtXDQm8GfZIuHBV6ScKKs/B4h3OZhWzGbY1XxaRtzF/ASZ7yktAUuminkg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:05:35.1335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeba120-764e-4d66-122b-08ddbd2d0d62
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB8939

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
Hi Greg,

I've backported this patch for 6.6. There were some trivial merge
conflicts due to moved coded sections.

Please try it also for older trees. If I get any FAILED notices,
I'll try to prepare patches for specific trees.

regards,
Christian

2.43.0


