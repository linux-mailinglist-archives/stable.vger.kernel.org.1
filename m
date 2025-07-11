Return-Path: <stable+bounces-161643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A738B01B3B
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 13:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCF7587CE0
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905329A9D2;
	Fri, 11 Jul 2025 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tu5swDox"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE343298997;
	Fri, 11 Jul 2025 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234888; cv=fail; b=tSAWg2upey/CkEuI1vqN+Owqpq5ZBjJDCCJaZbqiKkUihqkR+WJHnZf/qHuJbSQn315frfIba/O/caKwpmXKsSUQ/yEfdFOT0z6rEKihIPrXfGhk82laDqHYwVBtv3JeTuQyup+uBp8OJCONNGRtS7Za1bsjkG9yGDg6xl4D9h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234888; c=relaxed/simple;
	bh=iEgz9MoSwiteyzawsobpHuOuZRGEehlCmW8jvpf4Lao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MSGDry5+zKhLa5jtzzGeptoQopEMD9zuZNkVq5bwyFKDbFqRsrXNx8HzLFka/p65c4s9wLMmj/iDvnFBZgSRJilWDJ4ATEOZ36erHxiD8th8aBoSbZcLC73MG14g/kqXxo5m0V6cLfEzm3mHbNaW7Xv4xAk16my+Ojn8dMLVbkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tu5swDox; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYViCHcnfmZ3RJ4qF5UIxXHFCCfoL8obzj/qYiXMCr56hAdvXnGh0AD+/L3r/rETuFlpPhTd46AHcBj7Neow+7iCLUCHquZKZx9LiiolEtox+TWiizRv/k6D2VG7KR4rXSDFlL8mHJVVrgS8dw67Bns3cjAqHtT6HF66Px1fD51XJ0zEHhwN6eK34G1NHcLx+5JEkMntz31J4NatuRA4L1bVJZxIv5OqKBb8iDE3tdJb7OgFjZBSQKOaup2/GwXaxgBNjmFujZ5nFk+0FKaukxw/0flVMrfPmGOt+AKaNY+MsDW2tCcacfzjbBK7P3BwWTjoAvBoJMmz3uYIlRq/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwDCnJeUMkN5vlX1PupxfBFJCWYr9Ch9qtzG3z9EAsM=;
 b=JiYJDBeBlFuQhdvIvNqbG9gzO3Bj1QsPnc/rA4UBDEYHSAXYWJUKTplWCFhw6VNi9/sTrrQ0NhVUAZOhF931pqIusdGyo0xMNgi6TPqh6p2mmQkWRKK933S2e3czhBYrYgTHk7KVIohrGgug9/ox2CDi8DHW43QVWz43bJ8VkioHCIvyWaecr8Srh48H1XUcxySlKq8DUfYyEBqqUftmYoS+vHFjeJu1VwAl2dogQsiIhOoNbYpfMLbTIdfVY9QoY2Tg+ULtWqV9MMcVJ25bku1DfADYS4SWSh3QPZHLzzJf9dEk73Exs1e7kv7GUzkPymmfd6tSXzu+HycU8jbTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwDCnJeUMkN5vlX1PupxfBFJCWYr9Ch9qtzG3z9EAsM=;
 b=Tu5swDoxuTr9aLZ/pWelGDEvFuEQfLvvm7gFFYs+rziGbfzZH5OQnd+j7JMwUTUatqxe6y7sk0Xg3da/fC4lvVypiCE4HCEpr2a2C+VoBdjsQOZW+XCUwKWia144AcL6pyjI3ltgtIArbSJSq74bQdsAYAwmmwyWzu7Rkbu99yKtALGs0fTRnkO1t4mSqmZ4NEbmYYWRawRmISJA904Kul+C59Ij7DGyiBw9jcvhd36Lm2cKJZV6i3gwpCPy404VkgZJT9/pS1R0mCFRERS0Ur74FnNXJ1tZhOp/w2DtyDwfvlbqhYTIBMItj56Q5cIwzFgmL7uduAO9oQ01XIB1BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 11:54:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:54:42 +0000
Date: Fri, 11 Jul 2025 08:54:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>,
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
Message-ID: <20250711115441.GV1599700@nvidia.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0290.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de9a9f0-3f2e-4d83-9914-08ddc071b92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CBwxWiQ3F9HRiTkVGaJJEJQBKo4Z3tQEEGEWU4y2hswCcH1lLspJayzdfUpK?=
 =?us-ascii?Q?oLYFaD+MvoSWs431BzLgB42+rHufQzfenJfffUATAModzn4NWH1Exqwlo9Kj?=
 =?us-ascii?Q?GHn1uuKXfUrLFgBKYZtIwg6EQ0cZ+/crgOKjedFhu2khrn/Ykbc5dbraCCXc?=
 =?us-ascii?Q?vGZEmc2Zo49iUY7updfSLPReKprNLXyGoPUuj5AM5yUIz1oUxpeTZsFliNM/?=
 =?us-ascii?Q?/8WOcJr3b3xTKSGvUfwu2DPdhjIcc1NKTEKKQ5c2nlL7PoMHmvUqhDo7sAyH?=
 =?us-ascii?Q?vg7b6JEeu+kYw9ASv7lbe6VWg75xcszNN3jmnC9r8YWD3BJr0/xzWkt2T9J7?=
 =?us-ascii?Q?NA5Ap8eozaK1g3+tU9MaET1lsH+HGDZrAm2NjyHKckwbegTJIdlcZlXRpkYZ?=
 =?us-ascii?Q?nd+OeXMtYY4YnkeheHmHLnY5ffZV+pZabxJEzmXE3YhMmZ/4BZV/Qw6cinz4?=
 =?us-ascii?Q?a3NM3mid4glf5S/IflGsOv6yCSj5XSmdxfI+qMPsGAODG8v8hCCKE/shbjTW?=
 =?us-ascii?Q?uqO+C8qTtZANF2pUgPvlSXVYc7jcIxgVkBTpK3OaN7IZSamZGE/ZjXWh2LAb?=
 =?us-ascii?Q?ntCHyl/CtnIRT28I9e8KvcUVjffZwYzfFux1ihNrOS3m/K2ZGGGHyO6ZCY/v?=
 =?us-ascii?Q?nYYJu9ooyI23EmFsZHZ8ZhuZAWeax/txtfvxZG4wth4NM79k6wLJfdjNjhT1?=
 =?us-ascii?Q?OAf9PORUT72QNweVrqNUiBKStp15mmBuOhU64+zxpXM419Y6byXGsiiRU3Rn?=
 =?us-ascii?Q?cqNqVLlg02aOHP8VJkdmEr1v/hX+LRXg0y7PWTikCYKFfvB1uPdlVcCT60cJ?=
 =?us-ascii?Q?U98Fgn5q876M1m68meffsQh87uUQyVFp/We/JyRHcAQJv37740iWg6jZ2I/H?=
 =?us-ascii?Q?7PnTd7ccX2rMDbdPdopHE8zh78g8DBT9Be5NIO83fYcpM26KmWHaNYYXIVPA?=
 =?us-ascii?Q?EQvxq2lR+GDhdpUzLJ7iO2qSaSfcFf2YXIZrfK9+oNzX6NazPMHR6aTSm4KU?=
 =?us-ascii?Q?v++iEzltPk+0ERpUGNQesj1E28X5r8oDdF5JZiW0+FX86wIbFAjesKnIwS6X?=
 =?us-ascii?Q?BCYT1/IUG6PcbXawbnzhyFUjVbfmgwyXzhBAopyozRLaX1oeI+oVKeeuQ3km?=
 =?us-ascii?Q?tuK9ApppAYEL+n8oO2AvwVYO9OQomxzsSNYv8bsNkR+gWA7SvXV7JI6hiCGz?=
 =?us-ascii?Q?XXEQzXS4KNNEJhsvX5SFCr5PHPfKVKPCCrzHoXtaC/Sdm//dRodtFsph7du7?=
 =?us-ascii?Q?Wx1CsGQXKtOvKgDYBMc/6z376foy6SygGK4oNhAAjjv2khaYQPTVPuPtAZGE?=
 =?us-ascii?Q?8mqfYYsPTT6isVOpL+bAp2xgEq9q/12xi/qUEtJZ4Lp81DHRU9jog6GxSTvd?=
 =?us-ascii?Q?vE1TdpQE6YqomWA3xQRZdkWGua2QMEEGDhGkjkcZ1czSsqBU2qN5JqaRv0P9?=
 =?us-ascii?Q?u5F09Qq5WGo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0QAru6IR8u5MiOf9pmbi0eiDe1TSKaJ2gPCvGjrDRk0o880L4UTV9Z0M61gH?=
 =?us-ascii?Q?ICBoOI++/3Dr9DQ0nIXfWXNeu4x/S3XtMOVzIBo5cm7BGwD8eaG3yJs3D6Ly?=
 =?us-ascii?Q?LqnbNNUEHTv0ncLQLoDSZ689IqhIlkYzCTa42YXNAMlmhuD+NmNd8sfOT8vE?=
 =?us-ascii?Q?lodUzcYixhEJhDseunYP2Cvxy4DEk22iRy6RafkZUkfkTILKJ0iXRyyd+trF?=
 =?us-ascii?Q?57MozmbvZ3+vheu9PkJvMRKGdDGe4aQOy33oF1u20aW86tgwE5jHWbpzGwIm?=
 =?us-ascii?Q?07rh6URE81hUFVyxz9RzqY7CBzEmXs5hRCHgcxh379jCA+WXb3unnYTPZEax?=
 =?us-ascii?Q?mJlRgzO+2mgsrn7jLci7pSgFY6Z00fsmZZk/XgZBePoCZi1O1SvBzyi1bxsU?=
 =?us-ascii?Q?Md5nEXFCTaBGe1KWrIUX8OHvNhuaEaZofioaHGQL/f+Ns/qwaDxNtR2CKXcI?=
 =?us-ascii?Q?b8bH3kcDe1z4ffEmAtLT4iBog3VxYGSNMlEUZDh07Gr0JpCBr9NViFf6taho?=
 =?us-ascii?Q?5Qt50QkjNH7UsERf11tjcgNXihGuFl/tW9g9mqiJYuUDnL9d8BIPvNlJ2tMZ?=
 =?us-ascii?Q?0rqSB7a+DP4hMXl/X4ePvQsxcF9nBglCRVLk1p8G+3Tb7uQignFYJYZuhMSE?=
 =?us-ascii?Q?qEqhbfgPbxYSE71R8/FS5Ru89Xh0EdL+D1BZghDxhJjvWK5EIQuEnJTRK6b1?=
 =?us-ascii?Q?thMWSFTBJpU5DSMIrtZjPB4HKPgfPO3wzt8zjwhTUQVm3TEdhDMqiFcQCYsr?=
 =?us-ascii?Q?aLzdUIOdai6BlPSnOKMYtsm4N4nrMLcd4PhKck7NbeJeoOJvP0JlDuvYEfHy?=
 =?us-ascii?Q?OZgdf0aQd3vgeZ90Q3LUxREZ3UXhs7atHf9kgC4RM20bpRvUVuJ/TYSXvksz?=
 =?us-ascii?Q?IoyQd1b70dG/+FwTFellA8hZZlM+sw0bYwrGDH69LB64VZjyWZhNbh1W/LFz?=
 =?us-ascii?Q?2MCmzNDxzl+xzNwuh40/rHLZVok614U7sf99Q40aFXOcm74viHoXffd3V0aY?=
 =?us-ascii?Q?QLoWcBtOXMN+qTkKGOFXfYD6DEChFvD8UGByp/BYuTTnQyHXdO5RLcUGg3Zu?=
 =?us-ascii?Q?HJ00qABNDZCM0POrPrxn6DOdgYf5MA9POC7crENALiuvJNgIPWZsfUusK5ch?=
 =?us-ascii?Q?0HIftxN2cB4fOqiyXVa2xwHzVxvtewtmJw45l0UT2FdToE0f80zaMyCh0u4G?=
 =?us-ascii?Q?ZIlWZIH8GEV79JxlaaOAuAbL0UC+TNjb247OR0hXn0ahTs/m8eP+Marv8fKN?=
 =?us-ascii?Q?WnaHWd/NFgiZnB11FeANJJAwNkJXCh1NFgNCAr/fMYtehl9A/z4PIAdj7Pth?=
 =?us-ascii?Q?5taRswdCI7XQZzq7guYnOocXvobDLiXjC9thQhWPRS+Ud2JM3XK+b13ram4m?=
 =?us-ascii?Q?sEPx7yTdLmJ6yoZDsatbmCxVNCRM5ziwwCgL5hvy7clVEaCLjGXZaJ5Q0xvw?=
 =?us-ascii?Q?ujGn3rw0Cj8qPzbhZ0MLxITxZy+PkJUG4q9dTJdedvCtO+O05TteA0R+QNPH?=
 =?us-ascii?Q?nTj4p7lKg7LwwKTxJlPWnUUHiCwYkNldayuyvikddB8Fby4Zu3jOml7CqcMp?=
 =?us-ascii?Q?rhkbOYwNAV1BJmb3pAacfI/+tKyGDuJCVCMdTW/E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de9a9f0-3f2e-4d83-9914-08ddc071b92c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:54:42.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18Ugx65jLUunDiwH27Lpz0sPvAia56QEsArNWibBtDQJa9ED/HmDsJmnacFaBEOE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848

On Fri, Jul 11, 2025 at 11:00:06AM +0800, Baolu Lu wrote:
> > > +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> > > +{
> > > +	struct iommu_mm_data *iommu_mm;
> > > +
> > > +	if (!static_branch_unlikely(&iommu_sva_present))
> > > +		return;
> > > +
> > > +	guard(spinlock_irqsave)(&iommu_mms_lock);
> > > +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
> > > +		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
> > > +}
> > 
> > This is absolutely the wrong way to use static_branch. You want them in
> > inline functions guarding the function call, not inside the function
> > call.
> 
> I don't think a static branch is desirable here, as we have no idea how
> often the condition will switch in real-world scenarios. I will remove
> it in the next version if there are no objections.

The point of the static branch was to make the 99% normal case where
SVA has never been used have no-cost in the core MM. I think we should
keep that idea

Jason

