Return-Path: <stable+bounces-66031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99BE94BCD0
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154061F2346B
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C0B18A6BC;
	Thu,  8 Aug 2024 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="p+fajjcQ"
X-Original-To: stable@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2060.outbound.protection.outlook.com [40.107.215.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E418C32B;
	Thu,  8 Aug 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118510; cv=fail; b=JA02RTp0V9epWS95dfa7ZJ8BzhpdCDbpwYuLmOACBgXHrLKq6+BzyMEaYoe7rCSNN1rFD8PQcL/ThNm9w5dRacqOnA1DxfG0qTPb6QnpZsjJvm+acYhq2gpVV6Z9N3cULrndv04A3p1F3aobkCRl8xA2uNhZ4cxoCSEmj/jAc/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118510; c=relaxed/simple;
	bh=v3ghpAW55FtgWBRkWEHvsTItq5mgrmoz7mYwZfIXKPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZQIx61XBvGm4UoJK1qguhhqxW/zDAXD764jniOq8prnF8o1fNq9NKLqzuAZ36en0pPxCd44+J6R69RpTTYUWBEuYJty2kxilDmngyBbRS63SRR9YzceycYfy1G8H2084EWra6V7vc4azSSlf4dfftwjXe9n0OGYVW8U2xPj2HAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=p+fajjcQ; arc=fail smtp.client-ip=40.107.215.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbJdrqi+A/DJYeZxvgmM3uJLQR2AZJHH9Pi1vLHGlVP4++qLPq2+bg2UmEAABRDdwnLJAgt2Uzj6nxmTSsm3nk04usZ5v5FatkGn7RJnvnyHdjcR+BsdDeJC3Fyx1fGprQPxOSGF8HNR84Gk4dRD6GOS+cSKoTo6Q6eaXrm4usnw2KrJEwC+E8ac7tXNbz1f0jo3nv1Lci/S2+UuS25nYUeCKm8asxn85wMeulrQfBkzJPxaDOa2aQtd/NtGcrWQuHm/rDV6yUZrvyBw3d0P7daQ3KzkXPqM6ZygozWC0eghCEoT47nGNiLg8n/oepA/n5TvrRr06jrpubISvoOz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QarrBgpTqQY5CzFAJf1MdC6VIqVZgm4TIvV2jsZU1ws=;
 b=JJ3YgTvZtcfihyrVL9o5BNdrobqGjC/AJMuCPxReu9iWic01GQt2eT4QAHV6nhwxSiV0HIVNwEZGi1gnRL4jpCQogjOwWfOirAX3R8Gp9W6VWyS0mmC5s2fLADmmpFCZ2JoUBgDBKfALX0JYqokhfmbGH5OJkbr9jxUFcwTN5HnznM/6GcKlrIkKXkGxxA5hniKCuqfPB5WjfnErW3GEyQEqhw4OFWb8RoQBLGrUM+cxl+xNmA4r64G2WpTuKvN3AmxciPZ/51uAo1cHOkwYecBOuQ31FxCijjLBqb34tqlpNBg7Gcd/By7xabx3TqAPSpbYdB/LF70hBZxKlbdqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QarrBgpTqQY5CzFAJf1MdC6VIqVZgm4TIvV2jsZU1ws=;
 b=p+fajjcQRh+PXedz/8lmQn21qCEGlg+c73MwC7K02dQvLy0Fw8VTX2Mad/5POJYg734DYwHauThvnLT/jt0z2xLiomokoqxoaOsc1QPQjnH6pvEQV9/H1xh3JyTMPWLs4h3IIfyUnffHEl9FhlvdWL5QuW2JUJ7nMjDApAYBiVo=
Received: from SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13) by
 SEYPR02MB7460.apcprd02.prod.outlook.com (2603:1096:101:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 8 Aug
 2024 12:01:40 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:4:b8:cafe::fa) by SGXP274CA0001.outlook.office365.com
 (2603:1096:4:b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 12:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 12:01:39 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 20:01:38 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Vlastimil Babka
	<vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
CC: Hailong Liu <hailong.liu@oppo.com>, "Tangquan . Zheng"
	<zhengtangquan@oppo.com>, <stable@vger.kernel.org>, Barry Song
	<21cnbao@gmail.com>, Baoquan He <bhe@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v1] mm/vmalloc: fix page mapping if vm_area_alloc_pages() with high order fallback to order 0
Date: Thu, 8 Aug 2024 20:00:58 +0800
Message-ID: <20240808120121.2878-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|SEYPR02MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: f039b97e-ec0a-4444-38ae-08dcb7a1dc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mGcJXG8070E5BdISTL6/dHx88dwInr/mGRIg52ZHRqMxFSBQRHd+XLrprzGR?=
 =?us-ascii?Q?QVzSg/guzXjmH9UNQJET28xuGesdokfXkYbHGySpWuI04gTM22PE5oMQpbnd?=
 =?us-ascii?Q?WarL7VH1hv1/amSrTIJ4x0Jw82T0xQdclNB0Tv10aYfRZ4UOQ5EkMsPmN6kH?=
 =?us-ascii?Q?oA5FD/LU49dzAY7lNA6xH59hY1s/BfFupa5vwnamlsAYlsIxZCCFCChH4bap?=
 =?us-ascii?Q?bH10xEWACRMbL41kIHtZQiRP3xqlyq7DvZrl/8DbFZ1+ecuI5o86AraGhrts?=
 =?us-ascii?Q?V40t/beM7BlDGYxw3qNRNjgIL5lZ3w5SWsADkgS02yYYfxtwTxO7pziVOut8?=
 =?us-ascii?Q?RmeE7oHQsgfCxWFq4L5UuOvAsXXScQCSxqdtt1cjWutpUD1BQEBVRq19lGyo?=
 =?us-ascii?Q?Rdfyqncz1egtLi8ibL//qIRaRGAl02xsWlmXAQ7+Y3vjwxNxZwJoYqFixSUH?=
 =?us-ascii?Q?FM00zcYE27slLzgCBN1VHPJD/JSfJPe9RlLBV3j5yqnlq1Q+3lfbHAeoJBR8?=
 =?us-ascii?Q?IRngt+albyTUvB+bDAM4NRF9NGkwWLi4PMaOaMwlPKo083f1e7c1viWXd+Yh?=
 =?us-ascii?Q?YXkrdTpFnYp1SIFVscY9QFWJjOe86dikWPRy2+lfs1XhMUL4MaGfaEnYkTeP?=
 =?us-ascii?Q?qQo/hkE0FydNLxUv9699BLKrIGdfoRHnuTlNhGuADp+cikYINeHGe7XvI3Nz?=
 =?us-ascii?Q?JKqxOFyhYmrdYEJrTTXjQupCk5f5sZm2xLbQHsNToGBC/upWZUqeMIDTPUhS?=
 =?us-ascii?Q?2Fdxt+tKPoe+rv8r/nsfeC6Jlo6jcPjuoJ5mVM4e5s/yKHPC/gPKwskgGRRs?=
 =?us-ascii?Q?ITqqvKAe9W6hePRs6/WeQtizh+CLXXbnerYZlmevoTorpjQ6kdCiAICwpsGN?=
 =?us-ascii?Q?h5OfopWc1927Wt80JRxrsq7s7uKLtmPRywQunaAmSHcJSC6hxh8hGUptT8YW?=
 =?us-ascii?Q?oD4xbPKNhc5dQlDodk+ssX/XvB0Z1+reTD2GZT+beZKjrhRlZewl5m0bQyC7?=
 =?us-ascii?Q?g+XGN37/DWMBcxIbrdayhDI5VdXIXHczWjSjVnADcVQexUBFwtEFsKIBNLtf?=
 =?us-ascii?Q?FVBBKqWWz71eA1btdJnxpf9tKMF0y97OJlXDpD8B8bZ4MHaBAsYcTg7RvpCd?=
 =?us-ascii?Q?1FF23F5xTukhrCNwZuPLXU+ro6ponA8nCLC9SxGgSIpBwXWMsQ4uBeWWzbab?=
 =?us-ascii?Q?J0FAx+x7FaeBOdMHZ8wWLfWYPETPGNRLsfOVpm/2CAAUYiBEwZbiCC5njAFx?=
 =?us-ascii?Q?FqYmI0bCYFnhFn4R1oK+KoWQRqEN3fqHOdj2Sqgoz9x34OD3/L/OKButMwKl?=
 =?us-ascii?Q?lbeNkqxY7m8WCvDTIUx77AArCOnAhIq6eg9v2EnT0DUDVkl4w+gg925s6rc9?=
 =?us-ascii?Q?oY/O89Su320siXI7mzT9gBeAQtGpkK9ISVXxZ/ywBY79Jm0Xgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:01:39.6000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f039b97e-ec0a-4444-38ae-08dcb7a1dc8c
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7460

The __vmap_pages_range_noflush() assumes its argument pages** contains
pages with the same page shift. However, since commit e9c3cda4d86e
(mm, vmalloc: fix high order __GFP_NOFAIL allocations), if gfp_flags
includes __GFP_NOFAIL with high order in vm_area_alloc_pages()
and page allocation failed for high order, the pages** may contain
two different page shifts (high order and order-0). This could
lead __vmap_pages_range_noflush() to perform incorrect mappings,
potentially resulting in memory corruption.

Users might encounter this as follows (vmap_allow_huge = true, 2M is for PMD_SIZE):
kvmalloc(2M, __GFP_NOFAIL|GFP_X)
    __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
        vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
            vmap_pages_range()
                vmap_pages_range_noflush()
                    __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens

We can remove the fallback code because if a high-order
allocation fails, __vmalloc_node_range_noprof() will retry with
order-0. Therefore, it is unnecessary to fallback to order-0
here. Therefore, fix this by removing the fallback code.

Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
Reported-by: Tangquan.Zheng <zhengtangquan@oppo.com>
Cc: <stable@vger.kernel.org>
CC: Barry Song <21cnbao@gmail.com>
CC: Baoquan He <bhe@redhat.com>
CC: Matthew Wilcox <willy@infradead.org>
---
 mm/vmalloc.c     | 11 ++---------
 mm/vmalloc.c.rej | 10 ++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)
 create mode 100644 mm/vmalloc.c.rej

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..af2de36549d6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3584,15 +3584,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			page = alloc_pages_noprof(alloc_gfp, order);
 		else
 			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
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
diff --git a/mm/vmalloc.c.rej b/mm/vmalloc.c.rej
new file mode 100644
index 000000000000..c28017088319
--- /dev/null
+++ b/mm/vmalloc.c.rej
@@ -0,0 +1,10 @@
+--- mm/vmalloc.c
++++ mm/vmalloc.c
+@@ -3000,6 +3005,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
+ 	unsigned int nr_allocated = 0;
+ 	gfp_t alloc_gfp = gfp;
+ 	bool nofail = false;
++	bool fallback = false;
+ 	struct page *page;
+ 	int i;
+
---
Baoquan suggests set page_shift to 0 if fallback in (2 and concern about
performance of retry with order-0. But IMO with retry,
- Save memory usage if high order allocation failed.
- Keep consistancy with align and page-shift.
- make use of bulk allocator with order-0

[2] https://lore.kernel.org/lkml/20240725035318.471-1-hailong.liu@oppo.com/
--
2.34.1

