Return-Path: <stable+bounces-142914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649CAB015D
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 19:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08AA4E8692
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F319E286D4C;
	Thu,  8 May 2025 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ojMSGyd"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497335966;
	Thu,  8 May 2025 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725069; cv=fail; b=PnN/+xLgD9zjG0WTRPihlIIQY/NpmyagTOlQUBfmVUtw/t9N8tWGTlWotWjP+VCvKMkbrEnP8vQwNwXww8eckA3V2QaC+lPK16vRYMOKN4AGiNRFavmDJejgxFRAF3yapsoNnNKx+Uj5W+1Id0dXyw0/0PwuBdBV9mX2vb8wQ7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725069; c=relaxed/simple;
	bh=V48Q10jm62bWHdjgoOV+apRL1oSZPl7R64fZTAcJd6A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abS6r/l+L43PIkU4sjWo94fVnnqejQMK2sAkuuF0zI7quw49oI04SDGhDvdn/qenlPIYy1QA80toTtAa0iwYiBucRYTRsNLYgUbEKzEbIKKK2m0lfPAsVxK3EpKCB+ZsnA1EXURSzh0n+Jv2AOSeqDHyv5H2dSh+ck5Cp2rxITU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ojMSGyd; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvHtfkKxDpyz6OuVyp50qw0/o5CaZMTOrAZ3oK5o3QuG6imZO4oy5K1CbeQAnhDFPznM80mOqw2688rd9iDjLq2bO9y2SnnL+RZKdhhM88b2cnHBj4cx+v+QlSnormPQ8GEWAip7qOh7AB5QUgPuradHNOAvltnVg2ipzRpTNdHQFcdexy/ETdZevIHoJs2N9oM/ik4Jp4nFiYYMcIRRkQDN0+jN5NiXOmaoSRj3pyPbRau37ThHQb3eh9JOIg4dsqgIBVMRZ0Cfkw9zwOV3WhR3MX5uyZ9UB0BaniwyZBBl8P5632wJVntwk9fPY8QuKKaWjd4+Q5l3GdXKG9eBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq/2/QlfdXoVk81+oxjJXkEZLtMGiB6PBAfvk80Epxs=;
 b=uOeBWMpaw7cxKPGwfujLuE4yjH88dirgRRvCcr6qFQSkRK+E6i9fJf+rfVmvtKe2ispTf/qTav0JXp9HnNu3h9WIoEE6o8IzzDWlsPDlLwQQ9OLwPymb0E+4v5fLAx4dfKuUnYHB6fTOUr/UoW5Rikt3hFDuoWYyvRKI6x4dGp1wJMsR45BxDH4I9PFS833qRYDFZX79waNAhjDPWDhXDa6hAB0+DcKREUnAhDGhAihZKNcDgTeUyt1ikavP5XK50xBewSbuGGvRJvAlHQakZO6o0cRl2U/sUz2bNJ/GmUf6CcGkzAn/wm/7JQE50k/0QNEwGDfWIz+EWzNpVQvHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq/2/QlfdXoVk81+oxjJXkEZLtMGiB6PBAfvk80Epxs=;
 b=0ojMSGydgL/GvgCRzViBvo2hDAHaYGeQBIeUIQXcS7t1IqpeWvH6A7nIZCKarMM2z3q758M0zgffXqetTtE5C4GMrFy7SqnF4w4vKp8iab5ZIhW3tPoaTtH0g6qljMc7I3SGmAkzb7DmyySpkS/B7xrTzGg2WREPpdUuiPooN7I=
Received: from SA9PR13CA0158.namprd13.prod.outlook.com (2603:10b6:806:28::13)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 17:24:25 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::5e) by SA9PR13CA0158.outlook.office365.com
 (2603:10b6:806:28::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 17:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 17:24:25 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 12:24:24 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Michael Roth
	<michael.roth@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] memblock: Accept allocated memory before use in memblock_double_array()
Date: Thu, 8 May 2025 12:24:10 -0500
Message-ID: <da1ac73bf4ded761e21b4e4bb5178382a580cd73.1746725050.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: d08a3771-e2a5-43b9-556f-08dd8e552e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YNx8gDEsVc9uZwD8PqoBrOBhA1q5UHZRevhHWL8GyCzO/j14LEDyttPovlYl?=
 =?us-ascii?Q?RXrFU+bs3znBkiW2FW4+Px0tfc1xKkmgNTQGXQHBDsyeCBoFmNlmZsLJXjSe?=
 =?us-ascii?Q?43XkMYNiDM0A2OpP75UArHmZ6Y7owWoyjlXo6r2nsrJaOlCS9DNZdYich29V?=
 =?us-ascii?Q?k6sx/oXQqwS8wNnDJdEKrbALhl0UyR0Fc1B4+YjrINTpxxPVVHhAYXkSs8zJ?=
 =?us-ascii?Q?30g9zQ3VmXjeD4vt2lIXYauJvmN4Dx1aMMpyNE60v8uVkJB2fIpbbhiTsxoF?=
 =?us-ascii?Q?4+A6q2f3IqJaGBxW5291y5pCESQeGJHekDpZ5/S+ByEuqfAxS3Y60VfCNMrb?=
 =?us-ascii?Q?ohfKNNMPI3sXXQOzYyvrBy0p5L048OWLxAjzAzWz0qTJt2w4/kUFWM5LMYXj?=
 =?us-ascii?Q?DIq7//04CtAfXMbqbtAP0Bp41iyT/NvEBTyILvvPZrDBfvOlXZM0JUNNO5m+?=
 =?us-ascii?Q?UAoKVw+OIYzg8u5MZGEBzCVX08lYSxMe2sEZ+zg+FHKNI8VS+OfVH9QCcftF?=
 =?us-ascii?Q?DETl3H9C3ICpwdvG8MEojE9EUKSTcsrjx1mu0vbzAGgR9ep7/cYIenI5qy9u?=
 =?us-ascii?Q?dJOOtpK+0EhtQkBke600nJRa++ycMz28iEqmA1NlmjRoTzZfo6PFtA5EwbGc?=
 =?us-ascii?Q?hlZXxGhS+zXxgKa+7cFhCjVC0rCbG/5u8wOOOACp/NH2KJMPJpQxHBxSatVo?=
 =?us-ascii?Q?+QIFjWDbI95kKa36zHXTVvnkmGwn+EFDqqDc2pIo31/iSJDvFmzQXtgslVXX?=
 =?us-ascii?Q?AjpHeZbjgNqhEqtbLHNCCJkGT8/c/Xxm5Hja4lrxFER93MGTdu/2dRSaEb67?=
 =?us-ascii?Q?0L7rhn8WRT/A0d8/k5KVHMlH/6iXet6NWPTdaczw8TpsBooioYsRPF40DpGx?=
 =?us-ascii?Q?C01a88hU63ifCjGi12n3GHPW2UHiGefeZYEzs6h/sUAb4rudwjs7BPYWi2+f?=
 =?us-ascii?Q?JqzpV8qd5PAnjLpd+U1OwnQy5AEvA+sCMhEL5EGtMfyPwCejW8tqBFkT6yut?=
 =?us-ascii?Q?kH8Qm+dl6+CQDvHUL9ZrHlmjij7Ugqz3VU1ouG+wNdaczYd4/jfkQpp5Llph?=
 =?us-ascii?Q?PCZUsL/s5pXeCtrzKb/akGIvdQCCzifMoApTtQ49K4wvsDdcEYMf8RpC6pW4?=
 =?us-ascii?Q?5bIrA/ACcDYuLwfw+YEe+qLDA3rO2DBmT6vy9Zltlr+D32gKWaFSIDyyHdXt?=
 =?us-ascii?Q?hZUWbuV03utRvCmX3aoYO48NeKxPCC7H1My2sy3cSGdyTnAERhHKE2NFjRTQ?=
 =?us-ascii?Q?pni3BusUPir6+4IynDp8WTryOCY5/bmPZFuMboQlCFviy4bm8tV6OkUMj0Nb?=
 =?us-ascii?Q?FwcQcGX7cAOoA7M7mdAtOS4655pZW+gekh2oQ7AR33Syz2nqeOWadQ4FRko6?=
 =?us-ascii?Q?sru35i01nyShfbTT3rIt8xsTGdX/I7eSVWQ+XehAVbZizPriGJZNgYvZzz7V?=
 =?us-ascii?Q?x6lyA4LP37RnE55IdkEW58ANIy3wEDE9O5m8w/H1uM4inFPSZMfrrIgPHE3a?=
 =?us-ascii?Q?Y7G6ie0O/oFGjxJgVSIAh0IY1YLjSSBv5/KU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:24:25.2709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08a3771-e2a5-43b9-556f-08dd8e552e1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

When increasing the array size in memblock_double_array() and the slab
is not yet available, a call to memblock_find_in_range() is used to
reserve/allocate memory. However, the range returned may not have been
accepted, which can result in a crash when booting an SNP guest:

  RIP: 0010:memcpy_orig+0x68/0x130
  Code: ...
  RSP: 0000:ffffffff9cc03ce8 EFLAGS: 00010006
  RAX: ff11001ff83e5000 RBX: 0000000000000000 RCX: fffffffffffff000
  RDX: 0000000000000bc0 RSI: ffffffff9dba8860 RDI: ff11001ff83e5c00
  RBP: 0000000000002000 R08: 0000000000000000 R09: 0000000000002000
  R10: 000000207fffe000 R11: 0000040000000000 R12: ffffffff9d06ef78
  R13: ff11001ff83e5000 R14: ffffffff9dba7c60 R15: 0000000000000c00
  memblock_double_array+0xff/0x310
  memblock_add_range+0x1fb/0x2f0
  memblock_reserve+0x4f/0xa0
  memblock_alloc_range_nid+0xac/0x130
  memblock_alloc_internal+0x53/0xc0
  memblock_alloc_try_nid+0x3d/0xa0
  swiotlb_init_remap+0x149/0x2f0
  mem_init+0xb/0xb0
  mm_core_init+0x8f/0x350
  start_kernel+0x17e/0x5d0
  x86_64_start_reservations+0x14/0x30
  x86_64_start_kernel+0x92/0xa0
  secondary_startup_64_no_verify+0x194/0x19b

Mitigate this by calling accept_memory() on the memory range returned
before the slab is available.

Prior to v6.12, the accept_memory() interface used a 'start' and 'end'
parameter instead of 'start' and 'size', therefore the accept_memory()
call must be adjusted to specify 'start + size' for 'end' when applying
to kernels prior to v6.12.

Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.11
Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 mm/memblock.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 0a53db4d9f7b..30fa553e9634 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -457,7 +457,14 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 				min(new_area_start, memblock.current_limit),
 				new_alloc_size, PAGE_SIZE);
 
-		new_array = addr ? __va(addr) : NULL;
+		if (addr) {
+			/* The memory may not have been accepted, yet. */
+			accept_memory(addr, new_alloc_size);
+
+			new_array = __va(addr);
+		} else {
+			new_array = NULL;
+		}
 	}
 	if (!addr) {
 		pr_err("memblock: Failed to double %s array from %ld to %ld entries !\n",

base-commit: fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2
-- 
2.46.2


