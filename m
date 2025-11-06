Return-Path: <stable+bounces-192557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F6C38754
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 01:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E013A57F2
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D61940A1;
	Thu,  6 Nov 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qzlFUq7e"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E818872A;
	Thu,  6 Nov 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388396; cv=fail; b=FSMCaFq3vSeWSmj0PFgEuFa3JteWK0hyKxJ+2kHuzOAmS+wXi5JXqUw42+b+wMWOOGc9HGSsLtdhluCRRoVMXxio31XuD+cG6+o73uvUFhffDCOgQ253KUjCz9gWH9JVvQDGUxeFaCZOVJEWOLLLw8bSndJ64MeITQJWV8Rk4NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388396; c=relaxed/simple;
	bh=r4ntPR3bNpe3RBTssep8ZpQGXVvuHVPuowPmLw46gsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WKGp84de900hOXHkjolJJftPLapAUZWryv8vPC5PTaRfE7jL7EKwNpUq47hx3pvgW0g4eFG5Oo7Y9JjStsEOS7nyhS3ZGZjGKqCaqdx3eyKWaiiPzh1qlm277cARkTdQn/qX+Lswn4wVI+brsfshFCTNlrx2+sQnvmu5i0PYfkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qzlFUq7e; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hejDqzok+1x9mi/mfDnuayv75PHOI/pWxBoXj8FKOVcef0PuZVJKEqNjA7siV086gxaCYNZdq6C6ooNMcy9Q+s7nXuFNXbMWehtEPmaAlW+JhoV5j+zH5wZkXiNTvCtVONP7TeZxzQUhZ7QOLwnZfFAoKVSSLEfFg8DEZ8x6nAKI7nOI4oy9sebbBm7oHI7om6syyYcibbi4E99BhL+QXj7Y7dtZ6znMf9A7ecLpw8ncesU5Nr6WRIHkjkdWxUxr8zpthXGrRBT/TwPd/X7Q1L+ZTEiiHoaVdPKp/aAUhcX6LTMsJFfJUeWOzMqnKFaUIKnW7Cs7QMxgJgoDFdaZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v5ft7yKs6ph5QIJJP6+oJvJtID6GCAcYQK6qmHG0Us=;
 b=a6qYuaBvUk44GrH0pXdWWvD0yjZ3ZzKFyKyZvWECh7ZsOiqv8DawA3mE1IohMtvIpQJ1tUsLo6llrzIpw6SVJqjTmE9zHctR72gTlv3ivIEoCfQhXGqiuw1M4WYtkcPamJASAyn4E3D9f+iSHQKbjLHEG8Dorxfp9Qqjfjrv58g6onLdp919cpw4iwsIlYTOo0CV9v3uTGAoy6dYrvnJygftIcJ0yXn7HnxejVmj7m8lxoC/v7tSmzj8OrCdfxHndZQF37wglScP21bqIrL5wtN6lhiRncm1d/VyybbLrfe56koo5HU4fZey6jBkjTdHsJ9C7rvdXnVFNpPIdPg59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v5ft7yKs6ph5QIJJP6+oJvJtID6GCAcYQK6qmHG0Us=;
 b=qzlFUq7eo8OtupjCeEc5Jp+gNeW9N54FkuJulm64zTU8OVYY4ZlUENeayWCqkDATvkqVtHY5mK8RUsAJ2fU575N90BdLIdYzd0DukYBN78Xg3gkii8/wntx0ikFG0yPX7JgeWPh8cRb3GPguO8PYvj09yHG1MgLSK3Lyxhtq3UVIHguepVzV4t11xt0UlDs1OgM/b97q3tJrD1A2yyIgn3+gqZ0ZJKLlCQ+zf5wALn6rYsi6vpzXSu8FBUDvTrTGSiSOueXS6CkQQvLJiUr4T/ynrzGt7oABUrz3kR1kRzibfOwv8eK8jTWI02nq2nr0OWLUTuU6CvcJUBehp24vrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.9; Thu, 6 Nov 2025 00:19:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 00:19:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix folio split check for anon folios in
 swapcache.
Date: Wed, 05 Nov 2025 19:19:47 -0500
X-Mailer: MailMate (2.0r6283)
Message-ID: <3DF5A0BA-D828-41BB-9E80-35EFC02D2ACC@nvidia.com>
In-Reply-To: <20251105155752.fabace52f503424c64517735@linux-foundation.org>
References: <20251105162910.752266-1-ziy@nvidia.com>
 <20251105155752.fabace52f503424c64517735@linux-foundation.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0270.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 31337e21-7d59-40ae-81fd-08de1cca3327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t+8CL1fZuxYLwyfrDr/cttBxKxazZhRJ5SrRs1L9LvUpVmd6+I5PfF9kScji?=
 =?us-ascii?Q?Hs0tRu5hm3U39QUmGVBPEFYSJ7ySoWKP8lxc/R2EQ/a5JBsVYuw5MYYXGeOJ?=
 =?us-ascii?Q?ShqOave9qwGxrGWHWBXghaSONwYu6l8EKFl9fs500RN1DKCQCB7idg7aXgKH?=
 =?us-ascii?Q?ndpQc/zjpqEeNZ13vJsKkIqrJDqlcpHRBd3I3lY5NbzuB1olOLgzyuRfDiHm?=
 =?us-ascii?Q?O4d7nHdLOtjz7GhhL63OFtXuQEwO17hWaZEhfHMIskiaSHqez/KL0IqoDfjN?=
 =?us-ascii?Q?4TkxuIPFFR9ZWb8s9z9uMSMMP5xgZhPdkk3bkwT1fkiL14WeJx9BBqJtwGUK?=
 =?us-ascii?Q?pf9pdQmiial1M01AYw1OiZkB/nUzpdZcsTKAoKA3dsVp+td1O0o+apxmcU33?=
 =?us-ascii?Q?or7QvPpXnYncAqZumC7SDNPNuwWPaql6SuKIlDJyV7gZo97nvrb8/j0VtVWy?=
 =?us-ascii?Q?4qjwWxoGUIKvxU2fc7RPjK+nS6Zpil7p3Sj7fOAYCAxiPVDk9Lr4qRkTPNX9?=
 =?us-ascii?Q?1VtUTwcl5HTdhwx3vlP68if1REMSx0kNT/Awx5cT3ylWjk6DIdiyV56Fia0/?=
 =?us-ascii?Q?IESGeMh0e9qgaph5saUIkf4cXL4hX+io8w5u+IUX3HqmNkBzx8YVSfZSy67q?=
 =?us-ascii?Q?WSQbOrKDyZOpviMUCzThN75MLOQx3Y8yC3rRsP7TRAdkeWwF9ypSb6pGB7CV?=
 =?us-ascii?Q?xm7NK1HHOx5OjoEdYEacTBZUPhe5HT9/dDcLuj3e3wKjXqKVisjkQN7c3NCJ?=
 =?us-ascii?Q?5Ybq2Apj17NCPgWd5uxfGSVPO7+gqw0lhdSzfKNA7tHy8loya6Oz+iMkmEPs?=
 =?us-ascii?Q?v22jYIvMu+VwgJ53AJmbuzJviDyCWMq1k1RdXG38s9t+t1QfhqIy3C5Jg5mu?=
 =?us-ascii?Q?ueo9dop8lJN3sQvnExQauUHU9ETgTxWUM0F5wpEUmGjU8okbNCFfFoqL7fR5?=
 =?us-ascii?Q?48EXYz0rR+ZFDT92UMiy2KZ84NjvhDsjJKFDGhOQSkH/ViLOQGpAA82biqwq?=
 =?us-ascii?Q?XPFAuJZ7REaHZRlWjMQmiTcxa/J6Kj+XeV+LniLq5zHp6LQM8ZOW8Ev5LlSa?=
 =?us-ascii?Q?vuUMsAio6HbW0DblS/WwsOrDacnlSCnvqov4dq+1zIbERl+tSxSACJP8Gb/s?=
 =?us-ascii?Q?R2bsOz8jSHi+25bnZ34u6MyvRcC3EKTDNzDI08ANbO6mVWmIll0Kh2jHXXE6?=
 =?us-ascii?Q?1bynNU40JJD8zGCewiX2tp0Td2z626MuFkUoo/uyR7JifbY4b1s7gtm8e7oR?=
 =?us-ascii?Q?xjsLfkwSiPT/cfboYBxkqf/GCgbnSXQvCEnmnSVAZK50SGHSQ+us8ENuZtEn?=
 =?us-ascii?Q?p//xoCzQ7t2rtRx2Nx4qewIt/LVm8PaVJyfmYp1HSurpqlk1G2XkFQzpyqsU?=
 =?us-ascii?Q?RCzuQwGegF0yE8RYAJfJmDLVutXLbsn/eArQfZwcvStwCX1+kudQBnGM9dXh?=
 =?us-ascii?Q?7xB5zViYoHZ0cmzEChCOqLyFXBywfKlGUgrDGYhXmlzvyA8xn6JQiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WO7PzOdzJRY/1pAaue6+Q++RCeUu7bDteuZaHwc66wzBeXYA+iptfTi0k2x3?=
 =?us-ascii?Q?Dh+VQITldulH0r4O+Fd9jNXjX42E9EAWJb0nl4RFHtsO+13Ytu//2vunGw2g?=
 =?us-ascii?Q?l8oLmdYA3vXB5METYnY7yXNvApuGqttEo9UnEN2JlA4np8OLmHjMh+bs66Ht?=
 =?us-ascii?Q?SxY54/F12+5cgpmKYh8Pxmd/KaaBShQ9wXw7HKbbRilwGVrPJKDXTVJtx5ok?=
 =?us-ascii?Q?ciujvOLxpywEC8ONCSl0Fq2Qosw5CA3D5F1T51yir/S2sIL5FEyJmVmD21L8?=
 =?us-ascii?Q?fHnxmWgQjb0jb8MrrwcnHYypRq2U5xN02MDWzhlGbGQAtI9LO0bLeHxzPlVi?=
 =?us-ascii?Q?YMrQjXVHO9WK6sjcBRByfsiF9dNYmKswR6xyWNgXQJxGH7dteRp3TZ00K12u?=
 =?us-ascii?Q?5nNkpOnWMqrRnSnHD6+/F8rrj8IEUeRsyfM4vFN8xrqnAK7byauV/m4QwruE?=
 =?us-ascii?Q?t/hIT06R4WG7aR2/IBo0ST/aa/E8W7t0L9OqH8Y7XtASbW0riYgpniod2sk9?=
 =?us-ascii?Q?ex4fc8G+EBJyTyh7HzS91l3W8Oo8NCtNtRaTBm2CxhAzi+O2EArmJtUDc5cG?=
 =?us-ascii?Q?W4Rjt/ojcz9mRsEgVfQp4bokvSpXR5QwRoNdgNdUVk3VmzdNBIPFhdX5m+Y4?=
 =?us-ascii?Q?LMLpH7sr0k+uPnEPMAEgb8eaOKilRl1yCsTvqYsZ0EboEp2DJOCAOa8P9ktR?=
 =?us-ascii?Q?MMJE/pm/5Bt3TDbO/XagQlq7Hs0TWJeqKjWdc4w+WzP1DvV5Z8BNU7HePl/m?=
 =?us-ascii?Q?ISYVFlABNMKKQ3JXYbTDMuU8QcSzb8v5XsX9lK0sw57b2jQdjBuyMvvEIxfQ?=
 =?us-ascii?Q?FBSraKwcJk/9YVtKB3IEP5+Tlc4xSNUGVVxQp+eHfoXynxw1Kd6BYwWWhJtT?=
 =?us-ascii?Q?oJWOrUFrGIx7jzYfA5Hn9/5lGVd0S/v3JNGAbRCpVkkjCYc/PixBgQDjIcuh?=
 =?us-ascii?Q?syRnUQujCGty8VJodiPcqminHv5A62xX1LY+ZmyMjfH1BH44bOcaeGg6MIu3?=
 =?us-ascii?Q?rV3+y2dQ3iJxI/lT1wGMlPKay4tQ7jc6psktUvBX3S2icvj3DQZHq96zIJ6d?=
 =?us-ascii?Q?3bdFDlGgn0PAKKojrqa2LPfH93uIMVCE+tt1anR4NxLLTp8V3O5n754AS7VG?=
 =?us-ascii?Q?dWH7ZTQaur5NXmr1urKLktiCqzwj5QPNRNSjbjb8YGcTLjgmalo+K7xBvGNv?=
 =?us-ascii?Q?HovcZaEobJGLhUi11u0jxOCHSfY+FEPz0aLOPK7NRII+TPG5rFBcGDo2zhBq?=
 =?us-ascii?Q?S9I4HQNIGQIqyEC742aTp+jib1cekU6Cpj3BHjYFgpR/L2gD2NQqKQ3se3v+?=
 =?us-ascii?Q?uLI8DWb2poFHEHKnnq3SFclD2n9uFDz6A/oKRQSS9GLyH00ghZi1Ij0mxzeX?=
 =?us-ascii?Q?Ay59QQ1guBgV0jY4msdKNX3lC+qoWJPQwRGglHkcirReznSthBx3ZaTghlH6?=
 =?us-ascii?Q?12g12qK4RuOnvQyOSOhWpBicLMXZFjB8+Cjy91jjFscmTtC6J65/jmJsWrKV?=
 =?us-ascii?Q?Xd8X3whclwZ7LAj45ujsdLZ//+3rzxPknTfpBOwlmqAQdDfoIfTnbOkqwBRw?=
 =?us-ascii?Q?wDL7Gynb8F1g3vNCI3sNcNTeQYbyEehO9kWvud0r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31337e21-7d59-40ae-81fd-08de1cca3327
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 00:19:50.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdKiqi+dLmKmWvj386aYxGzBFlZfm7O1x3mjf9CW4EMH13pWbff6efhKSWbt65Y6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443

On 5 Nov 2025, at 18:57, Andrew Morton wrote:

> On Wed,  5 Nov 2025 11:29:10 -0500 Zi Yan <ziy@nvidia.com> wrote:
>
>> Both uniform and non uniform split check missed the check to prevent
>> splitting anon folios in swapcache to non-zero order. Fix the check.
>
> Please describe the possible userspace-visible effects of the bug
> especially when proposing a -stable backport.

Splitting anon folios in swapcache to non-zero order can cause data
corruption since swapcache only support PMD order and order-0 entries.
This can happen when one use split_huge_pages under debugfs to split
anon folios in swapcache.

>
>> Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-un=
iform) folio_split()")
>> Reported-by: "David Hildenbrand (Red Hat)" <david@kernel.org>
>> Closes: https://lore.kernel.org/all/dc0ecc2c-4089-484f-917f-920fdca4c8=
98@kernel.org/
>
> I was hopeful, but that's "from code inspection".

In-tree callers do not perform such an illegal operation. Only debugfs
interface could trigger it. I will put adding a test case on my TODO
list.

>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi

