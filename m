Return-Path: <stable+bounces-172154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4ECB2FD28
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53571BC02D5
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF141DDC07;
	Thu, 21 Aug 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="asc46Sgm"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DC1C27
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787017; cv=fail; b=GMLhknxBw/tEc5HQl00H0dTkxuv1J8WNqQEoYPfsCH3ohwc6/tKkQO/jkHVLL6RoPHgAkEgAPMTCuN2foFa9D9fOYWRzhzDBOTGl5xqUt91HT599pGM7VwqgKzcYaTdWQG6gZAxPrksry9lZbaNqAPcpuUisYy7Vg9IFDOJKjbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787017; c=relaxed/simple;
	bh=S4s9/APAWr/xrlYZ/lQTkf1661jjwgpEB77lha14TP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eh4hHRNAqqMnZdmnberxdDo06Dzp6s5sQyvTR8WMGYxUr+kkZNBRax5vXglAm8PMryxJWjDaeqc3P7Zi6V9sPNhz3WxrxWLlD13Ou5p6lfjEliKsJc6/D3Mu6+bojWxXbN3VB9L3c1HW778YFZYHvwlSKyNFQknzRQ5c3HPABRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=asc46Sgm; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwh1or8zOiEYIE7SaIdj3wZJkcDbuXs4NrrVIducig1DBOJNlIRjaYFQ20mjc+cRfukmpPDWMuh0cjZPKFXyrZPzkoaMXv3b9P44IScZI0+GSjbwWcEtq63PdzkB3ij+0ingqVylaHWYjWWec+LNWM1GfJxAEOcSwLVfOKw3i0RXcIsYkuocngSruAjDrE5PSgpytZ4j2rfPxoQVOLXyiIDtF88Hn4QXT0R8QLiQwHdpNZbxijeAXCxWSjJJ031QTBRF6jiE+stXo1nP6FUFTWS6PV08N/optKzzEahOmJCEJpINtXIp8EZR3aRl7Ez5BkA3SdjR1FCnTuSzdwA8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8mkTXd1tkZr5gGl8xgJLhDd3Sc7aVhdp26qeaqXxus=;
 b=bh4GMSqsqvdxNPq3PSTtqh+/TslImarrYDSN5G849xBth3la4irvsN5LTy4XbUEZgzknjOJlUihDxSnNkRWOwxYEzHF6nLrhMDiwQXAYJsZhdcTviLMm5GZ/aXj8FK9XOOD3VLR5LBbpXzp2PZIjMbUvMhSFGS07NFetDl6Jm+Mxt16YjY9o6CbBWqhpDdNRViPD5tdOJ3ZztsZ0kJu6MzQD1wM5YFpzHdTb2ylYiFWX2gweXQJA20EzuSuKJAbxFsZUNg8+w+2qkBXaMo1ZPkTLjB+yS3yJdZKlrbKFrxnTr5U6LAaWCDRhHKyodWOTZmUyvmwdBfBApeGj8JUUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8mkTXd1tkZr5gGl8xgJLhDd3Sc7aVhdp26qeaqXxus=;
 b=asc46Sgm2BpoD/mOBDDBtBbQsrSrFifqEs5P1o07aVsU6KSyMqZRs3UnjtN17lptzGMY9k9YVxJLA53WqCdWgfpsS0BfSmPGgyuzgGXD6kdo7eCUlL3v2nOSzzDYS1ONg7BM7oMuyeRg+pt9+7BMqRju+TkZMDpDTKMYeeu7Clc=
Received: from BYAPR11CA0058.namprd11.prod.outlook.com (2603:10b6:a03:80::35)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 14:36:53 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::98) by BYAPR11CA0058.outlook.office365.com
 (2603:10b6:a03:80::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 14:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 14:36:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 09:36:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>,
	oushixiong <oushixiong1025@163.com>
Subject: [PATCH] drm/amdgpu: drop hw access in non-DC audio fini
Date: Thu, 21 Aug 2025 10:36:39 -0400
Message-ID: <20250821143639.523345-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f73c3c2-22e0-441c-3d42-08dde0c02c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1diG9+DfPFPQTtFlr5OTg2ZzMGqCjJqzUWBbX++KIGRIF25T0dVh5FDIYGP1?=
 =?us-ascii?Q?5XNPnPgdSg/vwo4RUU3Nf/LWl11X0FcODCx+TxYpwkpZ0uoBu4C4aW5AkguK?=
 =?us-ascii?Q?IawpNcOh5oqxWZs0nz6FHe85Px9zNbc58RPVstylLeEOqi2zxe+VG5+MITea?=
 =?us-ascii?Q?REU5dc71DCy00vAcgeVSMAQwQ2ceLEPAoIS0Qs1Q2k0PSQKZa26laqUQxikO?=
 =?us-ascii?Q?7LlgnrNnEFCvS3QvAZ8D40O5GOhHDyaGDSWzui+M5Ssd0j4n6QFIy3iOj+67?=
 =?us-ascii?Q?htX2zHPjqWzj4d3Rz7R0uBYyE4QUQpMJAxvocpFDVzQ/hgznAFZ4ZT6z1vWU?=
 =?us-ascii?Q?Wnqn8zzIH+zgbwCJiGwHWJEorL7CdJnx2iHWNGdNHt/LehF+E7tdKp5nJQIY?=
 =?us-ascii?Q?0wfBklM0gFiRNoHMc04hVQkb1249pM8XIHTjN4jSZbYmermnqCq6N/KY6fsH?=
 =?us-ascii?Q?x8+B95u23YCoO8ePM5OUt3AyOGAWwAVzntlug38rXUGybt3cySiC0uFkngO1?=
 =?us-ascii?Q?TrY5oRKPtBpYv8QJvWmO0ADHCtxDpW17LPPDjPQdsAD24JLKjcg3uwyJlyiK?=
 =?us-ascii?Q?BRq3fhNTICc7Yx5ADjF49CL1LQQNXqd8MmWlPuX9vnz6AbV0DIFGYgi169Bg?=
 =?us-ascii?Q?wxQ0M2O0wnaDDNV/9EwcuZZX6gqrDKdwAyxa6uUgbYzvhh7bSdg9xy1qVrt3?=
 =?us-ascii?Q?s0ZwUxltpGKKmpYfzlxKM5J1wa2aocR+v+8ubL2lD12ulV9Sr6N8w0giXBFa?=
 =?us-ascii?Q?0FqKbUU7a9ae1k2Ayv6GQW6TCJMCBANOsW7F2P83fXqh6cyw6+2Q6HRGBJjc?=
 =?us-ascii?Q?79nOplZQibg4pGXBbsInzPp1HfLNPeRAWdmnQQynzJFeQA4S6sQA4lXshmho?=
 =?us-ascii?Q?TbchOub/9Quw6OvIl2s9L+67QoNu7YE+NTFUUkQQGL4EvDy5D5SBlYD4vyOg?=
 =?us-ascii?Q?f/ECTW1WKclgh40QbqEVClLFuB1DoEYClyFNaUoJ4G7TLRvdeabHxDrJkU+K?=
 =?us-ascii?Q?8hc1aoYUG5/ckDhrXmxf8IgxSt+n+PEuZBE/K5J4C5wWDK0Y6MGpxbGZOz3r?=
 =?us-ascii?Q?lVWGhgT3apP1JuOocgXK8jnGqYgi2HiKOAzajGNRcbPWNv7VVDWS8iomfZJk?=
 =?us-ascii?Q?rz4r6/TUvd8vu52va+L2dznxd9TAHZ2zQxaTgwEfRUtvfxVzUY+aHq25AHfF?=
 =?us-ascii?Q?n3cO4EnliX9Re9c+JJivPLnS0apUs5NtA7oaEQqBPqQv7pUQulYpRspvI1Ig?=
 =?us-ascii?Q?xHu1uWAUBOIC25HA/5YbQV84YxG7iwX6ufqXiJG6wHhXwEu1BBms3B+rF2AB?=
 =?us-ascii?Q?DkujlQdU1VBvubRQ0l1GY36Aeggurk1AGookEFI1v1QCEFAxrLc5IdF8cCc0?=
 =?us-ascii?Q?32BJyN2FAQXhlQZXeI1EooiKx5vTfeGfLSUpPYf431WiR1COrKDOmU9UOPB4?=
 =?us-ascii?Q?Ejje5dR20jollgRXWreCCSndVL0erEnEN17sNr7DirkbJmOaJun+BA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:36:53.5431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f73c3c2-22e0-441c-3d42-08dde0c02c39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545

We already disable the audio pins in hw_fini so
there is no need to do it again in sw_fini.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4481
Cc: stable@vger.kernel.org
Cc: oushixiong <oushixiong1025@163.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 -----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 -----
 4 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index bf7c22f81cda3..ba73518f5cdf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1462,17 +1462,12 @@ static int dce_v10_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v10_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 47e05783c4a0e..b01d88d078fa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1511,17 +1511,12 @@ static int dce_v11_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v11_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 276c025c4c03d..81760a26f2ffc 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1451,17 +1451,12 @@ static int dce_v6_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index e62ccf9eb73de..19a265bd4d196 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1443,17 +1443,12 @@ static int dce_v8_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v8_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
-- 
2.50.1


