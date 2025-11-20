Return-Path: <stable+bounces-195380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4B1C75E15
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADE3F4E106C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3026E3559F3;
	Thu, 20 Nov 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wwmkTAnV"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63A3242C7
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662633; cv=fail; b=osm49huxUig4UxlQVsal9ws6aA0252J5jEI6gMtjfr8vyDKeKp2qsuVLGjsT8P8bD5nYw1WSpK0d9/xNKSOQc+QjaGKgEfdJ7TEVzgWWxlvTYS2XcrR/xi/Oc9zUOkI/bngkxFUV4EEzn5vHcPnTUWeT2RwhonSABrO/abKEmzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662633; c=relaxed/simple;
	bh=OygIhdyiQpRqRMlMZEzTYnKZkLPvGFdykvwqyucXL/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3aBzExDPbRpQ7zDSpNcxFua9Dud/1UgaFOeUbLFL+NMMjgzTeXbxWgVb35d4YBIbEfjEgqEyj9CLUTjAZZxwBQt9QPs6LPUSWplnLwR59figVlchDJ4BWjs4MKRB2vcC6C/7r3KUTGk2yBbrmNbdI+UoXFQI62FS6W9oVVAMLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wwmkTAnV; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1fnH5gCKSsV3+I/iVFwM7KEe/QpupAWwwhjgHSMXTZwDq7gw1F+8HZtbmSbSNSWD3gRnTEaXhxoZS4prYJuOrNTE9TJx8fnVIHxU+flSy5OlLM9agyQC9QwLVL5QDVLLr/1S/7F4YixM0a1wcjCC1Y3mWS+UUN9LQWO6cyPaOMjdeNcAj7nkG4hNHNx77L5e08waAUpHgznsyS5GN30K+v/W3Vv982wy+dUAGjK5gv+ycySqrrza2T08GfyrocxVKiU/bKEthKmkubmjW8G5ke40DBb2m9WB6GYYCCpY9QWBNh2ZQ4QLhZKiWlNPktU6PtC0r1GyTRpdc1U0zRL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb9GZDCd4g0uKXh9jJlTiVm2okfPUR70qssWnX6bUqI=;
 b=RqMc3PuLZU3z4E9ZhySO6saVCP1KSs5r86ojksdAQ/DUQspJHjQAIggXWWDxIGCDOCBf1v/wdSLzCXM8ZMR5Qgz2uAriSV5O4ip/VuH/ZZNx3uo2M8lvpgw/2t0Hp6rnBgZHP93PRnC6CsvzX2TwdVWJAssVPZHHiMRiLKglytTimu5rUi9C3aqwYQIvjaBpqD5PMyYAopS+8wcMV0PvRhB9A14EHInT8rME3Nrg58MBXsxHPY+nGL9nibqDqFwIGvB/bY8vYvHlJ80ntKynO3JPB6ZYX0e1ByDX+GrK/cZ0W3pVWXU4zbbYGiDxEgZE2Yw6WXr4qdNko1rZ7f74yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb9GZDCd4g0uKXh9jJlTiVm2okfPUR70qssWnX6bUqI=;
 b=wwmkTAnVzHYeSjPz73eFp9EweTO6JDm8RXQvfRiqrH1ifwbp2iQ7ELRRU6EYiZiz1Zn+q5a3xuim8x+kSM/PSmOgHBnNiW+Q0UmIqzWB+/ON4g/uu+YROtGm85Y+7kgizO8s6V/MDvQlXhMs8C4jPrIxHYSy2FZu0Q+6dZ8yZd0=
Received: from DS7P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::18) by
 MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 18:17:07 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::1e) by DS7P220CA0026.outlook.office365.com
 (2603:10b6:8:223::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 18:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:17:05 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:17:02 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 01/26] drm/amd/display: Check NULL before accessing
Date: Thu, 20 Nov 2025 11:02:57 -0700
Message-ID: <20251120181527.317107-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: cad9674d-6196-4b00-ac0e-08de2861026f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RYS90DDtgqRvl6r1+CbXf+DiJcWyXCsRxoWmKBI3tEPf/ePrHTk8tL7kweUC?=
 =?us-ascii?Q?Wz06D/ibbp9wiIIuxLG5f8h3YpfHuz8uwfE+hBM+uIZmd+jv4/EP+MwMsFNQ?=
 =?us-ascii?Q?cddIrjGR3KjIwH089TqDAGAsU00msV9Am7lq/fsX2YFekkIl2McxPcwIFN9L?=
 =?us-ascii?Q?lB6dZ4H07L9A0clxN1gtfonGeIQzueZCln99WTmdTQ0TtP4bZyGw8fxVO+L2?=
 =?us-ascii?Q?RXgqxCOYgYRXBJKjW549ygulJJlHD6zM/isp4tjfnXTpTN3gggTRLHb1mZv7?=
 =?us-ascii?Q?AwkO6yQYHU/9LVHxzmPfYfvsTh3acQq93xMsnHwq3dWx/9wekffb9UjlyMvz?=
 =?us-ascii?Q?IMdQeoOl6KYYeyIvbIL4MVthwl8inXCQ3aPvSnBlqSylYpPY9jrmOzJEJmtE?=
 =?us-ascii?Q?N0q6Xe2qg+xBwMVt7qrOqaaA+6GpVFmmMleY5DV6HQ6aJ/e8/i0PQq1oXn+2?=
 =?us-ascii?Q?wMlM95Kmw+kN4i/6QIOJe6AiT7WEovLlR6uzQkOADvKl2QP8oZqIoCBmo1sS?=
 =?us-ascii?Q?xwY8YoM8yasNBqZ9gxQ/Sop3Cp8tRZZt7+dtqA5R7mtz5eklxHgCRbQ2vSrH?=
 =?us-ascii?Q?oPnBAbvCGUgLO66ckAY5VmLxSEaLHXOSDQKHEWWrcjOxjGIMYfBUeZXZAQBv?=
 =?us-ascii?Q?exhyg0zhuE7HKLcIfnWBblnKZ2gKo4BcGCErPgyDKBtc4K6E1wxefBbTBvc6?=
 =?us-ascii?Q?+9piMDDoZFa/vwPNh3msEtfPQlyBmk2udSOhHxcvlnVF+uL8DXeX8rteqpXT?=
 =?us-ascii?Q?IGOx3IZrd7ML5mYfsDsiNKPE0/Bq+i07NgF3KsgE4w0PQc+cHFq/cc/ruVTu?=
 =?us-ascii?Q?RFhPkVbNSw4bcvsZoX961VVzkWHy7jJgod0S2XdRkofXWMayJpPUwaZYmPFZ?=
 =?us-ascii?Q?ke+B2lyKNhfinCqX/NC3G+xVL0mrhm+7+C4Va7s1FnDokEe01iIPHSsYmvrR?=
 =?us-ascii?Q?7QL2yuGZDTn2RemlxlAOHKR/srSnWrdeOsGKap4dN/iOjuCncsHunoeRT8yH?=
 =?us-ascii?Q?TfxbvWsmQRgRWFNWr7vXNmB+GEyTP7nXbRcmDrcBwadNOjMMWWUR2txcB4uY?=
 =?us-ascii?Q?mmzW3+ksFKx1brmSLBwuVq3vL+QweObh/Se/QPXNHDviUYCQqn4d9BU+p+EE?=
 =?us-ascii?Q?AIlkSDCMZHDwrJq2FzGepykSdNF5lDIxRAwwiQ8iuqrboFIzecaZyBcC5KR3?=
 =?us-ascii?Q?W5LAq6Vl3xkQ9zl+4H95w+TU9+ZL9IFl5akoSqlznKwTAkfjNFXaV1BmwS/I?=
 =?us-ascii?Q?TIByHADl++FxznbkzYNAAldPFXfj0O/XYQ32PALaH0O2/ZksUBXnJncFJve2?=
 =?us-ascii?Q?jHX8fDJobw0eSgjnrS99d7I3CS9RCPD3oxQ8/W9dfTyL4sRRhgrCQ1Z6SQ3B?=
 =?us-ascii?Q?gUI/NL7Ur6HMKvfEtdqNQ79jSSwlSTFP6C3jrnhtnD7a4jR7wQwergpA5xKK?=
 =?us-ascii?Q?IhMlOeed1+HnDpwwFrWqI36WBYeQ5KJgXCz8umS8jlMRRS9EnZhiwympZ1F3?=
 =?us-ascii?Q?r0lX/yoMO3iiZo0Pzd3iokmQBTxFFwUD4QQB9rBn7X0NE6FNLBgW5kZgUqoN?=
 =?us-ascii?Q?vPtUZUUKoZKz/3ibZ6M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:17:05.0246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad9674d-6196-4b00-ac0e-08de2861026f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454

[WHAT]
IGT kms_cursor_legacy's long-nonblocking-modeset-vs-cursor-atomic
fails with NULL pointer dereference. This can be reproduced with
both an eDP panel and a DP monitors connected.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 13 UID: 0 PID: 2960 Comm: kms_cursor_lega Not tainted
6.16.0-99-custom #8 PREEMPT(voluntary)
 Hardware name: AMD ........
 RIP: 0010:dc_stream_get_scanoutpos+0x34/0x130 [amdgpu]
 Code: 57 4d 89 c7 41 56 49 89 ce 41 55 49 89 d5 41 54 49
 89 fc 53 48 83 ec 18 48 8b 87 a0 64 00 00 48 89 75 d0 48 c7 c6 e0 41 30
 c2 <48> 8b 38 48 8b 9f 68 06 00 00 e8 8d d7 fd ff 31 c0 48 81 c3 e0 02
 RSP: 0018:ffffd0f3c2bd7608 EFLAGS: 00010292
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffd0f3c2bd7668
 RDX: ffffd0f3c2bd7664 RSI: ffffffffc23041e0 RDI: ffff8b32494b8000
 RBP: ffffd0f3c2bd7648 R08: ffffd0f3c2bd766c R09: ffffd0f3c2bd7760
 R10: ffffd0f3c2bd7820 R11: 0000000000000000 R12: ffff8b32494b8000
 R13: ffffd0f3c2bd7664 R14: ffffd0f3c2bd7668 R15: ffffd0f3c2bd766c
 FS:  000071f631b68700(0000) GS:ffff8b399f114000(0000)
knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000001b8105000 CR4: 0000000000f50ef0
 PKRU: 55555554
 Call Trace:
 <TASK>
 dm_crtc_get_scanoutpos+0xd7/0x180 [amdgpu]
 amdgpu_display_get_crtc_scanoutpos+0x86/0x1c0 [amdgpu]
 ? __pfx_amdgpu_crtc_get_scanout_position+0x10/0x10[amdgpu]
 amdgpu_crtc_get_scanout_position+0x27/0x50 [amdgpu]
 drm_crtc_vblank_helper_get_vblank_timestamp_internal+0xf7/0x400
 drm_crtc_vblank_helper_get_vblank_timestamp+0x1c/0x30
 drm_crtc_get_last_vbltimestamp+0x55/0x90
 drm_crtc_next_vblank_start+0x45/0xa0
 drm_atomic_helper_wait_for_fences+0x81/0x1f0
 ...

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 6d309c320253..129cd5f84983 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -737,9 +737,14 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 {
 	uint8_t i;
 	bool ret = false;
-	struct dc  *dc = stream->ctx->dc;
-	struct resource_context *res_ctx =
-		&dc->current_state->res_ctx;
+	struct dc  *dc;
+	struct resource_context *res_ctx;
+
+	if (!stream->ctx)
+		return false;
+
+	dc = stream->ctx->dc;
+	res_ctx = &dc->current_state->res_ctx;
 
 	dc_exit_ips_for_hw_access(dc);
 
-- 
2.43.0


