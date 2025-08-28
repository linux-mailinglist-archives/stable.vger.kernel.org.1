Return-Path: <stable+bounces-176664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A1B3AAA9
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 21:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FABE7B30D1
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB54335BC9;
	Thu, 28 Aug 2025 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MMpMIkyc"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BBA335BCE;
	Thu, 28 Aug 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408270; cv=fail; b=STdsQsvjWm50cn0nrzXkQGrpOxFPPGoWiNqYSnN+ZlzRdbS6y3yjJzDsKtdSOzWS7JKXQ4rCIeHRLZXH+mQTEWfrqqnKgobDo/rFPv3msle6qem3xO3+QabdR54lv7wl+ygVLpHM+K+nQmGWxUwKblqmTi2aHndkpToIB0BxYmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408270; c=relaxed/simple;
	bh=aOpqfFCjBMoHyCMckG4TrDDcPz5oPRoa0KOIAfVkrJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YrXg4v7rXXOSQj+gqVfY03spXc2TcXmpsozyCpJ20ZLO+/y3yFJ9k9NO0IEO5+pxppHUrV4YFDRPLUabTBKZGFBaEr/+iLdsB1sKMFhfbcbXFjV/HavvudLnf0QRKKY3qScD5mX4CXx2eEgR/ogTSqLuuwQ/8mwILUyzUsT1ZpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MMpMIkyc; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jENCAw1WR62meMBlJU3PI6Rf5k/767n+DSzCORiuV7GHpsnqWkS0+c1hfem0ikRy6nyqYovR/VwqFhytIA2iO5az+VDsCT6MMf9QIagRRy6KP9H7Hh+tLdF4yDYMZ14QlB5FAe0OHfiBxU83Jep+JqcQ2MN//B5JyL1qanLy4fCZQgfJ/yZRmDSSrab0XyzL0rVO5iImwaIxDWamtp2SyHkcr7iE/svEbsYtwj1Mq57HMCxvJB3eXRsB5lTlKodH0QwNZ8NzU6wv9ZuKUdVM8K4jd8aPMsAM9/kJ8XS4JQm+R9bCcq0j0Ni1PsTk3bLGMg3NOKME36D0fTnHMapFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj5GuEBD05uci9E4sBj27kGzqBC7FPs2tYuHUdQAQzY=;
 b=eWNTpPE9SOo2O/yYEVrpfPyG9TK90ZwpoRtyv+eQu7xmU1r9gdTKuRt9NCmPGtuomqcQpEbqVx7f1HrujP8wLuYuke1PEW+b4cgCK6SjXqPQE8DvT5m463F5AQaoCc2XozSIhMeZ2z/8zJuIkuvhXlzsZoZmIIVmxQZ+j+/fbXJ6jvscMX5BlAfyYM7EplLb/7ISZ3czyxTkha79Rx/ytQVIfwNQYULK7bY+gTKnGysOpi/UrqV5frIfTho2pkCgBKFo8a9DP+jU/LSGAZMxbve+ku/ezSiSgynXsYdkifvUiRAnHJjYXOQZVd+yFIpF6XHYmJfzpIdstg32gLM+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj5GuEBD05uci9E4sBj27kGzqBC7FPs2tYuHUdQAQzY=;
 b=MMpMIkycVbWdlfCKeNUQ8wNmHDU1v6eHuMVGZdXSiPM0qcCg42aWPTB0Py4X2/vYc/xeDo0ccO9Zhq9T5IbWgejXR46SMGsvup0PYWDczFkWP/SvXTj9P0hrT1vl190PR02mt4kLAnq2YRR6Tc0zgH83Hm3ZX0FygBKvNSWR9vePROu1V5B0Um3j5BwVxRCjA5z2t6CQuhE3Ck4ZEMDUJ0i4uoQ4ayQ+oPx4Jh3jolBdjZ6yOarVcjAedHIrBvOxZQGtzFgbvRwrSVOp+UdQGzV+1T1GA//9xu8/ywZYYtdhNJwcffG46M8Xe4Xlo9QT2scbYtTgUW195dNqaIW5dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 19:10:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 19:10:59 +0000
Date: Thu, 28 Aug 2025 16:10:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"security@kernel.org" <security@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"vishal.moola@gmail.com" <vishal.moola@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250828191057.GG7333@nvidia.com>
References: <e321d374-38a7-4f60-b991-58458a2761b9@linux.intel.com>
 <9a649ff4-55fe-478a-bfd7-f3287534499a@intel.com>
 <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
 <dde6d861-daa3-49ed-ad4f-ff9dcaf1f2b8@linux.intel.com>
 <b57d7b97-8110-47c5-9c7a-516b7b535ce9@intel.com>
 <c69950ee-660b-4f51-9277-522470d0ce5d@linux.intel.com>
 <400cf9ab-de3f-4e8a-ab0a-4ac68c534bb8@intel.com>
 <ee44764b-b9fe-431d-8b84-08fce6b5df75@linux.intel.com>
 <BN9PR11MB5276FCF7D5182D711E135BB78C3BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d88f4f9f-6112-431c-948e-5f48181972aa@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d88f4f9f-6112-431c-948e-5f48181972aa@intel.com>
X-ClientProxiedBy: YT4P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 9612a1e5-325e-4983-4b6b-08dde6669f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8NQ2aOa2VcAsWC6Bkw/desU8JcLPcZ8YnS4L/d5bgoo7F4pMM/83/ZwCXaJ0?=
 =?us-ascii?Q?a5AJt4xtUs38xGqCidC9nD/6FSsmLJAMysDXeRKFPEIM3nsl84tBsvZsX1Tz?=
 =?us-ascii?Q?5JO+rsEaAGw5XmRAWUmnoi2UBVsFCDN4WM2pvgJu7UvkCrx12lv4XksqZCUD?=
 =?us-ascii?Q?qgyDBRSAbXFD7UaGQ8rJpePjyNEmBQsYx6XjZWqDvpBl0r8mFDVSsIc/f4Qs?=
 =?us-ascii?Q?pnWnUcvLscUdIiTWPWuQZ3CXLOtOaSELeZZX5dCtXDBgLQDIlxtbnTQUlo4g?=
 =?us-ascii?Q?9I0SyKqko1BzOqwMqAXZskp16yB1AtNjsoDKRTsXGER38ISXOs0EXCRIzWuU?=
 =?us-ascii?Q?v9CztMgBDE+NDoWlbh16U6Du+Ez+M7T/JDAfpohiySrKrw4ClS2Ly2pd0LLS?=
 =?us-ascii?Q?iCDlKFHUP9Zucvs6HZLvhF8jdJa8sKETkidJNpO3SkGKGaDxe7jEK+b1+WY+?=
 =?us-ascii?Q?Gc5k6ES4Mv3582N0n9hI+795o4v2/gGoVxVxBycD1iOqPGOyPrQIC+pyPOOe?=
 =?us-ascii?Q?8uyJN7tD+Sn33etbfF1DMO5TxRheIqUCg9SjTs2KEVIOGy0LNg5S/HM0VvD4?=
 =?us-ascii?Q?I5o781EbC1VChbjLdk3OHRl96o1Op1uAJp5s/pRSkE5svFnP2+oMOZc6KrBW?=
 =?us-ascii?Q?TFCPybh1Ubs1Cg6yfGpbzqylIZN+GPo2IwQmlG2Lt6L+37vTEu5eAQklaG8p?=
 =?us-ascii?Q?UBnY4ji/yag+qtCV+jIRy8m24jcpPU3Bv00rSpwkIaUS5l0b3vzz5GlHPAcZ?=
 =?us-ascii?Q?2FqsvRvZXcqF4SeV/HoXH3P0wQ8MEci+CHTfkCtJQtvhvexupLVwvgcbLebe?=
 =?us-ascii?Q?AdVVQ6h+z8+6YymrfJldLNdT9V21rn3rY29JwpL9giUkKEL+MIE6PD5n817f?=
 =?us-ascii?Q?mFcEqWO5yJUZkPwTTkw7OVd2JROyqBWk5d79zqUIp+jbtAjVCtiKEW6T1API?=
 =?us-ascii?Q?OvSp817lmREBmLSKJ/CBsby1FYZx2yGu+e7Rlc7fijjvlMQr5kIz7MT2oSWp?=
 =?us-ascii?Q?m8lkicgiK8lOvCSHpLSPLqOm4BsJzPcZJ8JELf4hLzZaLwieaPfXmzxjBxPP?=
 =?us-ascii?Q?cUWUQmypVNGgxfFoOp2tONOsileq+/vYCDrGGdQPtCXSP+nwj+nQrqohVYkp?=
 =?us-ascii?Q?n91zEroZhVMbR2a/BBsvCk8kr4OslK23/3grTU8TTdGiRozT5preZ0gSlbkA?=
 =?us-ascii?Q?6FQ4Xlpr8BOce+6EPA+5xn2qQ8aTIZajMfo2/zLQl/uJ2bCP1GB6xzA1XmZn?=
 =?us-ascii?Q?/7RPeZdJ9abRl3s7oMqxzJwaCPeZaYcoMWONb2QnieRVVhdQLpZY0mNM8AhN?=
 =?us-ascii?Q?VJzFfXnjyodH8KlgRW458hpa+fsdJF3owOgGO1wa2pGTKSF4V7PRPt7sIfX+?=
 =?us-ascii?Q?3i+A9Sxu+GFnRX80pRkY+rd2ep2IcCKJ3jN+VpDbAvF/nSMfc9wVyRdlvkJg?=
 =?us-ascii?Q?LrkOx5og36E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iveo0k/lwb+N1eyZHDxQsxv84CSQ6aJ3EU38oHjc4EOIpiFNTRfne0MDnyV3?=
 =?us-ascii?Q?19J/7fcGkoiQHMlC+m5nwkVLpDf2lZq+BzS6PGl8auQC040R4PWJnbCY3oll?=
 =?us-ascii?Q?nwNRuENgiu9jDGF3Cv3w/Hn4BLtBCzMYrsr9XrMBL0I6uJl1NFdN6Qmcyc3Q?=
 =?us-ascii?Q?QSiKO75QTXLWXgdaVqhQn9xGLM6uIatLdwYYMJ3R0kMT8LZNUgEh65N/lRUs?=
 =?us-ascii?Q?36hF4zKu9pbVfqDnHZ01UZnQPwSt9qq/gVwz0Z0iB7Ef0BfbBUnUrLaI8PIo?=
 =?us-ascii?Q?0eOnAfAjrs3X6Yh/TBTABuO82r00e5QnhmbObLA82hix9oeYtf0oohTi/eew?=
 =?us-ascii?Q?K2ZBQIdtqZBvtpIxI13jLuNIWG3t0xp/a3r2RrNmuUOVCPSgzvsH8p0iDLRm?=
 =?us-ascii?Q?w3aPmgjwbrqPnYR2mgEGvBslK9m4TXNVvkForPJAfSWUF8Z3U1Mu/7lwLE6+?=
 =?us-ascii?Q?Xl770Tq1T5LB4X27fLbNqVmmD5TFHH2owQOgIEhUC/4q2+1f/SEw9QatoktH?=
 =?us-ascii?Q?3lfLu9hu4VewTb4wod+cNPJosF4aH8FF4ocAADtb3/OiWO54fuvX30yIxcfI?=
 =?us-ascii?Q?grMRQNf7A7VTzcXXvRpGngZ6Vl8RIlHPeqBkqBSmbSRgL5Z95HG7AY6hYBgU?=
 =?us-ascii?Q?MYA117U+Ds/bXKlS4bm+YnqcajI25s+4UC03HdEOKnlrOMbQk1w8P8ccf7Fr?=
 =?us-ascii?Q?lbDTjpH6nFXZmbCP/xFHL8D5SYx7+HfdrU3a9ij+sWONYa4vmUSOynAX/Qoh?=
 =?us-ascii?Q?DEy7d6ubCsy671XN6g/C1bYe0pkJIfw2/xXDAKGO14yr0JSrAf3iN0OqShrw?=
 =?us-ascii?Q?HKUahAgMvq1SBB3wxQ0RkX9ZXxuoct+RPcemabJTNN80RJkOcBL0sy7rJlKS?=
 =?us-ascii?Q?vwhiSREElSLc2Ahgfdnzpf8Y83uYBgiIAQZccXfwwSoIQQTOiedUG+zy4qRe?=
 =?us-ascii?Q?galhcgci1TwVbRTNyWvLm3gLxpv7X7ZuxXsbKuIir4gC42tCItqTRyuYOdgt?=
 =?us-ascii?Q?whwGNhViU/cndWEU6Tgvu/ee8lpNiAHnEQhucPY9SdDLONzxdybhANNuwEFy?=
 =?us-ascii?Q?c5yq1aVJMRxgeSNuKyKTCZZzpY7kVwyke9KOpJZpxwQ6orI0UJcP/U7hCjlH?=
 =?us-ascii?Q?BssQak+70Axo5oI4OZfUBhv1ygkLxmb96pB0BbrQKE795JoteyVg4aNkk+Tl?=
 =?us-ascii?Q?T6u6yhhNoy2RcVxsmG/eHTS4xhhBPjajgX5qpbgk7QGi72B+lAb6z1QcUxl5?=
 =?us-ascii?Q?d17a/yZ4RdijR7hvfPFI/FT0CR34DKo61c+CpX2d/kBvidwB2RwzpurovQZl?=
 =?us-ascii?Q?rNLh8CDYu5981q0WF3YlP0blZsEq91Kb06CiBbgehdrdddvfIiuSqI/6+YaK?=
 =?us-ascii?Q?Ey7+MU2jqtgIRTPkYyhCxzyxw9cGznQUecLlksQ10gazlGnzUErLA/EfFyCy?=
 =?us-ascii?Q?hrGlgl/GtGGjWtZiOsDVKuzzz3aTzD5CSKWOYNrba1zQxYhXIBL7KnubZXZb?=
 =?us-ascii?Q?WO+4lLyiCV52vUP9u1iAxWWo6JXB7YVmMzXpMz6BL/J8avoAD4gRtCg1rrTc?=
 =?us-ascii?Q?VPpeoJ/Ka8eeXZOyq7w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9612a1e5-325e-4983-4b6b-08dde6669f3d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 19:10:59.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hKZT6RiZeZ5l7iZB17TpM546ihSfKvv6UFUMSh8DKxL5+JU/m282tfbNpeIDOEr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483

On Thu, Aug 28, 2025 at 11:56:00AM -0700, Dave Hansen wrote:
> I got a bit sick of sending constant emails on this one and just decided
> to hack it together myself. Here's roughly what I came up with.
> Completely untested. Changelogs are bare. Barely compiles:
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=kpte
> 
> I also didn't actually hook up the IOMMU flush yet.
> 
> The biggest single chunk of code is defining ptdesc_*_kernel(). The rest
> of it is painfully simple.

Seems not great to be casting ptdesc to folio just to use
folio_set_referenced(), I'm pretty sure that is no the direction
things are going in..

I'd set the flag yourself or perhaps use the memory of __page_mapping
to store a flag (but zero it before freeing).

Looks OK otherwise

Jason

