Return-Path: <stable+bounces-43529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845158C2185
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAFDBB20CA8
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 10:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256FE165FA0;
	Fri, 10 May 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="jkhq5wjO"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2043.outbound.protection.outlook.com [40.107.117.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577F4AEFA;
	Fri, 10 May 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335314; cv=fail; b=a/DiTRMtkEGVVkYgqxQvUMa0s6y+XJfdRPaj1cqMLS3OHuCrk/badRkVIw5NT91wY3llsiWVUxMeMvsbbIrDBb5QvQ5kUxaPxl62ApeReLDM6S4RjWtKiIWiHmpzjG4r2j7y8l7/57juxjKmh4L+8WBgTLmDe4khGxuDZ5AS5rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335314; c=relaxed/simple;
	bh=JGXVP3NkGWZ8c53BS/ygyeWVONyrdRcIEzpgczXEeg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=koaxZfze5cBSpIBhV0viXkvbJQ5bmDtugpm5JqkQkk5oiFS56ou3TUIiqeQlxrNnvVFdJ+4lVNHX5TkHz2Us45ioNFXxvoPujb40zV7rMnalgHYl25qHnp08HWEMuFSyMJQzINoq9QQZ6eaYIHGXncbLV+O4LZ3NANIarjfhYDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=jkhq5wjO; arc=fail smtp.client-ip=40.107.117.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuTDO2qLskf141dEw6aN0mplcGa/HezeVoWvZsoXKBlEqrEssKfDeBnT4mHSRLLpR13dSQDYSNo5hiKu2RI5nIWCjkptfaU8X7I+qhRX4vPECyopWB2YFTuIkmMN5cCCSJ0TmAaRYHUOF4Pa/zLlOiLZB7LrlLQKoh5gv0uApe6T+mi+6jw210Cz5ncX59LjMhmcvGNPUB5YXOepoFTUh6jlLqPLskVlr85ZfwmDnyjbbDMcu7Cf9iEuJqTSzgmGvZPSUIHOQkXsJ8Cunls80DIFrlube8/BBd34H/q37g4AoGBHx4ESRLJr5StgmzYaXSgmMEyD5ihDNAFWVCUPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKLdzosIdGgv2QIDSek4xu8G6B6eszpULhk2vpR/8V0=;
 b=Z8+WEyMbCn79JRO4vKTr9J7A0mSB5HKjUzcm0ZDRZciocnHynlGORayS0+bFLT18PzNV+T8qeWXCsN0gdZo0kTCwQgPOxjq0Oa/9IyZ6rbE59PXFeeKuGKGH9jlHMvqPD+vcWm7zZ4Mi9T1P8LF7LbhHyc9QX8rVkNNM2oB+dNxxgwDpDtFaFLIjGVrcLQ7WulMFbhe90Sq2HI8AD6TKESBR+GEB3MtYQ7Tk3DYxcvqcT9FNXtlZq8oTyKMIDdiOfAAQy8EE/nJqVuFhEB2ae5mrEzwx9MWXSrdIg8zOfIhZqCKqf6aLcVk8alcGt5sltFrcRrBkX5MzUijEZkaO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKLdzosIdGgv2QIDSek4xu8G6B6eszpULhk2vpR/8V0=;
 b=jkhq5wjOc3FA9o0JSljxEXySM2DKNRLDdgd7t0RywNs7kj6aXd/IUq6sdNn2uHdrYfTklQP57KVTNIg2cqvaIwUs/lCq3wZnqny04zHMTIZ3tYHh+acLA9gAE+MA3I+I6klmF609MVy9ZWp0qsh7rBhOeJjvt7w1AYlqQ+dbN2g=
Received: from SI2PR06CA0011.apcprd06.prod.outlook.com (2603:1096:4:186::16)
 by PUZPR02MB6307.apcprd02.prod.outlook.com (2603:1096:301:f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Fri, 10 May
 2024 10:01:47 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:186:cafe::3b) by SI2PR06CA0011.outlook.office365.com
 (2603:1096:4:186::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 10:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 10:01:46 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 May
 2024 18:01:46 +0800
From: <hailong.liu@oppo.com>
To: <akpm@linux-foundation.org>
CC: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <chao@kernel.org>, <mhocko@suse.com>, Hailong.Liu
	<hailong.liu@oppo.com>, <stable@vger.kernel.org>, Oven
	<liyangouwen1@oppo.com>
Subject: [PATCH v2] mm/vmalloc: fix vmalloc which may return null if called with __GFP_NOFAIL
Date: Fri, 10 May 2024 18:01:31 +0800
Message-ID: <20240510100131.1865-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|PUZPR02MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 23494940-940c-4c52-9147-08dc70d83426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DwffEpv7IPxFQp9+odnMvj11TR7agAqakRvnRVBODm+sP3jNqLNFNmfsWPv3?=
 =?us-ascii?Q?taWsxU3tSwxUHmtRgKwoMKnrxMqKMQ2FmKmAdMwg+0FT1fsaf8NluNiqVNu9?=
 =?us-ascii?Q?5aHEK16pRHFMS2zCO7yYGfsj8NMpniX3+Ei1VVO4zFdD3bH36uICuP16EPig?=
 =?us-ascii?Q?PkCD36dTtZqmlqMIAtka4HlR5wNyCYrM9G6/iGQQadU2VPM2CS6d+t1zjnym?=
 =?us-ascii?Q?6goZvZ9owT2CwW4W0/t11t5jUa4HKnp/qtAZ9pKS81gK7zDLk1PpVT57h4Ul?=
 =?us-ascii?Q?8jEfyC1/JDsVfIAmT74BFat3hgVyaO5yIFJufgH9dGT1vgA6X5MGV2jA+ShZ?=
 =?us-ascii?Q?FLkZ7WlozqFu3R7U6NO2eZdBopcZpanOoGZ4aNq86BXk0kZj+HFukZyTHO7S?=
 =?us-ascii?Q?eL+rKgL3DjA64HFp+igEVCMaAs34HMF1r5JxzOtEgepPHcgBfr/jndkcjNjs?=
 =?us-ascii?Q?G17lCcAMtuQojR51jcYUP84y8e1/xcjURANu/WJZcRjLFCn6qYcr4+3XXIEF?=
 =?us-ascii?Q?GT2G4GuHJRluik7dEjKX1bU5S9uF91yuSjg1kSLUxKRjZt/6Lxd23Nk/EyRy?=
 =?us-ascii?Q?oAWodcpsFRumrh17+ABnSGfcFNr3w+gQ+tL7TW119W+3C6xjiDNgtE0fM7gV?=
 =?us-ascii?Q?1fFNHC8kq/YfhQ5Rf5aZhPFhCmpy9IzKHoAHyWtfhGD2lzhLutLCtt/OreoA?=
 =?us-ascii?Q?094/ZUP0dVOIcNM9iPpctwuLnRVizDIe/yH+3HdoHMH00ixVOlZDx77GbEEO?=
 =?us-ascii?Q?3eqALR6d2PZha+KabuhpOW8ZpH5DQZy5QAcN8gzhBox2UjKTY9tf0nVUrmz5?=
 =?us-ascii?Q?QcxdrBhnN6u9CCojw2oURy5h9GewJn4tIg6zBYxdL0c0NzaQ3/RVkF5AV2aS?=
 =?us-ascii?Q?dsvChOmfhbD2GdGIw2cCjNzlWcZSGlh90fBLogg3e6VI0vBuo2DKFRpN1DdY?=
 =?us-ascii?Q?f4aSB1zOzybgTjkL1stXcGmSj58NMeRHUjrKA3pamWRyz5Zd1Qqh3N1Pq2g9?=
 =?us-ascii?Q?NfKZmfHINbvFOcmkUHnn7XhIVzHX9WMdcVHqaLB/YKcq90jwPkjUXrc2miLu?=
 =?us-ascii?Q?s0EwEVHvYHhUnvjzbbpz3gW0gMY2XcpJpYqPyukb0lPBnr2G3XZKCaF0rQeg?=
 =?us-ascii?Q?bRRKW27wOoT1c4MjyLz5jyBbkcaBJPae7wejmguGc4bbb5PCNGN67NvywIiH?=
 =?us-ascii?Q?BL5iPkWFFprUyyLuUXFunfYVfF9WBHpdSxM/gI8C2IeCBI6CrK/XdZbQ05/N?=
 =?us-ascii?Q?XIhK7cyECvP9gWI/5IQEufXgXvkL3vH3+D2QifevBuI9E+XNVUQ3q62C+nVV?=
 =?us-ascii?Q?4dEkw7VQq8/3vgjlLUc+U0MQ?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 10:01:46.9019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23494940-940c-4c52-9147-08dc70d83426
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6307

From: "Hailong.Liu" <hailong.liu@oppo.com>

commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
includes support for __GFP_NOFAIL, but it presents a conflict with
commit dd544141b9eb ("vmalloc: back off when the current task is
OOM-killed"). A possible scenario is as follows:

process-a
__vmalloc_node_range(GFP_KERNEL | __GFP_NOFAIL)
    __vmalloc_area_node()
        vm_area_alloc_pages()
		--> oom-killer send SIGKILL to process-a
        if (fatal_signal_pending(current)) break;
--> return NULL;

To fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
if __GFP_NOFAIL set.

Fixes: 9376130c390a ("mm/vmalloc: add support for __GFP_NOFAIL")
Cc: <stable@vger.kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Barry Song <21cnbao@gmail.com>
Reported-by: Oven <liyangouwen1@oppo.com>
Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
---
 mm/vmalloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 125427cbdb87..109272b8ee2e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3492,7 +3492,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 {
 	unsigned int nr_allocated = 0;
 	gfp_t alloc_gfp = gfp;
-	bool nofail = false;
+	bool nofail = gfp & __GFP_NOFAIL;
 	struct page *page;
 	int i;

@@ -3549,12 +3549,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		 * and compaction etc.
 		 */
 		alloc_gfp &= ~__GFP_NOFAIL;
-		nofail = true;
 	}

 	/* High-order pages or fallback path if "bulk" fails. */
 	while (nr_allocated < nr_pages) {
-		if (fatal_signal_pending(current))
+		if (!nofail && fatal_signal_pending(current))
 			break;

 		if (nid == NUMA_NO_NODE)
---
Changes since RFC v1 [1]:
- Remove RFC tag
- Add fixes, per Michal
- Use nofail instead of gfp & __GFP_NOFAIL, per Barry & Michal
- Modify commit log, per Barry

[1] https://lore.kernel.org/all/20240508125808.28882-1-hailong.liu@oppo.com/

This issue occurred during OPLUS KASAN TEST. Below is part of the log
-> oom-killer sends signal to process
[65731.222840] [ T1308] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/apps/uid_10198,task=gs.intelligence,pid=32454,uid=10198

[65731.259685] [T32454] Call trace:
[65731.259698] [T32454]  dump_backtrace+0xf4/0x118
[65731.259734] [T32454]  show_stack+0x18/0x24
[65731.259756] [T32454]  dump_stack_lvl+0x60/0x7c
[65731.259781] [T32454]  dump_stack+0x18/0x38
[65731.259800] [T32454]  mrdump_common_die+0x250/0x39c [mrdump]
[65731.259936] [T32454]  ipanic_die+0x20/0x34 [mrdump]
[65731.260019] [T32454]  atomic_notifier_call_chain+0xb4/0xfc
[65731.260047] [T32454]  notify_die+0x114/0x198
[65731.260073] [T32454]  die+0xf4/0x5b4
[65731.260098] [T32454]  die_kernel_fault+0x80/0x98
[65731.260124] [T32454]  __do_kernel_fault+0x160/0x2a8
[65731.260146] [T32454]  do_bad_area+0x68/0x148
[65731.260174] [T32454]  do_mem_abort+0x151c/0x1b34
[65731.260204] [T32454]  el1_abort+0x3c/0x5c
[65731.260227] [T32454]  el1h_64_sync_handler+0x54/0x90
[65731.260248] [T32454]  el1h_64_sync+0x68/0x6c

[65731.260269] [T32454]  z_erofs_decompress_queue+0x7f0/0x2258
--> be->decompressed_pages = kvcalloc(be->nr_pages, sizeof(struct page *), GFP_KERNEL | __GFP_NOFAIL);
	kernel panic by NULL pointer dereference.
	erofs assume kvmalloc with __GFP_NOFAIL never return NULL.
[65731.260293] [T32454]  z_erofs_runqueue+0xf30/0x104c
[65731.260314] [T32454]  z_erofs_readahead+0x4f0/0x968
[65731.260339] [T32454]  read_pages+0x170/0xadc
[65731.260364] [T32454]  page_cache_ra_unbounded+0x874/0xf30
[65731.260388] [T32454]  page_cache_ra_order+0x24c/0x714
[65731.260411] [T32454]  filemap_fault+0xbf0/0x1a74
[65731.260437] [T32454]  __do_fault+0xd0/0x33c
[65731.260462] [T32454]  handle_mm_fault+0xf74/0x3fe0
[65731.260486] [T32454]  do_mem_abort+0x54c/0x1b34
[65731.260509] [T32454]  el0_da+0x44/0x94
[65731.260531] [T32454]  el0t_64_sync_handler+0x98/0xb4
[65731.260553] [T32454]  el0t_64_sync+0x198/0x19c
--
2.34.1


