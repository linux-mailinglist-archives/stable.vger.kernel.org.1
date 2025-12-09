Return-Path: <stable+bounces-200496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93584CB16FD
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 00:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C0FB30142EA
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 23:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DAC2FBE0D;
	Tue,  9 Dec 2025 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h5YsSbC8"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1A79DA
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765323851; cv=fail; b=ZEmFZl/YEuzUsoFK90AaChTxySnbFwsLOw9b/fUbBlIjUCATJ0nC+J/M2KXyaDQETWf2w1xg8vUFQIbJ299xYWHmo8/HEbW8oXQdIaOjqIYARcGRWHkltd6QOAoojpAwsEkOb0mkJutTpsv1ZhWeGSdWihc0pfFd4MyX6Z2ae/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765323851; c=relaxed/simple;
	bh=SNMd1YDLR+qrJy3m8sBo5pt3QARXJvEl38CEAUBxdn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wuot9HU6fzIKR6UbMpsJM0SwjqB9dATkbLB/MAiCxrHHocVPpUuRB9+iuIoqbOtMRMyj6fJ781FqumLTBFu019pO2aX2+DQoc4gWRjIMFTqBsyuA+Bz6syY8/IqWEXtb87gxljzYvF69IqyW515nIjqxl4q6AAlANq8iaH2r7Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h5YsSbC8; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b67Ovg0qmze7RyXvat4C5heA6tQg7KCp+n7ArDNDcjsbVzOTOkCxHRFYBJBP+OIaJBh3UUH9BFU2lX6FhXYtE6LbFWy7JCp28UgUADZOVopvQlmh4Yvfb/uKZotW6M9rQVbswVXMH11YWCtBtEcwDUtUC3YAeKyHbvmL+T4/ckuCrKGDT84gdUJuZUVPJGKeyvEGfHeBJmhd6tq7BROsRPAJS8n48utN3xQgqAr2XaEKsdW6iqz1XbtG6c3Z9wdrVxBjRmHHG811Q3kpaS9MiFM5l8QcbZsd8/J+RJv1TVweVq9rwWjCAWxKGwNsKrxGflqScUaQ4vsarpdWerltPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERlVZ/lIsVQVciRw+l/sOfgT94UYxNgUDKxWCwTkcro=;
 b=htg70sgVQkTwsRcuG8NZtpo3K+jddmjeO99MGgKI4oLJ31GaLEhx/fYedW/f3/exdfX+XjlIIM0jXvS6YZKdUIil7OvZSlho5bpKpjld3tJIyOMncsLzOxAYHH/JemSWLb0W+qA54WluAkKxq1LW5EcizXc73IAL7Ee7CbJQKT/aWwK5WnXrhFjtBD1CMUh7c88vxtdEWMo370z/1Hk4/ZedpwZSePS6yeV4N0wMOdTUQ9hRc9sQAVY1uWEEfCYYJ8SGVDYDaYdLqifxYATEa8lUcukDkS/2w4I/ftxcdhzcNbNCgQxY+EYGjZ/y1R+/woJz5Hqi1FFfn+4heF3vBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERlVZ/lIsVQVciRw+l/sOfgT94UYxNgUDKxWCwTkcro=;
 b=h5YsSbC8rhX5REjQ02p8RZBWV5G8oaMDO1EzMVEaz/9BqUEkYh7Jo9GwuEVQogV4ILd0i/LrX2BYW7rRI1b6k+Y9Bz+zyya7UzMuOz/yqfyYupQe7WNflZCfmbuQxYgJ7Hk2FpZHryQLvJy0GWVD2B6zvZkyu2HmVBfLLjDxNrA=
Received: from DS7PR03CA0204.namprd03.prod.outlook.com (2603:10b6:5:3b6::29)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 23:44:03 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::7b) by DS7PR03CA0204.outlook.office365.com
 (2603:10b6:5:3b6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 23:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 23:44:03 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 17:44:02 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
	<david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
	<kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v5 1/6] drm/amdgpu: Fix gfx9 update PTE mtype flag
Date: Tue, 9 Dec 2025 18:43:23 -0500
Message-ID: <20251209234328.625670-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209234328.625670-1-Philip.Yang@amd.com>
References: <20251209234328.625670-1-Philip.Yang@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4708a2-95ce-4c51-f1de-08de377cd5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVkySmFaUW1McU9JUlhCMUVjK0xjbUZxeHJZQk5saU9laWM3MEtCVGZQcDNQ?=
 =?utf-8?B?ZER5T0RKVGZ1eDdNMTBGL3ZIdW5WK1BVSzh3akFlS3VrWWVPNjdOMEZXYXVw?=
 =?utf-8?B?M0ozTmhyWEhtajJ5TTVteERSOXI5YnlOVkpIZVQ2aEVqQlA2dzZqSHNLZ0U3?=
 =?utf-8?B?anVFemNwdVlLMVdqNWI3Q3UyNGJsVi80MmN4TTA4VzdlNTgyYjZhWTFHSzlC?=
 =?utf-8?B?YjFYalA5bi9vWmZJaHhPV2JPeitIcjIxNjMzK2JvajFHMnJSVnhYNVZvNHNQ?=
 =?utf-8?B?azZXYkNhVVVkZnZ5WU5EWWRETEpjT0prUEp2RS9QU1ppVmdtSkVXcUVmNHJj?=
 =?utf-8?B?SkZEZVVHK1ZUajVIUzh1OGtCbFZRRVJ0MjUrOHBTSUlXdnJvL2NYYXdwb0Vx?=
 =?utf-8?B?NnRZeS9QRmovVzdSY1MvUEpoUDZBWGJLdUZjYjA3Lys4Wmo4bENkU2ZFT3dM?=
 =?utf-8?B?QUxBeGIyQkFPUkh5V2U2ZjZObyt5MnREdmU1aDR6Q0VubFNDVW9XU0paZ2pM?=
 =?utf-8?B?UnVycy9TTVlBQjBoV3lvb1BxQXB0ZHdqeXgvdXU3OC9PZzhsdGpoOWo4WHND?=
 =?utf-8?B?MWtnTDFXNVBBa2VlTUtKUXVWcWtIclJLMlgwaGFTQUxkdVcrQU5sN29WdHhq?=
 =?utf-8?B?c3IzYjdKVkVzY09LejF1YXZiN1ZDNSttbkk0K1dHR2RacWpEdkswVnZ0bU41?=
 =?utf-8?B?UGlqaFlNV3pNRXhnVkMwVmNyMjI5MU93TmJ0Q2FidzRhZjhNb1JGUmFkVUNs?=
 =?utf-8?B?WmxrRy96T2ZTWUVRc3JtVGpZN214U2loS09GVENrbzRXTXBkZ0VIRmNCNitl?=
 =?utf-8?B?bkYwR1dFQW0yYzJFRnA2OUVzNVR3UFpNMXVOQ0g1SVRWbndDTlhrc2pYa1FE?=
 =?utf-8?B?Nk9PVjZiTEVmRW81b1lFYUtyTEsrVWQ4dTFjMXY4UldpbFA2Nk5MRzNvbW50?=
 =?utf-8?B?RmFGUlFYSStKWjg2d3JQczVjL0VCb2FFN1FlYy85d1ViZk4yY2lGSU9IVnRl?=
 =?utf-8?B?ZWIwRVRqL3lTVHkzRHR1cVEzMjhiUEFNNGx2SGJneXZTSW14b01aQVBpWVV6?=
 =?utf-8?B?VjRjbklMM0pVVkRjaERvOWVLL29TSzdmRVVVZHZWU1p0amV5dFE5SThiUU11?=
 =?utf-8?B?T3BNb1QxZjlDMnY1SzF1cXE1Q1ZWT3VFZmVwczFnZ3VxVHVKMk9IRmMyR29h?=
 =?utf-8?B?UDJ3WVdQY21RbElMYUZTK3QrMFBPRWJpRHczbDZIQlo5SjRXN0g4VU9sb3I4?=
 =?utf-8?B?bkJKOWVCamdURm9GczdMZm5wd2h4M2JGNlNSakJVQSsweGJlbVdWaG92TGlX?=
 =?utf-8?B?MnZxZ0I4d0pYTDNLd0pTL2x3eUhnemYvMkJZWkN3RnVGNlF6eFZFd0hqeDEy?=
 =?utf-8?B?dTFQZVplelVJbDg1bDMvbFVSTjhlckZENUxEOEYxTHJxN0NCMHNZK2lBaHdG?=
 =?utf-8?B?dVYxWmQwdWtlWkV0UlNTU3VYMXJ2dnA2VXpxRDdqSzAyTGNPeFJja090Ym9G?=
 =?utf-8?B?Y1pHdHFzTVc3ZnhZNVI1RFFNTTRpcG9HYmN6cE1yRGVxWXZEdWJtMFY5Z05Y?=
 =?utf-8?B?cVJHOVZSRlBOSUVQdHI4R21iREwxZkJuS0czUTk5czc2N3ZHY1dDM0Znc2pt?=
 =?utf-8?B?RWVhcW1rYTNJcUExZTdXTUlTT3o5SUN3M0ZZQVpTUExCLzJ4ZlZkZHZlKzdW?=
 =?utf-8?B?YmxzTDR1dmV5My9veE8waXlPclhpWjc2SFo1TkZjMWpybXZudzhOUytaSDU2?=
 =?utf-8?B?SnZ4MkN3U2FIeHh2ZjVXQ1NSU2hTTk9rS0FrVGR6MHQ4OHd4USs1T1dOVkk4?=
 =?utf-8?B?WXA3MXZmcmlidHIzZ09ObDJaZFFQZ3ZWeFBKWGhYVXdwcGloclZpU3VEL3U0?=
 =?utf-8?B?b3BRTXV0cS9nL1Z6QTdzdERQdU5lZWErMkovcmdaMnlkUEVMbFE5UGtNQTJL?=
 =?utf-8?B?MUZFQ3Q5NzlMU1hiRCtZQnVZeFNsdkdtVjBmR3F0eEhCZXhqSkpQem92UEhK?=
 =?utf-8?B?Y3Q2cGlMWVNMdElaWWdaY1VCNkRyNG9pbmRrNmdtVGJSRFlBa2pzSC9pc00r?=
 =?utf-8?B?dkNMSVN2b0lSajJVRnJxWko4cjVSVUUrS240RmVPM1c4aFpab1R3SnQ3QmtE?=
 =?utf-8?Q?DihA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 23:44:03.4168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4708a2-95ce-4c51-f1de-08de377cd5be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470

Fix copy&paste error, that should have been an assignment instead of an or,
otherwise MTYPE_UC 0x3 can not be updated to MTYPE_RW 0x1.

CC stables.

cc: stable@vger.kernel.org
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
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


