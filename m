Return-Path: <stable+bounces-201070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F49CBF3C2
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 183053053908
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF7335089;
	Mon, 15 Dec 2025 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZmGFRkFp"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61144332ED3
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817835; cv=fail; b=irf9F14pZb2w6PTEEI5IcWnVaEMFUA5AmwVwMk+mP0dZ9rA+oXiqxeUcSG1RtqpGGtTwX1UfcJGMkuh2pFCuuE+6NOCG3saRnQsmuJIs6lTudYWOuOpMc0BtHvvqgQfV3IV/Z4C7eMugROwlDsy+AXL32XfEXmsllJ79dwU3Py0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817835; c=relaxed/simple;
	bh=SNMd1YDLR+qrJy3m8sBo5pt3QARXJvEl38CEAUBxdn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpLPV4I6LjHBxYj3XYQUcM1a/MVGOrD72SvQem2XQqN41eZu8r5lqMOlpbWDQGdfASVFo7fZJdFOOMCGMMQLWJjJrDFqJ2salWPQVaRpOBroAIOKIqKfRqojr5q7sHJE0mdv59aAFQNLd48OnEu6SQaZ0mYH2Bq2WIIcFh2VN1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZmGFRkFp; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrrxxMcgnEJGlRmRH8la7WNpT4B1GD9kpa4CrxWB0LzHumDEwnUOWZ+cybrOCKbH9RuLdW6GVqxBF+5wMlu7ziuVT1BWeKrc1hFDZ/EYMWEEq1g2t9regPFvqDTIimaAOoJQ251CLAl9e4cJa1Gqf/j6yPtfw2M1dPrtHepcaVL5oxPR1kM3CS4rswfDvhbALXlZKjAIyde+Gqbkt999IeEyqhRlXBj7tRtYxbLZgXnCSFJac4g05nHKui7D63+Y9hVEVE0OSVtfb0d1L7q+13HqFUEaS6N9M0L3QV2PFKrevs+zG7Lmnbw2Oq1TIEOZYasAg7PZZ3nV9ngWDRZCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERlVZ/lIsVQVciRw+l/sOfgT94UYxNgUDKxWCwTkcro=;
 b=MIVkORebAiTE9Acu6E5icqnDOLTCjI4TkKbrzCFZxf4O9fSyPqJQK6oaqkM2BZmRX3vLJjynQZ8Z4yg1FfSowrFbkCorAJah5fYzGWkebC/0KTwcoX7whMMYVbbsQ+eJSJLvKIooSnAfMqSR9uui5NB471QL81dV6goE+oz/aLstT43N3NXuWLaBAkfSGEIqWsoWp3Snq0/twum6pdJy0OhdbcaMezxqH1VP4TmvgfG6jHeWx6IAf3lxkIDy6zoIOgj+9r/kUfCV5rQSI3vpMMJxYAhemSYPw8l0iSBpeNdxUdFKIeCihFq3xs+AFghY+GAasuSNKivhk1Ujr5RaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERlVZ/lIsVQVciRw+l/sOfgT94UYxNgUDKxWCwTkcro=;
 b=ZmGFRkFp5GFlTiJ8cFiUg/anQRyMlRo6/ip0GWSqQ9Josl+NkHkbTSAohpzLYAaG3RRmow93LnkA+eL18wOXhsuGgzjnlbUNrookamCChqQpShE1J9V36adt2W1tFxhQkhjvIliAg6W/lNGrk5WLeL3G69MlNb0rYIrwrX19LFg=
Received: from SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Mon, 15 Dec
 2025 16:57:03 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::9a) by SJ0PR03CA0053.outlook.office365.com
 (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:57:02 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:56:49 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
	<david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
	<kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v6 1/6] drm/amdgpu: Fix gfx9 update PTE mtype flag MIME-Version: 1.0
Date: Mon, 15 Dec 2025 11:56:25 -0500
Message-ID: <20251215165630.1172383-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215165630.1172383-1-Philip.Yang@amd.com>
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a2639b-4ae4-4ad4-56f2-08de3bfaf854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEF0dHlyWmhOS1dEcDJXWE1uOGt2Szc5Y0dNOXhYTVZaV2FqKzltY2ZHbzNV?=
 =?utf-8?B?WHUxRzNkTGNTRzM2L1VoNE1ZZ2RuNjFkSCtuZkV5aW92aXN2b3k0VXdFV2N5?=
 =?utf-8?B?ZUVJSDFBVG1tdysrL0JkQ21aMG9nWktXMjlaT0s5RWFnYXBucWxBSWMrTkdt?=
 =?utf-8?B?QUZ6Yk90U2YwMXdLUGpDSnJEVm5scXBzUnR4elBQRmJZQkJFbHNnVUR5VnpL?=
 =?utf-8?B?Zms0YnFRQnlja1AxMTlLclZpNVZJRE85MmFGd2FRRENSYUo1S25reGxUVEJz?=
 =?utf-8?B?dlFwSkxGQlFNbWR5aEZ2VktEUUVUYnc0YVVnSmtOKzJNZ2hKcDhzanlVeDhk?=
 =?utf-8?B?dklOZ09ZdnI1THpXSHN2YlM3UEQ3aDZSdjJOWUxFVjhYMFJRc0dXTHFsY3Rs?=
 =?utf-8?B?QnFVSzQ2YVRRZUdOd0VMTDB0VFJ3OTNTY0J2NTNIa0RpdHRha2o0Tm51Y2hB?=
 =?utf-8?B?Q3lIOFJMVjZQYVlIeGlEZWZibEUwejhOc3I3Z1JHRXgyWEpaM2Z6MkU1b01k?=
 =?utf-8?B?MG1VcG9qa0xQZFd6K0NKUmdQbU0yUm4vRmw0and0ek9IR3RVeE4zdW4vK1ZI?=
 =?utf-8?B?RGNHWm85S0svY0hOVWJCeVU1elZmWnhMdnJnZVY1NFg5YmdkaTUxMHEzSmN5?=
 =?utf-8?B?TEdMTkgzaHh4bjJOQmYwY2hBQVhFaTlYRU1Nc1h2WUtKZWNXSExpRWNlU0xR?=
 =?utf-8?B?anI3M3lTeUJSZkI4dzIvS1BNZDYyM2hLZGVTMFlpUmEzeGVpclVlcjBYeDh6?=
 =?utf-8?B?eWkreUdoZDlETnpkaUcvMlN0V09vQWhLa0lKUm5YZXJtaUxMY1BXdFJkQmFC?=
 =?utf-8?B?QWZMNDZ4d2k3UzU0NTZnNEFtb1NZTkRxekd4SSt5d2NSNFFMSmpQU01EOTh4?=
 =?utf-8?B?M1FvYk5oRCtGSkxCYjdNOWNHcXdNS0l3OVdkTjVUWWFRcTRSMVF1MGFUcmJV?=
 =?utf-8?B?Y2lQWnZuY0xnM3c2QkFKWXdldG02K1FUWCt6czVtS0xhUnc3blV4eHBTanla?=
 =?utf-8?B?ZjBxd0xxa2VUYnlabHozN3Jzd0RGQjBMNHZZUjI2clI2d2thYmtsdFhxOHp4?=
 =?utf-8?B?ZzRkM1hxaHE1WVdIQ3BuMWVESjJwOVVIT2ZIS2V3V2xQZ3BNcUVFSyt1RlZ6?=
 =?utf-8?B?RUE2OFM0NklvSnRPLy84cERJVmxSMWNYYjFVMzlRaXBNMmxRcURGUkpBbS8r?=
 =?utf-8?B?MW52c25McGcrS1dHcmdLakQ4Mm9DWHBic05FOTN6aXZUNG9NSyt0ZktZVnEw?=
 =?utf-8?B?emp6ZzV3UUpZRUQxdFlYb1N6NXBtYVVnYUUyMUx1MWM3b1IzZHlNMTZ5VFVy?=
 =?utf-8?B?WjN3OHZoY1hrQ0ZZQ2ZyazVvaGc1c01uM3VTdFdUVkM2YVVBN0tVa3hxRG5j?=
 =?utf-8?B?R2NiYkpWenI5alprQU8zOU5sK3FDaHlKenEybVdKbDBNZlhJcHRLc2Zwemwr?=
 =?utf-8?B?QUZOY1FydGF1dmdyYnBVSlgyVi9wbnVNYzc1RkhValhpL21DTFUyVzE0aitw?=
 =?utf-8?B?TU1WM1FscksxTElqT2RjSzAvT29RUHJPRVg5T2JxWWNNVlMzQ0VVdDNGQUNM?=
 =?utf-8?B?VW1Ec3BaV25NMXcvaEcyb1NCWjdnTlkxVXdGWFlvTXlzMFYycHlPSTF6NkJJ?=
 =?utf-8?B?SnZwN05RTWRIOVJBZGR2dUQ0NVdTcG1ITTVSSnVJdWovTjhYYjZWK3k0cStj?=
 =?utf-8?B?UXVWM1daNTdsUSs0S2ttZXdhVDBwajNHMGVqMUViOVdrMmtXQ3gzNHdkeThs?=
 =?utf-8?B?YlNoOWluL0tvdUg2aU9sdkxtSFgrV1NYK1E4eXM3WmJMSjErU0N6eUM4WVhi?=
 =?utf-8?B?U0tnSmlnNjg5RTE0bVN1RDIxZ1g3SGtObzNaZFFYaWp2blp3TG1YRkw1NnhB?=
 =?utf-8?B?STlEMVFCRGxMeVl3MzVVTWpOSzFrY0hjZUovcWd5Yk5mVmFEdDZoRVc3SGZ3?=
 =?utf-8?B?cEhaeFFxa2YxUHRaK21PSEl4MHBNTkcxU2FoR3dKeGNlcHVMK2cya0JkQ2t4?=
 =?utf-8?B?dDFldmNoSXZVenZJK29zN29xTnExT0psNkltZlpiTFJmNFF5dGM3UUdvSHhv?=
 =?utf-8?B?am1OSHVrSHZ5b2FyZ1lGUVUxZmoxZkF4NC8zZzJhOVU3bnIrM3JyK092SHpk?=
 =?utf-8?Q?hU0w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:57:02.5989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a2639b-4ae4-4ad4-56f2-08de3bfaf854
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165

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


