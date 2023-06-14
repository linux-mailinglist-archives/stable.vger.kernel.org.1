Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE4E73066E
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjFNR6h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFNR6g (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 13:58:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB83C7
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 10:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0EszGRw/wu8hzSBrpfO3rn4sN6dlh9Mj33Laxbbk0f2pP9lfHBf6aNpCtmPz+7Tk70JlIS300qI4JnEAV5YC74uER9JO77aCMLsOoVAME8bQqvSHFKFka+U4GkWvejWnnogowUYjJ+9N4bgzpphn+rhg4pTiHSGq9LbV2QEkZM5lymNF6jTlv5Zi3mwaY/prB2TxtcrYzDl9GLuIbMQSaF9Gmg7pnD5YVG9+AMeRNIb+WquDfCC1Wo9ZIg2QHaP6vWn54BLs+VrvyoOZe5Ea3PEZMryQhrnROF4Hk+IBDCGXrvXt207ZG2bP1MtXceN63D12BzCl0wmPVdrA2vKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naTGO5HZGoJEKsdODy9Q/eW/W6AP4kQH0VBhyuLH/9Q=;
 b=juEDabYHd868uhUd7mnhBJ2cHCNUemn+hazM+UKKzleEjXl5YyF3J7VZ9uoJq/NZ/lE+twiXIH11kHdg0oUJ/+VEgHrxxcNpD6kd75GY9mgHBq8Oi6dsdKvqqRLkXWy2ioiZfX/H5jUDySkSm/+JZUOQ4Gsyz0mRYOY2dPfKftBrbXRdRxAnrcM1mk5C/036bK24NPeug/h+ZseK6z9LF+M0x2bimEWrerFTjVUi1SqUNx7Fx/wwZs7k3tiD5FNCzkpCaenPb0QSq4+OeI4xZtOIGhS4dQUkrgmWy5o361r4uHSHukghykQsk/D61WFGiCZkW07sCTtMHHyA6DkxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naTGO5HZGoJEKsdODy9Q/eW/W6AP4kQH0VBhyuLH/9Q=;
 b=cwphgXtJUNu48ENP+OIfkfiR9/hpUI5dCNi6MCYS3fe3LFfb5aYfccg+5+WvOaDCFJC1Xl/W/aGN/U7ajBVWpqtHbl548YX6JQPPLFs16tzCgjXapGRH0p6bsAD0R/a3415rbcIpDt8kPO4MFty/2NxDH6sMCM5+gtmUtWT/N6k=
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Wed, 14 Jun
 2023 17:58:31 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::3c) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:30 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:28 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Leo Chen <sancchen@amd.com>,
        <stable@vger.kernel.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 12/17] drm/amd/display: disable seamless boot if force_odm_combine is enabled
Date:   Wed, 14 Jun 2023 13:57:45 -0400
Message-ID: <20230614175750.43359-13-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c30ce0-fed8-4989-a542-08db6d00f684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +C9X+q9rpR97QyuXX9SH2s5gHJDpJuadLLdhboNBhEXuBZC0vGuMKg7lGP8WrOd9gLQhK1Nu+OeL7mHHowpxB74XnSWcr+71FT342LEUoFyPGB9BMoiYap1MYJCt+12tOAKSQN0bzEqMoSd+vTuWYI5HOLUadmcI3Qk9EWjlItOmdQ1lHKkl0vvSWQaFLJVJ44ogtMVfyu6O9oQ6735Rqr52g0NfyTzmQohi8pz7APcNtXTFKhIyihkixtsxDEvJ+HDPIljgtCpKxrH6fJUQ354Un38IIqc7joicZXe32Cl16xMOsL8VnKDnKsIooWKdRKvFhACrcLc95PQgxJSeH6KkXfKzwEhttR0gcbN/TaSxySDPbZDnMaAiJ/BA53gKWG4xyGWrFrnkGL5WKb9UDhVoW9mzr3CGE0ZfHVFXGKnIyPj1GrBCB35bay1MWiSoJaNblh57y0YZljLxSJaq3nhzK4BexNxnHgn1nrYJhzQCv3XoL9KqcGqMPc/Rfe9eSxhTtlnSRzEISoLKuJDMxGeIbNyAeDpi2nJ3rSrhOYl1yVJyESpQHxSd4lOmb4q1hf20rAu7qVLFvIkCi60YMytdBVjgvys1N7gFwuFQ7sFUaFb1z7uf/Cm3Icu9bAE4pGQKnGWTiSnmHCKthUlSst4aE/zeLZVAmrwbtmP8yya8eTIWj4L2GuBlhu3zvOmt0u/y2nz0iLoihZfYrhqbXwZZG37na5k8Tg0RxclDjsvbrjYdimooe6dXQ9tNI1urzK/Q6I8Hoj4x2ViY7qpJqaGyR/6yUWguxJyN5ecr607c+x4ZAknMldXZ/q1A4iJP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(82310400005)(2906002)(4744005)(44832011)(86362001)(40460700003)(40480700001)(6666004)(336012)(16526019)(186003)(47076005)(83380400001)(1076003)(5660300002)(426003)(26005)(4326008)(82740400003)(478600001)(356005)(36860700001)(81166007)(54906003)(41300700001)(70586007)(2616005)(70206006)(8936002)(6916009)(316002)(8676002)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:30.4966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c30ce0-fed8-4989-a542-08db6d00f684
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538
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

From: Leo Chen <sancchen@amd.com>

[Why & How]
Having seamless boot on while forcing debug option ODM combine 2 to 1
will cause some corruptions because of some missing programmings.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8abf060d5917..d0e9ada594c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1629,6 +1629,9 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		return false;
 	}
 
+	if (dc->debug.force_odm_combine)
+		return false;
+
 	/* Check for enabled DIG to identify enabled display */
 	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc))
 		return false;
-- 
2.40.1

