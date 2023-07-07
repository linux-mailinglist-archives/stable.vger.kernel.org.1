Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9AB74B3BC
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjGGPIS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjGGPIQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:08:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D6B26BE
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agjU8f0BjTmO+ega29xKGhnpqGoJieaeaGVZRSxv1SX4Tv+cslM7duIvTlfb5pZrs9qRkdHvp9RarKBs7E01fpNcS860Dq8SCII8BxW/I2g+ERBd2x5/uvJ62jJRq5tE/jkB+kh3V1RRfdy9aknVFn+0OkgEoim8YTLkk8Qn44OpTEIbH5DSR5kZFgr7PGXxLtPF6FzX8Mj9hYU4rh9lAQsPtF8wxOpCF4XkAr1hEgybys24ycOfHT6V5wlAB6wkuyNVUMnl8dpZOphAkpD/yKkDtHE/tX/qpIf/vWQXP9hxNRJjlGbbmAYvzekX9J/jlXk/rdDZHKANDT2M+l4Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2chEtqqPDfyB8aOG+KRuRbHjn8PAk9ujLBgge2fatK8=;
 b=h5gJoiYBx5Q3Dl1VQWvi0dLainbfi89zLaUi/DAOyQyYUfI8k1+Iin0ebvl/X0COX1LVgGPr6Ss5iKnY5Lw2jBBUv7MINWdnBgxBYUKzP2Y+s6u2jlF6+YqIy8frjd9IOkiTu4vXGtfWbd1c4GW+iQGMN6BJJiSNjqtVbZaPk54iq9j+GLeV46LJ81vTb9FclfajUggNnuHWx2kd4w1zL59ek7vmeay+d9LMAKXQUu74kdK/PHO2BWmUBgde+m/4P7ajNMKyPNzY06mgGrWRgQLlikFKVYHdU99q9k4FwNNjdvS9SwD2IMLr/Mlttruxo9J/EFyTVyiNyCAtc/kpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2chEtqqPDfyB8aOG+KRuRbHjn8PAk9ujLBgge2fatK8=;
 b=dDJCBQ7sNjyBYd5tPp7CJf62HOCqCFYFxRRKG/xThF/sn67yjgZvgWEYQbl8zmG+YgVWEzMiNl/MYte0oNYuw5Krw2zuOuuMEgY61XaUbcGZEmx0dxcf7wm3XBBt/kko30gVO7YKoL2zIsjLtqCWQSXN6gbajkFnW82jr6BNTrc=
Received: from MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::15)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:07:51 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::d8) by MW4P222CA0010.outlook.office365.com
 (2603:10b6:303:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 15:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 7 Jul 2023 15:07:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 10:07:50 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     <mario.limonciello@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/9] drm/amd/pm: revise the ASPM settings for thunderbolt attached scenario
Date:   Fri, 7 Jul 2023 11:07:29 -0400
Message-ID: <20230707150734.746135-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707150734.746135-1-alexander.deucher@amd.com>
References: <20230707150734.746135-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c13a43-6489-4ded-9bbb-08db7efbef2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BV9/N8C0+t/1Vyopzcz/r9oYoFAsarKwx8AiufJ0sB8bKHmWlyjN3VyO8s6DbuRSbxQal+DtzZ+gCe7be7F3o5KE+LeUQvQUlcQzYaxJyIYdcC/ijRlBEf1U+WeNXUblOA4S2tQLNAVJTKqDlVFppYQbWQ34JG7PIYxW9hyAKjaPXxfsoytTVZs2jJ8Hdz8ltSHcsEcko+4qg/CM7h6PWxFN4alvjyFJlMXpEwmam4RcB+WLRLywyMM5V9wLiYu//cYSgtRvxTk4JeooEC3SEwXqjVnbOBoXrMk0ssBNomB32XF3CqWumnxxCXOU3pCws/hcO4MSoFSrjsx8nl1WrG7YUqHPKRUFk+DJZkUSJ1va3/K1fFCFwn7fpEwZfbN/jMucQwpwzgGwrkY+fQ2HDarPasDEE2IJb2X5R55l/Nk1T5fmeEtZmojL7nGTmg+qJBuNf4i4M5NMgJVVl6fjlxtyRBnjAvXcZ9lBIOXYVVvciJzzd0fhmIKejFHs8qK/hLM7D7/Ihknz+WFmlKI7o4BguPx3zBda2DmYXJYniLDuOhTdFKWecYTEw5QkDVyU6F3M/ZRd8flf9L2PbvXrL2qFXG/81oxXrwzhEkJAf7qhexSwoLkVzFDgAH0OBf4tAy//3vDCtlToPXO24k4Xb77nzCwIHPDB1yVKrrlUcpEokAk3OOpTGC1rWk2dLizh3J1NqT0wwz6906H+7RnUDZ+ehDyuu6DtmvZ0fFbC+T2UQh2v9T/wWTzXcKhzbakj/Nq+6AMgaXj683JkpBYDxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(54906003)(70586007)(36860700001)(47076005)(2616005)(426003)(83380400001)(36756003)(86362001)(40480700001)(40460700003)(2906002)(82310400005)(16526019)(1076003)(26005)(186003)(336012)(70206006)(81166007)(82740400003)(356005)(6916009)(4326008)(41300700001)(316002)(8936002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:07:51.6063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c13a43-6489-4ded-9bbb-08db7efbef2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Evan Quan <evan.quan@amd.com>

Also, correct the comment for NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT
as 0x0000000E stands for 400ms instead of 4ms.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit fd21987274463a439c074b8f3c93d3b132e4c031)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index aa761ff3a5fa..7ba47fc1917b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -346,7 +346,7 @@ static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
 
 #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT		0x00000000 // off by default, no gains over L1
 #define NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT		0x00000009 // 1=1us, 9=1ms
-#define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT	0x0000000E // 4ms
+#define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT	0x0000000E // 400ms
 
 static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
 				  bool enable)
@@ -479,9 +479,12 @@ static void nbio_v2_3_program_aspm(struct amdgpu_device *adev)
 		WREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP5, data);
 
 	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
-	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
-	data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
-	data |= 0x1 << PCIE_LC_CNTL__LC_PMI_TO_L1_DIS__SHIFT;
+	data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
+	if (pci_is_thunderbolt_attached(adev->pdev))
+		data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	else
+		data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	data &= ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
 	if (def != data)
 		WREG32_PCIE(smnPCIE_LC_CNTL, data);
 
-- 
2.41.0

