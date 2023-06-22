Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C43F73ABF1
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 23:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFVV6X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjFVV6W (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 17:58:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E691988
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 14:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrwpNM1V3jSFYsw+577+obHgfqb107xes/vQ6rkhvTJvZnm/zGYeHYVB0x0CafjnZbyhZMxBKGfourfD8P6aaqtLu7zuZ9Qg5KE/gGr1t/fC2w9ecAKAkgqH5478y5g9B9I/X9fF9/fPMEreN9J1eHEipTDyK7Elf5QIgnEgitDmzooHw8lIV7ATAmsoITISpQbeMy08mRcsC82W8IATf13XrVkfqMntyMvpMxOo5e1afdOLjNX1ssS4srAndILoZGm5c2xWYrFqXKulj7i91f4t8o25O6DvCLzEimV9vGHsL0FT8ck0vSQGCBbkKA4UTaAuhyYheq1XCLD6c3IkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7VtVm4KIzttxvduiVfWfpu0qEPjX5d3BoFB1JmNrSE=;
 b=BLh5ZAr4gstvfFdTcFe7f9dm4hiOAdAgZ3JiluMFc81nZcBH4chsWOYsyvfRkL47VaI7GTI9ZzGouJ0vs7Q34aQrTEo4Mze/U7E1Fcap+HV4J8swXlUlKuYZ9jkYiFrlH13CnIIRb38W4/AJWdQqXdzLP7GjmCZg9cp7GNBpNldkErKEB7FWIriPkfMVGDag1p+JINk5q0zApfCgDkziGOWFba/BR4WiOM7iG+GptlNNATWROpD92oka6PjuMUOo5SJWUwQvuzO4uEKO+zn0r+GvADqR0Q6451zGDfw7x940SzliiyRg7i7zZGpI5nIq5lMjjh+SPUzjDTntvT/hNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7VtVm4KIzttxvduiVfWfpu0qEPjX5d3BoFB1JmNrSE=;
 b=m811iGegVKaw7hXWErbo82j5XpOVGICCFPJguxu/2HUHLXvVbxPDq1MGL0Z/LkQn6uH+ZOd27j74MwzLQW7VfRGkK/8oZVEo2XPeLISxLeCetjUCgDxd2qWEBewVv4WKRxZ0VaQLmynZ/hQ88QocVOA6fpotvj112WcwtR/qLm0=
Received: from DM6PR06CA0087.namprd06.prod.outlook.com (2603:10b6:5:336::20)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Thu, 22 Jun 2023 21:58:18 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::c9) by DM6PR06CA0087.outlook.office365.com
 (2603:10b6:5:336::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 21:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 21:58:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 16:58:15 -0500
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        <stable@vger.kernel.org>,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 08/11] drm/amd/display: Add monitor specific edid quirk
Date:   Thu, 22 Jun 2023 15:57:32 -0600
Message-ID: <20230622215735.2026220-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
References: <20230622215735.2026220-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f86ac7-78fc-4ad1-d35b-08db736bc9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCPe7odj9zLy0pK+vEOP+9U+IIOKJJYG/l6lWyqPezr7fdr9uSwOEIORpJVWe46x19p9SqkJNRiqChWsjueISkg7Dn39j5J6C2ReonSN+m524E5UxFasDXdFCVc/TpFQGymMlYxCZIWclnZAQ7IOixov45K3BcwCkNOV2dJJaEVApD/TTvBdL7G62cVaE64sfTtaqFLlFEh5Yg+j6evU96sJhG/jr1yNTB7YH8g9gbqc+NhAogdFJMpFRDLGynKIle3Ima+n1SaHBR2mg3edudg+RrOt9/lxgadAGb6EEnE/QNhrApFr7TPKWyVEnIFDSXeWa31mSg4uw1NnnnLROfDCJ9ngv6Pv6TjGbGYgriZhIgenIHjuwkKhG0FCkzBkdNp/QGUKXGeSOM9xqJIfmZFz+cM/5Pf7AGy3jGotrWgZebaKO2u/F429vsu5BLmme0J52joDajG3WrNXSKsV2YsqaZhvgbkneK9bbyYqazlB1Mptrm5UYY2I0GP/w6wdcgbZ8qjWDK+H8GmRIfvn1QolSVgLjYgObhET2KNrbelvFuCMogdEsTODBJMDpwgFha1Wa3wGGnaE2mo71LK6HuKZpS2OGmZf0oVqFek8OjJNxfISA2wGD3WYgdMcQVshnc3Oahk4B2zolnxAEmffbLDurfsCUTAA0rdrnpmSIevs4xUI4wiGQlssly4Ued9IUG0qDN3TrsmaHLfUugCBoI+tiPRTchIVNWJzYojn6s1tlTcbkn2nrhoMPviFW0mazE7A2tyNvTpYto7VMksAyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(478600001)(26005)(16526019)(36756003)(186003)(47076005)(426003)(336012)(82310400005)(86362001)(356005)(82740400003)(6666004)(40480700001)(2616005)(1076003)(4326008)(70206006)(6916009)(8676002)(70586007)(316002)(8936002)(5660300002)(41300700001)(2906002)(54906003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 21:58:18.5460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f86ac7-78fc-4ad1-d35b-08db736bc9b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Disable FAMS on a Samsung Odyssey G9 monitor. Experiments show that this
monitor does not work well under some use cases, and is likely
implementation specific bug on the monitor's firmware.

Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index cd20cfc04996..d9a482908380 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -44,6 +44,30 @@
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
 
+static u32 edid_extract_panel_id(struct edid *edid)
+{
+	return (u32)edid->mfg_id[0] << 24   |
+	       (u32)edid->mfg_id[1] << 16   |
+	       (u32)EDID_PRODUCT_ID(edid);
+}
+
+static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
+{
+	uint32_t panel_id = edid_extract_panel_id(edid);
+
+	switch (panel_id) {
+	/* Workaround for some monitors which does not work well with FAMS */
+	case drm_edid_encode_panel_id('S', 'A', 'M', 0x0E5E):
+	case drm_edid_encode_panel_id('S', 'A', 'M', 0x7053):
+	case drm_edid_encode_panel_id('S', 'A', 'M', 0x71AC):
+		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.disable_fams = true;
+		break;
+	default:
+		return;
+	}
+}
+
 /* dm_helpers_parse_edid_caps
  *
  * Parse edid caps
@@ -115,6 +139,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	else
 		edid_caps->speaker_flags = DEFAULT_SPEAKER_LOCATION;
 
+	apply_edid_quirks(edid_buf, edid_caps);
+
 	kfree(sads);
 	kfree(sadb);
 
-- 
2.39.2

