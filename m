Return-Path: <stable+bounces-158553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A3AAE83A2
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3651701C0
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8695261574;
	Wed, 25 Jun 2025 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="R2dG4Eom"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EBD8633A;
	Wed, 25 Jun 2025 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856748; cv=fail; b=KEWxer15wXZ2yAdsrtksBontyBvQ0srLI0KJVJSmr4bAyxDHzQtF5cv9c+RXmxK5gjSufFAl7MmPLznxhEdzk+OZjF6/bHenQkxwrWfCNiSWSWmf04FZwVxsbxxZ+AGvyWUo+Ryc32oZfgYct8KOoih5DTeZmR8hOx1YGEYkT20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856748; c=relaxed/simple;
	bh=Es9sAH/1SfsGVEZ3v8cBcyvs6u5VyVR+PDrFRybqUds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UqMi7K462hjVSMUeGJxT9tIz27IyFNNKgdM2S8l3Ob0Trk3ZCkJSuqHwwfggKaCWpS4jH0fMnJ/hRBBcyZknM3qwwAA5JYnWTI3MrgzJUGHiovy8TzfGB+Pa3X8Nfei9mgC+V5mnvx114y+gksr5+PweBWwkQfDpbwbbC/O9+u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=R2dG4Eom; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWhEAUFCcW8X67NPBYO+8Q0BgV8wIEahJHMRDY9ddNRoePCD1+Fdlu5FDIE60+lhvQjHk9OauL9hJHjJfzOJIcHWuwQ5+QamfhlciAdb8C6DQyci+BBnUyOhqsla+P8nusaWjPqCrc7oz62JlHxyHG8/zvY5vSs/lftD8hxgFR96FqahJwjilcfAWOiDnilEGjVF1wOz7k8tPz/7zaTJrK59Cfpqo4yl55h5A0Xl0tbrlJ5c3FYoeTYrV9Atd/AXKUFtSrd9WqGppZPBYv3lXCe5ONJuUnW+mzTxsgxntwxc1w7w2cpxbhDi0s7arpgjeXtbpUEQ1fRorwlH1H7WWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BovzthIyEm4Vo5ktAtauVxegkmS4zbfAJwFTUZxDacQ=;
 b=o3tZRUGomoTCYq5qea5suvRT1MxNOlGqzznq7SD81y+pugZVO6bRta4t1STfdkBAnD3RdlazH0rHss9CDpA57uEacGRNEZRsHKwJXIMQxDpzKI+dZSO4LLVWZTyWDaWZIyzs6xzJy8YwWVNzqQbZL2kFs77aubR4Nd0ZCwF7WMxRIzkZmUZCF4IGsZa8U/XQ3s1K/Qelw8ctTLpndQFcsJotAxpKVaf/iF+d4WAAclL9dX8VMoLVG554+7IL1seLk0r0RYFQLV3lk9/fCXPIE/ufrL2QCa3rsydxpr2Mh6MaKss3V7hhUBxgec4ZH9eLftE3Z99clCyVITD1bZx+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BovzthIyEm4Vo5ktAtauVxegkmS4zbfAJwFTUZxDacQ=;
 b=R2dG4EomHx4jsj5FZLiWiR4LC2YniH4VyVwQaVSak8/WM+CKUcI/+h+CiSkLgfiSh/ix8ovp9PckS3zI9tFWnQxnTKxDau2swFf6JsqpGevHG/HUnqKvsaix/J7ipafG/VUInZtg2A6ktYnr0qH6/DYlQNMHYLI7ii/UiDH6qUw=
Received: from PA7P264CA0500.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3da::17)
 by PAVPR03MB9574.eurprd03.prod.outlook.com (2603:10a6:102:301::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 13:05:31 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:102:3da:cafe::dd) by PA7P264CA0500.outlook.office365.com
 (2603:10a6:102:3da::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 13:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 13:05:30 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 25 Jun
 2025 15:05:30 +0200
From: Christian Eggers <ceggers@arri.de>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	<stable@vger.kernel.org>
Subject: [PATCH] Bluetooth: HCI: Fix HCI command order for extended advertising
Date: Wed, 25 Jun 2025 15:05:10 +0200
Message-ID: <20250625130510.18382-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|PAVPR03MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcdc2d4-f5d0-4a03-0623-08ddb3e8f679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E/nmCz17EQTid7z0wqbWL5Rey+aVBYmCmY/fPT9xUZk3mQhNuyhKfT+LVosn?=
 =?us-ascii?Q?HEnnZ0oMXfHlZeezFtHmOnue3sjr4AMM2IfeOZaorxplukrEt8NwVV/oEoKM?=
 =?us-ascii?Q?Rg8f0Hs9dgMFCgga4UCECfSTVsTT+IxqCarZFoz0kDrhppU6YY5ZSlRKb/bL?=
 =?us-ascii?Q?s71MQN6PuHBTLWAf5wl0Ij+YJJi/0+pW2964XVU9DaFT+4sTePf+q7og2RU5?=
 =?us-ascii?Q?QSD7Otq5B3p41oUmAxi1oy7D0QR8T/RkAtR6pnq3AeEf0XvnYXcBiSviZHh/?=
 =?us-ascii?Q?HGwuzaNzOcZjhSuXfvelwHOh9oEVDlBzVG62Kok0W+bxeX37iLYBa/V+cUOd?=
 =?us-ascii?Q?jU4yaKpBnC5+g1IpWQwxDDXQIAAoF+NciUAnUvktXLxtw3QM0bnD1pUqHCZo?=
 =?us-ascii?Q?l2EnA1Tr+VCrSkx8TmtwuiTLb/wgyg9E+tt9rcOKWxnKP6OuLSgarhWPWplD?=
 =?us-ascii?Q?1ka5OFUMygOVvqYVZfNHLer3VA6UpP65SH3pmsBKdt1IfGQcXpIHl5SX2u5B?=
 =?us-ascii?Q?dE7m07WjKIpwPKIo5mi1KtBqmB24OxpGrHOwLs1jYEVh9UVGlTd25wV6fhn8?=
 =?us-ascii?Q?Gaf2TGFwsMCASRuFIc15DzTqu7zsCp/U4qqEX52yXJ/ze1bH99IbzyF1D9ka?=
 =?us-ascii?Q?/dAU2Fya4oKx5NsW5MfHib62cXw2q9XpjKsB6eLM4ylxj0GLvVcV7++3Moky?=
 =?us-ascii?Q?E5aZAchBbX3KuS2fiH2Wi7ttFIaZoWEsi1+OmoXqCUg8Hve2I2Ne7xWWR3NV?=
 =?us-ascii?Q?ZO+bC/ubQIeHJwd76mNUC31/1S4teHY7K0fsILK4Zn/LCFadr5SzgpzB6ojX?=
 =?us-ascii?Q?BomNaETYoHin9vFc77VixuXg7GQHGXyjFBmDS2zWNYGEOvADstLpnjBhsSHn?=
 =?us-ascii?Q?rcq5iUOX4gVsaLMHaJqQddQI9d8Dpl1/RsuvT36GNIZZ74aESUBIjBuW8twu?=
 =?us-ascii?Q?QBpEAsNbBBMLUQokz/EMHnLoPVob/7F80C1Qoe7ukOwvyFb+wBIJT09e6EWz?=
 =?us-ascii?Q?ubPkdaApZ/S5ZjB5vdMfe7piYr5IBeWrMPxvyBYOokXZnpToRBBjjWrzaXoQ?=
 =?us-ascii?Q?535R8a+f+oMY/WAVu3KONrFExJT06VRkj0BrINFc9oz9K1u+MyLlk10DJqva?=
 =?us-ascii?Q?b4bCLsao8jj4faaSpo/qsxHU9nzpySmG7wb6GmBd0QjH9zaQd7q4O5xmMFQQ?=
 =?us-ascii?Q?OANBlyuaJbD/EyDlKH6SgV78TGRHjkWKv3Hd527C9+rFRM8KYjDoW+t8RIi2?=
 =?us-ascii?Q?EJ5LblJrz63AWFiW5eZEaIb+eiKcu9EJFVAh6/FVJnKpfX3j6sSw8WEuQqLu?=
 =?us-ascii?Q?REMTwRT2Pafc0LGDuu9RrUBD7LJJ/eTRrgZ8ha541wLBlDvM29Y55PMzVu5e?=
 =?us-ascii?Q?lCQWGdR2N+uvlog8HKJWhiJYtwNrh7xcuTwj0n8yfl5OCtHSw36751kYuPhk?=
 =?us-ascii?Q?2B0kbpYy0yGCLxuNJCbKDy96NpE9iqOKYAoMUPmX/ucjQhmrpJ4KLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 13:05:30.5014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcdc2d4-f5d0-4a03-0623-08ddb3e8f679
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9574

For extended advertising capable controllers, hci_start_ext_adv_sync()
at the moment synchronously calls SET_EXT_ADV_PARAMS [1],
SET_ADV_SET_RAND_ADDR [2], SET_EXT_SCAN_RSP_DATA [3](optional) and
SET_EXT_ADV_ENABLE [4].  After all synchronous commands are finished,
SET_EXT_ADV_DATA is called from the async response handler of
SET_EXT_ADV_PARAMS [5] (via hci_update_adv_data).

So the current implementation sets the advertising data AFTER enabling
the advertising instance.  The BT Core specification explicitly allows
for this [6]:

> If advertising is currently enabled for the specified advertising set,
> the Controller shall use the new data in subsequent extended
> advertising events for this advertising set. If an extended
> advertising event is in progress when this command is issued, the
> Controller may use the old or new data for that event.

In case of the Realtek RTL8761BU chip (almost all contemporary BT USB
dongles are built on it), updating the advertising data after enabling
the instance produces (at least one) corrupted advertising message.
Under normal conditions, a single corrupted advertising message would
probably not attract much attention, but during MESH provisioning (via
MGMT I/O / mesh_send(_sync)), up to 3 different messages (BEACON, ACK,
CAPS) are sent within a loop which causes corruption of ALL provisioning
messages.

I have no idea whether this could be fixed in the firmware of the USB
dongles (I didn't even find the chip on the Realtek homepage), but
generally I would suggest changing the order of the HCI commands as this
matches the command order for "non-extended adv capable" controllers and
simply is more natural.

This patch only considers advertising instances with handle > 0, I don't
know whether this should be extended to further cases.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/bluetooth/hci_sync.c#n1319
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/bluetooth/hci_sync.c#n1204
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/bluetooth/hci_sync.c#n1471
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/bluetooth/hci_sync.c#n1469
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/bluetooth/hci_event.c#n2180
[6] https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-60/out/en/host-controller-interface/host-controller-interface-functional-specification.html#UUID-d4f36cb5-f26c-d053-1034-e7a547ed6a13

Signed-off-by: Christian Eggers <ceggers@arri.de>
Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if controller supports")
Cc: stable@vger.kernel.org
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_event.c        | 33 +++++++++++++++++++++++++++++
 net/bluetooth/hci_sync.c         | 36 ++++++++++++++++++++++++++------
 4 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9fc8f544e20e..8d37f127ddba 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -237,6 +237,7 @@ struct oob_data {
 
 struct adv_info {
 	struct list_head list;
+	bool	enable_after_set_ext_data;
 	bool	enabled;
 	bool	pending;
 	bool	periodic;
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 5224f57f6af2..00eceffeec87 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -112,6 +112,7 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance);
 int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance);
 int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance);
+int hci_enable_ext_advertising(struct hci_dev *hdev, u8 instance);
 int hci_enable_advertising_sync(struct hci_dev *hdev);
 int hci_enable_advertising(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 66052d6aaa1d..eb018d8a3c4b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2184,6 +2184,37 @@ static u8 hci_cc_set_ext_adv_param(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static u8 hci_cc_le_set_ext_adv_data(struct hci_dev *hdev, void *data,
+				     struct sk_buff *skb)
+{
+	struct hci_cp_le_set_ext_adv_data *cp;
+	struct hci_ev_status *rp = data;
+	struct adv_info *adv_instance;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	if (rp->status)
+		return rp->status;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_DATA);
+	if (!cp)
+		return rp->status;
+
+	hci_dev_lock(hdev);
+
+	if (cp->handle) {
+		adv_instance = hci_find_adv_instance(hdev, cp->handle);
+		if (adv_instance) {
+			if (adv_instance->enable_after_set_ext_data)
+				hci_enable_ext_advertising(hdev, cp->handle);
+		}
+	}
+
+	hci_dev_unlock(hdev);
+
+	return rp->status;
+}
+
 static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
 			   struct sk_buff *skb)
 {
@@ -4166,6 +4197,8 @@ static const struct hci_cc {
 	       sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
 	HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
 	       sizeof(struct hci_rp_le_set_ext_adv_params)),
+	HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_DATA,
+		      hci_cc_le_set_ext_adv_data),
 	HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
 		      hci_cc_le_set_ext_adv_enable),
 	HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1f8806dfa556..da0e39cce721 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1262,6 +1262,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		hci_cpu_to_le24(adv->max_interval, cp.max_interval);
 		cp.tx_power = adv->tx_power;
 		cp.sid = adv->sid;
+		adv->enable_after_set_ext_data = true;
 	} else {
 		hci_cpu_to_le24(hdev->le_adv_min_interval, cp.min_interval);
 		hci_cpu_to_le24(hdev->le_adv_max_interval, cp.max_interval);
@@ -1456,6 +1457,23 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 				     data, HCI_CMD_TIMEOUT);
 }
 
+static int enable_ext_advertising_sync(struct hci_dev *hdev, void *data)
+{
+	u8 instance = PTR_UINT(data);
+
+	return hci_enable_ext_advertising_sync(hdev, instance);
+}
+
+int hci_enable_ext_advertising(struct hci_dev *hdev, u8 instance)
+{
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
+	    list_empty(&hdev->adv_instances))
+		return 0;
+
+	return hci_cmd_sync_queue(hdev, enable_ext_advertising_sync,
+				  UINT_PTR(instance), NULL);
+}
+
 int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
 {
 	int err;
@@ -1464,11 +1482,11 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
 	if (err)
 		return err;
 
-	err = hci_set_ext_scan_rsp_data_sync(hdev, instance);
-	if (err)
-		return err;
-
-	return hci_enable_ext_advertising_sync(hdev, instance);
+	/* SET_EXT_ADV_DATA and SET_EXT_ADV_ENABLE are called in the
+	 * asynchronous response chain of set_ext_adv_params in order to
+	 * set the advertising data first prior enabling it.
+	 */
+	return hci_set_ext_scan_rsp_data_sync(hdev, instance);
 }
 
 int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
@@ -1832,8 +1850,14 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 
 	if (instance) {
 		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv || !adv->adv_data_changed)
+		if (!adv)
 			return 0;
+		if (!adv->adv_data_changed) {
+			if (adv->enable_after_set_ext_data)
+				hci_enable_ext_advertising_sync(hdev,
+								adv->handle);
+			return 0;
+		}
 	}
 
 	len = eir_create_adv_data(hdev, instance, pdu->data,
-- 
2.43.0


