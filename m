Return-Path: <stable+bounces-158554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA03AE83D8
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5386A064D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F09262D14;
	Wed, 25 Jun 2025 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="hh7lmUZs"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5AB25FA0F;
	Wed, 25 Jun 2025 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856995; cv=fail; b=lkRdRnQxX3L7xs3Et7p0N9UukQGVg5CkEIZej69AQkyfdMC0wKfThLsQy+AtBpSs0m6KsKdINFbBl1llu8MKsR6NYtC6oy5fUsO7hq/P9ckpiVvtX+jxuhKZm4qReUG697ZlvbBVcsV11uuAQ1bX/QqvnqxsBLWZ6JIC0PUIIA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856995; c=relaxed/simple;
	bh=GvJjCoRgL/IIGtlwaivv5sRPrNkDAzalF1HSQjykCu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlWlsJTCimW4go4dZ+6SniXMAnKd/TfuU/35zWxIZwFD8ZROp4daGZQ5Jl0gfKycau20PVDXzgju94qO3MGHFbxgT1bpce4wuegxdgUeu+e+pGhcSUKHpG417tjocURiP9i0syzMla1wARGCULC4o+U3sjWgDZpGhguuqw8A26U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=hh7lmUZs; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc7MdtI0IjO95HG4CiVGswUqLFYq0DCx/YzR5xJtqztae+9TAJvsWWZT5DiryeDLRru6ggipGJw+IPXjQAYbilMgBKAfewOVZWPoWJaswc/s4g8AVMWV2j3z5GcXPm2mqcCdXWR2tGKv+6JamwOExSsmLtG5JGNWtrPLjq0Rsdt1lEmYtpzNfDVtFrvl5fj9EQBDCCbT1eGtlYwCuuWuCycHZhr/BH//CJV1+rojaImQiB4yCElkBbn7G8Mp4sXzVpDheGvJin0+dFywMCXwOpJnrQpD/iSLKi/5j+jRg/D6F67Psl21iED2vJSbj74mZ7wQoRidf/26q/k8fiD/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot2X4WX/ED6XWvisnxAHdwvs9Mak7Az4G/XpkFwKzl8=;
 b=AL/FKWJubbpKnSDMNYzSaatgNWqczJfybWZHt5BP9A2R9q8Xffe+nbLhz5ZfGjApyn6rA5s4kb8ON7KcOVuWVt7SB5wGtvE+VpSOG1ODsXS6Wwfjig4/1TZVlWozsIFg3GXoSTdFt3ii2pvHBidKEWbC7QyqbFVLYjMQ11R4Y/slnzuckz3OjvZP/yuLyRyPOISaW+/07G96xcaKpez6HerRJdy1LA6fxv6lY4nN2CigwM9/WI6pdqNlDEkyOwIjHoi+SeFONygn983ihfyqqZU1e3g0YAMDlyvYWdVynkHQOW9Y3BOkNUXJWbJAvdrROoKwOMWT6FKslNOCN8Gwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot2X4WX/ED6XWvisnxAHdwvs9Mak7Az4G/XpkFwKzl8=;
 b=hh7lmUZsJnobQWQglVAqmvKdK7O4TcpxTaIkWlKiaL+eFnciro1aeQ+tsG4IPmablDRF6BzwliWTUT+oubq1G2IqCHIfbmE1w5O60+H+85vHvb1EbSLaFJEkQxi+gmfXmx+sfcxJQ3kmumQQSZ+zB15JKP4Mg4OWX/F1airQc9k=
Received: from AS4P191CA0039.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::24)
 by AS8PR03MB6725.eurprd03.prod.outlook.com (2603:10a6:20b:295::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 13:09:48 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::37) by AS4P191CA0039.outlook.office365.com
 (2603:10a6:20b:657::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Wed,
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
Subject: [PATCH 3/3] Bluetooth: MGMT: mesh_send: check instances prior disabling advertising
Date: Wed, 25 Jun 2025 15:09:31 +0200
Message-ID: <20250625130931.19064-3-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|AS8PR03MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bd4dcb-06fc-4117-6b55-08ddb3e99046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f9aQ9BTwTyP/ZNj+mPx49PE57nyqbpCOC+yn6oTBtPue8vFg/qJX5Abtl6Mg?=
 =?us-ascii?Q?bmIbbUfC8khfmXH39aVMJsBZQr7cLHthRX87Sb/LGvSPNj0V7zB2vyh5Fl1D?=
 =?us-ascii?Q?n6PVfh6pzBpmoV5vplkPvLjRf1xr//OHPqdXOZT/Hai4qQercbE+bL4Mry1h?=
 =?us-ascii?Q?FJKPyOMnvx1N9ZmNFiK91VJhEXFlaAwzhsr6mxy1OUMP0IJBZVMNp/+7n3Ew?=
 =?us-ascii?Q?Yl6GjlO7XISMmr+7Fev9R//UWmwRJNx9O9vG57H+uOf7btuoumAM/M9CKUJI?=
 =?us-ascii?Q?sh9qgEJ2BSktAMJUdhnbvn/WcKvqKCeG5ituHnwoCMJtOMO9Rlcg6eTb9yGm?=
 =?us-ascii?Q?2rnnumHaPl9E6kvTbM7dIzW/gxPNmN+Zq/UJ9Mo3HsS3Kb3eW6bzC+IadG5l?=
 =?us-ascii?Q?eAoG+58yCKrV2AhlH+ZsxVuj592JCi9wqJPgbqbd+C00D8Bnv/WgowIzx2sV?=
 =?us-ascii?Q?XUajI1+N4thlTXxF36uvoklWLcrEZh/xQWueR9wGW9PtzeHctlnzv1A7Vm9G?=
 =?us-ascii?Q?6lr9h23b7nhg9gpQ+q5XKWABGA5UPZz77QD8p6Ya/ZvrlsBuESo0naCHRgdN?=
 =?us-ascii?Q?L4k9HjBJNUZpRP6MIFniKSM9CggPTOgnEMsQq/fbefgadkr+bKU/KVc8ozMs?=
 =?us-ascii?Q?kW6f7rPgSSkoQGdTEDbHoGZ+2UjN+9DfCc7v79BHta38fNKzh9OCPG7FqeYC?=
 =?us-ascii?Q?gy6uPhS1tZsZE4sNQn+jK6SLB1etppN7yN5NNRnLTzdqg5opJp6SDhWvdu7N?=
 =?us-ascii?Q?Gm3oTGWPpsMp03TRX9iXE0nZ4zNZ2hdN72oydi7JeMMRnPZOgYfp8ha9GJPj?=
 =?us-ascii?Q?Zwew7qUTrd1XM7Rz9ohy3b6nBartlbFe5lDsK4ydi9+RBIddxNzFYEcUw2pO?=
 =?us-ascii?Q?uAKAgx2pLl0755liprDosZ7R+6TqG9lph0386bAYWtULEub0zKPF+KoYr+dy?=
 =?us-ascii?Q?4YuOkAAPwoK0hPI/I85mKZGRQdji1o2vSicNpwe+Wwd2z094mWdwsfxDQ0ci?=
 =?us-ascii?Q?v90YVCJR0XEC2Yrn/Um4FvU+pV96kSE0OJX0cWL/jDMDzH392vYSLmLzVeHQ?=
 =?us-ascii?Q?9hsMyIVM7XIw3Gbzj+Ahr54MlabuDeExFWCBmRiC/hJk/rAyMpDO5ZN4Fbm9?=
 =?us-ascii?Q?gxt3EmrbqtkZmPZuzFL26OKFxpYP38HTUUyP+5g/r1VtpyfLXVzKFyNf3dYi?=
 =?us-ascii?Q?MGU5W9w/2NpgGZjXVxXeBruSs9yUxvciSpUt7IVbn9J0XxYkUv5uJG14V1Bw?=
 =?us-ascii?Q?mwgHuXvDxClGnL5TnYaYmud2aeZ6ER7hZ2Aa/322wKVUtF7NKqz09LhFlATw?=
 =?us-ascii?Q?Z7V6TGPRMb6esCFZmv5VWI3NvEoceXqkMbmYPnGfgB7raedO/NOg78w6CI5o?=
 =?us-ascii?Q?oeyYhIznCy8MEWMy3XacoyL9ZYt6K02guG2w/daidBiWBCY7PUtRBkheO7WO?=
 =?us-ascii?Q?0Lf/df3MhHajIkPrm//z+iELdBEtTGTYW4y+GCQx05vG53qyO1E3iqT67Sfn?=
 =?us-ascii?Q?cWkBfoWONGpoJkyfsGKMYuIYFnsGtAuJaEaW?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 13:09:48.5382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bd4dcb-06fc-4117-6b55-08ddb3e99046
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6725

The unconditional call of hci_disable_advertising_sync() in
mesh_send_done_sync() also disables other LE advertisings (non mesh
related).

I am not sure whether this call is required at all, but checking the
adv_instances list (like done at other places) seems to solve the
problem.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5d0f772c7a99..1485b455ade4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1080,7 +1080,8 @@ static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_mesh_tx *mesh_tx;
 
 	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
-	hci_disable_advertising_sync(hdev);
+	if (list_empty(&hdev->adv_instances))
+		hci_disable_advertising_sync(hdev);
 	mesh_tx = mgmt_mesh_next(hdev, NULL);
 
 	if (mesh_tx)
-- 
2.43.0


