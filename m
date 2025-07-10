Return-Path: <stable+bounces-161570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9906FB00337
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 15:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689001C45407
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D217741;
	Thu, 10 Jul 2025 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oJOYy6uY"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91022488B;
	Thu, 10 Jul 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153764; cv=fail; b=P7gq3FT6/CcZWh4h0L33VK3ZdssIp2OJAvQFagGOZ65BfXZiOaZnpWuo1i4AOfAw/cZRbjNDWuabCJwum/7sQ6oP8SaePh02ALOmiECj4+s0QMm0ZsYb6LVCrgLr2kwfsgJj0ZKQLqSejJpBDJBmN64WYuiuDLL8Z6IxuSm0j6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153764; c=relaxed/simple;
	bh=LG/FS4d05oBEjtJ+yZdoZaPw2QTIkjpko1W6woa5Cag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bmnidkuPoKzeJcI6qoQFCh9fBKmc/e7ECMAa2dJW/0Hp173XpfMBbVtYhMhK4XmPrFRfXIja9JZ7MdVvSEej6xWGSn6tQ6iuB3BAcS4Ta0dFdTJzw/WSWpSm+yDPAtQqwsyQnJzxKYyptiNv+9vglkPyExM6q+V9Xe1aVQucjuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oJOYy6uY; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBlk6b5jdZ75RdJWPxs6NUMarUm3AGSMb6gHSI6fgjx325gL3btEeOIML1nKD4jyJmuPjZpLD21lR2r2EsiAcGyNMPTJBi2h2qHKzx8XhruayF7Pt8XKlnCqq4fPlRU17CAqMEKIyTrb1rzO3w55FtdyXnDBBqUq44Z8jxFziR8k9T4aCxot8zAJQtZca/vpWt7t6tql9mbo87RWDk8pGSAyJdEwPvgfe018nqXuAyWzlWQPUvWairYsyBgN5/GtMRHba3DDgZIv7vlZruOb+kdGsXYwb9iqHCbns2+yn/34exeno2fIzMZ6oW8fTMEe3GTEKBZWdci8mOSc+SnYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQBkSltn+N53YD7MwgrQFHBGw/rrxu7ZvVXNYfgXT7I=;
 b=dS2FiWn0CHe5KujhWywZF3yjYn2g3Vc327rVXIroGnsBcGOHCPn4sp/u+k6jdnSqw1pZccH3AoONMtaikeQDLKfgh6GR4cD5OENDZAHIobE7HSznDI+zt+0FW2ui/VD7g3uPmvMFIaO8APwZ1C9UVaCbT6XCRAuSz8HN82uSf8T2PppVsPLlNv7QHaU1IekwKFiyXfXvQ+7gp/YlaOcWIz+PKrM2ZONFMpnzmQSDVq72DYjqyyZQyGIclZMS9CNq6aBrzLIxWARY/xIia494oKOk3Mu/EulMh1e9ZIY8R8xfoQv2pBTU/o7v+guz1PwoFPbYPjb3MJMYBkWqmxJd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQBkSltn+N53YD7MwgrQFHBGw/rrxu7ZvVXNYfgXT7I=;
 b=oJOYy6uYvH6fhP2mg5B3P5e+C0rfRI/46QtUnaxGM3uFHA/j+gfRzzZRh636jv3okvXnSn3DjLXRB7GbyURts7RBQwea0UNezDTXLDK0yjQLv77lJPvzz5YjtDSVbDkHRJQQIW/pg+n207MrtOB2qOeyR/3YuqP5/vBkUh9pPCl/6ZdqKZBBPsKJYxyLeQVsWxo+htRInqjroiw3y2yl28IXP6dAavjrR7fNf5js74BuVPK+kfX0mUR9sjMkyllFTdkHyU9aJ63Z2YEfzwtcCvgCTtbgf+blIRu1GBBs60q1d7x2sSoUxL61hknXqW0Gi5u5I/4OR3GqNMnNmBeLTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB9498.namprd12.prod.outlook.com (2603:10b6:208:594::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 13:22:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 13:22:38 +0000
Date: Thu, 10 Jul 2025 10:22:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Tested-by : Yi Lai" <yi1.lai@intel.com>, iommu@lists.linux.dev,
	security@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250710132234.GL1599700@nvidia.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <ee7585bd-d87c-4f93-9c8e-b8c1d649cdfe@intel.com>
 <228cd2c9-b781-4505-8b54-42dab03f3650@linux.intel.com>
 <326c60aa-37f3-458d-a534-6e0106cc244b@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326c60aa-37f3-458d-a534-6e0106cc244b@intel.com>
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: df944cc4-b24b-43cc-fcf2-08ddbfb4d6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTLtZ7bGsyM22vxCAQiWCQJCqPd2PmFYVkZJgEpXH7tUTttHbMvPkgb7+LOw?=
 =?us-ascii?Q?RjpO4rOqZhXcp+CN413FVtIB4xJFXEPDoBdveTr9WFJ7Bw8zQUoWEF9WPmDT?=
 =?us-ascii?Q?LEP6k/isM8TJ7V9rYgpAqKgFlAzsm/m+j5kp5R4xO04poLMgSlo8jj0LQqwc?=
 =?us-ascii?Q?nu2+K1NLpAlo673ai5yHPvT9H8tFy7bpi5SacnRL+Ybjns6QDS2Ltw07sFOw?=
 =?us-ascii?Q?cX7v89EhHZoZiTJtys7vw3mGrQoLpRDD8ChMYJYGisZF3VWHRIbqbtW3gFu5?=
 =?us-ascii?Q?8JSLmxcS0KeD/nzeLYU09DDZuIZiHyHnrP9vJHhMX+HLq8bhg5Y0zZiPbky3?=
 =?us-ascii?Q?ZmIts2dIcS0/MO6VE621/e2DWrDrUWbpguW16qgjmEVDjpFXRZYukBOrdGsh?=
 =?us-ascii?Q?mLEmyHXVPEbqIa1NiSzzIW8jvgfdCad6H0Yq0fvByhwrl3YizXlfn7GM0v4n?=
 =?us-ascii?Q?yHnzwKhtZ+7MVUyHvyBLIDixnewH/DjdsoH3VSyb6wmij7rM4BwQ7423/LUc?=
 =?us-ascii?Q?c148JkEAN3C1tuvYHgHzfzeGqQz3CZt+OTt9MJk71OmXBHcV8xFyvfx9U/4b?=
 =?us-ascii?Q?nmZmDfBIA0Nld7SL1Br7AWCkm7V8dsRLpZzfON6X7ntbzy15IOqDhxTY78gC?=
 =?us-ascii?Q?Oo46XuP05ooeHjqAtmNtJ/6VgShKe1MsY8pAzEGloLAk7blRnlanwydWQ25X?=
 =?us-ascii?Q?TBJi6TZGCb4QJpRzr8al+hHWVYoYAv80TftvMt9DXo/F75tLrqeiLySw4l4O?=
 =?us-ascii?Q?8CFAPWxVX1twQO7HtQBwJ/rk6OmEq09MulcS52OVslQtOBI8t5DiNP62CFNa?=
 =?us-ascii?Q?Za3BkjtyIZn+qSptK15nB3zYJxbAGt7fpaXc1+N0C1ye+1/6N/Ha/4Q9z4Uw?=
 =?us-ascii?Q?H+gd48lxIqnuxDFiD1w5VJu61eZFToV45V5Mrx6vP+h2gHSPnbgnZYIYz8oz?=
 =?us-ascii?Q?CcEjKyCbnwxAuAleSBAdLdeo8RHBj9fl1aa/bMo4jvL688hpQ2yUW4lVhamt?=
 =?us-ascii?Q?sUEit5QJa/ctcWaPrmfNR44tpD0va8XSyfDgfIc6N6qiCM2LyGeRoFC5af6I?=
 =?us-ascii?Q?xV2dC8SgQHaGr3zujeBF4SvkNaLvsFptDU5t5hKTIfq9LPYvwkb/Ly7iG4WN?=
 =?us-ascii?Q?zEiL2fE0LM9y3Xy0sOJ3GN+gL9R5WS22V5XMh1Kpl/YzeOxnChYr8vxYz29l?=
 =?us-ascii?Q?0SMzSoyIXZWHXGf4M2yR9iIcEIIWWiIG1jslOa2+S+db1Nq4iqnPDsFOcxiW?=
 =?us-ascii?Q?/xo3MnTCR0yXqnC1Kys3NPu0kP1nj5XETH19u8UCWzgRvtBg0B3JrnNHZ/1c?=
 =?us-ascii?Q?nZ3NMQHaWWt+N8My9I8n/p+y+2yJ0K9iVNYON8XU7LEM1TdcheIwYaxmUqYr?=
 =?us-ascii?Q?gjYyDSc93AzxEXlMjMUTqDAkr2DVxQtkPWZPuhnOcoPG5DJwLoVrXgnSdYWx?=
 =?us-ascii?Q?WF1UGHiMv5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ad7rtHWqh3kgQlH5iIZJoBeNCtbOj7CbdPu2u1wBK73z9yA0v43DczH4NO2C?=
 =?us-ascii?Q?c5Z7MbeSAEkXqRFsccoC3ot1EVGyOGP4FbsLUGLsE2BOmAZrBjaQ84xFTYiB?=
 =?us-ascii?Q?HjFF6nu3imbSJshNRf/5ZwRxCu1FIUiPyB6+oSgJnjkECAhI1QNvW01R/4yV?=
 =?us-ascii?Q?DQEQ0GKA+LcTAZnZgi/r3doAFjBi/Nq9E4lyVcw0QSOY9T5uMDXGq6ZIEM0t?=
 =?us-ascii?Q?GtW1EUAQojWaIVhXTJQphFH2NrzsEzcaKHlj4B7QvKcEqSyl2QJZo2m42f1m?=
 =?us-ascii?Q?hSY6UNIVzLOgT0JIewxxO9spYmUQqeGLNrFQYg6QhVmvqiVn6sgiFASX4EKc?=
 =?us-ascii?Q?L0fmTBciWl80CSYdcf4RE8/kSi82fLCRycUT/MPf5J/7y2rpuIrSThlYpzD1?=
 =?us-ascii?Q?1+AACQMMytd5cwGMiHjrdzj3dp6TRtuzlph2r8AKzJwrAfddkxQ1VRWS4Z41?=
 =?us-ascii?Q?Kf9u/dbzrS+kIT0vACIvEVcqMpUKaPMOPr6w0pD8bu3AMpjQCUeQYpUOvwRY?=
 =?us-ascii?Q?ydjbtmsrIoU1Mp72LiKc6dOMoNiQVkmu5ZQ0dS7+xH6QLcM1FomZHUsA6s0B?=
 =?us-ascii?Q?XYsjluiMxfc88KQi4gv4dN91wxKjroO1TvGLTNInuEX/8/AeT6Xh6vaQf9xx?=
 =?us-ascii?Q?/o+oiWHb5YPGGsrGnwKoCaiukpz75l/AT7IWSw9jJP1X1b+t8kkyt+S+xFMF?=
 =?us-ascii?Q?SLuVchvIL8plXils8g6L9gAmqf28HGB0CuEhlu45VrU7u1gbN3Obwa/ErJZ8?=
 =?us-ascii?Q?CqKZ82uJHmwNQhqUALIRRw1gcMNQ8h26J2+t3OtdGdeDwStQtyq+Zlh8d8C7?=
 =?us-ascii?Q?7zIx1kUzgAo+Mr4GMtgTZec09TqAXep2IQhzjRdMlFgwkZvYMcmeKDkqjLET?=
 =?us-ascii?Q?lI0uK4B/VQ84vNucouLBQojFl5cseonv/L7T4dLg3KZrP/KgY7SLdgwoUZqS?=
 =?us-ascii?Q?3xV7lymmUa2r41UIXcr0bY5rlkgwlbDoo4dSsk8T1DZ7FavhRqRwHhJHkn5b?=
 =?us-ascii?Q?6mjz0QTbQpjukd68DprweDpD3hjS/RuWPplPxlgCMwtBZnTvbm+P2+ctfg04?=
 =?us-ascii?Q?Ozk10AE1LK17+4HbR6aTPQesTEFzs1dguK9xUAhWGjhfnnFdcizPvMGfBCFk?=
 =?us-ascii?Q?p/srEU6qnpfTp++e3CE6enTEVAc6+IbEQP+QtxE8kkEAjQdgcDZXXVoY4wXP?=
 =?us-ascii?Q?GwR4D51AVu0DUFOys+ZHBz1sf64+9AbCBZmV/3ozrju3cX+lY78pIzd6Otxi?=
 =?us-ascii?Q?7tvGsZv3mPZO4vMXTnS5YDmKkaEwtjumAYsEPYJFMN3ca+kvjAhrFbOF7Drd?=
 =?us-ascii?Q?caiX/BOt5wLM3AvnVct+9PZq1/AOY90fStU6QMrIyex20FHybYW2VBjtsb42?=
 =?us-ascii?Q?KRD76JjvCrq3v8RvoogpiIDPaqm8tT33N9vu0yM34fMhUbDkJzotbUdXBt4a?=
 =?us-ascii?Q?+/MNAI2voGStRaehpJQgf9LoRfwu+3kBWID4K0JFjyyB5WuxoN6ur+Bavt9H?=
 =?us-ascii?Q?thlAGZRvdxLfCkdFrGXygR/FBKL2L++9JGUlaHxiPNCjwZTAvyeF+I1T2ITT?=
 =?us-ascii?Q?nLsF9GGxcEzQ+2zbIXpBtHjevATA7xTMe/qT5pxS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df944cc4-b24b-43cc-fcf2-08ddbfb4d6e3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 13:22:37.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bs9h9L7iouIX50R6ngiITbYi8E6OiTnWDMnGpwFwNSNH+9C3sNt0xUbnL8Tj/X6R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9498

On Thu, Jul 10, 2025 at 05:53:16AM -0700, Dave Hansen wrote:
> On 7/9/25 19:14, Baolu Lu wrote:
> >> If the problem is truly limited to freeing page tables, it needs to be
> >> commented appropriately.
> > 
> > Yeah, good comments. It should not be limited to freeing page tables;
> > freeing page tables is just a real case that we can see in the vmalloc/
> > vfree paths. Theoretically, whenever a kernel page table update is done
> > and the CPU TLB needs to be flushed, the secondary TLB (i.e., the caches
> > on the IOMMU) should be flushed accordingly. It's assumed that this
> > happens in flush_tlb_kernel_range().
> 
> Could you elaborate on this a bit further?
> 
> I thought that the IOMMU was only ever doing "user" permission walks and
> never "supervisor". That's why we had the whole discussion about whether
> the IOMMU would stop if it saw an upper-level entry with _PAGE_USER clear.

Yes

> The reason this matters is that leaf kernel page table entries always
> have _PAGE_USER clear. That means an IOMMU doing "user" permission walks
> should never be able to do anything with them. Even if an IOTLB entry
> was created* for a _PAGE_USER=0 PTE, the "user" permission walk will
> stop when it finds that entry.

Yes, if the IOTLB caches a supervisor entry it doesn't matter since if
the cache hits the S/U check will still fail and it will never get
used. It is just wasting IOTLB cache space. No need to invalidate
IOTLB.
 
> Why does this matter? We flush the CPU TLB in a bunch of different ways,
> _especially_ when it's being done for kernel mappings. For example,
> __flush_tlb_all() is a non-ranged kernel flush which has a completely
> parallel implementation with flush_tlb_kernel_range(). Call sites that
> use _it_ are unaffected by the patch here.
> 
> Basically, if we're only worried about vmalloc/vfree freeing page
> tables, then this patch is OK. If the problem is bigger than that, then
> we need a more comprehensive patch.

I think we are worried about any place that frees page tables.

>  * I'm not sure if the IOMMU will even create an IOTLB entry for
>    a supervisor-permission mapping while doing a user-permission walk.

It doesn't matter if it does or doesn't, it doesn't change the
argument that we don't have to invalidate on PTEs being changed.

Jason

