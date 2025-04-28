Return-Path: <stable+bounces-136893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A580DA9F2F6
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 15:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EBE3B531C
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66326A09A;
	Mon, 28 Apr 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dqOYr6A6"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2826A0A6
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848642; cv=fail; b=gyqMdKyMUKqmHmWBK+QseAoGvvUj/wVkt7J9KR6kg3EHe2yGYKu9yp3KYvU6RksScfcybjEtpkZOyF8w296+lCt3EUXds29DdaenmwWtJLXh96AxZH11J1vwdE8DDwV39zD2bybeZpR3UEwZqgl+oStcwUGOvT/ElJ16mDSd5OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848642; c=relaxed/simple;
	bh=kTJY9SsQStEgkxQcTBhXYXuiIGHenE4Y5zKWp39KOK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoZKMmmiv0f70pMPXvkX2Co3r+2yiT425Gx364HPe7DrkM3MjtRt9MNn7NT/d9HatVyzD1QR2y53yHxYKNOTqRfr8HoFGLQ89Cpr13ZAVcMxdnyfbByzOcZy2+Sb02DIX8bStXw3vDXZ002rCq5wTp6UCqa8knagC9GTRCzM0q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dqOYr6A6; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAVcIhIaTV0/n1n88zmbDZx5dpmezrhZKv2kysCiMX2tJksGnqpy+suF0fKhxa2gxJKjC4TnO/XNm2fn+dWQ79WE6FPVz2AwOEKEmt6JLBCNHmqVxyuZYQKxwdeF0WoTPVVb9Z5eiiarVVH5AdHUYFDbfozTD8FRnqacIVSH9mI6ia5b5xnGQa7YVHFibh73wtcKy+ODsdgKHN2pFy0dO7bAtLpdyhcGRZ5qTcVcB+V0EqJv3plkboAa3lDhLUqIX947fMc+GJ3aX4FPYwdyvR6UHl3mlj1i6dwaJ2+QQwHE5VtRrZ9OSQUqP8Mw0EaK4AT2Go9Rpf10zkp/qD1Q2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRs91rHmQ1oGyekvO4ZLcnJps5lywbHWXao5aGnmQkk=;
 b=LSZ51EwJ/84vLuD1iPytDqp94a65Z8vpoc/mCbrzaxAkhUAclurJ74CDa5GTdxSx37cg5tlef7GqBaWfmB7mJY0Ua3/cHf4fbUQpOQymZbG1vJbUCKYmWsYSD/1nvWKskzhH8TDpRJBouYea+2YcgUuGiTSixQtgiVoXCCZX5kIX9E/W/sTjR7Z62KYDSO9UD2+67CTH1JPcHBm2fqeK8Ast+MgJnjTorDtXC6CLUIvLTzJt6sASBvVQzhMCvvptUbrF+AjrnPSp7HP8TZVVsickG7+oo9TpoLISquo0EX6TfWD/PFf67Inc7DNgjoHOc/LF+1Q+1LQJJS3phZAeqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRs91rHmQ1oGyekvO4ZLcnJps5lywbHWXao5aGnmQkk=;
 b=dqOYr6A6S5tjQHDA99Z5z+beOp/01/047ioGhb/s+hoTjFq3VW8tTkyYgCSJ+kAEx+UP0gPik0uiSFiQOQR8HBpBmlOT6KFQuHouYHyHFrvYJcPjC4A78XWoWouJbqo3UjMCVCSqn+nGBnxcyp5fQrQqqgdr1huGbXCmCfpbaDI=
Received: from MN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:52f::19)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 13:57:18 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::c2) by MN0PR03CA0030.outlook.office365.com
 (2603:10b6:208:52f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Mon,
 28 Apr 2025 13:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:57:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:14 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:57:06 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
	<Wayne.Lin@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 22/28] drm/amd/display: Shift DMUB AUX reply command if necessary
Date: Mon, 28 Apr 2025 21:50:52 +0800
Message-ID: <20250428135514.20775-23-ray.wu@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e72013-3b02-480e-0098-08dd865c96be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?18K1mt3Z1SffoDkhhOjfKfONaZXkyC5tXY4VcCkKiUhD00YxiSB+QEYokJs4?=
 =?us-ascii?Q?bERX+NX68lSoOnj5+nD4hgnQ3rFMtEwPohDJnQ/9L7z6f0hGJv4gddgJDic8?=
 =?us-ascii?Q?D0ijHu22oJ8eW6qnbCimTzKjscttdxSpWGpoE6kpLvgkyzsS4EvZQx/YJJkP?=
 =?us-ascii?Q?KkEm2FVRDVzoip2jpBFUW7kAB2j0w+ZWQGd5dGztKqzpUQOxpAKtEHmA2gii?=
 =?us-ascii?Q?Fb10yhol1pfoES2kR4Yq3FJNLqcJjg78Ej+Azz48lAGa0W/wqDWxUIUUohCh?=
 =?us-ascii?Q?CKoRYE2q/hJkWeV7EZrqU6E/vhmWtX6w+air0dhjLRMsv3H/XfhPeUSbk/CY?=
 =?us-ascii?Q?0Bi4w+TrALM940+rEJ5qDOUNxZbf0J7UZazh3xcuUeGBDxVMBMzK6w6LEQuA?=
 =?us-ascii?Q?rVl3HqXCuOTci2ZLPfxQRKSJIbVo/SlSYk6F8/wBlAcoP7MCg5eP7tyOvp3i?=
 =?us-ascii?Q?tJt9sEWb1Thy5opTKCeU3baSEz1+JiWXzrlmQDQTCWDh6t5akUN42LFHSfag?=
 =?us-ascii?Q?Rkgf7DDCtTOLnqUJBIx33dtP50/h7eUvkBAqzkqyQR7c6UxgltS3K4dDoAG8?=
 =?us-ascii?Q?6p904hVjfhkT0Ypy4eyeLyryj+mYRqBCyxBPi4i6JYcJbS4NJ7KZBhHug5Xl?=
 =?us-ascii?Q?PUcpmCBgW6wuliaMZcotPQy7FBp00ylu+I7RBLYzXInpgFfa6HbBoYsPweV3?=
 =?us-ascii?Q?w19/0N+umv27+7kh7bPm86R34u3b/BZQGDsbkqvv6UxMd4OZWUkuG/Q2OFe4?=
 =?us-ascii?Q?5BxE96V1GCe+ohGrjx7oxJPcgQo+sNaAT2bnAIFJCYOrwxjl76U03rM0tlpq?=
 =?us-ascii?Q?4EdF/Hh+TkWHHdToGFEUQ5TffruxRck976uWw7bvMLn5/rbI1QHYGt3fiwR6?=
 =?us-ascii?Q?NiKyWY4v7SFgO7wTMy0BuEWPturEj+V+XwIUvZt5pK0vZAe65Utt/lwvCOyH?=
 =?us-ascii?Q?1kx3eUnN9477We9l2+Lh3NByHeV4817X0xrd/FcoAAtDf8FBlpftFSapv0/W?=
 =?us-ascii?Q?OyKN/aZQF6bmJd2YU0xD+4mUKK/fgg20ejdHPMNh4byabnlkk+aPLd9jMbdx?=
 =?us-ascii?Q?3pI4wUNBE2jftYf5/ryf1byvyggR9H6xtRJMtHbKTlV386OIWxGslJmDCHMf?=
 =?us-ascii?Q?uL7DO0B1LXLXnM6IByXXhQTJuMyMSLpUNAXdiNlpCgMql1n3IpfP7N9/QHwu?=
 =?us-ascii?Q?qtT8gzn6gtQEM+2EUxC2ZHQJd1z/uydhs7FYdKcF8/jfHjedzjKhOJdizxB1?=
 =?us-ascii?Q?DZXeXOdiOR/DWu6n95isc4LyW8yBVe75ESsMOFnFVsp02bjVTX1C3FEZlyY2?=
 =?us-ascii?Q?j8CAl1yfdQ0L4tgM0iISVbrNiYsDKvoNTZz0HRyAbioqO05B4AmvVEXliCFc?=
 =?us-ascii?Q?pK/Rol+iuq5o7+tZpalCINGfrkBh9J4r8SdbwprXnWY9TWbdYAgpVoqArIWo?=
 =?us-ascii?Q?E7XQfT/necsA+n0ueoKxVNDvnY1atlTlRh4rX5HvfEAtOksLKgtbmt43zAOP?=
 =?us-ascii?Q?H8ly+nHAFD9jqnPD4vHq4tymHI9KEut2NmDq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:57:18.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e72013-3b02-480e-0098-08dd865c96be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Defined value of dmub AUX reply command field get updated but didn't
adjust dm receiving side accordingly.

[How]
Check the received reply command value to see if it's updated version
or not. Adjust it if necessary.

Fixes: ead08b95fa50 ("drm/amd/display: Fix race condition in DPIA AUX transfer")
Cc: stable@vger.kernel.org
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cd6e7aa91040..a59d0ff999e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12852,8 +12852,11 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		goto out;
 	}
 
+	payload->reply[0] = adev->dm.dmub_notify->aux_reply.command & 0xF;
+	if (adev->dm.dmub_notify->aux_reply.command & 0xF0)
+		/* The reply is stored in the top nibble of the command. */
+		payload->reply[0] = (adev->dm.dmub_notify->aux_reply.command >> 4) & 0xF;
 
-	payload->reply[0] = adev->dm.dmub_notify->aux_reply.command;
 	if (!payload->write && p_notify->aux_reply.length &&
 			(payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK)) {
 
-- 
2.43.0


