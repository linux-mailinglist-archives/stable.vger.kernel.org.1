Return-Path: <stable+bounces-177861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E1B4606C
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E5A16B1B8
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FCA34DCCF;
	Fri,  5 Sep 2025 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sVtRkWp5"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9696230B537
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094105; cv=fail; b=IPJyG/U4g6vXp63maLBGVL6E7VUkh/K2/pXUOs599zRD0ukTPzK1f6wEGkdx+0bhWGU1nJfNe9ulZaiVqiegh2iJZGj3o6qpWqKw28a0nee2n4VTmI3Ff+339EThV+fCuQPX8fhGuyDpfcKHUZt3w9z+bameNTfxj3wR15LrGj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094105; c=relaxed/simple;
	bh=j6L81a0syUMMk+TP+07SHKzcJ8VtOFUuO+fksZHo4OA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rpS0lj9NSQOD//obuqo+PT9fZNLjqSTNSqhgCp8B4lQ5PMYhwa4Cr9zKkZWXQtlf7mFJaWOGycNGewHkmRy++g3SWSFWg2eRk/I72xRDCKckMLu0dRGWzyYR+5XiaRIVFUSDflikQIgtA6P2SMWtbDOCnHynYLWiRR9iX5dASIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sVtRkWp5; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiXb6WEQUiN+99ZBwdpQZhecraRyU9l/Z33vt0YJfHB7kG9eLs0z2QwOpG9T+4ooaT51PvB5GKvRsdZLyM0YDRuULwklrbnp2rcRp3E1eRsvEwEynPZnRaso2XkPqYWQqk1Wm6tZ12HfRw77MMW32G9t4p9uusEzxetZIa4m6mwj3Gid6XRcbuzAmp8hq/gEaNiuW1IomO9NvWYe/1pcsFZRK9ClptU8VvKAVjvcLvTHUHtrOhnYHtposR1IvxdKZsOqgZZ3XdBrMJWh4Rzc1aq2tJsTCt5Ix2E1QXSEoL2e8Z+GZSbYqznof9PttF8C8yfkiPCkWa5gb4I3KQ1NeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI4+nxdnAoemhoqF6F+cw1nHtpJCmYcH650x6YP5FsY=;
 b=F+uhEnnHclh11N9NxD2XQaaley0WIuncucKQXSmV1hDDBZ+MW3AJ1E/Ui4qoJZc9VbeAe/ow+iDEuU6i1g+9Sm73YTAirfCrRHidSeVrkliMFo6WZDI6jj/DKmDQAgyooOa+CIhZw98dutfShPyevQOag96fN77ArVyUd24AzbmVT1TJpyZyPv/fZlYMYnVOxGdxSH2D+82rsqbrsfJtK69h004z6Q/wfzRJm717qeDlucIFgQhwPt25nSb0Q2WJp3qbfqzGZSzSfj0EaEvbrWyCYyUqrKDZOIUtEosO8XMLeWTa+laT8cluwgx8PcjoEqGeUU8EBKjB1AQN2J4V3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI4+nxdnAoemhoqF6F+cw1nHtpJCmYcH650x6YP5FsY=;
 b=sVtRkWp5jQ/ahRgap4vnH/lywtDcOogAj2LMTy2lJt8uvJg8lkhlJu66IDONwuOMhoxsuqEV3WuZoHDn0dAXuvPj5ypPHA77LU/n30ZFTETP6kROaQ3aqquGyctU7/E2dnNb/Bz4F0V5femd34Jg1YsbM9NtSoTejmA2XpIOdLo=
Received: from CH0P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::17)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 17:41:40 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::72) by CH0P221CA0021.outlook.office365.com
 (2603:10b6:610:11c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 17:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 5 Sep 2025 17:41:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 12:41:40 -0500
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 5 Sep 2025 10:41:39 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>,
	=?UTF-8?q?Przemys=C5=82aw=20Kopa?= <prz.kopa@gmail.com>, Kalvin
	<hikaph+oss@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Drop dm_prepare_suspend() and dm_complete()
Date: Fri, 5 Sep 2025 12:41:18 -0500
Message-ID: <20250905174118.3493029-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 59483a85-4fa4-404b-ddf3-08ddeca378b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2dQZ3BZdHVQZmNGVVlIbVNwa0ZkMDltMEwzemVDSzNFME5TMEtyMWh2RDkz?=
 =?utf-8?B?eHNVeHA1SXdmYkRUTVZLR0hNNVBYLytkaWJyL0ZQcHE5S3NVdzlvTk44SkVY?=
 =?utf-8?B?Vk5qQ3ZaLzJObEJHVmQyRUxRSTlpVnR6bEJvTi9nTFVlbEZCVExJTFpJUDlX?=
 =?utf-8?B?YWo2dkhxN1hIV0tKRlFPUDBuVGs2T3hDenhYb09SQ09iN3hZQ1hhVkdPNzJT?=
 =?utf-8?B?R05TcHVvU2JKYTJRRzMva1hmdTRCbzRhSHpCL1g1QlJVd09EYldzNCtSRXNW?=
 =?utf-8?B?OXdBaTBxZGhsK21TUEI3aVJmZUF5R0MySVJMZE5heTNDRFNLMk5teGJhWXdo?=
 =?utf-8?B?Y3p1RTdjWFBBclo0bmZSNFJESVdSajM3cFNheXprZjNJK1ZLWkpha2g3a1pO?=
 =?utf-8?B?MWxMaU9lcFBwR3R2ZE9lYUFVUUMrZzJHVmpHbEl4Y09taUZVa09iKzQ2ZzNX?=
 =?utf-8?B?RE5NQVVNdnJHVG81ZmZxTFNzdExnTE5PYUEzcVoyQngxckhlYktQK3ZWSWt3?=
 =?utf-8?B?MDF3M3c0c1pORTJ3MVh6WDdtZ1RFOU9lR2NRakp2emgvZnJCUlBDWHZtS002?=
 =?utf-8?B?T0dXR3c4cTBrWjFqK04rRld5Yk5PUmVOTGt2MVJLa2U1eGxXS2tRcitBVW1h?=
 =?utf-8?B?M1VFMURWbUk4WTJGMWZ0QU50QTN1MVRWaHhpSFJMMFQ3MzJLR2xBWVlKYUtV?=
 =?utf-8?B?Vi9BY1o0eTlNdDF5alp4VnBTRDVZazBaUGdNYUQ1R2dHL1RHMldJb1B6bTVV?=
 =?utf-8?B?cDJ1U3ZlSXloMVo5ZHdYUUt6WWkrVHl0eDY0NFV5a0FWOURMYUxPeHhsY1pR?=
 =?utf-8?B?VURxTyt0N2psRFJQbHU0bUNGemJWMy85VnZmY0VmdHlZVG5XdjE5QlZlMkN4?=
 =?utf-8?B?eklwc1dHZXNveUFPVVZEYW5lY21KeGZqbmp2cHBzbjdraUkxMVc4UURHSjJ4?=
 =?utf-8?B?d1N3OXV1UENBL1AwcnBFQms0QVZCTEd1ZTNndyt1SUM3d1E3NFFVcU02ai9P?=
 =?utf-8?B?U0x6NGZXOXpERk44Sy9oU3BIWU9sT2R3anlLOEdaWjAxOTgxRzE3UTF1UjZU?=
 =?utf-8?B?TUxzdGRxWittZXZLSkFSN3J5N2FHUE1pN3R0UXFSbm51NC9iVHVIeHJKakdZ?=
 =?utf-8?B?MXJUaFdwdVY2dUp4VGMrNytOdHlNRUdPUmY3bnFLVUZFZll5T3ZUQmF6ckdS?=
 =?utf-8?B?SHcrZjlEeFRXci9QVlN3ZmQvVHg2b2xoRWNITFUwUDEzN1d4Z2NDMVdiQjFV?=
 =?utf-8?B?Skw5cjUxU1ZuZDA4TXUySHJmdkpuUURocFNTK0tNKytCODRZUkNReGxzeGor?=
 =?utf-8?B?ZjRhUE0zVzk0M2dCN3FOM0lSUVYxUEhaU0ltUUZ5dTN1SHFmNlM1SjdUZHJs?=
 =?utf-8?B?SWNDL2R4VXd3R1RvbWJHcXM5U1BhQ3B5Q2ExQlQ5VWhXYkhXSW54eW9ZZXFF?=
 =?utf-8?B?TEMrZy9CUDFCTUZxU1NtMUsrZUxKUE9SYTJ3c0tGRmkva0ZqdjhVUHZnL2NM?=
 =?utf-8?B?T2hVZDdGbHNuTzRqV09TK2gvMlAwc1JXWVhUbE9va0xFUmVEWEcydXVFY1VV?=
 =?utf-8?B?Rk9OTVo1dWJDRXMwRmxocWZXNTlnUWtQcTJxYnNIOEVTTWYxTVZVZlNSRTh3?=
 =?utf-8?B?WVBjYmZLVzAxdGFnd3ZtTU9Gd2orZnVkRm5taDBERXlJNy81VDZmV0loczMr?=
 =?utf-8?B?dUVXakthdzNwK1ZIY0RiRkhrUUJvTVdDcFRmbUdZbkRld1FIcTlCNWxKVEhN?=
 =?utf-8?B?S0VKL3NCK2RlRm1uVHhFWlJNMHNBTTVEOWxqaUVQb1NaMnpVaU5lWEpNSGFR?=
 =?utf-8?B?bzlvYWwrMmRwMGRHV3NPVFp2WjZYTUNLL1pjZkZVV2NRcFh4N25MYzc4L0Jl?=
 =?utf-8?B?WXVmb0VYdktLLytUYVlrZVBZVkdBcGZtZlhpMjZhWGl3M0k3QnV3bmYyMHo2?=
 =?utf-8?B?bmUzWVpDUDZsZVFWbmxNZGpwWS9QRWFKRXdvY2NkT3FZZEZpMDd4bkF4aWxM?=
 =?utf-8?B?blRjU3U1ZUZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 17:41:40.4862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59483a85-4fa4-404b-ddf3-08ddeca378b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456

From: "Mario Limonciello" <mario.limonciello@amd.com>

[Why]
dm_prepare_suspend() was added in commit 50e0bae34fa6b
("drm/amd/display: Add and use new dm_prepare_suspend() callback")
to allow display to turn off earlier in the suspend sequence.

This caused a regression that HDMI audio sometimes didn't work
properly after resume unless audio was playing during suspend.

[How]
Drop dm_prepare_suspend() callback. All code in it will still run
during dm_suspend(). Also drop unnecessary dm_complete() callback.
dm_complete() was used for failed prepare and also for any case
of successful resume.  The code in it already runs in dm_resume().

This change will introduce more time that the display is turned on
during suspend sequence. The compositor can turn it off sooner if
desired.

Cc: Harry Wentland <harry.wentland@amd.com>
Reported-by: Przemysław Kopa <prz.kopa@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/1cea0d56-7739-4ad9-bf8e-c9330faea2bb@kernel.org/T/#m383d9c08397043a271b36c32b64bb80e524e4b0f
Tested-by: Przemysław Kopa <prz.kopa@gmail.com>
Reported-by: Kalvin <hikaph+oss@gmail.com>
Closes: https://github.com/alsa-project/alsa-lib/issues/465
Closes: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4809
Cc: stable@vger.kernel.org
Fixes: 50e0bae34fa6b ("drm/amd/display: Add and use new dm_prepare_suspend() callback")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
NOTE: The complete pmops callback is still present but does nothing right now.
It's left for completeness sake in case another IP needs to do something in prepare()
and undo it in a failure with complete().

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e34d98a945f2..fadc6098eaee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3182,25 +3182,6 @@ static void dm_destroy_cached_state(struct amdgpu_device *adev)
 	dm->cached_state = NULL;
 }
 
-static void dm_complete(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	dm_destroy_cached_state(adev);
-}
-
-static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (amdgpu_in_reset(adev))
-		return 0;
-
-	WARN_ON(adev->dm.cached_state);
-
-	return dm_cache_state(adev);
-}
-
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3626,10 +3607,8 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.early_fini = amdgpu_dm_early_fini,
 	.hw_init = dm_hw_init,
 	.hw_fini = dm_hw_fini,
-	.prepare_suspend = dm_prepare_suspend,
 	.suspend = dm_suspend,
 	.resume = dm_resume,
-	.complete = dm_complete,
 	.is_idle = dm_is_idle,
 	.wait_for_idle = dm_wait_for_idle,
 	.check_soft_reset = dm_check_soft_reset,
-- 
2.49.0


