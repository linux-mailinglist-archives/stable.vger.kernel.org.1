Return-Path: <stable+bounces-158374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5085EAE62F7
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 12:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0CB7AFADE
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3EF288C04;
	Tue, 24 Jun 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="lGELpFiG"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB36286D4E;
	Tue, 24 Jun 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762425; cv=fail; b=WT26rw0zjnArSfAOrfjSKfMgDHIYErLPDP8bP4MWjXUC2EkeaZf/6G0jdgKxA85K4V3t958jdb94qtwjCWxa6csdX+Xfbwk9dL3gYZhkcbPfQFLKDHrSXql1I7aPID/6iAMU0bDyVlye5KSraqrbj1uUy/jsxcG3okVxIKACpDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762425; c=relaxed/simple;
	bh=U9E/hhUR2xYzWugNxJmJGCcHVrHkwaU5t09dWVYudyM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W+Lvqe9g6H9rzcsjzVC/imHZNqpjCGsAKJT8qdmqSyQ5FgdTNxgfBC9OnC1KhUkQIuyCk0xCG/SsM55ZU51jaJlQCsixnAYpA73jITP6D1ngrWNK/+hc8PjjzYECOSO2I9vkbcnuZyaUMCUsYZJY+7Ho0B6TSeOaF2DU+KK7iBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=lGELpFiG; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SShFqIxnn9sxJXyi5C39SUxGGcCu3s/xNMYgo1IAWL6ESVWuj4ft+o7yG8Ay4FFjOzD5xwRDyMIihyJ8lSJsvRNm6UtQXN6VdzW7GE45l4EPlqY5g1Uaj0qvB6dGOhtU083P5XGpWdTGVH7ItruBsaHiRDahw//yoR6EoJ6SEbA06vtId9cISbHzsTPvSTwuXPu0hhyFOoUPapGpsjE+cx7qFMYbagbz7qePmHCnhuagLsDzrpumzwPGhHt4UMIrC0b8WYH6WVYNYnNTHpCp+wNUeT8c6ZkPPl2jlLr3oT6pZpqC7+nn8ErP0225EpOAYhQLZIUv00Ys+IjiBo6LNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1SOwFystKE2ge9VOH9hZodBnZUTd3lqqDhPpMuPs5Q=;
 b=uoqDVwSuiL6qlWqtfbyzbAJLAVXjRX69panb31z9p3IzRpwBvbnS39sQadZYQwEylh98BE0Qu4jPemIDRticjIPZ1sF9OXZobaurUjvMWOGIPJi44loKubTTF0h+mV9FdwK4hB6XkvISXZZfPFrgovGsbcF7aFhW1wkZr2MLv+jWRrAx/Ok8piY7BXMGSyiQTDrXKfmiQ2PKcyO0ZAfzbIiI7nSaf2FlttSwBsVK+Cpnsv8vwwh380dx0zj2XN78htOiEFx6RhJNt1HWQ6KKyC8qAI6FVcW70CptxjsRQmlSxNA0rT958UY/2FsXnxYxSjyolkSkrjkl9XPHF1tgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1SOwFystKE2ge9VOH9hZodBnZUTd3lqqDhPpMuPs5Q=;
 b=lGELpFiG0MZIvFrcxQwLV4VXcCNt2l4ArObEw2PERI1VmEtSM31Il8180efWukSL30f6DsjnDOMmPLhl4CflFfO8rEcnqaq4cps9ThjODDfYtSOV8zJ+P+QaS5fSjZlJIfG/3pT/astS+6xbkr2v1ifn3bqiC1CVZmo5DEneTqU=
Received: from AM0PR10CA0028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::38)
 by DB9PR06MB8122.eurprd06.prod.outlook.com (2603:10a6:10:291::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 10:53:40 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::10) by AM0PR10CA0028.outlook.office365.com
 (2603:10a6:208:17c::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 10:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 10:53:40 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Tue, 24 Jun 2025 12:53:40 +0200
From: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH v2 0/2] usb: dwc3: Fix TRB reclaim regression and clean up
 reclaim logic
Date: Tue, 24 Jun 2025 12:53:11 +0200
Message-Id: <20250624-dwc3-fix-gadget-mtp-v2-0-0e2d9979328f@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJeDWmgC/32NTQ6DIBSEr2JY9zWASn9WvUfjAuGJJFUMj9gaw
 91LPUCX32Tmm50RRo/E7tXOIq6efJgLyFPFzKhnh+BtYSa5bLmSAuzb1DD4DzhtHSaY0gK14Te
 tdH9tjGJluUQsjcP67AqPnlKI23Gyil/637cK4KCbFpXF4SL6/vFCbzQ4DLRRwonOJkysyzl/A
 Z+h8hbBAAAA
X-Change-ID: 20250621-dwc3-fix-gadget-mtp-3c09a6ab84c6
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, bsp-development.geo@leica-geosystems.com, 
 Johannes Schneider <johannes.schneider@leica-geosystems.com>
X-Mailer: b4 0.14.2
X-OriginalArrivalTime: 24 Jun 2025 10:53:40.0072 (UTC) FILETIME=[3E96CE80:01DBE4F6]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A7:EE_|DB9PR06MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: d9211e6f-4442-45fa-7065-08ddb30d613c
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHpzQ2Z1L2tBZ3BJU1pkbzZzRU0wRHVFc1E2QTByRXBHM0lQUTJ5KzlEQitJ?=
 =?utf-8?B?VE9MOGF3cS83OTFqQzY2amFHY005eTJNYXFXa3JlZEFkUGc0aUUxWHIzTlk3?=
 =?utf-8?B?WGZHY1YxOXVYSzlsTnZaMlNkNkhUYWJBa25rVlYrQkhrUUUrbCtpV1YvZkly?=
 =?utf-8?B?UlQ5TEtkL3lGcVNBTjVXRnFURWVRWXhPUVMzS3laWEY4RHBzOVJXeGszY0cw?=
 =?utf-8?B?MFdpelZsZGJ3Z2luc2ZxUEZIeVp4RFBWYytHYXR4UkVIek1CRytMczY2QkE5?=
 =?utf-8?B?ZXRnWUhUclpVMUtGOWRMMXlFQ0NyYTJCQ3VJRzlvaFkxb2Y4NjJVNTg5TlhZ?=
 =?utf-8?B?L0MrMm9HcTVkSmxzdDl0OWRhTDRydHo1cWNGU1JTREJKYXB3ektXT3RQeEMz?=
 =?utf-8?B?andoeGl3cnFmanNMMmM2b2xGdWJjQUMzZ2h6UzZwMnV2THdrcmc0M0FQQ21a?=
 =?utf-8?B?aXp2WEFMQ2Qwa1BJT2dFV3RFRDFleUZkL1pURG5FOWFvd2V2VnNkWXZRV0Rz?=
 =?utf-8?B?R1VHNVdrekptTlpXZVh0dU9VQ3JVOHFMZG9ycnVPbkU1Qk5uQ2hVZ3N6WTZZ?=
 =?utf-8?B?QXNjWURUSnNlRUE1TFg2Q20zQW5DSHBKaEgxOUh0Q1p0QkRtamc2NXI1VGpV?=
 =?utf-8?B?dTBzYVdHWklUTTdGLzlIK1pqS1p6ck8wdW5CTUhQRWhGLzNqV1JXb1h6Q1Fy?=
 =?utf-8?B?dWsrbTA0MnRKalZOeDRWOEQwblB2TXRxWTJrVlFWb3RMdS95SDhOMXhYanla?=
 =?utf-8?B?dTRsRUFRVHlIbnZMV0YxbzhHdXRialRCY3ErdDgvdXUxVWQ2OVh5ZWtDZEZV?=
 =?utf-8?B?YUN1c0txWnpKdXlleFhJTnFJMStmNEN2TVQ3NHVkWkxZVGtkL2ZucWNvUzRW?=
 =?utf-8?B?WEo4NytRaTVrQ2VESU5zU1dtTFRBQ01mTlN4WkticTNXOTZRRmRTRHdyemx1?=
 =?utf-8?B?T0RZV2M1c2VMSUNDa2wzR3FFSHJqWW03K3hScFdubDFlZFoxUXBUZW5aRWJX?=
 =?utf-8?B?Ui9IY3Z3UUJUM3ljS2VVQVUzOEc4NTNBMEMwVVZrT3pvdDB3eU1ISlNHTjh2?=
 =?utf-8?B?T0NkWWZ0NzJxMEFyaTBnREdrMGlpL3RXcGtwamV4S2NObnJ3ZnZmeEtodldj?=
 =?utf-8?B?MjFmM3A1RC82bDVKZFFub3BRckJzbWh2Y2lsam5iK3Y3M2hYZWRoejhqdHZU?=
 =?utf-8?B?TVZLVXBVbFFSRjBHM0N3UENuVmlVTENtMkFyTkVQS1o1cE1QZnFkVlRmQmRs?=
 =?utf-8?B?ZUZFb0NwZEt6eFh3R0h3SmhUaUtnUStvbUgwRldBOEZielVXQ2l1ZDh1Q05s?=
 =?utf-8?B?NTNGdGNGQUl1SXZTV1NtWUphOUxZd09LU21VMVBJdUd5SUFOa052TWFCWWFw?=
 =?utf-8?B?V3VZNU93ZDhuMjdoV0NpMDNNUXdROEFrOW5jUTU1Z2dMaHNDUHVUL0VnNC9K?=
 =?utf-8?B?d2haVXNvblUxUnZvdDRtRW9qR0J2M3pGblFWQkdlWmVGWnBSUGRyTmhrWU9N?=
 =?utf-8?B?QjB3NUp6endrODhuZFFPYTRjT1NoWStyamp5K3ovUm5IdWN6QXhIVkFyVGtS?=
 =?utf-8?B?VDQxbXJsUHJaQ2FiaEJWaGlqcSsxSDBldDNqWHFNa1FhNExBY1FqNk9sSXRM?=
 =?utf-8?B?VzhRdXVtSy9QL0h2aFlGV29pUFpFUGFGN3RtVFBlQ0xoQXRsbmNBNEpNbHNJ?=
 =?utf-8?B?TlBGblo0ZzhBNUppQ0tlWmtHYno0NVhnNkpjS3ZJSXFHVnRiVW81ZDRoUUtM?=
 =?utf-8?B?T3UvVUNPRkxxS0dLeG9SM2t5QjJDUE4yNGtzZ0t0MFZBTGd6UHdTcjR3VlNM?=
 =?utf-8?B?T2IzRHJMc3pKalVFbmU3NWZBdlkzOTF0Z2ZjS3FvOVBXQVEvR0huMzMvaTFW?=
 =?utf-8?B?QlBHVkRIaDZFMExYd25lcXBLV0NuNElnK2phZS9JQkQ1RVB3VzIxUFErREow?=
 =?utf-8?B?dUZsQWpxK25pU2ZjOUZiVUNZUFZTQWprUURZY0h1MzBoVFM2SzJ2ancwMXFv?=
 =?utf-8?B?WS9jTUlHcjhrNkNndGNkUlh3TmszZVd6YjJEMUEwTVdIdisvTDlqSWxqVXRR?=
 =?utf-8?B?YUdZeGRoTzZOSkNDcGxoNFpJS1Q5ZUZGam5zUT09?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:53:40.2847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9211e6f-4442-45fa-7065-08ddb30d613c
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8122

Hoi,

This patch series fixes a subtle regression introduced in the recent
scatter-gather cleanup for the DWC3 USB gadget driver, and follows up
with two clean-up patches to simplify and clarify related logic.

Background:

Commit 61440628a4ff ("usb: dwc3: gadget: Cleanup SG handling") removed
some redundant state tracking in the DWC3 gadget driver, including how
scatter-gather TRBs are reclaimed after use. However, the reclaim logic
began relying on the TRB CHN (chain) bit to determine whether TRBs
belonged to a chain — which led to missed TRB reclamation in some
cases.

This broke userspace-facing protocols like MTP (Media Transfer Protocol)
when used via FunctionFS, causing incomplete transfers due to skipped
zero-length packets (ZLPs) or improperly reclaimed short TRBs.

The "offending" chunk from 61440628a4ff:
80                 ret = dwc3_gadget_ep_reclaim_completed_trb(dep, req,
81 -                               trb, event, status, true);
82 +                               trb, event, status,
83 +                               !!(trb->ctrl & DWC3_TRB_CTRL_CHN));

Patch 1 fixes the issue by ensuring the HWO bit is always cleared
on reclaimed TRBs, regardless of the CHN bit.

Patches 2 and 3 follow up with simplifications:
- Patch 2 removes the now-redundant `chain` argument to the reclaim function
- Patch 3 simplifies the logic in `dwc3_needs_extra_trb()` to make the conditions easier to read and maintain

All three patches have been tested on a imx8mp based hardware, with
userspace MTP (viveris/uMTP-Responder) over FunctionFS and resolve the
regression while preserving the recent cleanup work.

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
Changes in v2:
- dropped Patch 3, as it did change the logic
- CC to stable
- Link to v1: https://lore.kernel.org/r/20250621-dwc3-fix-gadget-mtp-v1-0-a45e6def71bb@leica-geosystems.com

---
Johannes Schneider (2):
      usb: dwc3: gadget: Fix TRB reclaim logic for short transfers and ZLPs
      usb: dwc3: gadget: Simplify TRB reclaim logic by removing redundant 'chain' argument

 drivers/usb/dwc3/gadget.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: d0c22de9995b624f563bc5004d44ac2655712a56
change-id: 20250621-dwc3-fix-gadget-mtp-3c09a6ab84c6

Best regards,
-- 
Johannes Schneider <johannes.schneider@leica-geosystems.com>


