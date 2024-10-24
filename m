Return-Path: <stable+bounces-88095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390FF9AEB49
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 18:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF07285797
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7948C1F76B5;
	Thu, 24 Oct 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VyQLsN8j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mkXs7vid"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5158614E;
	Thu, 24 Oct 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785680; cv=fail; b=IMrFAxUVvIKCtyP9Or+K4yjGomHWMBc7N74vB0xBXcWopMpFnkm5FZpOFrUy+ywy0gOMSe49Xh9Rl9NwTvxgJntNQsgvQeM/V3gNw/dSWBYTkLfugzk4qIt+nYN4lARghdom8tF7by/WYnalhCFEW7qq1qHUbYC90kNFY0+81YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785680; c=relaxed/simple;
	bh=78mGbPC/vekmUQtbU3iKxjlcQcGslvslhOOKI8aonDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kaD2dQkZ93O7MxyTR4iva4o/ixz5oHl7I12I9RnYpXMF1cCOdx8E4LiP2mtSHam0Fo109tS0sQKsf8z1r0FulpcYB7eBaf2WedRXRaSzn8WMxqjH+U3AbEycYFKu8m3TJmHaOF2mJ7mwz0Jj9BqwmhkwFuL0daFeU4zEEJp2evw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VyQLsN8j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mkXs7vid; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OFtcLE019140;
	Thu, 24 Oct 2024 16:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hJb14qOtHuKUg6qXBu
	yeM83bGsCmvD9tupgae9mfyVE=; b=VyQLsN8j5EyVuO9RcNx3pAiIynNUWCnsQe
	uKV1fDiRHdCNCoSRi23zW3vIj9KFHWzlkAEuntgpgbjQfQgvj0NccKJV2BxUCD/r
	N9AJ8I+Ovr40IWjqImbx9KPJtfHzEEvGYYuj6gZtLZqDpjPmcg7hufpqmMNUOcH5
	MBwmrnjqM27MaRnH076fgVMJymEgNiD4F3sYDLhm4fLfEh3WQ3ajvd+TYVqjZsgP
	7zCLBiV1cIbjXQuq0VHQ3M8RpKqw71R2IZO4H/MAaCQmI+1M8rl6NRHzPG7J3LyA
	FI7kqf2s6jphqo0yVRHepZCNPmmoOQ4PcNwS8KSH9o+s9TL3YBAA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5ask1cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 16:00:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OF15eh018529;
	Thu, 24 Oct 2024 16:00:45 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhm7821-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 16:00:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYBee9yZ0qr/V33dt7S2vsSt7e5ZbR1UTRsmTjU4jMPKEZh0BxYDUMfGIlnSceb7InseMTEs1J13RROeLjflaXnbldCVLfm/bIkSSuKq8d4+2X3YmJA2ed/AeVyAnppNhRI2xma4jVJZ/8/Vo2w+ggOqEmKFk35gHkBvicUT82xpO0tUNy4v9GKRRm1mFtrS36DL7sFnIb8LjzEmzuQZv4vj/CwKKm7LObdhLhKglgAaDjEQM06Qd9O2t5uqfODk5tN09a9X10xEXxNpZorz2ZJy4zTly0D5lU+Z4tChhiuEhNUZEte7HpAjR7CE9609Re2da5ZjeOok26CzNIpewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJb14qOtHuKUg6qXBuyeM83bGsCmvD9tupgae9mfyVE=;
 b=HS8/pIOiCXnyPrKX640LFGabm89CSGXWw9MH6gWOs/GipuQ6JtsjnLmJd6JYh3KNM2iIIj1K/r+iXZAttXD9Nc6EFrlubKhtWKLc6X7ZACxh47xhFVD27i4YfjgxcXHsq4LlN7Ex/WRAJEfHCNm84/sUuK0lrkmhuvOvRr4HoHNa8rlEae/CmeETd6R42YJM5Ct7ieSNqAIkn9Bx8CbFLyESfHV521TkpZlNNxE8U5bqE6ubK0aAtqw76HH4ToeB7E2loH2xeJ/zqTV2AyGdf5g6dCVq28Vi8bD2oisX3bWz6NQm17atcWg/UtBtKPhgkwtWPVNgy1ze8nmAQbeafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJb14qOtHuKUg6qXBuyeM83bGsCmvD9tupgae9mfyVE=;
 b=mkXs7vidoSjDCsULG+4T2TfgpIBU9PwSOz7zHjIS/byOWvKM0I3/+B0pxIwxv84yNcO2/kCw/mcJtSLgNC96KE52NQ6FnCiMPr6uLl0DRVD3wyCpXDfbKMIpbojTECpZSBWR1yEbSgvSb0Nb2riT80traxcPOcp5VZchc5AFMbM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 16:00:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 16:00:40 +0000
Date: Thu, 24 Oct 2024 17:00:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Petr Tesarik <ptesarik@suse.com>,
        Michael Matz <matz@suse.de>,
        Gabriel Krisman Bertazi <gabriel@krisman.be>,
        Matthias Bodenbinder <matthias@bodenbinder.de>, stable@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH hotfix 6.12] mm, mmap: limit THP aligment of anonymous
 mappings to PMD-aligned sizes
Message-ID: <00899fee-4bf9-46de-8a66-45088243bd2f@lucifer.local>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
 <20241024151228.101841-2-vbabka@suse.cz>
 <2b89811b-5957-4fad-8979-86744678d296@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b89811b-5957-4fad-8979-86744678d296@lucifer.local>
X-ClientProxiedBy: LO3P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BN0PR10MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 7376957b-7f76-462f-a396-08dcf44501e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hm/hVw1ZhXIVDIw2DeEMCbRM5j2tJ+3rvivMimFsfMcGGxmgYjllb49GXaKJ?=
 =?us-ascii?Q?W/oPDIqBLY9y+U123gk/8aF68tWG3q/vbsnIrTNi5RYFHTe5sk3hVlhWauf2?=
 =?us-ascii?Q?prFkHJxdmfFlasCnhTm1kPQzybJL95PVr/Yt0ujeMSZ9bE/KJOd72iGkVm0J?=
 =?us-ascii?Q?/litIOTGN6+Sip5wzysl6hMhkovJqJUL1G67nj0VRz0d6+ScXJyD3LAcTlWh?=
 =?us-ascii?Q?k+WsMM8xnvWJBeOcn1mSSoKdczwLBpl9jaotWQzloTNEjyuz2QxWxgcR/XOS?=
 =?us-ascii?Q?zxYzcfXreuDkuK0QAoQd/X1E68oQXNhdVGWU+bkp+sdUowIP3iQSUS/EzCTe?=
 =?us-ascii?Q?QdsUulJv9q8f1ZyaVTGMVV+RWITsu8PCWdpi6wCHmNkgzyHDyk8Ik4h2Vmjc?=
 =?us-ascii?Q?ZHto+wM+mdQkSXNV3RcSIDY7WXS6tp2Zb/zaLC2y/tE/zFVJdDfA+8sKaMor?=
 =?us-ascii?Q?1QiU+Hx4kWasgNGGM9evWWo2LrYKycSWOqE/tG2wYNvMx42+UID0A7UdEFzt?=
 =?us-ascii?Q?TTExLeIk2x4MZ01RLx8u0JiSDBWoJFTbl/pCT4ZfwN8+DlHTriq3/8SWilWg?=
 =?us-ascii?Q?ErT3BFY/4+Ol3ty9DpDBzua7KtHoSillTInvvzbiSwZSklg7y96BJD1NSHy0?=
 =?us-ascii?Q?hDRA7LgdxGYXAQYbSW3CScLODfMY2C5dupyArj+9mzKSlyr76u5OeiPn++lJ?=
 =?us-ascii?Q?O6/eUWJRwIXGWRPUwb4Ut4F5ZibuP5ToJyL688YUC4brPaspPDJA8S1gT0xq?=
 =?us-ascii?Q?Iq+YQUMuLRdRd8AZmgeuCtlqMt9msXAcw2MSLMp/WPEJ08CGKjHQzuI2TZC9?=
 =?us-ascii?Q?2DW42U8JTH7wEcqEksAvxixbZYDNdU8rANwFlwEzu8/QI9nVu3jRXukaoqis?=
 =?us-ascii?Q?CtuObY4l/FI6J3wfOFjU39CNjomnRXJiq9uBYCtw6JoWIVJTXMTw8rJsHfc2?=
 =?us-ascii?Q?TAp8ds2FnzYqNMhfZ852qtZ2lnfHFh04fyCbZXJnnR9hXz9jg1Q1i4meRDzr?=
 =?us-ascii?Q?jnj1aCNYGg7H2PhZQiB5/ShHl+V5tZz05DRpL9XfzDs+d92vPDwaogyEhhws?=
 =?us-ascii?Q?az94QoUtCrcxvWxiyHAwgR6nG+i0jtxmj9QdVhmKTbPWL0LA3d0KE68oyMox?=
 =?us-ascii?Q?4tLrQNx+0fHccuQT2Fgu+tNbyreS+KjASNJkUEpGGOO1Y1Qjv+0nbnN8vj8h?=
 =?us-ascii?Q?GRiiWX8eZ7ouTEVEvb0RmqPul3LNfq9S4E3/HP2jDLsbe7ne3jLPKt8wZ+2w?=
 =?us-ascii?Q?pEghoFbgZphHWtvsWTJ1yCZNnch7Cri82UUhibm9b4M9kbDEB62kyeAsdPVG?=
 =?us-ascii?Q?kgNQZtnvQu7lTR2AcWNIS7SQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MaK2sycsiLSnNomvqAjnzXCpJYMb6bnFE5FoP+NJeOq5RF3pnQdyEgF8Kfg8?=
 =?us-ascii?Q?7P0O3rGRCPavTZ4NnES8k64uA8klzKc9uZFiFfeeVmwjUGkSvQnABTx5ONFl?=
 =?us-ascii?Q?EDcgueSynJhya8juEOu+InmI4MTWGghvJW18YPHXjMx3MRVjts4cELaNWS3A?=
 =?us-ascii?Q?hKoxAxNMp0BKSTWMpZrMB/Hbk7TQSmcDKw+FsZtlAw91/HVgMFvmvaft2qSm?=
 =?us-ascii?Q?RCIyLPEVQSbkqA7Wl5KBWcgDniMZsYVj3f0Yrx8Y7LTw0Oq+qQGFbaDOJS4q?=
 =?us-ascii?Q?wgM3kRFfVHECu+hOnyNrFtrsCM6AHhyka9AfjwpNSf6z6wb3cHxuTHYJtsoA?=
 =?us-ascii?Q?utneGAn2ls1FcuZ5oIMIWIzTQK9Ihx0zCpdtwX2VkXBNy7db835pHKVKCT6z?=
 =?us-ascii?Q?ygFA5+xpN+VrAgRA7I+KZ63xMSYrk28TAu5AIEIEUqRsyyPDfCODUqbTGCww?=
 =?us-ascii?Q?sozTOWoXsBDmmwNs4FX8elTl+5v+IxZm6+WzRSLuRyrV4TMhfTuD4+ReWmfB?=
 =?us-ascii?Q?mlcq9/8fDe+8QcLa29/zt65IdSoleKTSOwcKDPv7LCON3ykDFIJ3Px64OjzK?=
 =?us-ascii?Q?e/6/HFAeuS+ASuC3/QgZmNu3QDpmsmgdsKRbxYiOBcNgsXf3pPnM16GqYVt1?=
 =?us-ascii?Q?GRpkHGsl64ZNetDsmf83oSM7rr9aMWPn4PJOazVK4r2Cfqxc36xcAf7oy5Xs?=
 =?us-ascii?Q?zqxpxNgw1hH3PC2WDVk8vvQBsWRUYv2ilLdYAekfoaepl+isaCTBqX6PtMXC?=
 =?us-ascii?Q?FCXPeLLovNy49i2Sge+p0eWbj8+bk1rIcj+FMl4Rm57TRNB91nikxH3mBC9B?=
 =?us-ascii?Q?msTXSIOD6JipgDfKioj1IPifcLOzE7bkTNwhBpOpyOoq/U82BgbeN1ioJJsT?=
 =?us-ascii?Q?iCYZr2zKnmab+onmLIx92azu8VSJOypsvcJnioCEfiTthabo4di6gqAIMUHm?=
 =?us-ascii?Q?mrBifCdYzpXsWZVGHY7A3RKwXYnK7Dc7+UM/JRJUAOitHafeVg0CJTozwewA?=
 =?us-ascii?Q?J7qmSMCtgUJom+aV0xdf2h39GYAWRyzAoNj8Csp5oLRUu/CFmj0KRJHVzA2+?=
 =?us-ascii?Q?djxJezBhdVsdRVlxCkyanvLFR8k33TRm/RIX4t5mlndXWGEdQnKKe7m6JAUF?=
 =?us-ascii?Q?fTYUowssicrenKwl8uOqh2hw1SSmdOyx4aof5a5D0GGzNl3QES2DDKJBVQe6?=
 =?us-ascii?Q?LZW9+LVycuXVeNzBFCAT7HXXUrVq/DqrtJm36Eyassi3t1PEc+8VZ2+BRt5B?=
 =?us-ascii?Q?BXwksy1AHTCYqSL25EYiBHYVI3C+kOxunHWBGD/AkbLW+BSi8Et6doqKHkUq?=
 =?us-ascii?Q?YMgbJBZm1CQYa50OV93TdMWF16On715PDwjUCvORM7/OJQan+OOy71eo8H3S?=
 =?us-ascii?Q?9DsJ3Wdvx7oygBXKqzuzHWZVuXmuxrdzrlFl2cjfCkzKxhrjJhMG+PCKn84t?=
 =?us-ascii?Q?9LENcsxvC0SXP1K5l9+m59s8DwdQgLs8/dM01Oi/ZG2iAjteRE6rCglpOxbH?=
 =?us-ascii?Q?mA5A+NIPekms1MpLb9fS0ycZQMF2nJGljjpbOtjwlGMH4OX3OLxYacSWGV6D?=
 =?us-ascii?Q?IxQPEW/jZpgaks+g9j19jXN/2iSFwg2KPU2LIPvlRkuRHz4YkoJLVhK/k3Ex?=
 =?us-ascii?Q?eBY+Gt3QDMmgZEM0n2vlmExxAx1hcjp3j2Si5XBshXBzUlFCLmETIOck75KV?=
 =?us-ascii?Q?h6eOhA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	waX4S4HzBtHgdFQLFfza8rEBzTszrXn/2Nkdvh8EAmuXGbgoVxTTE78HF8jXOKfxiN1+PJvmNuA/kvZwqZRaxKOfleUsCZVUC/C41J63myJmtFoAmFw5mh9bbzrlRnhY2WbKb1HFnRTH5Cxq61tU6ANW7sML1gPzFVxwQtLp9ZcYWi2RabyZFAjxRBae+gC2z2hc55ED7+gyrc+czChTM1JRKHbnfCHc4OMECE4CbHYxf3RSye6Bf+MlzFZFXBuVeM359sL5tWdyUMO8BlwoanM+Twk+t084bKXaHtzUYUgYgTwzJPmj1i+0wHGjOkTyjx3z8XXF/U+WzYt5Tdj/EfugRd5djpIi6SfpC2pr1jx+S1U6aI0soQiZt2qiTnM3h1PEc6jJ+rW6BDSGazgp/BrDfG+q3Ki7tXq27X9ZQ5darpd9iki/3QjyEXwD9TjGrSSweTQiEoCYpMyslEEZqf7wgTc0PcIxLksRcQ4OJSFamL+QSdyUktgRs8B6Yd5LSQjRJKZD62mDIxFqh9o9Y6uJx9SzvIIg3mMTz5iPDdnJfskVtKe4+xUHZwH8rCa96A2ybhP4+1V4uLw5fQ7Yxjjdy5H2j3I412O2N/WX4Nc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7376957b-7f76-462f-a396-08dcf44501e5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:00:40.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0V+f9Vkg9ieAkZM0+JSIc0P65EqQdzUfhLg05weHYSgE1OVlUqPLBpu1+qvoFUPsRYkbvUOV4GyOT98TAwi7uzGq0clWbpjQtrU5nR4L10c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240131
X-Proofpoint-GUID: tX9IIW-Ro4CrFsD6JzYZ8ZpMLWh_XwCO
X-Proofpoint-ORIG-GUID: tX9IIW-Ro4CrFsD6JzYZ8ZpMLWh_XwCO

On Thu, Oct 24, 2024 at 04:47:54PM +0100, Lorenzo Stoakes wrote:
[snip]

> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 9c0fb43064b5..a5297cfb1dfc 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -900,7 +900,8 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
> >
> >  	if (get_area) {
> >  		addr = get_area(file, addr, len, pgoff, flags);
> > -	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> > +		   && IS_ALIGNED(len, PMD_SIZE)) {
>
> So doing this feels right but...
>
> Hm this seems like it belongs in __thp_get_unmapped_area() which does a bunch of
> checks up front returning 0 if they fail, which then results in it peforming the
> normal get unmapped area logic.
>
> That also has a bunch of (offset) alignment checks as well overflow checks
> so it would seem the natural place to also check length?
>

OK having said that, I see this function is referenced from a bunch of fs
stuff we probably don't want to potentially break by enforcing this
requirement there (at least in this fix).

So disregard that and since this looks otherwise good to me, feel free to add:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>


> >  		/* Ensures that larger anonymous mappings are THP aligned. */
> >  		addr = thp_get_unmapped_area_vmflags(file, addr, len,
> >  						     pgoff, flags, vm_flags);
> > --
> > 2.47.0
> >

Thanks!

