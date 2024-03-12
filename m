Return-Path: <stable+bounces-27438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A98A8790E7
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 10:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60735B21EC1
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 09:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D975478B44;
	Tue, 12 Mar 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E9SdZlf7"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D277F25
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235386; cv=fail; b=MyRWbSXmdd7iabFe4xkPP7y4bl70pCyxL5qMEGMJfOrYGEUJUaLIefbufGSfKZRCPXghgEdMDq+wDzGQGOU4Xw1GIvIYwEBPyUZkpgsSNPPZPRABXzzSY4k/vg7aFM1jTybTMW4SHVevPOOhrxyLH/yzj8HVIBzJ4OhQ1xF3bQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235386; c=relaxed/simple;
	bh=xh+XHp+T2MKTRhxpD/4+5PMSz/v37IF5pF4ElsQStSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0TDmnmD2VMm8o43nc8d3vU7+0OMgY5F77LJtjXnvkPyxYGpAIKhUR2h4z3q+PH/VcO9KRrLuembL++2cwaRj3LNnihwKVgt+RI92kpckugicZrClEdoMZoSbSabrxcEh3If8YxBDbjeYgw5TCwxQEZZalXijrG3hIad/8E2/LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E9SdZlf7; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6OwkhfDyrPCrKcJtvncamjcPzTxhEAEoZef53982IKFrHRG733zXjlb0ilDQLk0C0SXeExAFfi6xCOSMOdmDG1JpCm4kr7tutPwHO/z9NVhqvnF1Q9rLo7AQBmJ9YVMA6XzsyMxuY4rGWgfimEw/dP5Ig8v+nhvsC3kKju9IoQG0Lgk3poue2xYUtZHrvwERcFiESSeuFeVMkrQrMcNPIz3MLw9xwW94BMFbE9jJCwYu8aXTlCnqTuh0bVKks80LuOozapFIQhdjkJLcGtCq4nLORY9x1AE49CYAupmiSyuK/lnwt0M8lfnnP1QiTfCgNiPvmGnfMs+oF7kkR3o1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkZNZgb6/qbwz4l54OQXGn7q9xCsXeDa2Q4Peu8Gmao=;
 b=cklhZe4SVmHiYvrF/avM5zuS1kjuqximxDs02cPVb9bgyJnb0ETLiDabua2PGRxnBRzgf49HaAx6xB/T7caTHO9nRtKaCRvLZRohw0VgepOcQB+k5XXBkOLHOH8So1pSnTqqmBgbn3vwF8csNqOxWP1CpDg97hiCg7Sax2efCJIMDwVeUh3zA4DmQn2yRb05E30YV2wvgeheW63lh3O/dViscPuQnaVT/3/NEb2Bp8QcrwkKz9JV8EcFdoFuEZLlE6dQ6F/StynJTGHtDg7eiDy9Hw91NZSnLXNXzW7sib+jtcyCVrAejqpliGgOrHYwVo7qDZvGHtoBLTtcZ4BSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkZNZgb6/qbwz4l54OQXGn7q9xCsXeDa2Q4Peu8Gmao=;
 b=E9SdZlf7XH9I41rgLvhq2cEsy18eHxbjLPecq6/AaMbgTzoSPoX7LxADjeoZIsYJ3iVfS4F1FymkLs6JPioWUTIhXy++lNre/y3oLpAAksvqWy1qOjFbJfA4A+w4oazNRwAHWfwcxFVqr93hCTIbbdC0lu3Ofggwy8b/Dr+MlzY=
Received: from CY5PR15CA0227.namprd15.prod.outlook.com (2603:10b6:930:88::25)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 12 Mar
 2024 09:23:02 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::ec) by CY5PR15CA0227.outlook.office365.com
 (2603:10b6:930:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:23:02 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 02:23:01 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:22:55 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Ovidiu Bunea
	<ovidiu.bunea@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Charlene Liu
	<charlene.liu@amd.com>
Subject: [PATCH 20/43] drm/amd/display: Revert "Set the power_down_on_boot function pointer to null"
Date: Tue, 12 Mar 2024 17:20:13 +0800
Message-ID: <20240312092036.3283319-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a8555c-f474-49e5-941b-08dc4276043f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7lFQ8zI296vvqATK+E2Q4+m+uFjyFpY0R7VTj+cCKFkTo+KA/YiZkHEDPSKKA4Z4hXGbyMeDR8J4UaGttSVbnCjT608JuC3xcgHADIwJMNqJLJrFt6a3hzrLSjiqldpo+eCL7R9AefoJLr+/kanvhXMaSmrQGTPwILrsR4gBP3GVtFeuWKhHrcnWtYjq7DuUlxOOtJiO4xTQooVqjz2mNof9jURXqdgNFZQDHF4GEMO5/q9NIMTBwM4V76s7LGLnJtY62l4G0KZGxhr5XC5xYx+Hx+YwtW0J4anhKKyaUKtX0jIyQfRD6qEe2gRn38LSJElIwg4MP3WJ86GZ5J0PZYMwlVHzkPfs+kYN5hTOmlvjeZUD2XaGgwxyrkL7bGFDyadquQXaaMJyvX5pk1D9VJfd8K2vfwuRgi/oenXE55p2ob2G2JV/4QfdDpKf2jRXa4j7oKAkmu3hOiTA4sufhf6u80WeZO6de3PuacETQz9dgZkdFTt1++1H0984rltGdG0yyysKXx6E8BrzmFMVgI70s8F4gbxwqRQNQwpX7Ep1dL0o/X2WbkVXWI/5KEX01zgFmazkW+WNsjhdEvEkUWmiCgdTZYS4x0asELOLucpWGfitracoFRWMrp2Czyeev3P58d3iIiCRkJdyr5b8TzJKFwphGRGgW5qlOnVdqxrRzO/yuZHzX+inVepSvnZes7d4v4xQi54Bt9bsDcW8EjcjbvbETE+hOnxSKjwg7pMiC1N3sGQg7ZTJa6OrSP0T
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:02.3523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a8555c-f474-49e5-941b-08dc4276043f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

This reverts commit 1b35616f8bdb ("drm/amd/display: Set the power_down_on_boot
function pointer to null")

[why & how]
This commit breaks S0i3 entry because DCN does not enter IPS2.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index d4e0abbef28e..dce620d359a6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -39,7 +39,7 @@
 static const struct hw_sequencer_funcs dcn35_funcs = {
 	.program_gamut_remap = dcn30_program_gamut_remap,
 	.init_hw = dcn35_init_hw,
-	.power_down_on_boot = NULL,
+	.power_down_on_boot = dcn35_power_down_on_boot,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
-- 
2.37.3


