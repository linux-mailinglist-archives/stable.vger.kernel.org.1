Return-Path: <stable+bounces-202904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA63ACC9AA2
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 23:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83120300B924
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300DC1DF723;
	Wed, 17 Dec 2025 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QZbDnGgF"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AE30F947
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009274; cv=fail; b=VJL59HvobAbsejG9WMGfvf5M32QQH4XxG/FulMFzsH3yE/pgjf273TPNs1IWapRCvSZtse/eSeMKoAuLzKRIqAd90E5BAEU82tU7RN7PIGsH8HXYyuElPO75m7paJqSx17ocJF5CzYkGYMhp7dnBS9y1qU5GgGpQawaSRgM1Za0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009274; c=relaxed/simple;
	bh=5S6GbHHyGxwf1C1kkrQgIg/wJ9b2NaNbN5Ly5oilM78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mifrpKFFF21x8GomrBhoxo+c6PeVdSivrag5SEXLn3lOFtrQLQSHPEO/0dBmb+JNZtnNiTCZU/6aWY3SelMxTipcUPQ3Bcz4GdsRZE3H+uNBeAi6XkPIleE4vXGt9FqU30v/msOhfH3+2tveJ7B6YD7wzpnj23gIBJTT6MF4QAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QZbDnGgF; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Received: from CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 22:07:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aov7e2lBW5UhM5+9HkxWYL3IaRQMAdGxIARqJbdlfksdheLy8jPSDY9k6EFWCmkj2RA7vdLCE+iTWM24Ede6Xpx7DaES2ko305i1Vik/6512+QZrprnksJ9a+a2Iq/MMWykrsTeoWlFTb/G4aNP9n9SD4geEa3ZROMm9T1PCWqh5zorpwR79/C+ldjXAAKvRfvqQzRpVsTH+8KJ/6AYK5l+aRmrHpk75/b4cbUA2OY9elyo+yEyYywr/qVf4WW7LS+cx6O56LcHeW6o3m2Pk0mNLPc/AzO6OsIzJUCIifCToqSaqfOjSNQgtv/BxvOt5h4RKO+6HJJAfMaYh6AK8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNQTccXn6gXlbYL3bBfvEFTkuCCOry/Nm+qJVjEi6Ps=;
 b=Q+bUmwJFhOW1wjZo7YgcbGB6ptM4GPOIQRi4DOTprwRyYebKieNWW4wgO3YD7b4CVw2bwHBFsfaSfXr7E3mtc4ZJiLj/oJC0Vn4KehPOWhpoO69yHDIEvUIErF/uqjFkb93H6TVT+jU7YwUJsJpAPqcT4dE3ofoboJbIuuth7eQcyCtWcx3EWy74r6Zip43gQVNMFdCLPrIeETrf3rOVhLO6FFOjb+9yIRxB26o8ac4JjvYlNnTr3k/YdNGg4rgNfSQmm/7DogWEH15E8KSaOalgmBA85Yb27ab+INTjDsYjWg3bOJRL2laXA6X4wl+0rksCQh084DHEq4LQ4Q+zog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNQTccXn6gXlbYL3bBfvEFTkuCCOry/Nm+qJVjEi6Ps=;
 b=QZbDnGgFMu7Hm9Ya0HLlO6mhK4b+X8Xq/iFY0MRNkHj2TAPj7vXeAMMImBMi+2wv4+oYvr44dpEdFyxkuPqMURkGoi4mEG2Pxcv0SpqYaCzd2wM52J9PaJpAzg5n6dloP1nC7oqlwMLRhkiogQC/ktjVhCPpw545ZaZzb6b7JFU=
Received: from BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::9)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 17:54:50 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::d1) by BL1P222CA0004.outlook.office365.com
 (2603:10b6:208:2c7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 17:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 17:54:50 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 11:54:48 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <brahma_sw_dev@amd.com>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
	<david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
	<kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v7 1/6] drm/amdgpu: Fix gfx9 update PTE mtype flag
Date: Wed, 17 Dec 2025 12:54:03 -0500
Message-ID: <20251217175408.3020858-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251217175408.3020858-1-Philip.Yang@amd.com>
References: <20251217175408.3020858-1-Philip.Yang@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	MN1PEPF0000ECD4:EE_|CH3PR12MB8509:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: ec57dea9-d870-44ff-26ce-08de3d956001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aENqWVVkODFiMzhqRlNGTUVSd21IQy9NTlZPVFQ0SFk2ekVYWGl1SHVHWkdP?=
 =?utf-8?B?VUlsVG1oMWlOOHBtZGxUTFhXUTIzZXdoVjZNb0Vaam9MaXdZUnFJbVVMNTlw?=
 =?utf-8?B?NHJvYzR4RFJjNENVdU8xU1ZuRTcrZmlySEkwbEYxZGg5ZUJBekdPcXBNcFB1?=
 =?utf-8?B?R3RCOUdib2JWTFVOZDZJRTgwOEhnSWVzTTV6YzUzRXY2TDl1Qk1BU2hRbjBW?=
 =?utf-8?B?clo4R0hsTW41RkRWeGtNVlFDck1sUlZFL0hQWHFDbm4vcURxTllXaXZDNUJJ?=
 =?utf-8?B?YUZKLzFhY2tIelNQQ3VWOERSbUwvUDdTaEljQlB0S1dRVUwwNHBkYytQSkZk?=
 =?utf-8?B?MjhHSVJ4YzBlSXlicXBCeGNheXIvMEF2M1RPQ3c3b1ZPWW9xb2d3TUszdUJx?=
 =?utf-8?B?dDNCYkJvWlU3SDdDV200LzZ4bC9YdFpEK0luUVNlTktGUWk4RDBobTE3WUti?=
 =?utf-8?B?WmRSN0tvUzI2Qk1TcDFOUW1LSzhUTHZ5NzVtclcxUXBDMGYwRlhySlorR3Vh?=
 =?utf-8?B?K3ZPQzlNMHJsaGVwU0k2czFnYkMvby9hdVV2enpVTmlCeFdySjRKVnJqaFUv?=
 =?utf-8?B?TTB3L1dWaDBTOFNKYy9RZ3JEa3RwYnQxSmVqSTZZd2ZkcFVjQVVCSmZSTWVa?=
 =?utf-8?B?VFNEYTdtWGRHUkJXejZiNi84WXJzbDJYQUw1dEltdlBUcE1uR1kxMndENHFq?=
 =?utf-8?B?ZE5FSVJYRmpVRWFyQkg4cDJwaVF3N09tK1UzWVVDenhWa2M3Y2hTbCt0Ynpo?=
 =?utf-8?B?ZWlqeTJzMUdBRG5NZHVUQzF3bXA1dzU2OFNzaDd5RTNqZFRENHdqVDd3Ny91?=
 =?utf-8?B?elY0c3E3eDQrZjFQTUZlSDk1UVIrTTlqN2VZYytUcHZ0ZHRQWGFQczhxaW82?=
 =?utf-8?B?RVFKRUtWaVYwaUZLbXR6Y202blFKb3IvcmFNbllSQ0FoYVFtQjFDcGRaZGhG?=
 =?utf-8?B?bm5KNXBFWEFGODd2YVY5V2lUeXFWeXdUQUtPM3RpaTQyVnpmMW4wYmJDdlk0?=
 =?utf-8?B?RzhEN1ZGcjF1K0tVSTdPbkFkSzlqWmhIblczWmtSVTV0ZC9KQjBwcXdmb2hw?=
 =?utf-8?B?ZWZLcWZYcWJHdW9zeW5mWDFOSzJCS3NCWUYwdm0vQi9rVkZLaFJkYzQrRUZh?=
 =?utf-8?B?Ym1uellTVEhOWERvQUVpMUJ2RnJNOHk5MEJKS1RmK3lzM21DL3hyeGpBZkFT?=
 =?utf-8?B?MjdiWFRXRTZEUG1ZYk05RnZjU1lhU3E5N21qK1NyZmU0dEVVTHBwcHlHRkx6?=
 =?utf-8?B?WnlQVE4zUXBUVENNNVRlT3c1dGhrYkxJWEpYQ29zRVRhdjBaYTBXV2owTXkr?=
 =?utf-8?B?eDNOSEtXMGcwZXExSjhzdE5HWVlFRUpiQ3N2WTBEZVcyYmtjZzNUdG0yc3RH?=
 =?utf-8?B?MHJGUFpnd3JDNEZWeGF0OWNuemhxckxNVEpkVlFIZ1JoRmlySVJ4VC9QbERP?=
 =?utf-8?B?aVkrSnExa091WC9Tb0F2RW55akFwc0QzUG85cnoyU2RqakpSVVJONnQ0RUVo?=
 =?utf-8?B?N29BNEJieTZEYWNKWjJqWEg4eXJaZ0Rka1FQRDJxSnR0ZWpMWHV5NEpaTER4?=
 =?utf-8?B?MjBEb1ZBNmdqYS9hckNxSXhJVG1WQ2FETkdWMVM4NDlydU9hMkE3YVM1ek50?=
 =?utf-8?B?aUtJNjBGM014YitIZlM1am5KMlorek9LTlZCejNLK2VDNmY3MTRseW9DU3Vl?=
 =?utf-8?B?eWRrMzRmdGZ0OEhrTlZQNzJOc3Q1UG4rMy9GWk5RNVRmbXk5aTBPZHllQzNp?=
 =?utf-8?B?SDFKQUJYTG5XM0VwdThmdGduOUZFZ0ZQR3dzVVZIaFYwb2hwaW9CdlNUeENW?=
 =?utf-8?B?T0VMVUZvcVJYejk1dlRtMUsxVVMveTRDU25TU1pocUsxMVJLWmxwNjlmN2tv?=
 =?utf-8?B?Q2c4cWl0TGEreFFQcmJCU0VrdEZwTmpNbndnb05TMElXMlZzWnptKzdMNWJ3?=
 =?utf-8?B?bUZwODF1R3VONDRaWlRkZGw1TFg2NXh3aElRTEJXZmtmYktaazAxcnc1OWk1?=
 =?utf-8?B?MG4ySHF1RXpKNzhUSVE5SDlPK1NjTXhZRWxwMFlKL2ZEdVNxMmI5c1V6SGV1?=
 =?utf-8?B?NTZnSzUwU3BKNVhHaS8vclQ5TXFGMnlJaE1UOWNWZFIxVzh4Wm0vaTNnaTg1?=
 =?utf-8?Q?RFzA=3D?=
X-Forefront-Antispam-Report:
 CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 17:54:50.2864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec57dea9-d870-44ff-26ce-08de3d956001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
 MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509
X-OriginatorOrg: amd.com

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
index 1f630207ff6a..b932e4071c2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1233,16 +1233,16 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
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


