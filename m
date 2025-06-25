Return-Path: <stable+bounces-158555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE60AE83CE
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CAF166E46
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF00262FEC;
	Wed, 25 Jun 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="qFIsHZ1V"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEA2175A5;
	Wed, 25 Jun 2025 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856996; cv=fail; b=hOAdPC1CyUgLEHEu008cw2WcwSrXjcJzD/LogWYQ+mgu7y+FYbEG6KotypfzsA+58ef+Fu0Nu6mE8emVLnUlB7CHwr1vOR1CcLjoSivXdWLEQ0l81oDbx9jVny76DEUJb21AKc4HZuM6U0dCHL6kGU+i4g6a7BTWcm6Zs3c6GOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856996; c=relaxed/simple;
	bh=J7b2O/wgzOq6HCE1zEWf2dnlOj8Y/50cnPM/27f6fzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLzHpckg8y1pe3oF+0FFwbHjaQKKQMrdAUNbodPYwwDfmWBEZkEERHeCu7vbFsJ63w385U9sYIsHpiCWzTjNxKH9sKhXkPqQ4Rxfc+sIfDrFocIE13w1CcpMHD7D7bJMs2Qrw1pfXh5JwXFAwll6OV94yUyPkHvaX3FocRVPMBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=qFIsHZ1V; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Peydr02k163nf6nhKXhIZL0bLGqxMTH+8SFH2E6Xd4eA2YA4OYjttppOIyG0RjkGUGCTDj99HClLVd/NlHXwJz+p5PBhb8yDpl9WyolZIhZQ/MhOhBQYUuNsp2R+DYBYDzs5zoKIBjAnlFNNh345PQ8KvAFYEwJgCnQ+FtD9VYpZzrKaW6psPK8WdCfY3KgYvXaXnu+7j++2wEPfB/Jw/GUG5+SdcQx1mer5KCa0wptaJNs6qkHbFYGrqYSkfSqQeh/ngxiAD3KZtC6hf+Vaj7ldMCocViPfQ8bPt4MsYGto54DRLlbi6mHcxv71LGN0tNcMFSl7L18FesuR/kFCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttQh700rq5Qo8ZQFjNIFHV8HUlkpoeK1/ZVXqto8rbc=;
 b=x1jfeGD1vfqjDpJKdgpojvwQaz+CFOmE3ImyXUQhhbMFwSnjeSVq2o2jL8qDP15JkqAOcW7hHIf5miGwy/slN3JcsWWri0XE+EPKn4G4T89cny+lwVHxuJnDVtHsMXa4woPKE6cNDa/vb2heXSiHff0dBRyj+sFp23WszjyyizbkQBxkMwHO8bPux8iqpk1AYHmgSS4I3ZEVBT2BIsFn97Nw+rWJlI2QdawenGif/F6ZkEC/WZ/KOY+YtOCpuyA7JOqKi5YG97kAtQjVtNh8jS1/zxzbf0376SbZCjZ6je2/r3GHHq4yq2VHLwSEojcV4GOomq14n+1M33KzfnmdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttQh700rq5Qo8ZQFjNIFHV8HUlkpoeK1/ZVXqto8rbc=;
 b=qFIsHZ1VSZJgYZyInTAVS5d6ixqrmN8udBn1+Lf7W/ydbxvuhHmcM8dtzNUgYrkDX7oBhZ/ZxtKmRT8/4KFzXlkNKjxe82QV0vy7qWTdbV1cTdXJRrV369CL9iY8h8GLEjAYyNDTg3jssUkgTWAD9uLI1vfG8AhnvHTVINtNaX4=
Received: from AS4P191CA0037.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::16)
 by AM9PR03MB7139.eurprd03.prod.outlook.com (2603:10a6:20b:2dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 13:09:48 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::cc) by AS4P191CA0037.outlook.office365.com
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
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 13:09:48 +0000
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
Subject: [PATCH 2/3] Bluetooth: MGMT: set_mesh: update LE scan interval and window
Date: Wed, 25 Jun 2025 15:09:30 +0200
Message-ID: <20250625130931.19064-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625130931.19064-1-ceggers@arri.de>
References: <20250625130931.19064-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|AM9PR03MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 725054e5-f0f6-419f-0e77-08ddb3e99031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3iuHodbiljWGT9jVbjyL7pxnqneujJ+Sv6k/NZ5I/Udx0TmkpJDEFy2LpzbG?=
 =?us-ascii?Q?COVAT8SvViZoAVhdeHsatN918T+R7NGBmCAUM8FB4PDt8+ey7xZYlYmoYmsD?=
 =?us-ascii?Q?LLwpoxHUSmYznwRVBG+3dNjKymy4evJgW8tUeVnNgPKnUJRHZuPWWLLjPp3d?=
 =?us-ascii?Q?4iXCRJy98oflAgUMmf6HC4F9O5Ix5M0YzwT9DZ1qth/KDKTZjoGfDf8cMpjM?=
 =?us-ascii?Q?w9GCIWOys8f7T+HFLv7VliLoVazlTv52G9gVGLBxTpT8Idoynf6Al1thb6ZC?=
 =?us-ascii?Q?8JgX2HFui3e1qvptI1e+ChP7IzqO7sxwJPGDxzB7YFJM2EB7B9NOWWD2mjbY?=
 =?us-ascii?Q?RLIofLZtlIl7UprRMu5AuvnE2EkRZXLM0OPUklt/pnSVHl/j4Zq/LJPvnTNL?=
 =?us-ascii?Q?H0P6la/Hxj0kl0Qg+cWNG1Zd24IWgihyZr/E65h+TXQkfRbEbdbqBX9XNcFc?=
 =?us-ascii?Q?lTfKWNZAXIo0JlBZlBYEBUfcyT5/9ZPBjJb9+BGsX6fCsdnwEg3QkJUwPbYk?=
 =?us-ascii?Q?DQL2rYLaghPRElYXVNupzwVq93F/cPrLMjdCi38tLNlDidBBDrIP3BYA0F1a?=
 =?us-ascii?Q?u/7O4vEPpWPGY1CIPQRTB4WkLGSdMptsGMERIEU4WKxZh3HTS/LKKEgD/IL6?=
 =?us-ascii?Q?5OnnDd9zKq+SUqa+HMfZ4YetgmNXLEREwMhFL8UbliI5pNljMjhKzqZJY9kg?=
 =?us-ascii?Q?h4rRf2BM0o1KX6zz7iHkBgLcc6fVxFr86Z3krhcYo3gWaQXIG1iGRXfERi2M?=
 =?us-ascii?Q?mwfUTFAWwVw/Z6wH1V4MJIv9NqMFQVpy4jDcXORDe74b0xwpFI2JpWWZCq1P?=
 =?us-ascii?Q?OdmMHtJYSRCBmOQ/yHJnFRrlIRZFCv4sQtNpBk9efvi5KH46CqLJ1z/aKrCt?=
 =?us-ascii?Q?xUxOihD2h9eS9tV8Brlzx/5GqRI5gRmCllE6Do/pUP7DvNiYxqyXBh0DB6ih?=
 =?us-ascii?Q?b1qpZA77K7R3kafX6TjPsqUASKbrYYmBf+gpYbY2XGAb14EGjPzgaBAvbhZE?=
 =?us-ascii?Q?tsZHsEd+EKphsyB2A2OzFJmH+uIuBFcifjboAm511i+mcEd+Ss1ZzGmZIDd7?=
 =?us-ascii?Q?T0H0JNQj5se3GEJXcnmfGHj2aqd7KKbjSBm6UAX/4b2KOcteI7SnZPyRUF4b?=
 =?us-ascii?Q?PC6hsN4YBEI75keN1g2zOD4nRagDlTcy9KjfEDwoovy8j95OVLWgc0VDTfnw?=
 =?us-ascii?Q?r7SzNwu10Oxe7gNfapta6Cpdhyp7c2TY+OoGkiDW45UN56QaLNGrThI5KYxI?=
 =?us-ascii?Q?ekbhG9aIx9ARczoCvdes2en7XGLCyKbTXUlZJQswOqHh8o7lwEYXfVV07DMv?=
 =?us-ascii?Q?aa3nNDP0Zhhy99u4ADPNEz4Kqt5owaCzn/h2Zigl+LklFHTvYOammSHWwvj6?=
 =?us-ascii?Q?n5aP8enGktfWKDy4NSfSNSTlaoHcse/A6IsniAnPao22NfgCVdL/mrLk2diN?=
 =?us-ascii?Q?IDDIWeYrfv94NyVtAWLal//pAr5xdf4kNJmaRI/+KzXd1wmqZixDsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 13:09:48.3978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725054e5-f0f6-419f-0e77-08ddb3e99031
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7139

According to the message of commit b338d91703fa ("Bluetooth: Implement
support for Mesh"), MGMT_OP_SET_MESH_RECEIVER should set the passive scan
parameters.  Currently the scan interval and window parameters are
silently ignored, although user space (bluetooth-meshd) expects that
they can be used [1]

[1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/mesh/mesh-io-mgmt.c#n344
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 net/bluetooth/mgmt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d540f7b4f75f..5d0f772c7a99 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2153,6 +2153,9 @@ static int set_mesh_sync(struct hci_dev *hdev, void *data)
 	else
 		hci_dev_clear_flag(hdev, HCI_MESH);
 
+	hdev->le_scan_interval = __le16_to_cpu(cp->period);
+	hdev->le_scan_window = __le16_to_cpu(cp->window);
+
 	len -= sizeof(*cp);
 
 	/* If filters don't fit, forward all adv pkts */
@@ -2167,6 +2170,7 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_cp_set_mesh *cp = data;
 	struct mgmt_pending_cmd *cmd;
+	__u16 period, window;
 	int err = 0;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -2180,6 +2184,23 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
 				       MGMT_STATUS_INVALID_PARAMS);
 
+	/* Keep allowed ranges in sync with set_scan_params() */
+	period = __le16_to_cpu(cp->period);
+
+	if (period < 0x0004 || period > 0x4000)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	window = __le16_to_cpu(cp->window);
+
+	if (window < 0x0004 || window > 0x4000)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	if (window > period)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_MESH_RECEIVER, hdev, data, len);
@@ -6432,6 +6453,7 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
+	/* Keep allowed ranges in sync with set_mesh() */
 	interval = __le16_to_cpu(cp->interval);
 
 	if (interval < 0x0004 || interval > 0x4000)
-- 
2.43.0


