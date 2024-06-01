Return-Path: <stable+bounces-47825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321208D7110
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 18:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44761282575
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E795C82482;
	Sat,  1 Jun 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="apGZoWVC"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2085.outbound.protection.outlook.com [40.107.255.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D71DFF8
	for <stable@vger.kernel.org>; Sat,  1 Jun 2024 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717258711; cv=fail; b=qS0Kd4vpBq4qSCc6YFOU2mNqaO9XRGRtFfJfSULYOyHedOMWMSSLWaedhjPcw0xXjDyMiX4Bo+x0LA8QBA8A5UFNWnNZYAcx8nPPoqUaUhPkqnboA0GfoL5U21UkuLXmF0aRELIXXWZGsIKigN4grsclv5DyPvzbCsHNh0nuE80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717258711; c=relaxed/simple;
	bh=tjuM/B9q0yu6gEUBlJ5obG1R9oMxX//0NA3nO9z/J7A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y40AKJffBSh1RoPjyxz9LRt1E67FzlyvQCGhibU5r7Aj0Vd8gfTNeZ+IXwi4aq309gm16hRdETHt6fGzxNDYlvDHVrQZuziSnAeKvioo8M8dHim235d8j7ek7G1hOPuJlQHbF0mr6vh32lcVGHtvS6zbBGoJYfwbnmDUO44SCaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=apGZoWVC; arc=fail smtp.client-ip=40.107.255.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al/z4EYeihTzmqKFtUOIAnRWBddTMUqNJSk3UIeMBLkQHNy+ZnDDr4QnXuv4LojBMvLcviMkrd574z+NpPHlkcT+nRKPDRgNtqwCV7A4YK8PfZSdpmaOpNMniipyPCa3x7DvRU56pV3CDIy0zqYAzeyOh3ERZZINdnKEHK2hgk8hYmqCeUOf+eBBETysCAWf19bfG0NfCv/BV96AzxEx4+eq9xuqCSvxcTW5bC6/knanaj0uzbfVqjylowzQk1ubJ+En9uy94826zA0NayNbG5TUHbtmfCXhHJSreFmUAtJTfjRuiXUnBYzXNE/cE9FutYP05ZWV3HZWDs+YUKwbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7y67qaU1kqBHwSos1f3i9lZOIXK6gfW3cLnVsxmqoY=;
 b=ZBeRT49UyUQpo2KxjsSy1cS55//ivPHKe6liNbLxwIwTosqtU7QLE8vof96c7tKV+wKR5WU/yc+3NUqN3WzsQuXGJoiVkRr0PsSI2QfbkPCkxZK8sk9/5l1wOw4YtASe/C48kiffaYx6FRbIvVy/pzi0veTBrbURYk/nRfd/mUHjqUQqYujd/jIpjKFvCuOixKnB2KIerjJGAo/VesT07uRmT/XSUF9UAn+O/4dWH2NuF6LynE/SeZQ8XJXg3VGWBE+7UqywnpM+Wyt8eyMym5+/E1r3aNhPyEll0SnJivNLneOykTS5fLlyB43k5NunNueVhQ3r59wyoA2CscTOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=outlook.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7y67qaU1kqBHwSos1f3i9lZOIXK6gfW3cLnVsxmqoY=;
 b=apGZoWVC8XuY0NujBySMNq3kjFCJ6Wv/k02MCL9SKKdPZEbKj4im+hCXTN72Vso0VQDbG9yg/jXIzApHGZGZ+luCdG8kaBr68LMKRl+9ibY1n+Num13snnK60OG2QNA2mPz4WJzDf8m4Ul1HHP5HearYAij1Z5H5bvhWnHVgOzU=
Received: from SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15) by
 SEZPR02MB7135.apcprd02.prod.outlook.com (2603:1096:101:194::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Sat, 1 Jun
 2024 16:18:23 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:b0:cafe::75) by SGBP274CA0003.outlook.office365.com
 (2603:1096:4:b0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Sat, 1 Jun 2024 16:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Sat, 1 Jun 2024 16:18:23 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Jun
 2024 00:18:21 +0800
From: <hailong.liu@oppo.com>
To: <hailong.liu.linux@outlook.com>
CC: Hailong.Liu <hailong.liu@oppo.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] mm/vmalloc: fix corrupted list of vbq->free
Date: Sun, 2 Jun 2024 00:18:19 +0800
Message-ID: <20240601161819.8229-1-hailong.liu@oppo.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SEZPR02MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: a5743afc-5c34-49ed-5afe-08dc82567593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|32650700008|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVOdEVDZWZlWEtGZFJOSE4yT0xJeGdvYWZEUm9IQ2N1MFllZ0hvb0ZCcEY2?=
 =?utf-8?B?SDV3UE8zenhLTWFBV2lnN3p3Z1pZdC91Y2pKc3BoWDlrbDhiaitmYW9FT1R1?=
 =?utf-8?B?ZnBxTlVDY3A4d25oWWxBR2EwUllpMjRudU1RZUxyTHcvUHNjKzV4K1B3TWJl?=
 =?utf-8?B?VTRzRlptOHE5MmFKNkJmdXQ1T2dNN0tPWmY1N3dvc01Fb21uZHl6NUNtczQ2?=
 =?utf-8?B?TlBET2h6ZkdkcXBMTDV6bGJ1NVZ6ZWlHNk9IMWMxcUhsaHQ3clNDUjFGbzdV?=
 =?utf-8?B?ejc5TVNEVGxCd3RIRjI1SnNxNVJOQmQxYThZdWI1RmV4d0V3TFVweHkxUTF1?=
 =?utf-8?B?MVVCMUxkbTBQOVJ0Kzd6clY1S241NXRVbnduZUdQOHdjOHp4eitpWFQ4eGs5?=
 =?utf-8?B?NUJ3NzEwWFVPNDJ5WVQycDN1K1ZERmxsVnF6alFRSndYQ2E1aXNLb1BwM0Yr?=
 =?utf-8?B?aWZpNGhSSDh0VmRsVU9idEdWaVNoZzJld2VBaS81UXYxNXcxRk1KaU5RNWZh?=
 =?utf-8?B?UWhGTS9jNnVaeDc2N3lmcnd3UXViVmpZMzJvVStsSyt1SElpM1ZzRnZDUmY3?=
 =?utf-8?B?aTZ2bVJMYUlkTXVXaDBSMUF0dkdxV3hiL2dHYVhIVEpVR3hPNU9SVUNQNXJF?=
 =?utf-8?B?U0FpVEdVV3JUZ3BmU2Q2cHQySEpmcjBKaXNEQ2c2TjNVSGRwdTl0N2hLZito?=
 =?utf-8?B?RlJoNUJTREY3N3R0c0daRzVvSnFTN2FiOWJmVW94aHNiSnNzNTFXWHRsSWI2?=
 =?utf-8?B?SjhGTmVGeXd6VU1jYWsrUEtBZTZ5UjNXUldLS2dqVUxldC9MaEtNZVNZWmt2?=
 =?utf-8?B?a0NLbnMxaHZLNHYxZ2ZLSkI0L0Q1Qm5UYlA2YUdwWmNZT1lrck1rczUzc29a?=
 =?utf-8?B?T1dWNm1FdlBYZGF2Q3RJTVJOYTFhUlQwVm1ZRDkrZWdXOGJia0c3N0licy9E?=
 =?utf-8?B?Sm1kWkFjSWJZU1V4Zkd1SGJLcnRXMVg2SjJ6Nmd2cC9FYWttUmZta3dXZE50?=
 =?utf-8?B?a2F2SWZYbm9wMThqR0VJQ25JZ1ZieG9wY3RxVzg0cklwR2hNZkNBMkdOcUM4?=
 =?utf-8?B?RFFYVzRKd040TWQrMEJiVHpyWU9vdFdMTWI3T21tbTVGMzlnNVdwSXRmMmwz?=
 =?utf-8?B?YlRDZHJMcHg1Q043MEJreGRHODBoUzJJYi9YMlE3SE5UZ0VIOXVNdmplK3pX?=
 =?utf-8?B?NFkrWlQvQ2h1U0NtcUt2ZWpmeGpNS2dUMFY5TmtYRmcycEJlcGdpdWJSNzZ6?=
 =?utf-8?B?eVk2VllIdXl0Tm1kaTVSalAySVZjbDNDMDJ6QWFXbWg1cDdaS1NjdWwxMHdW?=
 =?utf-8?B?QjRwNWl1UGhhS1h2Si9BSE96ZFVabFg0N0tSRlQxN1dRaFZ0VjNuZng5VlV4?=
 =?utf-8?B?MWhudDlNdnVXTTNXblZSejlmaUR6bkRPcFQzaU8rWWtnOFVBay90Sk1LMGFQ?=
 =?utf-8?B?aXh2N1ZlOGZqeWJvRTUyby96eUlFRkc5N2JjbUdLcFhLQ3oxT25rMFdKb3ZD?=
 =?utf-8?B?S1U4eEhWNGh6dFp5b0psQVIxSEJyUmJMRnR0U2pJTlRVQ08zMDVpWFBFMWVP?=
 =?utf-8?B?bXhsQm5JMUtsekRhdk10RnRheDVEU3cyazBnWitvd2YrUDlrUTY0Z01OOXl0?=
 =?utf-8?B?NG84bk8yTSt2WG1PVjJLb0JJcHZzdGFrN21uMmJMRDB1c3FxN0xZK3duLzZC?=
 =?utf-8?B?OUk1TWZmMm9SRThBWnpGRXdYaXRWL0RCZnBhYzh6TXF3YkpZcDVpd2VHVThx?=
 =?utf-8?B?ZDF0UmpnUkJNMnhIMUxMRFc4QitLUmNldkNvakFuWGhxS1dGY045eGlrTEgv?=
 =?utf-8?Q?BRDJuR+QWFCbt/yWL52IUetRD873crQZywjRk=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(32650700008)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 16:18:23.0063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5743afc-5c34-49ed-5afe-08dc82567593
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7135

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

To fix this, introduce vbq->lock in vmap_block.

Cc: <stable@vger.kernel.org>
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
-- 
2.34.1


