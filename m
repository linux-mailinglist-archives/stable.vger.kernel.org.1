Return-Path: <stable+bounces-195179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C6AC6F4F0
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 15:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8F2212EDDE
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB2B35505F;
	Wed, 19 Nov 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LRLh/ZyO"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A6369985
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562611; cv=fail; b=fu59sbjSeTOSTsTeHXa+8lNx/s9XS1UHIX1HhiBN3arJ0zkAegssHCK9MSyjKSxKQuge7UVUqcEcTybQWa9MiZKVab3mFjdxAwvSrxi2qxwuIQ9pycwzTmDdK9mQGTVkESAZzGT8eu881KBwHJ5y80UA+2aDgLcIK0qq+feAvHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562611; c=relaxed/simple;
	bh=asvaKK77w1+3XGXslJPkxKfXaPvoZg4o522nC3qmYSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2FIrchFPZS2EuPn4OYTFzQcr6dAm4meFJcaJg9Wd4ghCS+IXzKyVqGzMokFFTAziacr4UUTs0mHhcNAV5b73+yckTv1xc3PHLZjitym8PdktaAbwKof5bP/QqdMcc5xKXe2Gu50xqVVlgQUE5uoW0XSDefuCPHzQA3AL5nJHY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LRLh/ZyO; arc=fail smtp.client-ip=52.101.52.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/cNx7K2f/i4LFpPVFbIFxI42RElqSwvjI+U75GjFbigv/nWHZUbZgkYxgGJm377raZHz3KXi/LjP/buVMs8w5kM5CiW7+ax495vaW3uMNlI25VwJG9DAx7Z0kYI2qmD+zywv72DDFpnZmrO0NPY+fnJXPvWAOEGIMn6e1dyBQG+kY5UWrvgsapwrUnm1Tbypw4IeR2+q+yrQBzuK8v3BmjaqtXdApPb+RtA9CSs/1IexDbARmddA9nA0cq2U5ysDwHDTei/HXeNy3QehV0uQYO+3QZuBnuNNpo3yQzTvuCEkboW+j01PWGMT1s69L53Zv9jqY6dWCP547hFEsFDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A1Nx1S14xNVno/7x2siV1UWPTRjVoHwJVwzTX7cosQ=;
 b=wtHPsFDkCx7b7aASBMAuYWayLhUHCQnk6dYaxg3UrUnMNhiO7JPAN8Q0KHIN2aDX8MglhFbH85ka9wY4UKD1hpKud52OJkisYArCbitPBwu4v5gXsXYlz9fsxL4psO96KoZ76TsGFDDtYr/SIMuRSbAC195UfCO85wj7COMrFbnpu/FjF991SDOJwcvgErV8EZ7GbSMvbjpDa0GWog6TEwJ/Mrla3NlDtMF9nf3r6/93kfpkGAneLoOf1kpfu4aNUZJvYX7P4t2FUBULhWltLffPDGZ5nei5rD/3RJJJ9q40Zn1M+aJnNIzHyBT4eEh/MNtM+Te2VgSr/DUmTZjipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A1Nx1S14xNVno/7x2siV1UWPTRjVoHwJVwzTX7cosQ=;
 b=LRLh/ZyOMhCqrFq2r6QLw3UbEko0yKft6zp9BR1i7UGlT/ux0xZyBH/b46Urx+pklW1eVl6S8nJCmAem8A5gX1WIzy23S9YMZ2dIfIDQ/GL/JJSQl7UVlIRK9J6GHWBiW8zWPcVdvcAzqSMx8igDBdW+vWr0vpzUghB81hgvux9vSlTBgQrODrWt+aR6qGQL1Oblt4sN6VPhyNx+MC1paowB1pgZTGNOl+SdZ1HnHjwyNja8+pU+ucHPrDNtrm0kekwsIyApC408pRUwXjJckzxnvQs/B8BQVsimJXuYE+ugbpNLnzk1LgvbfYa/N7QKFTeO+0Txk/g07AVJeF4/SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 14:30:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 14:30:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when splitting
 shmem folio in swap cache
Date: Wed, 19 Nov 2025 09:29:58 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <FA37F8FD-DDAB-43B0-9BEA-2AC25986767E@nvidia.com>
In-Reply-To: <4f9df538-f918-4036-b72c-3356a4fff81e@kernel.org>
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
 <20251119122325.cxolq3kalokhlvop@master>
 <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
 <950DEF53-2447-46FA-83D4-5D119C660521@nvidia.com>
 <4f9df538-f918-4036-b72c-3356a4fff81e@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: ec777dfe-6551-4baf-9957-08de277820b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXZgkDfpd/8g3GRrGCc/grwNIOSDGzCawparAOPuwC2Ax7Nt1ODPdRSRjRb4?=
 =?us-ascii?Q?up5sovOQ6GzGNlsv4pE8rmDKOjjkjhVXqiwMIisOHPL2R0baiXHGcjIqpJiA?=
 =?us-ascii?Q?ppvJX1qiOdrTgvTO/vJwWJ2CpSOBnO7y1N+xbPcYbc1QhC9n0RSR+tHfAuPt?=
 =?us-ascii?Q?FEFq4lkaBaNxnzo7smxrhIZJlS0dW/GUdGsYRbqzjosYp5pi0prrVOFx0TfV?=
 =?us-ascii?Q?cb9vDfT7aHVdE2XEcnPWBnAVjgkHVJ5+W7UwGMuSi3lDM9vrjskEwAocd2gq?=
 =?us-ascii?Q?YHRISun7HpqXI0YSSuIfNAppI/7CDqry1R/PJvB8lIU3dMUUusXdveU25RCY?=
 =?us-ascii?Q?+27fQ5wYVBE6s64ebHLqWfWydySXh3/jkTWLXz+hLL/lCaFdvKC9KGntWBak?=
 =?us-ascii?Q?wC7NH4EwmkmfBHAxvdXVmdnlJHXT1MSXP43JE7zqYDnYLDUzwgSMacwQaD6r?=
 =?us-ascii?Q?sw8QNRHuv1481gYL7L7q7TyWEdvNDlEy/zNYh5LpowUvCS//4PLu+i9e12Cr?=
 =?us-ascii?Q?0GJMCM8ntqGBC7si32RoE0uss2xh3REudpRRZThy5x1pwnZvHgjKXT6MNN8+?=
 =?us-ascii?Q?63rg9/W4XsELoGFv4PDXhTdpr5bckAgsXm/Q7AIVXNi/K0RCCaGLrhaoWlIT?=
 =?us-ascii?Q?4nL3cDDEC8ZA96Yfs+ECpn+1Yiz0esZ9P4k0ay2Thi0EOf5E7lVT2+BRY7Lo?=
 =?us-ascii?Q?Z5x/P0URFhVdVoiYyqFnSoApgTN7OeQrUVGXK3/rwu6K+7/iru1pKpruGWkX?=
 =?us-ascii?Q?nN77Bi3eECf9C0i1qZucxxk/+qCXnbRqmywSpA5/6OILfWWSDJ3Ptk0/IpgC?=
 =?us-ascii?Q?vI8+YwVZR3V7nJVqN6YD+GtzXMIep+E5WZRwOtbDpZnY0+6vVQQ9KgJ2RUIn?=
 =?us-ascii?Q?kuZxobdn7lv6rbb3VFRlnZD4fCznRxDiJ2AOHau1yS17bl5Y5eOzWgmlhmb7?=
 =?us-ascii?Q?P4plLQf4fTw4N/zse6hsAhpQr6GvazzLsYYO9JMAvrF+DP1sSkgAGyQ9GcQy?=
 =?us-ascii?Q?uTaa0TbDxkWmKHgtEy43T7NtNzJxhRlR0NQOcIW97lemNlTHqZlUmVsv76mx?=
 =?us-ascii?Q?odQw/ngXINCyujxqrBvAYZ5vi276W2O/jIY8Vo6Zsk2DSg9a41mphr8uJFrG?=
 =?us-ascii?Q?zK9FtcxcNzDwEQZl9EUXHAN9KNQJq8DWesz6Flw2LSMQ9s0yrreULXCXr1EW?=
 =?us-ascii?Q?J8JwVox11Db3QMzJAg2G/qO3Bjx2HF9BrIWZqq1Hl5jDrj0yxysXmT5SDic7?=
 =?us-ascii?Q?yeVqNNCG/Rqx4726tcXsmAsZLFt7y+3fYEWUmGFRxUlPe7PRYE218AV3RrTH?=
 =?us-ascii?Q?ovfnTWh0eqJwRA1Hc0mEH/1BPmQE6x5jpMgx3VoMDcc41onrM4VqNvlvQiZ8?=
 =?us-ascii?Q?YsNxBf9/txkIBfFKEuJLT+aNOnuV8+pHEUtySmuq4gRYAkW/S1s6cgTrTWQv?=
 =?us-ascii?Q?hPyE8h92zQwsRwWMtX9DNnFFCYlnLIQZLnPCTZPm0NOkAAi0OkFQfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hE59eraoXW9dwLlVoOPgTtuj6t8LixbxaYjpyyJrDQ05UnzPA9awWzGQbkze?=
 =?us-ascii?Q?7WvhguLZnP15/l+OBuUsdJOmBIoBjEPM+WlmGgRUWan3DlrbneBhAQM8rNuA?=
 =?us-ascii?Q?B0QjUbLGn2q5YNyn0nQt9h4wbpwR2LoU1qj8LkkRJ597CYSp99S1RAc0zrh8?=
 =?us-ascii?Q?NWgK3NLJW3oyhxJP+u4fEcW2CCgJGH09eu8aoCCemqRJOmgD/9fLLozyCy/1?=
 =?us-ascii?Q?GRirp7/sVU1B8sD31fDv405vup7ouJcmEdXhZXZWtQ2Kr1gGzCtXQxcdfu6v?=
 =?us-ascii?Q?Hgvgh47helB36EnScN9J56+wV+zD3SX//1w4Jn7f0x4kK1tFieF1Jq1i9j6j?=
 =?us-ascii?Q?43fZ7RdIbTznNrn1cgNucHnRT3VnLOpELELP0CLjz/BFkElJsrQTkxlQQZ7s?=
 =?us-ascii?Q?z1a5HoAH+z4xRgU0oKbB8PeKn0+RkK634XksATj9EkMrMHZrO2jbQpdMv9Hs?=
 =?us-ascii?Q?3nN5hIMHIhsAIyXFZsx+tgEdulAI/m08RajGW8iz43SYT4P468P/fHLpkZH9?=
 =?us-ascii?Q?79yBzcnO5e5fdI9Jo+C2RzLEL88tx0qZ9pWdyPC5eRAmFvDerdPRkOmhZBXT?=
 =?us-ascii?Q?iONt+vhyjji1Hwv98eV3orVlVZywy4R1Fe+VvaBZkMWjmR/S/5JpPI6mQJZ+?=
 =?us-ascii?Q?YYipnBevakJpeAaSdR8I+tQrhxQGMW12YAcKQ/Dr2kC9H69mDJffYSzvgbO+?=
 =?us-ascii?Q?F1EdGckizS7BOYFdSuD1M580vH0EzIB2b7kzN+kOTQpM96MXMHz8rACJNQV5?=
 =?us-ascii?Q?sORUYViw5TEf6p7PvpPXquFBrm3BOTC5lvWKtbbeFVFUkLFcP6limuz78nAE?=
 =?us-ascii?Q?K4cwFmaMRgyI/8Iq+NQau5ix8itho/vXfumOhcxVV0heSBnBr0v55VFrrWPK?=
 =?us-ascii?Q?fFbfBuXsuVhSOlDRhraCuxAYDZVbJaeEiKZk13QqXZZVwTQwGDGQdOJUc5hf?=
 =?us-ascii?Q?V3i4tISagulC3Vh1y2u3KCFWjKWjIzYpcW+wfLt7CF8NslFQYuSLf5DO3jZv?=
 =?us-ascii?Q?rzS2Kw4+cDbtIEnR3TzqQ5cQ41o21Amr5UjZ+J8dkGce+3QUl6L7dV1cCWZs?=
 =?us-ascii?Q?Ydzr1nqPdJqyyZDJTstoiBkOt0Ahcu8wZUROhUKGhGvmza0TeT0b7tMIdRgM?=
 =?us-ascii?Q?eQCiJEI+cjLvkmLuF5Pgov86OPy4ftTo75NeVY1NStf3weA3iE2WIjRUpy5x?=
 =?us-ascii?Q?30wn+ICm//LnQKGDKhJxRtHBsNa2WdG2VchJcxTTUi7zGYly7AOptMa6XoQY?=
 =?us-ascii?Q?Xe2oV4RWbzx0UdUxz7ODQDJnqBVylgweNozOLxTq0hiUEmAmzTvVeQGNJlxR?=
 =?us-ascii?Q?p586yVUgYxZo/wej+OXysRQ7lgToA49qGsm0MHlYuNiFl0aCQnUeEbJ6y1I6?=
 =?us-ascii?Q?zFu3q8z6dUXIwjKbZ5bnuueaxkbm3pRe48Uu98LzdrNdhIiQ02Ft/C6GuGzd?=
 =?us-ascii?Q?ANh6+X//xmcSAhd3DnvZJZe6vdf4KdinsF6d3kpgYczzYrITQHVENqaG8mKd?=
 =?us-ascii?Q?6Cf1xoxcZRIlNWf8xjxMCRutpScuy6kWfdi0AVH8H5vjALu624zXwHeoMIg9?=
 =?us-ascii?Q?nznkxXwpvzssuKu86kPKBJ6p99ZRLvn9i63D/yKv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec777dfe-6551-4baf-9957-08de277820b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:30:03.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2d22TVEeGUOOipAnw4AEHjTsWDusVpSLMBPtYQOof4Hklnx024USuHY4iEWNbSSx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058

On 19 Nov 2025, at 9:09, David Hildenbrand (Red Hat) wrote:

> On 19.11.25 14:08, Zi Yan wrote:
>> On 19 Nov 2025, at 7:54, David Hildenbrand (Red Hat) wrote:
>>
>>>>
>>>>> So I think we should try to keep truncation return -EBUSY. For the =
shmem
>>>>> case, I think it's ok to return -EINVAL. I guess we can identify su=
ch folios
>>>>> by checking for folio_test_swapcache().
>>>>>
>>>>
>>>> Hmm... Don't get how to do this nicely.
>>>>
>>>> Looks we can't do it in folio_split_supported().
>>>>
>>>> Or change folio_split_supported() return error code directly?
>>>
>>>
>>> On upstream, I would do something like the following (untested):
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2f2a521e5d683..33fc3590867e2 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3524,6 +3524,9 @@ bool non_uniform_split_supported(struct folio *=
folio, unsigned int new_order,
>>>                                  "Cannot split to order-1 folio");
>>>                  if (new_order =3D=3D 1)
>>>                          return false;
>>> +       } else if (folio_test_swapcache(folio)) {
>>> +               /* TODO: support shmem folios that are in the swapcac=
he. */
>>> +               return false;
>>>          } else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>>              !mapping_large_folio_support(folio->mapping)) {
>>>                  /*
>>> @@ -3556,6 +3559,9 @@ bool uniform_split_supported(struct folio *foli=
o, unsigned int new_order,
>>>                                  "Cannot split to order-1 folio");
>>>                  if (new_order =3D=3D 1)
>>>                          return false;
>>> +       } else if (folio_test_swapcache(folio)) {
>>> +               /* TODO: support shmem folios that are in the swapcac=
he. */
>>> +               return false;
>> You are splitting the truncate case into shmem one and page cache one.=

>> This is only for shmem in the swap cache and ...
>>
>>>          } else  if (new_order) {
>>>                  if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>>                      !mapping_large_folio_support(folio->mapping)) {
>>> @@ -3619,6 +3625,15 @@ static int __folio_split(struct folio *folio, =
unsigned int new_order,
>>>          if (folio !=3D page_folio(split_at) || folio !=3D page_folio=
(lock_at))
>>>                  return -EINVAL;
>>>   +       /*
>>> +        * Folios that just got truncated cannot get split. Signal to=
 the
>>> +        * caller that there was a race.
>>> +        *
>>> +        * TODO: support shmem folios that are in the swapcache.
>>
>> this is for page cache one. So this TODO is not needed.
>
> I added the TODO because we'd like to detect truncation there as well I=
 think. Hm.

OK, got it. Here you mean shmem in the swapcache is not checked and
when shmem in the swapcache is supported, folio_test_swapcache() can be r=
emoved
here along with the TODO. Now it makes sense.

>>
>>> +        */
>>> +       if (!is_anon && !folio->mapping && !folio_test_swapcache(foli=
o))
>>> +               return -EBUSY;
>>> +
>
> Given folio_test_swapcache() might have false positives,
> I assume we'd need a
>
> 	folio_test_swapbacked() && folio_test_swapcache(folio)
>
> To detect large large shmem folios in the swapcache in all cases here.
>
> Something like the following would hopefully do:
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2f2a521e5d683..57aab66bedbea 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3515,6 +3515,13 @@ static int __split_unmapped_folio(struct folio *=
folio, int new_order,
>         return ret;
>  }
>  +static bool folio_test_shmem_swapcache(struct folio *folio)
> +{
> +       VM_WARN_ON_ONCE_FOLIO(folio_test_anon(folio), folio);
> +       /* These folios do not have folio->mapping set. */
> +       return folio_test_swapbacked(folio) && folio_test_swapcache(fol=
io);
> +}
> +
>  bool non_uniform_split_supported(struct folio *folio, unsigned int new=
_order,
>                 bool warns)
>  {
> @@ -3524,6 +3531,9 @@ bool non_uniform_split_supported(struct folio *fo=
lio, unsigned int new_order,
>                                 "Cannot split to order-1 folio");
>                 if (new_order =3D=3D 1)
>                         return false;
> +       } else if (folio_test_shmem_swapcache(folio)) {
> +               /* TODO: support shmem folios that are in the swapcache=
=2E */
> +               return false;

With this, truncated shmem returns -EINVALID instead of -EBUSY now.
Can s390_wiggle_split_folio() such folios?

>         } else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>             !mapping_large_folio_support(folio->mapping)) {
>                 /*
> @@ -3556,6 +3566,9 @@ bool uniform_split_supported(struct folio *folio,=
 unsigned int new_order,
>                                 "Cannot split to order-1 folio");
>                 if (new_order =3D=3D 1)
>                         return false;
> +       } else if (folio_test_shmem_swapcache(folio)) {
> +               /* TODO: support shmem folios that are in the swapcache=
=2E */
> +               return false;
>         } else  if (new_order) {
>                 if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>                     !mapping_large_folio_support(folio->mapping)) {
> @@ -3619,6 +3632,13 @@ static int __folio_split(struct folio *folio, un=
signed int new_order,
>         if (folio !=3D page_folio(split_at) || folio !=3D page_folio(lo=
ck_at))
>                 return -EINVAL;
>  +       /*
> +        * Folios that just got truncated cannot get split. Signal to t=
he
> +        * caller that there was a race.
> +        */
> +       if (!is_anon && !folio->mapping && !folio_test_shmem_swapcache(=
folio))
> +               return -EBUSY;
> +
>         if (new_order >=3D folio_order(folio))
>                 return -EINVAL;
>  @@ -3659,17 +3679,7 @@ static int __folio_split(struct folio *folio, u=
nsigned int new_order,
>                 gfp_t gfp;
>                  mapping =3D folio->mapping;
> -
> -               /* Truncated ? */
> -               /*
> -                * TODO: add support for large shmem folio in swap cach=
e.
> -                * When shmem is in swap cache, mapping is NULL and
> -                * folio_test_swapcache() is true.
> -                */
> -               if (!mapping) {
> -                       ret =3D -EBUSY;
> -                       goto out;
> -               }
> +               VM_WARN_ON_ONCE_FOLIO(!mapping, folio);
>                  min_order =3D mapping_min_folio_order(folio->mapping);=

>                 if (new_order < min_order) {
>

I think it works if there is no impact on s390_wiggle_split_folio().
It also clarifies two truncated cases.

For backporting, maybe just move "if (!mapping)" up for simplicity?

>>>>
>>>>>
>>>>> Probably worth mentioning that this was identified by code inspecti=
on?
>>>>>
>>>>
>>>> Agree.
>>>>
>>>>>>
>>>>>> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order =
pages")
>>>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>> Cc: <stable@vger.kernel.org>
>>>>>
>>>>> Hmm, what would this patch look like when based on current upstream=
? We'd
>>>>> likely want to get that upstream asap.
>>>>>
>>>>
>>>> This depends whether we want it on top of [1].
>>>>
>>>> Current upstream doesn't have it [1] and need to fix it in two place=
s.
>>>>
>>>> Andrew mention prefer a fixup version in [2].
>>>>
>>>> [1]: lkml.kernel.org/r/20251106034155.21398-1-richard.weiyang@gmail.=
com
>>>> [2]: lkml.kernel.org/r/20251118140658.9078de6aab719b2308996387@linux=
-foundation.org
>>>
>>> As we will want to backport this patch, likely we want to have it app=
ly on current master.
>>>
>>> Bur Andrew can comment what he prefers in this case of a stable fix.
>>
>> That could mess up with mm-new tree[1] based on Andrew's recent feedba=
ck.
>
> Right, a similar fix could be had against mm-new.
>
> -- =

> Cheers
>
> David


--
Best Regards,
Yan, Zi

