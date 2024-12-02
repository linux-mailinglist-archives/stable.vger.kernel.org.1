Return-Path: <stable+bounces-96142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDC99E09E0
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED6B162DF4
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B482F1DA314;
	Mon,  2 Dec 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MGXJsQHp"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FED2A1B8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160538; cv=fail; b=tSkDqbjCYGI8UbNVMX/Jphg/V2/HJbLW2qNTd/J6/nPK7L/oKln0ZBJigrXb2/bxFGCwi9mRY+bnfBDGgh+yRM/6Jw3uXPD4zhoM+dEsxeZ1qVo3a7q/DEpr8T6iIWRwXUBFyT+r3ZigaGyorkYJKcsWzeWjZkI7CtL732dXt0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160538; c=relaxed/simple;
	bh=glb51yVsTLM33GQefZA5eJbvDO1hdUjuc9vsW7AtMIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQrBgBO4e7kF2OKNOITu3YggZ2zaNvvWkT48brGVUlL7ID0FAp0xxpMjIxSg6IBVkFhOHHvhuYDdUtSXhdcrV0qy1IRkjC+If94FD5I7vkxTMV3F0hPiqx9AGjNdQLQzy3ryPfKnh+EuflkG2E+Si5n5cksdbANCsMziRtu6rYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MGXJsQHp; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0hEVHzafj7D+1lbH4JmRHwxeDHGpfutfCRpQA3hFtfvsRBeMWO/VdvJ8P91zI+auRKtaddNAJC691iR0E4Wmk82iRp1aGEfTzlrnUfGomxaDwiZFqJwmwqXwMwJwVgMAn9lCN7pNvp6SvNIenJZfH7o71Z8FHW4DFAUDH4M43t84OrzvKm/uDtHO8mCwxKjE9pbhDzCU40cQN69mdufIzejhz3gVqNoCldSO1VcuujqW6qzkLAKvgooWgYM3rpclyzeerhaVfVgPC3oemFQaTKMIm4tvVzd7GHx4v5mxiKsbMn/2pr0hdCpbRIIhk+VC54bjT+tshjeOInVszWz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHXTcL5n75q8ACruSRee8oOhu44S4jcK67pTmdgNeJE=;
 b=MUlZYXUE8GnezqGe6x5KkWBJsi6z3n1EIZPQvus5CGmJonNK8DUlYGf9IBpOsV0+9VI0SC6CxyPHEClIqqbcZ18y0K+G3JP1oZc4QzqVhMT0MsshErixWlzEHE+Hn7oNcjODYeWmz85dIvFuow3DBjlL6fkE1QfMzob4Jy5sUsIHlwuw8fKmhNExCgrHXW9WbuEnzO/xyjZjG3v6urmC4jbb0qAEHBq9xaL0+OFGNETPlHEIEi9LPBDWFg+pNPDQAWf7swhUMWm52VQDCPrEFxBHQVvSKonUBv0ym/FmpTP6zpe8u7ii+Q3i/urGr8umhfNIr0n+c3R7KBgE6thPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHXTcL5n75q8ACruSRee8oOhu44S4jcK67pTmdgNeJE=;
 b=MGXJsQHppIfFktiIj52dh32k8FBB2P2M9aLLQO1uL5JAkU6Z9duYnYws/m/M7TT6scGpAmtUqqVW0Z0Vfq/aMM00O/AlJ/a9+Um40Pf92IaRqcmTLGJNVZAqV16l+L+JWYcxqDXhrUPKkmcx5UcJsbDFO0VosINvXGa66W+WadU=
Received: from CH2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:610:4d::38)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:28:53 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::4e) by CH2PR19CA0028.outlook.office365.com
 (2603:10b6:610:4d::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 17:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:28:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:28:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Fangzhi Zuo <Jerry.Zuo@amd.com>, Rodrigo Siqueira
	<rodrigo.siqueira@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Fix incorrect DSC recompute trigger
Date: Mon, 2 Dec 2024 12:28:33 -0500
Message-ID: <20241202172833.985253-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202172833.985253-1-alexander.deucher@amd.com>
References: <20241202172833.985253-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c505af2-c50f-48e6-5a93-08dd12f6caaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FPLeKNYM41PL/JJuSXWPWtMrjt/Jn1MskPPQ6MszmwrH9zufJLol37eH1rQP?=
 =?us-ascii?Q?KoEO+zkKO7OxkD7hoWzk9Do/7h9rR+8Wo0tgcMtc5N+m3OXbPeqq1TjwrcQi?=
 =?us-ascii?Q?qhK7K1bmy/3c25wDJ+biU6P8bMMXuW+jrhN5GACpYZwMobwDIZTI8zKtrh0u?=
 =?us-ascii?Q?TJTF3ZyfFNxPBO6g/wp81hsFF1py3X6GDAMjBaCeXh9JzKvAY/XQXjVQLQP4?=
 =?us-ascii?Q?jVtgufjyD6RHlQt8v7StLEejwBl3zZQUUmrwZ8PA7AMJFOF4euMhxfkwdzBL?=
 =?us-ascii?Q?XZc1tZUmCbNdqCFhelBNofDNQzW3P+SCqVEUyTujseSzF/z0NcRPaglG1nGR?=
 =?us-ascii?Q?2WiH7Kf1a/OzIeMVr2ZbFKca3wThfjKLiolroamTinqK+adgcXfsvkjZgfwk?=
 =?us-ascii?Q?CC50kWyISgFT+NzN70grraBrwpSm6sY0ZQ9Jl6wCD+dfenxS9e8JRfTpLE0+?=
 =?us-ascii?Q?c5EsOZscoFToIuXTrKwVI5HAkO3O+kJOm6Sb07MgvN6MMRqrL0iBIkDKR2/S?=
 =?us-ascii?Q?bB9lsdSwrKtW395AlggT93P3hNlMEk5chWSgQAWJ9hy0HusAb5VtbeXxSjGm?=
 =?us-ascii?Q?fWjFmDxlDy6WpsIq66Se6FrE5P5OMW39vBZlLjgfCsyz4eGfcy3Il2tEGr0Q?=
 =?us-ascii?Q?6kuotRFbTyXUgCrYkeN/TZrD4qVIPNhTwCY9B0azd0eaDQSW6HOFwFyOZ2UW?=
 =?us-ascii?Q?KxBot86uV4jr+xxGLFq0srR7FueUzolTxEwjTVQ/aF0L9ABt51xLHsPNOsNm?=
 =?us-ascii?Q?bHkYVre/A1EJm0EPuTWXUsy+y/97B8OTxyBZYjyxsCxXOmGoj1QaP3rgIGGT?=
 =?us-ascii?Q?l0f+klB0bw1CfpafGjkKcq23wbJ3DRb3hzxHs/BTZv5Ak+Y2XrvchWzmc0QK?=
 =?us-ascii?Q?Dtx7wPzYafGbwgKcVcdKEkAxiu22BAnpafxgT+YAJ8HCCgSzMhkZqyPYvZzP?=
 =?us-ascii?Q?CP+L+6S7bhp9i5oMsko+WpeZW+Cte1wy/oGAuoQTDTEfogL+m8yVI0r7a4Vz?=
 =?us-ascii?Q?aLjgJ6jO21uU0b8cS7a7lCkxBJN6EhxzOb5WC2uhoMQj9J9kHEmOe4K3nkWP?=
 =?us-ascii?Q?jUgPO7RF/Er5qjgtZ/lojoDl3PrgD4zDRb2FTEmyxR10S3xT9JeAlKXhRZEk?=
 =?us-ascii?Q?20mXo/dxqR02+urHuaCqMf1SVCgJE1SKh0qgjXfFZltcrw6oR4pW1Haj8EUq?=
 =?us-ascii?Q?Kmy6In9TXbBUcEVtxSssJ4iOohSwayOhPKrEoEZ2U7PhZKrUQIuVU/LrPGFk?=
 =?us-ascii?Q?XJIlPBt/qX3DVCJ6ecUXl56f1pVkVEi8/TR3kJhaPnmVdbRExmDVCDFVSB++?=
 =?us-ascii?Q?zebA/MOuFBs1ydot6tRkn1jA1DQ7qIiqwbOdbcI2QisbN3Z+cUu1vP6EqGhM?=
 =?us-ascii?Q?SvaeKBgEzO8npmXUXDt2pr4HLS5U1/jF3lpUrXP+7lK2pvkJWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:28:52.7129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c505af2-c50f-48e6-5a93-08dd12f6caaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

A stream without dsc_aux should not be eliminated from
the dsc determination. Whether it needs a dsc recompute depends on
whether its mode has changed or not. Eliminating such a no-dsc stream
from the dsc determination policy will end up with inconsistencies
in the new dc_state when compared to the current dc_state,
triggering a dsc recompute that should not have happened.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3405
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4641169a8c95d9efc35d2d3c55c3948f3b375ff9)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index f756640048fe..32b025c92c63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1313,7 +1313,7 @@ static bool is_dsc_need_re_compute(
 			continue;
 
 		aconnector = (struct amdgpu_dm_connector *) stream->dm_stream_context;
-		if (!aconnector || !aconnector->dsc_aux)
+		if (!aconnector)
 			continue;
 
 		stream_on_link[new_stream_on_link_num] = aconnector;
-- 
2.47.0


