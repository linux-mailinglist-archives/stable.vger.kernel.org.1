Return-Path: <stable+bounces-132289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C53BA863C7
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 18:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157239C2A92
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D6619CC36;
	Fri, 11 Apr 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tjJrHXiA"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151C21A451
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390296; cv=fail; b=oLwhzzB9e9SSlYr1xw6UM09tjgS89FjO9uLtbHcz55GgbsB0IuVfLcx+QHOpUIffNpZqjdXkwvj1+sKkIIdgunCKqTTvWuqfUmHGp+HYZhre3rlWDlxlrsg1DIMQgxvzElTLToi5xDoPb0LvbRoHBJDmX31VaI6sBuy/BU2XZI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390296; c=relaxed/simple;
	bh=JtrtKHinyCeveVpC1UXmSeagDCE3j2Evtea/LgpRWUA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jiUx3AsIrhlYSWmSosYzJ6yRrdgSzFrGBw4Zmr1OliGoM3VPjaFk1GOlQOo4eNQFfkhi0qkO8k/X9uPxG40WTg+lw4lrJ+TVt5eRd8+29POW9j+9BaL7fHcJE0hjMSD6TRH8IbRdY0o185+eqNCvhl2sKpqNN9i8Sc63PdqZc6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tjJrHXiA; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAttyYfMZsd2AJRtvuGLxswkcU6t1NAo96099MtjSmv+TQ+TheZwv+9n3SIBbhsCgjVDV1hXueG11mq946XqqJxRRq+gNF1/W1jO4c6a1qPGb1I+ggrerQSR/j6L/3y/xFdbMnb4216o94hJVHJ4tTccdzvbQAfrUnpl18hNU1CatWtwnB2BSlnXjpdxaASyaWrFYUc7DeaG7aNDgM74UHoSqyUUFQVvYhQLZj32eqXeFVrLovcrb+qflBqVknaeixmsAwzedtOG0wEKNHT7RjnZiRfAVtGMLI6Ort5arvY+D89wvULmKLTjFMcwW9EtgxaWmv7eWR/NRm80JDGoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++X1k2ylk3Smr7mbcmyTLmIvv1u6ueuLrCcXKkqrq1E=;
 b=zFRew61nvwLzez5fvsQuPdctLkd8OmjITf5lKEk+FPyPjF/UBvkdI7hD4GW+LKS5fDHNpPda1QGGZZ4oUNnmOu4kEn3V57IXSqykcdLdELhXb6Obduiu8CVs3TLgixwL41l6ZJLH46hN0CZwBpinFNZeFA4Km12jpYDNycurGHpBp9H3JH7CscodttWwGx0gPX/Ia0tNd0z+E+ieRdVS9lvDckkaHXxbmoVEeG1pK3w1xE2aWop4BTgRkYLKjeXXL3Le93kWt8O3iLgneIJy8t7N0faeqpVBn6cntBPYVgaIgW2kDTACxu5BgmEonFtEKtkZib8mPEfmrSGxSrkQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++X1k2ylk3Smr7mbcmyTLmIvv1u6ueuLrCcXKkqrq1E=;
 b=tjJrHXiAfShUw7rJPZynLt64sNRWKVGBny6YBdZQ2hjsImmOpXnIuoZzfO+KSfpq+dpZAlxl5w65lO5kqk/WlRf76UMU+XW4PFilx5Lp0rRWPSU+si42E6AzlUAlpnWS6gqVRH7hc6qbEfA5fTHqDZLfO1LBiND51qSlyd/zlHw=
Received: from CH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:32::33)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 16:51:29 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:32:cafe::84) by CH0PR07CA0028.outlook.office365.com
 (2603:10b6:610:32::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 16:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 16:51:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 11:51:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 11:51:28 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 11:51:27 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: <stable@vger.kernel.org>
CC: Jason Andryuk <jason.andryuk@amd.com>
Subject: [PATCH 0/2] Stable-6.6 backport x86/xen: fix memblock_reserve() usage on PVH
Date: Fri, 11 Apr 2025 12:51:20 -0400
Message-ID: <20250411165122.18587-1-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c8736e-8312-431b-440e-08dd79191aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVZGWkdma3hXL0NVbTZxcyt3V1M0UnNYeVVXeDlEanhXTXNzN2dMbG1zVnMr?=
 =?utf-8?B?NUlaWGxPdTJyMWg3WTBjTjRnbGJhVXRtYVJPN1dTaG5hTzJxVG9IVTFPMGN3?=
 =?utf-8?B?QmZLV09UVkI3czNsQTJMd0JtL1Q1ZTBZdGlWTmlJRFM0NXhqcTJUWWxHVjVW?=
 =?utf-8?B?Z2MrUDQvaTNxUE1lRCszUzB1MEVvRVp6dUNCMXBpMC9GVlQwbzZ4VWx0dzEv?=
 =?utf-8?B?V3Q1by8zcGNFNUxrcFZXQlVZekRZdVp2Tys1TmM3Z0ZEb2dxZXk5Z25ocnI4?=
 =?utf-8?B?SU5UNDN3bzVVQ1Ruc0J3NWliWU5LdUtiZUZCYWh5VjlGays5ZW1tR0FYUXJo?=
 =?utf-8?B?RDdGYmwvREtwZWZHUDlGWlB6WHZzUkcvS1gwNU40MXlJSDE4dElkQ3E0V0Yz?=
 =?utf-8?B?Q3h3RTdxbkdLYzZEUXozdXhZWWkzU3EyYjQxYllzdWZBTE9tWnFMbmxmaGti?=
 =?utf-8?B?SGlMYjJyMmd0SXpPN3hDRXF6TzJpUDlyMGwxMDUwOXVIQ3VQVUVuMXhSKzFN?=
 =?utf-8?B?akFOZUFwakl1SVFJMkZYbENaaWFXSUVIQUlDVnhzVENQa3dSOE9ueW9BTjQ0?=
 =?utf-8?B?OVpwV1d5SnhnTExMRGhLOW5FRGtRS01HQmJEZGlxZERlQUVmNjBhb1U3TFQ2?=
 =?utf-8?B?OWdTL1Q0RFRibWtIUlBhWUFSemxIMW5KWitkcjVTVnRHTWd1WTUzbnIrWEZY?=
 =?utf-8?B?UHMxMlNWdUZzWGg5WUp4TUZSRzFwNC9pU3EzRVRBOXUyZzdXT0VtYzVQcTls?=
 =?utf-8?B?cTQ0dlo4RmdtY290bVJmeGFVZHBKcFFVNGV3RDcrZmUrSENDU3BDVFlLcnJS?=
 =?utf-8?B?V3RSWS9pa0R1Wnk4QllIQ253QTNQeUY5TG9LTVJQSTNVK2xyejl1eGNqamVw?=
 =?utf-8?B?L1Y0bTd2WUh6Vklrb1VkbXZ0dk5aK3kxemFtNkdtZ2RBc21ubU41amRrYytM?=
 =?utf-8?B?OHRGMHVsMHQrZGNZdi9WSndMTGlZR3Bkbk1JTDdiNlhGdGw0dzl4YWp1OG1Z?=
 =?utf-8?B?S2U2Z0haZDZOSTFCNHczbktlcmQxbi91c0pwNE5tTHFDcWxrWjdHMm95K0x4?=
 =?utf-8?B?UVltSmh0a09pY0ZRNndnV2w5N0drTk9HWnV0ZFpNL2F1VUVqclVLRTZNcTJv?=
 =?utf-8?B?SFEvakF1QjhvY1c0ejNDNFZzTXkvd3JaV1poU01tU3FnSFZkdmdSSnlEbisz?=
 =?utf-8?B?aEFTZmtQcWxYQVUxdjltT0p3YTd5M0dmWDArR1RmdW9rcFFpYXVRbk8xNHpQ?=
 =?utf-8?B?aUZNaDExeDl1cjhjZmJxdXQyQWpiNDBsM25RbHhJMFBHK1hsMnE1N2pvanRN?=
 =?utf-8?B?eWNodmdoNDBxdWZlak9WQ3gvcVZGV2NMamIwOHI1SitSMXpNeTd4NmU0bzlF?=
 =?utf-8?B?SG51Z2pBUkxjVGNRTTlMM2F2U2RpdUxtUXp3TklOczBJU2c1YjM3TGpHK1pL?=
 =?utf-8?B?RnZ6eDl2alZFSGkzREJxclVEc3hiNTNCNmxaeHVXQzFUME5DT1RKWGM0N1VN?=
 =?utf-8?B?WTllRUNmOVh1SXVsSGlnS2I3RzdXdUc1MWFlZE1sUW0zQ1RTWHZ2WUI4aGR4?=
 =?utf-8?B?ZTRQYlhoRUNPOGF4bzdqaGxiL2UyOGJWaVpzRmNVeFlGRVZXa2N2bW0vMjRY?=
 =?utf-8?B?OVU2SVV0ck5memluWDVONU01QkZ4V29sb0tjTzFvNkp4TEllN2xnOTd3TEx6?=
 =?utf-8?B?eENQMmY0ZGZWZWZOaXhoekR4WnBGTWxhQXVRd1NCb0ZPY04yYzI3SDRkcDdY?=
 =?utf-8?B?Yy9DMlBWYUF3RTJDYWpUVyt6bStOMlFQSDRNNGF5dGJTNldPL0FSYVA4dWlp?=
 =?utf-8?B?OVRRZU54UjR4d3dtZnR6dE5aYkZXV2ltd1laUENpRnphTEYrTE1pK2V2WWdj?=
 =?utf-8?B?bUc0K09JWHFscVlRSnpCQ2o0WG5Xd1hkOEowVDRKME9nZlpMSXFZSUJUZmp3?=
 =?utf-8?B?bDZTQXRHaTNVdXhFb2svdkwzTzBVdjJLd2w1NXpmRDhtV1pTOWhBd1Z2SFRT?=
 =?utf-8?B?QVc2SWhBcCtZTGIrWVZYMTR6RzFvQm5QNG8rRUlXbGNjc0RLaDY2R0dTK29V?=
 =?utf-8?Q?KEIZGO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:51:28.8590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c8736e-8312-431b-440e-08dd79191aeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

For stable-6.6.  

("x86/xen: fix memblock_reserve() usage on PVH") is the fix, but it
depends on ("x86/xen: move xen_reserve_extra_memory()") as a
prerequisite.  Both need fixups as they predate the removal of the Xen
hypercall_page.

Roger Pau Monne (2):
  x86/xen: move xen_reserve_extra_memory()
  x86/xen: fix memblock_reserve() usage on PVH

 arch/x86/include/asm/xen/hypervisor.h |  5 --
 arch/x86/platform/pvh/enlighten.c     |  3 -
 arch/x86/xen/enlighten_pvh.c          | 93 +++++++++++++++------------
 3 files changed, 51 insertions(+), 50 deletions(-)

-- 
2.49.0


