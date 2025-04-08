Return-Path: <stable+bounces-131773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B9A80F20
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EC316632F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0491DF252;
	Tue,  8 Apr 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MKSeq3tp"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116CD20CCD8
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124387; cv=fail; b=uVbu5QsOhqPj7olDTTDZttkKKjYKkN8tiXogqHz/FrhmJGit0OryfDthUERWYyVCXe+S9q6D5fGp68OHZXyHlWhm7VDA8sxENKbYo526SYyh5J0DKELzMyLJovCJv+beGvhW8Ersnm7JREj8AlZ/DF/+X8SoY2bl4awM6+tIIaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124387; c=relaxed/simple;
	bh=cifblk6WZ+WzZLRQ+9jfTvYHdAifDBDb69M6ochkUQ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kq/U7AOFH6IxqvoDgfeMedetszHHrbLOkTyBBB3ISCs19LZQts62yEPpCZt+hkFZ1+t2zA5mKm0HZ78pCHB+8afSATnE7UNeKNiwkDEGkaGwYgNaAmixJ4nWYaA7cTTXfv1UEAzy/RSaKtbr1XjIti7gp/zbmuR5CpTUU88quZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MKSeq3tp; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFs6NMtzq8bQJG/HXhVgLT8sfPT9KQiaV8SuyL3PPl/8TZCoFxQccO6PMnB/k13dCWX8/Gp+4G3N6SUNU97gEITL9CUJnP+HRXB/VpTsCZNj/cIVYygq6gF9h7jI9ZOjmriwv/Jcxvn0wNcpk951LxQfyMknYFgB8bf61fDY06TywIOVOePTaAjWBLnGZkWyCdyB9IlUfaxqQXdi9KprCrGe/LsMtrb9DjPtINSc8rYvpTmgbOrrRawfYpctDBa3apwmHa1gg1pifCn0Mc+UuLnpynONpRp/0uQjn7GWwO2wWtQD0YPLL4zJ4oJokvVxG9j/zYCH6kYV3Rbi/j6vqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjFnj3Db2lDiNnfPswSaeg7Pk//4eYjdtYGaGXfWwXQ=;
 b=AZxed/mqSsJN4NJsBR8eJpixd/azkQBbZiMqkf4gb5Yj6slT9jUdyJ75hweFcpzwYLrzvybWpJ2zvUCn959DAMhdfDpqYvGMXUa5N5QHypqzJNi2i5gVPOcTxBW2FBxiIYOx+8jQ7YohR1obINce9avx/PyxJOl1OxMIpLxpcQ/qbGegmzg21Ku/0G0eKBnF5yUhpvfgND+jofPqNvtNo+xG2gD1JtijM80iwBGMVWAll0NNgjQ/Q1GebIGckq3Q1MUeJdys5jG0vb4b60SxHAX1ueITqFmNkXRz/E4oIP9XKdsiml/FVHX9ls4B7JzNCLhxRaewftJWwRdFUPDrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjFnj3Db2lDiNnfPswSaeg7Pk//4eYjdtYGaGXfWwXQ=;
 b=MKSeq3tpZuM1DNF6CvMH1VXa4cxkxTRt8Dhbwi8Sh9u2QtYHqxxl6S2uu8vSmIi/s3MuwdJLQ0hBOz3ainhO4gqv45/FWqUa0QyiC34dTkv06Rl1yxqf2Bkm6Awqqp/5rfjpvLihO3YHWTEKS6e/v4Ed3YRRL1oI5I8ip5twbrPZLgw/CGqaPC4AujbwnNF2JAHmdPVy0Q4SK1RtktcbFsGCk0mNL/QZCVhJWMRlsuPdnkRJ932PWBf36pc4zrknyH2Q+N49sgSKlcGFQuLtgnDtUWzE+JRZl8iCu38Mb3erhy6nn8w6oB6ChZY7X1zVhQn+yQmbKFX2UD0YRHdI/Q==
Received: from SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::11)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 14:59:39 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::99) by SJ0P220CA0028.outlook.office365.com
 (2603:10b6:a03:41b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Tue,
 8 Apr 2025 14:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:59:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:59:25 -0700
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 07:59:24 -0700
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtualization@lists.linux.dev>, <jasowang@redhat.com>
CC: <stefanha@redhat.com>, <pbonzini@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, Parav Pandit <parav@nvidia.com>,
	<stable@vger.kernel.org>, <lirongqing@baidu.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH] Revert "virtio_pci: Support surprise removal of virtio pci device"
Date: Tue, 8 Apr 2025 17:59:08 +0300
Message-ID: <20250408145908.51811-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6d65bf-e7da-48b5-d1f3-08dd76adfc98
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJ0054xmNEkh7yVXMdzD82+SpFu8C1HN29InW7ZEcE4T02CkZaHHeyIxF4E/?=
 =?us-ascii?Q?dsEn1w4dVbq1TSSJdsM8bynPwHoBIaAGqpCIGw19XnnaH3iWzNCQPaCA9i1g?=
 =?us-ascii?Q?Psp8gJ/uEp15UHar5VgJj8da6q/zlNeBuqvueAfOwDWaOlWtAPlg41D960ZW?=
 =?us-ascii?Q?WJ/9lDrN6fa73sKOEP0XvGntK5Ia682Hh7Eu47hw9IVAd6UaAIVlLfiSR6sF?=
 =?us-ascii?Q?2YzfnOQwedgQmQUYLiDuY3r0l8V4jkToCLMRppEbtvzsTt/p8k5xkjeM5V1Y?=
 =?us-ascii?Q?rsUYzUwv1pZKtexEe3a/Kmg+iYVMwWG0tend8PqKwf9WvmwG68r+5/YdW7nA?=
 =?us-ascii?Q?E0KKhgCTnT+0a2n3KI1Wap4lMnWUfzWBE4WEfYRdIKufumGGpdXnqKg2o1TK?=
 =?us-ascii?Q?cDgN4T3aooFp2G8ipoNSZGr4VjVBqrzVwQDMVL4cw1gbgnc8tVb6x62l4Frn?=
 =?us-ascii?Q?M3VQUe+/FPEJrxznbwH+iAjQTOazt0vEHmZztS996jT2sPJ8qgV+6NVaCjhP?=
 =?us-ascii?Q?KZew+pQKwAXEkECF2sQXV7bgRKrT7p6EKIzyY2STsTAsES6qmR7HzyJQq1+O?=
 =?us-ascii?Q?oU2x2f0pfvFHUM1WgsXWc1vpkiTDwgu7Ri7nCrVK30SSTCi0No4I2MjdqP/A?=
 =?us-ascii?Q?byzMAKk8TjuUf+86JTqYbWSrRYimFO+RdFullYE9vDohrmMoBraG9okaYtpP?=
 =?us-ascii?Q?I3BUKSeHcW1N0Gg24YRtvaG904BO0NUFUKUJcBa4ZtUfOdoajYx79rGe2e/a?=
 =?us-ascii?Q?N7GJUgMcv7V6RmRYk9N2oW0AsPTsMGnmbofhCTH1MO2kIisTxuPt7wWRrEem?=
 =?us-ascii?Q?VplpkmiwvmSr41A9oii68Ume5jfgFleEqj0vzQ+RH2okuWiXbXNwreWkPEnL?=
 =?us-ascii?Q?vek/ljMwEGWpw+uMeqPOWLaRFPJphcNutqWpA7kC/6pSOq12tXWQVpPqBVcD?=
 =?us-ascii?Q?YigmwNP5NDfGQlqBE7PBrih04CmRgaaf144OzmfhawYQVqwXgIdMTpO5jR6o?=
 =?us-ascii?Q?Hg6PO4UQz0ly5Me+dgQikxT+W8huRxmp/lXDP7RQvltsH0dHMUNqca9I3iZd?=
 =?us-ascii?Q?oOb/G4fMFIylyrG1yTL68w6KxLm0+CW6xjAYIfo5f27TlMy1KhcleWbSSIXl?=
 =?us-ascii?Q?hGgmtSgXaGs7J01Qpk/U3RGGRIcRumZ57moVpiDExc+SJfdGqTMjs63HLZ9T?=
 =?us-ascii?Q?DQBlut28B//MyG8naBYpYuNGlMqL1tFA9gFP6S1iRJNI/qZSK2cbgeEh4Hbc?=
 =?us-ascii?Q?9A28Xhr016Ay3jl2lX5IssZLHjoipk9tShKeu6mhiNQJeaFh9dr2I7I6oH3m?=
 =?us-ascii?Q?H/FdKsrvnrt/Ch3jlnuhgXtvVZu3njPJzWV4UYxxXNug1t2poX7jKEZ7eiYT?=
 =?us-ascii?Q?WNBTLr4OjM+f1b8L9qwPc0Ky4eK6ZvluuK07H1/pyQJppwvGVvVQp7IYhPgz?=
 =?us-ascii?Q?Xz1LkugqkEEhSfK7rZ6tGNmPXuP3TdndSMui/K8rDaaj+/vaGf8hUEfPS87u?=
 =?us-ascii?Q?TxI4nSVzJS6OMCU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:59:39.5615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6d65bf-e7da-48b5-d1f3-08dd76adfc98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619

This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device").

The cited commit introduced a fix that marks the device as broken
during surprise removal. However, this approach causes uncompleted
I/O requests on virtio-blk device. The presence of uncompleted I/O
requests prevents the successful removal of virtio-blk devices.

This fix allows devices that simulate a surprise removal but actually
remove gracefully to continue working as before.

For surprise removals, a better solution will be preferred in the future.

Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
Cc: stable@vger.kernel.org
Reported-by: lirongqing@baidu.com
Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
Reviewed-by: Max Gurtovoy<mgurtovoy@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d6d79af44569..dba5eb2eaff9 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -747,13 +747,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 	struct device *dev = get_device(&vp_dev->vdev.dev);
 
-	/*
-	 * Device is marked broken on surprise removal so that virtio upper
-	 * layers can abort any ongoing operation.
-	 */
-	if (!pci_device_is_present(pci_dev))
-		virtio_break_device(&vp_dev->vdev);
-
 	pci_disable_sriov(pci_dev);
 
 	unregister_virtio_device(&vp_dev->vdev);
-- 
2.26.2


