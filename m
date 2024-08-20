Return-Path: <stable+bounces-69689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3667958167
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 10:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C301F2522D
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1B189F3E;
	Tue, 20 Aug 2024 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="IZslqChc"
X-Original-To: stable@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2062.outbound.protection.outlook.com [40.107.215.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E66176252
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143987; cv=fail; b=sj7Xt2/FZ4D1g7mkcJQvhZUIMB/oW9sY7zvFJRVRhx14o3YIoA+31rbEP+5cA4xL0iXV8twlirpLu7OTH9tHsGPuU/Vp1WGRsU1iI9oSdsJ//3Tn49P9pUF/YESzgPEY1ByoXvQQgN8gjgSwIjzsqUyLApSewKSBWkTolOPVnNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143987; c=relaxed/simple;
	bh=ckttR6XCnkZ2auDjNesp0tcZrh37TavewbqFYC5y67c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YT98nIQFVZd5kr0m1ij9gMJoaQ46qx2kw/kZkkKCeBlU7k1tEmtX99QZPz9U2uufu5Q8L5pwk2dJVSfb/m/s0z7QFGFM/qkjEmNBzUVhZWc0pWjdJ2uzgfeskm+8wQoGkgP/77bJQj3XQ8jvkC5HVarLkKmK/xdvq+lK+pWdmko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=IZslqChc; arc=fail smtp.client-ip=40.107.215.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDwVUw8uUJXZi76jynhtR7855g8yKNdvTyuvNDKnG7NxONzW2wmHkRfoqvdMGW6d4/sXmpSNO3m9Lk23Md+lhro82CiHU+szMjerfil1s/dind+cxsfbhPa98HclG0M8CBhYxvBOdTRmpbYmzW4eoN1j0meA+CvE/Ty4Zr9Mm5QreRCoPRwpTv2NtiwVoir8Qk9NT2s3iXUJk++cCE3CgdlsfewipfwERUCQFZ7vzqjUO7Mrus+Yz/uKxzvGvDPGSDfa9xRK3XXHL7B2wYf/tdDdTbp2AlFTAzhnskdvmaiaWHWBAQs6ArGblIBiiwj8neY6Zktm6V057JgV0kujhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by8E0ohKnD3HN7gahLh971O+HSHtF/pUuWUJ8No+YFE=;
 b=X0TItEyvTvYVxJnAIV8ulx+BCb85k2DlDftSpTml6p1YR1ArbMAprtitMT2aRlqYsk/i3hhanwyRV1+nXIC3mRkMV6YItkTqW55/e1Q6PGKph9EPtbnNsiwQ+hHpnAn2rmWt/AM8XsSnx33gEAXWm3ulxzm8JZ+0g7bKGETi5oYrq9HqOdeJZLhjQn7MUCQgkScCQnsKON+GBTguSPV0gengB2d/WBsqgidENKE9Snft6m3wZpv5RqaRdMmNYlhBxeoV1XrZcOTyu+ov0kdojuuMrSSci+p8/dEY+4J8Gp2kmOILeAm8HgH65IejoNuhclHUlLhxM/Z8P1oTkXrrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by8E0ohKnD3HN7gahLh971O+HSHtF/pUuWUJ8No+YFE=;
 b=IZslqChc/Sqk7qgxl6NWGax16UsSPEx13Z27woemmMD0z0HgjGNPNJ24dUZyBI6PgbWKg3kYsNdD4fzWEr7iRNjsqujb4EN0ZsAaYItTMij69uMsdK8kO7qt4HsliTcHmyQPjboqGMkOMmsH1D4dPgTMbAIgWpaitnlIrnPXJYA=
Received: from SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) by JH0PR02MB6755.apcprd02.prod.outlook.com
 (2603:1096:990:49::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 08:53:01 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:191:cafe::10) by SI2PR01CA0016.outlook.office365.com
 (2603:1096:4:191::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22 via Frontend
 Transport; Tue, 20 Aug 2024 08:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 08:53:01 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 16:53:00 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: <stable@vger.kernel.org>
CC: Hailong Liu <hailong.liu@oppo.com>, Tangquan Zheng
	<zhengtangquan@oppo.com>, Baoquan He <bhe@redhat.com>, Uladzislau Rezki
	<urezki@gmail.com>, Barry Song <baohua@kernel.org>, Michal Hocko
	<mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/vmalloc: fix page mapping if vm_area_alloc_pages() with high order fallback to order 0
Date: Tue, 20 Aug 2024 16:52:42 +0800
Message-ID: <20240820085242.18631-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024081918-payday-symphonic-ac65@gregkh>
References: <2024081918-payday-symphonic-ac65@gregkh>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|JH0PR02MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6a80c1-2465-4c41-0e2e-08dcc0f57f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8VY8bIqkvX0oKXWwuSYndFJtJFxAWD5waP9/lA0VsRx46KlnVowmHyMz5gy?=
 =?us-ascii?Q?bdplw80bdQsm9KkQPwfi5jLwiYdMiWNOMZiVdKvA3BFZ9SsvviHYMMjVOrl4?=
 =?us-ascii?Q?xRoNZ4RR56kzHwZK0aHFvNdY3MicfhSg2Tn2QUgLGOWBaodvbr84hKMRZ/mt?=
 =?us-ascii?Q?AlDe28nSfQ4BRNN7/F4DR2aKBOR0w6EM2i7YHaNDyt4ERFHKb/PcLJPAFqSY?=
 =?us-ascii?Q?ZKGgi7astHj3qolmKy+9s/TLogjzE15jwg0PFIFq8r91xuHeDucrTVployKt?=
 =?us-ascii?Q?iSjUyMr9fALOp/fsLgGNVbNOe4EGIfNAoKmEsHfvRhjRz7tA1pNtNdTCxqim?=
 =?us-ascii?Q?uUJytyuPUTT44XDe1w0/r9i8ydI0lsV5/7QWHO7k0GGHmpBRu7UpYDUXGejG?=
 =?us-ascii?Q?SJnANrfjWy4lGpjNI/XN7dqCLJHujN0ecId8cA8+96AJyjNmJzPRLJGo/n7N?=
 =?us-ascii?Q?p5+M6ACyK4q8wFeoesKr94Pi2AbNnED+SMp/q9JzhzqMHLWXHXa4w0CxsCxA?=
 =?us-ascii?Q?xBOu4LQwzRtXPXDFNcmRIQUD0h/ew1w8UGUICV2IPTOFhqv7ow3hKYmtYUJ+?=
 =?us-ascii?Q?11NFmjq3BwmiP4XG3wykPdL2jvdf07fuScEYSG9yK0bEfrNFTmhwCegGe5Ns?=
 =?us-ascii?Q?odqSPDZb2ukzjzgLT68CG4Uf/kQ2tCiNYYOrbiT2rekE/1X+AccWsb6ovMO4?=
 =?us-ascii?Q?ReNSODL7sFsEo1qyd0uQHKCp/ds8DVS8wEAcd0VBXdOVv4GhfpzMkxH5uE+C?=
 =?us-ascii?Q?V94m45N1b1/+ekn/aXluWGDYNo1sepA1qcsPGV324V2WgJs7w/HDBxrG9/5L?=
 =?us-ascii?Q?8vNfiDYlEAqyxIdWK6jUoFWwUXQBG1qB2oRZb+vlgWdBRKy5FD6nc6Wo2SOU?=
 =?us-ascii?Q?gVSBDkeWHFr/Fc3haGT5TjBJwYWq4nejUKEf5iks8oYd0T3/YImiyqDBVmyP?=
 =?us-ascii?Q?+ezqq5urlZLaMa9iPVAQDGu5cH1UEsdj+9URf9m1tWpg/XWLVZfREZWTshb7?=
 =?us-ascii?Q?CTKCcGGdW38bJVh+uYN7OX3IhE8EuXnQ2KEo19Zpdvysh6cjSfFleqY7SkKj?=
 =?us-ascii?Q?PCClcE8PMzAsv3Bi4dpN/1iaQkz3JmNwZtiqppzGhRVavTxNgUFhfirWLFsf?=
 =?us-ascii?Q?NY4cmCgyGIkGkqDjKYM0+HBRxSGPYDih6GX0kRMsr2vE6R5VHV/AUVSv7Vk5?=
 =?us-ascii?Q?oK25mB6+FqYnhf9E22uRBjcOghI0cM9wufyGxrD4WjMM6p7acrSsqFiWCzNH?=
 =?us-ascii?Q?ihJCkGIgPsks8SVrNtCDkvaGKWvXmvpJ0hfkJemggTp1LvIrB/R94wzsngkT?=
 =?us-ascii?Q?g1Zog2LjMgGnDHE4xmmcl2ucGYQdCJHxbO6tmgjFTiL92KTMRfOHlB1Zh7Dc?=
 =?us-ascii?Q?NPYhudjyVfxphTGVShC/EKtrMX8daL8Wy9NmnNvm54ARJkDgDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 08:53:01.6572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6a80c1-2465-4c41-0e2e-08dcc0f57f75
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6755

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
index c5e30b52844c..a0b650f50faa 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2992,15 +2992,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
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


