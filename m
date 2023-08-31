Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE2B78EC1B
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbjHaLes (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjHaLeq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:34:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF73CF3
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2s9F08JcKmMJbnY8+0M6ME9A5MQM8IvwMg9jGtVtEi1o4n5o3BRsFQ1lXl9Y/XaVaXfMYK8j1ndSDl66DhGJf3T1ihPftYrUIPkI0PtwITOWfvu55bjEs4ru04VIuCUXzqfBwe2DvSozQCzT5NF4g3BE7ugBT5/TbAn4VIj6ufFieqf1EA9sJJuu4KsKz9F/gqE3+I76bHLHz70o/M0EWPPZo4nHX6PPkoKzFuEt92vMXG+jY2WOW2KnE33dX5okZnpXzoKC8VxAh3BLRO1yf104F+4mEkIiRR+VDgtue9sQF8Gn54Aw/TVjiG/n4TCf0MnDdkqp7vIQuMpw8xT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SVD2/PSUbbkhR8EUTXoGMyCriDUcJOkzpAuUEUsZFE=;
 b=ZE1Ma6fY+FtRkzFBWOWwvdjGsREWqNyuTOSaDSpHRtiaf0ZCr/4EXUHod9jU7b/ToADoyy/lCeITFxDlukLLknVU0RZOI0qywpoQVq1sQzbUAIg4YletSXzmFNaeBUbsCUXF2kPS1j1HIg9EYBaiGnZaVkAgArwTfnAcvPsFz2NWQmJJsRIPK+6PW1SWW2vC92TyogTkQIBsTUHeOGwtvi0iui0xrdndGGSiro3/mzReWWsLvH1t/YkP0b6agjmf5GPUS2wkKwUnebMCw7RPpqki91mO3opZ1Gd1bDqxCb5/qBsv1xkHLedqp4dq8R2oNuuRfcmVBziYD9vkfiPl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SVD2/PSUbbkhR8EUTXoGMyCriDUcJOkzpAuUEUsZFE=;
 b=JLrB9/H3WJh43OSQAxdgxxtahifwdD0Ap7m8AJkdU8OOY27PN/STaODsAeM9MLnPdZDd+aaqx/+3hDRZXkJgGLDCSisfEViUMoc+GQwZrlx6qimDxsQ0BL2BhWRvceLgVm2oduXfn565M0oRvo6NUjk0z3iC0DO7/W0LBaceALs=
Received: from CYZPR11CA0012.namprd11.prod.outlook.com (2603:10b6:930:8d::25)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 11:34:40 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::b4) by CYZPR11CA0012.outlook.office365.com
 (2603:10b6:930:8d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23 via Frontend
 Transport; Thu, 31 Aug 2023 11:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 11:34:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 06:34:39 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        <Joakim.Tjernlund@infinera.com>
Subject: [PATCH 6.4.y/6.1.y] thunderbolt: Fix a backport error for display flickering issue
Date:   Thu, 31 Aug 2023 06:34:21 -0500
Message-ID: <20230831113421.158244-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9331a4-fc42-4c0b-912b-08dbaa16439c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lePjA6XRMx+0pTIzE8YONKfM5nlKj05QCwlVgff2a67liMl1MjIyNjVFSwaiz3ekGXKuPuggqAkOjiwHkl2Mwuvn91+cmZ5eMAgHx2yGE5OMTRSw47tWpk4+1HfHe/DEezztPUATyiYcyhbAyu2ppsNimu8gH65NvwfrSatZCDHfMhgVJKc/BqnaPIUkRGojAZn4t+Gbz83QpU/0NIDyjOhmaUq3YvKKX3taphs7VygGlNc3Ae1XhBM7POGDGBqbHYfSvjSq7gxYwRA3JkrImVHiakhQ7ZXz+Z3YvKW62UlmARmW0h4bSc9O5RaJrUpXVYNq0R64PO52druxdAamDrhJhMd4Lm9fg3+1OO69z56qKZ8AguPLz4wTlYXGQ/t+PNakUIR740sSs8GQa56jdAFRb9eSB/uWWgk5MMF0uAgZaIF1A8HK67QNzLdhlcE+Ftl31u0cCpKkuvXgJUJW2nEayhZngp0qmFkMpNYIViFNINwbVjSofAhsisL//dKz4TLf3NEQyw5ME6Lo8iGZdUL6lWZi3e9yUNpQtPqozmoifdxGLMetVENz8fcJW52BsbbHZwQxYe+0Rev3t4Uy2lw8s9T57VDpZoYEwjLC7qbRphkwPpnjyKZdRZPOSCg/++8KkPve6ebCwtbUiOUuLITz/s90kPF7sFugq+8VEeHCBNIBSaR42stuiwlz1Y/7cd/Mg85u+uTkGir2442htc7tXeg0I/XPbl8jiStifgWCGl1Z0bS6jrA54y/AdlDA9WQ5sy0Vzwaml50dh70ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(40480700001)(83380400001)(44832011)(41300700001)(86362001)(4326008)(7696005)(5660300002)(8936002)(8676002)(26005)(1076003)(16526019)(426003)(6666004)(36860700001)(47076005)(2616005)(336012)(82740400003)(966005)(81166007)(478600001)(356005)(2906002)(6916009)(70586007)(54906003)(70206006)(316002)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 11:34:40.2300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9331a4-fc42-4c0b-912b-08dbaa16439c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

A mistake was made when backporting commit 583893a66d73 ("thunderbolt: Fix
Thunderbolt 3 display flickering issue on 2nd hot plug onwards") in missing
the `if` block.  Add it back in.

Reported-by: Joakim.Tjernlund@infinera.com
Closes: https://lore.kernel.org/stable/28b5d0accce90bedf2f75d65290c5a1302225f0f.camel@infinera.com/
Fixes: 06614ca4f18e ("thunderbolt: Fix Thunderbolt 3 display flickering issue on 2nd hot plug onwards")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/tmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/tmu.c b/drivers/thunderbolt/tmu.c
index d9544600b386..49146f97bb16 100644
--- a/drivers/thunderbolt/tmu.c
+++ b/drivers/thunderbolt/tmu.c
@@ -416,6 +416,7 @@ int tb_switch_tmu_disable(struct tb_switch *sw)
 		 * mode.
 		 */
 		ret = tb_switch_tmu_rate_write(sw, TB_SWITCH_TMU_RATE_OFF);
+		if (ret)
 			return ret;
 
 		tb_port_tmu_time_sync_disable(up);
-- 
2.34.1

