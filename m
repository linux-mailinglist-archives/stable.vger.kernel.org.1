Return-Path: <stable+bounces-118274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC58A3BFE7
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A7A1799F0
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFD41E102A;
	Wed, 19 Feb 2025 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LgNgoW2p"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F01E25EF
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971582; cv=fail; b=Eg0QTvs5nABG3VirnJ7Zspk121e8TjGmuM6c4givHecKragvYu4VfvHY6h+GaQyhDhrzGUVjLMjZmKzuyt0LcY/+DLzMCq/HDDyqLpoc5g0/pA690Wr4yYetFlBRrmAFGMAZZS+gx1xQLNOncsnnfWDSkFyzagaja30mLH4i+50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971582; c=relaxed/simple;
	bh=oqy4B+uoERQhZ7uHTDM+6mkWN98mQnLjb6SiqWSghaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMAWIWUkD9rsB2dqthU0LdM7tE7/U67Jr7QejHtuPKZo114On/lMWRryvKl6v9H6eKnGgRP6qSgNOjxtfa7CWHxxSYK5ZRMhCvX/3XPiqJwsTh90yu6jl3ID8woHJV+zxGx78ngvHDoeCIbsJGCfJ5a+k/5e8j7zZTHmwMRGqPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LgNgoW2p; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZxeCJKu7wbFIpU/zh0+44taBSuIGg509GgKLJDqJU4jHkVsnOVXd9KItPIzA7qUjaeS4Z3A20dDirFAt5/Uhowm3mK+ieDaEEsx+mcTqd/PHwlVWnj/XVwSNmKyn0JRdmY6m3VnYvxttYAHSqXok7IFC5HY4WmgX2RQHaL35hKGd098T7mhqWfG4ZO9YfTTwnD8MD2C0/3MDO3V4Ctv8iiv2phTyajbRGVG30EVaz/aGQjEABGxaAtCQHeq272/HWbeJcgGdbU2q3yz38hoKcMMC4WkjDbqZwtbgjcj+GMNNhE1FLNcBaY8T1Pgoqk3kCbKNju0f5Pa3cMP7vakqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7sDCuIsRfD00FW7Hr8pofNDClNvHfi0OGTe6GQjtzM=;
 b=c6Jg5u7S+9R4uuNgv4S1ABavQ+VIc0meOmaeqAdt+M+2E3J+IvEueaelKTzcXnyhxJNn68Ugdg+T/PvVHmAx9ljfMQy2dB0SwozLhJG4hkCJuFi0gOWrtJv+ri10peqy6Sr+0knX+dwNjNdtMOYEd7kwM4CT2xrzsobeOAhFem2nRGlXlQhfe986w9UX4bwR6Gkc5HujKIbe1DFcNCCr+p8svMee4fe7sOBlzB4/524qe820e8JDLKhPQPueA7h42T9TlsAWaoCy7DHckUo4LVBhkfkK8HOv5InZCuni4GMxwE8v11kObgwQXZGg/ubUjMbWx4ZmmJ/orLWIzjug0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7sDCuIsRfD00FW7Hr8pofNDClNvHfi0OGTe6GQjtzM=;
 b=LgNgoW2pIBm+zMc85SDYSENzvN/yOhLNblzExbNzITILxXnwzMWjyO5Jmi/gO+Acuno+/bGzlxSJZzfXQBmRIh7b6hgpbCnL1JGzglcnMCR0aGxfUMZeUyrTs4YmXXBWa+pa45HBuOvLuTKBCM/h4uSSPnqGtBppxRC0hmG9Guc=
Received: from BY3PR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:39b::34)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Wed, 19 Feb
 2025 13:26:17 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::22) by BY3PR05CA0059.outlook.office365.com
 (2603:10b6:a03:39b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.12 via Frontend Transport; Wed,
 19 Feb 2025 13:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 13:26:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 07:26:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: bump version for RV/PCO compute fix
Date: Wed, 19 Feb 2025 08:25:59 -0500
Message-ID: <20250219132559.3940753-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219132559.3940753-1-alexander.deucher@amd.com>
References: <20250219132559.3940753-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 6304aa81-1e00-43ec-935f-08dd50e8fdd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3H9haIlRt5vhfFHxSvoqViKlERrxPN6uh9qzVVbHOdXd731JUXJ4fBCWC6cT?=
 =?us-ascii?Q?c931qH2XoNQ8YiUR0bIyNLwDGb21xbLHnP9SVOkWtG3Kx8eyh6YWTbNvDpLo?=
 =?us-ascii?Q?DyB9yU4yOr47DjVd7HNBBf3P2nyZhYhn5vo69LSx1BfGbWmml3Cb/usAL+j1?=
 =?us-ascii?Q?6MIdadNi15XDTtF0+ykAlRJIuGkg9P8mXds5E/7bQbBl3BWDMnzTT+IshvfX?=
 =?us-ascii?Q?cCaKlpB76a/bpa60+MwjdPogNpgq4quietl/jIiAZckD5POZaKGTBQJjbU9C?=
 =?us-ascii?Q?6CyQpevaz9h7cQ35x/aMpCEHcqioCzN5ilWmc8tUMbFwWIZJ59d4H4KKX4xm?=
 =?us-ascii?Q?1uPk9LoA3GsHrYATS0raPWIbCOUjea7M+r+PQH5sty2Z13+TcBSopLhGg17T?=
 =?us-ascii?Q?9pbA7WlUM9bcF+xXmUE0f8vlJl1jghXTNr2o95WS5u12wdsiQjZf+n/cS0/Z?=
 =?us-ascii?Q?bTIsBBWDzEEyauNZqU/rVfZkksiTGljf+Cvu6eHfqxcWzrwPLUrw8l14pj/4?=
 =?us-ascii?Q?l3q0o5+qx2zyoXPjYS/duEuz/z9PhTuYbeHpvhUOChnMyzeFUy/PDepvsXwK?=
 =?us-ascii?Q?1Cro4UGnqgVqcz9yT9AhdR/OYrAQNxFXrRjZ4S0rSpemRZNivwFmMmzyOX98?=
 =?us-ascii?Q?0oQqrjfNcAWez+tCKW9xNtAJMaTqlKxrfHJMRHOg4A8I27Qu/T2u117nUbCV?=
 =?us-ascii?Q?P4vBtnZht1b2ARNomIQnpfmZ4pewXOgeJOtvtilg9oBEJSdr8K3HR8sdOmUQ?=
 =?us-ascii?Q?2cS8VDt42g8U/L87ualc0ye5BYzdzOh4FyKpsXTFH+DERkowCAxK3XBODIr6?=
 =?us-ascii?Q?7kyFk3RzFNuYwvsQ2ig9W2OLZZ4PzOEN8ZgM0+InlHRgIhUvW0O1sU9a9Ydp?=
 =?us-ascii?Q?w7QpcX17i7qGS9z6wbuEmThzREq9TflFTymZvcnWSIBdsmdCpHJhnppFmjhC?=
 =?us-ascii?Q?SMsvssXQEvOONaXmKe9VQJ8WJosHXUyZT1Uz1yrTdv9VRZl3w978gaUSb+sn?=
 =?us-ascii?Q?OPPkb0/K2UgHpqJa2V70B9C4lPbY03dhpwNra7N187farbBNSEZV5p2Tw82H?=
 =?us-ascii?Q?1CBnPiuYiAB1u5rxxcprCQ2RKER7rz2JoydjjkurK4Okrgo7tXYqejCF2D6M?=
 =?us-ascii?Q?ibXT0fdqq2BF7lJApWGi8WPr3Y4NXmCF4gVMQ1r8673FZTObuFWQGjPKwGSd?=
 =?us-ascii?Q?qRYtCynwbsuQ2C/LQyE+h1Xd0O8yianNxo5YPADoFRhDqXOd+aEg8LSN9dah?=
 =?us-ascii?Q?zzG76WiDTtaUOplKxhBlwJK26NbkOqKODAGDFyHJ2JffKTy/BEHclgMWE1ge?=
 =?us-ascii?Q?Mg4IDmMGYO3sMAeRTobzVjvI0xQOMeyaH71psAPToWcytbOrtzdaNYc4AwKJ?=
 =?us-ascii?Q?fOxoEUxzaXgBQPNQmmgPFU2zEa/9OOvcNoU8XPbiZ6zg0f4sIcgsfvYDPcPA?=
 =?us-ascii?Q?lQcgp6ArUeycf6kTVb6DDpPNtfMTNhAWuZI/pW3MITNY2dNrvDoeidIvqlAN?=
 =?us-ascii?Q?RZgh0jl1ZIOAIgw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:26:17.6445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6304aa81-1e00-43ec-935f-08dd50e8fdd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686

Bump the driver version for RV/PCO compute stability fix
so mesa can use this check to enable compute queues on
RV/PCO.

This depends on
commit b35eb9128ebe ("drm/amdgpu/gfx9: manually control gfxoff for CS on RV")
which requires a manual backport to 6.13 and older kernels due to
a function signature change.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.12.x
(cherry picked from commit 55ed2b1b50d029dd7e49a35f6628ca64db6d75d8)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e63efe5c5b75..91a874bb0e24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -120,9 +120,10 @@
  * - 3.58.0 - Add GFX12 DCC support
  * - 3.59.0 - Cleared VRAM
  * - 3.60.0 - Add AMDGPU_TILING_GFX12_DCC_WRITE_COMPRESS_DISABLE (Vulkan requirement)
+ * - 3.61.0 - Contains fix for RV/PCO compute queues
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	60
+#define KMS_DRIVER_MINOR	61
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.48.1


