Return-Path: <stable+bounces-223101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEBfLN1pqGnYuQAAu9opvQ
	(envelope-from <stable+bounces-223101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:20:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D120511E
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14BFD30B38A9
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F1937B03C;
	Wed,  4 Mar 2026 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JSfHvCxC"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F737AA84
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644627; cv=fail; b=kDUyPrDKuohA9+5J97dCoeq3oWkxQEk8o1FWzV/NnHAuPwQKjlYED6Ce7LzwuvRM/AE7cpwyBTg6UMRIqpPnlfUR7+weQ9FF1nyGDgnLZ7t9Agcz8u2dhGWlNn2LvWTRg95CRS0gxx+83iwgo1x2QnKsjWOHEdtRzdtTf0cz7wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644627; c=relaxed/simple;
	bh=XFK+XThMNgtGoAFTuPDLfi8k9QsEGtVF/fSR4R11zNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oHEurEM6ZrGa51pYoP56GIrzM1PjBJT+B5/Oe4D0hM9gTGMbRHcC6EtY3mQhosbZ0BSqFym9oddLYKH5fu6kk2Z5YUPd3JMjge/21iuzgSn4Ne0QDRTPFCaUtsUmABbqc42TsmhHOryVZ+WqvajARoIWnl5zFi+nHL1bYt4BeyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JSfHvCxC; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YA78da0ePCTw5yUz3/HNCmtaw9OCnW4FBRMB1AQ6wnxNIvXj6FfcqwgjLeaQG3ksMLY/r9hN5As+XZtqdPEwtLb0ExZhi2Sii64EGZKX4CbJlXxgi5b7H5wYRuBkpMmI/IGX0URAp3oZVwzURo66JoJ/xTVdfUzQ9F27CnNe3ATuSYBVx7HBaobQ07aKveAMXx+ZJdShCFhtfVDPJ7UYkY5+U8G97Ne8gbF9sorVCaHoqyug1BkRKXmFeK62c38Mqog6EtptCf2KwFtBWVPZ55gKIhkJePsYf2Q13UAE0rGeoQUPFqewU+nGy1SBPQPscZcmuXgH8avJ4dgcyeo0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJH5HTTS8IXUeuygbajdkmLcYEnLHSboe7+1ynkudCU=;
 b=oNFHhwJ/PQrlfMgX5P+RF3R7/ojPLzzOgQdFhLYkkRkho+VW0SsLPNICaxCzejxxah26hLu/rnhTZhVBj4AqLjDREWRAG/esQSaS5AvVNTcXBEFnwPLB2nsV5FPtSzT9Pg3Yt8KaNeCYT12BaiTs6FOGiKLkUa8BMDz+rvLOYyst0zH1ggcUXq8ruzllD6Kp7e3vRzFuiy4+LJ/pUZdoM7BS3/fpGbYwSGSYGKLGlGNrsLgudwv1tBAvWhgNT3f8p+dUsOs3dNIDzuGA0qsDhpsvUNsyh5u/wXlpUFDVCaSSPBgcGNILvK2mBjBAK5eKchFqU38a4Z5BuDAZWplSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJH5HTTS8IXUeuygbajdkmLcYEnLHSboe7+1ynkudCU=;
 b=JSfHvCxCVG+k0WkDfd/CgAVjEeFgcEIzEN3y7msFQYycX5rAGOXFT2CHE3x+a5GtEc/ciwcvg6efbKclU1wln7BO5R3wWjYGXclcHnFz3UBZ6d41WMytlTuqQRZtTh3vakKq9gXmtzhXCdg5MNvQPqR36qaHTfU3sWe4V031v319zQ903e6AWynfxgsw7pnu6THFouaRQ9Gfz1DBaGUAWvQld462Vs+gi6pyIvk/vTwD1Tl/2QbA1HkfnXRMvvkbfFV8F1h943On1s4isspGqC9s/UaNQwRYvyLyfraHhNp5lmijIUzexUjCjMVNY3KELwO14NxnOZ5IVOP3h2P88w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 17:17:00 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 17:16:59 +0000
Date: Wed, 4 Mar 2026 09:16:58 -0800
From: Piotr Jaroszynski <pjaroszynski@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, Alistair Popple <apopple@nvidia.com>, 
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>, Breno Leitao <leitao@debian.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
Message-ID: <aahnVXb1IF2yVV5x@box>
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
 <aagUtDTca5d0le2Y@arm.com>
 <20260304134313.GM972761@nvidia.com>
 <aahJX0NwtYHy1ILe@arm.com>
 <20260304153949.GP972761@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304153949.GP972761@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::9) To DS0PR12MB6559.namprd12.prod.outlook.com
 (2603:10b6:8:d1::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6559:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ec62af-5168-43b8-676c-08de7a11d856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	ZwnC6LGvMV+ssAGbfQXAgQ3D0j3UEWfRZMEtYHN88MfG8TXN39lOG7ZPljksoqpDkkQ2m0GPy8NPG+6TtMuYo47nsBGQZHnDw6Py4uruaEoPps63+4l+XOmH3POx6dwnxOpAP0uGT/jUZ4tmnBnjSLFnU2jLp2aBMjgKDPxoeKHJewrlKyVE5l0NKXlMXioSNrOl+NCwjSs6RcWfXEWGLgXpVL0daWxgK2V3ADpHw6TWhdzb6a45c6lyOLp2nL/Zumn1ovnVYLszEbKoxTz8f/OPjJArsttW7I++QvfVtIYz19LastVNlOTB0d2Jit7CfuB9ig6EBEaNUp3T6s3OAc2mt7SBo10YC8D8prxR9MiLRekrzuTUE+k0XZIbGWtdV6D1U5GKIb23HdGiownuufKuQRyr5h2aCv2y322VsBuF6Oe01VPI6fs4Bcj+NU0exgE+oW5LIsMvSKlfKTFCxewjAUKlPCvIvCufjE158w1lXiJHhjEtCj55ChIP+TNXZWk0+CAmk8lZMRJWNCmvHXsqNe+/Jg0jh4QXxK2aK//tL/MoMx2+XsfWvSLJZQsGoX7T+jiQmMaTkt0iUn8IkbWHjxctT5G7CSyJcGzcBGCfB05sIppt727/NQtlPCtGtOIdPtXFy1ooD7hjxJ4LyqEQ8oKKFXW3vosYgFowlFYJeLtNr2eOLUQo94jjosG3RtPLYFew+zF09+YliHEDuC6Pht2wEJtLPkRWi+eOet0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jEpGFrLTufV7GskmfwO2h4khYJCyhPYwwdqC6kZ/pfFxaPOkB6XquHsnkGts?=
 =?us-ascii?Q?L7xWWIq2depsH2XB8VCz//YubPKFsOpb+2iTKi3GrGpEQZxnSeR1TCmo3X1o?=
 =?us-ascii?Q?8tJlYlvgRdvKwY/VU5l93f2vhHMPBtVZ8m19ln58IARHL+lUeU5xNd8DQKAd?=
 =?us-ascii?Q?UKyiVB4xXWagwy968zKjMF2FGOCp2yDKY44XYx+a50RIWfDdHk87KDndjLww?=
 =?us-ascii?Q?tZkBMNtuIDpRlNbSw1AYHW/0ANjElg2cJM3USmSt5JRB3EKpAp967Xil/bvF?=
 =?us-ascii?Q?ED3PZ+1z8fGG36qmPwf2/A9ulaRbfve7SncuioLuIrdWIsVPhsZVGJg73EYd?=
 =?us-ascii?Q?pUIRWSZljRtVRE8zLbR3KLuFN0IeipFCebjAPRfNXCA2N2YS0eRHo8jRvEF3?=
 =?us-ascii?Q?RpOw4aA8nXT8H5qo3hHVSeqIR5KPEN1P4KMaoZiLx4NjQN2jxnmVW9jdimMb?=
 =?us-ascii?Q?XYWpCgu5WYMdvEDa8p6qpuHbgf/uQkmcQPrgaMWqgO6JPWtcO8tJ9aISUM7t?=
 =?us-ascii?Q?v2nTvXuDRjnPXUr/ZVdCBlhk5ngVLHzL4a6olmSlZnXhjba4D9wFnJaUuzrM?=
 =?us-ascii?Q?OiK9J5+cxys8C9QI4cvMboEh6HQW41RiknP9Yu7hq/E8Z8Sws0ipYDj5mLhh?=
 =?us-ascii?Q?KpgxHBeILirnfcCOPTFsAKjTkjd+hkwtFgNp1M6hsE/A861f2Gw0zyZrswes?=
 =?us-ascii?Q?bsc4fsSzTlDpEZi4PQQicT+2oUViGO08kzc/Pn1cifDG3Rdb3UBKCHScFPkA?=
 =?us-ascii?Q?X/TlEg+6x1DiCgI5oISABs+6N7PT2MJVa/2v52WcVIaPAqi3dPrsOOUHmAok?=
 =?us-ascii?Q?IreDWXGSoMIxR+MbNMS6U/pSmEaHNzLnKa78GQXxRMomBtjOLqAZyMhrulPr?=
 =?us-ascii?Q?klhSUiVSIlDS0a/BArK7Zo8EHRvbNvfI4wZ6QjxD581WfLuPtuOtjryf+MCa?=
 =?us-ascii?Q?apmoFkhErFP29+noxtjfxiMGs1RLIkNY5Z6e8S4O1qXXNPHQdpKeBhm1/jgx?=
 =?us-ascii?Q?zo4cWqpDRdG/9cve62caRthjJix2Msfh7cip39sF+enHfVntMLmg4dQvowrf?=
 =?us-ascii?Q?6FGNMqcSlwj4e6MvDNdvpCv7LzaNhZLuq3BhXPFOhCuhx/ay9pfpPve7tODQ?=
 =?us-ascii?Q?hq9P78p31g1bxi5Xruz4OIOGbuIE9kRxCiaQkTqxkgVBiBRPpyk9gKfcbjyw?=
 =?us-ascii?Q?Rh18pMTwkqQMuXHR5NulFOsss9c3r9JtWUuUrvDyvMkSRhZ2mzS2kkQ4lhF0?=
 =?us-ascii?Q?PQgtTFtvkl+MhzzNw7v1ZUvnJI5NOWIJz/U01Bwem4HlVTHlRRVjget1gzhJ?=
 =?us-ascii?Q?qq4eBjKY2rIUkEu+ERhJKadOyMmKS4xOblFJSpDBARoI889d6NAefhFKFbWp?=
 =?us-ascii?Q?mYGqMQntbkVdGX9jx72i6KUXeJ1QYWFKS5wbrD4Dq4i4GdsGDOPSY6LaskvE?=
 =?us-ascii?Q?aeYWSbjROipSuzIe77tmMPBhodTuQHeqw0rUTZYxwdizlkIcjYjM07gdm/ew?=
 =?us-ascii?Q?H+0EAz4IDZ0m0MxUbgtc0S591fopGA+DC3kX99Jq5KRXKJ2UWEVVrzTaf8Qt?=
 =?us-ascii?Q?lI2T8uL9VpBRaMohmX83bR0oI+0jHpklwQlBqgCy+AbmlYUwFRF4tYgWiZGp?=
 =?us-ascii?Q?7j0XIgajC2R0O67s8qS3SDNTdPhWF7M924GE+MVm1Nnh2RcVFoNINZ7wncVa?=
 =?us-ascii?Q?FzjrFdyAnX5XSemt//rJdFcuqLNjSI77Z67aRxu2iopa5iISrBf/zJ+cLGPu?=
 =?us-ascii?Q?/N85xnLrIaMIRKIXy4sido5F8mASGj8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ec62af-5168-43b8-676c-08de7a11d856
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 17:16:59.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /84jZNxpukOyCeYJwTWmRJahPvCKNCsmdqWRWABgE2RHRCBSZr908tns1V+b2dckYCty7c9Jo+UFPtyg4ryGow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
X-Rspamd-Queue-Id: 235D120511E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223101-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjaroszynski@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:39:49AM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 04, 2026 at 03:01:51PM +0000, Catalin Marinas wrote:
> > Good point. For the AF bit, the hardware is not allowed to cache it in
> > the TLB, so we can't get an AF fault for an unrelated VA nearby.
> 
> The way we have read the spec is there is no restriction on what PTE
> the HW accesses when it encounters a CONT group.
> 
> To be concrete, the spec seems to say it is legal to make HW that
> fetches the PTE at the VA, sees the CONT bit, and then always fetches
> the 0th PTE from the group and only uses that for permission checks.
> 
> Therefore SW should never assume that HW will read any particular
> sub-PTE under any scenario.
> 
> It seems current cores don't do this, and it is a bit silly to do, but
> I can imagine an optimizion where the core does a cache line fetch to
> read the PTE so it can freely snap to the PTE at the start of the
> cache line for permission checks. Consolidating permission storage to
> fewer PTEs would reduce atomic memory traffic if the TLB is thrashing.

"The Contiguous bit" section I quoted in the change says this:
 The entry is permitted to be cached in a TLB as though it is one of a
 number of adjacent translation table entries that point to a contiguous
 OA range with consistent attributes and permissions.

 Software is required to ensure that all of the adjacent translation
 table entries for the contiguous region point to a contiguous OA range
 with consistent attributes and permissions.

I think your example is valid as any of the sub-PTEs can be cached.
Another valid example is that first you access addr A and PTE for A gets
cached as the value for the whole 2MB region. Then you access a
different address B within the region and fault based on the cached
attributes. In this case the SMMU never had to read the PTE for B as it
already cached it when accessing A. If the faulting code only read the
PTE for B it can show that e.g. RDONLY was already cleared and hit the
problem again.

In summary, I don't see a way to skip reading and fixing all the
sub-PTEs. And the previous code is already reading all of them so the
fix is not adding any new overhead.

> 
> Jason



