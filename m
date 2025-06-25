Return-Path: <stable+bounces-158556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97153AE83EC
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCF06A39C4
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA772641F9;
	Wed, 25 Jun 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="SqrHmMeE"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012006.outbound.protection.outlook.com [52.101.71.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A62627F9;
	Wed, 25 Jun 2025 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856998; cv=fail; b=hvfErK9cHwxJqGqJYtamTrvtYzmJkQ7gUvDSlfo15/60iNuAn7xXYkHk1p12KucIihEDT/LID1guGSp25buUFDnXCZisxLKDz15iQwT4//b5wsYL3CFh6Z36stVXZ67nBrWYihGbvwIwdH8fz02VLmDKkbLb+wuR0e/r+DKjWgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856998; c=relaxed/simple;
	bh=yJPD012M5Bp5Z+czjGXnyv9T1lLSrHhlIfP6hd4YJgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ouTrsiBRTdcLxWGxpcmXUjNFHFnkOUb/7rH9dHG1UoQ05tVbUsumDC21ziPFz1XVvweqvFizfjtB9pb6ZQhau3cCQ1VUTPSCC+DmO0X7KwbmqZ/tApgPlLLPyfC6cXW21yOX+Av5o1iv9ei2LQ+tZ8gkUaKg5DUU/1PPbDVdKYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=SqrHmMeE; arc=fail smtp.client-ip=52.101.71.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuxVqjXi4B7fgPFsYDhVr3IRIGPEDjPJMTjs8LLrFIO8YomSdj8GoeatPeIavHZwhb/31nQuDxnYdyyNI8bYUy5l9ze0DoMbQmODBVrke8LN203DoRDdl7ARQV9JGwQyp03ah88YySZMKTA6wsHA1eQ9sUhYCzO32pl4SkdSNqz7AZYdaeqA1fB0KGJGiYx28Z3bo+9CGOMu3+rOhlPHEuB0JXrVuNf7wqqngi1d6Q4a0IB/q+YNXFf9GhzTohUfC+ogT9ZH4k0lxqFbvkXAJGHg+epGxPQaLAu0V5Ytnihw6nwU0bujKpqxS9rYE8+3eaRTa+Ku5pjIotOp6TAnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEFiO+LAZROdF8129wLUjHCyu4hw2KpL5o7HrJiD1/Y=;
 b=koIKPdn3UtXqF4FdJq1TcnNIM3mB04maBnSmoPIfuBeq5pBtAW1byxTkVR1/MyJZeS9fh1leWvxbJrAVct0D3iJrh0yt8kSvXgBcAR06PWc7LygqGqqB1q0SzBnSKOU7s3uBL5VxAIHZZ2x/+7l8Dy1eSI2y23AA5fsjyFOoGHBAjr0TP91RrJvHR8sX4lf/YXX2srMte4sF84qPqdbTMg+ev31GDvkuYOQy3ZzB4NnBQJ8cgAyOteOJ917Qh/VoK4tzKQzHrXK9RkCGGM4ytRI6mM1paIhcYzWD6/ofYAaf7UCevWoUhRDePSxXKUYiPMWbk88ICUMau1Nh4l9qTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEFiO+LAZROdF8129wLUjHCyu4hw2KpL5o7HrJiD1/Y=;
 b=SqrHmMeEQIUyQnHE1pKEHe2C1BUM1i3ysDIrRZYKwO6JRuUpQuIesnpN3L/YDhCPSY5e1W0NHw81ciPBMApEU6VGRXWyWD0DaXjljqvQQ6UtxenKB6h/dKroXV+DYDvKdHARbUFzfolhyXqbY1LZ495qYgU3qTWF0Qxr6KWPboc=
Received: from AS4P191CA0037.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::16)
 by VI1PR03MB6223.eurprd03.prod.outlook.com (2603:10a6:800:132::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 13:09:48 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::2a) by AS4P191CA0037.outlook.office365.com
 (2603:10a6:20b:657::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 13:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 13:09:47 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 25 Jun
 2025 15:09:47 +0200
From: Christian Eggers <ceggers@arri.de>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>, Inga Stotland <inga.stotland@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Christian Eggers <ceggers@arri.de>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] Bluetooth: hci_sync: revert some mesh modifications
Date: Wed, 25 Jun 2025 15:09:29 +0200
Message-ID: <20250625130931.19064-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|VI1PR03MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: faf5921f-5e19-46ed-d4a4-08ddb3e98fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CZK3fKV4IRweUxGakdM0dpFYysFk5jvql2GOV75MPBoeRMInPi4ezAwtRmw8?=
 =?us-ascii?Q?kehUSp0LmCL4KpZVoiU4fkb1gM1jxEUmGoQXJ1PFImHfJEoGqho/mm3Pxah/?=
 =?us-ascii?Q?WeEnDabEwy5ZItx1g71BOOX6fI9S+D6kkoKGzWWwTYaER6l34aDVATRA3UH9?=
 =?us-ascii?Q?Y36UU4y9q+2sTqtv1WUWtX6oPtiwhHSMAGwqMMo+ATpm9CtTyOh2kT7nb0j3?=
 =?us-ascii?Q?bUMBnHDI+TNbj3y4BuMX0xwXAFliUZHel5w/yemXgNH1NR7lQrZtup1+TszR?=
 =?us-ascii?Q?lf0v3U3b3Sv8R7nnUbZc+OuHy1+pKw8hbsnFdE1TnL+YBtM8jd4urX6P6PPy?=
 =?us-ascii?Q?/cdiJY7Ol1hgxFrkk9mJl5cck2aVrTeeNzJn8hIsQDwbuovIOdpkn4hJxkaC?=
 =?us-ascii?Q?deVFZxcMhlCRMIy3jneO5atKw0REhXVyFLmjX8/LNjfaIgb8Fpv+oHxk4tJ4?=
 =?us-ascii?Q?ii7JVmo/QVCjDLNInJP2Va6pvBhXy0bkWJ+CWnqxVD0xN41HMwGXAPUOAFxl?=
 =?us-ascii?Q?6wAHxj5p6YgAp+0TgMXct/tAFMAvfuFs5fiMtCHty9i/jRI/idYCPYeIDUUh?=
 =?us-ascii?Q?sCQ8AWeJt5tYSUtHa3E1GpXB7KaRP7DCRrdiJ/r+/LpZd0G+Qzh1Sq2QTKWw?=
 =?us-ascii?Q?hodfog78AfjbbLeINdF5edgbLs4lzNk1io3u87Q2iSzu1mcyPOjKvbPFFJ/D?=
 =?us-ascii?Q?dm1fcp/RACcHi4aSe+8RzlJOXcvyma7RZivSC/JSfHpFVMBYUt/MbPz3j35D?=
 =?us-ascii?Q?yS7ueseHd/h1NMbCtd5y6EMoRuDWnL4eEK+Vp/qSHUL1V4sJzoog/hvv6BQO?=
 =?us-ascii?Q?qOjb0mzSth4Escd9BUAkbj90hRJPMrZozeAQspbGP0naevFRq32FP7ro6RC+?=
 =?us-ascii?Q?hkXl16Bp7h4K8xryxGWNL2zz/xwJwVeALUD45tQMyj+VmFFIxOkqx8ZMNL5O?=
 =?us-ascii?Q?glk0XtX0GWyalX1zNMLdVbGqq9+DUoQZntyO2Jvj8eIdfdn0juglF6wEGRmw?=
 =?us-ascii?Q?P3RUnuZVTOB5wlh6lyMXdYB4nBq8h4hyVoan/RN0JCtLSBOt16eRSLiwMkrx?=
 =?us-ascii?Q?9LXMXIrHG2Hke2BIzFW39gwOXDhF96HqIyXd+7M2AP+5h/X+Rjh0+nvb68iv?=
 =?us-ascii?Q?V6yul2VycEqag4rqa2/dVJvlELjul+hmsOAv5Wdz+9B3PwSzAdC8s0uXxJMY?=
 =?us-ascii?Q?6kcql8qfqCQlWnhiGTkJs0yy/Cz+2+F08niHUunWeJ1dB6JJUnsVSyS+UNKv?=
 =?us-ascii?Q?l6jSbZXZsySalNnW+AaEwv2ErKB4krz475MqTZEUFPGLjXvwsdegevLFWM6e?=
 =?us-ascii?Q?SrYozHPFHDxA9pSQ63rMFiRFVA+VmceabvdWa6zPJl5BO1l4Bp7+s69akisx?=
 =?us-ascii?Q?2s18V5vzKpAAKgcP4Mte55U4UYe9ip2Z4z9snAq+Ff8pb4Tyw/FtS4J5C09V?=
 =?us-ascii?Q?tTWtXnb/CLPmTrcu6DT6d1prj8DVFCrlR1toWWt4uiWp8Wzp+DWqhYMRVlW1?=
 =?us-ascii?Q?VpT9dv8udpCwQH40E3ApHncWtlN73/77IJ8z?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 13:09:47.7026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf5921f-5e19-46ed-d4a4-08ddb3e98fc6
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6223

This reverts minor parts of the changes made in commit b338d91703fa
("Bluetooth: Implement support for Mesh"). It looks like these changes
were only made for development purposes but shouldn't have been part of
the commit.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 net/bluetooth/hci_sync.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6687f2a4d1eb..1f8806dfa556 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1970,13 +1970,10 @@ static int hci_clear_adv_sets_sync(struct hci_dev *hdev, struct sock *sk)
 static int hci_clear_adv_sync(struct hci_dev *hdev, struct sock *sk, bool force)
 {
 	struct adv_info *adv, *n;
-	int err = 0;
 
 	if (ext_adv_capable(hdev))
 		/* Remove all existing sets */
-		err = hci_clear_adv_sets_sync(hdev, sk);
-	if (ext_adv_capable(hdev))
-		return err;
+		return hci_clear_adv_sets_sync(hdev, sk);
 
 	/* This is safe as long as there is no command send while the lock is
 	 * held.
@@ -2004,13 +2001,11 @@ static int hci_clear_adv_sync(struct hci_dev *hdev, struct sock *sk, bool force)
 static int hci_remove_adv_sync(struct hci_dev *hdev, u8 instance,
 			       struct sock *sk)
 {
-	int err = 0;
+	int err;
 
 	/* If we use extended advertising, instance has to be removed first. */
 	if (ext_adv_capable(hdev))
-		err = hci_remove_ext_adv_instance_sync(hdev, instance, sk);
-	if (ext_adv_capable(hdev))
-		return err;
+		return hci_remove_ext_adv_instance_sync(hdev, instance, sk);
 
 	/* This is safe as long as there is no command send while the lock is
 	 * held.
@@ -2109,16 +2104,13 @@ int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type)
 int hci_disable_advertising_sync(struct hci_dev *hdev)
 {
 	u8 enable = 0x00;
-	int err = 0;
 
 	/* If controller is not advertising we are done. */
 	if (!hci_dev_test_flag(hdev, HCI_LE_ADV))
 		return 0;
 
 	if (ext_adv_capable(hdev))
-		err = hci_disable_ext_adv_instance_sync(hdev, 0x00);
-	if (ext_adv_capable(hdev))
-		return err;
+		return hci_disable_ext_adv_instance_sync(hdev, 0x00);
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
 				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
-- 
2.43.0


