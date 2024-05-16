Return-Path: <stable+bounces-45335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF40B8C7D32
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 21:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85076284895
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 19:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3176414533D;
	Thu, 16 May 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SpUX/YWz"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972AD271
	for <stable@vger.kernel.org>; Thu, 16 May 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715887633; cv=fail; b=iVm2jOBoE1MbW9rUQDA0IC8bsBX3StCJiyc73cpyePQkSKYXuE7Fxc9d1r3Hsyt1n+f0TPP0FHareaGvB12bJYcjObtVNN4KcwwbXFmbThOSGX/2AKea4YvNo8UnzdG2FZZlFftbQQiS5KnaCor0qmywUgcTI42e9NfBR6UJtoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715887633; c=relaxed/simple;
	bh=Cr2FznSJP0SG2jo9j9RSCqVs+wgBBij7xoBeVyzgXCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFGVGbyZ7d5ZALs7aD0k2Y3dWcJnC6Rp+n4npOFe706g66v6D8CauoC3GX7r1IV7XtBXRpNKyCPJTEUeUXrhPtlD7WzEC0ZCJCmBtiucPV/iGEPtmFQKgL1sbrT3w+4iOn22CJ5HK1G9Vc8J+R5va/vp1F2WeR4I6OT2LJ175og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SpUX/YWz; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avweTbtMyfrhFLxn6BPGsCoZ/iKA3fSwpn9zvQdDonmdXh2fD56TjiSuhVTxVUXi2kYAJwjyg8vsY6xsZZJ4Dfrg+4HFC9NFs9XX0gRVBlNZWQDrt2lIGWfNVwUkKpdn0anL1RNaqOa1c5nejDNVTnvfFkQw7hSFSexH4/wuTchwhmPECCBAg/8nsBmxv6g2apGvT+M7iPmTmia8uDjd9UVjZNqjn/rY3i50/Nex5R3ZNiXFVDurF+y7F3txLyz1yeBZLZ2ERcRUmpFN689fJ5mB0sbdpzorO+y0H+ApRJINhtjRLbMbbYkzDzr9BmDPR0rAF3WFsI/qaZM17ni+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=betzDHyDzFqA+vD9z6ChcNlWkudy6aMUGEDp90Pkltw=;
 b=A/1XPpTYOialKiRPDfdkfGXdH7mqHFt2BGaP6VOLHlWOAr+QWf3TsXM3LlYl52Kw0BcCEFKsgKEiVgm7+XERzmU/To5xZI+Cywpcs0IlfHVVaiwaZRCCfp1e4EpskSLYHJidnhD+zmgHlzTru4udS7K/tm6RbSBW0KDe3vWhYxu91I8LQsWiXZkfmAk9UxycWRqz8VDiaM+tWCKcmX0d2yf6rTA2MCJPutXX78D/uTtQReHbLSG4vX00TVvEkm2sf9DwCe4ERXmUaOvOtNcVPtrsC+a3blmQ5FKcxXCXseKHfpQqd7J6izsuoLlXwRKQ2uQDpiPCBMkgVVKH1F8WuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=betzDHyDzFqA+vD9z6ChcNlWkudy6aMUGEDp90Pkltw=;
 b=SpUX/YWzXWpK+TYIzD6sFKY5bc/4AVEOeKOA5lMTmyz+jS3cNTQPZ44rHAS2u4y/Wku/2TE+UXzhfmvMe5v+HGDafln5DyVHxs6sJ2dIWW18p1Y0dbWuj2qM24kPX+du4g8xOAV/BleZrs5LliG4VR3OHky0ANnieUKTMrVwPOg=
Received: from BN9PR03CA0246.namprd03.prod.outlook.com (2603:10b6:408:ff::11)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 19:27:08 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::f8) by BN9PR03CA0246.outlook.office365.com
 (2603:10b6:408:ff::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 19:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:06 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:05 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, <stable@vger.kernel.org>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>
Subject: [PATCH 17/24] drm/amd/display: Remove redundant idle optimization check
Date: Thu, 16 May 2024 15:26:40 -0400
Message-ID: <20240516192647.1522729-18-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: c116485d-d610-43c8-dd95-08dc75de2d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ssvahk+dvHyO3NpUI7nJ+A6FqR9IwhJsQMw7h7vufqlRL5B2Onp6MiaC+/Ev?=
 =?us-ascii?Q?AEyCj0HN2Ee1pWiQCIEeAktiNeG8hhA2EDKQ19ordpHIAWaz0Sar/aRAUvYt?=
 =?us-ascii?Q?jQrCWwI3UE3oTEWuvVlYVlpclbG4AScePwMYSD7UdRS3aXylEJfVD5s+AKKj?=
 =?us-ascii?Q?GNWdPjrBnnKVCAV+l8i+6DVqtzqQ9T0Jtxf+ChhkKYNjMZUsQO46WpdDHQCT?=
 =?us-ascii?Q?fSX7mGfa7EiiPZJtH705o3Z2FxJvfuODCmhN3uLDivyzd3hwQmHW6GBvsN5o?=
 =?us-ascii?Q?OIWz+WYSFH1lXD4NRWdOxVDXNMTY8sO7Or9EiCRnsVC4HcsWSL4krcrIoKc1?=
 =?us-ascii?Q?FSoXKBmOLy5icMe0mKewLVC5lbUsiUt8qwvxFroUldASOY0drk7PVBrgERso?=
 =?us-ascii?Q?SJ639Rw2ilyee4MizF6+SaMGqIhpWiM7fDVtsh+N+1dN2B7tHtyyJfm/d4Vn?=
 =?us-ascii?Q?bSxqgeIOh5MTCmUNn4fVyICNN8MXLIJ+CyeHmQ4XUyEeio+WUatvOjWVITMv?=
 =?us-ascii?Q?fmy8LRZYhmkXCk4IbrdyiAPnDZVkKnT6SZKVbxu8Zl+KbC/HCtop8cqkE1ic?=
 =?us-ascii?Q?/QTXeEG6cgTlhJnD/mkHelzmdTPfSdV9Y+RJypCn2wiKtkeHjVo60l8HnQ6U?=
 =?us-ascii?Q?d4XoWn2R5cZZEjMbA1ncFUnLWk3Y9cIhdgO/C6UuE6YY8M0nWCdDP0OqIY4L?=
 =?us-ascii?Q?b4XI+OdJOHh8zSt04iOWQdZzcunqdI4ONjTpaI9EBPteOtfd0o7cuJpCszdY?=
 =?us-ascii?Q?9j5Bcn6r+5JC8R+uAHN4j1L/myHFpdTTBWRP18p5/bfYRvRNBBuBpTDcppg4?=
 =?us-ascii?Q?LapxZopfUdWzrG3DfrQSPprlTXFS/9/dP5eC94V5I3oM1/jXDHib6ObeIfFb?=
 =?us-ascii?Q?+FjiuZmLfj+Ox79d0QEIvQHPYIIVeDunifTCguqN3RKxkFPdjMv17g4Lp0mG?=
 =?us-ascii?Q?+RWHh5n1YB49zOosvyLZCTyWE5Q8RWDDUzuuFPG/k1KMz8BjZ8hS3229512O?=
 =?us-ascii?Q?X9jzEhhBklw1ZWXlgHZxrwKEEWqziukmJgY6PTyNJE7piW75JCBFMXUVBmtE?=
 =?us-ascii?Q?k15TdL/5e+UPLJV/rRmBTjm9y/8OlVsvBX+8TBXxmSOuZ6GBUfVojOpz74bo?=
 =?us-ascii?Q?CHd97kJ1lyfY1YEVaXDnwb0/7TmPiB/UeJsTR+kIGGp0Icn2PG0p3YsuMp1g?=
 =?us-ascii?Q?eEEsmQxJt+HQSx78MtlYFJuzbC0gzZJz4BGOKYPkI2+9XmKqm1PXtjQfVh2I?=
 =?us-ascii?Q?1HqMWUnZZIebOwngbu87slRDgIqapuivvsLjE/heiD+A7ZSKIRc0oA6xAT8P?=
 =?us-ascii?Q?pzT17rqh92h42GcFJGX5TpXrjw/AGhvwe+s1wFeNJCZbVJCUZk7ARymRWEvE?=
 =?us-ascii?Q?2JHlwLyofLwq/cVDieYP2BW/1HHN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:07.9813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c116485d-d610-43c8-dd95-08dc75de2d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423

From: Roman Li <roman.li@amd.com>

[Why]
Disable idle optimization for each atomic commit is unnecessary,
and can lead to a potential race condition.

[How]
Remove idle optimization check from amdgpu_dm_atomic_commit_tail()

Fixes: 196107eb1e15 ("drm/amd/display: Add IPS checks before dcn register access")

Cc: stable@vger.kernel.org

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 53dc4c75fb75..328db84e3d44 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9395,9 +9395,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	trace_amdgpu_dm_atomic_commit_tail_begin(state);
 
-	if (dm->dc->caps.ips_support && dm->dc->idle_optimizations_allowed)
-		dc_allow_idle_optimizations(dm->dc, false);
-
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 	drm_dp_mst_atomic_wait_for_dependencies(state);
 
-- 
2.34.1


