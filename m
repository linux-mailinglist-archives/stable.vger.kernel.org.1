Return-Path: <stable+bounces-35869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4741189793B
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 21:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC601C26A9A
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429FD15539B;
	Wed,  3 Apr 2024 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UmWULLVk"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47881152DF5
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173900; cv=fail; b=DXSxoQllc84O2xOoSL1JxitLEMhvkXNNHbIrQ+W1gJi6QjdRQV7WNXNEurNbEuUHD6Xg4kFsKzHjBR/kP9m/QFQ+hB0Vyd1GmmFjvaEKMLVJZmKz/qQ2yhXcJpctvJ6XGwy7/fxu1AzwSEEwxMAJPGOhMPVycwI1EHxboTvbtQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173900; c=relaxed/simple;
	bh=+xM9Mt/1FojhpbZjtz2vj7jfVY04AeyRpqFYC49J3BM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiZmuYaG4m0moyvpOEAVFihnhxiI8sC742tMGA10BAceZ7iy8s1OM6xnnADJ+C5IIOCTyhdCWdV19iPIJAp8bwYOYsOgZd7BBNwvzINSs2eiwLi+y5rIu/2gnrf+Pqa9GpbMVk+wClT9GdnyPAlJhTEYb8RtCg3asj/M85Ucizw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UmWULLVk; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPb3UzWG7v7Rny3bIMexiCJy8Niu4bcAIRBbYOcDXaAmPyYHdSPkTUAmmX4ciAxtyw7/zowNvvhPMshljABBY5ZJOavqaiuuCJdMHVJI9lf8v36IUhooszlBvzFQ5FZsD2dBMt6DKHaZZ5HK8PLj+AmNwIWL9FLPETNrnW2w0Hqt4VRu6q1jAkzj+irgpWCLh21xEKcnc9HtT791Z5EOsxh0klDU6ps8wJjFTe4m1Yh2Df7QqdAYxEXhW9JKlLSmSXRjjy38dTBy3mQf9tSzJBh2cdyLK9L+K+AK3gxXIAqt177Th7d0Iqk2ReQkXYXHfQ1WsbVZ2phbj2CskLpxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIBhVrb0NuviT4I53PqRpxV9Fi8Epo2S+cbwP8wwdp4=;
 b=FDqJiWsPQWUlIm4tDbuCR8yeuzVg8ZCE/oXRKG4Zcv/MWby8zSDs2WtKiLsyZdpKiC+GaFXvcdMYvxVSjPP6yUFCNL9MDKDdwxQk8YFjDWRc9vSp3GHKKYM3Cj3LJJFZhWDSOcjh63LjoZSUcilHpiJ8lQBN7uZQQRws2CBSALdsgFVxnLkLJ6G5b9uWlZtS5zFXFzxQHuWGrGYIQ7uyElVUwTUoNVUuTBONXQdRMNFVBqYNjRgLcErsu1zbjf5lADkinmEG+GLMNivFFu1DhDJOd5m8RCq6GQwhTMJ4SS0JG1eI9yIQVMjsj+3/HMtxuNlnUq3DqE51rxuX6hv00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIBhVrb0NuviT4I53PqRpxV9Fi8Epo2S+cbwP8wwdp4=;
 b=UmWULLVkrEr3lJwsTHPX8+cfPV3RfNl4kxRM9IENh5a/yyKXBNniCnl7IGL6fDGs9BKfKX+9MB6/okLcAueknqJiY4hlMvIZLuRaN5RKfC3/yikpUDphOKDg374EVcbO05FyPbbZ5McTqCk7Z6xXHtnJo6wctLtbqAKSMUih1p0=
Received: from CH0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:610:74::18)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:34 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::98) by CH0PR04CA0073.outlook.office365.com
 (2603:10b6:610:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:34 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:32 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, <stable@vger.kernel.org>, Alvin Lee
	<alvin.lee2@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 03/28] drm/amd/display: always reset ODM mode in context when adding first plane
Date: Wed, 3 Apr 2024 15:48:53 -0400
Message-ID: <20240403195116.25221-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 6614b6a8-bdcc-4044-b561-08dc54177744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PsVWe5sVqscFh9SGcD6je9fflU9TuzjDNt9Z9oCEISbZXfw0Ywj/a8BGCR2hiUbDLE9ASexg7eR9KhnE24M6BPD21jL2xjSr4K0BZruKht4ec2GQF+bG3nq2m0wYDBz1Rx0bimSS2aDQYB2hWVh34G9gRTp/bjiyewl+1dNdkLILRyQpWYIKoZWt0NZHGvjdF7PcbozOUOKZnSgEGEIwiaTZBoebk2dg+bN1KBVUNBY2Y5q9e5PHwWMvdUSkRf/LRp+2g8XIwoqeMPi2ty3M4jM1PCVPjxqu7xodhGMfVOJcc4a4hL2AoHhEe1rHZf9kTLwJmF7ZW8CjYpvxPEXBcpK3DksVm+KYGJ8xMosCHg1Q0Th4x9Ym4vUbFEJ/bUvOwGxdwspBlzkYoHZciojU9npjaptcyfF3k4PyPSX/Nrfq3ScZ1c1nd/ACMGdE7FYrNqsofhxdBwQRk66iK6NSUGoWlc4fwMpyrqs1VgqkElbbsgepw37L8/Z1CiU9u35vZIReO/D65SSNJ0RBkG2EAbumA3Jhsuo1TYXXTDUDAA5kd0OYcuQkae/ag8TSnbrTymn7hdtUyZn/sXgTqIo8THR0ylEdw3HGvwsPKQLQ27Yg0KirgB6tljv7p2EEG3o6kG6aDi02ymxIfoUA0XtgNvXaOWCyWJvqpW3yNT+lC4wfI80WxlyTVZnSIrCV1uVLoPwsdFOFSq/88neBApAlYYbumcvJFw4O+NB15ZYPqVokPXL/XOgHcn3nvXnSKJKn
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:34.1115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6614b6a8-bdcc-4044-b561-08dc54177744
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
In current implemenation ODM mode is only reset when the last plane is
removed from dc state. For any dc validate we will always remove all
current planes and add new planes. However when switching from no planes
to 1 plane, ODM mode is not reset because no planes get removed. This
has caused an issue where we kept ODM combine when it should have been
remove when a plane is added. The change is to reset ODM mode when
adding the first plane.

Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index d1d326e9b9b6..4f9ef07d29ec 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -458,6 +458,15 @@ bool dc_state_add_plane(
 		goto out;
 	}
 
+	if (stream_status->plane_count == 0 && dc->config.enable_windowed_mpo_odm)
+		/* ODM combine could prevent us from supporting more planes
+		 * we will reset ODM slice count back to 1 when all planes have
+		 * been removed to maximize the amount of planes supported when
+		 * new planes are added.
+		 */
+		resource_update_pipes_for_stream_with_slice_count(
+				state, dc->current_state, dc->res_pool, stream, 1);
+
 	otg_master_pipe = resource_get_otg_master_for_stream(
 			&state->res_ctx, stream);
 	if (otg_master_pipe)
-- 
2.44.0


