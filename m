Return-Path: <stable+bounces-5244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D23280C11E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 07:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6534280C81
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 06:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910AC1EB5D;
	Mon, 11 Dec 2023 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0qAwz6DL"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13BDB
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 22:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaJ/+5VtnytUAZaLlc8nDQWRvSfw2bch5yZe+PQWxQ10elZ7qVcB4tFmzsE+1soTweTODfnkHRxrV3Yah5MVXYHKredzWgw3/J0uea/T1tY0oaQpd7Tq1owUSAiJMW4DnTJqIAzdZl63p1sXGzmP+PQDHmW9yzXh4L23SZlgMxVG0r2HhvJ30lNoe9k4e/tnp+mG83pTtg/Ddr6TMB2haLEndEznATb4bB44c44e1O3vM786yBAh0ydXZHC8dhb35MVFvp4ZiFjDc9Zek4dBpgEfRzoxWbJsDPgyDwtRhCfSfQuj3o3awVwnSGGIqR8bm+SMkOXYbrMND2LX+X/3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VUE62sF6BH8p7j/1kR1wAefyWKM2H7xaC/+/RMOeHQ=;
 b=nGf7H/GBDGkk34BGzNrZ0d2CkByvCOdT/urmn/pDqNuRD1dyiUzUWe20lXjfLpVu9ruG4cVwxfheDl54IuO+5Df/BOr0mLHwTzwI6ikQfxe5/+1XNaHrlGfoPqWM56cfdJducpWHcsw8CeBywjttQsuamMbj+XC4Bs4+4dmgp+/VC9hGrdbxrkz5FsL8qVKmBMF5AomONoYzdMHDQrRknDDniseAaNsa/84YNJEGUmabWMBlI0IB04pB/kkIJXdGe13Tvd8J+1XXbBuaArXJgaE86fmxeSOgEzZ/i0NIwzbSfO0XF/0DbF3hFG/xyhsHzQc05AKQudzohcOXjMivww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VUE62sF6BH8p7j/1kR1wAefyWKM2H7xaC/+/RMOeHQ=;
 b=0qAwz6DLAGAe5HdqySqXAy2EZaf85hRL3t2kgnhZmoTuJzihnCisOFMuO2D7mJScgeYBnHZ4Tui+ihtCR/IKaRtq7jxNxYAVB/dMGpnCWUsJpl872rtIziQ/kNR4LogTSPgZi0pqsrG+H1Iyv3AdsDsQN40CvsNi33vB0k5ufJg=
Received: from CY5P221CA0160.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::12)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 06:04:53 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::81) by CY5P221CA0160.outlook.office365.com
 (2603:10b6:930:6a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 06:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 06:04:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 00:04:51 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <stable@vger.kernel.org>,
	<aaron.ma@canonical.com>, <binli@gnome.org>, Marc Rossi <Marc.Rossi@amd.com>,
	Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Disable PSR-SU on Parade 0803 TCON again
Date: Sat, 9 Dec 2023 14:08:30 -0600
Message-ID: <20231209200830.379629-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CH2PR12MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4a21eb-d384-4a15-53f7-08dbfa0f177d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nAfsyHUFCwZqY9tvYt6Te6PR1Q0W7cwuEInwYaAwjA/MnJB4FF+t1MZAMRy4GWi7WBjz9vOY7wshQx398FhS2horEVHWjQTy4/JzbeL3X9XeS0wN4A4QWeNIilXPdtPiA1G267HVeVMIxkM8pMY/OL71MfSGL0aC1MLgppjMdSu/fw4uWpop6BSTB52KwkaXrU/zmD56PwV9QVwniwf1VH4Jhvl/1bUlUOJDKzzW5ih96kzEMb97ae4tbyI+dd1R1LMrEO0dY+4jq1sM3LJtHPyBC8x88T+mmebuzyWKm3jknCdcirEcfDRy3pBpXUzYwvoppMN3Pvoi97eOSYNbFsREf7ZJbAd7geyg+rF4gqbMdFyKew4nZFiDWq7KW5cpMn8v024rspHe9GK2VdN231juiWpW8qGoflERTKbLtRJ2pqeWbro/5+8D/ORf/uPVhNHoqgpe9gWV5vOps0TyFd1OI+Z4HbkdqwM+yA2pwM90Ah/A/G6w+GLWPbFECGU31B36oFfmlLbbq0wqP5wxgmij5sjK96IcM7jfgqrKcDshJvlGPvDeUrW3M2bWJZh3ar2h3qIwQ+ellOhcOVQfZ5Qjatqs7dpJzF1uCDZ3xHe2yzl6OpQn2Nyfiv021hxgwkrZo3129Jyr60fj1sww84CytD3z+/WSKsJ8e3qBVdTQdwUv5Au6Q11zDvkxvsPmlIUFAdXbEXszpdAaGebiaqincp6l2Px08qJxxo+1hTDiegYTary1L5MRBN7/Md0UyAVjgqRtF4YVO7oKYd1OgQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(46966006)(36840700001)(2616005)(1076003)(36756003)(7696005)(6666004)(478600001)(316002)(70206006)(6916009)(54906003)(70586007)(8676002)(40460700003)(86362001)(4326008)(44832011)(356005)(81166007)(82740400003)(36860700001)(47076005)(8936002)(40480700001)(426003)(336012)(83380400001)(26005)(16526019)(5660300002)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 06:04:52.7506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4a21eb-d384-4a15-53f7-08dbfa0f177d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
X-Spam-Level: **

When screen brightness is rapidly changed and PSR-SU is enabled the
display hangs on panels with this TCON even on the latest DCN 3.1.4
microcode (0x8002a81 at this time).

This was disabled previously as commit 072030b17830 ("drm/amd: Disable
PSR-SU on Parade 0803 TCON") but reverted as commit 1e66a17ce546 ("Revert
"drm/amd: Disable PSR-SU on Parade 0803 TCON"") in favor of testing for
a new enough microcode (commit cd2e31a9ab93 ("drm/amd/display: Set minimum
requirement for using PSR-SU on Phoenix")).

As hangs are still happening specifically with this TCON, disable PSR-SU
again for it until it can be root caused.

Cc: stable@vger.kernel.org
Cc: aaron.ma@canonical.com
Cc: binli@gnome.org
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index a522a7c02911..1675314a3ff2 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -839,6 +839,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
 				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
 				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
 				isPSRSUSupported = false;
+			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
+				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}
-- 
2.34.1


