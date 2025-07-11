Return-Path: <stable+bounces-161644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5C0B01B4A
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 13:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159B13A648A
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03B828D82F;
	Fri, 11 Jul 2025 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="raxRyx75"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439BA28AB03;
	Fri, 11 Jul 2025 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235093; cv=fail; b=kNEikOzqMz28A/3k6n3vDHoKKfx2aKBeKjVdJSSZqeP6AYw5qy+IuZWrpr1Oxz0cKSbDuaV4RivYMMy0U5eBTi93F4uM1GyyJNQzy+ycVqAnXA+8mSrk9w6YYLK8WjKIq4NW8eLnMUxgbsj0gsNuZdNmPwLdGGfqJQDRIw514P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235093; c=relaxed/simple;
	bh=o5mDQEo+7BQVG61KA00Al7UX0l9ECK9Hx/igxHZFIxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DJWHQVxOAN8f2KOww0i6m1wMuEvIOqktW9uQLrxmmQFUkEbKDvJzp51W3JZlXRfyMJntEMIEF4ZEUPFxT6j8NHSy74zntsEofCsL1NlxnBk2bwB5TiJzBsBk8nfFY0H9amUTriuLr3yTGDGlPzcvHVmocdKmLKrAt+WZsUPN9K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=raxRyx75; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9iPmVP61c8yQxumJmgiSrlu9kOoo9b/pNabvtSt/uYPz+mrreFsIbzT3Dzq3UwPsiJXgeZM4BpMhkMfbqv/qdvcaPPQ3wzJGeN4yfpvUC2/Lr5meUb/go8cPJknWZfbHHrf/7caqBN+z4uvvqBv6vm0ocW/MIsPbWWf/MoRW50gZJLOZgzKb8VCGVotbblqivmruwIvtkkeOfk2p+OFo1CjvquJCQZ0ZS3B9qoyjYqlKTjAmZXdFwvLPxWo6XOLyu82OvUaSc7Efij/o6rKEIbkGaQZk7kQcCNUeGKEl2UOZ+kk+/J37s3K2ulHASkTD/hNbjS86ut56fWAuM3vuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5mDQEo+7BQVG61KA00Al7UX0l9ECK9Hx/igxHZFIxM=;
 b=c3bge6FpMTuoIxz2Rk5axddNQYv2FyKYv4I0+updUYgi5mc9uePrSfKor873qOR2L1IK4p3gjAh5D4Qbf5KMnqFRkImFf6i9gMJ2cIYs3YT58x24FbW0Xm8hWMso/NSz67X6P36UdlDI2MZJlf0MoTCTmu/IKZpKgZfp/yDki7PWtZE0la3rPmAh7W5M5i0IokMUwrYjSJFhhd8ZNgO3rxQ4da7+Hm1H9loMNRhw4VcEDw/K3PILV//LxP7LPrYt1lCbFjlcF7lxClXyRH7BJglECUj1fINx04NZDFIFH31ZBP08Z1IwopysDv8pVYcTj1JkOrGm7PbciilqtbqyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5mDQEo+7BQVG61KA00Al7UX0l9ECK9Hx/igxHZFIxM=;
 b=raxRyx75+NF+mN8qS84Q61Zf51lGcdySj99rzSFiwNOMWmg7CFGFt2MCuaHJQbU7xckkTbVxB9PxxKGS6Lg3zyA3+QIuFkZ9E1wOpyIS7JZ1zzdCoMa6Xiac+JBx/3lmCWpyo2KN/4fOxxT/O+hgVO2QbU2Ymx1N+2XcZJqEi5jgTFAXl82QVWovsSg/dENxCzN7IbnMeiQhvnYvIwMdHNx0HpH83wauEzq6IJ+jCNvdSANKaMPeZQlCNWfJQiOY8hIR7qXWWgla6NjfITmad+9VAYQqkY/xsu2QdQ9bKd0csKSMsVVlUoCtwjjtslI2zawsVXg72r6CtRteP3gz9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:58:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:58:07 +0000
Date: Fri, 11 Jul 2025 08:58:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Tested-by : Yi Lai" <yi1.lai@intel.com>, iommu@lists.linux.dev,
	security@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250711115806.GW1599700@nvidia.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
 <20250711083252.GE1099709@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711083252.GE1099709@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MN0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:52f::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1b2321-491b-4261-c934-08ddc072335c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wjM7mUhpMNTysO9uKB+nnLEO0X5bWg1LAmG+HftwIJIJB76ZS0xflFzf7N1i?=
 =?us-ascii?Q?wSVvPi72Cy3shpaheYnXl9qhO8Z6a8wlY7yHEvx2m0v/ciLaRxOw28Fd5DLJ?=
 =?us-ascii?Q?ah1g8JcWWZcT82hXXFMKy3pJDgum+6I3tW5mf+A89QRG6Jg86sbBLHpJuzKp?=
 =?us-ascii?Q?cTBnYs9CH2C06xEUaSnv4JkT9ZcKqJfnelilM15saabQNijEJhSEa3kOm+0C?=
 =?us-ascii?Q?TjnLDMPUFyfXXleqtryg2yX3YWwfyDldHNAUDX1UlAl69O1ZjYMzwqZlmTbP?=
 =?us-ascii?Q?d0kDgcOZyN2JFAg2pBqhmd3IAKVcKLSLCzFF7FUATazjeRSKbhVG675IGiFY?=
 =?us-ascii?Q?YSvwAIgscxrPB2vcvyjRu1IBBTL2JES0fwwRxjrx6vKjq6NxIf1bvwSkHVF5?=
 =?us-ascii?Q?y7XKLzzqhRxv23nc2bHRq8cgKRffZLpM8tnValrbggL5csrvCud6MnQLiQx+?=
 =?us-ascii?Q?4nT3t5zTlkFsGnweTcPTgo/Z5MqoTn91gxHZ2Hlppx484b9pNYAjLP7UHWt0?=
 =?us-ascii?Q?kTZPa5DC0GEP4oP/PR/zkyxeWjm2RzbW1EsIrJ5cCTzr9q5Wm1hgYw2NE0Sr?=
 =?us-ascii?Q?EC2QvL/UmPzlZ8nk1m8AZ/5y8NWY84OYJ4CtmEXpudBcKAOIe45+iQ96TRXu?=
 =?us-ascii?Q?xnX7kBFHHx4Abp6X/02x9TsXFsi+GROMtvTn1qb6BJAQGwI5w48atpNO5tzK?=
 =?us-ascii?Q?CrBBCzNMTZeaR93VS83LCFSVQIXd3ll6Dgk2ftHLsLm9wrSzqyksaGmjFTzx?=
 =?us-ascii?Q?Odr4XqW6GLgJ1RliZgAYyzMYq3LrTsHZv3nCe2rwR2iipv9PB91FE+0zYG1b?=
 =?us-ascii?Q?gXMDoqJAqJCuuL16jaZNrsBb8c4WWFF4d+s8OsPMUCjSJEl7LTxPWeUPZVdF?=
 =?us-ascii?Q?xYoMj2WM8Tq0XVM3297rRhrLZLWEg1BsMvkB2SqDFTeZeCov4YiKnqNs9u7U?=
 =?us-ascii?Q?SrcS4TjTi6Pz3Wc5Fcs/9l6lU8t4QTsXhX8ECGFUEVVfZAPU3QkpQiGZ9f1l?=
 =?us-ascii?Q?yd49hZq7nZfQJanZwWwyFpoSKLEUAwHWb3+XblEu6PNpCTqLDt3pjxLwvrVu?=
 =?us-ascii?Q?itaWJMzylp7O1ClrhpM1qySqooUDlD1fcAm/VXkIYxsz17QNStpHu+UzpeR7?=
 =?us-ascii?Q?QSTYUrpKs339ZDc90cJk8iIECfSq2/mlluKIpEuoC1zyk6kud+am05xztOko?=
 =?us-ascii?Q?R6G73OLBkYgPTS0Yswdne5qQUsu5lsCYUPFezF0B0hTM1Bk1g2KKi6dInANz?=
 =?us-ascii?Q?flFwvLMQ3FlBjVS41sZFybABSx33g+jIIedCZ8kC48HstP9kpSG20P0RfVuw?=
 =?us-ascii?Q?ah8CNVDwIUkGiK9GTucMFoTZIEcw2f9tvQgqJj0MqMvXVtllpHUyAqhuHiCP?=
 =?us-ascii?Q?0Qru0gh1TPeVaUNH7SiMAKdIuJbJpxJWD0xsY8U/4xXymQAOXh9alIxWSc0Q?=
 =?us-ascii?Q?X7PZvir0zB0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ahc90w5DYNhRMpeRdAPBKtOJj1xTxWkCLiuXXTuV3nMMDooGkGwDA0exANmY?=
 =?us-ascii?Q?icSngAxC0UjWYww3EK/YG2CG2VGP9skhl9NocUSFDbxCruOBhy1qu3fEZBF/?=
 =?us-ascii?Q?QbvJ8RUsWZJa76REBVkwzFYoWhqHsNdx/AXjpjTzPy2q3hbO+EBBEk9fn/qC?=
 =?us-ascii?Q?hM9gux6QAC/bNM7Y9U4rqxiBy8nX4EtdYiC4J3ab/yu8AC/2x1Bln2zAk7TN?=
 =?us-ascii?Q?uy4mmEbG2yjpKxE+9bfOKx7AYCkpOIRIP1NvtZ/Qbe24yQ7/lWkVJ5RJD8us?=
 =?us-ascii?Q?OHgvRjy/+qDVYhNmt8nq6Wnne8wW8T0+8Lm2zQe8zQGlhrIlUytThpjiWWPC?=
 =?us-ascii?Q?W1TljK4zZvGydoNhpwp7i8rd2ObI+YoCR4O0zdErwL+hGon9sY/Nx3n695Pn?=
 =?us-ascii?Q?9MsfkgWgfGaiKvJQ5ZUYr3mf5RR1x9GZdn4/9LSkDNidwIbZcbQNNSSoyg/L?=
 =?us-ascii?Q?wLVlz+i4jqxkarTOtxioAo2K/eXraUy0sFBjvrZ7dPAkj7kDfwe7YXnowD0Q?=
 =?us-ascii?Q?fgYziUJ881VbLGA/Y8pQpmdESH7oo21KcLlvnrz66rmSjyBr2xYA7IU5KwhS?=
 =?us-ascii?Q?24RvweYp3TV62WKovvqAIrmBfsBJOFquNK96PNBGf1cvtw6Y+COW8ccdM2QE?=
 =?us-ascii?Q?F5XYJiC/oFNem162Ax4VpeUTQ1ubg0/351VrQv/yC5IwzLYiHqE0xDQ/Ju6I?=
 =?us-ascii?Q?MqP7IcMkh0lupbizqo9Xf1j+1LCsq6g5xIWdDYGx1fo4HzRsj2zSEbBbNpqP?=
 =?us-ascii?Q?Rze6gk/NIOs6c6Gv9dySDw50ysIuxy4Qk1JKAHdTHDWpxygiI529X/WEM2i6?=
 =?us-ascii?Q?4fTGBz6wgN1rMhZp2jY6VGbme3GdBHYMkoQHVMdkq2ENtFBgfPw6/VR5ZKbM?=
 =?us-ascii?Q?U92JYhL6ob0qQ7rQPojzaibTRU10AHyASnxfZHiWCBx50ZnywTkm2AVChIoA?=
 =?us-ascii?Q?tv8bfMWEekF8lez6D4bers2e7jQZ2tJ1tCBRusxl3VI18quOmxskOkoj1mhW?=
 =?us-ascii?Q?eZN1FY0QB3qPj/+SLVx0Pfx76MlK1L9mqUzPR+bTzPCCcRNghBaHCu7+4D5U?=
 =?us-ascii?Q?sZnM/UmfmeYSHlneIqZjW2i8U2HLmvb06B0OEWwCnIUBO3B0VCrZRpsg4c6z?=
 =?us-ascii?Q?qgOV8kuLSHBx0s2RikZSqgLHS7FcqNrdAf7DTihVkW4VwQX1aNyuc7m5woF/?=
 =?us-ascii?Q?swJ/pnfqv/gDCfZqQb8UuEPy7ddoJSO8rMjRO56uLg8WFg2MvyG2k8dK9VQI?=
 =?us-ascii?Q?1wCNu9u/9Xnw0AgL75vX9WPmoGBw5dlJiEztQ1cXLc+wgJ7mwOgFRxz5+E/P?=
 =?us-ascii?Q?7db1PRAC1Ga2EyAiYiwVFwgH1eypSnepuUYjDfw/ZoLWZvzO7nn3Ts8hRh+r?=
 =?us-ascii?Q?33wgKccwmvPkXz8tYelGjZ0qgUh/Fck7dAZ6zLUGOPkjQITQtc4Ts3MWmrKZ?=
 =?us-ascii?Q?n+PgljJc8gpNBtHmDsf73fIksWSmGnh+tI6gSSqNoa+4R7Wiy2J47ppcU3Vc?=
 =?us-ascii?Q?Ps+G8auL0zEyw/hNxG582o1I10NWvx2yolf0cDwedGCZsGXtGe2eZ/SmXEWy?=
 =?us-ascii?Q?+49MfWGzGG6QmEK/q4RTTjJ85+d8A0oR4tmMtAAU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1b2321-491b-4261-c934-08ddc072335c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:58:07.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqmW1v6Uias8AulTarFLp3Ka05VLaeGV597huhXBoTvWISDBT5ZiQ3f1dfhMUSVM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

On Fri, Jul 11, 2025 at 10:32:52AM +0200, Peter Zijlstra wrote:
> At some point the low latency folks are going to come hunting you down.
> Do you have a plan on how to deal with this; or are we throwing up our
> hands an say, the hardware sucks, deal with it?

If you turn on SVA in a process then all this same invalidation work
happens under someone's spinlock even today.. If it becomes a latency
problem for someone then it seems to be much bigger than just this bit.

Most likely the answer is that SVA and realtime are not compatible
ideas. I know I've had this conversation with some of our realtime
people and they have said they don't want to touch SVA because it
makes the device latencies indeterminate with possible faults.

Jason

