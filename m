Return-Path: <stable+bounces-25432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87D586B79B
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA88A1C211DC
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C871EAE;
	Wed, 28 Feb 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YGSMnthN"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73579B7A
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146051; cv=fail; b=PN29T9irprxRJWruLgpA7AevbhqVJ8Lgnzw/xbGcqP30CSREJdZTyh9ngUanmGCg79doKEPxr0jb1hzKkdYZEtu7CcVxAgyW71cK+DGKds0qfwFoegupvOD8D33cE55PF/QKDYExatQv3h3oNnPx0kmNQANr8zH9qciZUWcHxNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146051; c=relaxed/simple;
	bh=OG0AucLoY9Ym7PtFA9U63WiprdO1fr/iHoIMq2Lt1n8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZVVoedqSkPuRoMB5PBTavhVRO+EEMPjMqpEDIeJDWNk6ySx6f4dzQijwOt7xBs2zOQEpeFV/bQ3hPnXpkGUMKuCm36n3HFfE2qfQtb0q3VJx3OegYa1ETai8ay1KifcLw2Dyz9yQFTkIIMgN+/u5jvA2Bz9YzqSme/ClZLYG6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YGSMnthN; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEa1KhX1qOVtPIdBRLQFm5NsO4siomVR9B7M984veJZ+VU8VGpcmqDpzTkNzfQ39mDOF1479Sojbn6mCuFO75cMOE1gjkrgZjsEs2qtXUSe6pBZCTvWUa2CkzV/cKBS9izOIyPSx9x9UJzuf2eAR8rbgA3RGjWIpvnhLigQ2IBE0VeXgWwZlBaAVMSJpIvln7W7cZLMDjjY2fzdC5orq0gckVQk7W1NPxvthkJObqYRcU18ES1yZ02r7qE46UcO7NWVUrWQoRplIYxYgD+PJZ6p+SjoT32Mv+lDCtCO4ptvPBq5A5PYNNCNzQeicQbsW3oAu+ZLjA/ONaNxZaf1B3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6817TsJkLnxpIzyMUqXP8IlNaUCBcWfC1ntIIgy4RA=;
 b=ZJFnQTxzEcPFK1FOkPz69m0wB58RQYLBDfiTw8bO5XxfzpnZeU1bRc8GCyKtUCxZxDoCWxFJvzkx2q9d0V1GIl3Ex172GlIg+M9ur5jIE9sqSYl3dJ7uegI83Dg7l7Xy9SNxyzw+KTdrdk19/UTNo8J7bn2ueD+LYpgCGC7zmHrzocJ+JM8I0LkM9/ov8fLEA3q/ZU5cVbYcHdPjNtLTH7H4eEvY/EEhpoovTkf8/4jghL4eRMC1EcCWDneiUIbMzLhc4NbrComJIKGhQRR1B4SxZqsdhqdIlkqEJnIskHJkyZLkh5LDLk3VFhq7zceqh13BlpGcbRARvm9OgZy38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6817TsJkLnxpIzyMUqXP8IlNaUCBcWfC1ntIIgy4RA=;
 b=YGSMnthNjLA7ylbxKYbQ4/tCJx2dXfhf0jFkowjBLSgMyBfwU20S/0L+rHDOugpNaDs4HHOMhAZREwIBoajqc+ZMpRdCf1mRzbzZldnKMwzLheI+p2rU4Wt1VtftoFSUUxCWtHWr1vqsN6iTfju+i9wO8M9MMMya5J08pyukziY=
Received: from PH8PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:2cf::22)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Wed, 28 Feb
 2024 18:47:25 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::3c) by PH8PR07CA0035.outlook.office365.com
 (2603:10b6:510:2cf::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:47:20 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:47:17 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Allen Pan <allen.pan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Charlene Liu
	<charlene.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 29/34] drm/amd/display: Add a dc_state NULL check in dc_state_release
Date: Wed, 28 Feb 2024 11:39:35 -0700
Message-ID: <20240228183940.1883742-30-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 41322116-9209-45da-17c9-08dc388db1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VWdyOPDG/FYFn+rsT7OVafeC4pu11Lz+GeqJUR44e/uA8N7mAnPRu5pTTz+u4CBsi/4gdONDf8YtTaQ79O9dDnUHrXkOEXCriGV5h24zkCgP4x/Oks+TApxyX+B5+UxYkBS6e6cbXiL7TZa/48JQRtWaK5QwtacR1TuFSxSdH3IOxowF2YvLM2pTpRVsoXNmat083RSOXgbUxKj9uj3vno/UkbQBbe2rMzaKky+8LWfOPcQXu9xTZMnuxBuf0IGBgZO+zBZfV/t7+0ev7VMZhXL0hcxSzawSTxGSuc3+n7viWeyrhaEXd2xCaK/yQPQ8v37O+aR7nFoR5BnPd3F75RbbcxUbrOByziSnLBGB35rQHCzZMlK7+CwRGaorQS8L2y+iMg6kKepxvkH7BJBoRhoJPCZqmMF82sFW3+3kpPDuaKJ4HRwMqPnl/hAR2VH1oCRnJJVHCl+Il+hi1Cmf/YR9Jfe6AgTLEHV2aojIIuJIIrQo5eYrVNvuDY9wH12j1eYI+n1CcAdBZZvosuTfZWlQUMjCduH71exeLzt0BKNcbXwQQiuzzIkIKeie9qZIkUE8bH+oBkYYBJAPmsodiQH5cCRuwQwQ9uaoXnYGPo/9SzoG3T9Oac2tBzBDxM+d/2gR2HkXVfSpUZQWA+uX7EQvyMsGnzFrOMxLH5spaT6oAUpPKhqwv7L+fc0MVyko+dHY27DWMUJqHTLgllOhNCDYurxlV7PNtsLyneHA263SIo86LqMAIuakmemRwJeK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:47:20.1663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41322116-9209-45da-17c9-08dc388db1ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

From: Allen Pan <allen.pan@amd.com>

[How]
Check wheather state is NULL before releasing it.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 180ac47868c2..5cc7f8da209c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -334,7 +334,8 @@ static void dc_state_free(struct kref *kref)
 
 void dc_state_release(struct dc_state *state)
 {
-	kref_put(&state->refcount, dc_state_free);
+	if (state != NULL)
+		kref_put(&state->refcount, dc_state_free);
 }
 /*
  * dc_state_add_stream() - Add a new dc_stream_state to a dc_state.
-- 
2.34.1


