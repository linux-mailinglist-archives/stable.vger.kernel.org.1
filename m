Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2545731786
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 13:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbjFOLnX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 07:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344310AbjFOLmo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 07:42:44 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583EB35AF
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 04:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1hYwlkzwPDELD4xWiNgwnG3cbDlnLwS05yZkGkhsFA+bfcyz0xoS61wadJbDvyFlkqSTXee7ONJ8EYjTKMJi5cu6IvNJotI3KONoRLEuSpfKAe1LV5YuzKsBeFm/Bx+3CTGYh/KYF3lDWYBJN0RKYV70sZTj9TOvCuwocNsXmL7z74jGV6a1w/ze9G5o3IOlW1eNtfSpm6i+n0zqUvKTq1FTrLwkPZhvzKG81kESjWPKEe8prcQZ9YLR0VL9riOb7mlHtl+v5XiWZbQqz13xNhW+wwHShl4bIcclz0TNJ1WI8L+Wcw5f9U2KYa/xoy1qEokloGqism44Ck1PBc6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQOg+SnNQyqKqwPD0x8vOdF1b7oSyc7Hp4dcStSEckI=;
 b=IxKPfGcjZOdVICQO0sUshSviH4lzYL6UxtC4P6nCvvssRzJJrA22HDRxYOZy3MD+s5yNL5CzmGVfXBHc33E/sc2d4SdCAE9tXiWbQVKF2fhGUQiJKhMS86IUeLHSh40+fVz7R51CreE1IVBYUoCcmFgoTzcXkO17CPOsUMx6eWOT1EWkOE+fIAMS2QDcq4SsOezkhLXh9mKjbUQ/ATeiu77TJYfivK6xAS7/4KEOgMOrHeIoBINLXXxc1BRNjvCFPZE0AU6xCEaj+B0c46pWKpwv+bK6RNkYkmpowPsMn0JzY4om/P2AdxHlpvfdxeSF0invFqeQg/IC2cWqXGfGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQOg+SnNQyqKqwPD0x8vOdF1b7oSyc7Hp4dcStSEckI=;
 b=hggkMoT7rzkDbXC/D1KbyCpvEz+5eH5aSyHSoE8cSSnUL7wbCwzxzQ4B2YcoIVm9ybzGPXqEPTUBUgCE0e0Hg42FTj2grxMCx0LA0rJxmtLo/IRse42Aj8/1akoQzFGu7Uo1ka/JtBJXy9/XoX/I2FFHg7lGIdnnlxdmMVqRLkpwy7Ny0YrdG8dfbwVg/YndR/Qb9ci0UxUahGHJbJfSWzLAioOc6u94/n+ebZQsZftOW8Cuu4z/ysb/Ng4xn8vGqBfsxJ7Ytuj6Dz3gkVUNAtKNlZijgDjO+44dK+MgAN2gZv0jgQvDC/KKqnoSmpD4L8mvOyNwfoC677t8KMk9uw==
Received: from OS6P279CA0158.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:39::11)
 by AS8PR10MB7825.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 11:39:21 +0000
Received: from HE1EUR01FT078.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:39:cafe::41) by OS6P279CA0158.outlook.office365.com
 (2603:10a6:e10:39::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 11:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT078.mail.protection.outlook.com (10.152.0.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.25 via Frontend Transport; Thu, 15 Jun 2023 11:39:21 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 15 Jun 2023 13:39:20 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.220) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 15 Jun 2023 13:39:20 +0200
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
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 5.10 v2 1/2] drm/i915/dg1: Wait for pcode/uncore handshake at startup
Date:   Thu, 15 Jun 2023 13:39:08 +0200
Message-ID: <20230615113909.2109-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230615113909.2109-1-henning.schild@siemens.com>
References: <20230615113909.2109-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [139.25.68.220]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT078:EE_|AS8PR10MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 994ea809-31be-4e0e-0294-08db6d952936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMoq6/m219S3rjF7JbvGoSz1sCell4T8YT27ZPmB8GHV76FG/hU5OQ6INKzqWRJEBzA1Zzlq1rz3Jh8qyyLF1H7qurUGrAdkoSsD6MqlI2CUWCZ5lcoTGFyCmo+dhGEEQwy9yEjYnHwaeMZ/9K0W14/iCysqRz5zbQGce5SVUtQsi1sdg2I/PW1dmRVW3c5im6ZLK6POiAe7dCwNnBJnQk+1w+8knd5dFcx9w+G86yY7WvwVzu6pHTiIqNjWk/Xv4IJjN51j3UImgvQTBjNVvSpYWRkaZ2rDZPsLYAjFDDZM0qnvwXmbb55grhVjneiMo+keNm6vqF1uelRpiZiR+XqXXPwIRcKJxHGRY6iz7pbGEf3eg0s5FtxMOSeljp5sv6QPwXBp/xE7sDY4hHvqS3WJC4dg6upZnWJX3CPq+sn+jpwQd/OMUukSVmL09C3VIE6DB06gkP25cscVIjDJ1H7xQgx85YTm0LUHObUrsyJZz0qdS/PEePJXQGP0YLyV42VRifdYlLJ4Vo3sVgoEmJWRxjxRe/KAgXMYdBcGLu1hsup3EGCHhPgVmlHHTrNmd2lM5aKzXr+nNp0LXdwknt9xBpHJFs/AJd53Kg51EFPuIc6Y1/45sW0poZcKhLOtVrASr1VYi7JCT2mJVvunRL9qZ1oN9Z0ewDpoHNp7vMekkQCXg7orgydzPF7RWuU1
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(83380400001)(336012)(186003)(40480700001)(44832011)(66574015)(2906002)(47076005)(16526019)(956004)(2616005)(966005)(107886003)(36860700001)(41300700001)(8936002)(26005)(40460700003)(8676002)(316002)(110136005)(54906003)(6666004)(82740400003)(36756003)(7596003)(478600001)(7636003)(356005)(82310400005)(82960400001)(4326008)(86362001)(70206006)(70586007)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 11:39:21.0959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994ea809-31be-4e0e-0294-08db6d952936
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT078.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7825
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
Signed-off-by: Henning Schild <henning.schild@siemens.com>
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

