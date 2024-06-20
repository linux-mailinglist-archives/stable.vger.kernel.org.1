Return-Path: <stable+bounces-54739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927A9910BBA
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B9E285EDE
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E22B9DD;
	Thu, 20 Jun 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fdMjbT4D"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0F17721
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900176; cv=fail; b=j3wGbUPMk0nYO95bRS/asKl7lZcCScGGJV+j7V+EVihxRpRdQPE1akk1oee53xGKWmEYdplvIfh8TM/jStaKrYrWJ4Pman76W93jVkY8iE1GrMzVvHijmP7Sr1Xk8ub7h0O6pbMAIRK4mzpwUK80jA/n0hvW41s7kugqS4mlo6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900176; c=relaxed/simple;
	bh=1/MFVGV0fnCuvvw0S46e4mF69Ec0IyNo+h0yLVRnsOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUB9cB2zL2K6rUE2G7MCtSLeon88nqhy2ThzMZgCYZsRhpoWn31Ig8VjWNZjG1xjXGJpieJPHweJXSW77WCoRn7EqxgL1wVTg0hT/cTpjG6F80acuFVvPHJ2dLDUFzlYQmvDM9+pGFA9PwKdS1jRq0pj0VH9cSB7A/I2qe/OOTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fdMjbT4D; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMHOVSK9Ho3blW0emRAvDZdZHKzvbMSU5Paz1htevkIO2scf/vs0+xowV1SyGBwVleJg9F7u7AIGCHtj+ykiX+I1Fn+ajDmW0l8cFL2kY08GVKjJ8H+jOAuchfjTadhhd8qPGkkKQHAYrdqkMZm6i+OW14f3V5jR4npE2+XVnwwoF7Iy8jovKqVS3txotcibsD3jk8PG6JRoeVWTdbsTyrpqGPRQxNroa7t3g0wEetWcQgWr7Fc82xIdldIKyihy65uCvjgq3BuFOzylURaoRSzZhhkprRSKKc/CfSug4Ax/4BNpANDENc1nQrHg8bVRPBnII7usBUzeriddcDonOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeNhjMvzzL5UY/RYW6Cc876iahIAZqjciJmadwrfFTE=;
 b=b32f5cLzqC/2xDW334RGVu60CRgp+l7ITpRboKgxkwJ9Vj5cmcgsFGQ7FC3iTD3RfUBgKZr3I5Z82yl8axbKU+PWHN6c+3guYlM3BM9RUjUpgtzonM/tHU/8V9l4UBz71qGdEkjKZSJiaiIoLa19DsvH1atf+FybJ176613KaA2OXkgeG226fPRurSopgFuPAjRk3j883n6r1x2e4hyz6sSzZ7uZ1ZC/g7uqDWTzDFRo/tXKetDQzKYuFAaFRRDu2UDmUm44GyVOxemPacW2+LCXF8Q0+rVNj7sw6fFW6kJdrosSrouPkHBxlpjEw++Z/wvPRS96c6BNZKssP2bA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeNhjMvzzL5UY/RYW6Cc876iahIAZqjciJmadwrfFTE=;
 b=fdMjbT4D8xrx31nnEIa2Euggd1sKlQbDeq+kalczclIEUHFgdsuuTDifwIQMA0dP/g0p/iXEObR1ZezLJ/IDs5W61+xCAWWABzL8liMQMogdpFw86ga8tFgF5V+yD1bZee67qLlNwbjVSBxgfzhZvmxqQ1VyfxKdJIbTumrX2AY=
Received: from PH0PR07CA0036.namprd07.prod.outlook.com (2603:10b6:510:e::11)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:16:11 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::b4) by PH0PR07CA0036.outlook.office365.com
 (2603:10b6:510:e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:16:10 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:16:07 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, "Leo (Hanghong) Ma" <hanghong.ma@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 17/39] drm/amd/display: Always enable HPO for DCN4 dGPU
Date: Thu, 20 Jun 2024 10:11:23 -0600
Message-ID: <20240620161145.2489774-18-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: ce464c95-a21e-412f-d8b2-08dc91444c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T3sXYKhHe9WUDLO1U8j92izYA8EtVkKNbco/0dUYCTERjZxVT343pN3y+zOT?=
 =?us-ascii?Q?HHppE95gODMUbCCgqTm3rxqH9S790BvkQhoViwBN/BW7LyE81MO4aHrAwCGy?=
 =?us-ascii?Q?QWqNGLzybYogHZ835XrVNLU2BI9yzzmR4ImXHbyP4Tzs6XfadU6oVtjxFUI3?=
 =?us-ascii?Q?ehqQ9WoZaKmUJRtPjmvJyyRB5+HfaVf6wRioEvgZYEXPdJetI2cPdPmjnsHN?=
 =?us-ascii?Q?IMnOKuUG97a++3gkGhwaLmIDIhii09RQuLOA7hIBjY7Li34zxlKMdjG+VKpu?=
 =?us-ascii?Q?3aQYgs6RWvuCxpNsBHsMnXWvPpdy7VVlugd3MXf79tNdDZBZxu/YstUqMxXw?=
 =?us-ascii?Q?S6JtDi7wlzUAbwnxAsNnhec/1mAY4pRhgXdryPASaFxZbFDIUzRSC+pTCXtD?=
 =?us-ascii?Q?qdWQwRcp2qgLLslNU/t/5kpARTCcGHiro4m2f1luuAGbXijZuLluVV6VF8uC?=
 =?us-ascii?Q?3meNEIjTwW/8KxdaQn0KRrtqg+KZAOqskbbKstXO6kAY6qyosVJl573kcs4a?=
 =?us-ascii?Q?Ej5tbpTRJL1UpVPRQdSceu/LoHSbvjYUOpp/xsdMMAOzp0CBk2c6kwuujWD2?=
 =?us-ascii?Q?WohJg5bj9EzDFRLiyqRpInGFPQukWAD4lLR51UWUWO02JdBh5cp3bql6ZqYp?=
 =?us-ascii?Q?D8F6TitBKJH7ayDkdX0/D/jvjHVtPyyd/8eKHf2I80AVvowjB+EFoD0a/LW9?=
 =?us-ascii?Q?6r54vLIG14/Sz/LpT22s5mF43BLYTFJlQ0zbOAVVVf9k4bXZ3HtsBFQfsNjv?=
 =?us-ascii?Q?FHdt84nKQ72qgUq4ZKIjpzLA1c1i1snZMFQZgtOGRxC/w9c5KKOn6TDbxRvY?=
 =?us-ascii?Q?7QzN5XlejZOswdgXf0EOyl0fyA6ckQW5zsROX5TWze/e1mX0ZADNSI6Nwzpt?=
 =?us-ascii?Q?3Hc3gmORAyJ+7/QBoydwd8EePYZ/TRTcRaCkF27XytAFJEHEHorMntznm+Y6?=
 =?us-ascii?Q?ElaLqjqw3yPTXa3fgv2nxq86aNIfcPB6Gxb629YJhMqIxTw4JB0vtGZtuaw8?=
 =?us-ascii?Q?Dlw5OVUQWAUEarA3U3j30EoSG/Y9xKbiodJQMVKcGy7ofU7KZWqnM2Sl7MVP?=
 =?us-ascii?Q?c5wEDLhwBRFRjurQx3a4NeOyZv7LYmNIcX3j1XUZlPN3zYm9PW8vT4382uJs?=
 =?us-ascii?Q?qiO30wmY7DxEbcoetJLvNs1x/DicNl4/kqZvoZwxypwVGEr1vE31u7hwk+7+?=
 =?us-ascii?Q?th1qrQdWIXkZ3jsef6xO8qqZDrXl///IpbsMXlj2ZgOe96wfOWS328nkuoJF?=
 =?us-ascii?Q?AM2Knbx3U6hv6NBpdn5iA9z55XY76ny2X3utsaIkRZwzfn/e/bn7ed137nfX?=
 =?us-ascii?Q?Y1CHoKMtw7hvfI+0k3ZiDN5zFrHTtGj6JPZWCytjCcJKKpxZaY1F9RElWE2K?=
 =?us-ascii?Q?lHXLxJ0dQhxHdIkH7ZNiQqqyLk9Sgus26oWOd47/Ai68X6M3+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:16:10.5309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce464c95-a21e-412f-d8b2-08dc91444c78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[WHY && HOW]
Some DP EDID CTS tests fail due to HPO disable, and we should keep it
enable on DCN4 dGPU.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c  | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 42753f56d31d..79a911e1a09a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -408,6 +408,8 @@ void dcn401_init_hw(struct dc *dc)
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
 
+	dcn401_setup_hpo_hw_control(hws, true);
+
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 1cf0608e1980..8159fd838dc3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -137,7 +137,6 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
 	.update_force_pstate = dcn32_update_force_pstate,
 	.update_mall_sel = dcn32_update_mall_sel,
-	.setup_hpo_hw_control = dcn401_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = NULL,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
-- 
2.34.1


