Return-Path: <stable+bounces-160484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD0AFCA67
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 14:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9584E562794
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B323C2DC353;
	Tue,  8 Jul 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SHqq25Ya"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B62DBF73;
	Tue,  8 Jul 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977687; cv=fail; b=uqVIMjECYZBYgduKWU+QV/n+Z/VTCctyb15+xbs1tPTtHwtFcnn25Ph5Cg09Ruw3GIqfLq7X7SmsIzhyOjyftBFcyJhbcGRZkGYvfMBucq2blZ7db6kkoTN12X1WaGhMPidR37rWotAVSmw/grRxSQmRJPUXESb8cymtItJ22Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977687; c=relaxed/simple;
	bh=wKhzi/AsEySU6B26WfmXjGAoyW2/z60G1mTOHEsb7TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GuZ5fV9wHUV9I5+Ov9SFmeTM9UCWkXhtQk1YRceJfMlOJX/6EOVSUV87ssyjN5HccIGcb13TnMy5n/ReYiktfyODAhQXEVT2BONBOQR6xPi750yBsuOekuPRN7xzJYzJXFAQ1zuXTaAPZq1fr6Zhz4b2ZAOoadVWwCxjZho+5BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SHqq25Ya; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ehanl7q9Gxau2gZtEx6eucKTd3JjOQuStiSeJzkOsZz4goU5VdI7QYCfAOZAc+h+3ScYPZb/DMOiCs8fVH+fjXFOiz5H5DxMmdVdXRbs7hD0T2+nHefnMWJird/Fq0Af0zGBNV6eeCu6i5/fJdk+lJNowrS6XzKSd1AFk8yjCzEzQ0BB759T8jax9Y4fPvWnKw1q0xXCyOxX3XzOlXNuK/8F/ycL5ZQUchJlMJcKSxZ6eV/b+dvYdXcRzUJMTiuA9siotPqIvNlbXLRpNOPoBzP19JeskiB6Ye0l8pyEJ3x++db7Wkxf9hyKHusx+JSpix17t2SLJ4w3R00c76rf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgkZwzaesbHJ1vpfAMHERYRFQrbI/OqTO3SMC0INFUA=;
 b=Bp+JrvPT4b2I7nFLZB9QX/5o+GIzn76goYnm2j7tp/EHHb+0wk/4JgFffwrY11kpFvYC7k9nEVfrIqy/5aTYbOC8LZZL8WrZUsAcqTOqjM3Pbm+hxS7/7esAWFH1E4/V17zxm2YPk+u6LxVMIUCD/ELx9IeRpS14COdzV+akTqDjZanrg9C0r4CCjJaebmQHOzWuxyt3iV4iUe4NgkF4V8aEMipYEKSPIUAgci/VFnPPtDuM9XAidqMFRv7fMiL8dkRUUafUUdpJyHnmnP8JSdoIkvhyqjz4DPGmVN/0r3WHjWXdGz9W4br6ydUXpP1R1lA7ajobEFAkGrhkdNdcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgkZwzaesbHJ1vpfAMHERYRFQrbI/OqTO3SMC0INFUA=;
 b=SHqq25Yamg9JUF0qF83EzoQ5M1XYf2Dr9c+B9F2dV/FTHG7a0Ie1J+K9fhzGL6eOSfZjYkU0Z2xa34k83HouxpA6kN3WiIdRx9I5yNhFu77szpLw5Tvyj0YxgjfqUP0rAki8Zyd1omxs4ItdyTMEOr3uBF/q6l2C+zxPnZKtR0AJd43xrijwwrFxAQHJXF0PjeEHeKF+1cEtItvaNx9SwiIqSpnM+1Q0LfwIEZVO5XIOrJ1D9FqHO+xweuVUAiBbmXPLH3YHbEYV/AcYA6qC1zikFdgc6bPjdXy4YtkH68KXgalKLw0PTe/ofHHtUVPLzsu0yPess73BmCBFUf2YxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH8PR12MB9837.namprd12.prod.outlook.com (2603:10b6:610:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 12:28:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:27:56 +0000
Date: Tue, 8 Jul 2025 09:27:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250708122755.GV1410929@nvidia.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <0c6f6b3e-d68d-4deb-963e-6074944afff7@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6f6b3e-d68d-4deb-963e-6074944afff7@linux.intel.com>
X-ClientProxiedBy: MN0P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cbde5e-735c-44f6-a78c-08ddbe1ade48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fNElIlKQD8FKpZRiIXNuuxFcP7ND7q2kMfe0SK4E1uaw6tYlYP6USMBo1Czk?=
 =?us-ascii?Q?b+Q7DFxCZ48Sj2xwI7EriCTUqjOjth/nNstFpVZt3wtmiRWdbHPcwLhWrMUP?=
 =?us-ascii?Q?UeaZUJskHF0Ba2wZkAujP3jFJGGTXSHwA3YUkZhNrPQcKFI8RFiyJrfdXEcJ?=
 =?us-ascii?Q?ukd/mmPsoxX/kRhkDejPKO1epWHoqaL1n02WnpdBfrm/bdrqjhtSx3R0EX2h?=
 =?us-ascii?Q?H+mKI3RSpszxr+T5hUvGyPuTAfaROavDSINzPbXhT1MKI+GkjjJXYUUK3ocp?=
 =?us-ascii?Q?yuTYQ457WGzqBkJY9hPrssncpkZdsf/veHSRDDz8PD4fpwixVLk/TciNyMi7?=
 =?us-ascii?Q?dRtrQeJHGz17Z8N4yylq16mpGZo2Yzso0jL3uMMqoKZJx0XOi8BcpZNfvGr4?=
 =?us-ascii?Q?Tf+rncimZo+JC4/fYvkFCUsByTYiFUPkYuILWfqiuOt/wyJdsWFG1dTzHMoh?=
 =?us-ascii?Q?CKKTrvnU0ANnRqT0MyhQVy3PUpML/XT/H2xOqBBk/T0px6oVWSdJ0pZCY0sD?=
 =?us-ascii?Q?djzjgS1JPRdsx9d0pzLSvKOsW9LFwSfWD2xrwh8ce1oGx8NAKfzk+/FxAMco?=
 =?us-ascii?Q?LL/W+1kjDuZdCq1eHUK60iY/hlmhFY7X3pMxjRwBxK0YgutfBuEg6+pUJFzU?=
 =?us-ascii?Q?ZJij3sSz2TDg8RllZxtSPok+blWcuB50lfPTmDNrdfhpGEYf8K1EiKDaLUqO?=
 =?us-ascii?Q?VG88Nnj9/V1nbjTMRDNE3je2ERLcDR/ogoOXJkH49cxApiEAXu9j1gxYCt6b?=
 =?us-ascii?Q?JyB5Q9c6nQ04joHYTsqrtQhK44QpNL/pZCyJzBNdQhlTi+eG2bb2bOOJhpV2?=
 =?us-ascii?Q?KW3bS1sFeZh5J2B5g/IaFrJnbzckNt3e9Cad3n84r94JykQ5UF0Ef+/UHINV?=
 =?us-ascii?Q?OKpv3l76eQUhyfcOEvycwIMOpMDxPdlQHDY6Tg9+HiMHxR648+sGY8cCbBu9?=
 =?us-ascii?Q?81VZos7ZeJdG1wp1sSVh6hf5LWPvU+JufY4bBAaW9MFRTLMeByycmR8QUCE5?=
 =?us-ascii?Q?PntWN1sYftJZnLFou61Xgpj0sN23ITl0dREVp9CkW0HytzANf3MNFC8jPOAk?=
 =?us-ascii?Q?gCK5zrDQM23s4B1U3tPV0+sgJHeDIEp11H2U9/M4KJoUVRA0Nx3mn0easaaZ?=
 =?us-ascii?Q?sknWqE3Zn2Xha1tFT+lerfX+8XPDXUdByRBd5uSVDeROCLOxzGFkvPSCVSa0?=
 =?us-ascii?Q?jL9lGiaC9xSoAWon7yQMW8YVvby9JS1Xt2RFp7GKOy7EVeGunuHtIM0wHlpi?=
 =?us-ascii?Q?GxUoKWARbGEQOtIONQWFuhe36AKiEGBCyZWz+3AtjQqaNFJ+N7rnuAXgLYHF?=
 =?us-ascii?Q?VYC8HQcu0DjZtL/vATqLhveqkmjGnYN5bUSM9uVMSrh9/k0gdxHTguZBy72T?=
 =?us-ascii?Q?KjIy5OKwYreOIAKxWzbF8E3l1AZDbgyqw6aoQdHcWeCRYRO2rZBwx4PK/KWr?=
 =?us-ascii?Q?KSJ/ElJIbjI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oi9oU0ujWDDtzLHfxm6j4bfCvZwcviamJjTibwGi14DngyTxU1sEgU4iIxIe?=
 =?us-ascii?Q?6m1yUtH4U+LRxt3Qct/lUKqiLHLEhYi2KdISJRsQvIq/8FhOew4/cA0sEdB/?=
 =?us-ascii?Q?C8pRdd4Mihke5ngqxZyHSNhm1ohjRmSotoaYnIMn7tFBeDb+46wIuHgncydy?=
 =?us-ascii?Q?Qqm8kvvXzkP6ACHN68z+r9M69J1C3xI8WofOqbw/vIooAoKNAOzTUS7ToS9F?=
 =?us-ascii?Q?3Fli/BVGpJFgfAeKHchAPz/rkIhszpIvw2FEaPjJjfyGpiWHXRQc842J3kCo?=
 =?us-ascii?Q?uPn4CxhmUnGDegbZ/yz3HJK/WELrYvTPiphOX8ymXYG8nimFgKg0gGwxw5BX?=
 =?us-ascii?Q?nEf35M4nj1cbGYP+fzA6oHA6eynkOK9pp+XP2CxGCGdSBr9m/0JAW9epAnnZ?=
 =?us-ascii?Q?KuoOhO1vmlcSiZ06fyKn3QRK60nZYCT3iuflm4pbNw6W+XBM/Y50TRFg9O2S?=
 =?us-ascii?Q?lICULKh1WCXfAD0Ki9kyh0hrsKuS28meSPpZIt7puDRoIQv68cPegS0hm62b?=
 =?us-ascii?Q?nOMgwpFsCp/6I0q9M/9fHMnfY1xS+A3Jqn58zgVHdwohFYgAPkgvKzS/MZzF?=
 =?us-ascii?Q?UB01czOUr5De+u5rCo0cvgug0XvhgL4JzrgtXDJheWceunx8zkhfwlIvwdR0?=
 =?us-ascii?Q?jWaLbG4kTz0PChpke+XXbKk0MpWUpclQ829kX++EPn9i4nOwUxjzhQgYiBQP?=
 =?us-ascii?Q?vZvfC4jIRrpSSyrVirWUufzwmM+NvzbughS+j9TMsPCjw4lol1HCUJ5hjrXY?=
 =?us-ascii?Q?Jf+1QsbODyhsjevDdM5h2rRGX3smkeGaGr9H+zpxNwPBtrEtwBmOMJjV4MYr?=
 =?us-ascii?Q?6YMcWlVisKjmkb4CPfKUmIV23WzLMU63aHf7Ob4eCKN5yZsqbevxVfaeDeHW?=
 =?us-ascii?Q?C34ybb7HJSNyTpCsXdXMJP0KuIGmLjKcxLNQ+VZGMKY7Ng5SPIa0Wjladj3g?=
 =?us-ascii?Q?WiqPSBNf1ZMmAuzsIzZGRpZQv0YglkMzYWHmNKL1sHzG5jkDERQq92YRxVl6?=
 =?us-ascii?Q?3/Q6/G0x8fK6tJHQWZlYBEL0NigPJKeLAwg735F/fe4AVtZzKFgr2kRaC84H?=
 =?us-ascii?Q?V38VIp/viCT+y6I/4RAWrkVdTpSnrcPVtGS1nDxEanXVCcsGvvPw0WEQ4EiO?=
 =?us-ascii?Q?PzfMWkP/2qpVjMg2MwpNxnurkW/CTmLrEEcTZ2656gLoexnID39EM8E0bfqY?=
 =?us-ascii?Q?/EPqbK5LmvItRm0D8jAHT8McGKSdIGz2P3u40LLmT/WUoSPIa02mZM1PumBe?=
 =?us-ascii?Q?xcTZ0XxSrFhrheqwD1J1oYz2WFoHG3gGWC3U+clYLgcTPgfGwso+N1SaVOPd?=
 =?us-ascii?Q?ke3qRtnIdKX5OE9z1x1oCUu7dD94YidpOLdK7wZGIaA4C8K75no5ksvFEStg?=
 =?us-ascii?Q?cd6nIUUR8yQpLK0N49HK1pnWo6HAJhEUNy98J6dSCjIMu1x01/6GfdRQz0qm?=
 =?us-ascii?Q?dgA3u7xZfHsMW3PXxOZs2UX6em9WqqJfRMWJf/npJulV16NrUBgTapgWzuGr?=
 =?us-ascii?Q?o5bm+od4qc94aEnC5+wWWJVC6TyzeFD8tKh5tuUziInIHqbw+DaPfA7hajQS?=
 =?us-ascii?Q?zCGYKUnnlEy2bI2aMcg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cbde5e-735c-44f6-a78c-08ddbe1ade48
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:27:56.6783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqmtdrVj2ELzxDZvPm6svb5fXXzTGcMgglnBUt1nL7ayEyJq03qmnIyj0tdZSj52
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837

On Tue, Jul 08, 2025 at 01:42:53PM +0800, Baolu Lu wrote:
> > +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
> > +{
> > +	struct iommu_mm_data *iommu_mm;
> > +
> > +	might_sleep();
> 
> Yi Lai <yi1.lai@intel.com> reported an issue here. This interface could
> potentially be called in a non-sleepable context.

Oh thats really bad, the notifiers inside the iommu driver are not
required to be called in a sleepable context either and I don't really
want to change that requirement.

Can you do something about how the notifier is called to not be inside
an atomic context?

Maybe we can push the kernel page table pages onto a list and free
them from a work queue kind of like what the normal mm does?

Back to the shadowing idea?

Jason

