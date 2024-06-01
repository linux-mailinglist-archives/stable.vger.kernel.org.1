Return-Path: <stable+bounces-47827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 715128D714F
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9535282A06
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D76154BE0;
	Sat,  1 Jun 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="hnEwLTJL"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2057.outbound.protection.outlook.com [40.107.255.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6CA14E2EF;
	Sat,  1 Jun 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717262040; cv=fail; b=fPPUmgPPl1KLqWknhkB8npb/LiczwANhjmc7JNGqpc+DsMI9yg2Fw/HjxjXsDrpKZrSode8A5vh8q5Qf1LV73TKRi7dTztcBhw6VEhymcLMhvMSh84iW9mqca4Cvm8KrF20xjabVijd7o+/CsaowdLxeCxTLeWtepqmfowyOIUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717262040; c=relaxed/simple;
	bh=mgl4gjj73TrY1xx2ezESkYLEhKqR2lzCjUo5+GVrFVU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QjMuTS9VaeP6AGt7YjoOgr7dzj6ZHKxBWdm97mmaDzTIPMAJsjbDLFrsYLyn7U2zqBqtAxNpM3NlUS9AmLIxkz1bZML8CnawBk0lDXVTfzmv/4fIeKTbz//kTk3CnbfJrILWZI12JwQIfO0YG42dKFwAMsNChtshKCA3G9rginA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=hnEwLTJL; arc=fail smtp.client-ip=40.107.255.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP2rVo1FN5imyqnKGLwMJ+5+b5QT+INrlhpPdpvzFv7H1ldccG/1o6FMBZShXGVed8RvHZbLhmMCFtCKCpEQefIYihmlU8rNA2Ht/VPp0If21FVnrU+B9TQAMxqXWroks3PKLBY/Akzyqqh49MRasb6a8FOZl7CN/Ylf8xNVpeyR3+P29/pMtAWV09bsOdtm7l9ASox6gdroOlMAIHOtIjO/TxsIQGJSbwq7FCov8kAATGS0eJJ/vC+dFKcG4pvlQj71ZL7HcEymLTBYwUalGG3xjOy8ptiEipLC0VpbsmKUT1e80YMFgy4/gGLxyXU8pI3GdO0V9GSonfT1EQ+ffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqOgLgthzn1qLp3kbc5ZQt6YMy04O74tT8zw4l/e2+I=;
 b=gtqw/7FpwXFR+eJ8yjugRQeeBVfSA22iv1hiwdDkU+v5zN49E864RU5868EdzCAXR6WaCgJfrkliWiFHyp5M7vfjPZ2AqY2+eKtpRZ6v4lUJUfahwPtPvO/QTL1AvCuPMd39UlS+9fm79ZH0A1y9uRPQuY06e0YMcZgPbv88X6x85ioOntN6yMvs7WinYt9gapAUOTTtp0QNrl1as8cqOQo4hJP9y23zz36kaixeieYDakAh2HuYdHaSEfc24HBCWmyD6ppXITG7B5nN1vIG/21lq3gSU/TlGkDVDJtEeLWBxnY49ctgsAI4iASsL/wsb/pV9quZ0gwSMc0jmv2n/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqOgLgthzn1qLp3kbc5ZQt6YMy04O74tT8zw4l/e2+I=;
 b=hnEwLTJLax5uyRWYxtSJN90l5ZUf2bT8ea02fj0lcOLyIPEteGOZD+vIgfThjEPc66w7FLfBbgYGJ42PeBJfoqwAemOHr1PYna4mj86YQl4UAWvMuTdquWFSl86+GOssQ44OimoXWl2EIkoTEsAyESLIeLrk8tFZPU95tl100ZE=
Received: from SG2PR06CA0182.apcprd06.prod.outlook.com (2603:1096:4:1::14) by
 KL1PR02MB7042.apcprd02.prod.outlook.com (2603:1096:820:10a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Sat, 1 Jun 2024 17:13:52 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:4:1:cafe::75) by SG2PR06CA0182.outlook.office365.com
 (2603:1096:4:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Sat, 1 Jun 2024 17:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Sat, 1 Jun 2024 17:13:51 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Jun
 2024 01:13:51 +0800
From: <hailong.liu@oppo.com>
To: <akpm@linux-foundation.org>
CC: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <guangye.yang@mediatek.com>, <zhaoyang.huang@unisoc.com>,
	<tglx@linutronix.de>, Hailong.Liu <hailong.liu@oppo.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v3] mm/vmalloc: fix corrupted list of vbq->free
Date: Sun, 2 Jun 2024 01:13:28 +0800
Message-ID: <20240601171328.9799-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|KL1PR02MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: 66156564-8491-4aa7-0210-08dc825e35ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzZ0WlRjbmxHRXNsSm5NS0hRSCsyVk9LcHc1STg5R3NySmZxYXg5SXhWM1FW?=
 =?utf-8?B?YzlrRnZnTzdiVHQwMncwa2RqQWhZK284UVdJVE5OOWlNR0E2MzhNSWNRQnFl?=
 =?utf-8?B?VlFNSEZWNEdubkNRd1lvSE1GZ3dEVWI0RVFFTytwKzRvVUtEL2JlQW1FQ1hl?=
 =?utf-8?B?aHdoWllLSmdzNG5lZEp0ZWtSbkk5bm83b1ovSVowcHBqdlk1enVNM2pDZHlw?=
 =?utf-8?B?UUhvRThkKzhuSDVOL3k5cFBlNkRQYXBUZFl4SktzcGdxT1hVbEtoNlV3QUgv?=
 =?utf-8?B?a29OZGJiSTAzV0JQL1kvSElZdmUwN1doT1JTUHdVQVozSDNzL2NSaldQTTRX?=
 =?utf-8?B?NGMyME9raXc3TFpsNGpJdWhnRk9ncjgrcDNCMHoyTElRRHAvZkQ1VTMzVVdU?=
 =?utf-8?B?TUtHaDJVaCt3V3NNMFQ2cE9uOG1iWnlYWmxyRXFOTDRCa2JtdzhkTlZLQld4?=
 =?utf-8?B?M1ZHOHdTUGx5dHVvTGZycjc1RUxkaGNNOGl0Vm9yYjJHeDRBQUFZbnV2RXlP?=
 =?utf-8?B?eHlxUEUvOFpnV2lPNHZoR0w1TTB5QmFXUW42Z0dMZWwzc1phR2oxb2o5dEtN?=
 =?utf-8?B?VXh1TDJzRjlkczBVNXg0U20zdVRCd3FZMnVKSG9IKzQ0TzVQMjlEbXBJdUVK?=
 =?utf-8?B?RkJiRTNjVzl4K3lDVVdLZitUeTlURmVwczdibzM5d1VRUko0Wm56MG1ScWpw?=
 =?utf-8?B?a09Xdnl5dVhzUVRZNGVlU090NnlrbVhELzhXOGxUdjgwSmc0ZFNaTmpYR2Ux?=
 =?utf-8?B?SXRCLzhKWDh6a2RwOUxRNC9KMkc1cG1vU2pEaStuQkt1ZTdvVVU1RzZueXFW?=
 =?utf-8?B?OStXeEN2OTQ4MXYwbmxJck5zMFYyTG9SZUlzMkI2QTJ6dVZTd1NlMGRsSXpy?=
 =?utf-8?B?OEtlQ3N5UDFYNnUweVlaT2ExYnp5VDV0YWs0Wk83OEpIM0pJOEEyNGZUcDFN?=
 =?utf-8?B?Nm5MK0Z4WE5OV3NVK3BEWGp0cUtMYXo3R1MwUGlpZXB1VDBDM05ZeG5Eankw?=
 =?utf-8?B?dnRuQ09YakJtYnhWSmw5eGNrMWJ1ZTY0eFF5L0Jpd1I0N0g4T0VFRnpmLy94?=
 =?utf-8?B?cktHSVFRUy85bDNJV2JCTUsvZlRTVFRSU2FZSmk5bnpRci9uUmI1QzRCOHda?=
 =?utf-8?B?RlY2MEc4TVdTNkpjQWJEYmI5WUNMQ1c3bGFTWTFTN25ySkZTekFQcWdyd1VZ?=
 =?utf-8?B?dWVBQWh2TjBacG5FQ292ZURYcFR6VmRieEtQZWpIdzEyUksrYmFsc0RkQW9v?=
 =?utf-8?B?Y21xR3pSZGRocDA5VGpIWG81RVloMU5GOGJKU0ZsZnlZa05aQ1JvVFBkTnQ2?=
 =?utf-8?B?QzlWa2lzbU04NllORDRpUEtUZ1IyK083Rm5RM2pnVGNKbGJzR3JFdndGYWFB?=
 =?utf-8?B?RXNZMitydUFZK3pTQUVLOVI0NzNSWjAzUW9nTXpENVN6c21qSHcxQXlrbEFM?=
 =?utf-8?B?aU1lbGN3V3NTbTU0S1pmTzcwei9TWFlPOFlFNmN5TWUzZzhYNlMwUkZZS2U0?=
 =?utf-8?B?c0RIc3hyODJiQlphWXZOMkkrVHltVlpxd3huZ1c3NS9JR2ZQV2VlTHJ2TEtF?=
 =?utf-8?B?UnJ3QWoxYzQzOFZCMmxHS1RrUm43c21wZUoyM0ZnUlhSTEIrcWpyVUJ3b3Jk?=
 =?utf-8?B?dVJqU1M5c0pvbW5seEw2NG5TcnJaQUdJTjNuWU9adWtON0lpdCtZbFFVQ05y?=
 =?utf-8?B?a3dlWS8rOC8yd0cwR1hWakZRQVlNbUxiblFKdyt6UzdrdnJuNkswb3o5OWFH?=
 =?utf-8?Q?PLb3D80Dnl51zUjbXMYb08ztU7uY3TT2jOd55+f?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 17:13:51.9173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66156564-8491-4aa7-0210-08dc825e35ca
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7042

From: "Hailong.Liu" <hailong.liu@oppo.com>

The function xa_for_each() in _vm_unmap_aliases() loops through all
vbs. However, since commit 062eacf57ad9 ("mm: vmalloc: remove a global
vmap_blocks xarray") the vb from xarray may not be on the corresponding
CPU vmap_block_queue. Consequently, purge_fragmented_block() might
use the wrong vbq->lock to protect the free list, leading to vbq->free
breakage.

Incorrect lock protection can exhaust all vmalloc space as follows:
CPU0                                            CPU1
+--------------------------------------------+
|    +--------------------+     +-----+      |
+--> |                    |---->|     |------+
     | CPU1:vbq free_list |     | vb1 |
+--- |                    |<----|     |<-----+
|    +--------------------+     +-----+      |
+--------------------------------------------+

_vm_unmap_aliases()                             vb_alloc()
                                                new_vmap_block()
xa_for_each(&vbq->vmap_blocks, idx, vb)
--> vb in CPU1:vbq->freelist

purge_fragmented_block(vb)
spin_lock(&vbq->lock)                           spin_lock(&vbq->lock)
--> use CPU0:vbq->lock                          --> use CPU1:vbq->lock

list_del_rcu(&vb->free_list)                    list_add_tail_rcu(&vb->free_list, &vbq->free)
    __list_del(vb->prev, vb->next)
        next->prev = prev
    +--------------------+
    |                    |
    | CPU1:vbq free_list |
+---|                    |<--+
|   +--------------------+   |
+----------------------------+
                                                __list_add(new, head->prev, head)
+--------------------------------------------+
|    +--------------------+     +-----+      |
+--> |                    |---->|     |------+
     | CPU1:vbq free_list |     | vb2 |
+--- |                    |<----|     |<-----+
|    +--------------------+     +-----+      |
+--------------------------------------------+

        prev->next = next
+--------------------------------------------+
|----------------------------+               |
|    +--------------------+  |  +-----+      |
+--> |                    |--+  |     |------+
     | CPU1:vbq free_list |     | vb2 |
+--- |                    |<----|     |<-----+
|    +--------------------+     +-----+      |
+--------------------------------------------+
Here’s a list breakdown. All vbs, which were to be added to
‘prev’, cannot be used by list_for_each_entry_rcu(vb, &vbq->free,
free_list) in vb_alloc(). Thus, vmalloc space is exhausted.

This issue affects both erofs and f2fs, the stacktrace is as follows:
erofs:
[<ffffffd4ffb93ad4>] __switch_to+0x174
[<ffffffd4ffb942f0>] __schedule+0x624
[<ffffffd4ffb946f4>] schedule+0x7c
[<ffffffd4ffb947cc>] schedule_preempt_disabled+0x24
[<ffffffd4ffb962ec>] __mutex_lock+0x374
[<ffffffd4ffb95998>] __mutex_lock_slowpath+0x14
[<ffffffd4ffb95954>] mutex_lock+0x24
[<ffffffd4fef2900c>] reclaim_and_purge_vmap_areas+0x44
[<ffffffd4fef25908>] alloc_vmap_area+0x2e0
[<ffffffd4fef24ea0>] vm_map_ram+0x1b0
[<ffffffd4ff1b46f4>] z_erofs_lz4_decompress+0x278
[<ffffffd4ff1b8ac4>] z_erofs_decompress_queue+0x650
[<ffffffd4ff1b8328>] z_erofs_runqueue+0x7f4
[<ffffffd4ff1b66a8>] z_erofs_read_folio+0x104
[<ffffffd4feeb6fec>] filemap_read_folio+0x6c
[<ffffffd4feeb68c4>] filemap_fault+0x300
[<ffffffd4fef0ecac>] __do_fault+0xc8
[<ffffffd4fef0c908>] handle_mm_fault+0xb38
[<ffffffd4ffb9f008>] do_page_fault+0x288
[<ffffffd4ffb9ed64>] do_translation_fault[jt]+0x40
[<ffffffd4fec39c78>] do_mem_abort+0x58
[<ffffffd4ffb8c3e4>] el0_ia+0x70
[<ffffffd4ffb8c260>] el0t_64_sync_handler[jt]+0xb0
[<ffffffd4fec11588>] ret_to_user[jt]+0x0

f2fs:
[<ffffffd4ffb93ad4>] __switch_to+0x174
[<ffffffd4ffb942f0>] __schedule+0x624
[<ffffffd4ffb946f4>] schedule+0x7c
[<ffffffd4ffb947cc>] schedule_preempt_disabled+0x24
[<ffffffd4ffb962ec>] __mutex_lock+0x374
[<ffffffd4ffb95998>] __mutex_lock_slowpath+0x14
[<ffffffd4ffb95954>] mutex_lock+0x24
[<ffffffd4fef2900c>] reclaim_and_purge_vmap_areas+0x44
[<ffffffd4fef25908>] alloc_vmap_area+0x2e0
[<ffffffd4fef24ea0>] vm_map_ram+0x1b0
[<ffffffd4ff1a3b60>] f2fs_prepare_decomp_mem+0x144
[<ffffffd4ff1a6c24>] f2fs_alloc_dic+0x264
[<ffffffd4ff175468>] f2fs_read_multi_pages+0x428
[<ffffffd4ff17b46c>] f2fs_mpage_readpages+0x314
[<ffffffd4ff1785c4>] f2fs_readahead+0x50
[<ffffffd4feec3384>] read_pages+0x80
[<ffffffd4feec32c0>] page_cache_ra_unbounded+0x1a0
[<ffffffd4feec39e8>] page_cache_ra_order+0x274
[<ffffffd4feeb6cec>] do_sync_mmap_readahead+0x11c
[<ffffffd4feeb6764>] filemap_fault+0x1a0
[<ffffffd4ff1423bc>] f2fs_filemap_fault+0x28
[<ffffffd4fef0ecac>] __do_fault+0xc8
[<ffffffd4fef0c908>] handle_mm_fault+0xb38
[<ffffffd4ffb9f008>] do_page_fault+0x288
[<ffffffd4ffb9ed64>] do_translation_fault[jt]+0x40
[<ffffffd4fec39c78>] do_mem_abort+0x58
[<ffffffd4ffb8c3e4>] el0_ia+0x70
[<ffffffd4ffb8c260>] el0t_64_sync_handler[jt]+0xb0
[<ffffffd4fec11588>] ret_to_user[jt]+0x0

To fix this, introduce vbq_lock in vmap_block.

Cc: <stable@vger.kernel.org>
Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
Suggested-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
---
 mm/vmalloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 125427cbdb87..f4cfdf3fd925 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2467,6 +2467,7 @@ struct vmap_block_queue {

 struct vmap_block {
 	spinlock_t lock;
+	spinlock_t *vbq_lock;
 	struct vmap_area *va;
 	unsigned long free, dirty;
 	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
@@ -2603,6 +2604,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	}

 	vbq = raw_cpu_ptr(&vmap_block_queue);
+	vb->vbq_lock = &vbq->lock;
 	spin_lock(&vbq->lock);
 	list_add_tail_rcu(&vb->free_list, &vbq->free);
 	spin_unlock(&vbq->lock);
@@ -2630,7 +2632,7 @@ static void free_vmap_block(struct vmap_block *vb)
 }

 static bool purge_fragmented_block(struct vmap_block *vb,
-		struct vmap_block_queue *vbq, struct list_head *purge_list,
+		struct list_head *purge_list,
 		bool force_purge)
 {
 	if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
@@ -2647,9 +2649,9 @@ static bool purge_fragmented_block(struct vmap_block *vb,
 	WRITE_ONCE(vb->dirty, VMAP_BBMAP_BITS);
 	vb->dirty_min = 0;
 	vb->dirty_max = VMAP_BBMAP_BITS;
-	spin_lock(&vbq->lock);
+	spin_lock(vb->vbq_lock);
 	list_del_rcu(&vb->free_list);
-	spin_unlock(&vbq->lock);
+	spin_unlock(vb->vbq_lock);
 	list_add_tail(&vb->purge, purge_list);
 	return true;
 }
@@ -2680,7 +2682,7 @@ static void purge_fragmented_blocks(int cpu)
 			continue;

 		spin_lock(&vb->lock);
-		purge_fragmented_block(vb, vbq, &purge, true);
+		purge_fragmented_block(vb, &purge, true);
 		spin_unlock(&vb->lock);
 	}
 	rcu_read_unlock();
@@ -2817,7 +2819,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 			 * not purgeable, check whether there is dirty
 			 * space to be flushed.
 			 */
-			if (!purge_fragmented_block(vb, vbq, &purge_list, false) &&
+			if (!purge_fragmented_block(vb, &purge_list, false) &&
 			    vb->dirty_max && vb->dirty != VMAP_BBMAP_BITS) {
 				unsigned long va_start = vb->va->va_start;
 				unsigned long s, e;
---
Changes since v2 [2]:
- simply revert the patch has other effects, per Zhaoyang

Changes since v1 [1]:
- add runtime effect in commit msg, per Andrew.

BTW,

1. use xa_for_each to iterate all vb, we need a mapping from vb to vbq.
Zhaoyang use cpuid to get vbq as follows:
https://lore.kernel.org/all/20240531030520.1615833-1-zhaoyang.huang@unisoc.com/
IMO, why not just store the address of the lock, which might waste a few more
bytes but would look clearer.

Baoquan and Hillf save directly to the queue correspoding to va,
-	vbq = raw_cpu_ptr(&vmap_block_queue);
+	vbq = container_of(xa, struct vmap_block_queue, vmap_blocks);
 	spin_lock(&vbq->lock);
,

 /*
  * We should probably have a fallback mechanism to allocate virtual memory
  * out of partially filled vmap blocks. However vmap block sizing should be
@@ -2626,7 +2634,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 		return ERR_PTR(err);
 	}

-	vbq = raw_cpu_ptr(&vmap_block_queue);
+	vbq = addr_to_vbq(va->va_start);
If in this case we actually don't need the percpu variable at all, because
each address directly to the correspoding index through hash function.

Does anyone have a btter suggestion?

https://lore.kernel.org/all/ZlqIp9V1Jknm7axa@MiWiFi-R3L-srv/

[1] https://lore.kernel.org/all/20240530093108.4512-1-hailong.liu@oppo.com/
[2] https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.com/
--
2.34.1

