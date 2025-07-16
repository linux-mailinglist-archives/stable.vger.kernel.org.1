Return-Path: <stable+bounces-163135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B70B07550
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C17B48EF
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85882F431F;
	Wed, 16 Jul 2025 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JuNE0DIj"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F8291C09;
	Wed, 16 Jul 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667703; cv=fail; b=f7p+5Xw3XFasSSCFMuqJOPeM2E9Y4N6CaUG4AfpT+rLsSSAhZ2+sz6+aykz+Lj4oFmFdMg2C18gjBdNhTevqwfWmjieN539BTxcXYyLEaPrVr/tETMMEPftmJVhJybISVDScKSmZKiG5HClhtbieZIgMxWa7eTPclyuXBl+Mw6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667703; c=relaxed/simple;
	bh=BuWguJW8DOrClIn7TpcN2JNym7RzMHzRpp9vtfH8jqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QjqMAy1PG0nj05x5RpFzwe4dTthxHrPlJzG0nHFqlclxvPHWs7rJliwr5KUipyi2hW8tDszza2fVpFAZcmeTOx/kv64KJxcxQlZ2ihl9eIgQRhCXAXtoZy5wm4Q5VWst/fwmegqmbjw7blRcM/C36iqY0c+I/g/Ezd2OIRGFz9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JuNE0DIj; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgQxihreivVvr5m0+Zx3a0q4QrS+HAziq/Y7ASpFoL6RW1fTeyzkiHGIQtpLt9bZsxRpjiQf4UKIK6gHDjxGyutOwpL0tQSDvlJSwy5nyU7XPrahS35z4wfeUkz5cRg60ChbG9jBcdp/qpyab48hXEziPQigwlGLLq57mq3K2ST+CVrHvC2WrYKBuKUnkMQtTHIyJWvERECb+zirD8JVb1vgiTTm8tCKG4thhd0taW7l0hQB5hIRi3GSWErW31YPV1KUoQLNPv8vP/VYMN1rXFGGRUSv2D1xS0CGNzihDPnWVkTvKt8KKWNA1CelySyLxlfxz9JtiTDCh93DBEdxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6J54FxAs8WByMZEqLZFisu5/DLINAOmR9s1ZXSFCeI=;
 b=oT9N0118Ur51z4Y+a1VjIRNeD1779OUMtYjtXV7Jl4D5TKIVPmidHkI/mjbB5MmNbQ8dq28VP/JAJvc81Mfd44YlKwzjnpKZuRNs2N1r3ZOFDGfhIEIKx+MilySUadIP4El8/ND6lWLzUaEcGCoaRgeP9uhObHRXvdPmpzkp5wsEPugYSucNGOiILmADwRh1xVYA20FS/c4ZIcRwa7rfFqSYsVjtt8J7vO9ayCQqCp4x9mVwwQekLsbVYWFd1k4Y2rKfVSl1lzfW5PQPT2bfQS97uhAf6GKv2ByPgE/9yuKUNVtbhsutiFcqtmIb8Ps7iR1xi2ptfcuytGKZ5g61sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6J54FxAs8WByMZEqLZFisu5/DLINAOmR9s1ZXSFCeI=;
 b=JuNE0DIj91a2PD8nNQRZWirYG4DzyLBv52FtDJukeaYS5LuZTfekzYtMBlvkWnqup5mnwj9uaDA4lGhtfRhB0YNsBayqn8X73FpGMK28ykjrimQYNNCM8g5XAKlwv3sA4nSE8Pj+JLCzIDNCy2WQZLZySUQDMPdM/D0cf+QWrw7SB64Bw70ObG5KW7utSDsU8u/q10cF0X3kbYh5XoSknccYWvA/6Vxkc1ovMHQJblBYqXhk8stV3DU3IAp+j5lwDouC4cEoqAXu4BVAO1idAqEsUCkCH9cDBYoYtM2B5otnu6wkJhdrj3BMESnjlqiI1SXy0o9ca82WdiNfEAHcqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 12:08:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 12:08:18 +0000
Date: Wed, 16 Jul 2025 09:08:17 -0300
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
Message-ID: <20250716120817.GY2067380@nvidia.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
 <20250711083252.GE1099709@noisy.programming.kicks-ass.net>
 <e049c100-2e54-4fd7-aadd-c181f9626f14@linux.intel.com>
 <20250715122504.GK2067380@nvidia.com>
 <f58a6825-e53a-4751-97cc-0891052936f1@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f58a6825-e53a-4751-97cc-0891052936f1@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:23a::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f44d9a-0898-480a-b1f2-08ddc4617347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aRo6LflCGD+nM9cqPGNc+gPmWUexLgxyFgA6Pufot6KUYYRErrPemuOlTe6d?=
 =?us-ascii?Q?utkJCnrDd0g8HmT2siMI03jjwcWIdm8bTMGOBdS3DEbJdBkEvaILiwHRjVzI?=
 =?us-ascii?Q?IByBnaZODQ9Umj/FeT9RKQlGccop3NMZau/E/+Esfbvo7FiFu0lxOF4Fzu2y?=
 =?us-ascii?Q?0iNs7KAD5KWL//lZilyJ5yAWePmrbTDeya4t74agnFAHht3PghlmpwEXtcEz?=
 =?us-ascii?Q?pGKEpwzWCSoDVEx2DZTPK0kkBWGh12YO7q0YWh5gfpquyBcxo8khO3jc4Bld?=
 =?us-ascii?Q?/T5QzJdHbnzJ/Ix8WTbkT14M1cKnzifGR9nad38qrIEG4P7vX2P+VOYmLVLw?=
 =?us-ascii?Q?3mZVHuXRnGZ2w/taQgv+CWGgdgfAZ1i0KYRaYcc5BTKouWHz9f8BnS6ah662?=
 =?us-ascii?Q?iOhFYLS9YldGa2FXa7k+V/V0cF1iDTxopc1jHpTx5vfRZMhBpUe/ua8SpNlH?=
 =?us-ascii?Q?+k3wwVoI0izXUPqZ8Ehm2ZbpJDQGADBnueMeYnj1v4FcNQ1zVBiihGJyCcrd?=
 =?us-ascii?Q?LIOpU3HvhVq2BALCNdot+t5Wo69zlgyWsP3v8bmMpaOg2qkqXicxLTr7ZDDJ?=
 =?us-ascii?Q?zgLLYW3m8F6rR4eqz1/6CTdEDZDDUeIcgkZFFvkrNrm1TQAwEd5pIN20nQA7?=
 =?us-ascii?Q?87j3sXl+abDdy70zw3yLHXAHu6urRGB7jIb797SBMKZA8rRspzI0F17pDqvW?=
 =?us-ascii?Q?p+wVH5rQ6gfkxunyCO7JkZbkG6rzqHuotl1IPWHdldVH77fHtqxni2Gf9/Tj?=
 =?us-ascii?Q?/ALK6wxPuovAvQqgYlGPoLiKOTeCdNXP8IO5KPPMzkjbZzzLqCGTR3QX9d6O?=
 =?us-ascii?Q?Z6o10ebziOsalVt6UZ9DPUJ0KJpaDoJnwUZCLzgye0v1UhVZkETGg2kD//iR?=
 =?us-ascii?Q?OWIhgRWVCX5YffOTcWw4OnP46Z4EmmN9AvUJM0Sijp14jtDFz0l2GHOEgrVN?=
 =?us-ascii?Q?Iozd+c9fpFMmVCLIrXY51e2yOKTQueuR6xzwJ0tLST5+Ly8B11yNcCtd0tAw?=
 =?us-ascii?Q?VyCzGAeFA0YTnOKZq201DplgnXIjdWCvo1oi9AIpzqHe4679loaW5yAEB6rT?=
 =?us-ascii?Q?o0PwQ+//C4crlGoBUMWYPDj8AOjCIvns4a48DXXMKu0KFghiEeanRjh4ODKs?=
 =?us-ascii?Q?9MrrGcSDN3cr6Yv6+zY6XD3ioP32KqM+V949yFNHnBBMUo8EKkR4KUQ530zV?=
 =?us-ascii?Q?YqOx6ocFiWcBOqqgX1xgtmXvY9Hczufj5sxWyqI71pZOBtQ9jTzblFTUZ2oQ?=
 =?us-ascii?Q?LOuBiNLCmwKTdRqj24zELNFTmDXKO+R/zu5s3zJ//vXbFmD1TWHZd3U2bLnY?=
 =?us-ascii?Q?LSH8EQOJD4EEVXH0Xe8/D+AN6o1zICnqMzv9LGom1o2LutYkk4zgNgPFDPWT?=
 =?us-ascii?Q?OOd3VLuulOPKSJ55iWwZJz8r7QZNC1UkI2oDVVuS3E9oPIhg+EsIblCrcON3?=
 =?us-ascii?Q?pl4Fd6SEMU0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rJUC+zKHxPns3IoSrMt+oNUAKIo3FUnX4Wkd5W2pz3N/eZn5nu416LzhtZIK?=
 =?us-ascii?Q?n5SODPHJALRgMEACfKZE1FBAGdyUOReLA3Masz2aJgMzvn0+2Hou/2N5v9lf?=
 =?us-ascii?Q?2ot1Jk9yCrSJ+obms/uZ8oPR50p9kTpa9DoYG2IBYrFOQxHk044yRXO6UTpL?=
 =?us-ascii?Q?/zyfwLzawZoZp/+EwHdg+btL7TUVg66Vaz32bunQ6FHI9wYLCjhTdp7d6Uib?=
 =?us-ascii?Q?IEXClLtkgTRQA/OMxdNy9Lfd4eysy/xYLnJOoHFiXfW7suUxksnDn6zFTQrO?=
 =?us-ascii?Q?IQOyYex7SLwbVB6hKKPGkvXlTQalU3HVtSgCVr75cqR5P3GdtJscNYZaOZwU?=
 =?us-ascii?Q?REmWpg2bb9W6PwWIxpageuRNkfBdp0CJ0bdT21EQh0dPAyMVmjmMTPXjru4I?=
 =?us-ascii?Q?vXPcFgsfQi5xcfz4fmXPupyiL1gppijFKzr6r7AnPyTSEdx/BlG5WTVQCIdp?=
 =?us-ascii?Q?aXoZjJyUySgX1oUvmQqtqWQiRDJPsdJeX6o1l2Fjy4prNmk2VZtqYWXYccN6?=
 =?us-ascii?Q?CWeo7A0zG7VE9qpyjrf5EvFP/SupQKvejtiOZamhO7iDzh1rgCnSXkheZvlS?=
 =?us-ascii?Q?I0ixqJuTecRzZyvGbUqxixAj6taMtFo5/EG4OGdo2/VTIPPQxvzqFQTF2IIc?=
 =?us-ascii?Q?HkPxm/bRz0B4x2QEC1EwhO52cWHLl939LPfhkOSL9Q6KCBK0Sh0FyJgthkC1?=
 =?us-ascii?Q?4SZm+36WUXCvOWO4D3MuIdsT5WAjotHJsIV8v3AUgbvOqxLDH3rNVyEPigs6?=
 =?us-ascii?Q?lpn1Vo2l4YkGVqBWvmfUeJr9Be009yli+Jf0DWnWJdb3zR7vgdeoe35aYyFG?=
 =?us-ascii?Q?CVehCM4eQtl611GLU8s6sofDRg0V0HGZu1QVmvyMYkOHgprMiSLqPA5tSvgk?=
 =?us-ascii?Q?sH0eOItTAli96/Sy7yQU1s5UhG35rjC6E9XbRXtyuL5X/nm2JcFE53UtK0yv?=
 =?us-ascii?Q?BVB2485ua8y4bfgNNhtw+Rl/A5pnWOwjlHvpmHpDyAzyfNIKDSGGSmrgjNqi?=
 =?us-ascii?Q?gsIkx942kacGLaYp0w/d+VzA9MkmahNFkXMmLWvqDQ4665lerQ8bafUHXbXg?=
 =?us-ascii?Q?kGTyIv/UA2CkkiQpEbX6P/y2OjZEryy/cdyNRI1zIXzqwe3fLdko2VSwADzN?=
 =?us-ascii?Q?THXFOPnIg7oWVIECvih7GYmqEsyu3ksIvxJPGELo/CXUC2VNBcssdEuETRn2?=
 =?us-ascii?Q?oSGt9gxEptqqxXQxl3CDx/8htv8yPgt23hbuIU4CJpj0+CetIMeYJKJKx+Ac?=
 =?us-ascii?Q?bjcgutg6YMy/6zt8b6Z3wXxo9gWaztI75ZdVzVIdbep6I4msEJ1PwlLmv0It?=
 =?us-ascii?Q?nGEAVHVU91c6jSHSmy3U4FThT22Zv0bhFNFiVz5Dz8N1t1K2C3EPft5WikOC?=
 =?us-ascii?Q?QYkm+2s6YXaH/GNGpUf8cmolgCu1c9qbQLic6fp7FaFjW4oVFoKSpVbaBpyk?=
 =?us-ascii?Q?zfM6+HcPPKMx4ye2QEcIw/swojT6s3Hw1r9ma1ZFvqUMBobsbkMzpOjuoUhR?=
 =?us-ascii?Q?R/Z+vv3KQ7p2onaTOo+u0tmkdhwEyIToKpAz1x3GMpgC8R3hIBlObkM2D+jH?=
 =?us-ascii?Q?v9CwCIUhuD1T/t1zpI3gzrmNg5Zi7HnHgaXYdDfg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f44d9a-0898-480a-b1f2-08ddc4617347
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 12:08:18.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRLzmApmAUTkC0Gn7646rMCMby9cnjNC8T1bZC84JJWc0XLsdPTTuDqJBoWd22d2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981

On Wed, Jul 16, 2025 at 02:34:04PM +0800, Baolu Lu wrote:
> > > @@ -654,6 +656,9 @@ struct iommu_ops {
> > > 
> > >   	int (*def_domain_type)(struct device *dev);
> > > 
> > > +	void (*paging_cache_invalidate)(struct iommu_device *dev,
> > > +					unsigned long start, unsigned long end);
> > 
> > How would you even implement this in a driver?
> > 
> > You either flush the whole iommu, in which case who needs a rage, or
> > the driver has to iterate over the PASID list, in which case it
> > doesn't really improve the situation.
> 
> The Intel iommu driver supports flushing all SVA PASIDs with a single
> request in the invalidation queue.

How? All PASID !=0 ? The HW has no notion about a SVA PASID vs no-SVA
else. This is just flushing almost everything.

> > If this is a concern I think the better answer is to do a defered free
> > like the mm can sometimes do where we thread the page tables onto a
> > linked list, flush the CPU cache and push it all into a work which
> > will do the iommu flush before actually freeing the memory.
> 
> Is it a workable solution to use schedule_work() to queue the KVA cache
> invalidation as a work item in the system workqueue? By doing so, we
> wouldn't need the spinlock to protect the list anymore.

Maybe.

MM is also more careful to pull the invalidation out some of the
locks, I don't know what the KVA side is like..

Jason

