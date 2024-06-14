Return-Path: <stable+bounces-52124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3709908131
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 03:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1601D2828B3
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 01:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1701822E3;
	Fri, 14 Jun 2024 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Yw887OuW"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2061.outbound.protection.outlook.com [40.107.255.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A81773D;
	Fri, 14 Jun 2024 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718330297; cv=fail; b=rwKCL6bDqIR8IyHYMf0pXPBSiobVsLTFSwntlAe+fr+pHnjDlS9+4bmXGfe/vegoeVq6YhkGRrbFHzRfLTv/aeHbfFyweN/dDiQcnPfEVyRIik1xWLx0+06XOvzK/Isx0WBSPr8hDXsor3ye7xSQS4HI7+lyhwcWHlBpQAXMbmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718330297; c=relaxed/simple;
	bh=2y+LzguzN5gx5k9zAf2Jfq/vFD086pnzyK3VPJfZnGs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pML5NQopQikZ/h5ZsJmdLKjVAfccU+SFrsq6xuTdUVrc6x0FexNm0bMnNfOn0ZPzd9JMja7JSKfwdacK36GWkA46RHQWqv8JnhmLP5lM+nmX47AAvXVqaDgHY7fGCg+znR9Aab4nL0JCrgd4GkDxtsmTeKifFmE2RasZ36o9PMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Yw887OuW; arc=fail smtp.client-ip=40.107.255.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FImam1eVxlpishY/gOfSuPcQgKk83Dr8qNmhjnwDA+C5F9ReS/tOXa1ZvoJR2TXj4clcd+KY7nTbdJ/RzIDnRQT9PyxpvKC5tJdhYXRecN+PDYpec9WK4KAYNQz2nv0U7S0nH1UpkAKkVlcVFN22oa6/Z2liokFXRkHfAbdhO1MpQGMyNAWXYBNcvciJDWLAH0xuMQKUm5pVpBMBags56tHaL8lsXftfauQcRI23PO3rMr32emQM3rGLN3LNuzko1RopV7xWudl3oehsQPuneELBWC5CrvLvvr7ATDxmxszOWU+JPgaMu5RzSiXJHheWTOxZhXQKsvh6WBcf6+XLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNbrBDWFnLzwMlOKJBhdcqYoWq7YU6xX9uU46iFgrAM=;
 b=h5NeqEpGpuH5oekBAzR7X9FqP6nhWFYpZjWfwxQ6XoKRgjxAS0zVGTzzdVrfMfVLX8esoz8yVwYZN39/AwpATKIf8fskFcgz2uvt+Y3mLhXY8CmdgRlHBPhT7zfCxVlpqRpPvvp3+AZXey1HC+pPakA0GrHzOrsvPEfyzewbLoUS6Mn/nM4hkzYpKnxfDKb8BsueiMnr5VskWTzc3Oi0rParCXXuJ77GtjLbUds28AYM+hSU51+2ru4iKHYQXClMVmL4nPCe0CnarTW7SrzunStfw8U/6Ir6sJlMY+JLutsRKT/aMt2ibG4cqy7mlcORVUSC16QcgEx/yP++yWAGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=unisoc.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNbrBDWFnLzwMlOKJBhdcqYoWq7YU6xX9uU46iFgrAM=;
 b=Yw887OuWaV1mrpFWS5sMmUdrsHBGhyG8iSRCx+haWLPEMvdK340wv6A40pm8t1eQ7zSy+GHJWtgeSIaveMXptL/2R8+ZsoduY6xihfhshzuuTmNlvIO/fl0eg6xPji1NzNxYH/buNK+u71NPlVMJfpHql+C4e7dxIVZnULfnTBg=
Received: from PU1PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::19) by TYZPR02MB6223.apcprd02.prod.outlook.com
 (2603:1096:400:281::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 01:58:11 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:803:15:cafe::fb) by PU1PR01CA0007.outlook.office365.com
 (2603:1096:803:15::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 01:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 01:58:09 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 09:58:09 +0800
Date: Fri, 14 Jun 2024 09:58:08 +0800
From: hailong liu <hailong.liu@oppo.com>
To: zhaoyang.huang <zhaoyang.huang@unisoc.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCHv5 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <20240614015808.tcezyuloxgxm736l@oppo.com>
References: <20240614010557.1821327-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614010557.1821327-1-zhaoyang.huang@unisoc.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|TYZPR02MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: c0283c71-4511-4a4e-c7dd-08dc8c157137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|36860700008|1800799019|82310400021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aURacFJSL3FEUUZJVEJLV0VoT0Z3Q2JQcDcxS0JjQVIvRVNHRUxWeEhYdnB3?=
 =?utf-8?B?cGhrYm5jVWROeWtpTmc4cks4Y0RTaHJTeFFyTklBTll6Y3d3ZDk1Z2h5VUdY?=
 =?utf-8?B?K0ZLMDJuTFpmSS9QL1NqaFkwWEQyZStSdmpxMzZZbldrbnFjNnZtQ3hxSVVW?=
 =?utf-8?B?VHc4WmpraFlHYlduQVJEa0hISGVkU2krdXdsYVJwNEx1RFBocjNDdVBqcGxl?=
 =?utf-8?B?elNXUHdPVHdBbjNjR3VzTmJ6aDduTVNiZjJxWktqRGp2QUFJYXNNSWtSNHBH?=
 =?utf-8?B?VTFJTGxKbkplbDZ6cldJWUsxSU9jdEt6dnFNN0Q5RGxybEg5Z0RnUGhhbHc5?=
 =?utf-8?B?Q0pvSWFnYjhVN0tTN2VpNCt4N3pDUm15SmNpbWZZbnJ5OHpTamxaTXhGYVha?=
 =?utf-8?B?RTNraDBsZWV6UHFhUUo1WTF0QWRHUHJaMkU0a2pLNk01TTFUcVdsUWJDakwz?=
 =?utf-8?B?Q0lnR0R0ZXBaL3lqZjZSeTJLcWk1WXhoanVZSUNjZytscThETGFOdFIydzAw?=
 =?utf-8?B?YVpiMGNHSmJBT0ZTYnlqYjBNRy9xTFNSNXJTeVpnY1FKN1BvMjFPSkcvcTZE?=
 =?utf-8?B?WkhhdWg4NitGWGNreHkyWjNiZGF5c2RYSnF3VjBJNy9pcStwVnNtUnplMmtx?=
 =?utf-8?B?bjNXMmpndExoZHlLQk1IVzYydmNnaHZ3WVRwNXRMbXJTd0ZlOFhIVkRaM1do?=
 =?utf-8?B?VU00VFFhdjdMZlhNelNFVUdkNHovVDJFaldzRjRrb1lienBGQ0VIUXdKVzFE?=
 =?utf-8?B?OXBNYzE2cC9GeEtPT0pTay9wOHBkSExXZW9aQ055dFIzOCtjUVF5VUVyM3o1?=
 =?utf-8?B?UUdkaXdTNUpOejV1RW9scXFRYWtGSTN1ZEI2ZE5zbmdYVG1DQ0NMbWUzUEI0?=
 =?utf-8?B?Ymh1LzBvdlZpcmlCaHpLaGIzcHQwRTNHbzJxanpkcFdxQUM4SmZjbytjWW9K?=
 =?utf-8?B?WXFWaGlQdnI1a290UTZUNEwzbmFhMTZ2UDJiYTRBYXZNdUExUkVnNUp3QnZV?=
 =?utf-8?B?eHlpMUV3U1U0TC80RnV1dFB2alcrNWdpOXU0YytJam9Qa2wvMk93bVpyOTZh?=
 =?utf-8?B?Q1doTkZzUGI4eWNVeTlEdnJQcmtlT09JaUtPM2JyV1l1cVBZdU95K1ppOEdo?=
 =?utf-8?B?T1dITW9laFM1ZkJIejBLL0RlRElvK0tJcS9QZ2RYWmdLT0ZRRmZwTUwwMlpE?=
 =?utf-8?B?ZW9rM1hNQzhYbUFlQVk5UHRaL0hLbUZobDhLVGpsQ2dkZTRFRDg1ckhCUmcy?=
 =?utf-8?B?bjYxcEM5UVpmbnNJakF2WkplR1UvNmxGSkNXdFRxVzNweFYwc04wUDMvbXJQ?=
 =?utf-8?B?WkdFcUx2RHZiR2dVZENRbENiR2NEbDBxL2pwSHgxQVRaQzFpVHlTbkNVcnR2?=
 =?utf-8?B?NmhjeFB5eWJmQnBpTUd6WHhzbDhYU2hDWGNGb0MwQUlLamR5a3M5RnhRUWpr?=
 =?utf-8?B?UEdWVVQwTWZNM2ppcTg1b21lR2tZOFNsT3ExdFlscC9QZVgvWXA1NDYyRi9q?=
 =?utf-8?B?Mm5kMXM2TkxsSmpsZ2VRRVEvWTNJL0JjN3NWQjFhenZPdUJvSmRKVkFadkpY?=
 =?utf-8?B?RVBuVlBNcEZOekxBQkxQUUVqa3hDbERpd2QvaEZ3by9lZ0Z2dDY0S01HRTF5?=
 =?utf-8?B?UlA0RDVONktjWWZIK3poUWFEeGpYMGN2K2ZpOERJbTQyc0NyT0h2Q09NTDlp?=
 =?utf-8?B?YVVvTEdETTNCZlpWZjhTTU00Q1c1YWVtcTllRDVmUlBCTXRqcmptdXFhenJm?=
 =?utf-8?B?b0NOWGVacmRDVGsyOGxrR3dFdk1iaUFlMGJSakgrM255dFFHY21FMFN1UWgy?=
 =?utf-8?B?SHlBM3d4SXRBR3JRWnRmak1YRk9DaUdEWmdCb3pkTE1ram81V0NIOUlxOVNv?=
 =?utf-8?B?WVdZdmM3enBHNmZaQUloeTd2SnU5WU51aTE5K1cvbzJzVlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(376009)(7416009)(36860700008)(1800799019)(82310400021);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 01:58:09.9888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0283c71-4511-4a4e-c7dd-08dc8c157137
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6223

On Fri, 14. Jun 09:05, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> The function xa_for_each() in _vm_unmap_aliases() loops through all
> vbs. However, since commit 062eacf57ad9 ("mm: vmalloc: remove a global
> vmap_blocks xarray") the vb from xarray may not be on the corresponding
> CPU vmap_block_queue. Consequently, purge_fragmented_block() might
> use the wrong vbq->lock to protect the free list, leading to vbq->free
> breakage.
>
> Incorrect lock protection can exhaust all vmalloc space as follows:
> CPU0                                            CPU1
> +--------------------------------------------+
> |    +--------------------+     +-----+      |
> +--> |                    |---->|     |------+
>      | CPU1:vbq free_list |     | vb1 |
> +--- |                    |<----|     |<-----+
> |    +--------------------+     +-----+      |
> +--------------------------------------------+
>
> _vm_unmap_aliases()                             vb_alloc()
>                                                 new_vmap_block()
> xa_for_each(&vbq->vmap_blocks, idx, vb)
> --> vb in CPU1:vbq->freelist
>
> purge_fragmented_block(vb)
> spin_lock(&vbq->lock)                           spin_lock(&vbq->lock)
> --> use CPU0:vbq->lock                          --> use CPU1:vbq->lock
>
> list_del_rcu(&vb->free_list)                    list_add_tail_rcu(&vb->free_list, &vbq->free)
>     __list_del(vb->prev, vb->next)
>         next->prev = prev
>     +--------------------+
>     |                    |
>     | CPU1:vbq free_list |
> +---|                    |<--+
> |   +--------------------+   |
> +----------------------------+
>                                                 __list_add(new, head->prev, head)
> +--------------------------------------------+
> |    +--------------------+     +-----+      |
> +--> |                    |---->|     |------+
>      | CPU1:vbq free_list |     | vb2 |
> +--- |                    |<----|     |<-----+
> |    +--------------------+     +-----+      |
> +--------------------------------------------+
>
>         prev->next = next
> +--------------------------------------------+
> |----------------------------+               |
> |    +--------------------+  |  +-----+      |
> +--> |                    |--+  |     |------+
>      | CPU1:vbq free_list |     | vb2 |
> +--- |                    |<----|     |<-----+
> |    +--------------------+     +-----+      |
> +--------------------------------------------+
> Here’s a list breakdown. All vbs, which were to be added to
> ‘prev’, cannot be used by list_for_each_entry_rcu(vb, &vbq->free,
> free_list) in vb_alloc(). Thus, vmalloc space is exhausted.
>
> This issue affects both erofs and f2fs, the stacktrace is as follows:
> erofs:
> [<ffffffd4ffb93ad4>] __switch_to+0x174
> [<ffffffd4ffb942f0>] __schedule+0x624
> [<ffffffd4ffb946f4>] schedule+0x7c
> [<ffffffd4ffb947cc>] schedule_preempt_disabled+0x24
> [<ffffffd4ffb962ec>] __mutex_lock+0x374
> [<ffffffd4ffb95998>] __mutex_lock_slowpath+0x14
> [<ffffffd4ffb95954>] mutex_lock+0x24
> [<ffffffd4fef2900c>] reclaim_and_purge_vmap_areas+0x44
> [<ffffffd4fef25908>] alloc_vmap_area+0x2e0
> [<ffffffd4fef24ea0>] vm_map_ram+0x1b0
> [<ffffffd4ff1b46f4>] z_erofs_lz4_decompress+0x278
> [<ffffffd4ff1b8ac4>] z_erofs_decompress_queue+0x650
> [<ffffffd4ff1b8328>] z_erofs_runqueue+0x7f4
> [<ffffffd4ff1b66a8>] z_erofs_read_folio+0x104
> [<ffffffd4feeb6fec>] filemap_read_folio+0x6c
> [<ffffffd4feeb68c4>] filemap_fault+0x300
> [<ffffffd4fef0ecac>] __do_fault+0xc8
> [<ffffffd4fef0c908>] handle_mm_fault+0xb38
> [<ffffffd4ffb9f008>] do_page_fault+0x288
> [<ffffffd4ffb9ed64>] do_translation_fault[jt]+0x40
> [<ffffffd4fec39c78>] do_mem_abort+0x58
> [<ffffffd4ffb8c3e4>] el0_ia+0x70
> [<ffffffd4ffb8c260>] el0t_64_sync_handler[jt]+0xb0
> [<ffffffd4fec11588>] ret_to_user[jt]+0x0
>
> f2fs:
> [<ffffffd4ffb93ad4>] __switch_to+0x174
> [<ffffffd4ffb942f0>] __schedule+0x624
> [<ffffffd4ffb946f4>] schedule+0x7c
> [<ffffffd4ffb947cc>] schedule_preempt_disabled+0x24
> [<ffffffd4ffb962ec>] __mutex_lock+0x374
> [<ffffffd4ffb95998>] __mutex_lock_slowpath+0x14
> [<ffffffd4ffb95954>] mutex_lock+0x24
> [<ffffffd4fef2900c>] reclaim_and_purge_vmap_areas+0x44
> [<ffffffd4fef25908>] alloc_vmap_area+0x2e0
> [<ffffffd4fef24ea0>] vm_map_ram+0x1b0
> [<ffffffd4ff1a3b60>] f2fs_prepare_decomp_mem+0x144
> [<ffffffd4ff1a6c24>] f2fs_alloc_dic+0x264
> [<ffffffd4ff175468>] f2fs_read_multi_pages+0x428
> [<ffffffd4ff17b46c>] f2fs_mpage_readpages+0x314
> [<ffffffd4ff1785c4>] f2fs_readahead+0x50
> [<ffffffd4feec3384>] read_pages+0x80
> [<ffffffd4feec32c0>] page_cache_ra_unbounded+0x1a0
> [<ffffffd4feec39e8>] page_cache_ra_order+0x274
> [<ffffffd4feeb6cec>] do_sync_mmap_readahead+0x11c
> [<ffffffd4feeb6764>] filemap_fault+0x1a0
> [<ffffffd4ff1423bc>] f2fs_filemap_fault+0x28
> [<ffffffd4fef0ecac>] __do_fault+0xc8
> [<ffffffd4fef0c908>] handle_mm_fault+0xb38
> [<ffffffd4ffb9f008>] do_page_fault+0x288
> [<ffffffd4ffb9ed64>] do_translation_fault[jt]+0x40
> [<ffffffd4fec39c78>] do_mem_abort+0x58
> [<ffffffd4ffb8c3e4>] el0_ia+0x70
> [<ffffffd4ffb8c260>] el0t_64_sync_handler[jt]+0xb0
> [<ffffffd4fec11588>] ret_to_user[jt]+0x0
>
> To fix this, replace xa_for_each() with list_for_each_entry_rcu()
> which reverts commit fc1e0d980037 ("mm/vmalloc: prevent stale TLBs
> in fully utilized blocks")
>
This needs to be modified to your implementation method, introduce cpu in ...

> Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
>
> Cc: stable@vger.kernel.org
> Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
you can add Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com> here.
Because Uladzislau have comment in your v4 patch.
> ---
> v2: introduce cpu in vmap_block to record the right CPU number
> v3: use get_cpu/put_cpu to prevent schedule between core
> v4: replace get_cpu/put_cpu by another API to avoid disabling preemption
> v5: update the commit message by Hailong.Liu
> ---
> ---
>  mm/vmalloc.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..89eb034f4ac6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2458,6 +2458,7 @@ struct vmap_block {
>  	struct list_head free_list;
>  	struct rcu_head rcu_head;
>  	struct list_head purge;
> +	unsigned int cpu;
>  };
>
>  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> @@ -2585,8 +2586,15 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  		free_vmap_area(va);
>  		return ERR_PTR(err);
>  	}
> -
> -	vbq = raw_cpu_ptr(&vmap_block_queue);
> +	/*
> +	 * list_add_tail_rcu could happened in another core
> +	 * rather than vb->cpu due to task migration, which
> +	 * is safe as list_add_tail_rcu will ensure the list's
> +	 * integrity together with list_for_each_rcu from read
> +	 * side.
> +	 */
> +	vb->cpu = raw_smp_processor_id();
> +	vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu);
>  	spin_lock(&vbq->lock);
>  	list_add_tail_rcu(&vb->free_list, &vbq->free);
>  	spin_unlock(&vbq->lock);
> @@ -2614,9 +2622,10 @@ static void free_vmap_block(struct vmap_block *vb)
>  }
>
>  static bool purge_fragmented_block(struct vmap_block *vb,
> -		struct vmap_block_queue *vbq, struct list_head *purge_list,
> -		bool force_purge)
> +		struct list_head *purge_list, bool force_purge)
>  {
> +	struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, vb->cpu);
> +
>  	if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
>  	    vb->dirty == VMAP_BBMAP_BITS)
>  		return false;
> @@ -2664,7 +2673,7 @@ static void purge_fragmented_blocks(int cpu)
>  			continue;
>
>  		spin_lock(&vb->lock);
> -		purge_fragmented_block(vb, vbq, &purge, true);
> +		purge_fragmented_block(vb, &purge, true);
>  		spin_unlock(&vb->lock);
>  	}
>  	rcu_read_unlock();
> @@ -2801,7 +2810,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
>  			 * not purgeable, check whether there is dirty
>  			 * space to be flushed.
>  			 */
> -			if (!purge_fragmented_block(vb, vbq, &purge_list, false) &&
> +			if (!purge_fragmented_block(vb, &purge_list, false) &&
>  			    vb->dirty_max && vb->dirty != VMAP_BBMAP_BITS) {
>  				unsigned long va_start = vb->va->va_start;
>  				unsigned long s, e;
> --
> 2.25.1
>

--
help you, help me,
Hailong.

