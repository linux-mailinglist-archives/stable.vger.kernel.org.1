Return-Path: <stable+bounces-200429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BFCCAE9DB
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 02:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACD02300D574
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6352737F9;
	Tue,  9 Dec 2025 01:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fUxHlavF"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3F58F4A
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765243579; cv=fail; b=VYrwaRLwgKA1oudcXpro3yaPY2JcjTtjzED7k1QZebHzfIQOcX99fjeQuCYoom4IS9FdFe9ywhM3pzKKeyAGwHuOwKcknmZz7BG7Ou8Hlyn7vwzwj6W233m8MKobqU7jME/eDg+4NyJ5/k34EuOSDy3N6nRwgzaDGjPkEnKRFGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765243579; c=relaxed/simple;
	bh=R7lnzuxXclr8ACgg1cHuhkrdnzAkY9Gh8Z3y05lZII8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDc3jjPIO6wUMS/UBXehpHPJoXZhH1JB3iEZjBT5iSC3kJYiDfcGNDZ3f0jLaPA7VWPOVZfQn3s72l/dKyVxjLLmu5kMIj/VESYSm0BiSRS5atxINUYHNBuPRAAAy+sARiDnRFMMYZ8xuf/GotnicTaevpkN4brz5aEvuyznDSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fUxHlavF; arc=fail smtp.client-ip=52.101.52.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXV044cCX2T1YyuTXvzl4hp3R42OD6VZWXkoIbOi5L44p9p9MgRjtnt0P30S5DYMBdNKcaTKARW8NL0OzlnTZIZqIJLKqCR7irHBcYPQAw0LjMbppPJDqMJZlL+ob8hwILcxm75m5ouKXciEdSaDlhQPUgCusRDF0X1jPfiDCjV7OCb/HnhEHtdjUMOlFVMrNZcuT+c0+SMv5djT8T3eF/O3fcMfosFIPQLeIhoauiAIzqYjDDpJJSnrUAIpYiD8K5Ue2g/AElPlUvlb7tJ92DZNBJmzjT0cmRa2BztoN7xQiJ2nNbGoi/F98a1vyZSpEE6QXVt539dY58q2cV5lDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTbDQSD+oJAMfZH9pU98vXy85TLt5hpT4pq9ZRu3whM=;
 b=nhQwAlBMwaYAbBwvYfniCnhq0FgpAF98A0ZCrYe8zTsVz2yiT25WDkC7r45jAd1OwUA7Lo2fJUOzPRRBOe9EcrTA0wxB6o0SziQhonuZyLSab92AnNZpNfsJYX5PkffyzVh7ENC0eIC65zsaN4qShWFZhH4jN44pIT9BYLC62BV+uK+cEog9nzIpIXiGY2WfvXoYN3Zhi6IvK9X6U9ybHzN8eDH2CGsTm2Ve7aBuHx4p/Mh4hkfgsiU8rKN4hZVcgeBCisLYPYWntK2iB5iZWtaoMI6dNXMWe9PDliYrR9TnnwZ23YCFxlwKOwhYNCRcienANSf2ls7BR9PErJy5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTbDQSD+oJAMfZH9pU98vXy85TLt5hpT4pq9ZRu3whM=;
 b=fUxHlavFrXOk33/FA3oE1KJ1qoS4KNSIfrB3DpWuXl1PLgnEL3wcyv0Ak2tnBuO+z8TjClexwW7S/vQddXCMaXVWz1DAQACzQkyQDs9gCtaRA1gW/ZRvGUzCYsJRCEA1R2vW/0051YfYdKBjIQLX0teuAPUpGdfIbqfsXOdl0xI=
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 01:26:10 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::62) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 01:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 01:26:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 19:26:05 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
	<david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>, Philip Yang
	<Philip.Yang@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v4 1/6] drm/amdgpu: Fix gfx9 update PTE mtype flag
Date: Mon, 8 Dec 2025 20:25:32 -0500
Message-ID: <20251209012538.3882774-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209012538.3882774-1-Philip.Yang@amd.com>
References: <20251209012538.3882774-1-Philip.Yang@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdae886-07b4-4af6-b040-08de36c1ef4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQelX41z7VUmvzSIGIX07AN3TG3P6vEYcmpYgPqL7OiX+sKhPijPHh7Iavgx?=
 =?us-ascii?Q?+Rm9tBlHY3X9njZGm5q83p7geKboOw4M4MztwXal2NPLUv3hNjTgB8W5LeVb?=
 =?us-ascii?Q?jpEg43zxsIMnr2/3LhyBxPo1lnt+zs2+5U+n5N++5PA25M4wi05jp+Vrpuw/?=
 =?us-ascii?Q?geg+HXcYnKgiCQWejqSphd4IxJw/xG51aybjiHVN1g0PgRcGLKWmnVtPqjsr?=
 =?us-ascii?Q?cYn0qLu5lJ213Q5iu3jSwA7ietiBUuCzghrnwzLSewnhFthV0yjKv5PdlMmE?=
 =?us-ascii?Q?/NMKK3lmQ8icJYzHxb+WdrkzY8Ne0hAtlIWwsUeLXZAZ+fHP/XdD5jYIiG3I?=
 =?us-ascii?Q?pnFTaQWE0ntSIFg1q9ZK2kOhzVAnO3yYi6PfI4Yo8+vkwHPgTJgiSz/yPeOx?=
 =?us-ascii?Q?wjtuPx5XU6uBz+iFVBXpac6kaiPzYqPb2DWe903guzbB0K4bL0nDPtR9N1PP?=
 =?us-ascii?Q?Rvi/QJY7pnkbErWfh3QqHT2z2jl7Cbmd0OoK3YjjifV/smPFVvhEz75dPOyA?=
 =?us-ascii?Q?H4mtGsU2jc69LLXX6Bv1cUfH3WztMvORJe2i/l9zu7O0jLR070ZsFCKjRITi?=
 =?us-ascii?Q?cOx/nzjgnJllpkBJbyZgB5DR0wAKH8674KOBaVvEbvRL9BtLT7M9askh7B3U?=
 =?us-ascii?Q?zhBzlYvOYqPZl2VymvybwbGSfbyIW02q++W1NPIdYBhZHlFeRZrnJql2Llqm?=
 =?us-ascii?Q?BkkuEMEKZA0Rog3yCFD9Db/Tn39YTvdfA+pbZkDd6eIaMXW8gX9bsKPEph8A?=
 =?us-ascii?Q?WpeNn1eegByK8QWYvTgCc5pvplIsyWOnSKeZBpYNFYZknHkATYjvq+6qC6ZD?=
 =?us-ascii?Q?Xz0ukSykc9WMZYvnpoAh7rb7704zg4CaqgZHvOCedWTdvPiMoU7ik9gSNpnl?=
 =?us-ascii?Q?4hCcchavY6l3a8f9Ntr5CLVknMbICb1L/pXsGG2rxRe3rWsdL22PrIDFasGr?=
 =?us-ascii?Q?lCF+f0oEFFQ359F/vBvBksoB3Q8rNPURO5oXmmzQDFOcY/BZa8CuMeT7bSNX?=
 =?us-ascii?Q?2bU7vGdWuNdYB3IHLJ3vKbibNSIOUGxqL88CnQuxSmSf5CYlQreluo8JjJDY?=
 =?us-ascii?Q?1LDjVhYbclOW6HKEeROTKkBUGveXw9xuLhF1AieL5zGEBiizLpgYEP1ImPyS?=
 =?us-ascii?Q?hA7hlqB06W16Raxh3cXVU45uYtC0kAyQPXqvIn8CxtQutLhr01F9BF1IUzjh?=
 =?us-ascii?Q?Ub4zPzEyoJ+GBSmoHXbhoV50TNCxS4SJWGoffs3dcnLzfmsrfdXZluqoceR2?=
 =?us-ascii?Q?TKtbcaWRIeAZI5UUzwvRbJauyoZ9G2fQFARLFleAtG/47cMWQ8czwojCvwyp?=
 =?us-ascii?Q?B2taQhTGMCrQ2lW8iv53oO97JAC7JPaQ3cNDHfaFjvN/O6pTF0sjYNZgqYJs?=
 =?us-ascii?Q?/5Wf6yDTWEgBS2Dk5k+t8mDHgYiOMXCswDltvNnkW19IZx7c1UsdyR2x/lUA?=
 =?us-ascii?Q?HMCKYwbWkXI/vH2GJBiehX5grgeWb0ZI7TAIjpJ9pR+klSmsjqC7Med/18Wg?=
 =?us-ascii?Q?bWqYjNUiTP5ZhEm+3ec1i+LdktmUfd3DUK9H2eEVTfcDEkP9i1gLMLjU48Hr?=
 =?us-ascii?Q?rnVL2LnK+kdCe8LXxHo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:26:10.4016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdae886-07b4-4af6-b040-08de36c1ef4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330

With this bug MTYPE_UC 0x3 can not be updated to MTYPE_RW 0x1.

CC stables.

cc: stable@vger.kernel.org
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 97a04e3171f2..205c34eb8d11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1204,16 +1204,16 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_NC);
 		break;
 	case AMDGPU_VM_MTYPE_WC:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
 		break;
 	case AMDGPU_VM_MTYPE_RW:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
 		break;
 	case AMDGPU_VM_MTYPE_CC:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
 		break;
 	case AMDGPU_VM_MTYPE_UC:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
 		break;
 	}
 
-- 
2.50.1


