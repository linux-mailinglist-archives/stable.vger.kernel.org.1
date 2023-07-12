Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDC5750F47
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjGLRHN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjGLRHM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:07:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29D1BFA
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WE6IAUfziIlAa4hoaSoDxGFjpw3OhKRWXEjN+KtxXaX1wLKun9161sdJoP8Hbz1PUAKSG4mX6uWoZKw1EtRVTB9ql+Ju/nmSLYJBh6JCrJOn9OZNBGwMen8eHGv00lAPGJxXKnZbWWcWvuEwnyzc5DAAPhBNrgOu8TYjJ6rKPYIkT4y7p2OFTEXgkAb+4LcxLNvmtyPO0EskKJMILeuTDIrY/b7xoZkcV0avWASsEyWIxD/iazpZuzA875WeTM6a7T1x04XMZ9YsbCa7serJ/pFnYpM2D9U3ZI8x9ww1tI+gSYaMqilqm88uYgHKqI43W3249VShAOe4nFHOHbWBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6OSNH56fTgBhP2PHB7npb7IGOW25UquDK5/8FUOVoc=;
 b=ZKTHRkEsmNMnYFMEcyIobhZIO8O37oMdCymlpFGX9AP2nKB0v51+pKz7hhDKD12NeEX4tMfTUedcYLKxJphbzg7KHM+qIlYnRJkfo3W8NWby7zjpPZxqBJeIcg1TZH02/s90b61Vo2aKYNEzx0JfADJFPwrf8b/1c7toScmpl9+yCcsg4AXogUqw3yYBPviXgsVjgDR42w8vfLFvrHAoKuRP5PX1q52Qg6vnF0zVtNSG4JbLu3a+tNxhNy8asw3wazpSxfqNfGzgwc1lhfnT+ZFMHRVoP81NzJ1qucDR3qdEgdQ76qym+giy6X/uCh5+zJq1V4x5D8lpAdrfKTvUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6OSNH56fTgBhP2PHB7npb7IGOW25UquDK5/8FUOVoc=;
 b=Dy+r05onFzfSYvvUjp5+B9S5zA7ZWrmuabtPPw1P/9S79FhYySRijvF/R60l+y7t0KEnOSVlX5MHPH7odJHXZ/ie+rMYn/+f0jYT1GmpjoIrnEnWI46uq1u+kONQYlcXISZNYOB5xxu+sQRVS+ePhv74IqWSL8prfD2O0vPAbEw=
Received: from BYAPR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:40::26)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:07:07 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:40:cafe::4d) by BYAPR04CA0013.outlook.office365.com
 (2603:10b6:a03:40::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 17:07:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:06:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:06:32 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:06:31 -0500
From:   Alan Liu <HaoPing.Liu@amd.com>
To:     <haoping.liu@amd.com>
CC:     Zhikai Zhai <zhikai.zhai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 26/33] drm/amd/display: Disable MPC split by default on special asic
Date:   Thu, 13 Jul 2023 01:05:29 +0800
Message-ID: <20230712170536.3398144-27-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712170536.3398144-1-HaoPing.Liu@amd.com>
References: <20230712170536.3398144-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cd1674-6fef-4588-9082-08db82fa6c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVdFIIivGAtTY6+mf+cIP4hDrY4LeEQK0hC1Ijg4nvOg5WX8S98eW8mPasoZwejVNoDnFNhPg7P4MIn4Ej5tOJDhxXJTra2hsgZ7pe93a9bNYRFjP+FI+O8v84e8YMb79RCYyiiIJUPILw1UzGl7bI6dEA+s2QhTYNy7Tz6W6qdko73uepkmA5WQz0ouL4Gut5vazlp00eV9DqMZZtAblK0v/wT5qhAvyhP8da7dRSZWOrCmu5Nnp1o7VNISKIawKa7vrmLqHJf6LtqSxch1L6c0/mbDfM80PKO9WeQCHva5STdPPcPqsq2mBS0Kxy7webghxnZig/c3LF39G9eIo/ayO13iJT08oXj+wZXxqgWh8PO/fGc6eXlrW+TxTMIUtzzTo/m6lZO0dgMnwwVUSk+abENomhQdsRxFwiu/vlqcSVM0EtJSglU3SF+MGfeTLGqp5EGsO1ml/k1xzB0n1VOyCIaHlBXw7Cic8l3IUEauOwugYyQENOA5LP/cUhtvurONym/FGsCRc69FIirZu5bVoR69c5J2g9o6JCZy3Vquvs78XZq2HbAtKDNN13Kl9MwoFVvhMg0evVL78D4QHdGX1wr7ehNYV1vRoeyO92n4TWpriu2E9Z/8lFCpGHDKSBNbQHDAMNrfAt4L7juWzsYu8KLoGKT++ZfESv5WZLvgffHlZO7xSBXEFhaHXCrqJWYWZIOyzXaaxjTJLFvbRDbyEe7L7OT/zLgXmllIXIONGaPksUZAM5UkTLDINfSMnIVnpSHyKBoGeIvO+o6QAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(82310400005)(6862004)(8676002)(8936002)(186003)(6200100001)(36756003)(36860700001)(426003)(336012)(47076005)(2616005)(2906002)(5660300002)(1076003)(26005)(40480700001)(82740400003)(81166007)(54906003)(37006003)(356005)(70206006)(70586007)(83380400001)(7696005)(4326008)(478600001)(316002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:07:07.1952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cd1674-6fef-4588-9082-08db82fa6c4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
All of pipes will be used when the MPC split enable on the dcn
which just has 2 pipes. Then MPO enter will trigger the minimal
transition which need programe dcn from 2 pipes MPC split to 2
pipes MPO. This action will cause lag if happen frequently.

[HOW]
Disable the MPC split for the platform which dcn resource is limited

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 45956ef6f3f9..131b8b82afc0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -65,7 +65,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.34.1

