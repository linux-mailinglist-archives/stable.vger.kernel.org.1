Return-Path: <stable+bounces-99954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9299E75D5
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F7D1888D27
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031220ADD0;
	Fri,  6 Dec 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z5pkfa/g"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71520E31F
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502101; cv=fail; b=Ds1zkINTtdvPmYlIqCyIFIHx9sh9vnT2U2qCmUMwAz1WbvsRmFNTTtDYhrD5Bxvxh6Nso69fN9opkgzD8++qwRrx2pUal85wf2dbXlOQ5OKwAjvImb0jzOhK5zwScnTP0D6dLZFTbrj76DHY3WGTBTWGMuUXOw4cInXBAZgy3iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502101; c=relaxed/simple;
	bh=wsk8MjaIbWyCdpS86+Tlrkk+1jpU+E3FDjXmKu5DpMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4wqyWd4TMRJ6MKiE5PVFYjLXFZFzag+tShoKNGQrRlbTuir4c7xF0KGhkXxjuwyqSlfOC//4Th69gAEySxXIvImF/9slifKRMIrn9zjt5BwJObhbuHNPeXI/I9zYwjeBn4z9gyrwFvW4eyJV35PVm6oNM+G1TeZZW1n0LcrCLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z5pkfa/g; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvDGeX1AcMRD07UJ/OR4nbXlCCK5BqhiGQOJ7tOSm2LvNV01yT/W3J/QTjDmrI19d7WD7pVJ7AdxSszUIRfVBONkY5UEOEE2+zSdhXB7THS6X0/9+2EMLdTieip2W0bGQ+eA8jMTo2jaI69D5tF67ku/ZJBGwT0nGnJdgaVIXc8uFdMtjgO82YVXUShl2hNLt7/DFHuW6ngPuy4gtapQWGlYKKlP1np2Ec0vNQ4LIpO4//NlR7rEMdN6CfNT76Yc7tUuXDzj2EFgpnpaHDPuo7up5+rIXpHZYLeIlzi1N4AV7Af0gp/Pj6VTFQv/WfPbkpHLQusdvRnRbu4gQPDuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNjxk3VzKcoGhnmCB2PU/eFRYcCnzRXkINrG47YOmrU=;
 b=t6SSV1BsR+S3IN8TzMLbG+Ce6lPXbnnvGMAE1mABPutQ0/wEQ0vbIQBl5eAdmHnP+EgJ/7QvoY/rNfa87aiOVxaTfbEoPDSk+ZfPy6xqmBYpN+u3scgFH1xD+4L8ebXWk4/q12nBWQdvfGQn/M/CcVBY+2JvMvnHvA9h8BpBu/NDGtP0bnanjsSEtbJxYMCXx2Hx5eMHNysFIzvS9ToMDZpd/RMB0Nt8noO4iPrsuCRuKDwcNT6/CycAMXnR/yEjNh2U+GT+w+oNvQgBziMTP+A/i0z1YeaXFmrPxImEhswGOAy3oskll6FeKu7EKPS8cGY7d42429K8Q82TXhfnBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNjxk3VzKcoGhnmCB2PU/eFRYcCnzRXkINrG47YOmrU=;
 b=z5pkfa/g7GkdH3TwvJsZQ2TqogDgbzlgVMwOt5EaIPSvgyxTp63Wt78Ed/uch5GQUm2DWGbfOH5cIiMkmvojM7PEWO51tzbYi6jHxMxTFlAiz3ZGexoSpdTS5KzPpfsNcKVcn7Ns+OSLV/XU0YAW6UoJRWjvBN1teJ1gLbd9tl0=
Received: from BYAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:a02:a8::20)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 16:21:34 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::a8) by BYAPR03CA0007.outlook.office365.com
 (2603:10b6:a02:a8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 16:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:21:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:21:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Fangzhi Zuo <Jerry.Zuo@amd.com>, Rodrigo Siqueira
	<rodrigo.siqueira@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Fix incorrect DSC recompute trigger
Date: Fri, 6 Dec 2024 11:21:17 -0500
Message-ID: <20241206162117.2496990-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206162117.2496990-1-alexander.deucher@amd.com>
References: <20241206162117.2496990-1-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aeb408c-07d4-4b83-1612-08dd16120cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vX1feecIwx1vUyToWOl33pbOezaQhfYHvq0B6j2AuQkqQg1Jd15bVpJnvA98?=
 =?us-ascii?Q?Q1tJ6+77ehhfc4MNqecZDf1ZQ6v9sH/fAz+RzgigIPkTFKW5GifBDez9Oqio?=
 =?us-ascii?Q?Pz/lUURMwvSI8PTd7t1cYMSH054tf/9PceO2dlef8YkYKY7HlNsd/ueRHR4D?=
 =?us-ascii?Q?Tui1sqpi7rKu9W8TLQhhSISFhLUslJ5PAF9pAala+joWLeS91lNBAdNRKSGc?=
 =?us-ascii?Q?QDLUdeF2ai4vPXCoxqpeBCstygfFUBAhdx7lZx3dfWUBqlHfEEGyQqOmNXPH?=
 =?us-ascii?Q?WolVb4Qb4biZ0Yj9B6EwpizbqYNuqynOW8lPatMmjXEW61eGeXiI40E264B5?=
 =?us-ascii?Q?cct3q7sgfOgxIXpzo6w6DtVI7eG1mXKwk2z55Uf2OhYS4zHTDqu1rg8rSzGB?=
 =?us-ascii?Q?bkQdjUlkfl5nfTQpbC96qdFBJnms1dgovxxVcfgC/RUun+uY2N+A/T0roz/V?=
 =?us-ascii?Q?jBCB4rdCs34o/rb31FAZsdhrbYmkE+b2+UKA4b2DbwCZIUn+ozaDcjVY0565?=
 =?us-ascii?Q?PRVTbMqKC7o1Fdc0JZ5W+yvPGp1nsuQ9V26tN1THJQ3Y5x9rqgJhXCX6O/8u?=
 =?us-ascii?Q?80qB8MoH18tfnLmjKkQSdOkiCWVhHZDOPUn/XzqQQQktBWhqdmKo0CxaHU0S?=
 =?us-ascii?Q?jv/JSAYONUf0cJSuEM/a1W21oE8dSkRk0pbEaXgldbTIB+5S5KkOqtICWGcE?=
 =?us-ascii?Q?6ok4AnYzRF1p9AseB5LDt7HOUHx9tE9LDrdotfv85Nl2PsDcP7atW269nss2?=
 =?us-ascii?Q?yzuX9WJ25KOuPD5l7x+3/nVBbPvK5+0fooHRAwLgHzweruYlji9oDS8zdKsT?=
 =?us-ascii?Q?sHKnj1EBtDlx++DCE/Qj1AharRHjdPR4ZM9dOA3kapGfNDehybB9siktfyAD?=
 =?us-ascii?Q?qypy6ID9ZMsJihHcktQpLeuVn0Pnbi+kHMX0JFxSo9V3KC5a0RWe3CRZ+WxO?=
 =?us-ascii?Q?sz8x756u0Y7Sw2fNh++VhELf3bVyc2ZWBINK1jzsbKGymGi3jxTD3ZqxK/kA?=
 =?us-ascii?Q?0e4d9V5p47zI4qz86R7lJ8mxSSwOcFE/7Hpump+T9BBFpZPEXHq41Wktv4r/?=
 =?us-ascii?Q?QSzRsbHtJOZKbIql+XYLnyrKr+CbOy8CliZWnpcQE5zj60i1gJHuqy1YfU3Z?=
 =?us-ascii?Q?0SW8CuFGCIHUQlZCc1v7s5oU0NdeckNHjlb4IQ2S9ZqRm7BQxq0NrzWj8WbI?=
 =?us-ascii?Q?gP7+t+xm8/eQB+vXDlnxDF211BqXBq+ec3KpnZwwUZgJnO0fUdZsVy6uGM7Q?=
 =?us-ascii?Q?rtSqeB6hlGlZ7JRo4tvLOMUPLdW1Qx7w6o5nYqz38Se31X/uJ4R0LEVMoDkH?=
 =?us-ascii?Q?u2zgHz1Wu9STuJaVTgUSsKE0vGGW6Kdx/xCqWfAJwXkk2w55dj5GUHCcDa3y?=
 =?us-ascii?Q?X2DGfN9aQdkPTWdDmQvVQGS9WCts9Ph9BtCLOz4zjq/QTol9CA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:21:33.4396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeb408c-07d4-4b83-1612-08dd16120cca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435

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
Cc: stable@vger.kernel.org # 6.11.x
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


