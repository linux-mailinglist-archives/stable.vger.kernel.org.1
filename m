Return-Path: <stable+bounces-69687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A672F958137
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A5B1F248B1
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 08:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E475918A930;
	Tue, 20 Aug 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="EMo02Lu0"
X-Original-To: stable@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646818A6CE
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143475; cv=fail; b=i77r1x2S/vyjVK2NVfWXLaxt+c9mAl7uQ5OdQIaaiHz2WKWw9wxoZPnjgbvnnMRcXO13jol2LrtK9Ow6s/+dKVbSD7Uiavku9/BS5GiHVQCVy8N+L0v6Pf6OZNpXPMxgiH6rodx0luB+szLkP2Vmm7ZeoNqekhoaWwZSUHqAEK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143475; c=relaxed/simple;
	bh=lIApLR1v191ITwGf884nRS1tO2mo6QndsjUPeOyxcp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTdBRKQXQAdjPKNfTBUYYwoyRG+8kUPWekkW5G4pwIUOXjH9suZ7ur+2VLMfbrR/s5GVIr5SpfWy9MaS1A35ffJwN00eO4ie33S/R1CNosLss/rxYo5q/GkqbIhWGjds5d/Ovf5sjQNI1D4l45XVHLBleu97/bJZ7vevSzhcZ8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=EMo02Lu0; arc=fail smtp.client-ip=40.107.215.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTcY0LMMXyYui4F9mZul6B/Omz2q8fghGspdjGgL5cFIN6dc0g7/FgA2DS3nwDPbsPdimpqCgLnQY3FzOPqBuWKB875a0Oy2+GOzltHZ6nuJp7ntVSn8sKQOplTp89Yu4FGNI1js6Pjtjryzxcy4Eq6WArwVdZCHSE0RAReEen+PxlNckzOF5QNkokJI4VlL9o+tG7x9SSfhcQmPFsZV7YEvpJilLRXahHBnCRSWmWpckGbBzxbp7zHgUDVvbstETSn8LUKyXartu3rQrPNwBOhecPSrH4HAETGaS/tEyaDaRQDbY0hNIroUrVnRDQ7W9BeWGjPFEbOb8ZU5YAsM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8we4DR1Ef+quPQ9GemhJDQK9BF2ITn1AMJjoEyPd5Y=;
 b=ftSltV+F8ssgiHTPoqVIsrf/f3mO4CuEens/EsY/6sYCVdIcweFGJQApMHv42PghhH6PASsgdvao9b/Kd2UtTeKoKbGNii0SPZxf9zp0h8JqH2eKhLmh9J1Q6ljHqjGMXxvul0aSN6whKuZnO264ihuTko5im+2vOxggKmP7IfKxkmQ5g8XTkZrxA/5kvGSFBVy7A7GmLBVvRfIZDiAiVguxSWYUypxqbhOap03Cx8DCrBu9wkF+8aTRz8YYBv7ocRPIa0q6uzUcroCMhNxPE/QJllXSNewtSNT7kZzS5iIu/XFXW7v1s6Avk7qQVlBj93su4ykOtItDxKYn5g1lAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8we4DR1Ef+quPQ9GemhJDQK9BF2ITn1AMJjoEyPd5Y=;
 b=EMo02Lu0/X2bf8nb0s/NZIiwgu8sJOyLK97qwNgB3Dd9tEVFbLDWJy9AFv3fxhD3l2vUPIHePyp+HCv09HPmtabiDxjdhqFFQIEphCfSGldWiBECsu6YO3xiQERySGqvXyfcWTLMnwWWGankOjVIXLl/nAk6/PFuULkAyics/Aw=
Received: from SI2PR02CA0002.apcprd02.prod.outlook.com (2603:1096:4:194::22)
 by SEZPR02MB5496.apcprd02.prod.outlook.com (2603:1096:101:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 08:44:26 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::27) by SI2PR02CA0002.outlook.office365.com
 (2603:1096:4:194::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Tue, 20 Aug 2024 08:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 08:44:26 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 16:44:25 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: <stable@vger.kernel.org>
CC: Hailong Liu <hailong.liu@oppo.com>, Tangquan Zheng
	<zhengtangquan@oppo.com>, Baoquan He <bhe@redhat.com>, Uladzislau Rezki
	<urezki@gmail.com>, Barry Song <baohua@kernel.org>, Michal Hocko
	<mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/vmalloc: fix page mapping if vm_area_alloc_pages() with high order fallback to order 0
Date: Tue, 20 Aug 2024 16:44:05 +0800
Message-ID: <20240820084405.18065-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024081917-rubber-cable-a9ab@gregkh>
References: <2024081917-rubber-cable-a9ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|SEZPR02MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ef2c62-b458-4d09-3347-08dcc0f44c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dfGBs58+c1ZlsvhHoNub3NSG9wo99qf4G/EBd/XaHyMDIpTuvamR0WP+kuX7?=
 =?us-ascii?Q?zNN0XYF8ICOKIa1D6SCeVarbKRLdOMMfP1Ra+YPgOE7FhZi09NWliZFnq0WR?=
 =?us-ascii?Q?avgA7r53zpUZKbaJ5MQYzJ+81fg5uSSLQ7SjH+M1B0TNuDeUhkNwqXzdztdA?=
 =?us-ascii?Q?0WwJ2aGMSKp5uOVtrY/GDVzD9KjIDRtKU7Jpeql9DMMG4jnndZBJw/hy+8sW?=
 =?us-ascii?Q?vlDtP720soOyK1iP8F4GlEZIevZIjdOl7VPA4RJpnXfGPWbafVTh1iZPOCvZ?=
 =?us-ascii?Q?oRwooEaNPoAnWChkq19JLQ4SkeQZN7hWBipsW9qrbaSOYRN8Hfnw05korHt/?=
 =?us-ascii?Q?CT3MtDbs/t7GWYgDxIWr9T/SU0Rq4Lewuhncj7RgDod0AydDQvmNGuAN15Wq?=
 =?us-ascii?Q?SaOzBdWEzsGMjxS8YDR4Tpff8MVpqq4BWy9HNJeSfT1Bw959VrliAot25GsW?=
 =?us-ascii?Q?vDYAz0c+cFhJcXrbuUZdEv5oZ7/uLvCZ8wHhqSm9FfPPO538iA3/H9lrhBrc?=
 =?us-ascii?Q?XeKQah7eWQFHHeHar5+pNO5LGkF7Hll049hwp2Ntc8BLB0wGFP0W4lcEeJUH?=
 =?us-ascii?Q?wnF4LUG8bocshwK45wWwphZh9wQrMlOdlakIXI49IpA2XV6JbuMMDfkf6Dgs?=
 =?us-ascii?Q?J8www6xon+o/qNSLUx9r2ZaIXdGJ0w0J3ne6gD4RCyRSNuSqk4y5ubRNAF7I?=
 =?us-ascii?Q?aW4o3EFnycg1/hTqeu/YVXY5idSP3EzKE0oZipoBjTfLYC7eUYhRNtND0oAM?=
 =?us-ascii?Q?zYlp2cLULxQ005cpufene7WKZCzSB2fVw6tna6+z9kKdMoXvsZVpkGUFXuTg?=
 =?us-ascii?Q?f2eGhYgz+YyjHEEoViCqL/R/dLeP5ETlxd627q9o4Fm7Kr2thBRmmAmvIS+7?=
 =?us-ascii?Q?DaAruHIvzZQYMTh9VEKqbtoQyjwMTdB0DOr5j2ESrGM55MLZMJ7efsh2Bj3B?=
 =?us-ascii?Q?MV+8CSgQN+JQxypDDH5tXrpf295Ow2haftBcUE6K2sNtWg9gOZd81SXiE+mp?=
 =?us-ascii?Q?F23gcMFDAiwBcgT9lvEfGI6J1mlqWV+Q/rGBz/qrIIytjDyZa0HaBAsh8fCO?=
 =?us-ascii?Q?hHXec2Sxy4PYmaia7SOe4RyVysxDV/Y7z9RRyzMerymrIffmxyzooZssNsVy?=
 =?us-ascii?Q?WD50Fxy8TtSqLd+0YbtDNxYvt48OIeJPyXj5WMB+r5g4DQKVv9oKTyOMcTua?=
 =?us-ascii?Q?amUG+ICjzJOx3dYhkyQkp+ubSZ2B+BJTGylTrrr5TT0eIc6oHVwmbPyYTX2G?=
 =?us-ascii?Q?lO/W8V3zzz1IVGfqYL56TyasyelRn4/QL3tQGc0rWECpOED9MOCW0Ymjv7Mm?=
 =?us-ascii?Q?UztpncGUUjbrl6j4z1XATPqG3qaBQ9UENftwU5SsyHmePx3VKKC6/SBCZhWl?=
 =?us-ascii?Q?EPtSO/gh22l7LDTLarbaFKvojYo1kx1de6ti8tz8INc66/8xXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 08:44:26.0390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ef2c62-b458-4d09-3347-08dcc0f44c1b
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5496

The __vmap_pages_range_noflush() assumes its argument pages** contains
pages with the same page shift.  However, since commit e9c3cda4d86e ("mm,
vmalloc: fix high order __GFP_NOFAIL allocations"), if gfp_flags includes
__GFP_NOFAIL with high order in vm_area_alloc_pages() and page allocation
failed for high order, the pages** may contain two different page shifts
(high order and order-0).  This could lead __vmap_pages_range_noflush() to
perform incorrect mappings, potentially resulting in memory corruption.

Users might encounter this as follows (vmap_allow_huge = true, 2M is for
PMD_SIZE):

kvmalloc(2M, __GFP_NOFAIL|GFP_X)
    __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
        vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
            vmap_pages_range()
                vmap_pages_range_noflush()
                    __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens

We can remove the fallback code because if a high-order allocation fails,
__vmalloc_node_range_noprof() will retry with order-0.  Therefore, it is
unnecessary to fallback to order-0 here.  Therefore, fix this by removing
the fallback code.

Link: https://lkml.kernel.org/r/20240808122019.3361-1-hailong.liu@oppo.com
Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
Reported-by: Tangquan Zheng <zhengtangquan@oppo.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Barry Song <baohua@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 61ebe5a747da649057c37be1c37eb934b4af79ca)
Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
---
 mm/vmalloc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 078f6b53f8d5..732ff66d1b51 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3079,15 +3079,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			page = alloc_pages(alloc_gfp, order);
 		else
 			page = alloc_pages_node(nid, alloc_gfp, order);
-		if (unlikely(!page)) {
-			if (!nofail)
-				break;
-
-			/* fall back to the zero order allocations */
-			alloc_gfp |= __GFP_NOFAIL;
-			order = 0;
-			continue;
-		}
+		if (unlikely(!page))
+			break;
 
 		/*
 		 * Higher order allocations must be able to be treated as
-- 
2.25.1


