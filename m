Return-Path: <stable+bounces-136894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D79FA9F2F5
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 15:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE59461C6C
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0639F262FCA;
	Mon, 28 Apr 2025 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sdP6Rnwk"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744C269B0D
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848657; cv=fail; b=kCNWz1duo+gmo+eKYWdDyV5l+0Wgp//mWvpotF1bGzSeDXF+wKvinFczXG17z2mvtGv0JCsuvONTfAq1hSArUGky4tD4ZUsxo7tpxnb8BezbNzTK68uBb7Zb0QKaeb2/fafBKxEQ74xjCDk2Z7ZuRMohzhwmzaWZKnJBiFiRbkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848657; c=relaxed/simple;
	bh=r1BitlnQyzH9TDXbcEOeNRHTk8SytZkHNGhG+dK3dBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOkZYuMx4eZ0alu+sXLR1LPZ1k2te209obNcGzD+PWJiCyxsA7iVN+gTLGa57Ou4gUeFzocVshLTXrRJCcgYnMK66S4dEYCJuzKMtaTylfmwxWii+OFbnGnjA5sBGsTY3xYNEgQQ0S+pad4qbrRS2XOvCDzcSjbVjjEmGxCD42M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sdP6Rnwk; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBQn3FAhGh49LcMyhGXJV+l3E1LRqSGnHx+y+MdShbK/pYMO9h3VHcJR7AUP/mK34gTBoYgM6KwspsetAVZhVub6H+gkGuSYLiYzGT/GoVNtH1lXtkyhb59Nxzet9ixqv1m3ftEy1x6IiOzF2cBb7r6L/sdYQ+zdya8SxN3042ICKQId2fP+Nf+fl5QxjwfhdsBJchssIq2sExV5Z0IRlLyFO5WLedQauiTjgB86Sb09K1Bb94jFzVjYhMwsqZmUfTDtuNfP+QwYO9+5FBthmbolAx3Rfx54MbwA6Ykw2FmTOBxFCQwuo5ARm/fujGTM9qWq6IQ0PfO80wI4CJSwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJyE5mUaN8UQ5Ew5jbvw8QYx17jMNu1hoIC5ZFlAu2g=;
 b=OIpUw5u3W2VrlaNbH4P0Ldb6sbWyY4pYO173+GQzOLzCFSjfHU9DU8SB6mOfCd0kaM1xEHWz0Nc9hf2xGhO6J+oZKOts6BnBsVyAdMI90JIDeTgU5H27xPM3xv279p3prKSUrwvjDUP4cOBEF+BTbJGG37E2hqbqaQSMOmcJXwUC5Ii8xeXcuGFVoA9i7tD49Z+92wPN/aPtyaRZVx4b19C1fjOg5cefXxqUEAKjuNohPiK2KnsabvquTEaYcZ3DQYV0FppXUXqlZe8F4UZkd/7W33PAKCwu9FI7IzVoPQHeQQJm5DYb34a8Y2zDtN8rBP/pg8HIDPXbJ7pxnOhaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJyE5mUaN8UQ5Ew5jbvw8QYx17jMNu1hoIC5ZFlAu2g=;
 b=sdP6Rnwk9qAosLw9JDByhluxOrtXiDiYOXBXLWdv+FqzpAmJ3k1j2ozYBMIfZ3+sFLkKNcPB5s0qcHxJmaXrnWIaUlWRZotdWkg7Vnd/zg/MlvvHwkTSm9nZwFalhva46gadq57XCLT5stJp8bNZH2YULXvkMU6hbEw0Vmfa5W4=
Received: from CH0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:610:11a::13)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 13:57:32 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::c) by CH0PR03CA0351.outlook.office365.com
 (2603:10b6:610:11a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 13:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:57:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:31 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:57:23 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
	<Wayne.Lin@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 24/28] drm/amd/display: Remove incorrect checking in dmub aux handler
Date: Mon, 28 Apr 2025 21:50:54 +0800
Message-ID: <20250428135514.20775-25-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1605a9-7c61-4242-85d1-08dd865c9f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5zlpNnu+jUjs7XkdXMt+dmwgYikgeoKefL1Cbtdn8b1VYeEHtQGKxGojUrcJ?=
 =?us-ascii?Q?FRbK1ZXBv6QZPYHhyFSN9rRH2DEM2lRi7oDmFIU4vskxRGfmafV1LaWSsoNl?=
 =?us-ascii?Q?LnwXeFRELqWwcSWUCGAJeF2SZjx9Nynp8VAgpi2QYpDn79XaAUOt+urlUuY2?=
 =?us-ascii?Q?2J3nSzvKGXKiqUgDyoWA79IYeZLLExJupOfo/yRr0rDrTpUse4skiP1ByTTt?=
 =?us-ascii?Q?FrWxgkWK6m63GDzyrMfSa8ugOowIVKqlAeZRIBqPUamPHN6jKNCfgHZlnNDj?=
 =?us-ascii?Q?0FtY9xdB+uBmd2WLXIXLRGUoJy3TeXf1AuN1E9e9LMHHvJZSfeOKDrzKP8Xp?=
 =?us-ascii?Q?3ujEEtfEtcBMZS5MXoQ8IpvCc25j40Vo3ypV0Bt1PpT+cTJ6qH1L2HQLko6m?=
 =?us-ascii?Q?R7HlX6sWTGW1092PRb3CMdSswd3RPR/CLcPItuYPQaETRDoVrqd7A4r2KgM2?=
 =?us-ascii?Q?ZU0kvlns9zVD2UG2eOxhcMS7wuPaXB4POVuiSjhjEADtfCuRWYqnZUvimF+d?=
 =?us-ascii?Q?/vUbDI92xl2efScQ7njSmYdGDpVZxVt+TqiR7xdnmsFrJkCneoBAJdU3b2ZN?=
 =?us-ascii?Q?3gRTGBosebt4bJ3OBxBkhbQyOG2EUGB/6J+FPa+s2qRbAVHEilvnbuHSoTQ8?=
 =?us-ascii?Q?dSs2AHYwg+gVCbo5pQRQSR75++o8V15q8qouh1tiQP5ZLcQd0VYW1IBSTwtn?=
 =?us-ascii?Q?PCi0CnyhcwbnzgoRZ6tNK4P8YVIYsrbHVaipjyIiJFe7Wuh7XQkOO2tpbu5j?=
 =?us-ascii?Q?FGDyDUB9lCr8+eLMBKaWk4ika9jOvLx1MzZSIicAO0CLX2GIjateWuUtIiO/?=
 =?us-ascii?Q?0lqtvxW+q3xQ/BMfZlcX/fN3TUk53JReqTl4a69ckn65L2grkWVWbdV9JCu/?=
 =?us-ascii?Q?J44DmH/rz2beVMe64QMsApe3QbncQyJXuear/8bjXefqsOGVQjIrfSQBf6mZ?=
 =?us-ascii?Q?nc3hI1u++CJ7NZROcQFIBjok7NRO/eXRv180gyjPuPh2Os61o3GDInhcShpy?=
 =?us-ascii?Q?evkX4Uf9oj9UWRSGFSVqyZ0BQxoONaWHurbSC4qR/xGWFcTJghCGFkDDDG3/?=
 =?us-ascii?Q?fbUwdCAou+4QX3HlIcsD45IEDA02Bm4yoEsOIcYrCUhS7mVKNGT2UoUQbYF+?=
 =?us-ascii?Q?ZVgQDyw6AKjJpGuvGrLvJnB4ElvXQxPjA9BYe+0lgltMemwf1cHq+NExIhs0?=
 =?us-ascii?Q?/XBSD9cbYar4s1LThrF2UY7GNuwZN9EfPR0NaZUhFFjCxHAbkdA5eolr6Pd2?=
 =?us-ascii?Q?EYGRs0lP57Mvk2TggCwtmms3RULssqwxM0hhD1ZODWvSlEcbWugjzJ76AOjb?=
 =?us-ascii?Q?Kdsr5YMFqphiNf5X4sumKdeX2VQO6aM6AxttFMqEZVXJ7NYVy73baBGMsVXG?=
 =?us-ascii?Q?tB9ALas9hNv0+IeVDGgszmsZ9cTg+4+CEy5AMimaJxaIMMcHwbXcKLoRThH5?=
 =?us-ascii?Q?NPdqY8VD3o8zplmtwLFy2gCYmZ/05pjUtOBn4eb4fAov7v360n0/tmRzZAY6?=
 =?us-ascii?Q?qsKe1GXHy6XpHnE1ckzdxUvyVONk5O6tcj6S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:57:32.2883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1605a9-7c61-4242-85d1-08dd865c9f42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
"Request length != reply length" is expected behavior defined in spec.
It's not an invalid reply. Besides, replied data handling logic is not
designed to be written in amdgpu_dm_process_dmub_aux_transfer_sync().
Remove the incorrectly handling section.

Fixes: ead08b95fa50 ("drm/amd/display: Fix race condition in DPIA AUX transfer")
Cc: stable@vger.kernel.org
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ae71ff3d87a7..d9c18e0f7395 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12858,19 +12858,9 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		payload->reply[0] = (adev->dm.dmub_notify->aux_reply.command >> 4) & 0xF;
 
 	if (!payload->write && p_notify->aux_reply.length &&
-			(payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK)) {
-
-		if (payload->length != p_notify->aux_reply.length) {
-			drm_warn(adev_to_drm(adev), "invalid read length %d from DPIA AUX 0x%x(%d)!\n",
-				p_notify->aux_reply.length,
-					payload->address, payload->length);
-			*operation_result = AUX_RET_ERROR_INVALID_REPLY;
-			goto out;
-		}
-
+			(payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK))
 		memcpy(payload->data, p_notify->aux_reply.data,
 				p_notify->aux_reply.length);
-	}
 
 	/* success */
 	ret = p_notify->aux_reply.length;
-- 
2.43.0


