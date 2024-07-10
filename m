Return-Path: <stable+bounces-58958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFC92C7C0
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 03:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678D2284802
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 01:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20E61B86D6;
	Wed, 10 Jul 2024 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HdY8Zb8Q"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD53207;
	Wed, 10 Jul 2024 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573606; cv=fail; b=alGzRXTG1RJkIW7YjD/npYbxzTHYj7pIsSGtJW+WzBG5blX2P1/VXWWqO9+KPImoriAd3QUD+x+Z8JnlHYmThsf61JACIv0XaO7nyyl54ZA5zQ4/qj/OuGRYmoJVT6F+Z24elh4/LiZ9XEiIeRP+du+IHD18SMNAbRRQXB+8Aro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573606; c=relaxed/simple;
	bh=ev/DbwUoJjM+VHQ1HVoQZlyBa/flmbVG8T8PK0CcWSc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=gA0XCgJ0C2+HSkfiVDfLDk7w2AJfjEqu2ffc503j64rMxS/YXQXHGXuF0irId/c9xs3HescuAdRaumOUIQeSWAtCfSj9rj239AvIgh2UjQ025FwxFJe8FLikJHhZFsEiTEIjN8umssy8AyQBgZOeRyYFBItaYOgqTuPzNzh4Cv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HdY8Zb8Q; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3X9XEcucSgAm098xqRpfcj6nHgT6HBdu06D2SiBE/OcRglLEJfD7FoWMxQwUK2FqNjept0Lv09b9eIYR0yhNx6CA27aeCbxRlMRTZruY3KTsxdOBt3UolwMFsoPiBbSfgf3QZcmQ4WkL5+im+OwU+kcPUnwRN3nC7sJ9HSWyfJXMDCwDov9djBbgGVv7Doo+ouBH5XXELW7MVWbpcKau0QEAuXbJc5vLOhRQxGmW5sgCv2wp1KFMkkLv5sRVlmvuah1CaGslY7+/XzVEgD5f8N6FQ1Qa88N8aE/RKAmyFJLrYRRnocgIlYDMuZSj3V47Q0P7gcaod3zWbtoCJxW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev/DbwUoJjM+VHQ1HVoQZlyBa/flmbVG8T8PK0CcWSc=;
 b=VPYUlQEWDqCr5QUKm4PVRwA/6gOKn9xduwizmAo9vXtYAZDYgngWBXykhfA1JlEXj75m8btjst5ELfpxshix1W2CC+jXJ7quMZN83I0+tkc9i9BoQoNT2A8D0pmTNPhhlTXSpBcZ8w1x8Cw3qedSNKgwZqjah9hhkPvj7R47uTo2NmmR7B6VLs6hWdADa4Qw9+yPV1vBEg7H2g5TIxIjx45iGv4eDt1j3I3855dsExnV8l4pYgERicHCAdhg7WbnxgaNRdcrpbZQi+uDCtNm4OLzV2EA/M7+koMqjrrGCS4Ijs+Zxqgc+97Fjcgb20u8ZGzA4rVeJVSMq9mdJz0Zcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev/DbwUoJjM+VHQ1HVoQZlyBa/flmbVG8T8PK0CcWSc=;
 b=HdY8Zb8QP9/ETiv7+4TZMv+nDUyT9bytM0N2hQj5mgCHvVG/H2/6YUQH9oFKc/nAAotUvqea6roCmUVDF/x3jUioy9F1pgbO4Ya0YIFcpFOnUjPNsf03NnaeOMrFvbUlf16lTKvPieulfjEKLCTGp0NBAPYh6iTrr1E9xtYsDC0dyDw0ksiytLs5d51Th2uXRtrxZQtpu8PDthQfXbHpFFtimeTZU9qGiCC13cLLcmfSVUPmyjyigvcyMS/wVCrIEhH7jxJGP4GvE2Qzg25BfZOzpOl9p9UMB6kqQPtrphMTcagjNxxKw772DncbC3y3PhdoUaLRLtrQvY9C1xHGlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 01:06:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 01:06:39 +0000
References: <20240710000942.623704-1-rtummala@nvidia.com>
 <Zo3SN_qlYUWLAlyR@casper.infradead.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ram Tummala <rtummala@nvidia.com>, akpm@linux-foundation.org,
 fengwei.yin@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix PTE_AF handling in fault path on architectures
 with HW AF support
Date: Wed, 10 Jul 2024 11:02:03 +1000
In-reply-to: <Zo3SN_qlYUWLAlyR@casper.infradead.org>
Message-ID: <875xtevyw6.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0159.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f51fc75-c53b-4ec3-abee-08dca07c8dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZfwbNfslaL7EvSR12me2hYWfcZ6yWsUVQLov2kQUD09AiuRMrN4OrojQvJe?=
 =?us-ascii?Q?oaNYISe2qY4+KAOJH2Y1DVaeiNw+MTglkFb3lMRdD+td87qJZ1/Btj00DYNk?=
 =?us-ascii?Q?FrMLuGo+Ak014/S2ibQqroZ/0AGs1Pymwwlczfwr8Bodk7hlcGvqNm4S4vIO?=
 =?us-ascii?Q?QrktRJSVnlz90oPlCSP02/3HDyV8CZsYPGdLNEqZRYF4GFtY/D9vSnl2Rr6C?=
 =?us-ascii?Q?by1hgZ72VKCLE+pWRoFIMN8cYUxJaOek4n08DGYw+luTLIALYqAuHwYWXxah?=
 =?us-ascii?Q?BR10Rf0/0TMKerCY+OKFzuQGTsOF3zclz6PKVM3kdswjzJ9yiOobmRnYRani?=
 =?us-ascii?Q?OJG4LK1FahO+ButvDW10f4A2MdzBs97iL5v4HSUgAL97NuTtOakqLqvlKiW+?=
 =?us-ascii?Q?19P0yPUQDBWOooPeF3dRU7/sBJIY52XbYtmnFlHxMmyCqloAdSjzSuyPupPZ?=
 =?us-ascii?Q?ESp0XEl35G3NSMyxmbc5ZKa14l7mxdzFD5w+HiOIpLOa85k7opbE/LeZrnr/?=
 =?us-ascii?Q?gifPFWkyzmxpqD+aiMm/7bAN6++ZzH73APtLyhZGUclNzVlRvlnX8qqAPcZh?=
 =?us-ascii?Q?SZ5KmRMOCTHY823EsXqg4EwvotHnZiNsJkAVysnpubt7fZBotrz+95IsnPFk?=
 =?us-ascii?Q?TKuLbKGvqBP1OunWR1+ZqULKaXa0DbVCrspuwufUGDrHRrWlThjkfWRn9MoG?=
 =?us-ascii?Q?D55xuhq9cDgGBQrXYe3wrATETVcbBdRX0bUSiEhO2XpOb2YtwXauU3SVV42i?=
 =?us-ascii?Q?YMLU2icQQ9z8RTt0L7Y5JAF/AqydB9RIX2my/p6u9DrDTMjMtG9MFGmTLlOO?=
 =?us-ascii?Q?7UIpEIGcsGAgFRQD3sYnepEdtU05EFtnwYF6ItjjDkDwude7zqkrgbrBeErx?=
 =?us-ascii?Q?fWM0aX9EBdP9SliXRcpnB4Rkx2GwgdXfnbI0YpH265lYl2PuRlxg8jrac+SK?=
 =?us-ascii?Q?/t1dbOPD1bt0Uq2CNNJcDW0XyD/tYq7GH6TsT5eD6Jr8bcR7/cq3yOELfyql?=
 =?us-ascii?Q?n9hjKKdhtzUxgzt0s+6Mtf9WwYI1LtTwkvOcHzJS3HFy3D34L6tCiClU/LVX?=
 =?us-ascii?Q?UxO1bZz3fRokL7f/EwW+/qRcLwGO9QKxmsz/vrOuR1F1S+YzrEsBp+o4ZyNa?=
 =?us-ascii?Q?qCDLpr6UiCQeq0NF7/vrP5Md5CfsQe4NhfPDr3WxL/1nUFxt3bclIOW2ghuy?=
 =?us-ascii?Q?Ksrwcy7KzlWVqUOfH5gRIF5RIic+eYiZOni9yni9PSTdU7GE1Ch5EPMSE81F?=
 =?us-ascii?Q?NYm03ZJ5RiSKDq0iobYYNCXh3z/XUuTzzW8nN/D379PGx7mNwwOhnFvZ15dM?=
 =?us-ascii?Q?XY2JBgCzQ4lmNf5b+EvhOZCLGWSpxBqkKpr3uNv+M1j9aQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SHNib+deeP+WdpSOG/jj/AAjTAYX6uhx7483gIgT6OI7EA57J2OampIrFJx6?=
 =?us-ascii?Q?QmEUzAPLuMYGbD5GRUB2zJ5FgDV/ihLMIixlbDfwZQGBYwHhDuA7gxi9X7+p?=
 =?us-ascii?Q?atnQkjWbxHWRj/KZaxbRglBL8MRolewffjDowwElnbB1hE3REhtcVZYvaPkz?=
 =?us-ascii?Q?0ePFULU8eWh9Lh3MVxuhGOWfRCEZoeoSBzZ64DlgAAsDHfOa3MBu5rotRPs8?=
 =?us-ascii?Q?J2CRFGhLgFtK0RjYNz2XXy+voJgfPM19j71yXRbdryBw2N5X2vtqWwvrRtof?=
 =?us-ascii?Q?RMts4UQKSxUg1LcvWH7VTUorhXHLiBJU8A9isBBthK45/TiniCYzUTBLK15j?=
 =?us-ascii?Q?tQOukHrQ/7aSyFwVXZehv81e8eGI8v2wL+mXFwjhC9Bd0+vm0lxk5/obT7QR?=
 =?us-ascii?Q?xLpgfeyUw7CSJGFyR+il3mIqJOHHLWVZU5BmKKNLuU1bbGhOXcfgLQg2oGhq?=
 =?us-ascii?Q?FRLgJTAUCFaR9vvozhOXjN2ykciWAhziAhS1TqZJv3l3nfGwR7w1HbaSeRjm?=
 =?us-ascii?Q?97EZbPd1G2lGZHMiQtgmP6OO0EvsCCtIAIJyJ7Bqa/S9ggG6K3wGCJt4PGK6?=
 =?us-ascii?Q?HZm3udvpAJDzGRHTq7qgbjTJFMHNFixR/kZBmSjCJQWmx4ja/5fqW9ka5yX2?=
 =?us-ascii?Q?uzAl0BICp3OUdw9jWnVS+TI/AiC4rnoOXSUIPsbchS5so4y/V8XYWr97W5C2?=
 =?us-ascii?Q?uJNiqjQiSCi3Q7YkjQnbPL6S4t/QtBy9JDv2YI86szPFPo9FWdBlVvt9kWfm?=
 =?us-ascii?Q?mLPF3g0OSz7/RL9UJNmPs3VQFSV3qrTkqhP3rFiOQhQ1oEOdF1hQVHlbhheU?=
 =?us-ascii?Q?2y+LJCe7K+VBHBsJmEL5cgXWqqkGU6BrWqcM3gsPYlUoUOIhXq3NwIAKcMqu?=
 =?us-ascii?Q?mzvLfIPiA+8tbA+i4OrqaRVIen2+4fi9q+na5bV3YltqC/szXJlE/FKG2dQ2?=
 =?us-ascii?Q?2C5EU9J7rivHOkQDcwbBClE6o3S83TnQIN9SkNf137lT0loFW9k1NWTehr4K?=
 =?us-ascii?Q?Njyq8un4/zk/x511sLPYzI3BV4HBBCQIgQ8ykSLb3yFYAlKt2O2abKsUvWkg?=
 =?us-ascii?Q?vy2iKROQliNzNYY9PP52TUqDtmCTvrNp62t0pU2Y3NcgJCcKmN+10/uynIsH?=
 =?us-ascii?Q?xvN/+QNvHW1q6BzpVcKv+kJxAR02TUJDu+jUXM2eXyaLix9E5YFmnAeV7x8F?=
 =?us-ascii?Q?rRLDj1yp9ihmOV6DL2lkotooc8R9PNU7iBIZuPCJSM6sXQaVlnkvprG2ktgY?=
 =?us-ascii?Q?JYeMhfhZcIdDBHqwgYu3+Wp6TSC3U+pfx/4wQ6Bqo3c8vsOtjhrCakPClv0U?=
 =?us-ascii?Q?dL+N9A5uQDTFPMUrUuCGOgnerqMQdEXauCQHbSSTHxY7hdeLO24cUR0TkKsz?=
 =?us-ascii?Q?WzkGxkiH10SXCkNJjVW3StkZ2DrMEzfcTFvRO8yUc+52X2RqH4ZoBxROpf9V?=
 =?us-ascii?Q?RVB6u5mz41OYB+Jw5FXm/V7kTCskq1PojxDzAncqF/YtlozyBKUZJltWOv9E?=
 =?us-ascii?Q?xqt25BIuofb59KoOuQLU30pCpZszRywmF/7Fo1iK1dEAxgRJYVkQKSDalyPh?=
 =?us-ascii?Q?1HZwALC5u630i/Pgp3IjeJ5hnj0L+dewCRnTYMJI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f51fc75-c53b-4ec3-abee-08dca07c8dc0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 01:06:39.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gu677zx0JmrQ+5c1ppsOXbW6AmXdNVNBvkF6pyeDVUx2WbvvnOrHikOSAborOi/nzVbmhO4/PhEFJF2o/fYS1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913


Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Jul 09, 2024 at 05:09:42PM -0700, Ram Tummala wrote:
>> Commit 3bd786f76de2 ("mm: convert do_set_pte() to set_pte_range()")
>> replaced do_set_pte() with set_pte_range() and that introduced a regression
>> in the following faulting path of non-anonymous vmas on CPUs with HW AF
>
> At no point in this do you say what "AF" stands for.

It stands for "Access Flag", but that is specific to ARM64. As the fix
is in generic architecture independent code it would be better to use
that terminology (ie. old/young).

