Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829246FE9D3
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 04:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjEKCYX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 22:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEKCYW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 22:24:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B0B3593
        for <stable@vger.kernel.org>; Wed, 10 May 2023 19:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+c1GdVBYRW61g41ZFI9rkyHbzcGR7UAMfTl0kih2oGqhmIGzam1Rk30EycIvtMwPe3DjQ4LXxIKPLASc84ZsKkZjQRLWj2iFNnqC35Bg2w4TBWSyHM8+qNi32y6KlK+Zv9pZZ7RrSp7b1/D+KNC0cWzecDozbiCLFDYJyGiJMr9MkuMIssTRtg5OAc9wLlj4Zn40xuD5C7R33LQESGpKRxhDaE8wm2kVedJyuQlPWxkPKZwFK1CWdVRrbY0xOj0De3SjAg2FrSjt5pFjoCR7/w/DeGzlYZTR39ThGc5q+0CaR8sapfnHhioCFeZqxNLv2+mHOX821KqIzyCbmt2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ5bt4SO0efLz5sH/v9OO18wvelf5vXM72QU7HyDK/w=;
 b=O2E65wY9Bx0h9WVFikpjo+4uN0W1KpgX7l+9KhJcOpB/8mbWxTXXQPU9bf3ogbPNnZHu41YBKiCIaWgQ1LLSSyGyUcknp+ZJNIJVJbeYwIEftlmkXf339v3OHqO/2pYl793HD/9QxPn1fR2R70CWq8Dy2Xn3jdasheu6jKv0zqsw5Ubl8FSSqoNE9K7O/J+IiGwyG53+yyREaFWuQyOsta1ACukoWAlyB9TeUyY5Vi9RGytiuj5z2IDqtxFixJ6inI4wkEeaEAkF8F0rq6hntqx0sfUN/N4rDJ7HmtZSzXSDp6ebQRQz2v/wHHZeSsZBBQeJcF6tS6d8F55JURwWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ5bt4SO0efLz5sH/v9OO18wvelf5vXM72QU7HyDK/w=;
 b=1IUWjOJ+DY9+u8GNuYx/ZYnCYdzBvam9ApQlgUDq2rEv8d281uOSDLNcgd3X9gkay2VYg3sqcLODhauBydmhvhkZhCr73X2H/jRWORRpvGHM0DXOFvV7cyUGF7aRdLZtx/zU0N1libdjw0v75R6Dg5Dhr4rCA1U6qOKuZw+Ko20=
Received: from BN8PR04CA0022.namprd04.prod.outlook.com (2603:10b6:408:70::35)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 02:24:19 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:408:70:cafe::12) by BN8PR04CA0022.outlook.office365.com
 (2603:10b6:408:70::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Thu, 11 May 2023 02:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 02:24:19 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 21:24:15 -0500
From:   Yifan Zhang <yifan1.zhang@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Alexander.Deucher@amd.com>, <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>, Yifan Zhang <yifan1.zhang@amd.com>,
        "Yogesh Mohan Marimuthu" <Yogesh.Mohanmarimuthu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tim Huang <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: change gfx 11.0.4 external_id range
Date:   Thu, 11 May 2023 10:23:33 +0800
Message-ID: <20230511022333.1977681-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: fe853044-714d-437e-1be5-08db51c6d337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7ZK88LjzV9ORIbuFnO8/EhjJApKVSAjhd4VzmJ8fly1Ok3cVhpyWzypnF+3qEFZKRsf2eGgGMdmcNkU5oJdS1yVDfJWezL+U/lnq0UCM4mPpeq/N/xpnjj7Dy20WjZkFGjoWE3Czw/PRTieB+7o7qp3qEsgy6Ib0n9tH4v3rcX8qijZGr76oPPWDUcJdG6rhLnsJVGByW8bEOo0Dq06+ROJBZ+HXHyBdEA+qNxZ/MiFM4ixr9Qm8m7GA5CAhsje/ROZjAiCanww2LDLI0ie2uXWJ56xMT53Vcu0InjPIcDZ6rjktIusiRdrsx+YdOgbdTb7kcfPl/N2fcrFudgzaPvKdlrWxUaWtoc0LcJ/2Io0mde8rYrgmtf/74UOgqtBku3bT7s/4Ltjsz0JsZr2FEmRXF4QSpLtJem5Tkxjhb79gnyOqO1wWaaVZcy8NX+ZvXX99wLdqZH7xScSrRBEii/ysQFBXNdCO5Hvf7U9GwctXczwkva9fYYIXQgUtPphxQCcZr8GuERXX8qSRf5xhFJsyOtlgo+krUpdhFf6sHWnUZTh4l7mkRu2GPcWcSaNVEszjficZ9Nb2bRdd+oQVxjImwZEbO/EC19sIATtemXKp+IghPRtC4KRnYpzEd7mKU1UaZ+jqRGcgyb0CiZMSoR2dDCWAslJ2mxeSL/aI3vl0M6r+Ggh+r3Pib0baR78nW5ER+5UUdLRRIGqNCNRRz7nGUux/YqY2EMW+PjL07wb+V+OUALe4JzULghtsMz1McI4CSwYi/ePzLGyjFlvRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(4744005)(356005)(81166007)(82740400003)(36860700001)(47076005)(2616005)(1076003)(336012)(186003)(426003)(26005)(83380400001)(16526019)(2906002)(5660300002)(8676002)(8936002)(40480700001)(478600001)(36756003)(316002)(54906003)(6916009)(40460700003)(4326008)(41300700001)(86362001)(70206006)(6666004)(82310400005)(70586007)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 02:24:19.1567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe853044-714d-437e-1be5-08db51c6d337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

gfx 11.0.4 range starts from 0x80.

Fixes: 311d52367d0a ("drm/amdgpu: add soc21 common ip block support for GC 11.0.4")
Cc: stable@vger.kernel.org
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reported-by: Yogesh Mohan Marimuthu <Yogesh.Mohanmarimuthu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 0f82b8e83acb..6bff936a6e55 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -711,7 +711,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_JPEG;
-		adev->external_rev_id = adev->rev_id + 0x1;
+		adev->external_rev_id = adev->rev_id + 0x80;
 		break;
 
 	default:
-- 
2.37.3

