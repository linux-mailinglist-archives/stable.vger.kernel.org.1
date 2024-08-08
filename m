Return-Path: <stable+bounces-66061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DFD94C0A7
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 17:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BBB1F21967
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD418F2D3;
	Thu,  8 Aug 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jigwbW6K"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6A18F2CF;
	Thu,  8 Aug 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129984; cv=fail; b=rmBqU/LG5ngwL9rBI3USSdapK+CPYPIhiyAi9qC37LuFZtSnlPUjEvyyxGRz34dYSa0NyRcZCWGEPYSn39NZbuHkyrC22Y+txFz902A/mHXAIqs5dkmCT93je6edJqMzJPt7TTK+u5nXn/2L/R52xMKregSWVuTZIP5tw3ZlpCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129984; c=relaxed/simple;
	bh=BkffYbMsaCOLZ/2v42jLYqo8dGGUAWTP0Q7bCbOrhzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L30lbSGLN4EKJ3IhA0MAkAwbtbwEUkaMfewRcw4Jvu0ks1RgpCK2x0s/BUuIL5q/6gDDDWhzR97E6UNM+GP0CdaL6/F+dayCp45bTHJ45z/xpT0pWL4CeBPC6BIOmczJhX8ZQQa7SSW0HgTGhEwxQgdr7Kgn0KIcvyzYsa429Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jigwbW6K; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2PJxcPvbjEV07qKw/GrmX7b0NL/AvhyCIeGoA3hgFGourYlP/3Rsy1be8E+c/W4U9HH5hWVuw0a8r973IuCqbQ2L8Ujh4iuSzTCqoH/jz6ZgQLJsCNffyWARbmS2TAXKzDbGXEKZtS/htup16MskQVhjUMpZ17HS7dxpULz1+Gvv8uEYrr8DA6FShcxrhdrYWCsGIw96L2U+WAzFNsxKmDLCyvfmkq17W/ukfERfF1fCJyOCebtWz4d6t3VmvjZtGQ0kbBUxn2caQmW82Pu5bXWRtbApyLGn5shKycoNl4qHz6GRSrWCfGKNG464QrL4wL6DjKQgPKmcqjUdMVo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5El8tZWDS8+eHzhb8zYbn0/0VsdhiDkl4YaMVVZ5/qc=;
 b=pgDm1reKciqmt5ISv1JQTF5+1XqDifNEIhCnlp+Mshnm0iJbs0X9N+pPR2fLdIAA2vQZi7daoYyk8WoXkGxJ2lPBqIY5W/MP9eFcImr9OkKh0veWpcpTrleg/acmMvSrLfgllRDe6jfwzZovvmuntWCZwRzxaImaxHeZmVezYnw5NA7yy+wz3PlQsyYs5sXQy1jnvpIJcgDQnDoJW1ySqjZRDZxFmkG2b9d92aynyjIj0zvP2r6WJ+Y0s4b/Pbd/zkXJCtMAmuhyAGzsHooDCUqEVhTIbMlcPR21VnmYKTXC8Oxr3pFUrAJG/Ht/b1eWaDjhtp/UodUeQgVAM404DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5El8tZWDS8+eHzhb8zYbn0/0VsdhiDkl4YaMVVZ5/qc=;
 b=jigwbW6K3YGUG0FKYkYeJlP5x0vtt+bxkf4tDPyqfpJjReaXZmZzEyvcy3Ut8c53GHbmoHDra1VtLuScXBNVAZMlRf/L+3/nW16GvB5KUDCgW/TUOLCibkYzYk1e1MLI80KaRLO5gUsXn8fFHnjsOpBYjv/Xx37QACpxFDw2+H+TG7Fb6ObZYCIQpP0dhk3X6AFHtB/vZdXldfRSizulKNa5M4joG8CE5u0+UVnUuzO0cPJ7DrtbPQ+qPkIuWgP2pNVCtCglfM1DXq+GzYe/PQQ8OyRzooURvnz0gHbKZJaohhD1LzgJyAyvn2hyZk3b7ImNiUn0b0GAyE70qvIo2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.33; Thu, 8 Aug
 2024 15:12:58 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 15:12:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
Date: Thu, 08 Aug 2024 11:12:54 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <819987AD-273B-4AFB-9447-39F32664EBDE@nvidia.com>
In-Reply-To: <6447AB19-CC4D-40C2-94F5-C39DE132E1D6@nvidia.com>
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
 <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
 <052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
 <8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
 <b0b94a65-51f1-459e-879f-696baba85399@huawei.com>
 <6447AB19-CC4D-40C2-94F5-C39DE132E1D6@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_473F7B1E-360E-4679-9AD5-B602A0B9770C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:208:fc::30) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 5383aa71-2594-4121-4581-08dcb7bc95e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?it0ELEpfDWV19URrERq/++U0y3MoofKY9cJPx9OnXQ9P7M04AEYQBiOHMpiU?=
 =?us-ascii?Q?3lI9TZ8Vhc87KbIuEs3no+u+xTxkjA/IYLxTfiN1u2glgYtcrFP2+HXIlhj7?=
 =?us-ascii?Q?I5/kuhWT83UEewiL7pJvNgdR22UaiGIbJzBLLtZwYtUWb/HbDvjcuFxgLRUq?=
 =?us-ascii?Q?gtTk7JQTPkPmlb8YuxGH4nuAxofwM86R2UvtYaIt/uP8n3fod1BLDMY8LqEU?=
 =?us-ascii?Q?b9dWryic6GevZf52TkTDXSXkqr0pNjFpn+rmj105sQOl7p4br43iaPvvIdu2?=
 =?us-ascii?Q?8FOdOXk048Pqx2r/QnrSRFhskmq5M/JBCtKld5nnEk67JWI3Vs7uui+KIDs1?=
 =?us-ascii?Q?9xVjPCicCBGadpyCGPuqrK/j9olspYK0TFRjdCESUXdFY8mPVk6wQyT5ueBT?=
 =?us-ascii?Q?C126G3jSltGLG57ARKN6yt0HvR9CcBFtM+kTpT1YIdiZilHJ25RgsMCCtwj/?=
 =?us-ascii?Q?2tTm6WSSnCGepozx2dtLKsnjItAv3zQOX3EVOIi7v1HkBW0ewZEI3RudUK6k?=
 =?us-ascii?Q?rnwrTlYoBN83fTZl+RqAZTG7bOsuNralS3XA5GmbD3JcLDmYgVkZI0mLw4fP?=
 =?us-ascii?Q?X9ajJuHQk9OMVo0CIZb0EdAbMKAbJ0RM86uveVUCuvstJA3AurqB6hIhgKvL?=
 =?us-ascii?Q?b8acDHfJT4XR5//PtzYP5IjymFXamOGVvOHAYPbDBHd0dzla9M8cqZUOgTXv?=
 =?us-ascii?Q?PS8L8S6Q2mp4PcxCpIzGOXYftJ/JzzPKLmlw97R2Izf+jct73yXiOyG1Mor9?=
 =?us-ascii?Q?r/PHgeoiQSHQ/WhvKfOSH/uP3Z8cgJRtywAwB6yp70HjdBDrKc5X1Fhomdjk?=
 =?us-ascii?Q?5TDAEDUdNE07ldi7nOErLdxO1FABtXKTjvyVWkW/l12sauqDe3kCT8/6QX2L?=
 =?us-ascii?Q?qzXD6jhaM5Utf4VRSoQUoaeMnHW9VojslX7uBaDScuZ17/9u1dBr90ms5mbT?=
 =?us-ascii?Q?rV4CwxXj44HZ7+70H45Ri+ZWyWcRjHbil8KUlytpSqzcMQRQflm7iP9BRyzt?=
 =?us-ascii?Q?X6PhqeJy/GijRvAuCsaQ3oJpyD/FVkI4v0fWtWS+DWPwgMzSJZrxH1olrKd4?=
 =?us-ascii?Q?TJYS+vDxcbeCp0oXKbPHJD6MoiCegodtdxuAQyN/12wzHo5DyD8TPrqb1Ofv?=
 =?us-ascii?Q?vZqg4l4tVeN6pBwZNRFZqsrf4uZ9X4065/wtpOOOj9k0dGUtM0q61C6OdXvb?=
 =?us-ascii?Q?iPy0GASRzDkq6Va7gkcmp2OFN5DLua8rhGr9Ruw8K5gTrkcUV2V0wHnZukzp?=
 =?us-ascii?Q?Cpn/ubFE9EoncUl3BgNrbKjFk0sK2vIk+ejUKr1YqpK4IRyme2KH4tEyJEi0?=
 =?us-ascii?Q?ETSZP5U21tVuIyiN7Kanr9RIjrCC2sCpwjkuipKDm5Ds3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QqS1HwKWE+R2Y7WWQjCpV3J9QyIhrdd2Pr8tdRQ7C1RD60Otva0AM0aJS+km?=
 =?us-ascii?Q?2U1nocHloIpwzfDuMjDoiy+wkAn8He09g0I2aV/tfCXmh0a13r/skVUmAOFe?=
 =?us-ascii?Q?SRfZi51eeNf/6E19paW4bZBJZh9U1N6aAjrPwQ3bUp4TKOXNMs13G3BVwh1T?=
 =?us-ascii?Q?IKqQGK1lB3CpVwGqQNDJ5BwXuVzL+54bbwTXhEYvg4otw7fZllbAX+iTvyqj?=
 =?us-ascii?Q?xv0VFgXN8AtCVhGCYOgLvR9VbL9nJ/72ivH99EhBCfyJwsoEl0dVUviKinDx?=
 =?us-ascii?Q?5LKs+jfvNkq9l5iDHNkaMsJhBybWl4QumOA1PaBx+5MlTYUUiDJ8kEH+GxEL?=
 =?us-ascii?Q?KVTN62TU4blXOQ0qy3FTrrdUp31z4DeflJ+chTIfxbv/PirJz0rReHfTcM4A?=
 =?us-ascii?Q?Bc1BpQ6YX7wGjz0WtW3CuPH744oFdXhP6ZC/S75aQIwOjTPsoDLymU1qb9AG?=
 =?us-ascii?Q?iCtKZB41RmWobGtZruncBo2X9jvBoNGVsGUZ1p2fzM2x7NSYdtwgulMmZ7NM?=
 =?us-ascii?Q?9v0oJVKnnxUkuERzxKNKZ8pauabNyKfGW+rKH48AMRYFLj02ybrvvRWAs+u3?=
 =?us-ascii?Q?0Lr+XwzoLGAMMm2br2Jr5ZKzg7urpTJqaR8Ea8Zwa5cLmbyXjSD1Pp5pVC0o?=
 =?us-ascii?Q?77fFLsK4qMHQADLjRYchUYDVP+iM82z/j5nM1O1QReEwljuh2/0f10yJAfT1?=
 =?us-ascii?Q?MT4aZJIvULftTdDOEXF/iZwOJwKPxGgcWXDuMptlQwQaJewPV59/dV3yu236?=
 =?us-ascii?Q?ywgvzICzJzen+m1coMX2S9H4nIZQg4pshRwO7MjG0pD6eMwxRa5+nM+aXKQC?=
 =?us-ascii?Q?AvnlJpkIFj2aWPOo2x2Xo/0yQ2h5e2IeqtWD93RSzgczB/nmgdJyWwdbJe3a?=
 =?us-ascii?Q?YCFkksbYg5rfsYYONJ5uS9yt4xC23mN+sIcJw99GMF8U4q4N45Yj6dZWAQZv?=
 =?us-ascii?Q?yQR5ir2k6QNtkTnQi6Cdlb+M6dCEbXcZQgiyLOdNmOZ9shNGFi2JEC+F/XmB?=
 =?us-ascii?Q?lFz93ynIFeDplq3jnO2jU0aIIJswcxLLD/5FEwE4vKBB+1PVHmy6nj682jL8?=
 =?us-ascii?Q?JONWsVc6p3fbBwLU58RB4RpkBRN4/Hx/Xr/iol4xpO5SRDBcI19eHdO8v1OS?=
 =?us-ascii?Q?2k/BvpFSmOmAPdHgj3PoHaBt2GoW1PUaKChVV6nq/cjuyKwYgOOHWEAmhzYI?=
 =?us-ascii?Q?WgpFsblNXBAFum6GIaCbuWYsXwO4eP8nAf0xbryZkyBi5wJPvP9zVcFjYJuI?=
 =?us-ascii?Q?Iwv5C0irvyRUvug7E9CcSW9q9uT0ENu20ku6dJ3t+p/c5YD57JfhYHjt6fbE?=
 =?us-ascii?Q?dwLgIczHvXBEt+Ou8cJizSPVXF8FUstCRg1iS6ZwuNAKgTrpt0N/K7nmVQDe?=
 =?us-ascii?Q?OcyBfhpRWoxrx4+WEBK8kmqYLBs3pK3OSwVSiuBKGQv5Z2KkKVrFsa++fz46?=
 =?us-ascii?Q?BfxSwNWq5xGhcDY0SvKIDYBTpq5KNgF0w6mP9c1JipVMY1UJ40/rLu/KuKn0?=
 =?us-ascii?Q?IP3M/vJ57IEem/vv3q8KAk3PuVByAA52UCMcxvc8IJi5J2QV2fLjdh++eExC?=
 =?us-ascii?Q?MtUC42H+phRiSo9GX17Mh3vS0NH1WxkFBAhm5cq4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5383aa71-2594-4121-4581-08dcb7bc95e4
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 15:12:57.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eU/ryagp+BxWLQf73JYd3wQSwElDF8V3x/Koe+6AWQbFtNBAeGIIbyINroYFov1x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990

--=_MailMate_473F7B1E-360E-4679-9AD5-B602A0B9770C_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_6830DC5F-D16D-4DF3-8B2A-B5AA7286B356_="


--=_MailMate_6830DC5F-D16D-4DF3-8B2A-B5AA7286B356_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 Aug 2024, at 10:57, Zi Yan wrote:

> On 8 Aug 2024, at 10:36, Kefeng Wang wrote:
>
>> On 2024/8/8 22:21, Zi Yan wrote:
>>> On 8 Aug 2024, at 10:14, David Hildenbrand wrote:
>>>
>>>> On 08.08.24 16:13, Zi Yan wrote:
>>>>> On 8 Aug 2024, at 4:22, David Hildenbrand wrote:
>>>>>
>>>>>> On 08.08.24 05:19, Baolin Wang wrote:
>>>>>>>
>>>>>>>
>> ...
>>>>>> Agreed, maybe we should simply handle that right away and replace =
the "goto out;" users by "return 0;".
>>>>>>
>>>>>> Then, just copy the 3 LOC.
>>>>>>
>>>>>> For mm/memory.c that would be:
>>>>>>
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index 67496dc5064f..410ba50ca746 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fau=
lt *vmf)
>>>>>>            if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>>>>>>                   pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>> -               goto out;
>>>>>> +               return 0;
>>>>>>           }
>>>>>>            pte =3D pte_modify(old_pte, vma->vm_page_prot);
>>>>>> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_f=
ault *vmf)
>>>>>>                   vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf=
->pmd,
>>>>>>                                                  vmf->address, &vm=
f->ptl);
>>>>>>                   if (unlikely(!vmf->pte))
>>>>>> -                       goto out;
>>>>>> +                       return 0;
>>>>>>                   if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->=
orig_pte))) {
>>>>>>                           pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>> -                       goto out;
>>>>>> +                       return 0;
>>>>>>                   }
>>>>>>                   goto out_map;
>>>>>>           }
>>>>>>    -out:
>>>>>>           if (nid !=3D NUMA_NO_NODE)
>>>>>>                   task_numa_fault(last_cpupid, nid, nr_pages, flag=
s);
>>>>>>           return 0;
>>
>> Maybe drop this part too,
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 410ba50ca746..07343c1469e0 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5523,6 +5523,7 @@ static vm_fault_t do_numa_page(struct vm_fault *=
vmf)
>>         if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>                 nid =3D target_nid;
>>                 flags |=3D TNF_MIGRATED;
>> +               goto out;
>>         } else {
>>                 flags |=3D TNF_MIGRATE_FAIL;
>>                 vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,=

>> @@ -5533,12 +5534,8 @@ static vm_fault_t do_numa_page(struct vm_fault =
*vmf)
>>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
>>                         return 0;
>>                 }
>> -               goto out_map;
>>         }
>>
>> -       if (nid !=3D NUMA_NO_NODE)
>> -               task_numa_fault(last_cpupid, nid, nr_pages, flags);
>> -       return 0;
>>  out_map:
>>         /*
>>          * Make it present again, depending on how arch implements
>> @@ -5551,6 +5548,7 @@ static vm_fault_t do_numa_page(struct vm_fault *=
vmf)
>>                 numa_rebuild_single_mapping(vmf, vma, vmf->address, vm=
f->pte,
>>                                             writable);
>>         pte_unmap_unlock(vmf->pte, vmf->ptl);
>> +out:
>>         if (nid !=3D NUMA_NO_NODE)
>>                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>         return 0;
>
> Even better. Thanks. The updated fixup is attached.
Update the fixup, if Andrew wants to fold it in instead of a resend, agai=
n to fix a typo causing compilation failure.

Best Regards,
Yan, Zi

--=_MailMate_6830DC5F-D16D-4DF3-8B2A-B5AA7286B356_=
Content-Disposition: attachment;
 filename=0001-fixup-mm-numa-no-task_numa_fault-call-if-page-table-.patch
Content-ID: <0C90E745-3609-43D3-A8DE-6FB0760B4E56@nvidia.com>
Content-Type: text/plain;
 name=0001-fixup-mm-numa-no-task_numa_fault-call-if-page-table-.patch
Content-Transfer-Encoding: quoted-printable

=46rom b42f0e90ed0b4117139cf66de2d6f83e3d8bcf8d Mon Sep 17 00:00:00 2001
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
index a3c018f2b554..4e4364a17e6d 100644
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
+		goto out;
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


--=_MailMate_6830DC5F-D16D-4DF3-8B2A-B5AA7286B356_=--

--=_MailMate_473F7B1E-360E-4679-9AD5-B602A0B9770C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma04HYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKdEsP/Ag/5HtDcp/nHNcYmliTEMbAcfLoBKabL1x0
BKucnT+XNDxiG/58u0s9+0cN0PJ8DD6EBV9b1cKPbtoBPMQHe0IX8G62MCJmhfdH
GAAFWvm4aK+DowEabcjqAGnnPH683dQik3AJJG1RySwngWoTsBovYroXCHN+pv+a
qFL+3zzXAyFDdhi9uuS/hKARTazBtqBqvDEmuDhJS6q6FSd8BvFjU0znzmC6cL+z
Elkm492TqrLJecdaib8IkJaMV0vwq2r+RrKau3BRywYL5qKXdTF5+QOpc4KPqxwr
m6LB7ksEYTwrWVgAQCw+U4nIQDpMxkc7fK21Pjg3/BXRWsjqSXXzpfgyRGJ2Q/Nc
iQjEoOoNCnfpoVl/ocBkJ+jCo94UHI0aRG0nebKCjYno00MSmGF1GzNLbyWkZt0g
aMnzkHBTcw/VyqiyT3wGIqCxes11Mfm3M1flGyxll/3iAQm2+fXquM5lrFx0AVQN
wFapvt5evwczcx/QWoZ/1SU69uikGonncg1zkceo8yl2vKbr9Fad6mjUIM8+vhXT
/jQ5fC1Gtck+7J48/PYiHNrBIk7yaRBjiLvnagac5piky3do13zd2dooHrNn3Xu6
rNhYEWcHOUbSXvhjmOTbq4rveJ6iSotw5pa6P+Q0imOnDzt9c+m6NjINc/fcAdww
nWxfaHBg
=A2nN
-----END PGP SIGNATURE-----

--=_MailMate_473F7B1E-360E-4679-9AD5-B602A0B9770C_=--

