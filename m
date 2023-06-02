Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E07206CB
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjFBQF1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 12:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjFBQFZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 12:05:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDC5E2
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 09:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQyqzAdkt0qVsPptkXm8lVYbrevTCOfVmYxK1g94573QI52UwoayDaOJYZWdtcwKsAX1rpfsz3JBC4owY30Gz+ABYMFkSLTgS+EsTQM5Bn0sF3EkqABzhVIjbizcWi5Br/SCbmBBp2nrINIf/MQe5NEVtV+3BBkd/6nOvxbaVzDJZ0GOJaAliEzK0ZU8KXOAaimPrxEs+QSAuazpEveY53FEfiEYgUj2Pqsm3z/1jIHGMEc2Yk0TSIXB+3zYW4D+vDfLXwL+T6PhaLqfH7OoaAHRfmfPLd8SwgTT2oLvHZy9xTdQQR+Laxrn9HHkhsErpaTzffAeSutNUTw/wef+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao2xWJjcMb2jd8+W/La8pKDKX1jsjqIW83mxK97LgRE=;
 b=ImBZyLVnfGKGmMvZK20jYyVZNDKWRYBz58flopB/mArSgN1mFkraYZCDpASE0yBxpeB/bGkBVTCsH3wXhLJTyz8ylPmdTCSaMGZnjldg09iSM5SVcuEbNeJwikqXoBxLf89H1cu0QE2qb3l9nNU9Px8yPHyWGUmlLcnOm/xpjuaZtgg9nGbLg4E6IMbMiHdXlg2Fpw+2uHLGqdiKGAdWER5tC68zSVAq1PHNoozqooKhS42EiANj7csJYVJuUJJkrxRdJe6hk7FQ+dC73caOebIm6RNL5rXtHuMp6/DYd45keu7TA8P9EtEtlwcKaxhfTW0I2KNRHvZ7ZLfMCbeDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao2xWJjcMb2jd8+W/La8pKDKX1jsjqIW83mxK97LgRE=;
 b=buhiIARoSfYWHRPfjN02/8yAZBDZFAgI9129AM1QgHvhsLI/0So0ddI0Vg3oGpVuZk8lTPbiKdO5imn6TB5G3iO8ujFLUe4vS+Wkl8Bcm3ZKEtpVlFad4No98pY5KbXSxrfr3WGUVEaNPM86pPWr1Utz59hku87PUxPiw1wpNpbiVRq1gNZi8bZkunwCPlXf1TA0vDosp8Gj+NIXM4NtwS1Oa7W3uorbddVcbAUvKRwkrrfO3i+/5+szq4KKVJVqnnAvnYRilw2TYknPn3TB5Dp0v4DSJOKLILeZAbtJEQdrLvxnrM5wh6B9BKthQYiHtToloi/VGw+5fvtHiJufkw==
Received: from DB6P192CA0008.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::18) by
 DU0PR10MB5386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:328::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Fri, 2 Jun 2023 16:05:20 +0000
Received: from DB5EUR01FT023.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::37) by DB6P192CA0008.outlook.office365.com
 (2603:10a6:4:b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Fri, 2 Jun 2023 16:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT023.mail.protection.outlook.com (10.152.4.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Fri, 2 Jun 2023 16:05:19 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
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
        "Lucas De Marchi" <lucas.demarchi@intel.com>
Subject: [PATCH 5.10 2/2] drm/i915/gen11+: Only load DRAM information from pcode
Date:   Fri, 2 Jun 2023 18:05:07 +0200
Message-ID: <20230602160507.2057-3-henning.schild@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB5EUR01FT023:EE_|DU0PR10MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ab8e55-6263-4105-1d4d-08db6383298c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WU44h93jbgyRcphxpZEQA683GaDcPr2lnsa8nJ8y55EL7c/d/Tk8OXSr0W3XGrcyfdvGrAuzvYl/tSP1UozCvPaBAqOTuuuDzEmvU/kLEQUK0pHdTif0eqAVCmEcGbQpLDSvI2We/dhfIGFWwZdJqi0XiPkzbqRFCdzL4cVf6ZsTCUnvLBS7EgftkZDHBQttWhI6XYaDRIrWqHTOECwT4yZm/QVeusTQaVBhYAsRR9fXoptQ5V13MmpbZXOx1pd5xjlFl9/C1eSbVgqvEmwXQbQnZgWkIXIQ815wu9Hg3f5P1n12EBYGyb/JBsUXRbXmvtpNAjfPBFa5u9aaJRjr7Gckfyb8pG2xVx4N5bkhuLXKDnzZRjjBpmC1jf6g01yJjQJ/+rlxfaWOWdztWQ65UHv0/kwnmUIWc5P6evPDB3DS/OJauB6QYEfwUT+tkVng+jqsQOsRYPjtpBkHC5JwYPZH+5GxFaL2ZetiVSoh70QOXEJvR4xRdFqgB9/3ewi6RGgammeYllAyfqA3l7koNGT1ZUM0N6MJVgb6orowuK1v0Y1+jMLBvHUg7fA1OFOxoitQHImaWG6fISbUwUgIVcwr2iXTrcTx0tW6cUty1yBoLX+CQAOgsRMgGrdnPuxm433b5Mcs63uLO75xYw30AdwdLekxEjTaSQ9JvS9tHBBkiQZH063KFt7M0nJ9vESp
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(44832011)(6666004)(316002)(2616005)(110136005)(478600001)(82960400001)(4326008)(70206006)(956004)(26005)(1076003)(41300700001)(5660300002)(8936002)(2906002)(336012)(8676002)(16526019)(186003)(70586007)(47076005)(83380400001)(36860700001)(356005)(82310400005)(7596003)(7636003)(82740400003)(40480700001)(36756003)(966005)(40460700003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:05:19.1222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ab8e55-6263-4105-1d4d-08db6383298c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT023.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5386
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

From: José Roberto de Souza <jose.souza@intel.com>

From: José Roberto de Souza <jose.souza@intel.com>

[ Upstream commit 5d0c938ec9cc96fc7b8abcff0ca8b2a084e9c90c ]

Up to now we were reading some DRAM information from MCHBAR register
and from pcode what is already not good but some GEN12(TGL-H and ADL-S)
platforms have MCHBAR DRAM information in different offsets.

This was notified to HW team that decided that the best alternative is
always apply the 16gb_dimm watermark adjustment for GEN12+ platforms
and read the remaning DRAM information needed to other display
programming from pcode.

So here moving the DRAM pcode function to intel_dram.c, removing
the duplicated fields from intel_qgv_info, setting and using
information from dram_info.

v2:
- bring back num_points to intel_qgv_info as num_qgv_point can be
overwritten in icl_get_qgv_points()
- add gen12_get_dram_info() and simplify gen11_get_dram_info()

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210128164312.91160-2-jose.souza@intel.com
---
 drivers/gpu/drm/i915/display/intel_bw.c | 80 +++---------------------
 drivers/gpu/drm/i915/i915_drv.c         |  5 +-
 drivers/gpu/drm/i915/i915_drv.h         |  1 +
 drivers/gpu/drm/i915/intel_dram.c       | 82 ++++++++++++++++++++++++-
 4 files changed, 93 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
index bd060404d249..4b5a30ac84bc 100644
--- a/drivers/gpu/drm/i915/display/intel_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_bw.c
@@ -20,76 +20,9 @@ struct intel_qgv_point {
 struct intel_qgv_info {
 	struct intel_qgv_point points[I915_NUM_QGV_POINTS];
 	u8 num_points;
-	u8 num_channels;
 	u8 t_bl;
-	enum intel_dram_type dram_type;
 };
 
-static int icl_pcode_read_mem_global_info(struct drm_i915_private *dev_priv,
-					  struct intel_qgv_info *qi)
-{
-	u32 val = 0;
-	int ret;
-
-	ret = sandybridge_pcode_read(dev_priv,
-				     ICL_PCODE_MEM_SUBSYSYSTEM_INFO |
-				     ICL_PCODE_MEM_SS_READ_GLOBAL_INFO,
-				     &val, NULL);
-	if (ret)
-		return ret;
-
-	if (IS_GEN(dev_priv, 12)) {
-		switch (val & 0xf) {
-		case 0:
-			qi->dram_type = INTEL_DRAM_DDR4;
-			break;
-		case 3:
-			qi->dram_type = INTEL_DRAM_LPDDR4;
-			break;
-		case 4:
-			qi->dram_type = INTEL_DRAM_DDR3;
-			break;
-		case 5:
-			qi->dram_type = INTEL_DRAM_LPDDR3;
-			break;
-		default:
-			MISSING_CASE(val & 0xf);
-			break;
-		}
-	} else if (IS_GEN(dev_priv, 11)) {
-		switch (val & 0xf) {
-		case 0:
-			qi->dram_type = INTEL_DRAM_DDR4;
-			break;
-		case 1:
-			qi->dram_type = INTEL_DRAM_DDR3;
-			break;
-		case 2:
-			qi->dram_type = INTEL_DRAM_LPDDR3;
-			break;
-		case 3:
-			qi->dram_type = INTEL_DRAM_LPDDR4;
-			break;
-		default:
-			MISSING_CASE(val & 0xf);
-			break;
-		}
-	} else {
-		MISSING_CASE(INTEL_GEN(dev_priv));
-		qi->dram_type = INTEL_DRAM_LPDDR3; /* Conservative default */
-	}
-
-	qi->num_channels = (val & 0xf0) >> 4;
-	qi->num_points = (val & 0xf00) >> 8;
-
-	if (IS_GEN(dev_priv, 12))
-		qi->t_bl = qi->dram_type == INTEL_DRAM_DDR4 ? 4 : 16;
-	else if (IS_GEN(dev_priv, 11))
-		qi->t_bl = qi->dram_type == INTEL_DRAM_DDR4 ? 4 : 8;
-
-	return 0;
-}
-
 static int icl_pcode_read_qgv_point_info(struct drm_i915_private *dev_priv,
 					 struct intel_qgv_point *sp,
 					 int point)
@@ -139,11 +72,15 @@ int icl_pcode_restrict_qgv_points(struct drm_i915_private *dev_priv,
 static int icl_get_qgv_points(struct drm_i915_private *dev_priv,
 			      struct intel_qgv_info *qi)
 {
+	const struct dram_info *dram_info = &dev_priv->dram_info;
 	int i, ret;
 
-	ret = icl_pcode_read_mem_global_info(dev_priv, qi);
-	if (ret)
-		return ret;
+	qi->num_points = dram_info->num_qgv_points;
+
+	if (IS_GEN(dev_priv, 12))
+		qi->t_bl = dev_priv->dram_info.type == INTEL_DRAM_DDR4 ? 4 : 16;
+	else if (IS_GEN(dev_priv, 11))
+		qi->t_bl = dev_priv->dram_info.type == INTEL_DRAM_DDR4 ? 4 : 8;
 
 	if (drm_WARN_ON(&dev_priv->drm,
 			qi->num_points > ARRAY_SIZE(qi->points)))
@@ -209,7 +146,7 @@ static int icl_get_bw_info(struct drm_i915_private *dev_priv, const struct intel
 {
 	struct intel_qgv_info qi = {};
 	bool is_y_tile = true; /* assume y tile may be used */
-	int num_channels;
+	int num_channels = dev_priv->dram_info.num_channels;
 	int deinterleave;
 	int ipqdepth, ipqdepthpch;
 	int dclk_max;
@@ -222,7 +159,6 @@ static int icl_get_bw_info(struct drm_i915_private *dev_priv, const struct intel
 			    "Failed to get memory subsystem information, ignoring bandwidth limits");
 		return ret;
 	}
-	num_channels = qi.num_channels;
 
 	deinterleave = DIV_ROUND_UP(num_channels, is_y_tile ? 4 : 2);
 	dclk_max = icl_sagv_max_dclk(&qi);
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index f72e3bb4ee9a..c72a26af181c 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -609,14 +609,15 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 		goto err_msi;
 
 	intel_opregion_setup(dev_priv);
+
+	intel_pcode_init(dev_priv);
+
 	/*
 	 * Fill the dram structure to get the system raw bandwidth and
 	 * dram info. This will be used for memory latency calculation.
 	 */
 	intel_dram_detect(dev_priv);
 
-	intel_pcode_init(dev_priv);
-
 	intel_bw_init_hw(dev_priv);
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 6909901b3551..a8b65bab82c8 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1148,6 +1148,7 @@ struct drm_i915_private {
 			INTEL_DRAM_LPDDR3,
 			INTEL_DRAM_LPDDR4
 		} type;
+		u8 num_qgv_points;
 	} dram_info;
 
 	struct intel_bw_info {
diff --git a/drivers/gpu/drm/i915/intel_dram.c b/drivers/gpu/drm/i915/intel_dram.c
index 8aa12cad93ce..26e109c64984 100644
--- a/drivers/gpu/drm/i915/intel_dram.c
+++ b/drivers/gpu/drm/i915/intel_dram.c
@@ -5,6 +5,7 @@
 
 #include "i915_drv.h"
 #include "intel_dram.h"
+#include "intel_sideband.h"
 
 struct dram_dimm_info {
 	u8 size, width, ranks;
@@ -433,6 +434,81 @@ static int bxt_get_dram_info(struct drm_i915_private *i915)
 	return 0;
 }
 
+static int icl_pcode_read_mem_global_info(struct drm_i915_private *dev_priv)
+{
+	struct dram_info *dram_info = &dev_priv->dram_info;
+	u32 val = 0;
+	int ret;
+
+	ret = sandybridge_pcode_read(dev_priv,
+				     ICL_PCODE_MEM_SUBSYSYSTEM_INFO |
+				     ICL_PCODE_MEM_SS_READ_GLOBAL_INFO,
+				     &val, NULL);
+	if (ret)
+		return ret;
+
+	if (IS_GEN(dev_priv, 12)) {
+		switch (val & 0xf) {
+		case 0:
+			dram_info->type = INTEL_DRAM_DDR4;
+			break;
+		case 3:
+			dram_info->type = INTEL_DRAM_LPDDR4;
+			break;
+		case 4:
+			dram_info->type = INTEL_DRAM_DDR3;
+			break;
+		case 5:
+			dram_info->type = INTEL_DRAM_LPDDR3;
+			break;
+		default:
+			MISSING_CASE(val & 0xf);
+			return -1;
+		}
+	} else {
+		switch (val & 0xf) {
+		case 0:
+			dram_info->type = INTEL_DRAM_DDR4;
+			break;
+		case 1:
+			dram_info->type = INTEL_DRAM_DDR3;
+			break;
+		case 2:
+			dram_info->type = INTEL_DRAM_LPDDR3;
+			break;
+		case 3:
+			dram_info->type = INTEL_DRAM_LPDDR4;
+			break;
+		default:
+			MISSING_CASE(val & 0xf);
+			return -1;
+		}
+	}
+
+	dram_info->num_channels = (val & 0xf0) >> 4;
+	dram_info->num_qgv_points = (val & 0xf00) >> 8;
+
+	return 0;
+}
+
+static int gen11_get_dram_info(struct drm_i915_private *i915)
+{
+	int ret = skl_get_dram_info(i915);
+
+	if (ret)
+		return ret;
+
+	return icl_pcode_read_mem_global_info(i915);
+}
+
+static int gen12_get_dram_info(struct drm_i915_private *i915)
+{
+	/* Always needed for GEN12+ */
+	i915->dram_info.is_16gb_dimm = true;
+
+	return icl_pcode_read_mem_global_info(i915);
+}
+
 void intel_dram_detect(struct drm_i915_private *i915)
 {
 	struct dram_info *dram_info = &i915->dram_info;
@@ -448,7 +524,11 @@ void intel_dram_detect(struct drm_i915_private *i915)
 	if (INTEL_GEN(i915) < 9 || !HAS_DISPLAY(i915))
 		return;
 
-	if (IS_GEN9_LP(i915))
+	if (INTEL_GEN(i915) >= 12)
+		ret = gen12_get_dram_info(i915);
+	else if (INTEL_GEN(i915) >= 11)
+		ret = gen11_get_dram_info(i915);
+	else if (IS_GEN9_LP(i915))
 		ret = bxt_get_dram_info(i915);
 	else
 		ret = skl_get_dram_info(i915);
-- 
2.39.3

