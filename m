Return-Path: <stable+bounces-158373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F007CAE62F0
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 12:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EBD1883DB1
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76275288536;
	Tue, 24 Jun 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="sCNNuDsr"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08228689C;
	Tue, 24 Jun 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762425; cv=fail; b=f9mi9gJLgGcTJtEwtzGwwWOhrFI6BYe1KK/gMTCnaa989gkKguwDMWxfJLykvtYQ5cDsm6UYvwsjhuk12MRAlzMr8v5PVqgNXwxhvQKNszg2Kaoc1Vzb01FQyz1Uy8Re/AaPykMZ3nzIaPiM/udqnDiv/BVqfPwvh4ttJyN/5/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762425; c=relaxed/simple;
	bh=neZNTUymVbHPHw6syfk/hFLqcFLHJ0YX5YKiDoOIais=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFDRz0QhEuGXeasS7fULDhQdR6TVmi+2LiKk1uG2OSdvaLeIfPNlGhhEGaNNjJ5Y3+n/FsxwSvOG/4CJb8/wPl9k7gFuIS1aFfWlx9bEixZd5j+1Sh9aT3JaCzzD7llWnNeSkaa7ZaBVslAC0HJEdw3l1ViEp/tui1YDrpdQULo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=sCNNuDsr; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdlY104UXRkk+cQV+f81PzgbLkEsHIJbYyb/UDVt/bXxHw/vOXYR2FwSfLHjqVF6cTXlH/KltpB7Xi8mmvjApzHikjumXuUFd8n65ZyxWucmC+NakEjxR97xkwl21fYGSbVmzWlXTpSRA0rqDRGniCXNmQ2VVgkYMnQCsYpk03JOIW4IrtkcfeBtieTdcp1D4Gc9b4u8FLk8dwHJCel4yPHmnRiYfpN4IzQdZSr+5S52SVMuGIIAxExPDgqis4/V6Je9ALokXbsI/TVO0ZphhxCw8buyZHdyi+Tqu7OLhgAvlhOFfBGG65TB723dbQNWQZWz53V4+hZi1fdsGYd+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJSGVLktELB2mglF8p2m3zl1G0aIPUNQNqJI0n+L8Ao=;
 b=SD8EQsA49/B0Nmo9/ltPyrS1o0F+5hrMpMgv/Azbu7dV0csF6EO2BOei1KvGgbsVTSALlcH2VIrmy4JKTG0wnnx8Qd+S0GSGiokNKGHhi3EOb4vxh0thUb/Ypt8ttsyOmE9t/rT1KnBIcL1JdCJ7xh/cZ5D3+CP8NPho+3zwweNPzr49g6Cngoa8YfhTnKOwNmcFUaRtXsZqdMc6CxIZWo0xRQXiNmkq9Pma7grcyaTuIqcnQ+3vfgIbzWC3dmYmj8WrtwIEYiMvDrFUAK5hmbqHRFQew8XdT1+VAG7NjDgfatOddpRUdiMwVNyUbEbyil4jgvWg1py5QVFTUX7syw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJSGVLktELB2mglF8p2m3zl1G0aIPUNQNqJI0n+L8Ao=;
 b=sCNNuDsrff0XpfW+D1MxU/enQI6F/eAxQvHqXCuyNx5qU43AkqkwqCHYaEw00V3eswPb/SejOcdTjX+mdqxKUwIT+c613/4f1j5hWQwCeqv+wgrzBkZj/5B8bdL2rgnHP2r9udXreqpSRFcjMaJCdh93OKi/Sf9yJHC+dtlEyMs=
Received: from AM0PR10CA0030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::40)
 by AS8PR06MB7944.eurprd06.prod.outlook.com (2603:10a6:20b:3c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:53:41 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::8d) by AM0PR10CA0030.outlook.office365.com
 (2603:10a6:208:17c::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 10:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 10:53:41 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Tue, 24 Jun 2025 12:53:40 +0200
From: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Date: Tue, 24 Jun 2025 12:53:12 +0200
Subject: [PATCH v2 1/2] usb: dwc3: gadget: Fix TRB reclaim logic for short
 transfers and ZLPs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-dwc3-fix-gadget-mtp-v2-1-0e2d9979328f@leica-geosystems.com>
References: <20250624-dwc3-fix-gadget-mtp-v2-0-0e2d9979328f@leica-geosystems.com>
In-Reply-To: <20250624-dwc3-fix-gadget-mtp-v2-0-0e2d9979328f@leica-geosystems.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, bsp-development.geo@leica-geosystems.com, 
 Johannes Schneider <johannes.schneider@leica-geosystems.com>
X-Mailer: b4 0.14.2
X-OriginalArrivalTime: 24 Jun 2025 10:53:40.0103 (UTC) FILETIME=[3E9B8970:01DBE4F6]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A7:EE_|AS8PR06MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: a08488c0-146e-4c67-854f-08ddb30d61bf
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFhOY05zTkdwWVd4UTBvdnF1MklhQmh0eHYrSnduU3JBL1pZWXNZdXd2bWhR?=
 =?utf-8?B?dDN1Yy8rSFRjYnNQL213MFBFV3cremkxWm1ud2RvbVJlZnIzSG4ybEJva0xs?=
 =?utf-8?B?L0RQbjZlL1dxTmtBQzdoRTlQVVZidXlFK21QRHdSR01yN3ZYVm5sRE5nbTlG?=
 =?utf-8?B?cis2YUt4MWJPc0pCTkkxeVFaSFRVa2FEZjU0OGZDUkNzb1J1a1RyMC8rWGhO?=
 =?utf-8?B?aWRSL091cXN3ck01SWF5Qm0zR1RPR2ZyL2xzU0RydTFJOXpKMmlTc0lsclhk?=
 =?utf-8?B?cjMweUdnTDUwWWswZ3pQcEFrSGJ4aXRhM2hjN0UzM3JTVUR5aXUrcUxXbktX?=
 =?utf-8?B?akdEOFljbTZDbEFzZE9aajFqbkRsL0wzUW9BYVBmNzVIQXdGNmtJc1VOSTFN?=
 =?utf-8?B?a1V6ZXZyanpCb1Y2RlVJbTBnbFErV013MDcyYkRwOUF2dUg5MENoZE51NWZD?=
 =?utf-8?B?ZXhqaE9yRHpXUUZRaW1iU2oxMmM3QVBtV0dPNGI1YTNjRkJJbml1ZjJLQ3hB?=
 =?utf-8?B?RnVwUmZzbHNvWUxZd1hXSUtERStrekxOcmRaRmliWUd1SkRUNlcwcFRZT0o2?=
 =?utf-8?B?bW1mUFdvaFBCR2ZuS0FZRTYva3JvTDJSWUtGWGE1d3l2Zk94STdkQVVhT2ZL?=
 =?utf-8?B?VGs1TlduREVDMVRWSzc4Q2VVRFRYUG1KMFdiZE9zcnhkMG9RUUt0UEZHSUlv?=
 =?utf-8?B?Y0dqaThESHhvSUVpNm03UEcyZDVMRkVkUU9tQUZMSXp1aWhEb3VXaGRkL0NY?=
 =?utf-8?B?V3lmbktEdkFhRFJvSzVYdnY0bWF0L0gvWmVKTXBtRURSanZUcmlLSjhNU1NY?=
 =?utf-8?B?TXM5M1ZxdXF5cEZ2NkRXQUV3eHpFM2FIbWVUYm9tR3dsVzVXczhXRHhuSi9U?=
 =?utf-8?B?aGdzbHRYOURhYzhmWWVScEx1NWdwWFNXMVIwZFZXQWRGNU9KSnZhckpoSXE4?=
 =?utf-8?B?a2hsdXRxZ3JkVHdTTTBtS01xV3lSc3N2c0U3eFI2NkJiRUxjK0EyQ0Z3S2dR?=
 =?utf-8?B?VFh1bSttcWlVTUtRRFpUQ2hIcXdHR3ovOEhKdU1HVG96TGdmYUZoN0NnT1Qy?=
 =?utf-8?B?LzQrZWkxMTFHUDd2ZTQwQkxZUGVlZ2Q3WEU0eTFOL0E1Z21URE9vMEtHbFVL?=
 =?utf-8?B?Y1l4Qk9pcUlkTXMvc3FCMFFNS2tKMFRkbjdHamRZejFUcnVlN0xoSVhFZHpn?=
 =?utf-8?B?TFFvK0xwZnY1UTI0L0VqeUNRUkU4Sm41akFoMmNtdW1RSEtVWk5sSXVHY0xI?=
 =?utf-8?B?aUdscmZyY09HTzBpenZ1Tk9hRTFoSFJPK29DV2lZSXpsWkNFUFZaMUQ4MG80?=
 =?utf-8?B?WFlma2lKQmhLckZHYnhUWGt3TWNJbVozUU5sNzJjdWovQ1FFeWRxayt0aFRC?=
 =?utf-8?B?eUdPQVFWcWZYS0YraWNsdThoczhpelBpQ3l6bzlFcExWaE5ydzg2U1RVZTF1?=
 =?utf-8?B?Wm1xSUw0MnFhTFFRV1VrcTBaRnFOV2E4V0YwUXZjQXZqUDdNVUtoUnk3K1dy?=
 =?utf-8?B?Skx5ZGNjc0xINnFiY01jOFNKa3hYVldLc0g0M21QYW52RWo3R1FnTDJ5Vk1a?=
 =?utf-8?B?YnE5cUZDTWdXZEFLdEhBSW1xUmpJNDlsOThqeFU4aDRkVGRySHhueW9jSmVn?=
 =?utf-8?B?alM4clczNGxxZlpDZWNwT2x3VnhRU3hNZ0RaZ0l4RitNaEhCQjExVCswZkMr?=
 =?utf-8?B?UmxndXJQdDQ0aVg2NFo4SGpDWTF0RTZReFYzbE1NRU81ZjRlejdVQmdTSlBN?=
 =?utf-8?B?TjBlRGpBK0VRMWJ6cFNBN09OUTBVcmxNMHpRNi93U3VsUzhkWS8zODN2b21k?=
 =?utf-8?B?YlZvak85RDNOcDNWMkpVMjNFcXRJSjV2UHd0UTFYYU1IL1ZKQ3RVdVlQRFJM?=
 =?utf-8?B?d2RRWmpTV3BXQ0g2RytuUjdsNktSc1p3ZGh6UEh0cDk0bG4rUzNKREQyQkRN?=
 =?utf-8?B?YjMvS1NJMUtpUkJyVEVuMnNBT0xvNnNFcU1LankwT29qOUIwWnBOOE8wUjh3?=
 =?utf-8?B?cFRPMTNOaUIwVTl0WExlOGkwWVpSRXdKODlURHpJZHFVakIwbmZ5L2xCMzFl?=
 =?utf-8?Q?m9Db0v?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:53:41.1461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a08488c0-146e-4c67-854f-08ddb30d61bf
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7944

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
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 321361288935db4b773cd06235a16670a6adda1a..99fbd29d8f46d30df558ceb23d2afe7187b4244c 100644
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


