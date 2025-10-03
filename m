Return-Path: <stable+bounces-183231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9027CBB71ED
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 16:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEB024E5ED0
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C31F9EC0;
	Fri,  3 Oct 2025 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bl9YLNzf"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA77081C
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500530; cv=fail; b=FnMSr7CKWO2qYswttExeG4CvWRgRpKUyb4oTqp3lmNQ1vs7MMBLq7D8ZBaha5SH0h6UWMnFTDKdNqh5Kxu+8ZhSZk6rxYi1pUeo5Y2LHhL0jrwG7rYfseBBMsQ1o2f/FHNwGG7Uc5+YAGpcnAa0noN75cBjFaBfI87zHIoA+2W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500530; c=relaxed/simple;
	bh=Xf0K8Fg/BdgytkNBPVrD0/bI0Bxlms2RGOnO8lma0l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eg1r7s7k6rETBRky0pJUAznhJUdWPGoVvss6osv5SZNkpARwRHJyl9IwuMXsftUJkQUYPPh5I/82416opJQzT8S3wQ9CyqCEMi4xO1F001S9ewo8/hPzzk7JC2r55scHpA9ejDGe3lL88Uu95Hth2r0mWR9QRnkEihxgBLIkH8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bl9YLNzf; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIsv33sqiIUGqTXYgUQcxme8V1RwpLGgpqw+09Q46J+3dtksx/IMncIw9cuClE0mUzdw1j99X4+fqTf1tMxqbWR+qibmAk2SB0s3chC3fj0ijCvbRh3R+UihHfto5kfLAH882tPxUH7OJ6ClXXpSKvDQfNbjtJMgub9K8P7P8uKk3tlf6Os5uJlckIZ/HOvmD40yKnKvHcwkFIPNKvQMyirkunQGYdqzG7ML5lslaQ5NjraV9WCFMUOe7o6XiQnu8L0RwxuVLQ7un8MDorYoMs6sFQCtbSb/2bscawYeoxFN1sbgYWNIpXTgxFRNBBa8Enda7jvc/M//8fOFei1Rug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yY3Jj416rYnJxkLlUjvlgLuqQf92Pi6yH958VjH2BNo=;
 b=T+mjYZ4lYx92JBoWlCivZ9ZfJFkRvzN2IWyRXJaZ5Q3hafbw2ZEfKv4bQpPqtOd1H8tXoL8RufFE+LX69+LE2oTLUo+7KjSLcCCyt5tq5GCH37qDy599BfKAplByYabxq19RDZ3KSHi3zrulfY/wmZfS6WNL3KGPKeoy0A8THv/s77uozca9IyCjBi5h5np1BxW1pb6UAaXDRx1H09n6k81aicvyzEnEyYCJ8A7S9yUWPJUYDz5oVuDdSqM0+O5pQfT5ndjPsADCMfRX4BM4Ma3FlNkEMpgDdiVI8FgsrkScNR0Q+kmp6mIRagjq56lv5RPEx/FOu2rCMBdILXLTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY3Jj416rYnJxkLlUjvlgLuqQf92Pi6yH958VjH2BNo=;
 b=Bl9YLNzfxnuXSGvfqdEkBxnON9xWTSyAiFjLFvUhDeqtcHPYOc9zcMyfRUzNviiVfPHxrtIyJC4aRgliq8DnHIBydIV0HZNDrQ0CxZ1RTCj/gF2/SL8hD6ID9ZjLBhxVPTshBEZNEkWVmMGZ5sx2APDsXLhccKcS0GbQG5ikBgrILV6MvNb6PGStTTWd/Hr+r2BZ6uMVJlvdRAFJ+B1vHdYMbt1AGnI8clqPLSpvPeWFP9Lc59JsUfPeKQVE+iuTN+b5UeBEqjrkruYNkHzsHhGW2g+sUsXRGXjhxIQgXbIMvTIHEENOh/wM13f2/uyZVCK4cDJrrKc+BoaOkv/Vsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 14:08:40 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 14:08:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usamaarif642@gmail.com>, Lance Yang <lance.yang@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, wangkefeng.wang@huawei.com, stable@vger.kernel.org,
 ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com, baohua@kernel.org,
 akpm@linux-foundation.org, david@redhat.com
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Date: Fri, 03 Oct 2025 10:08:37 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <1286D3DE-8F53-4B64-840F-A598B130DF13@nvidia.com>
In-Reply-To: <d8467e83-aa89-4f98-b035-210c966ef263@linux.dev>
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
 <d8467e83-aa89-4f98-b035-210c966ef263@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:52c::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: f3736f8b-69f3-4104-96bd-08de02865a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PSyp0Ute8LaKU8QSb8ZizCqXGWUDcLlI5e4iVhoOyJqnA3D0kcp2B0Bn7JXe?=
 =?us-ascii?Q?zWGLqlDEXEs8ixWFZyTRHaNOgSn7g8V4fCvuT7y3k8MobDTLMid58BzEhi1S?=
 =?us-ascii?Q?nlwAsb8Ra07fzBSwNNRhirZrY14ZJU3dVdzSWdUunKQ3Ip5rl/A6+1D7vKPL?=
 =?us-ascii?Q?WQjUhIjFW4n8ov9HIeKTpcOLWX/lz7mzClqtOiW7rig+3hxAJs8rvhEgg1zW?=
 =?us-ascii?Q?lPwZZ1Npj1LqbZYXUg7fECxYKmnZPjR4QutN2v4YIgDs+oeSaZZMnREQwXPa?=
 =?us-ascii?Q?Us+b01sNqllYxbTORuUxy2ms4FsruYdirBNKT7DjwOmzJHXoZ8Pd3lz8ivba?=
 =?us-ascii?Q?cqu2fD4GjT9PrVOS1CsiJ4u4hS53P2s91eeqRC/55m3sqEOQD02jCgUJvT+A?=
 =?us-ascii?Q?JWG/MIgxmX5uy6qm11lzaC/r3A3Idr0MjSPGrcE3fil7FLn4g8ptSu7yYeeG?=
 =?us-ascii?Q?NnQPBp5YeX8pJ7lHmkdO/0Z2rwb1cjj70dxkoxbUBFkfmABb2Jus7NaX6N4l?=
 =?us-ascii?Q?iyv0oZ071NLFuEPDqiDCK0yBePmI7zFJV+GwQ2/+JGu/XOxedG3pBd2bTVsf?=
 =?us-ascii?Q?eMxVXSQX79FNyBGofqBUEW3BExVrPUM/8or+JuNlymiR03TAgIOqvHBqOp9f?=
 =?us-ascii?Q?vpG1IGUoxSQZ9JSdFQ1KrqeXw2XCvCcaAC/NdYcliVmdGYOE5ZlcQ535BvJ5?=
 =?us-ascii?Q?9jeuPtiVjq+IVFAVImVo/7h6C73gy3TtduQ/3QV3I7Xe4SnazMgeQTaMS5Fv?=
 =?us-ascii?Q?N6cpJj4DZkov6wOJg+shkNLshSrblDG+CJp8UAmuZgTNO6o98V4vUKd4dsWm?=
 =?us-ascii?Q?S1hUciN8vmNNUMvq3M/Z7p9DPgDndkpix7ITMwUgde5m5nBbAFjW+hIvm6YI?=
 =?us-ascii?Q?Iav9MaGTv1aGB0ULUAPO+ORvydoeCSjOnOuI1jHP8knplIP+fRtWp0mXyLOQ?=
 =?us-ascii?Q?bt6WGI993Fzt3pZIlbDY+MqzGJ4FFJ0mDzjTlmdohlkWZqHLsCFLblmn9Y5/?=
 =?us-ascii?Q?6j0DxK1g2IQY6cjn/M7t/JWgpF/UF+44nRa1T5FWD1Eo5QCJ2FPahAqy4EWh?=
 =?us-ascii?Q?y9aeQdLVzoQNa8A9gWwIIvMEmBH1BRnBq3sEVSTRzEKUmSuIRjqMyskIigO2?=
 =?us-ascii?Q?bzYArFOndDNgk3rHVeKL1OtbCOuStzFgXGb1cmeulYdA4T9zdfV6VDrdq3d4?=
 =?us-ascii?Q?rwK4hbXWnoskCSRrTqUM52mfSsq4h/jdvJtM92MZgPIX0BQrlpwD9qXDShTP?=
 =?us-ascii?Q?YktyDSmVS8ZVCa3Rx8XWnxNvKGfIbT3YubUVA/17npdIfdN4wtIaQAYSW57w?=
 =?us-ascii?Q?fWnyueAtTW8wkq/Y87s+TiH1XS8WXDGG5OSLEaGVj6iPMu/2HfhYFPifVfjJ?=
 =?us-ascii?Q?s5Gtph76PedgvKkblzRCYuV8+QUpw3WXfN2WvpmrqDuFpkeQV+QyFq5wjYUd?=
 =?us-ascii?Q?P4vuysu7XxFqRRMs8HRWViSVFaSRKZF8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqdYwv0fD/+STlH/7zQJ6D06sljaCCin2akOe9T6c6X6i1Pc/KH4VR3t4Wym?=
 =?us-ascii?Q?UYZPKEILS/LqCzhDHX7+mImp9umHArZz3UweqtdGADZ21OFca0YuioFIJpLW?=
 =?us-ascii?Q?YSYxa9VFLUYOKdg37VkghHIIoGPmsnAWNyELyrRG0h0KpSFvyTkHwLIvHvKH?=
 =?us-ascii?Q?3k25WEdCHXpxKzqzZVw+2kJgPF4OyIkHTzsJJ7HRWOw2l/eOMixdYMsy7O9x?=
 =?us-ascii?Q?CVIJ44NOoSp7OvqQHAlnx9Gc9gH0a4bkYa8ESa3N9hOO3P4oirPn2gHq70w5?=
 =?us-ascii?Q?2VnA0wtCkEVg/7C0K60LMSSDwPyevWh6c/nR0P4z8891CfGWJy4IwxxG2lwL?=
 =?us-ascii?Q?uhIMpq9DVO9oqGN8VCxVTRtTRTEisWrRYKMnLLPcZAyfzlqItkEAbeviXoRu?=
 =?us-ascii?Q?AFjTtiTtvCgbaPDerW3pUGHn74Waue8wjssnkYh/AmkS70171ZSdQmG7LzXX?=
 =?us-ascii?Q?FzZQElgrAIjSQ8p5PNDq2BIfyU+n/0ROnYmYgnQgYTYDqk3S8BmJZYTlrz5o?=
 =?us-ascii?Q?qc49dbEmzzfTLGV4zOFEKLGGfwXgp+/0GFyvris4eEOzvBxW4KgGc5lK2FLP?=
 =?us-ascii?Q?vdsv5S9Ny8iJN7K+kexCBMAzYgBjWnTHZdt8OlLfFW290Q3HGJpw6Dg6Xvo3?=
 =?us-ascii?Q?ayn74/SHPxweSl921ry0Tyu6Hbti5jHjw38msRVM4PsXwFfbWvC4XFYjHOsw?=
 =?us-ascii?Q?xIa2LhOaooW9l8BEFvR7C3XkCVfiZ5PnavBdE+hUq+5xRH5b3jsuepS8FXvZ?=
 =?us-ascii?Q?h5oZpGQ6CeJZYsSrjBBGi5ZB4RkNj2CItM4VsGbozB23m2fxlZSypKYO4lJ/?=
 =?us-ascii?Q?4QJ0a0g4pQ/NDCDzErIzgGFfKYoz0cuy6ms7fQnkF29mbGlB4P+UUQW64Jf/?=
 =?us-ascii?Q?6F5hfMeTjRTRLj8Zqp+PyrVrCP6Haq+sbFwN6epI5teKe2DuV7qsbwj18m+M?=
 =?us-ascii?Q?LDhuLMxX5Q+ar39V4UhCvgBUZpKeEdgo6rZJsIVLdutBmIPSWILo/fvhrIKS?=
 =?us-ascii?Q?oRg77nQ0ze/PqNrYgzYGJSoxxHDQina8SgJbnKIOaoKHLgBec4eIHx+xdXww?=
 =?us-ascii?Q?Dw9NheZbi43DmR5ia3QsqGqMaEh4i1GmBApI1Dm01tl9meXhSqevtD0/pg6e?=
 =?us-ascii?Q?BHPEHZ1RJaweoppQTvuLqUh7Frk5HNEqqExBItzsyyBiroo4k36vfHb3FH1T?=
 =?us-ascii?Q?CV3YSvFemb6m7Tjvu2WE5iGdQoPhfRdJ/XFHy+l2sPKTRF6Tks3FzM6RNXvZ?=
 =?us-ascii?Q?4v6Z8deQ+RVUclh/kXhty2lEnl4+yX1kNMhksw0pDgohGWmfqHsocZUm6xhX?=
 =?us-ascii?Q?j8dz063T/9iDPgaNP9kFGEa/sOJBWB1Hl6m8ryX2t9UihbzjimHZZRgB18k3?=
 =?us-ascii?Q?2PPvzL1+z+kRv9VibRlIJtpEfzGJfW8nUWm4gFGqWuOFV0y8rcOknLK8LLFj?=
 =?us-ascii?Q?XwTwTZFJyxF/7IH0/S9zzFTRXS6IkKeC+z00wr6ihfcaOZkzJhL9ng84qzSY?=
 =?us-ascii?Q?CabmPm7c4lcMKXFj1IGjUn3ghlahdLidjOIxQepoHdYV8SdoCXuN1HGk/9Ig?=
 =?us-ascii?Q?WHecrOCQlbABkoxfj3hfH/0fDK5lI6VAS/ufhFZr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3736f8b-69f3-4104-96bd-08de02865a8d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 14:08:40.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aHp2dyCTucmsrBqnHoqRkn4v1i9hg9HVnOm0Jta8D+YpC247V5uItQ95bXJwl6O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966

On 3 Oct 2025, at 9:49, Lance Yang wrote:

> Hey Wei,
>
> On 2025/10/2 09:38, Wei Yang wrote:
>> We add pmd folio into ds_queue on the first page fault in
>> __do_huge_pmd_anonymous_page(), so that we can split it in case of
>> memory pressure. This should be the same for a pmd folio during wp
>> page fault.
>>
>> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss=

>> to add it to ds_queue, which means system may not reclaim enough memor=
y
>
> IIRC, it was commit dafff3f4c850 ("mm: split underused THPs") that
> started unconditionally adding all new anon THPs to _deferred_list :)
>
>> in case of memory pressure even the pmd folio is under used.
>>
>> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
>> folio installation consistent.
>>
>> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
>
> Shouldn't this rather be the following?
>
> Fixes: dafff3f4c850 ("mm: split underused THPs")

Yes, I agree. In this case, this patch looks more like an optimization
for split underused THPs.

One observation on this change is that right after zero pmd wp, the
deferred split queue could be scanned, the newly added pmd folio will
split since it is all zero except one subpage. This means we probably
should allocate a base folio for zero pmd wp and map the rest to zero
page at the beginning if split underused THP is enabled to avoid
this long trip. The downside is that user app cannot get a pmd folio
if it is intended to write data into the entire folio.

Usama might be able to give some insight here.


>
> Thanks,
> Lance
>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Lance Yang <lance.yang@linux.dev>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: <stable@vger.kernel.org>
>>
>> ---
>> v2:
>>    * add fix, cc stable and put description about the flow of current
>>      code
>>    * move deferred_split_folio() into map_anon_folio_pmd()
>> ---
>>   mm/huge_memory.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 1b81680b4225..f13de93637bf 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1232,6 +1232,7 @@ static void map_anon_folio_pmd(struct folio *fol=
io, pmd_t *pmd,
>>   	count_vm_event(THP_FAULT_ALLOC);
>>   	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>>   	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>> +	deferred_split_folio(folio, false);
>>   }
>>    static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf=
)
>> @@ -1272,7 +1273,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page(s=
truct vm_fault *vmf)
>>   		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>>   		map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
>>   		mm_inc_nr_ptes(vma->vm_mm);
>> -		deferred_split_folio(folio, false);
>>   		spin_unlock(vmf->ptl);
>>   	}
>>


Best Regards,
Yan, Zi

