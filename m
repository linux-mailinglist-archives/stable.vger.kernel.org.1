Return-Path: <stable+bounces-158375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E5AE62FA
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9557B0294
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC228B7EC;
	Tue, 24 Jun 2025 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="cMzRwScY"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE047286D5C;
	Tue, 24 Jun 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762426; cv=fail; b=BD7fJ/e3iwPt+mXDQf1XvvgZMv+2ymLTtIx0j/KffgHe4PtvjTIUNKYmF5D/3+kzkbXfHgjRpPafM/9VIzIH4ItxvL5ijZiwiwgLmh3y9seIyffekYmdqBjNI6LDJQ6rn9y0wHuHqABwo9wJIlOhV9HcNEWrFtaEwqCriyZXQmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762426; c=relaxed/simple;
	bh=ySmdgbjjWwzam3PMv1W5Jw7m0nltGPcZ1Z8QHn/jQ3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PnW8F/cO4QCS30csaI/1O92+Tl+Y/IbQFf1cW4UcfIMcKd/Ti4J8wNwxK3Mj2NSbWueDZZP+VdtR0IS1hck2/5KGRxUfDsG1pOaDfgxVrcbuhrKFz3fryl78ZLCWJ3iWJpqHGtdsPPg2sAP6+Gx3W/4ltkNeVJ1BLEA12WD/xws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=cMzRwScY; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZ3yOp1mDLVty04HtQF335P8BILCeALs0Wp3fAarQ1iZLOvP48ExjrHadZkGlbGybUgUp2EfOaFg8u9ftQih7h+9EVlOh3ImuvdXTyMa57nK9FUnG6UZF3v2Pp2WTrW6uRwmSdaiR4OY22JEFfGOwL1TAtqSAB2F2t22OIgKcxgJeOuPWs5jdqsWYTFvw2r8Q6SNn4Kr6a2pDU5qaXGvkTG/fhRhXgHYJrWPqa9jvebNRJ7IVcRU+Y4cFRIRbeJ/9jKY5JEhW71nUdVj5gxLwpQY1bIftVANFexDNFceM9eOOhvN2f35VLz2Br0idRkUvvneQJ6hAdjhey1BLrGG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93AtsQcPW0Y617Zyhl2dB8W5wyfiml0H6iqU6IKuvLY=;
 b=B9w4FsZxFyF+/+QkfCCRApv4JRaQIUcJOz5tIac7nvZLQ7gU3vrGLqoPhCKrPnbthnyQ0Yza7Us7CxIU4VLXC+ea45uj5pb0VpeMbz+nK++3UTCr5H7w0QHJsB6QVlbUowsHz32vQjnAOE0fQN5gYR8zGneabBoBfqe25WAmBDSM8OLyHj/IUW3dD2U2NUMQRz9UsOt63NAKMwTSLgxCm3To3f3rTZjCpEEWG5RxX1LNs0G3p7SyWkNpTc9tae8C++WWGb11cS6S07pTrxMJiqR3GiB2RDqIJ2ENX3RVmki9yH1XYhezvqFOU/rt0ylUrgJxNgXYpQXD/ABzYOaIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93AtsQcPW0Y617Zyhl2dB8W5wyfiml0H6iqU6IKuvLY=;
 b=cMzRwScYuq5T2C2DR62Q356fneZTzUOxVWVV5Is8e3b/tVm5OM6Bqw/SyirTEyETn9Kbuq5ycID/HM5cSnImS7Yj+2uAR47/GDgzOwFmeEbs985DF5/MfiJvwDPzxj3ETFpygL41xZPkN6Lw9Mub6SMBzFiqgZ7vFYG//lHijk8=
Received: from AM0PR10CA0023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::33)
 by AM7PR06MB6705.eurprd06.prod.outlook.com (2603:10a6:20b:1a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:53:41 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::c0) by AM0PR10CA0023.outlook.office365.com
 (2603:10a6:208:17c::33) with Microsoft SMTP Server (version=TLS1_3,
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
Date: Tue, 24 Jun 2025 12:53:13 +0200
Subject: [PATCH v2 2/2] usb: dwc3: gadget: Simplify TRB reclaim logic by
 removing redundant 'chain' argument
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250624-dwc3-fix-gadget-mtp-v2-2-0e2d9979328f@leica-geosystems.com>
References: <20250624-dwc3-fix-gadget-mtp-v2-0-0e2d9979328f@leica-geosystems.com>
In-Reply-To: <20250624-dwc3-fix-gadget-mtp-v2-0-0e2d9979328f@leica-geosystems.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, bsp-development.geo@leica-geosystems.com, 
 Johannes Schneider <johannes.schneider@leica-geosystems.com>
X-Mailer: b4 0.14.2
X-OriginalArrivalTime: 24 Jun 2025 10:53:40.0119 (UTC) FILETIME=[3E9DFA70:01DBE4F6]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A7:EE_|AM7PR06MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 76775d22-3dc2-42fc-0a40-08ddb30d61e8
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0YzWVFWR09RSEd0ZWZ5RThEc1ZWMUhTUUIvNUw0YkViR3hCNWNvYTJhZW05?=
 =?utf-8?B?dEpmWGwrbmN3TlZUN3JPVnZVd0tZUE10SDdKRjRqWFJkck1qSzlPYzV2azZl?=
 =?utf-8?B?WjIrUjJyQ0VmdkN3WFlyN2IwOGxOdmNFMTRnVFFJV09zYy9PWkpJZUlaVTFx?=
 =?utf-8?B?OWdHdUxObFBGZzZleHZCbG9OYTg4TzdQOVF1SjFuaGN2YkNidmtncHQ1czVx?=
 =?utf-8?B?b3g5b3A2RTEzek9KNmExdkpsMXJMMmFBd05UcmZqbUorbU9ZQk5PUERnTkM4?=
 =?utf-8?B?VWxtYXVyaytFSS85YitSaUtmSUN6QkZZOXZSTEg2b1VwUVZGTFYxYmdxNXNO?=
 =?utf-8?B?bDdNcFl4S3NRRlJMZHJlU3VIQ1JPc24zQWkybUtKMUlqeE03SEk1Q2daSEF2?=
 =?utf-8?B?dC9tcmlSdzlqTVRCU2VoWW5CY0xBZ3JVVGZOTjJndjhtNFB4SHV4RjlURnI2?=
 =?utf-8?B?SkpuUUpveFBkWTlGblVoSlYzZ053N3llc0hVQTJzUEcyNTdrMHdSQ293ZnNT?=
 =?utf-8?B?SWJoVHpXSlhydXNCRnVBSlpmN0t2YWRvaW1COGEzVFp3Qmc4RUxMQ0FIbThF?=
 =?utf-8?B?R2lFdE1UMStWRHNUSUk3dGtiMmZQMHNMQ0NvM2FhYm41THY5azlpTGJuTkRq?=
 =?utf-8?B?aGcvemp4MFlJQUY4ODRGTE1ocVM2QzlzRUJaWW11Yld3MnJpcWsxNXkyMlBw?=
 =?utf-8?B?VGppUUJEUzg5N0diWUtteXVPVS83V2xBNGptMmRIV2JrQjdBeFZqTkVPNUhS?=
 =?utf-8?B?R0w5WEdKMnA1bWQ3b0RJaGJQU1I1aUxnVk1yYTFQZUFuWi9XMG1kckw5bW10?=
 =?utf-8?B?dnM5R215MEV3cXEyOWxRYS9oM1Z1emF3SFV0cGhXNG9McjFDUk9idUdVOE03?=
 =?utf-8?B?b2dZRlhXeXdQV2t6QUZPVWxzays4U0U1bkhpUmZ4aWhGMExmMlZKeWJwZWJr?=
 =?utf-8?B?Q1d2ajJtc0lDUnZIb3Z5NHptOTVoN05rZUwwcWw1d1Bxa0JPdm5wRWx2dGRP?=
 =?utf-8?B?dzZhSWxNRkU2YWEvb242WHpKU2lGeDVuc0FSUmZ1eU5Od1hjc3VZMXZsNGI1?=
 =?utf-8?B?MTV2NE12MGpWZ1VHd0EzY3ZjREtVQnlvMTZ0ajVpNmgyRWdKR2xtUTFESmxx?=
 =?utf-8?B?Z2oyWG54RFpJTEp1cndTV1VaTzVyaVBLMnVBaWF1YlFaMEVuUGxLbUx3dWUr?=
 =?utf-8?B?Z2tSSUdrZE9MZGhtOEZLWENqZ3JpTE5tVFA1UkovVjRhTTlQRjQvdVJwcUht?=
 =?utf-8?B?cXJzUkN0TmZDTy9nVU11a0pncnpvWHBad3RBMnVpOWtqQ04wNkFVODJPTjFD?=
 =?utf-8?B?RXkzZkNhaFZ1akJYSWx6QVVTNTJBSWJhbUxTdEhqSkhlanRYcEgwRUI5WTNo?=
 =?utf-8?B?YWMxY0ZvYm9vaWRXT3pDQkRuZ3FPK2ZjL0U3eFZLZGNxNkZocVFaemhtRlNT?=
 =?utf-8?B?Ylh3S0lObEpCSXFpeEF1SXNCZ3FCTlRUTUpQTEllSjNQc1pDeEtOanpIbFNY?=
 =?utf-8?B?U1crRGtQQkZjUnIyZklpK2xReWg0RFNrakljb3U1UXpwZHhUek4zWk5GWTk2?=
 =?utf-8?B?VGtvbUxXT0N0bEJvSGo4R043a3hvTE5LMVZyNVRDcC8xbnNvNUdMYU1MaUtk?=
 =?utf-8?B?aHpmdElvdVAzYjhpVlc4V2FlWjVibkt5K0VjT0Q4VjI2WGdlQ2tpSHBxeEVv?=
 =?utf-8?B?RVIyb0dOQis5aW1vRTJ5ZTA4bHd4SUgzZTRrajZmTEd6OWZiZG82MDRraVBa?=
 =?utf-8?B?NFJuWi9LVGZjd1crNy9HK0diN29lWHpIYXg5QjIvTWpDYnNHNXFwbWdZQVFI?=
 =?utf-8?B?UlVqMzMrK2UvLzRVTVhXaXdweHNERjNnMkNqRlNJT25JMnV0RWVkZW10Q1dJ?=
 =?utf-8?B?WUtRdHhjT2I5bllzeXFSYXRhTGM4b3dBdkdLNzJIZ0VaZFpvYXFROHIySWxi?=
 =?utf-8?B?SkZSUCtOcTh1MDMwR3RGd2I1SFJjUGFIYjFYendEcVhCWjJVR1crQUIrS1dw?=
 =?utf-8?B?TGdzTFhRQ1ZqSFo1dm02R1RaYk5hcXZaTWJsdHBjZ0Z1SEtDSVRISUVvTkRN?=
 =?utf-8?Q?DcydAn?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:53:41.4017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76775d22-3dc2-42fc-0a40-08ddb30d61e8
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6705

Now that the TRB reclaim logic always inspects the TRB's CHN (Chain) bit
directly to determine whether a TRB is part of a chain, the explicit
'chain' parameter passed into dwc3_gadget_ep_reclaim_completed_trb()
is no longer necessary.

This cleanup simplifies the reclaim code by avoiding duplication of
chain state tracking, and makes the reclaim logic rely entirely on the
hardware descriptor flags — which are already present and accurate at
this stage.

No functional changes intended.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 drivers/usb/dwc3/gadget.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 99fbd29d8f46d30df558ceb23d2afe7187b4244c..a4a2bf273f943fa112f49979297023a732e0af2e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3497,7 +3497,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 
 static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 		struct dwc3_request *req, struct dwc3_trb *trb,
-		const struct dwc3_event_depevt *event, int status, int chain)
+		const struct dwc3_event_depevt *event, int status)
 {
 	unsigned int		count;
 
@@ -3549,7 +3549,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if ((trb->ctrl & DWC3_TRB_CTRL_HWO) && status != -ESHUTDOWN)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_SHORT && !chain)
+	if (event->status & DEPEVT_STATUS_SHORT &&
+	    !(trb->ctrl & DWC3_TRB_CTRL_CHN))
 		return 1;
 
 	if ((trb->ctrl & DWC3_TRB_CTRL_ISP_IMI) &&
@@ -3576,8 +3577,7 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 		trb = &dep->trb_pool[dep->trb_dequeue];
 
 		ret = dwc3_gadget_ep_reclaim_completed_trb(dep, req,
-				trb, event, status,
-				!!(trb->ctrl & DWC3_TRB_CTRL_CHN));
+				trb, event, status);
 		if (ret)
 			break;
 	}

-- 
2.34.1


