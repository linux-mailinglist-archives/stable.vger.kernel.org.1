Return-Path: <stable+bounces-66058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDD94C059
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714251F2840C
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1018C906;
	Thu,  8 Aug 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CzGDXmxX"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3718D652;
	Thu,  8 Aug 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129061; cv=fail; b=dypsPNabmNc3OI2EDvQ6jjYoLHfEcBgEdWSa0LDR6Iy+rkfAqcDk5/3o2wlVec6JIHKD+ZpkBHYTEjdCVnYWuUltsjH7LluUtreRMcJsuQnpH9g3j5oV9WqGqQiIpZr4oXGpE83QHz21XwO6XNvf0lFzEdXRiMgbiXGtuxlznQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129061; c=relaxed/simple;
	bh=efWABc3vnrt9m08yZOFVTQlW8H9ZVKvYJdH30WqPzx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sBiit7PXmh7WSyLZmi7wFcuzEmy2jb7UnIgHwD8ywKV0MR9Vz9IqKA0BhJhMS8uYFEhCo//gE3Pd81X/AnJHlh768zUJ35YgUQLbV3uuhwTTdtJOj0AR8lSmNK4lkP7lJ96MWk0S+6mSKTAwWqtG8jCJkc3xDU5OyUoz5Ro5Sjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CzGDXmxX; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mg2IaMzL4Awa1gCB2OsbijGUoiAhXlBTU3ds/giwrT5f+qPXL7M3X1jI2j2CWvZc2iF3eEGybPO082ic5SStX3x57S+lnBjunvDaky6w9fk7SxQp2G4KkPQxOIl+pzAnLzt6/80/8xhpJUD/Kndwt66OsX7clD38z0phMwrHXfyzwbXTMdbI0z41j/4SbGeGLXmrswWFDvWa5k5F8Qcfkck75JkKKnvs8K2KBvZiatUyEMiYL0L+obhiLYQfnort2BFCXfZcOyLLLLS0C16KtPvTyhIeqJ6yFwC+bAEjOcXlRtiNRjcfE5E+O6wIKvIYtGaLNLlo+Lmw+irOzmw02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exZQ94ecdpOUZWNHFHlf2tATtepiAVoLoiurqc/9W8A=;
 b=j+SZPoCeeQoYphrPf2/cALDog/8MUxtVXgTbTArZPjteZoGcmYDMVAl6fTDMfAiaz4JRb/jxv0IPELuhADOyI1FalInyGlhB7OIxTrkUrcNiAPAdw+HEH1x7CDk0W1lfkKq/WyG30MoDznIiPJiRsn9YyXXMMn5bpYEZX3yDVc/jYryYFIJL/B3N6vELlfjR771xIbE/0E4UxzwZOMW4+TzpHrz0b1y1p+CgyQTtjII13FGHcj7ixVxVZPhVm13zBvo2yXW8mu7KYxZaFs7vb9RZNz6Bto2fBKFyKI+UZ8ELo8H9tib1LhdIppt4mdEdwQDatRI11L1216A+oZemFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exZQ94ecdpOUZWNHFHlf2tATtepiAVoLoiurqc/9W8A=;
 b=CzGDXmxXgl4/USs9bHrZtqS6yxdRIu4H2ck4KqnakEV9VtqMpZXMOm91D6U3uIObIIzhzm7n2FVB7Rm1sJZXW23Oc6yxDrKruG0ZHHH12LSKbojpYjAd/VxZJmQ13bvQgTf2FHk3Y78PAVkEO4ZNLsq6Y5ZquRbt1aOZIUFBixBZ7tS9kolSbNHexYrMxHNFZCZxWRDGpRKezNlk1If6OFhdxGGIroEhnTSYN0DV00F8P9nKSqI0gEmYhrN+uC/oBLiX1VO1Uqewd1hqhF/UHwfWkovo/j/7rNGO15OQbUpWC0PQLtxlAVrlVGRi2Vrok6ZmR46INgqRoVicpu1Vbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 14:57:33 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 14:57:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
Date: Thu, 08 Aug 2024 10:57:30 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <6447AB19-CC4D-40C2-94F5-C39DE132E1D6@nvidia.com>
In-Reply-To: <b0b94a65-51f1-459e-879f-696baba85399@huawei.com>
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
 <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
 <052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
 <8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
 <b0b94a65-51f1-459e-879f-696baba85399@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0E7B4A51-888F-40C5-8522-F7620D9C9FE7_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::17) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: b51285f6-552b-4851-61d2-08dcb7ba6eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?crLu0GhqoeV1MBSe4IjyHEmnUY6Ind0bTYODl4eN+mNWP4q6bu+Q/0r2lJ9V?=
 =?us-ascii?Q?IZCqsnX5qcD4Zzz+UqrTkbH7SQVt1oUwqrfOe8+QCuXoJXASoIdHAlirzQeN?=
 =?us-ascii?Q?cmIZTSM3kJn8BbDEZY5tf7QiCoCx1JnqjJAgIMNeKhxOmam1Trf8zzZVnvk+?=
 =?us-ascii?Q?rD1vgxzpBd613tTEw0hBdbtIE4Ilci0Ml3XB5/RYtlpvVhGh+x0Hq2Jt5TSG?=
 =?us-ascii?Q?/spr9TZz1DQcIVt/YLgMtXhd46Qdu0VHUW+4swdqsSnA0IfRxk+ZVi9SoUTN?=
 =?us-ascii?Q?BOpArJxxFlck8tAp7VOgfZhnD+gCYegKFaB6bBmFgz07vg7lU5K6Swrot8yU?=
 =?us-ascii?Q?I7zTysAQqimAl6VR8Xa7EReVwi8EsuEgT9XZi+4dBCKz4WdZ/uFIfczttiRL?=
 =?us-ascii?Q?nUisZA+9qtWAZxsLFqhsK69vcM6/z1AJGh4wV+yrzaZFGt5aYyBo5iGYBwcF?=
 =?us-ascii?Q?wHxutjhYJ/h9jeNd1vA0YHmfyKbN3Dawwa4Z70q57FJNFuGAdsKNGbArAUJl?=
 =?us-ascii?Q?1fuPA1KHznoRYRanmdaB4fQBARkyYNXx02lE0/Ja/CvT7A71s7KmGUm8LJ4l?=
 =?us-ascii?Q?tEPhRadBeDjFi0SYLGGrng2zqMSwqkhipOMlrAifNdsr4xtEynrQJiXbRSnz?=
 =?us-ascii?Q?Ri+6iUmmTQ0E7Doww6R3jjpzQy3luYGyK16T5870qyt0aWDVYUYZamLy9/jg?=
 =?us-ascii?Q?fGZaA21+DF4TrJvtRCBxOwAfnfMd6U4R7P24XYc6gY8R4uFv9iiPtiQ5sQd5?=
 =?us-ascii?Q?dTafJ30hW37KAFwXhBeB22JtZ1VFKa1YsgsdsjJrRGm/8YaXzWYFOEeOgML3?=
 =?us-ascii?Q?1//ZI29ju2daOS/EmSodWJMgALGiNBV76NqVvpQB5N0XYhxQdZViH9/pts2D?=
 =?us-ascii?Q?2N5tac3y2dTGN7Xr7k8v+KNpgcNs/N0luuXJ4Gjeytf90M4HXDu55ItIOmeG?=
 =?us-ascii?Q?thY1Jdr4wlE4PBYPPj+vuBgh1p+OQoFr+8JuTvCgEbk6BMbnTyV3ceyqScGY?=
 =?us-ascii?Q?Ygt+FR0dICjsH/lY70HV7StDUvy9/O1ZVFap1GO3JRY50XZKRx2rXUvdMmb1?=
 =?us-ascii?Q?1eT7A1ERQNVz6NRYIqXnhA+iwU4yyHQ9YmTP64jrq9Uc8+lTyzeBFrHFmZkk?=
 =?us-ascii?Q?CPBjRP/98qes0KwIXq8SaVbkFagRK++4pmXAM105J70Nt3kEprcFlUiYksq1?=
 =?us-ascii?Q?YlYK1HbYYZaXDyy8pBokbMxH0XH3sDMjhFvcTMpoTPR+JvzoeTSlCSiqNJ7E?=
 =?us-ascii?Q?pQKuftPM3zyrL8zD7/+WA63WrGvLDE1IzLySv/o+GsYB/3Ric2f/FJu2aqdk?=
 =?us-ascii?Q?imAqPsUxO4kylitJHRgfZc4E9UfywskLPf4jnSFP07l3RA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kx5aONSvX5Si/m7MkaFKc2QH5gbxl/YQeNa/hXS/rc5b5P8fgIL9zqHHszPy?=
 =?us-ascii?Q?QZNdFGiIKBYTP3f6D1FC3B7+0Hgf1jCY02+qiCJnl0SDxpLdFbvEBn3l444P?=
 =?us-ascii?Q?Jr1rZ6AAx0YJKLpuN6LJtNMWjwoLXTSEdLorfo0PrYbHWe4RmMdZLxZXgTvY?=
 =?us-ascii?Q?bQHx+DA95OAXQEO94ldD0MJmnPFb71n2QvXgnV97NQhwWc18aGABy98tCzh9?=
 =?us-ascii?Q?Cp7chaL/KqLrrIDnKBNRWXgpCDafv8fpscyGmJFa9RKgZc2NFlqoJ06q0hk2?=
 =?us-ascii?Q?II5NYEg4LzPqqMPsC+7YYEnkc2KrwGnNpDGcQNz2XBgToyYghkjZ38TSJtqm?=
 =?us-ascii?Q?+rkECx3WBgIecQOOAbP8rAlObQdddGESeq8yOtgKdTHUPsd0oig3AVZ2474a?=
 =?us-ascii?Q?EFP9aBl1Avpg0D20TAtd0+PasZjZVLoKkUTv+5ygnyvX3qOkQNkYegnUStPl?=
 =?us-ascii?Q?k4Ipc9KrxMjZ4iRJXVmlhkv3fHDhBzHDF/xYmGja12KwJos5hjmW/a1Qz2CJ?=
 =?us-ascii?Q?OQSWFUAWQ3O+dyyb7z10cmJ+AHBVZnteKrn+N1BBGVr6xy8YlqmjnfEgy763?=
 =?us-ascii?Q?JD3nDVI12EIzxzhNL577wS8WF5mfPVKsxiBRP+yY4IrBZMphrTV5m7tIP8NI?=
 =?us-ascii?Q?pV6v3Bxe5lghoRLVqy5AyYZGxfnfkosRhGhXZpedM2W/6gcUezxTYSMDekCV?=
 =?us-ascii?Q?5zFb1oy7fgqaZ9nXv6yeBscemYD5TglcDMQoQz4y3uBDybjzQFK+Zr6bcAta?=
 =?us-ascii?Q?TRSSOgwiZd04Y23k39fgS7Tm3x/HLS5Bi6wmE6/P2n9iFBSo6sx6DZZONH6R?=
 =?us-ascii?Q?JsI8s/Qnsxav5dLug6g0WgHUf4N8zqu8Mfqx04vJgGIUI9E3qQFYnZkIaNw2?=
 =?us-ascii?Q?Yd0JBRVocm5FqSq1DbAjJGcq4wJWBidtncrE9XUByhcMOEeAyfunRyX9udYR?=
 =?us-ascii?Q?CCBy+H2NEsUifMTeCFa/QzEvgOGuMtg23mYLZDGOGwXdNJQyQpBIOb++cdEg?=
 =?us-ascii?Q?5T/PPakuY74IzGlmmkwk7q+xd5jYuObCMsRFgGShwG1DP2LegtK57ebdBcmu?=
 =?us-ascii?Q?mWMjE0V24YL6Ax5ESffNGb1g9G1inPLA+AZAfEuBWlcnTTYZ3isGh/mF5jw+?=
 =?us-ascii?Q?Y7gPBR7Uv+lzhywDNpMD23iqi3A6Jl3hU4gsjRe0fa7NP9cFKUaQo+xLKORx?=
 =?us-ascii?Q?4u0UIerKhKK7OkAK7nY2gEhglJjA7s+EA2vFVxcYzGDWNPUBod55AUJpHWi8?=
 =?us-ascii?Q?V0dS5ltVD5TZmUfsShmHbO/9XPH5AKPtOGEu3//8/upJDaPyOz2ctefmKrRV?=
 =?us-ascii?Q?1CDB4RrsjvM0/UHXU5ifKO0r2nhQNGZXvSnLdwvkayc/WKF20xJRSDpK8o8N?=
 =?us-ascii?Q?lEN/22V8q2Ly8N5KFA/I6LmVkxr6ia7sSUBkV/ZC45ZRgVMra3xMTCagu2Ww?=
 =?us-ascii?Q?vjtqQL5y8t3BYgazVnUW+Jg/4snJuTkGaUwJxXBSGuCPfsJF+QXCPP3GgF9J?=
 =?us-ascii?Q?6jms9Xxy5HENdNVBOlMqf98F6dLysW0CEBUcnfyjLtIfjrAjkRVgjo8+shGJ?=
 =?us-ascii?Q?z8lybSCfvrf0xVX0n3btqgzx1VfJ7wWl0ze/PVNf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51285f6-552b-4851-61d2-08dcb7ba6eb8
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:57:33.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFyNUN1cHnLUJHL0JNgEY5rplvv/IlctvBtLTchBbtKx8aLHjKdbLeeWN1keA6H7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040

--=_MailMate_0E7B4A51-888F-40C5-8522-F7620D9C9FE7_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_F6BB45DA-7D87-4D82-B872-91B895940A9A_="


--=_MailMate_F6BB45DA-7D87-4D82-B872-91B895940A9A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 Aug 2024, at 10:36, Kefeng Wang wrote:

> On 2024/8/8 22:21, Zi Yan wrote:
>> On 8 Aug 2024, at 10:14, David Hildenbrand wrote:
>>
>>> On 08.08.24 16:13, Zi Yan wrote:
>>>> On 8 Aug 2024, at 4:22, David Hildenbrand wrote:
>>>>
>>>>> On 08.08.24 05:19, Baolin Wang wrote:
>>>>>>
>>>>>>
> ...
>>>>> Agreed, maybe we should simply handle that right away and replace t=
he "goto out;" users by "return 0;".
>>>>>
>>>>> Then, just copy the 3 LOC.
>>>>>
>>>>> For mm/memory.c that would be:
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 67496dc5064f..410ba50ca746 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_faul=
t *vmf)
>>>>>            if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>>>>>                   pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>> -               goto out;
>>>>> +               return 0;
>>>>>           }
>>>>>            pte =3D pte_modify(old_pte, vma->vm_page_prot);
>>>>> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_fa=
ult *vmf)
>>>>>                   vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf-=
>pmd,
>>>>>                                                  vmf->address, &vmf=
->ptl);
>>>>>                   if (unlikely(!vmf->pte))
>>>>> -                       goto out;
>>>>> +                       return 0;
>>>>>                   if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->o=
rig_pte))) {
>>>>>                           pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>> -                       goto out;
>>>>> +                       return 0;
>>>>>                   }
>>>>>                   goto out_map;
>>>>>           }
>>>>>    -out:
>>>>>           if (nid !=3D NUMA_NO_NODE)
>>>>>                   task_numa_fault(last_cpupid, nid, nr_pages, flags=
);
>>>>>           return 0;
>
> Maybe drop this part too,
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 410ba50ca746..07343c1469e0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5523,6 +5523,7 @@ static vm_fault_t do_numa_page(struct vm_fault *v=
mf)
>         if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>                 nid =3D target_nid;
>                 flags |=3D TNF_MIGRATED;
> +               goto out;
>         } else {
>                 flags |=3D TNF_MIGRATE_FAIL;
>                 vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> @@ -5533,12 +5534,8 @@ static vm_fault_t do_numa_page(struct vm_fault *=
vmf)
>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
>                         return 0;
>                 }
> -               goto out_map;
>         }
>
> -       if (nid !=3D NUMA_NO_NODE)
> -               task_numa_fault(last_cpupid, nid, nr_pages, flags);
> -       return 0;
>  out_map:
>         /*
>          * Make it present again, depending on how arch implements
> @@ -5551,6 +5548,7 @@ static vm_fault_t do_numa_page(struct vm_fault *v=
mf)
>                 numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf=
->pte,
>                                             writable);
>         pte_unmap_unlock(vmf->pte, vmf->ptl);
> +out:
>         if (nid !=3D NUMA_NO_NODE)
>                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
>         return 0;

Even better. Thanks. The updated fixup is attached.



Best Regards,
Yan, Zi

--=_MailMate_F6BB45DA-7D87-4D82-B872-91B895940A9A_=
Content-Disposition: attachment;
 filename=0001-fixup-mm-numa-no-task_numa_fault-call-if-page-table-.patch
Content-ID: <B2A004FA-B4BD-4CC6-969A-A9AD420AFF29@nvidia.com>
Content-Type: text/plain;
 name=0001-fixup-mm-numa-no-task_numa_fault-call-if-page-table-.patch
Content-Transfer-Encoding: quoted-printable

=46rom d761a4bb6cdf3277f1af1d129bf01583962c53b3 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 8 Aug 2024 10:18:42 -0400
Subject: [PATCH] fixup! mm/numa: no task_numa_fault() call if page table =
is
 changed

---
 mm/huge_memory.c | 18 +++++++-----------
 mm/memory.c      | 19 ++++++++-----------
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a3c018f2b554..1e22801a9d6e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1681,7 +1681,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *v=
mf)
 	vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		goto out;
+		return 0;
 	}
 =

 	pmd =3D pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1724,23 +1724,16 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault =
*vmf)
 	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		flags |=3D TNF_MIGRATED;
 		nid =3D target_nid;
+		goto out:
 	} else {
 		flags |=3D TNF_MIGRATE_FAIL;
 		vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
 		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 			spin_unlock(vmf->ptl);
-			goto out;
+			return 0;
 		}
-		goto out_map;
 	}
 =

-count_fault:
-	if (nid !=3D NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
-
-out:
-	return 0;
-
 out_map:
 	/* Restore the PMD */
 	pmd =3D pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1750,7 +1743,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *=
vmf)
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
-	goto count_fault;
+out:
+	if (nid !=3D NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
+	return 0;
 }
 =

 /*
diff --git a/mm/memory.c b/mm/memory.c
index 503d493263df..d9b1dff9dc57 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
 =

 	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		goto out;
+		return 0;
 	}
 =

 	pte =3D pte_modify(old_pte, vma->vm_page_prot);
@@ -5523,24 +5523,18 @@ static vm_fault_t do_numa_page(struct vm_fault *v=
mf)
 	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		nid =3D target_nid;
 		flags |=3D TNF_MIGRATED;
+		goto out;
 	} else {
 		flags |=3D TNF_MIGRATE_FAIL;
 		vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					       vmf->address, &vmf->ptl);
 		if (unlikely(!vmf->pte))
-			goto out;
+			return 0;
 		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			goto out;
+			return 0;
 		}
-		goto out_map;
 	}
-
-count_fault:
-	if (nid !=3D NUMA_NO_NODE)
-		task_numa_fault(last_cpupid, nid, nr_pages, flags);
-out:
-	return 0;
 out_map:
 	/*
 	 * Make it present again, depending on how arch implements
@@ -5553,7 +5547,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vm=
f)
 		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
 					    writable);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	goto count_fault;
+out:
+	if (nid !=3D NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+	return 0;
 }
 =

 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
-- =

2.43.0


--=_MailMate_F6BB45DA-7D87-4D82-B872-91B895940A9A_=--

--=_MailMate_0E7B4A51-888F-40C5-8522-F7620D9C9FE7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma03NoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKGU8P/0iJBhujJse98f90Nv923kaqTQq3/spIWZQc
epI0uC4tEJ/azwYOV8nWuT1D0qCcyn4xmefhNacnfzJD9BDW+HyVHLsjrfpnaSp4
fanSl7WgUQqNvNpZUQjt7yg9l25bNvOK0IG+PvhHZa3BELZNt41PQu3VL27XabrL
IezJLRN1uDbHwltJSIRa74ypU4fux6S9ETj/uUaKXskVe7qcg/Y0Xy0mcLkR6SGa
8+lAYAV0FlN2Kpiqn1umcaOIcmylH4IcIC38Lp4QQP5NhtFj1BLugH4OyQlTe3IL
s9VeZoqVKFASF+3HyJEjY0poHeNfY8Qdht6Ud/1QsUtbu/6+g0tYqvuhtxOlRC9H
1c2XclSfWDsV8MtRBCVSzMKNbwNFq4TvaPFGnffJ4AfwCNZis5Xbc6E4moUk89bL
tVIIMfdR8Sw/QX9aNkKDnwnZOzHq32S3TmqhTfJF2hKFkW7GrMwvi7u8AMtXGDpJ
jFdAJsPisxepnWwAvXmSSTplaHpOODuMlJ9PYOOv9wQlU0A8wISp1LC5uxPrRnVc
vyj5kJUcVF4KbVdjAKS2peZ8rHE5GaiRhLlYS9VmPxdQIAE1d1165cGYHolelor3
/N3yJXR+l42AjwqCIbdwwv/uV9BzLukt21vRb0r+8ha8Z42FebCAM4Waqk+8ER2i
nrY6xkb8
=wvfV
-----END PGP SIGNATURE-----

--=_MailMate_0E7B4A51-888F-40C5-8522-F7620D9C9FE7_=--

