Return-Path: <stable+bounces-10464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF0682A3AC
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 22:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B4B1C22F36
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 21:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5C4F209;
	Wed, 10 Jan 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U/MFNt7T"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C38482E4
	for <stable@vger.kernel.org>; Wed, 10 Jan 2024 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLf1uMSW307masuRjMnq5sgr+CpHz3JRpHhYOJ+fBI8b7b3Lvmwf8ugObyTvJ2DlL3FNubf3j8rcXzm0K86y/l6WwGOxZ5ZI4iLAhhg/E/MQ8H68OQxFjjACrmnNhacrGq8wWv3Gof37zbQhCYL9ov1+OZOhmn7VeHJ6OtN0z3RFRdJvLw70U8I4OQfjkjrn3r5WLYdkeqXeE9h027fWS0B3cCammffvRzpNKHwlyo1gHB4bmEnkGKqWqhRf0hSG/lV17NTSZq6lkp6rE/XF67m2FNXKxcnPLoCY5HqIgdhTU7VziW+zYIGI8G6CG+VheEaF9FCSJMacOVTKhLFFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NvRxj2BB8adILhgiGHG7gX7fZp5nyRslpYlPQvQtgg=;
 b=ngpd6IWVSenIMbuZw6ygreNxRpcxMQP73lS1HcXz3ROAdCg1zA1zw8C9J7+YpkEf2Vh9FxZnm2Jpu8jJeHSdk71bREEf1UTAP/yny9b57HLrhi1+ot+t+TtYp5GwfUisdXg8QajXGzQD76fnNIqCA6rXjcVXPQl/COb0VhA6OJXCLsYb33yDKSZwTfsuH0nGa0FaqTYWPewluTxFqSnNV2D4fOJlFCIc2g6bkBxTg5aNcnc8Ni5IqgyUbL4ynRRfFxSukQvnCo0RrC/B+wWj/ZY/REP1XUJdO3Buw4BjEmHjgohuh3E51HXiU3oGwokKp/r1LGKUF7sAwaUleLqJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NvRxj2BB8adILhgiGHG7gX7fZp5nyRslpYlPQvQtgg=;
 b=U/MFNt7TANeIAFQ2CeQA7yEKYKZ0bNb8tdJft7gfCoFHel/p84MCgp7bMQ5Y9vmXLC14rfMj3rBruhDsUcDEyWsjpn2M48SmoFfF2OhGI4UY3df7uHoXO1rMtZouwcIkXBG1m6E67b4N8pisD3IsTEA4mM4AaBG2PQzIHLIBYV8=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 10 Jan
 2024 21:55:41 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::5f) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:55:41 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:55:28 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <stylon.wang@amd.com>, <agustin.gutierrez@amd.com>,
	<chiahsuan.chung@amd.com>, <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
	"Ovidiu Bunea" <ovidiu.bunea@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, "Charlene Liu" <charlene.liu@amd.com>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 08/19] drm/amd/display: Fix DML2 watermark calculation
Date: Wed, 10 Jan 2024 14:52:51 -0700
Message-ID: <20240110215302.2116049-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: b1aad934-585e-4641-59c9-08dc1226e354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kdmWMq1vC6fVstAPEvfVa403/yVnRjBv+CE4hcRF2LJKevyB4Pn6p0dAYmuOfI57g3fyDhVvi1wk7s/+7HCMSlnLLESR+httdtO0BRjd4h8qZ3DWdtzv8cbffgk9gEiyOZgLZLps75Y9lJdVLxkVvRWUsZMh4ZvavDNTRPnqzg1tRQyZHmWQhIUWsdr1jVk3CRPfCuomEcVUMaZjqGqzV14YjQC9zakWtQENr550kgddqbqg2aFTI9jQ0Nk0PjKjOq8L/rXimSaQd9lHnxLOhfILGpZvpJDMiaLG9wzA8uBmY3xP0cJBABfDQK4HFYX6jgGCroxIciK12n2bWutP/4M7dXFyNW1boSy6JBXH9ieJowsGSpWKMyBK/VqmeKk93XiWaxzTKTY3X+bN8QDJQPh+79+6A4r2190wvmp1ATV2ERBAGXUfwrb9xFbTO80U0KqOgN1K7A9aWIX9oymmBq2lU/13WwAA1wZBZ46FIXnRYLWP9pPcjhZmKX7eaksB5uOEWa7gsCI3f488gIEo3noLCpeHIlipJu17xCbsqxBGTjdyUo5B/2P4jlUkzq8mFqy01xVYWxe/AfEVNeH1GVfPuagwm/Ja8SAUItQbLeQaYA2E6QiWQPdFZCS6ivsSzviC2HfTk7raMPYnhmsbdub/UAqEFpB0x/+9k/XLKGFWBWtmeutJid6FYqiGSsZz//ye8m/m1cYqR4+v9JTJVEYCa0poPN6S+Qlpkl0utijPORfTrEd/qojK3uyzousCyRTLXEFrnxKGOeYevjZ+uE1uTynkDxIg3sCHMW39Vfs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(41300700001)(83380400001)(336012)(426003)(1076003)(2616005)(26005)(36860700001)(47076005)(16526019)(8936002)(44832011)(8676002)(2906002)(6916009)(6666004)(7696005)(478600001)(4326008)(54906003)(5660300002)(70586007)(356005)(70206006)(36756003)(81166007)(82740400003)(86362001)(316002)(40480700001)(40460700003)(36900700001)(44824005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:55:41.0374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1aad934-585e-4641-59c9-08dc1226e354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[Why]
core_mode_programming in DML2 should output watermark calculations
to locals, but it incorrectly uses mode_lib

[How]
update code to match HW DML2

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
---
 .../drm/amd/display/dc/dml2/display_mode_core.c    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index a6b938a12de1..9be5ebf3a8c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -9446,13 +9446,13 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 		CalculateWatermarks_params->CompressedBufferSizeInkByte = locals->CompressedBufferSizeInkByte;
 
 		// Output
-		CalculateWatermarks_params->Watermark = &s->dummy_watermark; // Watermarks *Watermark
-		CalculateWatermarks_params->DRAMClockChangeSupport = &mode_lib->ms.support.DRAMClockChangeSupport[0];
-		CalculateWatermarks_params->MaxActiveDRAMClockChangeLatencySupported = &s->dummy_single_array[0][0]; // dml_float_t *MaxActiveDRAMClockChangeLatencySupported[]
-		CalculateWatermarks_params->SubViewportLinesNeededInMALL = &mode_lib->ms.SubViewportLinesNeededInMALL[j]; // dml_uint_t SubViewportLinesNeededInMALL[]
-		CalculateWatermarks_params->FCLKChangeSupport = &mode_lib->ms.support.FCLKChangeSupport[0];
-		CalculateWatermarks_params->MaxActiveFCLKChangeLatencySupported = &s->dummy_single[0]; // dml_float_t *MaxActiveFCLKChangeLatencySupported
-		CalculateWatermarks_params->USRRetrainingSupport = &mode_lib->ms.support.USRRetrainingSupport[0];
+		CalculateWatermarks_params->Watermark = &locals->Watermark; // Watermarks *Watermark
+		CalculateWatermarks_params->DRAMClockChangeSupport = &locals->DRAMClockChangeSupport;
+		CalculateWatermarks_params->MaxActiveDRAMClockChangeLatencySupported = locals->MaxActiveDRAMClockChangeLatencySupported; // dml_float_t *MaxActiveDRAMClockChangeLatencySupported[]
+		CalculateWatermarks_params->SubViewportLinesNeededInMALL = locals->SubViewportLinesNeededInMALL; // dml_uint_t SubViewportLinesNeededInMALL[]
+		CalculateWatermarks_params->FCLKChangeSupport = &locals->FCLKChangeSupport;
+		CalculateWatermarks_params->MaxActiveFCLKChangeLatencySupported = &locals->MaxActiveFCLKChangeLatencySupported; // dml_float_t *MaxActiveFCLKChangeLatencySupported
+		CalculateWatermarks_params->USRRetrainingSupport = &locals->USRRetrainingSupport;
 
 		CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 			&mode_lib->scratch,
-- 
2.34.1


