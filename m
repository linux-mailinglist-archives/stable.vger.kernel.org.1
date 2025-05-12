Return-Path: <stable+bounces-143294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF492AB3B50
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 16:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409323AD9EA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B8218AC4;
	Mon, 12 May 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ej0Akcht"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE23215789
	for <stable@vger.kernel.org>; Mon, 12 May 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061374; cv=fail; b=D1X+nLpJs4z3S6j0jW86Q0P3D994QR9W4W1qQQqHV88hmZ6dsJIuwMlPbZ6JNUzKMMLpIlaxKloPcU37AXr07j7fGcrDXK+MG/gsM20F8izU4OFZXBATfIzDH2rnbcvIWK0wNFwXGdfhkEexeGHjnUjMnq1Z+IDZoYsc46Y1KDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061374; c=relaxed/simple;
	bh=V8dtTwQPV+NW87p1KBC/AywhiSYV5Q9XkfMAtYzNd6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isz+LPRUsackKFRtG88UKJ9oqL+/85eDKI2YHDjFO/YVmKgCxqC5KOCit+fOtBIhpvEz5HUmrw94y5BZGdN1+Xnihsfw8uMtZBSF2IOV1lw6tP8mcyHLfNq92hzWpfiDryvqMUvVgv0fu1qmDVa2yuXQ7Lmw30h+gPlbex8yb1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ej0Akcht; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdZvVRlMKJaPD32f1io2mD+0l26G9X42TpXz7xSjocY9bBj8LX4AjJnuY/1FG5uxvXNfyPydkFq5eFjVgVYhNHYs95CoMvQdwIxRJQVC6M0KPXSmnZMtM9P5+h3Q0Olszzo8tcsbdguv2soXGLekBYqjr3QnOlfEB0Eyi3v2FhZCxmElz5SuCPluBiuWw0utC7Layl8CrUZTCEyScMsnsSkl8tmNJWEkQ2kWr6Yw9VEwymtcdEma728lZ1xLv90YuDZ23gj3vfhgysWG2Vq0VRhZzoCDfCnIl09yvjSotwuC2rbSR9+dxTqtfDgN2eZFXvX34cUPP0s9GBXk8e1KvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y17ioDAvcB+4iSI2jaBZQJXhiL7U8cUYrCGcvkgBzkw=;
 b=Q/F/zXU3isF0AbwL9GtQCi4OL86mmAk2O1otFTvpo/x7h4o0RizgC0Ma/qWW4xPRuQKuGgQlG3kwf3U3R76lpCqOdtDTP8U48ZpLW80ezsadqhrEEI0WYlzCI7QfZBJU2QejO3d7vRq1yln/yPs+HnUGK1PBQQwk5k56cSVhSOecuDVpCc526FZRvjqOG4nbKSOuV9UEuA7UB77cx6VjeMy9paqivAenAp8vQQhCYtedY4ik5HHoKvhJkDfsHcyhJhjUQ/dgPBHAU09ONsR064e8eL39rrGN7iwEoe/hx278pUSiD57SYr1wFjChzGXymWUH43qahTL5W4Qweua4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y17ioDAvcB+4iSI2jaBZQJXhiL7U8cUYrCGcvkgBzkw=;
 b=Ej0AkchtkXY7AHFlsJ82mdug5yC+aNAxklr0Zw8UeV6GSd85AT9hfDQHtfxrgeI4bwYfQFi8X0RSqDy9aqvRFQqpnsKJS+rFd6N2WV+uUj80nJxYG3SRCBLrhlUI7RNf9v2n74vqSdCuynh8Opfn/+E71qWeAUx3yAkogO8L+RI=
Received: from CH0PR03CA0310.namprd03.prod.outlook.com (2603:10b6:610:118::33)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 14:49:30 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::7e) by CH0PR03CA0310.outlook.office365.com
 (2603:10b6:610:118::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Mon,
 12 May 2025 14:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 14:49:30 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 09:49:29 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport
	<rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
	<vbabka@suse.cz>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH] memblock: Accept allocated memory before use in memblock_double_array()
Date: Mon, 12 May 2025 09:48:50 -0500
Message-ID: <ac06a9649992e80e584e4f2548d9058c50f50c6a.1747061330.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2025051217-dispersal-trustful-906e@gregkh>
References: <2025051217-dispersal-trustful-906e@gregkh>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: 4861a90a-8df9-4604-a685-08dd916433b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQ2ggH7GjYIRiQoHLsKUpTk6XajUnJaeJSHt3WSFTWVHParcYO+bM8yWEAoT?=
 =?us-ascii?Q?vEnE5zWyUADiN3r6MYrbo00mVIDUuVMcN7HVh+JFXisCQKI7/Uyl1ICcFBCe?=
 =?us-ascii?Q?KKx65D5R0/ZJvNQhvqkUaTsqBLSpY4pTLa9sK5meyg/BDOBU9nw3IE5ud+/S?=
 =?us-ascii?Q?EwguHI9JayROSG+7CwNDdy6bDIAJqLEue9AtH47fM2AwVGdKCf4cJli+QLUY?=
 =?us-ascii?Q?NPjFg5kzgBaonI+M8YDHszL90xZEmNepo6LA9FfK0eS3oLMt/2H5T/u9j6z4?=
 =?us-ascii?Q?jD75zaUU4TxwxemYWCQzstWzOXTYzFII8DuiwYTzlzeMM/+9akN37Vu4EMgT?=
 =?us-ascii?Q?o/psqC447J93GXYV/Cgev1hw4j6FBaVTWbLMvdkiLU5KyTx/LmEY1NJdLHai?=
 =?us-ascii?Q?s4tjGJxiIgtZxvJ8l416KwSDznGAOETQluh/aFmqhKGrcLBXmyDhS5GYwnYr?=
 =?us-ascii?Q?xGFN0wOl6Y4S+lPTfJUb5YT9lIYnA+Ze3Q8VqkRZINlNq5uxawNvnTQx4JHf?=
 =?us-ascii?Q?vDsPvgKGnF8ohM2cgLJNc/+auoyy8PJtaxGoFBEXGBWgM+usy+ebWWDr2JZF?=
 =?us-ascii?Q?nPmDJzDa3YV3BU1eZsXd9ojcAC6Q6jiP40J48JiHL5qZ0oWmd+17rBcmpqMh?=
 =?us-ascii?Q?pYI55zJJkQh9zGqPbsXfA0kQJ++5QTOuRXM1pKYK5bMRAnCL+Ehukl4s+m8Q?=
 =?us-ascii?Q?KKvW2ILB+TPQ6DQcBUiZN42tLzW5I0EUgGRujk9QGTuI6ipyI8JEE2LjI4Ps?=
 =?us-ascii?Q?RO3kaJbivHFlkx1m8kkmArEhS/iftEpOHNkSN+6BXwstpjSeZWnGXDtXoCEj?=
 =?us-ascii?Q?yz0Zt+xZm2KHsmBHKU/m7/xr87GS+0rt8v4gH+UbT7H9cRwfeh6vIIiiGQXC?=
 =?us-ascii?Q?oTGhJe2OsX+khv5TaKfgecu+Pq5DyFnJmfstQMDTLVSBPxjt8y7h86EcldZW?=
 =?us-ascii?Q?oM/9OtIG1WWYw2tRKD/8t5SVALZd3IJUtXDQwC91nq+BLT9jwKGo7Ep67rDD?=
 =?us-ascii?Q?Tbu2GLIs3KoDaVvRLpLKxDvrHUKywAAUcBD1fJtV4SUrkoSFY5Zm2Q/OQDxG?=
 =?us-ascii?Q?0juEjhoIBkERHrMaM4Uc4yVB98QitVt0OxLeblIs69VwYtVhVeZZpXZEFgK4?=
 =?us-ascii?Q?4DBRr2h9tNY8WvYXOxSw1LvS8MDIACypfD4LEyoGyhGBaRPUo7qV++BjX1kZ?=
 =?us-ascii?Q?J1Zg4NGku84fXcZ3rw5FkW3q43SXlUsjFcXD5ZgGj90x/E7gGmhQV3jsAgHl?=
 =?us-ascii?Q?GEbsET4G61CCjXBsN4DgDKa9+oaWCs520t0QQ2S7+m5pOBTMpetFNEqKV79J?=
 =?us-ascii?Q?T1+oFL+aOiLy4O0zkXFAXlspvVjBaM2qNUUR3873rUeTF6/GPie/Jv+Gt+A8?=
 =?us-ascii?Q?DtC2Ie2nxV7CKxdiicAze5ti68P0/inFTpUg5YBcgclAIAbdHLGAPaQgyCzP?=
 =?us-ascii?Q?kMbefm6d2RZipyflSYRxvMt6oZ+w26gn5hMkk02xdf1cKbCFRNI7eLv77oWZ?=
 =?us-ascii?Q?jD7l3FCT4zZ2n4ZI8dvIokNPadHoioLyGDPrfD6oRmU9BXNgzUZnsUhHww?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 14:49:30.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4861a90a-8df9-4604-a685-08dd916433b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673

commit da8bf5daa5e55a6af2b285ecda460d6454712ff4 upstream.

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

Cc: stable@vger.kernel.org # see patch description, needs adjustments for <= 6.11
Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/da1ac73bf4ded761e21b4e4bb5178382a580cd73.1746725050.git.thomas.lendacky@amd.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

---

This version of the patch is to be applied to the v6.6 stable branch.
---
 mm/memblock.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 047dce35cf6e..0695284232f3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -460,7 +460,14 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 				min(new_area_start, memblock.current_limit),
 				new_alloc_size, PAGE_SIZE);
 
-		new_array = addr ? __va(addr) : NULL;
+		if (addr) {
+			/* The memory may not have been accepted, yet. */
+			accept_memory(addr, addr + new_alloc_size);
+
+			new_array = __va(addr);
+		} else {
+			new_array = NULL;
+		}
 	}
 	if (!addr) {
 		pr_err("memblock: Failed to double %s array from %ld to %ld entries !\n",

base-commit: 9c2dd8954dad0430e83ee55b985ba55070e50cf7
-- 
2.46.2


