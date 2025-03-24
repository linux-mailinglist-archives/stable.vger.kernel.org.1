Return-Path: <stable+bounces-125964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47BFA6E2B2
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0BE16FF7C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6C9266EFC;
	Mon, 24 Mar 2025 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vr6b+zkH"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32A266EFB
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842217; cv=fail; b=NUlKMsvLBNMaxv+Xe8hllqZB19ZdK+bHXXcA8NXaLHlE+OEsRLnbVWSdMktDFyH7RIT2FnyR26qAGIHy4gLy8yysD1nmbk2/jFDjmGNdWDD5GU+lGF0Jnc9dbgXbFq5RW6hd76G9Xc3wVmWaU4l5xOy4Aj7Zp7558qiTrT5z1B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842217; c=relaxed/simple;
	bh=i3EZYqTHVbQ0tgRcKXSUs9syIyHeRJKHoqQGfqDC02o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BbRHMZssiZXZxKoAC7mx5eWEsvwN2yVR7Bjto/VsP+QNpQAH/qqHSbu7dbPh1Y6ixABV3dOz2cF8QFVWe8YQ17lBb6CJv8vbIGeC4nNSxoECGt03U9/lI/OZjvBOIefxF2CxB6+z51CTjhA0A9G9/Td0C7g4arXhvvg9OeL5EzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vr6b+zkH; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfobOkO3Fqwuv4mjo+B8Qdd0lclg0x7uc0Nz2rHFWQJvzOLV4Ob+rISFpg2u/mKhIWQAeWRur8vNj1c8n2kstBh4joLYGASqj90SlmiIqoarCj5NzyiivIPlHhLYGgQod5nCQYqGDzKmnIUkXCMjT+e07M5tpt+MatdB57zJkiDnjdfC8+wINF4Hkxi3HLXzjJaBUOoTlbVdj5J6ljACkeU4CZkr551zKbpOkS44RQLqlEvn1gPFMj5m7MTzMf2gPebAp1HhRm48hMmLFcMEOCP+XI8dXf8f7xU+7lXJbsmR5VsqwZxHKrpMkl7NjizwBbTjQPLdy0wG1Lf2HntCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvp9FnIEzmvhcKR5q3TaamGBy7vIf9NuCVTxRuFZtJw=;
 b=Y9SxpUmm1D/5d/MT9NqWTWBbYBD8YaC+7DvoHfOGXOFP0JMhpGiGp3PiT3Yhd+SRtOHG3BRLCqFMZxCYaqnAsWS8Z7M6VRvGm4qQjcpcItK/9v1TESufUnjRaaafbo1FmnvKcF1ZmhoQiHLy1oGFvf9Zpu6RYUQa+m27w+VC8NaDTznD2N1G+Kkp6mRG4ENvn6Kg0XtRFZw71vMbQWICV2Zna5ZwuP0Lx0SuaaQH3uZrnU3vw0uJbBRBGNJGpe88iZ58ix25iLaeQ2MmEpfIrxgxzAF/mAYEfDjYzWq3GPhdrqgwT8toqbEMcn9q6iY+aMEmv9c1RtbOQtNaW+9iBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvp9FnIEzmvhcKR5q3TaamGBy7vIf9NuCVTxRuFZtJw=;
 b=Vr6b+zkH/LkMyA/GAK8JFQTkESxoBU4UF1xrcverBCMWr+XaZDIavr6qFlV0HO+0m15NA9IcyK6W4zRacuFPofItMqRnW1IZ7uXa422VfCiC9vkbuG/wFjBQenDj9DE1xtqOgzRX/w/MzEdQg9bYKvME8C2CnY+t0ru+2rhpkWHdTEnej4zyMV4tf3CY5uB62zM1K51VqfWjoABi+EUczdvNUAN5sZ2uS/3i+ChVGLjy5HRenTYUrcGL6sboZ2JnJm4fhrLF4zO6R6yYhBWN1qUfdnbHPhrcZjTXgMOMfR905Z9v6LU6cp89/ipvjsjg0ivC/YwylnZk2GIjgtw3lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 18:50:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 18:50:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
	Luis Chamberalin <mcgrof@kernel.org>,
	"Matthew Wilcow (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/huge_memory: drop beyond-EOF folios with the right number of refs
Date: Mon, 24 Mar 2025 14:50:07 -0400
Message-ID: <20250324185007.142918-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025032430-granny-hunter-c6a5@gregkh>
References: <2025032430-granny-hunter-c6a5@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR12CA0032.namprd12.prod.outlook.com
 (2603:10b6:408:60::45) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a24339-a9ca-4768-6782-08dd6b04b564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HCoMynpQljLTYoKnPr/i9gYUOZ/KUuJ/I6e4XIkGzcTHqI0z0wwepsm1WR+X?=
 =?us-ascii?Q?iWXhALvHObAxmdkUJnM6TP+8GaP/8Qe9dzBaWhbU7SGF5qCOXbUeHkEn6j1R?=
 =?us-ascii?Q?qB3betXSZDXpScWl3OdA2uhCo/4t5ExPOz59OgRdAdmzVoS896ZlO/30tDj7?=
 =?us-ascii?Q?Do6BJBW/VMelY1SFhAmaoP4PcdrUMn2vNsZ3ZV3CC2tpKrBedEZyuaZkdV02?=
 =?us-ascii?Q?25DYpxfK1+WAWPGfZo/3yUwpHQgWdMEyciKF6KjOz30ORCzieMdIZ+p/naEN?=
 =?us-ascii?Q?T3jYxq8dIB6GvgLHv+QUjB+uodHXcBuWkEpwTT0QAQyzMpzbX0NRpYFyk3kD?=
 =?us-ascii?Q?m3PV6m1C9NJpwfwvd9iPaZNHcO/P7faf2js2fXE9Sp4kr310u4rYcKHlHELk?=
 =?us-ascii?Q?4ofg3/cYj3M2EyjpIdqNgaKdWh6aamd/5WWScRaFpD2mYWVaLn6Hhe+DuMn5?=
 =?us-ascii?Q?JLTpVY7bSZwGIIuEalKNM8qBr8QGMxEerzPKWyo5Ss1JLvcV9x7wCFnVqCvZ?=
 =?us-ascii?Q?l/mBrbYHEbmI9G5dfYsamlPVzPOGDLtgZ7YB+SFe0z0O2v49MaY5gigA5fNF?=
 =?us-ascii?Q?R+9rp52YSPZOoUyEER0yo2GRX+3Ui4Qb8zh/BbruLWMswvakkmGWKtDyMcyv?=
 =?us-ascii?Q?5Lf7M28SVxsiPxEmHIEYafPvG1eFadXhSNYhFhVF/mEMWl87Y17diAy5wUS2?=
 =?us-ascii?Q?JDNVTt4e+Tewl3+jxQRycQO27YGIYmOGGVzL5C9+eD5HnzIjlwm4TExr31OY?=
 =?us-ascii?Q?8bb1h6N8lRbq1L+txTp9XlCN2FeVS8NFdcJzCA6xHT6qQeIYeqxcWyfHe/Zq?=
 =?us-ascii?Q?qrn5Oyc9HSpDhxR2GBFejPeVZAdaUI/RSZcILXr0Vawp/n/Vp/qChax9VLhK?=
 =?us-ascii?Q?luZKOYYLT69orPyYJBlFWMeCCfCs+5woRtNyBCnjLLtqgwKhfahL1lVFduU3?=
 =?us-ascii?Q?BB0URqMwgJvIIsHeKVTpxqdzzbZ3sHPSdd9LThhNQ67NYgQa/eMTH0HAkGyx?=
 =?us-ascii?Q?hjGxkJ5OAJZ9VIzhjADJGZUgeUs1apCzpJJvUM6oIdfLMB6gmHjhGT45Gb5b?=
 =?us-ascii?Q?cWAWzRAHNFGe+O1xxGO6MKsj8orZOmtfV8nOhNAA0zlvq/lPK509XjiN/nGx?=
 =?us-ascii?Q?o33HVZfYYVGUCUEtiTBifP6ITrB1kjZ0WaGjwhO8rEfSJb1w5ltl+NH435aG?=
 =?us-ascii?Q?IeBplNsizZEMzTUAVNEfwUMpG79HWFytLcSvJoR1nI71y3c9gxiWpjCqJFD8?=
 =?us-ascii?Q?wvP8WZWBSWyI1KPqvX2XSG/4TMLLqBSMMETZF8HVufLvM72KQfcr5Y37xLIA?=
 =?us-ascii?Q?6mB51qk1GX+gZPIGfdGTIxETODuYmaeFZT8iGZha+tNXFvt/76M0QWnyeI2i?=
 =?us-ascii?Q?Zg0FVovsJZTqdXmdtH8Uv8DAAlgPjCsCCsgK2wNrxLwERu5nhf7PikJVivQ7?=
 =?us-ascii?Q?+Yug/SEuDF4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1OdOME8TqY1GQEG4UL+9azWZfZcXS73+iS150tcppBns4rEymWsepXv/9F1?=
 =?us-ascii?Q?qzZnaSlvo6/mMDcG22UcXBk/3B8HxvUPvYr5uCbwkTMGujlG9uXPr4XwXfcH?=
 =?us-ascii?Q?4jWgEjPtwpFH7oulkAwfjT1hZYcXPTsDE/XXVL1LIPRwtoUOPg7e/7eOWwP8?=
 =?us-ascii?Q?Y7Vrl6OGxFWAKr+CxowiSPKLn/v00Rb2IWWDNszGHmfoP2MpzyV513mrMXrC?=
 =?us-ascii?Q?+aoIcpyWoIMAC/ru1GY/TtmjCFr0Fl/BiTwNFg+Sqpd7UMR8T3X2ws0KgCHu?=
 =?us-ascii?Q?rHey+lYMorJQUMtODkZ/5v1LlwWuPSqzMDavPZYI3q9Fl2MEdOjAsizCYO0y?=
 =?us-ascii?Q?X53jHHLQhvJuyXOtN5KGWvelf6b7m7Zhb6J+d9jDL3/235vvLdv7cB0hDcWA?=
 =?us-ascii?Q?zzopKaEvbx+VEel0pE9iUsBPhbpvHFRR712BgZFfdCzfi9JS62vnt9pG5/rE?=
 =?us-ascii?Q?dombpcKHiREQpE8wV1aTQ4TNfpFXWtfA1hK0v/E/VqaqkOE5WO0qEsItQCOW?=
 =?us-ascii?Q?eIqnXqM/uslEWWut5T4mdam3NkvKB92wTF0PSL0fn8+hmlQSDFwbs0RRpGK0?=
 =?us-ascii?Q?bqmRw2YX7AP9GCrdmtFzmWSJYw2LWrRgOno6fRUu0HXUEa4UZer6IYtwJxdd?=
 =?us-ascii?Q?2SqnMiuQRStnvb1NWrra3ZUfLZQcYXXMnorzQpPQ8mtCXNtux6s2s1kQB4fq?=
 =?us-ascii?Q?gYSwogU92EslOG2S4rgZjHKpqbJjSDFWzjdItu6TgMuRtQ70NzZ9Yeyhljee?=
 =?us-ascii?Q?e4MAaLBMuO8YulbGm5bmWkgiQZdVmRUFf24ds1MTSCuZ/lNVoA4DPtOrTKA9?=
 =?us-ascii?Q?WbUJPWSUWbZAuVxDGNiBvN5nE3NPgPpdOVtv19rU/siracsxZ405CUSzbatM?=
 =?us-ascii?Q?YN1eNWalegjOEQz2If32yyc5l1rSKN2SmvI2/rxyPfkTv52P3mlBkRaP66DJ?=
 =?us-ascii?Q?oNfXTe+z3eKLhF1o68VnjwqxmuzEBaVgEJOQ+HwrMNJTVkduTH9rcZxWGIN7?=
 =?us-ascii?Q?7HA6rLxS1XO8ZfE4SsYrjtPKh22UTSMQFFid7R/Gj/by5C1EeXIb6bEDuc53?=
 =?us-ascii?Q?8fepMH6e9p56OWeihhm0PluFdVUc+qjHx04PHHlIgSQU9WoHOuBpAeDptPWr?=
 =?us-ascii?Q?yXt4NKYERYhaIzBJw9OA8voTy5pxU+bkBzA7BULZOsMvzMTlQ6p7tVwIEaX6?=
 =?us-ascii?Q?vp6LxpZF7/lV1DdUktI80f/2J8XCCa5geQPPAMyyzfFxSo973V8Dse6IXnk/?=
 =?us-ascii?Q?qqK0jgyzxZRRaI+P8fIBRqT5oRg9Od9K/EoUm/QL5HzTIPqaTulf0wGUe9IW?=
 =?us-ascii?Q?KNPSX398hNs8NNVRY7PF0uFhtkEYVtjw041cuFoQwGSSxKGmTdaEzkWFGFeC?=
 =?us-ascii?Q?eBWxYZmNoFXVWnxQqWpt+VfvZTGwXZRv0A+c9RIe+mQANVjKvvltJQgiWB4Z?=
 =?us-ascii?Q?nucM06VHF0UOhHxf3vrYupNtCghaiCS1v9ZHd0GGaJmOz3+GtHNlj8CYT79p?=
 =?us-ascii?Q?8gGsrtrIIWUun81eD9qD8Vt9ynkQxZ0pDV7SSdtat7ZDWYbN30DT/aXzR+si?=
 =?us-ascii?Q?+jFlAIoBF84gjfIbaPQAnaedg4U5fO7fC8onf3W3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a24339-a9ca-4768-6782-08dd6b04b564
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 18:50:12.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cc1m4ORCkAvM1PXYqQxRqowTtB8BkeAwJYfHBjml8SDgQO1BknV4Ct68odwqPYta
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138

When an after-split folio is large and needs to be dropped due to EOF,
folio_put_refs(folio, folio_nr_pages(folio)) should be used to drop all
page cache refs.  Otherwise, the folio will not be freed, causing memory
leak.

This leak would happen on a filesystem with blocksize > page_size and a
truncate is performed, where the blocksize makes folios split to >0 order
ones, causing truncated folios not being freed.

Link: https://lkml.kernel.org/r/20250310155727.472846-1-ziy@nvidia.com
Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: Hugh Dickins <hughd@google.com>
Closes: https://lore.kernel.org/all/fcbadb7f-dd3e-21df-f9a7-2853b53183c4@google.com/
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 14efb4793519d73fb2902bb0ece319b886e4b4b9)
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f127b61f04a8..40ac11e29423 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3224,7 +3224,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 				folio_account_cleaned(tail,
 					inode_to_wb(folio->mapping->host));
 			__filemap_remove_folio(tail, NULL);
-			folio_put(tail);
+			folio_put_refs(tail, folio_nr_pages(tail));
 		} else if (!PageAnon(page)) {
 			__xa_store(&folio->mapping->i_pages, head[i].index,
 					head + i, 0);
-- 
2.47.2


