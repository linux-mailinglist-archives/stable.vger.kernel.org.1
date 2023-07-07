Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006D774B3BD
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjGGPIT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjGGPIS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:08:18 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB631FED
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7UPzM1RA8LWFKxGMeZr1EQ6a7kCXAw6xrTCQFX7Ec3kiTNe0ZZVw5sZYGCzWZInT2qG5eFpIs1fhog1cDMgwfreta/SCUud8EjET+kQFVXwzoLWRKvSiSEJPH9r3gjgCsFsOnC1k9nBmivAJdwydJzpKtnhywV6AERVpyPMV2KrT5j5P8nC+h7XtlHUwrhAW05D9kAbIgHg/ZhsvRVyp2ZLX2hVUdBEHHOdTNS6fKjafm/2c7HDJH7eV6twuxLcAFA2GjdHMcXpwi40+y+Ib2Txbz+Jl1GJ1l90T/Q9PkYaSI+0IDkb3juqTQM6cBuipoZ0seACOgHXGFvl8/CJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUCUR4Sm840KsDdfaS9gKyb4ZQ9o9YGUk+E/F3zy4kc=;
 b=NMK2XwJZaUV1HXLkR48J2LYBc6x+7MfGwXb4DGYE/3+dtOnVBD3pGKd1EOTN6fNsBmy2+CW3amxXdwoyXrVNnl76aVIAUw5UEMXBKOioJHn0Utk1y8mRwtxN51YTRAbcFGFkNil+WBHONT2Pm50y1VZprHaQ/0nvEmiPGX1Beg9G39YnThGwdmOTPCSvbd6vxOvJ2h1ECw8ybt3QVb7ZaosFCyzmha44t9bIUjHZPY2Tu5Gpio3C45ruZBB03HbebwerCYHDNZ+peARrDlVgr7GHrmRym0AR7AxXqCHoX+tM3e81qUFz/zlirqf0quGyYfWSjky8muPFeJ/qVDLPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUCUR4Sm840KsDdfaS9gKyb4ZQ9o9YGUk+E/F3zy4kc=;
 b=vHEf/hUg39pxmC3DBGaMSvSFWKRB9SHhAWgchozdctsqRTZY4dC1a5r4LXxP6+XKFkN5jy90j/zaHrgXeS0AMHnIpbm3505Ud1tnyVGCU4URlk4DWEcyLUllU7c+CnnRraepLs17wW1f2VYDNYjMiwKUW1qIMwq22LvoDYbYPlA=
Received: from MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::31)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:07:56 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::d6) by MW4P222CA0026.outlook.office365.com
 (2603:10b6:303:114::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26 via Frontend
 Transport; Fri, 7 Jul 2023 15:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 7 Jul 2023 15:07:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 10:07:53 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     <mario.limonciello@amd.com>, Filip Hejsek <filip.hejsek@gmail.com>,
        "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amd: Don't try to enable secure display TA multiple times
Date:   Fri, 7 Jul 2023 11:07:34 -0400
Message-ID: <20230707150734.746135-9-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac36f53-5c15-46c7-857e-08db7efbf1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWrl6QDsvu5C6D8AMVcyaRb/nF+0Uo36EeLxW+P174kXB/E3asgx2GCzZxo7b6H83sNHpe4X6KSscpmeIDu57BIc2fpQUAAG6l5eGFTpM/uMHkOUtiDsezyS0V7jWOk/d7Q1YkTwQghVtTAiU5DMrP5c0GPUaMKc4W30nPAwbeiiFfMEyvco8DAwAAbXCQI1gGlv5MUgGW6xACoqZautwgbvTrf8gCQKXkPXrvjLWHRYMeya/hZaYNy/YFcoWU1c7x2ZggxoD8ZhXPGh98GMts877dGpwmMQ84jl9kililJ6Ld2hHoq5jzKxbxQtTISLjilf8Gh6RlA/K5ViDWu5xBBtJ1CNwx9vg+t9K56Lxxhxqu5A+W3PwoFahjUP5RNu31zwX/XlzbF54at4qRcB2rd7y31donouNWXJWgaXcx7xxJuQYNpa7RORFPEAqWyhrSD3sDV+2Y2CihTm97E4zUdyuYoJfHXtWoseiHZMoEPgQjxszyNU9gq0Bfzi+kmeds9C72yRJ3etZNyrkrF5iZ0UR+EfgnOXqc3j3uJfqlONkPEgQpDyFduJfxEYWDtU15yq7b38ykMA+j9nWrsdHE+sLEjHcp7wpet6fl6XVfptx/saSy/xDUoiZRIAwZFuSEJwojycRIqwk/nnZqQYJwWr4Lyvj0mKJrNDzKZvqmRZOZCoEIrMAEcQ71vzMiq9KVrQK565rakJsPh/vdT6IgNx68xg/6wbIWHtwLq+1sMZ2Wi8Cl7e5Jf2UAXXCCaw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(83380400001)(336012)(426003)(47076005)(16526019)(2616005)(2906002)(36860700001)(6916009)(4326008)(7696005)(70586007)(70206006)(316002)(6666004)(54906003)(478600001)(966005)(5660300002)(26005)(1076003)(186003)(41300700001)(8936002)(8676002)(81166007)(82740400003)(356005)(36756003)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:07:55.9967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac36f53-5c15-46c7-857e-08db7efbf1ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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

From: Mario Limonciello <mario.limonciello@amd.com>

If the securedisplay TA failed to load the first time, it's unlikely
to work again after a suspend/resume cycle or reset cycle and it appears
to be causing problems in futher attempts.

Fixes: e42dfa66d592 ("drm/amdgpu: Add secure display TA load for Renoir")
Reported-by: Filip Hejsek <filip.hejsek@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2633
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5c6d52ff4b61e5267b25be714eb5a9ba2a338199)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a150b7a4b4aa..e4757a2807d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1947,6 +1947,8 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 		psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
 		dev_err(psp->adev->dev, "SECUREDISPLAY: query securedisplay TA failed. ret 0x%x\n",
 			securedisplay_cmd->securedisplay_out_message.query_ta.query_cmd_ret);
+		/* don't try again */
+		psp->securedisplay_context.context.bin_desc.size_bytes = 0;
 	}
 
 	return 0;
-- 
2.41.0

