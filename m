Return-Path: <stable+bounces-54737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E30910B9D
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7961C24AB1
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C931B14E6;
	Thu, 20 Jun 2024 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bANkL4iR"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACC1B14E4
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900057; cv=fail; b=d8Phbcj4iY0S7maQKOAmJsnzXzhClBWh5qm2fbclOriZ1/bV5x4W0CKoTIeJatxJvwzoTZ+INbXxFb3tiSkSPpenYvs3gmYArTjH6aOK8XkSVQv6Ca6gTJsDT/vC4KP/CaiD0GzRAoRA1Wik/m7r+95Il9SbfusDeC4biFcdy3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900057; c=relaxed/simple;
	bh=srHSia7DchEjL3TExJr6o7vH2lF//RuodZwsfyqV0mM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2CW2mmPwScnn2jvuJ00kTCYYzhr2sK8Lz4kuyOP4xDaa27YvusIwtabPLhD6vlFF0yjWMR3m1gHLglSMLzkq8v0NEmd9Am8ZhdoDsGX2HyvWRGEiqHwiSX0W2AR0IJv/DhsCfQmEK+NS72TSvocOUAtno37my6vUiC7sycLY3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bANkL4iR; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUrUlkles/wKJ7sXq+Ok5zGkjdw7M4BDc6oqoCpjpoc0xtrpsXnpdGgIpZa7vZwH4dsmcbtprF1BFoU57PJvhdT/5KyRE/ktnVCKfzid3Z0IlsqrtA3YBNea2s7/16tqtsW1fjZMs0xj0X2C44yxoGe3Vre6/t0LsbVt6MeqMmpPZStoiKUjwfFjMg0DdUy9iTcbJwb0nZ/+zNWcyKwnKggOIRnL/PC2M7P4rEtslQcK0xzEE8XDqSP+QRbbB196V1ZTI9edi9x8pQkPOH1nwYsmQSLdOpJ6sBnXUXlsFuo74j1jBtK/YeUnGSuwd48fa9yCttSnFML9Ci73BhFidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cuf/3lUZZDoSijT6eV1tP84qREmBj6mOUngjCL2qRCM=;
 b=UImi3LnPUcqr/ImY4C4MuEY80HLn5lVNgm3j2TXjsjyO9R9rmWzvJLm2fr6K8jgiId1pXa7L4htqs2F0Z/1XNUBIzWkIbrUc7vFzwYvUFfX35V6osMggPZjHAYHUJs3n1x66g+GwNyp3KLUcqKWifJRscaKtYBWAOraQKwNZmZnYlGRPEF++irz3A8VhviEZ/9OQ0AWZ5/oiY4kfuqQAeq1OKeJ9feJYqK2+JgjX2doOtCFa3MZIwDnSx9Fr/e33Bg4+9ubALCzPQ9hPvCFzvxwYezrd+T6aqJoV58Y9rmRbLDi1vVUvemBP2A3kKJ+hJpn8mbyZQbYEnY55V8M2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cuf/3lUZZDoSijT6eV1tP84qREmBj6mOUngjCL2qRCM=;
 b=bANkL4iRYklbBtQMSRF4xvBo2kFzTeRouMkTBC+oMa6KvV7ptIFkHUO63MsbgWOImpLBCCr6kZJIF4Ueo1brHsNJH5J20ulQZxGg6VGCDf4K6IspUwC234vaFblksxeC5N4iOznDDraKjJiLpIyYnnynVtrpObHVvep7n1X0BPc=
Received: from PH7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:510:339::28)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:14:11 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::37) by PH7PR03CA0021.outlook.office365.com
 (2603:10b6:510:339::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:14:11 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:14:06 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, "Sridevi
 Arvindekar" <sridevi.arvindekar@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 09/39] drm/amd/display: Fix cursor size issues
Date: Thu, 20 Jun 2024 10:11:15 -0600
Message-ID: <20240620161145.2489774-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f799c53-38a1-4d10-ae47-08dc9144054c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PPAHuk/Wk6fdnHeYfJNrHJfuGWG8f1nZv+R802cxdpAhjaEq5aq1KO5wB3CG?=
 =?us-ascii?Q?SkRIecoZAG8I7ExXtXaXUV/cVk/BLeivjbizCCVLYoIekli/lytlZ4bQaW2U?=
 =?us-ascii?Q?Tr5J1WF7ta5t3017TGyGPFbfKu3jWpLXWeUajn2YNH0x82KbLwNfr8JXOgST?=
 =?us-ascii?Q?b9xP8HrI+ogIhPjreymJcqoomBbOwYxydeXrI2qARh9Xv69y0arRU1J9auUz?=
 =?us-ascii?Q?rIAWhte168NQUkSx5568MhUH8RkZsobhNG6iRpxJ4yNyMCYBTZC9t1UspUsP?=
 =?us-ascii?Q?yseDcUzCWzFrHtFFCquQkILdmW2KE4Z3kCfQJKzeTObxTe86ARSBU8McYIqx?=
 =?us-ascii?Q?LiSwmFQzGNlaiUeqLdRgdWOHPsGRrET8VIL/NQTeGYj/GXINK1n3uT2UJ7kw?=
 =?us-ascii?Q?tgEUzTAdhQcTP6Uilu3iy8RCL+dI7IRI8ZrJ9Ll/2sRZ0Nakkz0dNsqUkPa0?=
 =?us-ascii?Q?gvk0yeHDNRuuweve35IwyoW3y4vG/td32iczoJe6Lt7iDb0ZpeoCTmxltotx?=
 =?us-ascii?Q?C/YvKypEiViCYPgvIH16sGE41hg7OvQmGGvXX5kzi3Z8NjQcqJwas5ug9ePJ?=
 =?us-ascii?Q?v62jaMo/7N2Zf6nUU5+aOB81+m4kwxLJaF++uuHp6SjTylhALEN9CMlM4975?=
 =?us-ascii?Q?eOS3IPcao4BkK+dMb1PekUoAdikal086KjNVDzHntwgUd9jl+M3+uMg7J/nP?=
 =?us-ascii?Q?aPHpezfph0FZp92lKOuIdMcvKr/dHvHsHP+EwQc/zAyj/SEqZx+kpH4vf4t9?=
 =?us-ascii?Q?gUnRrAsinLMLjbEoqs2mOmom0/SR5K+Oj77G7z85OKdgtYQjfkd0oFQb2c0N?=
 =?us-ascii?Q?0rO7Gu5uh9Zf2m5z0hlOqAn31JDJaHTTbwKdNZPrm+/CqhHFxfG1YC/X33D7?=
 =?us-ascii?Q?L7VZjCwLik1IDFkBhwcglPninHjKgMWkV4/hCap3TgAR7YhKIQdlBAmWVSly?=
 =?us-ascii?Q?Eqp7vSg4oTQo3aPgHVw/ejfiT2/LbDgIhoYUfizusKy4a074TozjzcdywaRQ?=
 =?us-ascii?Q?jLI39ICpezNvtiXW+NuT15sDWwNyX4FSdPyDNYvYEMkQcUaMF5oiQYijClYI?=
 =?us-ascii?Q?GfvxJ5g9yLKRfQ5MQoBvD0SrlZxlpGNRkx7zYrx/7QOGdISVsRyRnJM89oD+?=
 =?us-ascii?Q?6IZcHQXp3LnbuZQQ054WuVKWXEt5qNgvey/WpLsQBUuGio8W++r/fn+5QqMy?=
 =?us-ascii?Q?AMKYeNGEhJZril0+NhdlHwE/H9BjWfQ29IiBx5Bnqe6mKrAs+2hXWSgyjxTH?=
 =?us-ascii?Q?xda9nMB6xGY3h1kXOY43hKmsU9vbUEibaKDcij5sfK3OFIe/eKj1mLHl7tgS?=
 =?us-ascii?Q?kNCbk3UHqihXLcLregXvfO6BoDaJaMn+8ik9R4y7sujZqWUWAy1CUkeg8y7Y?=
 =?us-ascii?Q?R+xnhiz6snj5VLiizXgcdWVdyc+Wt6fVypkJCvnwfhJInPMNDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:14:11.1232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f799c53-38a1-4d10-ae47-08dc9144054c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595

From: Nevenko Stupar <nevenko.stupar@amd.com>

[WHY & HOW]
Fix the cursor size between ODM slices.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0cf55f557c3c..42753f56d31d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1169,6 +1169,20 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		x_pos -= (prev_odm_width + prev_odm_offset);
 	}
 
+	/* If the position is negative then we need to add to the hotspot
+	 * to fix cursor size between ODM slices
+	 */
+
+	if (x_pos < 0) {
+		pos_cpy.x_hotspot -= x_pos;
+		x_pos = 0;
+	}
+
+	if (y_pos < 0) {
+		pos_cpy.y_hotspot -= y_pos;
+		y_pos = 0;
+	}
+
 	pos_cpy.x = (uint32_t)x_pos;
 	pos_cpy.y = (uint32_t)y_pos;
 
-- 
2.34.1


