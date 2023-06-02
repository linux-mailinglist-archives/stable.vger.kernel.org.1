Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988537206C9
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjFBQF0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjFBQFY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 12:05:24 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BED51B9
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 09:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Myn6ybutNDoYH+ahahtlrigTQaMGBgBYBP3Er/SsUJnBVgn5MLo3F+pVCPQebyRxH0U2Km5UUlMcUI1PPFhLYzLJr3gooJqYAo9crVMEhVB7CFJ9AgX7aI+6TgPAKt/W37E8q4HYOa7z5bmWQaOZtP9ksztA+3Av3CRfqj/YsY5KqELfsSwnFcfdf5xVpgumjbXOLxTcCCD9oIVV+LDaAO8B5TfErguE4iT2+jBzxG/QWeI0GjmBTXH2lMm3WsLo+BRfw1Vc5tptPlLXN+kxKxQVVLOZYqwIGjson2m1ugAwnzMTZreuu02y5ZGyRlIwKtXyfjoCPKaoCjz9iAyFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtGl91kb2cWL6UNDBf+OWK+yKFExFgtt0Hf4ngprBPo=;
 b=AZuTtJ9nve3vGYjbmymnSxPCbJgWs/bYp+/+nd5QY+m3IBrqVA3fq00GI34Dfpah2LsUT6fvWp+cHc84zp1kIuwYFXFrdILuRGi19UI0pNJ/Ul9YJ6n4dcDidFRicJA4i/hkmqib3zRdRfCwLfJVHJSGYzZ/ei/yLnHYEcG9M9Um3qryp6kxXbK17QHCEsLh28t3eQ/nbhYClibML9VsKgfRBUqzGyjulHwsY/2951OyEcHHCz9UXUaH+eeUjrDafFBzJabQqmDXVm+fLUTbOWzBfiUbmkH2vxaKhRhK3xUYATiO6DdZ9Jxr0NzSo6H5XYI53zksvSL2wI+Xobb4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtGl91kb2cWL6UNDBf+OWK+yKFExFgtt0Hf4ngprBPo=;
 b=uRmZfxCp9rnlB3cu/K55g8771wmvXmPt1XnTbf8zuImbzBrLwrPrWqNxxwM1Gi/wDMeEQDD+B9aSmpm+usx5mgoSV8I/ldJjOH9kvZAAg5h4k8qQgguZfkiX6n5eGZTsQj4socwva7Il5AhPW+H6Y0Jzo+DzpByBCCamCyqAV0nzmcQ11EFL3vv2UDjyiGigmoHGY32O7L2PUV5RvDzKCjXBe2eZc+P+rgI9jxhLus3EQ1zgjSs3zSp759EJJ8eYmIDxjhuxhSLjXSOF45CUR8MZP0ZfcT1+gI8fAeTOr1eSl2Rcur6g68FOQ2B0gjJ8BpwrjsUDSwoTbQJpbrBjCw==
Received: from DB6PR0202CA0034.eurprd02.prod.outlook.com (2603:10a6:4:a5::20)
 by GV2PR10MB6308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 16:05:19 +0000
Received: from DB5EUR01FT082.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::a5) by DB6PR0202CA0034.outlook.office365.com
 (2603:10a6:4:a5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Fri, 2 Jun 2023 16:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT082.mail.protection.outlook.com (10.152.5.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 16:05:18 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 2 Jun 2023 18:05:18 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.177) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 2 Jun 2023 18:05:18 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <holger.philipps@siemens.com>, <wagner.dominik@siemens.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        "Matt Roper" <matthew.d.roper@intel.com>,
        Clinton Taylor <Clinton.A.Taylor@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 5.10 1/2] drm/i915/dg1: Wait for pcode/uncore handshake at startup
Date:   Fri, 2 Jun 2023 18:05:06 +0200
Message-ID: <20230602160507.2057-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230602160507.2057-1-henning.schild@siemens.com>
References: <20230602160507.2057-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [139.25.69.177]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT082:EE_|GV2PR10MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd7edf5-447d-478e-99e9-08db6383296a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogFyjaIGcZOmKW7m+7phTp5/D/Gq9MTYNdgnzldyo2uHP2GNvaXVCk1EbNUIuWc6ilAy9VzZcV8wSX+Hz1CPcuu7UfKTSwb0NHWhUnXitnTYqFesXGV2sImC4zAzADNgq/fKc/fH0JgyVpy1q8ewRt3mWmtclrylEYWpbG0g3ft7zRilAoo9iF1t4LK4MXcLaUkiEN6Oj+dh2zq/JHkRmL3C+Kww5UpXyTMeS8nivqK2lS76gQttgnfMJgoKxFh2nE21WcdtLTPmXBAQlrJS9W8idXj0UWzEMlRmMGWzsfiFbUwEYSJXYRKm6WUHqtwtq5FbBpe8Kd6DEJx3v9gAvvI1YJIYbIJsBnFWlyAElXbO/geC2f7HN2nwKkcZ08+Nuukprqb/qY+5unRDBqN2atAK4mVGyzuG4tUNbjM/Cqf6szdOd19eHcq734n7CLv2aqvD6+nyV7MzWSFpBHAU42kTTPh1/6/0Ey/yY1OCOUS/R4wOfGar7tOfYBK33A7hHpMFm6p6i+KUz7Zzl5eQGV40oyHz/GpedILgcGpDlSozbansUaHjmIpXeJCSHLyJTXcMW96gwzxqeTXmnYLo1ZlY02hWwmOOpY1I/9oN7QEvrp77wfH6vZ5VvwbMm3QLz9I9ilSqylrZl0WOsNJnhU9YRpfJJ2y79Opgku52IvOjK/KzRFt/vAFSGZIKwG7yWMWacLMNJ8SwfTzWb3eUjzPakw79TNiyHZV/XGoBm7Y=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(66574015)(36860700001)(336012)(40480700001)(83380400001)(47076005)(70586007)(70206006)(6666004)(26005)(966005)(110136005)(8936002)(478600001)(956004)(86362001)(54906003)(16526019)(186003)(8676002)(40460700003)(44832011)(2616005)(2906002)(5660300002)(1076003)(41300700001)(82960400001)(82740400003)(81166007)(356005)(4326008)(316002)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:05:18.9061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd7edf5-447d-478e-99e9-08db6383296a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT082.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6308
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matt Roper <matthew.d.roper@intel.com>

From: Matt Roper <matthew.d.roper@intel.com>

[ Upstream commit f9c730ede7d3f40900cb493890d94d868ff2f00f ]

DG1 does some additional pcode/uncore handshaking at
boot time; this handshaking must complete before various other pcode
commands are effective and before general work is submitted to the GPU.
We need to poll a new pcode mailbox during startup until it reports that
this handshaking is complete.

The bspec doesn't give guidance on how long we may need to wait for this
handshaking to complete.  For now, let's just set a really long timeout;
if we still don't get a completion status by the end of that timeout,
we'll just continue on and hope for the best.

v2 (Lucas): Rename macros to make clear the relation between command and
   result (requested by José)

Bspec: 52065
Cc: Clinton Taylor <Clinton.A.Taylor@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20201001063917.3133475-2-lucas.demarchi@intel.com
---
 drivers/gpu/drm/i915/i915_drv.c       |  3 +++
 drivers/gpu/drm/i915/i915_reg.h       |  3 +++
 drivers/gpu/drm/i915/intel_sideband.c | 15 +++++++++++++++
 drivers/gpu/drm/i915/intel_sideband.h |  2 ++
 4 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 382cf048eefe..f72e3bb4ee9a 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -84,6 +84,7 @@
 #include "intel_gvt.h"
 #include "intel_memory_region.h"
 #include "intel_pm.h"
+#include "intel_sideband.h"
 #include "vlv_suspend.h"
 
 static struct drm_driver driver;
@@ -614,6 +615,8 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 	 */
 	intel_dram_detect(dev_priv);
 
+	intel_pcode_init(dev_priv);
+
 	intel_bw_init_hw(dev_priv);
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 04157d8ced32..728a46489f9c 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -9235,6 +9235,9 @@ enum {
 #define     GEN9_SAGV_DISABLE			0x0
 #define     GEN9_SAGV_IS_DISABLED		0x1
 #define     GEN9_SAGV_ENABLE			0x3
+#define   DG1_PCODE_STATUS			0x7E
+#define     DG1_UNCORE_GET_INIT_STATUS		0x0
+#define     DG1_UNCORE_INIT_STATUS_COMPLETE	0x1
 #define GEN12_PCODE_READ_SAGV_BLOCK_TIME_US	0x23
 #define GEN6_PCODE_DATA				_MMIO(0x138128)
 #define   GEN6_PCODE_FREQ_IA_RATIO_SHIFT	8
diff --git a/drivers/gpu/drm/i915/intel_sideband.c b/drivers/gpu/drm/i915/intel_sideband.c
index 5b3279262123..02ebf5a04a9b 100644
--- a/drivers/gpu/drm/i915/intel_sideband.c
+++ b/drivers/gpu/drm/i915/intel_sideband.c
@@ -555,3 +555,18 @@ int skl_pcode_request(struct drm_i915_private *i915, u32 mbox, u32 request,
 	return ret ? ret : status;
 #undef COND
 }
+
+void intel_pcode_init(struct drm_i915_private *i915)
+{
+	int ret;
+
+	if (!IS_DGFX(i915))
+		return;
+
+	ret = skl_pcode_request(i915, DG1_PCODE_STATUS,
+				DG1_UNCORE_GET_INIT_STATUS,
+				DG1_UNCORE_INIT_STATUS_COMPLETE,
+				DG1_UNCORE_INIT_STATUS_COMPLETE, 50);
+	if (ret)
+		drm_err(&i915->drm, "Pcode did not report uncore initialization completion!\n");
+}
diff --git a/drivers/gpu/drm/i915/intel_sideband.h b/drivers/gpu/drm/i915/intel_sideband.h
index 7fb95745a444..094c7b19c5d4 100644
--- a/drivers/gpu/drm/i915/intel_sideband.h
+++ b/drivers/gpu/drm/i915/intel_sideband.h
@@ -138,4 +138,6 @@ int sandybridge_pcode_write_timeout(struct drm_i915_private *i915, u32 mbox,
 int skl_pcode_request(struct drm_i915_private *i915, u32 mbox, u32 request,
 		      u32 reply_mask, u32 reply, int timeout_base_ms);
 
+void intel_pcode_init(struct drm_i915_private *i915);
+
 #endif /* _INTEL_SIDEBAND_H */
-- 
2.39.3

