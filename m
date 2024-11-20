Return-Path: <stable+bounces-94092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A729D328D
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 04:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADA9283FD3
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 03:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4027F155CA5;
	Wed, 20 Nov 2024 03:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LvQWIfOa"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2373740BE5;
	Wed, 20 Nov 2024 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732073355; cv=fail; b=CvnQrdVQxPPmyU8/IXqmH/+lnpRQQEFIKFi5COCIs9QA8j0HNMsdEw1qHBWx68+ItEOJKKdb/ogbfZDsjvXiUYhE/BXb0VvTDKXMQh4mp6iWeAuLbAx8mcee6TW7MdpKZo4yH252CCvDJoo+onfCmuqmXZLedUQMJ8uxjbTv52U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732073355; c=relaxed/simple;
	bh=GWqje6QTjWqFQ1S4ALbcMqBlhyAv6M/YKDcPOlYnSig=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SFryxO5l36hufNNR4qG7TUYoDMkbBPJRWMPzMKxnc1cL+Q3If2dnbXLAlijCW9jwp0WO8DUPmLG8qzUbsXoYabYX6meHbsJxR6e7NKx4z4FSy29Jxr911ruvlHLpNl9e2w4Vrfxoz/dRMT9pcBihBll8hxZk+gQCDLX4of0DVog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LvQWIfOa; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiNbtIg1VUARRQhoulEjunAmkmg/Rc83RgW/yLci++nQCLeevAEc3rHwE4eSkMVMUvAN1hoIIamANOW+uX5sgkhyV+bmIyj7cGd+CQuq0EU/gRQY6vGqwD4Or48bcPqprsVtztPGVn+sUVAOBV/m0PEO1Is+FbxJMvrIxpupkQln6uGaIzmwtzzxSJSWFqCmzXz0R/5b4dwFLlJSwFGHlBv6XaSWw6fB5MhaHHY1GTRVvIOzhdIfR2umPW80mOUH5jPmECJmeRKpBAoPv/GwGAvVSDVqyzeDs/cZ5dhl4A5ceqADJWQ0P7kjMVe4l6Q4lyR/owxlynXtwtALHiiaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mHCt/8vt3QqwS5+HTUNujtRHT7AFFZstcNq1dmXIwk=;
 b=bNoydlwRaiKDgFp4LlA6/7d8jLV9lH6RpHmq1JLyLIEcV/xdnfG406+irap4Xo+Qu+3VV6lolHCuYFjz8wPkqpcQHONJJeQHglRbOu9jYbXGm+pcemWbpc0MDeGC26JLrVNw3X+PgDAb6NThqOrYZisYF5RAg34/PMlUqFJktTIB/341FKIy/dgCbGtfeSlWcjGLt6JsKxFj75LKQt0ZwjFyJd8A3aYuFnCScDhdnL94y/qjmthfY6nTqnX5cLv9WS8yS0AAh6ExmhGp++67O+oW8qJsLZQVyCSBlsomr2WWs8FnTrY6E3mJy/UdCXCfy6N8PkCKoVgSBjk7yGGFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mHCt/8vt3QqwS5+HTUNujtRHT7AFFZstcNq1dmXIwk=;
 b=LvQWIfOaAPx703oVWeZlUzkODob+A/ByzxN4vhqJoN4zuFAa4GfAeVGOUImfNNoTZYTUv9bOEABSxQCQCQX7+NMxLHuDtnLVfmokcVp92J1592+hl7tDywD7vPvmaX/nnn3w5qUN9LBjxgmnmUkxQCYnIW9S1mJ+mlnpyP10pwh2vbHdMswrffVN6PkC6hQyr3kxoFW25wuCrxXWHV/sHa4vHLj2e7PALMmH8i9e6mJ/vC4ZwJwZiP7Csv7FCAdsdAqbofuGFBciYleE6+L4+gU2ounwGFtQRBOOZDB6C+hjTdL5N8ORCoBA7F4QfPtTJXpJZ4+ndqZ377xV5Hg/eQ==
Received: from SJ0PR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:332::16)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 03:29:08 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::b7) by SJ0PR05CA0071.outlook.office365.com
 (2603:10b6:a03:332::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Wed, 20 Nov 2024 03:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 03:29:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 19:28:52 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 19:28:52 -0800
Message-ID: <171354c3-c276-48c8-9a80-795f4aa7a471@nvidia.com>
Date: Tue, 19 Nov 2024 19:28:51 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: handle NULL pages in unpin_user_pages()
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Oscar Salvador
	<osalvador@suse.de>, Vivek Kasireddy <vivek.kasireddy@intel.com>, Dave Airlie
	<airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Xu <peterx@redhat.com>, Arnd Bergmann
	<arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dongwon Kim
	<dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>, Junxiao Chang
	<junxiao.chang@intel.com>, <stable@vger.kernel.org>
References: <20241119044923.194853-1-jhubbard@nvidia.com>
 <64d5e357-94b5-48b4-b6cf-0a7a578f82ae@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <64d5e357-94b5-48b4-b6cf-0a7a578f82ae@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f28c34b-a337-4756-b249-08dd09137dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHdxdDloMkpwSzhjMHlJMFpEL1ZZSHEwK2Y1U3lWd1BnTy9DdktDWktpVE4w?=
 =?utf-8?B?WUNpbitVRlNZa3FPN1dDdEhFeGI5TU1NRit6YVArcDRVYTN1ZGJialZPRlRx?=
 =?utf-8?B?SkRCS1pZQXY3dFZsNEx1bzh0QS9oOXRaVGZ6V2ZDWFJqdUVLTno0dHVXTm45?=
 =?utf-8?B?Rk82RDZ4QmZKNG05QWlDc3hOMVNHWHRxekplVTR2UnQvUUF1QnczeGkyN01j?=
 =?utf-8?B?SkRhZDMrVFc0eGNjSnNpaW56Z2QxMmNPd3FXK0trUWRyekZQR2JJdzlWZWtx?=
 =?utf-8?B?ODR1SGFlbHY3bFZyY1pBdDhRT2k0Z1JGQUpTNUMzSnIyTklUWkZGWnpFNVhs?=
 =?utf-8?B?ZUVUN2MrRWN3S0tWaVljRXl6R0NXUndnR1REcE5hREIvdlNJZFdJZ2Z1aHFD?=
 =?utf-8?B?TDlKamlscjZINTdkNTdGRmFsNlAxcUl2V1JyUmxvcDRQSml3bE9BRmNJTi9u?=
 =?utf-8?B?ZXR1NXZNSyt3YWpNaEh3S2xPMHJ6L2Q1a3MwTUpkVUVCYUg3MEdmSXdQR2dF?=
 =?utf-8?B?NklTT2dYeFF1enJxQkRtTGpFenlXVjJsTWxHUWY0VndqOFE3TVFTM0xQbUsw?=
 =?utf-8?B?cGFILzZMM2Q5RWkyVlExN0tPWVNZM3M3M0hzTzNWYWFvVW44aXlHa3ZycS91?=
 =?utf-8?B?N3RiRS8zOW1zTURyTHFSbmNhMkUxK2Z2NDlaVmYxMEdZeElGdlBaZCs3S3pX?=
 =?utf-8?B?V1ZHUHl1WGdLNU1kckJSaytjRk0wYmdZcU5kMldPdkgvWkY5N1NWZDVueFVW?=
 =?utf-8?B?ZWhOaDl5Q0xheTRVUUdsb1dFYU4yVVlpT3VhZlFGNEFHaGFxUFM5bnRQdTVt?=
 =?utf-8?B?MHJ2WUJQenRMdGRtQzcwMmt2dDFlTmp0aW04c3QvMlkxWmNseHRXT1pWSEhG?=
 =?utf-8?B?SWJ4ZjZndzVZOGsrTnhFaVhjWVowQUdjd3lzTE1ISmVVcDNPc0Ezby9ET3lY?=
 =?utf-8?B?V0NnRU1WVGkvekxZalhRVWsxemtmRUhVbE5FcXRMR2JkQittWjFGOWNkYkg1?=
 =?utf-8?B?K0VNUnJwZitLcUtBdkFrQWpuZ2ZVVU9sSXJaSWpER2orUW8yeElpLy9Rak5C?=
 =?utf-8?B?RmFDUEsvOXFTckZUUzF0YU1tQ2NQZDR5OVFwOURjek1pam42YXNQWXo0ZGVm?=
 =?utf-8?B?cmgzc2ZqeGZJZ3RzVWhiLytlczBncm53QkRYL2tkSUNWQzJwWllJMUJsWXQy?=
 =?utf-8?B?SFRUQW8vdG5UUlpxWXo4cllyVFA0M0cyUHZOM3ZmZEJHU3dUUlh0RituaWo4?=
 =?utf-8?B?YlVzaXdRa0FudFY2ZkcyOUpHZ0dWR1o5TjNYekZHcjdJZWFxbEQ2T0w4SHpG?=
 =?utf-8?B?ai9hbyt6blJ0YnQ2dCtXYXVCaEpVem4yRWlXdDdOdmQzcHUzNzdJUzNKQ2tr?=
 =?utf-8?B?WEN6K29CTit4NTl6WnZrSzdRTE5HNFNVcy8wNlVMVitSUDBFMW5hU1k0SFM1?=
 =?utf-8?B?aUZ5TGIwQkxSVHRuN05zT1d2OGlmQ25wQmp5MHFZWjZNRDlydmg0WW03NVRi?=
 =?utf-8?B?d0o1Z1MvRHlRUG44MDNtRmNKczBOTWZkVWNSSThTN3RLNWRLbXRyTzRVdWRa?=
 =?utf-8?B?aFd4RVZTSXlUVi9KRHYwdnBiTm10a1JOa2IvZlV0SW9ZanpseG03RFZqa3V5?=
 =?utf-8?B?V2g0WUczWjZ5cWJDeUR5VURrWjlSTU5JcThQRWdhajJaVE9TV0VrRkVvVTFU?=
 =?utf-8?B?cFh6a040YnF1NDQ0TkRXWkJLbGtMTXB4YVJ3VVdEWklhZjRBellJVFRidWJ3?=
 =?utf-8?B?ZFNLZjVLQ2Frb1ZadFpZd0NwU29tTTFMVTltYXRBSVowUDhlUnJHM1QvWnJn?=
 =?utf-8?B?OHZUY2FRdE5wMTQ0R2p4RHdPMUQwL0tDditTUUQ4bHFLL29Xb0MrQ05MOHpn?=
 =?utf-8?B?RFZ4UDBwOHNaTERBbFN5L0dSck9kRkcyeUJNNVZMcnBNN1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 03:29:07.4496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f28c34b-a337-4756-b249-08dd09137dc7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

On 11/19/24 6:33 AM, David Hildenbrand wrote:
> On 19.11.24 05:49, John Hubbard wrote:
>> The recent addition of "pofs" (pages or folios) handling to gup has a
>> flaw: it assumes that unpin_user_pages() handles NULL pages in the
>> pages** array. That's not the case, as I discovered when I ran on a new
>> configuration on my test machine.
>>
>> Fix this by skipping NULL pages in unpin_user_pages(), just like
>> unpin_folios() already does.
>>
>> Details: when booting on x86 with "numa=fake=2 movablecore=4G" on Linux
>> 6.12, and running this:
>>
>>      tools/testing/selftests/mm/gup_longterm
>>
>> ...I get the following crash:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>> RIP: 0010:sanity_check_pinned_pages+0x3a/0x2d0
>> ...
>> Call Trace:
>>   <TASK>
>>   ? __die_body+0x66/0xb0
>>   ? page_fault_oops+0x30c/0x3b0
>>   ? do_user_addr_fault+0x6c3/0x720
>>   ? irqentry_enter+0x34/0x60
>>   ? exc_page_fault+0x68/0x100
>>   ? asm_exc_page_fault+0x22/0x30
>>   ? sanity_check_pinned_pages+0x3a/0x2d0
>>   unpin_user_pages+0x24/0xe0
>>   check_and_migrate_movable_pages_or_folios+0x455/0x4b0
>>   __gup_longterm_locked+0x3bf/0x820
>>   ? mmap_read_lock_killable+0x12/0x50
>>   ? __pfx_mmap_read_lock_killable+0x10/0x10
>>   pin_user_pages+0x66/0xa0
>>   gup_test_ioctl+0x358/0xb20
>>   __se_sys_ioctl+0x6b/0xc0
>>   do_syscall_64+0x7b/0x150
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Fixes: 94efde1d1539 ("mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases")
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
>> Cc: Dave Airlie <airlied@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Dongwon Kim <dongwon.kim@intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Junxiao Chang <junxiao.chang@intel.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>
>> Hi,
>>
>> I got a nasty shock when I tried out a new test machine setup last
>> night--I wish I'd noticed the problem earlier! But anyway, this should
>> make it all better...
>>
>> I've asked Greg K-H to hold off on including commit 94efde1d1539
>> ("mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases")
>> in linux-stable (6.11.y), but if this fix-to-the-fix looks good, then
>> maybe both fixes can ultimately end up in stable.
>>
> 
> Ouch!
> 
>> thanks,
>> John Hubbard
>>
>>   mm/gup.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index ad0c8922dac3..6e417502728a 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -52,7 +52,12 @@ static inline void sanity_check_pinned_pages(struct page **pages,
>>        */
>>       for (; npages; npages--, pages++) {
>>           struct page *page = *pages;
>> -        struct folio *folio = page_folio(page);
>> +        struct folio *folio;
>> +
>> +        if (!page)
>> +            continue;
>> +
>> +        folio = page_folio(page);
>>           if (is_zero_page(page) ||
>>               !folio_test_anon(folio))
>> @@ -248,9 +253,14 @@ static inline struct folio *gup_folio_range_next(struct page *start,
>>   static inline struct folio *gup_folio_next(struct page **list,
>>           unsigned long npages, unsigned long i, unsigned int *ntails)
>>   {
>> -    struct folio *folio = page_folio(list[i]);
>> +    struct folio *folio;
>>       unsigned int nr;
>> +    if (!list[i])
>> +        return NULL;
>> +
> 
> I don't particularly enjoy returning NULL here, if we don't teach the other users of that function about that possibility. There are two other users.
> 
> Also: we are not setting "ntails" to 1. I think the callers uses that as "nr" to advance npages. So the caller has to make sure to set "nr = 1" in case it sees "NULL".
> 
> Alternatively ...
> 
>> +    folio = page_folio(list[i]);
>> +
>>       for (nr = i + 1; nr < npages; nr++) {
>>           if (page_folio(list[nr]) != folio)
>>               break;
>> @@ -410,6 +420,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
>>       sanity_check_pinned_pages(pages, npages);
>>       for (i = 0; i < npages; i += nr) {
> 
> ... handle it here
> 
> if (!pages[i]) {
>      nr = 1;
>      continue;
> }
> 
> No strong opinion. But I think we should either update all callers to deal with returning NULL from this function, and set "nr = 1".
> 

Yes, that makes sense. I'll send a v2 shortly with one or the other
approach implemented. I appreciate the review feedback as always!

thanks,
-- 
John Hubbard


