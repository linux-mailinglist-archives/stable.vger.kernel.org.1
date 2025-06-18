Return-Path: <stable+bounces-154648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A5ADE77B
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 11:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7096F189C65C
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CE2280333;
	Wed, 18 Jun 2025 09:53:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023095.outbound.protection.outlook.com [40.107.44.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE827E7C0
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750240411; cv=fail; b=mAitXFeFyPUWA5Z8AO1Ufdwg+ULOmRU1qF7KoBwRUAGq/F0aOOTN+urKqNVkqjXACdxNGfhgSBD2EYMbGXKXwWfKlk+bVz9qFMl6iL9zpWRMl1XNPBaEC3GvM+LrV98ayxMUAYAbnyF8Iq4YA6Txm+HukvjbTokSiSi+ouXXryE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750240411; c=relaxed/simple;
	bh=1Hu0oi0h4P0uv1BfD9QXyvnMmwAWs6HNpSDYq1MflD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=svR8hvDh09B9cwLmaggs9pcC9+MipElGIOQTwbjhJoSD5tyZp65vqmhIWc22UxSZRMK4xg4TYC6mrpD5hTvjQOLa4+3E9A3mLfH/Yr6KokeVki4e3nHgDZMUZKL3tWmmP1hbxyChskHXUs07ic0lN3zsFGliAWkSZZfTEmLNRGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6NHPiFfJGSpm1Bla2j7SHxki0UucB1nx/KWlNmYvDK9j96wWdNG6Dq7fi1BugrMK/p6a6hStKtkpMH+oEC/fJA56/XgiPfIijrb8ijaaqNduRkhalaBvpamokPPeXTAs1FH8AtXrl0gaSL+fIhbsWIL6eConxhtxeR3IX4xg7An/kid0b9LW/yUWuPP0S0w+NWAfJwiNgpF8SH4pgDK9no2J154t9K3pmKRKrC5Bpni/5rnIhrOX1OcJ48q2qj0m2a/xOxZ315P/DxByyblFAQGyxvIAPWzbvcYO2l+ywlAbbBAXshjwddtTllUz1xlfNmzUDLya8hFQRFR2CuXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVwR+eVrmCiJOgsKxJnI0nfX4dEuRH/i2YjMC/w10ws=;
 b=LbXWlTuvsBXktVTTNyAop3BByCYWcPVoAzz8LV5WQ5pgnHPsGZU7sRG4J4nn5eSUdn30fVTOXSL1rImSTNdz+6GxG/Hs2TCYa7mVVb9VtB5IOJ29H8fsRVzqEJ7w8/8GGoXwxPxY6Z6ROwqz8+h9zzDVt9Ol5FO1tPQKMtrsfYihw4p0tIX1PBQtD8oECt0V0bu+seW0F2yGzbHaC4G8efri81yprqoEJnK/UUTAhbZ+e8vRfRGlon6Mpb2OqcSamSAsZnfOI1W/dA5SaAprt+YrnTDgzmMXerDnRCukBRIHPgWrsBOGAM1guU+Dck2LqWuqP8xeDf99Z/JFyPM1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0059.apcprd02.prod.outlook.com (2603:1096:300:5a::23)
 by KUZPR06MB8023.apcprd06.prod.outlook.com (2603:1096:d10:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 09:53:23 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:300:5a:cafe::3d) by PS2PR02CA0059.outlook.office365.com
 (2603:1096:300:5a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Wed,
 18 Jun 2025 09:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 09:53:22 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6CF6544C3C84;
	Wed, 18 Jun 2025 17:53:21 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: fugang.duan@cixtech.com
Cc: cix-kernel-upstream@cixtech.com,
	Peter Chen <peter.chen@cixtech.com>,
	stable@vger.kernel.org,
	Hongliang Yang <hongliang.yang@cixtech.com>
Subject: [PATCH 1/1] usb: cdnsp: do not disable slot for disabled slot
Date: Wed, 18 Jun 2025 17:53:21 +0800
Message-Id: <20250618095321.34213-1-peter.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|KUZPR06MB8023:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d9391d3-852d-419b-3ef7-08ddae4df690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0qZ7mWmF9TUhv9ulvuG2KdFsGeu/D7Q+sZ1FjzSrRkmffjpFXKp6dMmJUsM?=
 =?us-ascii?Q?RRfdDvYnuz1LP1VMPELoUqx2g5lNspvyhWHBEXcvHGzGuOdxjzkbqcOihDqG?=
 =?us-ascii?Q?6PYlByckmlUxovhWHRmTweVA7sj+8Idi7RryzrtZRb6IuaFSTdIPZNILFF3G?=
 =?us-ascii?Q?N53vKvJ45nTsp++2BZfJ/WzUEmx4XUL+i8H/sqpPWUp3I8Q1MpspDNC0BI7b?=
 =?us-ascii?Q?2csixIBx69/8J1xWX8vIZCRZO/JhaoVDCWRBv/afkrQ0rmeDnl9JmVy/mdCd?=
 =?us-ascii?Q?aAT2JNikxy1VMYEWEGhIK3SEB2DBLRWVNrU3RzT8CpH7hOKD96QzdmtztYz8?=
 =?us-ascii?Q?Vhz3FkLpWZO9Ch+/rSUWTVXY7GSZJIyC1Ufb6kqbZ7LTwVyP3ToJrQiUPihp?=
 =?us-ascii?Q?dem40IVJ9Y55WDQ2gJ3zzAPNp7FDsxPr4cfPHVug7Ywvsr0ZAqQ+H4/1xc0S?=
 =?us-ascii?Q?CH+xZeS0DQKEsmjMvKctwj/YeW30pitXmQQjfXgwnWSYbZtgi0U53pP4QlAA?=
 =?us-ascii?Q?3CS259kKJ+gTWWgybYn0g1toufsFiTYlHgch7dKOejdcVGMnK9eCmcIX7/CB?=
 =?us-ascii?Q?draoqiULsBwlgJFzPNaprSqd8SXBFnmUPscTTV0+n8kk6y7RH4+brChg5g1d?=
 =?us-ascii?Q?X6xbMyxKFRugg+KZgJX2XohHQMVzA4JKTWWhya9jxCTbPtknkjm+dxzfP6UU?=
 =?us-ascii?Q?CbD1hcr9en6PU1bEcyFP3PT9zMKntaxv/03CI++EuZf4geGBg6fHQVt0N/GR?=
 =?us-ascii?Q?UmgGz6PMkrk3eGrHOt/kK9IDYjUPqUfWzwwEYPtGZIUDBxvAV/F/45JZvMNs?=
 =?us-ascii?Q?a6X2JwJrJlWM9/ed6+GSyRILXglOH5gsquE+ACXWuOnz2F1sGuASN2rUnkx3?=
 =?us-ascii?Q?/DRie7Oe/aKJa49sVcucehCoIojgQQm08DoZ4pO60sWe4wi99sijVFO0uJtd?=
 =?us-ascii?Q?EDdP2H0eLj2/6FbUmzA5Y7XaufssAq9VQDS0rmLnebyBiuBv4Jaqj3SAT47p?=
 =?us-ascii?Q?Z0zc4u8LKBwlXX+/cI0OjLgAKHfDO7ya4O1rXtmTATYKbXAFpoTdqi5+FaP7?=
 =?us-ascii?Q?fVegNSLWqeZRuC2GnV34jhdUMEK8Mce60QDVIv6ESvjk7g0ThRa6+UFXcKCe?=
 =?us-ascii?Q?dHv7jgF9aqW+oYczmMVP6mqRtwnk4OmoCNJcmg8lCZmCUOgBOo9UrBxI4uih?=
 =?us-ascii?Q?RU3EdmC5pdi02zHlis3U6i5Azu2uq3kuNgn5PrQQZ3KYbOrmPC6sRrg/2O8H?=
 =?us-ascii?Q?BdK3wO+ZWqKaYGYr8oq0+yEgCYI2yYWiZBDUTgeM3sOB5MHVFatNAJ1HJz0L?=
 =?us-ascii?Q?DfCA89QQqzvuiJgEVP2UHs8t5L0x7BuqbFlwwyOE4v1RGEgx9MWS/nn5XnX6?=
 =?us-ascii?Q?TJZkm5UbdGSKLT1qn3ywkKu03/mf9uC30ojw6P3Ks6DoRrghfZUvOHRrTZVw?=
 =?us-ascii?Q?/OC5a6mZu0papX7xnvhi6ZfAEiB/k6OD2KsytyzLGTlMYpWPFXAgCz+PgLOV?=
 =?us-ascii?Q?0kbO///ipbjMUNrjjnk7volNx3aipZ8Pw9Hr?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 09:53:22.6337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9391d3-852d-419b-3ef7-08ddae4df690
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8023

It doesn't need to do it, and the related command event returns
'Slot Not Enabled Error' status.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
cc: stable@vger.kernel.org
Suggested-by: Hongliang Yang <hongliang.yang@cixtech.com>
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


