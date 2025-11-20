Return-Path: <stable+bounces-195413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE16BC761D4
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C181128EF8
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1523E346;
	Thu, 20 Nov 2025 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XUoZtjBr"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA103FFD
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667975; cv=fail; b=LRk4xbjMIsSCLZpFvZNBgPwDZZvwfb17UpZsPTCukk6ruA91suS+vOS6Ki3z08BOmMTwoBZFoyLiep5alpvzEl6Rc1nsVVdHaVB0rui0kkqr2vJaErBjLX1jnS1KIpaWoPq7aem6nJLVyPY2tteHSxGT7say3ZghjPIhPv+M8Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667975; c=relaxed/simple;
	bh=Wy8G9rjD1jdRZclprVrnLHSna9OqcmEQG0ignUq2tVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jE3tfHQGCpktN2w0WYXV7PWxjp3AP4kfKbvTQjQparM5+QoBy+W3UnpIj8/sMAzJCoMTzQcStIbfX9nyfmmeewLkTjeUjGZWYslyc/sHKO2P9KaQN02YTvd6Iho/pWFjzuAZsYauxDMqxbChipnvohl3D/5XYQ8iypaTF5bd+SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XUoZtjBr; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUkBnyT1lr23y74Tlvcqbls8jd9r+Da7Y/Ht1dRGYCRbFbs7mP29Q61YJZyfxjJo5DOvCnUJmx/1MMdshxZQEWHu6yYzNFks+4jnIEy5Jl99b328gl0af6Q/f9HU/SWyZ2eelzAHyowTkpCsBlTwJIUNosfOtO/QrrfEptuDcY5mnEIh0f6FAtC3qFvDQhFdfXcys+PECPtYIWj8zlvUsoK3WAUkOUqX7YYVBDB35xKExpS4h/6IWNYi9hG+UjVUAsjfjNhbMJ5QqoSkj0QUctz+5gvlOZQEbP/NLmXkBhBJyT2vUXaQTYpeYNIiU9DAWv0awlw3ksemYLdfNh9pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQUhlcZajExtDUKh6gJLlWBIWy+JlFgVdwuAWPrHP7E=;
 b=Zb3cSUQeMqA/rcvFwPwIv/FuIZkvbXMSMN2kinjXdlUAz1Atg2K8FAe/3joEp3eZw4oFWaqdbHZXo1kZ27HL8bh1pF6aLYQQWvyI3dvPDUzPPekprahcSgh3weJspupmu4MDualPXkLMXgg++HjlzZzToM+hgQuqMs0XjWOmasuwMw1MpPGIExTA2j2OlGfhYY1D7q773yqGRobWp6x/X7xxobraw5weBO9MVAnVbzouVPYTHMZim+50YlgNlqR1PogcrOq2hEVKYivaiYrzx36nNjBvUvveM1junm1YMhiDv3VT0Sv6o0AuYQCnCKtBO1eAJYQsZlOcjoJ6mog9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQUhlcZajExtDUKh6gJLlWBIWy+JlFgVdwuAWPrHP7E=;
 b=XUoZtjBrBT8GoToAX2eQcCe70nf3wPFWqCXTVY/foPZoFzMzXeRuNd6jGUA1UsoD+pQl24E2mB0F2xvFMvyiPGVnQ9IYC0dLljz/Mjjb7xIsKy0yVDY1FQQF+7ttintaSNfi6qZ03M1PU79UhnNZSqsFMuOP7GP1bWWeALyI7y88uZaVhsT65DRAkNx9iR9JuCpWlEz//VJxyKGY95WLi4vg/huaSrqPAM+va3ihiqMwAy/dGP3IhR3+0DkMpHIqEYg0vZSKdElCdqZ6Xyl9SsX3eaQ8RkLMwaAwTx8orU8+An6rQPxAD8qAjQxeYqUcGVBD3LyeIv1FK8UX8b0whg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 20 Nov
 2025 19:46:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 19:46:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: stable@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Lance Yang <lance.yang@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Jane Chu <jane.chu@oracle.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Luis Chamberalin <mcgrof@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/huge_memory: preserve PG_has_hwpoisoned if a folio is split to >0 order
Date: Thu, 20 Nov 2025 14:46:05 -0500
Message-ID: <20251120194605.1343034-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112056-isolating-punisher-7be9@gregkh>
References: <2025112056-isolating-punisher-7be9@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0097.namprd02.prod.outlook.com
 (2603:10b6:208:51::38) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f89d865-b11f-4c67-9e5e-08de286d72b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6qMEHmAEHm1sx9EIy8F0YtO9vx5bmuXHbO7ZkrPRhZHk1MeSPBsMENIw+5Wu?=
 =?us-ascii?Q?OxnOwHwpqVw948o5JF+P0rxwaawAbyoJ/8cSRULQvUCJ/eHgFOqmG5R1ZQlc?=
 =?us-ascii?Q?I6NeqzEf/oBnYvS0CUZ1O8gWn7a8u/PDk8t4d4DyFpww43oQAZVgYL1PBJCx?=
 =?us-ascii?Q?KMivCL7ed/4et6/Ez+Ruz8v3JoKV/kullPl4z4jkspgmljxwcsZdyDP9Jwnr?=
 =?us-ascii?Q?oo6KzNvrNU2zyF896EGPFZP01g/pcqh5aiu8TGEu+ry8WLhrRX/QAB9b4+dw?=
 =?us-ascii?Q?LWGYiNaJqb+1PoI8JrtpWNPzSWujTQY7tez728iMfEpfdCjyU0PvjXNFbYbA?=
 =?us-ascii?Q?PhLuRJU8BjNb5kLNDNPzBflzbUCzFeUKUniivEcBS/tmEiu7+3h2HE8l7UH7?=
 =?us-ascii?Q?INd8hGsdtG48AgOj6qp+ruwU3muyxQoTDMHQBwHUfA/PEEWgL56Yd8D+LmzR?=
 =?us-ascii?Q?rKXnYZ4x/Nh45AzM0/srRj0js/C9padV6mtXgfZPpXexjafFxkhKJQJ/4Q5+?=
 =?us-ascii?Q?R61PvK0T7/LW25gHo5mDw8/ycFiWEoqVCS/6RL1aj/BD9HvH+1p4f1ETfK94?=
 =?us-ascii?Q?kAzUqj4L2JZvDssXXFVqYU6z6ADhvjrfuAw4gbrrk9ewF3hsMLz4KACCQ9Wa?=
 =?us-ascii?Q?MSEMlLdneVk2iA8cU9Blnh6aTZB2tK/cnuLCGgCBAhqG2lVhQfEU/s6F5tAW?=
 =?us-ascii?Q?dVgoFJFUOVNMwJctf3J4DZR6+GUE0ngRUV/8b4fHhKTfrqWVmpvUTsXPqyPa?=
 =?us-ascii?Q?xVl81MV7kLxrwwl1O2G7I9fX4Lz2QRlwSYVX6I23+AepXLwHirbWBNcGwr8P?=
 =?us-ascii?Q?7xB3HCC2y7eD5TXmlYp1K11V+heTMe2/hQbcPyZC5zR0TE/PJ5t0j/eKYSfL?=
 =?us-ascii?Q?T6QyDJErKbnbGBtBL42x1U9AIxDnY8qElvo3Z3R7RHEUevnyPKHAW3SK3JBz?=
 =?us-ascii?Q?AMuXIxJziWRZtoKwA/Wbfugxb1VGDnJ5ijaEHgPzQp+M1/aict6qhzBheLEZ?=
 =?us-ascii?Q?niARl/X2xb3fg9iLzEVwTbI3JfU7evxbalGzn8aXwRBFpje7YrRVK5Y6xtMl?=
 =?us-ascii?Q?zDe1QE1g9Z4mgE7rjlmNgB3MhOFPt//XrRP+IV4HC/CblHRAj2gB0T0MqiYf?=
 =?us-ascii?Q?EfXX/1YtG0/4FknKLOoEZH88L65TTBkwftMoY5qHj1BWTCMMBArh/HAXjLn9?=
 =?us-ascii?Q?BarJ4YY1CWZLIB2pfNGKxqySnaMsJuM/TlXKzXWai6J5KyWpRgQJB5zYZcRX?=
 =?us-ascii?Q?ZCKo2ZimXGazt/Hy0bB3rG8IUm1hW8By9/WVcumlC8jXeloMy5fsVUoU505e?=
 =?us-ascii?Q?AoPn1V7L8Iavl24oiQ2T010ogLQ5TGpHXZ/XP9LremyGSbxyw1U7rxGUv7oa?=
 =?us-ascii?Q?m6w/ni80T9a2Wi22J3YPIeyPUzqW2gSI7lJYCH8GVuYTuRP1ufToE5y+P3cx?=
 =?us-ascii?Q?SmuxI/TPHLLwn5LwwuxIzCBWamI4tQ7wKLW1IzV+uttc0gfKfuk4QA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3GndiDPWrUS4gdHHMM1wGhgYEyXC+9ZN0timdj24TOTDbZn8m6PXr+73VJxk?=
 =?us-ascii?Q?1uKyfmi7lGULJQkmEL3kbJT/X+YMpEHloz5lIy1fo79n05r1nUi0k2xydIjy?=
 =?us-ascii?Q?r4bBPE/R2pZwDbwdHfe/3ZV/SDaY799pnjzKbsePhtftRZSGe9T+9Sz48rMA?=
 =?us-ascii?Q?DpJkh1zI/n7VaN3bst5F77VD159fthtymU46hdB0piIKZQv8p+JlEXs4lHnA?=
 =?us-ascii?Q?0Wksi/WjyuAYKh+IXN8oh6vZUQS1z8I9U0HFex4hDW2VFYf1HOTHQWVOImqm?=
 =?us-ascii?Q?9xKO3/9i7/bo9hL/cxGWWt8d+48qLG1cNFOkU7DIUUKpSDA3d2E+HsfoSaPS?=
 =?us-ascii?Q?A3oI7Tiyv4YRPsnS0mC+MlUisr//sWr1Fp1MrzhxS+0hP9sZNqJwX/cTOLzk?=
 =?us-ascii?Q?9Q+i+IVOUrwAlkXizXojzrm1O2tVq+CTT5Wcs3bGmFli/YVsedS/56hOssnH?=
 =?us-ascii?Q?lr6Xv+gfC1LtmjFWCRhdhuFfusdrnxmMYsbjUvoz71VFHMHvLhB75w7KOj8O?=
 =?us-ascii?Q?6J6m2pM26O0xV07hbMgomnug3B243rLolV4SVPEnOjHNFC4j6AI+BVyI5TLU?=
 =?us-ascii?Q?zGDuINdLQQy2bG6pwG2srMxN642gc55zWqejfNLs9SYDlGT22Bpk3RN4fO7M?=
 =?us-ascii?Q?aFsUfGld+EZH0SfVSbz60w5NaAJIPDzMqw2BleGP1sK9+vDyBFo55z10Nbeh?=
 =?us-ascii?Q?GiJP7YrJfDcfb5UHky3sYpMZFBVWKSNwh3iLC2mrN+KZFV4FZ3lifi64Kal1?=
 =?us-ascii?Q?Qc61wWNg/8qevoCHOeTQOs4UPowSBfVbdDj6sJrawpqiGXMxB9g3ktAyW8v6?=
 =?us-ascii?Q?1yJ07JuwcXK3yIVrgtyAvgEa8Fn9wIivu0UyDY5a8+n02AP9RQpN1pEB/SHO?=
 =?us-ascii?Q?W/FVKnzz53QrwIpAqtAVizcoJzuwIx68i2eKN0F31t6HFaSHRFqMTPvOLZE/?=
 =?us-ascii?Q?pfd/fVxgf+3qsjlJA0bfRJLZENpDHLEsG0ZDkN3FHDNC0PhHOM9mvB0+F8Fd?=
 =?us-ascii?Q?UNdF7XYpO54+9p0VkY4GXFPCkc2to/k182dnvrz8g4+UFe14IHV9OW/I/rFr?=
 =?us-ascii?Q?yHd1PtKfFvvGHQtUXjLRBuZ6qOLJ0MZtKJdtEjjiCrDxKjSqDeRZmZOzLwUi?=
 =?us-ascii?Q?KFV3huIrkETArGSbf6hv3a+anJvDsmm5PloJma0HVs6eXnH97MRjHA3PMUal?=
 =?us-ascii?Q?nmR7hnnHSls9REcUFc3v/WP2Jw8vJ3/EXcmuEeIKZFW8fZMyTLXIJ369teaZ?=
 =?us-ascii?Q?bT71L8zE2SHOivnvfIUTYeD1VpdKDiYx5zMT6t/zTOMBEukyrpfU+5aoHW31?=
 =?us-ascii?Q?fxxmJLoBukt/cKt1e9d2bFvJR9U/rDOUc+572jlui3Hr6K+TxJj22iuzX/qh?=
 =?us-ascii?Q?piyjhr+rogkWdlPPkZvbvrkZ/tkG1medbATIMrwUMg+45D1eqkV/V57gxKqE?=
 =?us-ascii?Q?w+2em+Xf4Musj5JtLkY76vx+lfM48zamEG5hgYrQ7vxUCvfw1iqr4JWzFM0H?=
 =?us-ascii?Q?HYt9wzO4E+NuLkxyQcSAchGegpTSUClUcos7q/aAbxOmmgpI0DCVSC7w3h67?=
 =?us-ascii?Q?C3XcKgHuRk/t84FWz7LYmjHIGVr5rpRY44DQy5OD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f89d865-b11f-4c67-9e5e-08de286d72b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 19:46:07.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgza69Dq31l8BrfLLdoXNcIH3nDC0lNzRAZw1TmiLY+gxwwU24MlIhkf+MT0ip9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969

folio split clears PG_has_hwpoisoned, but the flag should be preserved in
after-split folios containing pages with PG_hwpoisoned flag if the folio
is split to >0 order folios.  Scan all pages in a to-be-split folio to
determine which after-split folios need the flag.

An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
avoid the scan and set it on all after-split folios, but resulting false
positive has undesirable negative impact.  To remove false positive,
caller of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page()
needs to do the scan.  That might be causing a hassle for current and
future callers and more costly than doing the scan in the split code.
More details are discussed in [1].

This issue can be exposed via:
1. splitting a has_hwpoisoned folio to >0 order from debugfs interface;
2. truncating part of a has_hwpoisoned folio in
   truncate_inode_partial_folio().

And later accesses to a hwpoisoned page could be possible due to the
missing has_hwpoisoned folio flag.  This will lead to MCE errors.

Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com/ [1]
Link: https://lkml.kernel.org/r/20251023030521.473097-1-ziy@nvidia.com
Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fa5a061700364bc28ee1cb1095372f8033645dcb)
---
 mm/huge_memory.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0bb0ce0c106b..d68a22c729fb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3091,9 +3091,17 @@ static void lru_add_page_tail(struct folio *folio, struct page *tail,
 	}
 }
 
+static bool page_range_has_hwpoisoned(struct page *page, long nr_pages)
+{
+	for (; nr_pages; page++, nr_pages--)
+		if (PageHWPoison(page))
+			return true;
+	return false;
+}
+
 static void __split_huge_page_tail(struct folio *folio, int tail,
 		struct lruvec *lruvec, struct list_head *list,
-		unsigned int new_order)
+		unsigned int new_order, const bool handle_hwpoison)
 {
 	struct page *head = &folio->page;
 	struct page *page_tail = head + tail;
@@ -3170,6 +3178,11 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 		folio_set_large_rmappable(new_folio);
 	}
 
+	/* Set has_hwpoisoned flag on new_folio if any of its pages is HWPoison */
+	if (handle_hwpoison &&
+	    page_range_has_hwpoisoned(page_tail, 1 << new_order))
+		folio_set_has_hwpoisoned(new_folio);
+
 	/* Finally unfreeze refcount. Additional reference from page cache. */
 	page_ref_unfreeze(page_tail,
 		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
@@ -3194,6 +3207,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		pgoff_t end, unsigned int new_order)
 {
 	struct folio *folio = page_folio(page);
+	/* Scan poisoned pages when split a poisoned folio to large folios */
+	const bool handle_hwpoison = folio_test_has_hwpoisoned(folio) && new_order;
 	struct page *head = &folio->page;
 	struct lruvec *lruvec;
 	struct address_space *swap_cache = NULL;
@@ -3217,8 +3232,14 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	ClearPageHasHWPoisoned(head);
 
+	/* Check first new_nr pages since the loop below skips them */
+	if (handle_hwpoison &&
+	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr))
+		folio_set_has_hwpoisoned(folio);
+
 	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
-		__split_huge_page_tail(folio, i, lruvec, list, new_order);
+		__split_huge_page_tail(folio, i, lruvec, list, new_order,
+				       handle_hwpoison);
 		/* Some pages can be beyond EOF: drop them from page cache */
 		if (head[i].index >= end) {
 			struct folio *tail = page_folio(head + i);
-- 
2.51.0


