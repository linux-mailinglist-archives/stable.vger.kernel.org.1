Return-Path: <stable+bounces-158831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4703AECBD9
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EF03B3A4E
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE52C200110;
	Sun, 29 Jun 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="dQaNmsMh"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3AEEC3;
	Sun, 29 Jun 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751187864; cv=fail; b=mPfxNHCpMDR2sF9Q6egCFA9/GjkOmMMC39CeA1N0hWQK6DXPVN1TakckLbmCdryp3aQUSFoepP1B+XlaaNcoTH0D5j1Ii6iIc/tInEdXy9qlA0AtghC89x9VRu0LyxZCHyT0YOJF7td1zuBWwYf31Cwt1jDphjGTkCrDYjssljM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751187864; c=relaxed/simple;
	bh=B0VVU6QU8JtngRFaZVc0klC5dAqrqu0LsRXUwqm0AfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eR8OM286W/XeN6Pnfgv2SRxC9+Vj91yciL3fl45e3TP93Dd+NyluX2vInYkSQmJLMyPsvurbgbKlBDWXIuh9PzRguS/oePwvoPIMoq56rS9WrH30dimOM+ek/Say6RG+9yp6rIau0+jGFOvZ474Lf2o+FGz7Rl9sUYEeU+zbBv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=dQaNmsMh; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdLNZFYDqrMl+47C7yKVIveh/68vEgxpmHm697Dbsqdt/2JJ3LuNiRxfmu4pUMtV5n3q/6QsCr6UypCvK84aFwGHGjzE6MNi9dAY9CruXK6vW14MLcq3O9gHpLalb+AED/SdENORojjC3EIMIG0rD5nPc3r34E+nwAu+jsx83U57B2M2Vx+6QJJXDmlU7PVHWWEqdm2gcOxl7zna1NCRUNQg8IAJ6GpcMC1DDmhTWS1zdIOjPb2HAgvyTeZ1RQPIaKSzcVmbAvpxV4v2Udt+kdWUZ9c+NAhBKvXXVFZA8JoX55dBTOz/fLkZcSC5dZFT68XkU8Pcp0epNeqn8i3Ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXIH3GtGrObn0vTWvtiKQdN8fgfMaOAyV/ty6pkAyto=;
 b=SyFSAzzoY0fwmeGBznjrprXlczmQ09NzLwQuT6bnGN960LhUAYjD/JcGKG1cReslBZv7u/clDBW2bhJIIQP0Q3SsFWeX36X6c97oB/hUBDvfTkY0B1h3UA+pTjaI/3L2ZXI9PvcUjSdodEZFiyf2BgbyfT2JkbQ3+7+IC2HdnKara+wccoTgoaoKmVUfJ36pHgAcxznIdA03WPIl6nu5o+Xt+uRGWJzuyM/amsG161RU6b5P4Jk8aQQzIGSJIUTCKXXqKIN2gk1RTczpVh5NR8IQHWjt6iCzzmnADcSbIxLRpuC1++xLFbkql9y07RJ4qKj8avHzBPvh8C7tLRYUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXIH3GtGrObn0vTWvtiKQdN8fgfMaOAyV/ty6pkAyto=;
 b=dQaNmsMh5GFZD6JakU9sOXBkVHJLgdsZC097K6qpgVU0v1KeZCsByIrMkHUK2rky0y5OGdbistzdkjiLqImFJVk3dFah78yK9hg56XdRR6BUywqHoRP6q62++eYTi9YHvkjXGKXl4eJkIB1JjKt4vig3uXnt/Lbycg5Hgy5uhdo=
Received: from CWLP123CA0066.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:59::30)
 by DB3PR06MB9897.eurprd06.prod.outlook.com (2603:10a6:10:5c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Sun, 29 Jun
 2025 09:04:17 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:401:59:cafe::da) by CWLP123CA0066.outlook.office365.com
 (2603:10a6:401:59::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.25 via Frontend Transport; Sun,
 29 Jun 2025 09:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 09:04:17 +0000
Received: from GEO-H84s5E2W8Pk.lgs-net.com ([10.60.34.121]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Sun, 29 Jun 2025 11:04:16 +0200
From: Johannes Schneider <johannes.schneider@leica-geosystems.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org
Cc: kernel@pengutronix.de,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	Johannes Schneider <johannes.schneider@leica-geosystems.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] usb: dwc3: gadget: Fix TRB reclaim logic for short transfers and ZLPs
Date: Sun, 29 Jun 2025 11:04:13 +0200
Message-ID: <20250629090414.294308-1-johannes.schneider@leica-geosystems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Jun 2025 09:04:16.0662 (UTC) FILETIME=[CA8EAB60:01DBE8D4]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|DB3PR06MB9897:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dfa8d838-04a9-4322-a8c0-08ddb6ebed52
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CgtcLfcDKdN/NNPEHpXYBA8oHs4ExHhZsFJy6vOyyrvmWF2XeuFgDjHRhL9R?=
 =?us-ascii?Q?f8VT1R7A1bKGxrC6HpL6K/Ho1sxibxx5W1emiV+JsJmH834EhnQ5ifodRwlH?=
 =?us-ascii?Q?7TrBErVPA4B2Aauo6rkhNYCJRM6mbTGlS9sTWcTGeMTVXxjziEK1WmHqlnCA?=
 =?us-ascii?Q?9Sj+Aq8FOX9IijXA2AT5XIlEsW5LJgbBBVaC68qLIiYXciU8npyCgSl18OAw?=
 =?us-ascii?Q?lpbpcrqFjjUlq/HLaBxjs2vYKV9f7phOFcOOd5CthlOSz4uPYPayZo+Q9b/F?=
 =?us-ascii?Q?vyAcCTo7WvE46eMy18CJijc0INLtner+OcunTYDscPZMhfWPiqRkzSEAAc2O?=
 =?us-ascii?Q?ib/sJd5bxaCxLbOAtRv8KZAsUtdrMzZzeeALHnt5DJPvS6RKB3XRo8GGk9vh?=
 =?us-ascii?Q?B1b7mFbU9Gu2Zsc4ByDte6QNblVRx80nEUPUacMW5LxK7is0wnodp5wfyKmQ?=
 =?us-ascii?Q?d4AMi/sFhevMckvXdVqYV3IZWEzk95WFDehjo0wO79NK3Hu9E9Jo7+woaE67?=
 =?us-ascii?Q?ocfSFqC8Nwo+0lFKqfLZllJeowiHqgsdjPhOGcJtY155QqCHNg/q9U7QJvDC?=
 =?us-ascii?Q?xSTKv30ocK5+8HtvCH1clx5mgB5gr29rk+Fp8cYT6mKh7h/C/3uIYrzROLlM?=
 =?us-ascii?Q?OjLNzitBSrGIgcoBQDVIqkcqfkhAYWLfzV2pn505CP7CqK0NQ7Zt5DZ/b0xs?=
 =?us-ascii?Q?CxTLhyB4tnubCHKW9OAd1E8khChknTT13pLRbP7uN1O3hzm2ySyrpcQx2Cpa?=
 =?us-ascii?Q?k4YMRfEeR9ZTnaHPCY5mBs0q3mPhnWGR8r0QNzrGj5lbFWd5LNm3zy/0BRgw?=
 =?us-ascii?Q?yRsKFmOqrSI6gsXusIq2yWxPFtZa5Qy7RkLR8e6cF8WNDcnO801WZYygwlrk?=
 =?us-ascii?Q?O3pUPaQAX1miUFGpxjLwbg/ig4wX1c664tMDEjeiG1Qsxr4/90f4xhpvvo4Z?=
 =?us-ascii?Q?7yo54xavZIg66BKRN+wjoyShCsqINXatdMLxZhadE5emFlkmi4SDX91zYHG2?=
 =?us-ascii?Q?Elp6Og2G9JhhXqlnMhrBuj8yFzUT5r1tgz0AWEGqfbfhe4FhYgILsKSj9yEo?=
 =?us-ascii?Q?dzV5Gk7xXPq5g1UR2EEX9+kQ+EkpwSXC5NQ4yCKYkrzqVKBj3CIPlmSazX8Y?=
 =?us-ascii?Q?G9qOPkhNfQLTQi27wwHamGyFDzffHwwe1sjt+wH3W/lGv0T+aLsV+xjvyHPv?=
 =?us-ascii?Q?SXWp/5SGVEmWi/UTdOA0nzKtE+Mz3WNJfX9w7rY2IWOnBb5tDH60QePqazbU?=
 =?us-ascii?Q?iK7kotXYWLVJTOOlvi1RIrpl/44wYi6VFyqgFMYYmlvdrFVTIe4mVOXyhciv?=
 =?us-ascii?Q?Do8xPBA9BOWZUdr0ed3uqslrqshF0PmdkAKFdDu9X86Tf0Xk/Muo2OW+3JlX?=
 =?us-ascii?Q?SRTZiYZ9D1f2K8Q2xNHZ9CvOe1yWdpW8FzAqh57+ZeHvp5zZ4ACIk0aepuY9?=
 =?us-ascii?Q?JeP9CyKJrOEKXJ4rzwZ4p/xJZDBPfUbc0EQ8YUDTJNpx8FT9DRYzQBufiN9G?=
 =?us-ascii?Q?bAxNn1qA6F/JDe2HDMTAaQgonpXaWTteuydz7hJL+uMACPHwWxXGWP5l4A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 09:04:17.0684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa8d838-04a9-4322-a8c0-08ddb6ebed52
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR06MB9897

Commit 61440628a4ff ("usb: dwc3: gadget: Cleanup SG handling") updated
the TRB reclaim path to use the TRB CHN (Chain) bit to determine whether
a TRB was part of a chain. However, this inadvertently changed the
behavior of reclaiming the final TRB in some scatter-gather or short
transfer cases.

In particular, if the final TRB did not have the CHN bit set, the
cleanup path could incorrectly skip clearing the HWO (Hardware Own)
bit, leaving stale TRBs in the ring. This resulted in broken data
transfer completions in userspace, notably for MTP over FunctionFS.

Fix this by unconditionally clearing the HWO bit during TRB reclaim,
regardless of the CHN bit state. This restores correct behavior
especially for transfers that require ZLPs or end on non-CHN TRBs.

Fixes: 61440628a4ff ("usb: dwc3: gadget: Cleanup SG handling")
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: <stable@vger.kernel.org> # v6.13
---
Changes in v4:
- None, patch content is the same
- re-assembled into a patch-series, and re-submission to solve b4 troubles
- Link to v3:
  1. https://lore.kernel.org/all/AM8PR06MB7521A29A8863C838B54987B6BC7BA@AM8PR06MB7521.eurprd06.prod.outlook.com/
  2. https://lore.kernel.org/all/AM8PR06MB752168CCAF31023017025DD5BC7BA@AM8PR06MB7521.eurprd06.prod.outlook.com/
Changes in v3:
- re-submission as singular patch
- Link to v2: https://lore.kernel.org/r/20250624-dwc3-fix-gadget-mtp-v2-0-0e2d9979328f@leica-geosystems.com

Changes in v2:
- None, resubmission as separate patches
- dropped Patch 3, as it did change the logic
- CC to stable
- Link to v1: https://lore.kernel.org/r/20250621-dwc3-fix-gadget-mtp-v1-0-a45e6def71bb@leica-geosystems.com

---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 321361288935..99fbd29d8f46 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3516,7 +3516,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	 * We're going to do that here to avoid problems of HW trying
 	 * to use bogus TRBs for transfers.
 	 */
-	if (chain && (trb->ctrl & DWC3_TRB_CTRL_HWO))
+	if (trb->ctrl & DWC3_TRB_CTRL_HWO)
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 
 	/*
-- 
2.34.1


