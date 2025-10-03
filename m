Return-Path: <stable+bounces-183301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A8BB7ABD
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 19:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D1944EE0FF
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF62D8783;
	Fri,  3 Oct 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bT2Lwqm9"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013016.outbound.protection.outlook.com [40.107.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67910260590
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511530; cv=fail; b=CMZGiG5ib7a2/cHJ3OD9i0dXQLCLzYyDi47nEk1bikRyabEbCPYOxM08Yzafy31y7LJaxo1QcHIxsxxGHv9xrXDGoSbyYKv5f0V2VTo4k2J4MFQ5vmd3q6w5fpWpxxTZ4UDJ/oxv62ZTgczLNqkDABEd2QCT2xM5ECBzyUKt5Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511530; c=relaxed/simple;
	bh=qFWcvf87Zl0eO0b/u6izBvTv85uTNBDQ8JSu2z+MJb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WVLUsU5Os93SOWOjppYv82NWgDv1v+46vBBmQFKDChAZw8ZyuZbTZ4sTr8e9OF9iUWjVUdNUV1HiGDnguKEy8CV+aLoojdtcW3ppGod7aa8CqN16KbPigeRHwOZr1mKtVixAcEdB9G279m7vlsCUoLgl9MaOOXMaucT77QWcg5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bT2Lwqm9; arc=fail smtp.client-ip=40.107.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkbSeV0rt+L7f2F3vh875LPtLmelK3pGeBp2k8x5aNKF2zC0s9pyPCY5vkbTQzX0J9E8YMgZtiURnizz79QraM7vWWwE8n65+xfODCyMctZr4PH4Zd//pkX6roGV9+nxKTtKp844XzXS/MCll5p6DG1/ycteK0p2RIjqv3HguA1OmOMMHqReMdb3RfyHflSfjRCPSTRuAfJ8XrIWQbBFsXdSrl5e92zPcfj5VV94uv7chTlsMTxHqPMievzJF28Uk7hgMSuvNvG4NdajRy78PSR3Awv4PuOOzJc4yO3nkv1TC6DfoiL/7oe4j93sZkg0a2NonOHXiK5snT9xmLfD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im+8lRf5N/pjTNVBcX8kmjP5KpMj9WjG4I7Jv4zYoKU=;
 b=T3Ae81BBOg6mqfwq5QFn/NJah8yI75/nWiiOa29e7vKXxfYkCTJxIN5aZ07Zh+aKOaFBxzNXJnD79IRTVR5b+D6kS/a1bheNnrlfkRo45yChQm3MzdhyxPXw6d67pa+faTNdYiY2By3gbrwOqHKVQmzXhZM2Mi0cwEdqwP+C2QSruUV3lGNbPsJsJ+Wcgwwh6NCahivf2wCn+x/zbuD/l2mhDgjbWUu6xj/6p8c2Y5JYJcx0ZeN0IZzn7Qf/v+p3EMjhWxXjb4zZZSJYg/CO+VV4LE7azsY5PtlmzuBIrcOfDz64ixsOjy0LyKJPO9g7NE4wMUffScIxlcI3rSNJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im+8lRf5N/pjTNVBcX8kmjP5KpMj9WjG4I7Jv4zYoKU=;
 b=bT2Lwqm9Ys59h84E04p4mv5xohEPPy703p0M5sHxFXG0PJPeSRW6loc8XkE/OnaLr6lb1yUT82oejPWdzNtxVd94kOEoXTjLP7THfv7IqMqktbwEY8k60iR8WYGdgrxmRmk5gvQmZGKjZiv6yKZTybIEgL8RTc1D9nuWewpZQtwweieSt4RGvgoWs3Jywcjp7dRakTPzIDd7uZv9n1fe8tdYxVWab/RVU++TpXzIUFZyqQk7qKoHrHMzBfH61kZoK0caKpyRGlScT8UiqGPgD3vUei8u/A87K3n0AaJRXhAOuUXMgiQA50OdCdC9gIXkNNgJYZX2Vx4gn8jxdoSdPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Fri, 3 Oct 2025 17:12:01 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 17:12:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>, Wei Yang <richard.weiyang@gmail.com>,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 wangkefeng.wang@huawei.com, stable@vger.kernel.org, ryan.roberts@arm.com,
 dev.jain@arm.com, npache@redhat.com, baohua@kernel.org,
 akpm@linux-foundation.org, david@redhat.com
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Date: Fri, 03 Oct 2025 13:11:58 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <5C87F8F6-C508-4BE4-A3B4-9563AF48EFE6@nvidia.com>
In-Reply-To: <29ac3e02-fb60-47ed-9834-033604744624@gmail.com>
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
 <d8467e83-aa89-4f98-b035-210c966ef263@linux.dev>
 <1286D3DE-8F53-4B64-840F-A598B130DF13@nvidia.com>
 <29ac3e02-fb60-47ed-9834-033604744624@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: c12422c3-9b6c-4ff2-eff9-08de029ff79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E4rl2Woe8L9aX0LaLC1y0aZtcv3bxRNvXz3xRwVTyAbbqUUo6qs7w7iZ/CD7?=
 =?us-ascii?Q?lAFqUqa4f9tXm1rRvSVwD1VhO2NRkIDEc2kkSpNnzfBwX2upRBGxGpZvsb7Z?=
 =?us-ascii?Q?0thAjrRwTt2oaS7fZ059MHPpTIPmxpG+dDw0WNI00aKJCjsKJQJPFSw0kVzF?=
 =?us-ascii?Q?vSlBcG7ZCcEsKGlE1h4V29SoXmZ3/f8Jq3JLueqLWfDm0WW7+7m2JFwgRFpZ?=
 =?us-ascii?Q?RlqktO/RLmmydeSYgBB71ks7MkSo8HMtBi8bgt3NweKnf/n6r9Gj4I9qHrLY?=
 =?us-ascii?Q?/SP8iV8g3nwt45hGgvgxZh7KuATaQRmflfDREOAbkXB/nAiui+tXow4pAYT+?=
 =?us-ascii?Q?gzmMJTwCvckTpxVOiPIVNHs036nh5Jt+pRjAFknwxMzCS3s4hqECDkdpV87O?=
 =?us-ascii?Q?i3nng3JlZ6xEHZGni6c6ZHiDe/Qq6BGhNccW95w6yoqpOYwl6v/9xV+Gn8fS?=
 =?us-ascii?Q?qvrfYFHX/TO4KpuoxoDSbaYTpmE487K6yypAon5StVr02vaj0Zk3adIhYPn9?=
 =?us-ascii?Q?QMZcQ4+QpryrlVTYGh1AglPdTEnPQpx5ytOTLyr4s2GGQKHeEeTkAMWN+ioJ?=
 =?us-ascii?Q?a4PBxetvVbnG05RQVQvwj5KyY+1JCLSIx70L9uAAv3kBdGdMaaa1J0aaPAu7?=
 =?us-ascii?Q?jnfHMSYeC+x7nWLjBK0fz00q7my9+fiUxmLpGtxC5ztIivINa6Cx1osvBK8D?=
 =?us-ascii?Q?QE+WZrrZsEaBeRa24KVLzPfADnI0bKfA+IU81kQRgcgd3rlSlEo2fVs5pXJf?=
 =?us-ascii?Q?HHPbyNuGk1zQQPys0VVH9f99mnSzUu8M/VeD9at3kDJugNYeseWW+l2FcGpZ?=
 =?us-ascii?Q?SjnCrb7jxriweV4mkTq0Dle/1ggqGFH8/noE31DpYYDr5OrzthIeo+gi863x?=
 =?us-ascii?Q?RI0WWoV7IZbS/hNMWvvQIOG4PTmKZvnd66hHy1KuHNgZnV9Id6wtQycdKijl?=
 =?us-ascii?Q?Rkmr745rz/A44KMBFMs4yIYnyMNWhjpVm6BSHtRkgkrnnzqmxuGfQd35svPl?=
 =?us-ascii?Q?mlEbyBnKuSGA8iyeYZvz/uZ3tzZzg47y1F3ZqUG8ZDmHRMvM+LWYL3wI7KEf?=
 =?us-ascii?Q?pEbV0OEP7uXOVKVmh0Hm/RSJ/rSX2A8AynPXs8h1M55lviw23oCF1m24tkbJ?=
 =?us-ascii?Q?9wBkC3Op0vjizVZpgaEJ5EJhH9Q1uPqH20vkOMHV+ivBsESrKO4nVgvb6DyM?=
 =?us-ascii?Q?MoeE1hDEaaK6j5Mnb7r6DWvWOanDVBDKnRTENXZdmQZGDl70fBPrknuPIlw6?=
 =?us-ascii?Q?4HcP7SwTO6YlYS2XZs5A3MYvB4DV3vCAM0eeHeu+d0zHyIg1imZUH0qPV7oF?=
 =?us-ascii?Q?M61+eBR4n3JSnHAKdPibtx5b6SbmxzVpX0Yjwo2aay74XPno381blu+n9KUb?=
 =?us-ascii?Q?Bt4aHvYeQqzPVLQ9IPQJfNbDi3ZzLRih4KVs/mPWPGL50vvRc3vPCgcKwYc1?=
 =?us-ascii?Q?NxfLhzLvXgpGb4L+xEdlPJ8bzgCLA76z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8bRF/rUGRAFcr9Fxm7dNaInDm+VsOSIvGRglCw/aORR/Y1UV4b6i/Bxgb/bU?=
 =?us-ascii?Q?CvqJ2qWiWQfkH3s/j5djyI3mc6P4AIAHt0S33T5NzjbRlu6njZObxXtw/O/B?=
 =?us-ascii?Q?eikC3r1VcrB/W4byfbs7elM5LOaPbfSqdFRap81YhrZuIYsLgtUBR8s0I2Mb?=
 =?us-ascii?Q?B976mj9C7hnb5i2Wl81Gx0cj1oVxgIdHz+hu/lmMTp8xH4Jz+FmdnIOBxGuD?=
 =?us-ascii?Q?nKWFkKCwII8ECMsJrnaJ9qoTNn58Lq/4pmPfbadIXYToZXAwe/wA77pIziiT?=
 =?us-ascii?Q?wyofB3xkeyE4vLHkSQVnN5/BPuiv2C0ZZP43CyS2U7IcvSebcAdrqXJNXZ0m?=
 =?us-ascii?Q?bv4WtwM480z2TQq5yEGBYL1d+ePyAmx4GhvqKdFTE+cBBqCYesYihmIdGDgW?=
 =?us-ascii?Q?i6mN/cto0EiPMVWmCqbawvGrpzivdmKIdYByccGDD9QVplJmqDfq8rFvJkDn?=
 =?us-ascii?Q?c+1jz0slcNBiWa21o2dlvRkOiUsl/IpgmuV1xwnVbKF+i9+pPClR1HwHq21Y?=
 =?us-ascii?Q?gltMg5LU4wplUOAJ9ocaG3XLxEXnNcFK3FtoDl/194LPLHrdiH7w0o/6xl9N?=
 =?us-ascii?Q?+nU5DkYSL9ozZW97iI94d4PNJKTLJUGEV0i1xhSmuyZ15ptmmQhSjWNh6pi/?=
 =?us-ascii?Q?CwTXo6x5kgKfV0+7VA5LpUXOIvnxt0874v1MmC+9RaRNr6Res2C50Q2pgHsW?=
 =?us-ascii?Q?1zgmpZpaeJhwgIl+Ync0aPv6B/t/h/Ax9UlVLrjftBa1KiOlU/qFVtd3asCj?=
 =?us-ascii?Q?4XrunguNG6bGWWZN8o2pVKydhHWmoXtY5s3rvD0yM472ZgruMHCuBWIBnz8P?=
 =?us-ascii?Q?K61sMziGLgfoy4JhUajHpYxZzdlpFFcTNN4YZ05BJzgI0kKRbpxLdniRdL7h?=
 =?us-ascii?Q?vAJvS7YlztoznrULuDWFwww8ruhoKKnsNMAj0ERbEJ40jFBK/WJXCgM3n6Ph?=
 =?us-ascii?Q?AMK+EltZy6nBigFYU+imIcEO7cro1bRwlG4BiUuNkOa3IunOPY0mRkD8MbWX?=
 =?us-ascii?Q?QMGWkOfcHEyyiF/vF8DvtsntjUcHeVyBk4ryHtLZ4/7uRZDvRhOTIi7wb+nv?=
 =?us-ascii?Q?SmVXVtK51EqZyRicyCGw3IqQKpsYL/t9IBxcUZSgBUGhzAuhfMyGAzSidFDq?=
 =?us-ascii?Q?x1GMg4JX6EoejMGd9AlmVRSB78AqMsEZ+fC6ZjHwrzs/fpghCWasRj9IHOGC?=
 =?us-ascii?Q?GXkBCPaoulPkPDwXhEt3C9eAIr3ffmVJCImNw3B58S5lgsYyMVmCSHL+6qsS?=
 =?us-ascii?Q?PEE9YgdV3hso98dfnEI2Q6KE4COCCwWsrhdnsJ3Bbi+gR4ybsbfF5Is2a40B?=
 =?us-ascii?Q?Rh5RiAbgl+MI+aqKqVBmjBMzudvWdOQfyby0fjiX6nOWCXc0KtDCBDG+IOXc?=
 =?us-ascii?Q?ixxoGNI2JWS3thmulY67IX7uJBOTeMLPgrnma/bo4pjDqL/GSpF5Akd2uJNy?=
 =?us-ascii?Q?hJi1C+3Ce20sSX4wHxA+uUXJH2COAjnrKUaygBz+WbkSr4UvZRRSSsuhhOrQ?=
 =?us-ascii?Q?i++DxctMM0/mpjhcpmmI0CgZazK+fioFe6sEZSHJAYHm5F3SImgwlSTOHZDE?=
 =?us-ascii?Q?cnB0TuIxdbHMQga/hauTgEVZCevefVFjB+Nk/6YQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12422c3-9b6c-4ff2-eff9-08de029ff79c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 17:12:01.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Asi1CC/GdzBTuT7cF+4Xd7DijA5scJI3DjFzmLP85WHrWPfohGXBSizTWu0ogkvM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

On 3 Oct 2025, at 11:30, Usama Arif wrote:

> On 03/10/2025 15:08, Zi Yan wrote:
>> On 3 Oct 2025, at 9:49, Lance Yang wrote:
>>
>>> Hey Wei,
>>>
>>> On 2025/10/2 09:38, Wei Yang wrote:
>>>> We add pmd folio into ds_queue on the first page fault in
>>>> __do_huge_pmd_anonymous_page(), so that we can split it in case of
>>>> memory pressure. This should be the same for a pmd folio during wp
>>>> page fault.
>>>>
>>>> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") mi=
ss
>>>> to add it to ds_queue, which means system may not reclaim enough mem=
ory
>>>
>>> IIRC, it was commit dafff3f4c850 ("mm: split underused THPs") that
>>> started unconditionally adding all new anon THPs to _deferred_list :)=

>>>
>>>> in case of memory pressure even the pmd folio is under used.
>>>>
>>>> Move deferred_split_folio() into map_anon_folio_pmd() to make the pm=
d
>>>> folio installation consistent.
>>>>
>>>> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
>>>
>>> Shouldn't this rather be the following?
>>>
>>> Fixes: dafff3f4c850 ("mm: split underused THPs")
>>
>> Yes, I agree. In this case, this patch looks more like an optimization=

>> for split underused THPs.
>>
>> One observation on this change is that right after zero pmd wp, the
>> deferred split queue could be scanned, the newly added pmd folio will
>> split since it is all zero except one subpage. This means we probably
>> should allocate a base folio for zero pmd wp and map the rest to zero
>> page at the beginning if split underused THP is enabled to avoid
>> this long trip. The downside is that user app cannot get a pmd folio
>> if it is intended to write data into the entire folio.
>>
>> Usama might be able to give some insight here.
>>
>
> Thanks for CCing me Zi!
>
> hmm I think the downside of not having PMD folio probably outweights th=
e cost of splitting
> a zer-filled page?

Yeah, I agree.

> ofcourse I dont have any numbers to back that up, but that would be my =
initial guess.
>
> Also:
>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
>
>
>>
>>>
>>> Thanks,
>>> Lance
>>>
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Lance Yang <lance.yang@linux.dev>
>>>> Cc: Dev Jain <dev.jain@arm.com>
>>>> Cc: <stable@vger.kernel.org>
>>>>
>>>> ---
>>>> v2:
>>>>    * add fix, cc stable and put description about the flow of curren=
t
>>>>      code
>>>>    * move deferred_split_folio() into map_anon_folio_pmd()
>>>> ---
>>>>   mm/huge_memory.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 1b81680b4225..f13de93637bf 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -1232,6 +1232,7 @@ static void map_anon_folio_pmd(struct folio *f=
olio, pmd_t *pmd,
>>>>   	count_vm_event(THP_FAULT_ALLOC);
>>>>   	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>>>>   	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>>>> +	deferred_split_folio(folio, false);
>>>>   }
>>>>    static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *v=
mf)
>>>> @@ -1272,7 +1273,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page=
(struct vm_fault *vmf)
>>>>   		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>>>>   		map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
>>>>   		mm_inc_nr_ptes(vma->vm_mm);
>>>> -		deferred_split_folio(folio, false);
>>>>   		spin_unlock(vmf->ptl);
>>>>   	}
>>>>
>>
>>
>> Best Regards,
>> Yan, Zi


Best Regards,
Yan, Zi

