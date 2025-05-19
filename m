Return-Path: <stable+bounces-144756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 731E1ABB860
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959D01892577
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 09:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AC1257AC7;
	Mon, 19 May 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qnd8NXC9"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9F2580EC;
	Mon, 19 May 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645827; cv=fail; b=P5wF9Vry+xsEBJ5dKOAK/IR3iQXsMF6WJSyzj/HWadaRfbZNKbhacaExAJaorjj6179TMNfbXOVTuB0Vx7331u4xDs3hg0xTmhDt7nC+1b2XWWP9FkCzvK6jtcrLwmFIGZNOqZwenabl/9CRY3l2AZnLwnmhQYYBXzQ//+tVDkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645827; c=relaxed/simple;
	bh=fW1kn2m6CM8lQB2uz/QLZHu4w6ymNH52wgF9hkYPpck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPiu90mZr/aBMgSMCcEU5epPPcg/674PUXw2lL1NV18pjkvkaUQgIalAGpDpSkPCJcghoVm8lhuUBvXpjZW9Ym0nfBcgZ8bP13OFwJzk1kKI2uRisxolj5Spvld0PAemratenXSeJ99mauoLlolzeZ/pwNaHpEpz4YctNx5Uo5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qnd8NXC9; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vu8r9Mv2Dlvmso6PAoBP69mwLaT4KFhxbb0qGiPSkuB1BVHpkgQ8JEhfhjBhJOK6zs/iGRXzvdL3LqqpPnOJKDO436IskIQFabBxoGy42PYZd9OxF802XF17kHVGiDrvDJT5lb/bXxaevCIR8660m6iI7TM8EtKPZRPBgXgD/OygpgfdaUrj+bsKscmmashI1jWNpSNnHnCargqdJJCFQo0QH6Rtes0HgHTV2J2oOYtEDmiTlNClCx8lpgi0Kx3kerLhYPi45LBqFn4upnzsadIMq8zuYL5xxh7YszN8f4OA5Cl18SS6UOvN7INc+x1CF8EAcjZI2+cvRF9jDoPdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GalOtdE8/OHLGuS3Uv6e2+9I5mZxLCm+E2G4ARmHCY=;
 b=kwZ5w7bYDmQvMayvtE1/elTT2aV4ABKOXFUoZevCWqENmJYJTGrPn//1ot+jLoncEqfLVU8znkquEJd+UeGxHXi9QZ88XdSwx6pUZ3uMhBVuHbWGbj4zNGzuFXFk6SY0p9osPsq59e5p3GZ92FfNCPP6sTQA3fy+iU4ROLDFIddU1fKLu0GJTZ4RxwyGLoC5TK2BnvPQEvTywzhgWwn+CnAqwS+6hmBzMV8SPxsT4lydR2RN9Xu5NSlLv3VHVne72TSYBtSz6nDcKmmy+qj3sU5vuzqVLaW6Z+00l6CVvHwyYYpazZIcIpOhMZV5vJd2my3srX7Feen0PL/PNlKYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GalOtdE8/OHLGuS3Uv6e2+9I5mZxLCm+E2G4ARmHCY=;
 b=Qnd8NXC93tKMyhaX9IToDJikIjF3XktyfAZnZqPACK5HmMaoqDnS6/WXvQa+yYW9j2wXbz8exkUGGsbdCeOH+Abcaresmip3fp13N7pt0pvPUjKhyIlY/LOJtFXyxb5Cs1TX0ZsgiqIVik/aXXWJXfF/u9m9oX3iDtfU8Z+136wH8ukQCRB41TUd+3pZrcUJpomFME9fHM5ILHd4XD5qpwx/bsVKLCUNA8/ExidA6kLgFU0CJSVQJpg4xdVtUB37C8YFUkwbYJbZae67SuVoGDydJ8STNKSzD7l50rsbmASGD4OurOwGfDJicghNgCwTsRSlx8ZNsgucsK8/7tVBhA==
Received: from MW2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:907:1::21)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 09:10:21 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::32) by MW2PR16CA0044.outlook.office365.com
 (2603:10b6:907:1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 19 May 2025 09:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 09:10:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 May
 2025 02:10:03 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 19 May
 2025 02:09:39 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Mon, 19 May 2025 02:09:37 -0700
From: Wayne Chang <waynec@nvidia.com>
To: <waynec@nvidia.com>, <jckuo@nvidia.com>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Haotien Hsu <haotienh@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH V2 2/2] phy: tegra: xusb: Disable periodic tracking on Tegra234
Date: Mon, 19 May 2025 17:09:29 +0800
Message-ID: <20250519090929.3132456-3-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250519090929.3132456-1-waynec@nvidia.com>
References: <20250519090929.3132456-1-waynec@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f7afae-2ed1-49ee-5bd1-08dd96b4faf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3d2L2Y5WTlhVmFvelRjTmNGK3RJdUZ6VUV5bWxPRVBvYkQrWk16MStWVlZw?=
 =?utf-8?B?Y3Nma3NXSHNKSFNuOG1LdkE1cTB0VzZOaytydjVINi9TYjZlS2xITERGMkM3?=
 =?utf-8?B?YTBGS2lBenB6ek9YU3F5UVY3ajk2Z2kyU3g0Y0xzcnVZMlU2T01TbFREYk5S?=
 =?utf-8?B?SG54bVJTdGllbWFrWTh1aVpUWmRNZmliOHJ6QjJYczZiL3J0d2QyMmpRVVVW?=
 =?utf-8?B?R3l1ZFZ5eFFWN1ZkcTBzMmVKdW85UXplTFZ6Z0E4MDRwdTFxall5Q21IS01a?=
 =?utf-8?B?SWRZKzl3eGhzTERrNnVYTjd1R2l5enAxS2NFNlQvZlpqUUlLdU4wWFRsWW1J?=
 =?utf-8?B?Y3hDK1VNNTU5Q3VSbmxFMG5wbmJjMjRxY1d3aEdxN2xPTGR2VHpHS0NkTGpC?=
 =?utf-8?B?Q0Vyb1RLNEcxZTJzUXBXZUhLZVJyTjJSdmRQdVdSTE16VDZVL2dFMFJhdHpE?=
 =?utf-8?B?Y004NW5zN09xZ3BLNDNQTytCT0oxRmVuelBzMGZqb1VqZlhrSU5QcW8rcnhX?=
 =?utf-8?B?eE9kVTg3ZVQ0L2NwWWlGcWdzWlk3djgya3l2OEhBdWF2akRBSHVrSit1ZW5n?=
 =?utf-8?B?a1JWWkdGSy9KblFacms3SUx3SU1UT2ZLb0l5YnphcGJNRHVqMGVqdGhkSW1q?=
 =?utf-8?B?cmNoSmpvelhMelMyTWJ0MnM2cUUxQ3hrczVRQXh1dXA2dGtvTjdiNDBkeDVC?=
 =?utf-8?B?c21uZ1NoVmk3cjVTVnpNUWVFaExaR21sL05BQkFvOWk2akNQYkV1THp3UTd4?=
 =?utf-8?B?V081MWh0SURaVlliVW5PaWFyT2FLREVnd2ZWaVF0Zk4zL0ZWM1dKZmVHZXhn?=
 =?utf-8?B?WlhveFZJWjJyVVBXLy93a2xidUhCYnJVNVF3MktJaHV1Z2g0WjhZYzA1ekxB?=
 =?utf-8?B?ME9TUUxVa01lOEM3OVQ2a0I4NHI3VjJVK0hJWWJDeWpmU09rWUVqMUNDS1o4?=
 =?utf-8?B?UzFPQnJEQzlsMTRNaFZFRi9raURYRlVwak1rSGRXWUlJWmplY3B3Z2lJb2Qr?=
 =?utf-8?B?bFVFRytudFdyWlMvY3drUUNGSncrdDBNMExHYlJVbnNzUDllSCtrTWc3VXhB?=
 =?utf-8?B?WTJQOC9pRUVUem5IaDNDVkplMmFOeTEyWC8zZjRYSU9SRVQ1Tlp2cDlWcGFl?=
 =?utf-8?B?ME5HUFNvSnVFd1E4ckh4R0pIMnFYVTdTM2JmRlljY2Y1emRRek1kOW96WUVa?=
 =?utf-8?B?VGFsODJid0U5cmxTUU9HeVhZdzExaCtOMU4ydmVaSzJ0THNrMEh5ck1JMi9a?=
 =?utf-8?B?VDVzY2p3c2VmNHJmZzVIZ3BnUjk3aFYzNHhvOXdUeXZLSFBaLytEeFJ2R0hR?=
 =?utf-8?B?UGxIU0k4YUFWd09Rc3RMczdsaE5kcWxHRW9RcEZFcThDTDNmdEQ5M1d5K2NY?=
 =?utf-8?B?NXdvNHBTMENmaEE2eE1ZTUhLelZJaitrdVpBc2RlQ09tWGptRnh6TThWNVJ2?=
 =?utf-8?B?UmxKWWgwTHZSLzA0NnhnU0dHUlVzbm00QnBObXpYNTFKcmdCTVgvemI2RmRu?=
 =?utf-8?B?anlacmQxZ3VIS2xhWExDM2J2aEp3SWUwT3dzV0NnWFFGa0d5YTM5VjVNTTF6?=
 =?utf-8?B?VnZSNk5mUTd1aUVOQWVHTW9YL3QyeHA4TjFDN1dXOS9qSmEwQVl2eklvTC9V?=
 =?utf-8?B?NmhkVThhL1dlTE9EVFFLT2xyajA2cHpzVXV2bXVsU2lzM0VGUm1IVENCaUpG?=
 =?utf-8?B?dW50RFliMHRocmVWZHBqSnlaWDU5M0EyTmRMY29lK1B2VzY3U0tZd2pHOEpp?=
 =?utf-8?B?VVpsMXFLK2tMWjhJR1gzVWp2Qmo3djFNZmhTRGlUNzlUM3RBL0RaVVZTTCtR?=
 =?utf-8?B?RTJIVEl0aEZQZTVCdkcrS1RpaG1VK3JwWEZtdjgxZnJubG03ZTJQay92c3c5?=
 =?utf-8?B?NVFpVm5kVmFoeFN4eGVVNmJkYkZOWUR4N1gzWUhiMGFGeWpOT0FJUFdEWlhn?=
 =?utf-8?B?RitTdVowckt2L3VoWWFFRlZGVEVFb1BTNmNwTklaV0tOVStJMW1VZVdWR3RZ?=
 =?utf-8?B?MkF5SXIxYUlBd1paNnljbTZPMDZ6amQrQkNkUmVGeVkyWDFLY1h2QW1BalVI?=
 =?utf-8?Q?uO1UcZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 09:10:20.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f7afae-2ed1-49ee-5bd1-08dd96b4faf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696

From: Haotien Hsu <haotienh@nvidia.com>

Periodic calibration updates (~10µs) may overlap with transfers when
PCIe NVMe SSD, LPDDR, and USB2 devices operate simultaneously, causing
crosstalk on Tegra234 devices. Hence disable periodic calibration updates
and make this a one-time calibration.

Fixes: d8163a32ca95 ("phy: tegra: xusb: Add Tegra234 support")
Cc: stable@vger.kernel.org
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
V1->V2: Rebased the commit
 drivers/phy/tegra/xusb-tegra186.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 683692f0ec3c..ba668c77457f 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -1711,7 +1711,7 @@ const struct tegra_xusb_padctl_soc tegra234_xusb_padctl_soc = {
 	.num_supplies = ARRAY_SIZE(tegra194_xusb_padctl_supply_names),
 	.supports_gen2 = true,
 	.poll_trk_completed = true,
-	.trk_hw_mode = true,
+	.trk_hw_mode = false,
 	.trk_update_on_idle = true,
 	.supports_lp_cfg_en = true,
 };
-- 
2.25.1


