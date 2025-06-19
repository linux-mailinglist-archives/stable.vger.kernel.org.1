Return-Path: <stable+bounces-154717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3A2ADFAB5
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 03:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7618A17AF8D
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE617A301;
	Thu, 19 Jun 2025 01:34:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022075.outbound.protection.outlook.com [40.107.75.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8244594A;
	Thu, 19 Jun 2025 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750296863; cv=fail; b=jIUF8wpAJHXhsoy06qU8qpEu+jYDedNNOm6gDdI3/Lll0xzFlhzWx9kDyXgMaP1ojSGLMOb2mKI344JghU54Fmwe7PjuFk48JMFtMg8AnXVBcIvbdnM7jR3mBM56krdg0AOcHXUyZvz/4jp+6vhYE07UOi6HH4rrKvttHVES7Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750296863; c=relaxed/simple;
	bh=5MlWP5wEfJhDb9uNcS7r8vaKjoAmEuVtT6rydw6wSUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YHEkdsPFIXUQDheiEr7sxzSceOuwrqZPpb10DhTKKrhygbXSJSN91PIH8qm79oX/BBz3V/zAakhHE8xvpGI4/rI0TPA4Kpqp81bpipcH/ZJPXMIi2+bNEi3mzm/7ItV2ScmkTTAGfNyPpdHBcpasC17rWo8Q4hI5DOLqoPY/Cls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzVhrsI8OgywaKCbQTcvLv+tDUdvtszLW1YgkrAafon+JFCVAuWlrSL6tfhhWp5a++G9RkI07j3Wv0CvcwxqHYt4JCtFi7ULOuIUT1hI9/7LRBlcszB5tR0HlBnBHaUnX4ByDI8zj7PYOA1JZ1ptCQ3jTd2mxW+BG2JRJuC2j6WFkimo5bBKzq97VP7XIwNWeBquWNj49b8v6VaZ2oSVNGRP475v8TSRLIJOcmI2muLOailpmu6FoX2PJn2aIkoQo3sqfgRu8EH4/9qUQ7m9wgYxFvg9v+xYfljOEtxXMwxVA3AO2NmWuMcmFDYPYx6TBhWHPlMSCgXJ0vXp9Q46MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tpn0WqIw2PceV2rvmzuZPiP5zry1deUIa9t+JOlrHJM=;
 b=l3ejd7f3xyd+hzG5vddvJINtgN05qk6Cobz/XDbyREwDNbtSqLdsIYFCEZcNwm+9pd0/PS/B4Tj05qCSxjEfAypRkWx+TEzXB8ECO9nzjdIHAu3T8ruRUcX8Ou6t5prcYhWOl9rNEVHECQbYStpigs9h3E69b/MRoY0tkUpARNlA10LToszHrHx2kbtfVN68pB1xRGHfPOsHScNtLnyPtpLC11JRhFdMQGSbtJtK4OeQHvIQDYCcIsWjBcoL1EtGTUVgfHPDVgPQk9nCrF6HHhcWKQ019hmGjNHOLA+DZwlP4WZMmReVGl2Z9T0V2Ge7Z56xSKq20TWwPbfl+wTY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16) by
 TYSPR06MB7344.apcprd06.prod.outlook.com (2603:1096:405:9b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.32; Thu, 19 Jun 2025 01:34:16 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:c6:cafe::56) by SG2P153CA0047.outlook.office365.com
 (2603:1096:4:c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.7 via Frontend Transport; Thu,
 19 Jun 2025 01:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 01:34:14 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9A51444C3C97;
	Thu, 19 Jun 2025 09:34:13 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: gregkh@linuxfoundation.org,
	pawell@cadence.com
Cc: linux-usb@vger.kernel.org,
	Peter Chen <peter.chen@cixtech.com>,
	stable@vger.kernel.org,
	Hongliang Yang <hongliang.yang@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH 1/1] usb: cdnsp: do not disable slot for disabled slot
Date: Thu, 19 Jun 2025 09:34:13 +0800
Message-Id: <20250619013413.35817-1-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|TYSPR06MB7344:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8ae81e76-86fe-495b-2e32-08ddaed16690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LoZeO6VnmuWJ+su6gL04275hgQEZ1VMtzM8A4s926uSf2H/9ebnvRCXRI1Lj?=
 =?us-ascii?Q?oX15Cr+mUgDNcyjyB4rYobaQELE/vupYprGjLMzewZh5DKR/f2A00CXynziB?=
 =?us-ascii?Q?jOFdVqeFl2PQM9Qok20k7YjKI0gkqTcYosn88QVGAvwyBjl2agJHc86rd3Zi?=
 =?us-ascii?Q?uiUha6Bj104v6vzR70igWlwCneScu1HqYfqVmA4vha+AnZwpibEAdjsJM/ri?=
 =?us-ascii?Q?iPFmsQ7UJXjkYRUxgn0HBg/V2TLvlAOXVxET8FMFKOLWNtBIgVG0+dUdhrDx?=
 =?us-ascii?Q?Tk9CU8ZlMCrCzrASWYco/w5YJJFC9SCh9KQSdq2CtnJ0/32w8Bbczh41oQib?=
 =?us-ascii?Q?kZCit04ckbkDx+lvL2zmx7EfCYxnTIB1d8hap2ohlCnV94oJNNobZXh7vY0a?=
 =?us-ascii?Q?5cSAvotiTuuNlo0AZKj56oAJ9acjthR+1yq4HvrPQvjf1cJIFLto7ccJYC5g?=
 =?us-ascii?Q?AhcvWnA/i2rXenaPZJFPmKN4ReLRkLOLC+LrXVu+aw0oqsD+FOeW3nB3DKZF?=
 =?us-ascii?Q?bY1IgHDI4JhT4MO2jtNcVmc5MceOzUCIVKN8i5+KnbcgL+0rERM/WeiOYwi1?=
 =?us-ascii?Q?UtIkmBsDefzRVJOjS3SndhjqpsX/s17/YshM0ZPISOoLiezT16kXYn6le+bW?=
 =?us-ascii?Q?dOC7DQF1n0m5AbSi7sOzIgdPYV1syJOEaQtRwsWdxQhLuuSeUk0ZMWVp7fjy?=
 =?us-ascii?Q?haiPebeYykQ8HwxUz9GuHRk8DilwYWXWZZJIWNydhQyFRuyIC4wYoptUG253?=
 =?us-ascii?Q?aKamiSS1SktG6FPxnWce+6JedbRBDaRNXq7tBllqRs0Of3MdIGUP3QudQQ0E?=
 =?us-ascii?Q?+NKGYOBvDqVSB5nIBNSNl5BByLDCqgEFAl2upA9636S+0M/0m0cqC2WtQXOm?=
 =?us-ascii?Q?V1W18T+4+i7a1cFRJF9+YOwM8i9EGU6iOmIxBHO7SAWlDZ1A1wsestlE3klo?=
 =?us-ascii?Q?eY7a2lsIDPcqWczuR8ChM+auPB1Gg4KV8SjtHNUNPN/8zlEzu/mhXgi/dnU6?=
 =?us-ascii?Q?YmZYtDtj+y8NXQaSLzJVJ1IYqnbVaQgXyJSps1hqvt8tL83Tkco9qkJOm1vD?=
 =?us-ascii?Q?yaJN6PfAHi4Nz1llc/aAs8jrs9dvNOmzKUv+TajY0DOIN7dq3SOoNdCoETf5?=
 =?us-ascii?Q?1BwYl2krieJdaXfcDLmrJQ4/PZwC0SdTkU/qyiyNRNPT6SKI2FQ6Sd8jTOrS?=
 =?us-ascii?Q?mwR/uc2jV8rdyj8Zuyz259Yz9A69iJP1PKtbrbKYlQIAvFNqXNLCP4C5O0TC?=
 =?us-ascii?Q?78f5DyGHUf2w3D7zHUppUjj80x8U2NXQggdiaJ74F/e6G/jskpmiBXoMrRpc?=
 =?us-ascii?Q?BmE0g87VwC7Miq5O0N/5H0Y3VnESoMgcZI5S2Er5Wn99GQ+6OUo8dhVMaPMV?=
 =?us-ascii?Q?ZFnXnhDCdk1h/lJ0Rd17AoLYPxoFbUIHRYjSluqtitmEhfUGE/gSvnD3fWGZ?=
 =?us-ascii?Q?yFPy584vNMK+jxvlnHUERx2ko05xQRnHJfYN2gdtKZUx6Kb+ptCNgRUSYqvt?=
 =?us-ascii?Q?Q7AvhU3jKINKTB6Zj4/pukjoqBkbDeVRjEI1?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 01:34:14.6954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae81e76-86fe-495b-2e32-08ddaed16690
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7344

It doesn't need to do it, and the related command event returns
'Slot Not Enabled Error' status.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
cc: stable@vger.kernel.org
Suggested-by: Hongliang Yang <hongliang.yang@cixtech.com>
Reviewed-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 drivers/usb/cdns3/cdnsp-ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index fd06cb85c4ea..757fdd918286 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -772,7 +772,9 @@ static int cdnsp_update_port_id(struct cdnsp_device *pdev, u32 port_id)
 	}
 
 	if (port_id != old_port) {
-		cdnsp_disable_slot(pdev);
+		if (pdev->slot_id)
+			cdnsp_disable_slot(pdev);
+
 		pdev->active_port = port;
 		cdnsp_enable_slot(pdev);
 	}
-- 
2.25.1


