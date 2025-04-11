Return-Path: <stable+bounces-132290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D30CA863B5
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 18:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9424A7AB66D
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F1521ABC3;
	Fri, 11 Apr 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gaREhpvx"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D24821CC5D
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390298; cv=fail; b=bVk8gvaBHB8CCaZQ6JvkTmX4h/wgCFShkyym54AYQ4rTTe0D60fAz62T9MbQWSsIuJijtCnXt4lJLqtcg2/kBPFFPkeYcQePZWRCaHG5sVD3/YxzyBpwcUxo8BAGiBTGzngCFhrT4tKptHxj3X0DrMJk6/A3JDkZbVWQNfQmaXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390298; c=relaxed/simple;
	bh=wSdxGzxZgrw13dfz233lDjKcD1sqTq3v7w3TGx6x0yw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBWNI7cdGt7qpjeEvYRJCKw2yilnlr9Q1SiSnbD+JaxwY7aAfX7+m8SiCIcuo82fH0rr9PScTbaDUQtiY2jc3DcSRPI28TztRYrhXUKvoBMvR5boVJXVg0H4Iue5e2ZsZqP9wS+WQLev2JnRJq5XPCg71Awr+6J8oWiYSkUs9WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gaREhpvx; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZkxr/onmAJnUBEoPpun7PggEmOmEnZFHdJ/lVuYmN2s6MGIFEzG2pnFI6ZRi251xu8j6/XffWyefEgESFfftt8lYyeMpkStxAVL+TlJ0hGqZtqr6vUSkUfZCAo2MtLOlJ+umIg5W3kJT0OBkKh6GWIGDYi/oZNKPhnI48VJ9p6mp5n95ualD0B+AQEKoRbfPmfAQjs4iGMS36rSaYwc9lGL7mKtVKNzCd31lzpGehBbfncyC1FWaBNm84vDxSfRlJ7UmRF55ea0bHDXTlVsLXvoo40CwjroPtjT0yKaYBlG7bu6n1Zo224KVfxMdi+W1+thrZdfjdbOtfQoBZbI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JazLtXrN/OOS/RRuKwUWawM1+E6sF/UMT1Lz4GO2fIY=;
 b=WMgRo+iyDif2+31nFXTY8f9z4IWVzqwooQlcCThJfsjEUTo06v6kndCls+bfTJqum5IrbVk8EIHEglftUBJLG3bkmiZ/DMJh0za6kYEsts+kU8Gohg3bUdApXdj5IcGGp47uu0qD0YLYIGPyhDz7oUZ1XX0XohIYBfK01CBhpc6czQwawZJwUF0yCIj5+9Yh5uIij6NiIsAV8Ki5hehnNhcXDfmrOuiHtdc7tPtTQff0090sNbkwFnbtZ+PACm9ttQLsrRckoNId3Wl1lRHalZ9KpYbwKqXelc9c+7IQDPeUAoOj6n7pxj0oNwUBvGP2MXziv0CbMyXmdtP5FDrbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JazLtXrN/OOS/RRuKwUWawM1+E6sF/UMT1Lz4GO2fIY=;
 b=gaREhpvxPwqvcTGc5c2/wXrR85r/DHEMUTdadFyvGA3bd4YKivQYHmhRYLz13jwmNiOTTnMbBbTy0yJQxCzHb7j5uzCearO75qqS2fg9Azw30adGyTnYwNAHoxdX60iy90CmwK+L9nnMUF7uAj/lyF7pyt94WszGsBfTUZ8R7Zg=
Received: from BY5PR17CA0031.namprd17.prod.outlook.com (2603:10b6:a03:1b8::44)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 16:51:32 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::73) by BY5PR17CA0031.outlook.office365.com
 (2603:10b6:a03:1b8::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 16:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 16:51:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 11:51:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 11:51:31 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 11:51:30 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: <stable@vger.kernel.org>
CC: Roger Pau Monne <roger.pau@citrix.com>, Juergen Gross <jgross@suse.com>,
	Jason Andryuk <jason.andryuk@amd.com>
Subject: [PATCH 2/2] x86/xen: fix memblock_reserve() usage on PVH
Date: Fri, 11 Apr 2025 12:51:22 -0400
Message-ID: <20250411165122.18587-3-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411165122.18587-1-jason.andryuk@amd.com>
References: <20250411165122.18587-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 59789c7d-c2b6-4c60-6bca-08dd79191cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjZYaXoxTWE0V2JKWW5ROXlIakw4Slp1dzFlQTFJTXNyOEM0dEQyVXpjMEYw?=
 =?utf-8?B?bGxwVlpRKzhLMUdBb1lBcFNnM0xFUHlrSWh1cG42YzJ6NzVCeUx0SHpua2Vi?=
 =?utf-8?B?TlkwRGdJUFFMLzZ0RTBqSlpmRnUzcmlSYlB1aW5RbWwza2ZkZDhPOFBkcWVV?=
 =?utf-8?B?TEg3cHZxRlFTVVl0U3JnaE5KS2lJQmJ0YXlEVURubkVDRE0yMXdVK28wK2Vl?=
 =?utf-8?B?eloyU1IySmhDZjJpSWVlSGFUaEVKRnRyaDhScDBuVWV1NHU5aTVCb25FTlRM?=
 =?utf-8?B?TEpZbVpKNDViSDljTFNmcWVaazlDTVdaSStVb01vWXJHSTFlZmFSVUN6NlBh?=
 =?utf-8?B?S2JZQVExMTVxOHkwVnlvZkZVNzU3dFlKcEFaUTAzYkhKT29PdUlOek5ndmVI?=
 =?utf-8?B?QVlFK3g4MW5temZyZ3VwWUJzMWt0Kzk3L1BwRUxYZUNaRnNFTzF2eTczelBK?=
 =?utf-8?B?RkJWMlYzbFhvYVFGUkFFTG9nTUZaNVJaaGlsUGRPdzFkQjNkR29hV3hhT0Z5?=
 =?utf-8?B?OTlDU0JIN2ZQSHJMK1lNcDhHeW0vbE96Y3ZLQm5nTXdDSlNRY3lHRFB4cW9D?=
 =?utf-8?B?clI5MHYxMFh0ZXc3ekZWQjBlK3RteFBiNVQ4Z2EwY3N1MG1BdzRyMEs3WEQ1?=
 =?utf-8?B?aVVGQVUyL2tqYy9BeGRmaC9vVG9XQndJZ09SZVhDdUdTTHMrVGlCa1ZCeitY?=
 =?utf-8?B?UlJzVVU0QURmMFcyZHlwTmlQRjRIRS85b3l5THBIb3l0eVJOd3JMWWdOeXJa?=
 =?utf-8?B?R0xMSVkvTzRPc0tVMU4zNTBZdjZ3YXdIZTRLeDhBTjFqelIxNXNxSCtXRTI2?=
 =?utf-8?B?eTcxb0FFcEhoTTluc0xvejJhM1FlQldNWFJXemx5T1kvM2VPU05za3VWUGtY?=
 =?utf-8?B?UVl6UHFWbWdXQmEvNzE0Mk5BcTV0VGNQbHZzK3Jvb0o2MHFaY1NZSmVjKzBX?=
 =?utf-8?B?SVdTN0xtcVF0a01kN0laMnZyWXpZZXB1Tm9ocTczeXNWSzZveU9oYkU5cFVL?=
 =?utf-8?B?NEdtajZqd2YvRUc4K2d2NFZBd1M2bUgyUit5b1JzT1k0QUtTVE5jZGxNK2lx?=
 =?utf-8?B?Q2RNejFhZDNINXV0ZWxmL2tCWlQ1emdBRlc4cmZpZVpROGR0UFd5QnFJV3Mz?=
 =?utf-8?B?U3QxRXZaTmpTbTVMRHVyTVpySTExMkQ2TFFNVmxHU2tkRG9mMG1KSUFldUJa?=
 =?utf-8?B?NkJBMGx2cUZqMTBud0g4MWdTdmVZODBGc05aa2tyY3VDbnlnajBMcDI0aVdk?=
 =?utf-8?B?K2FsT1IxSjJzZkdFM0xOaGthT1BWRlhDVVd2aFQrUnd6NzdUY1UxMDRDZUx0?=
 =?utf-8?B?TWpUdDJNWXpDcjVlM1ZoY2pRakJOQTM0OWZWaGxGSm82eVdmbTdmMXQ2ZzNa?=
 =?utf-8?B?cFlJQjhTMklnQlZ6dWd2MWRVZDcvWW0zSzhDdlNhNkYrY3I0V2tabVN0Nmd0?=
 =?utf-8?B?TnBXTlk5dzU2N1ZMUG8rbm4rL1FqU1NSOTJRYmlGNVhBeFZhQ21BVGlnVHcz?=
 =?utf-8?B?SHNKY1ppRVdNVmpRNDR3ajcyaUd2VHYvZ0k2aVA3bTJHellpaUo5OTFBKzZL?=
 =?utf-8?B?TmlyS0p6dGZvSzdMemJoWU5VWHpPQzkrNnNlYjlsdVorWkJ4QXZGVlFIajY3?=
 =?utf-8?B?Mlh3NVN5Y0xuSEJOOEpoWWV3WEdFY1Rmc2d3NlFiNnVVTmRRcGo5WFNqTHhz?=
 =?utf-8?B?VXhldGV5WWdXR3UxR0tTWVBKZ1IxK3RjdHhuL1RTcVBHNytiR3lqUEswd3JJ?=
 =?utf-8?B?MnNqUTZYYmxwcUxtei9KVFY2MEs3YUxaN0hBN2dXUUZyUGVVdGJ2NXBLUStQ?=
 =?utf-8?B?QytOZUsrTkZGc0lGRTBaYkRoTkRBMXJWN0lMK1Q5MDE2VFRrUDRTMlgxYVpN?=
 =?utf-8?B?bHc3ZDhaZXhtMXFocDlFRHU2MTZOaWtuandpcjR5LzR6UU5lZ21XVnBlMUZp?=
 =?utf-8?B?K0FVQk5WUG12RjZjYnpseEVscERmR04zMXdlTEZTejlKUkgvTFJuZ3RsMTFB?=
 =?utf-8?B?NmM3MHVJYUtEMTRqNUptVDRvblZIUXhXeFRoSjNWRnFwRzNJRmZ4Q2ozajVw?=
 =?utf-8?Q?NIHDdz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:51:32.1798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59789c7d-c2b6-4c60-6bca-08dd79191cf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146

From: Roger Pau Monne <roger.pau@citrix.com>

commit 4c006734898a113a64a528027274a571b04af95a upstream

The current usage of memblock_reserve() in init_pvh_bootparams() is done before
the .bss is zeroed, and that used to be fine when
memblock_reserved_init_regions implicitly ended up in the .meminit.data
section.  However after commit 73db3abdca58c memblock_reserved_init_regions
ends up in the .bss section, thus breaking it's usage before the .bss is
cleared.

Move and rename the call to xen_reserve_extra_memory() so it's done in the
x86_init.oem.arch_setup hook, which gets executed after the .bss has been
zeroed, but before calling e820__memory_setup().

Fixes: 73db3abdca58c ("init/modpost: conditionally check section mismatch to __meminit*")
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Message-ID: <20240725073116.14626-3-roger.pau@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
[ Context fixup for hypercall_page removal ]
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
For stable-6.6

Context fixup is needed to cherry-pick after Xen hypercall_page removal.

The Fixes commit was backported to 6.6, so this is needed to fix booting
for Xen PVH.
---
 arch/x86/include/asm/xen/hypervisor.h |  5 -----
 arch/x86/platform/pvh/enlighten.c     |  3 ---
 arch/x86/xen/enlighten_pvh.c          | 15 ++++++++++++---
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 64fbd2dbc5b7..a9088250770f 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -62,11 +62,6 @@ void xen_arch_unregister_cpu(int num);
 #ifdef CONFIG_PVH
 void __init xen_pvh_init(struct boot_params *boot_params);
 void __init mem_map_via_hcall(struct boot_params *boot_params_p);
-#ifdef CONFIG_XEN_PVH
-void __init xen_reserve_extra_memory(struct boot_params *bootp);
-#else
-static inline void xen_reserve_extra_memory(struct boot_params *bootp) { }
-#endif
 #endif
 
 /* Lazy mode for batching updates / context switch */
diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index a12117f3d4de..00a92cb2c814 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -74,9 +74,6 @@ static void __init init_pvh_bootparams(bool xen_guest)
 	} else
 		xen_raw_printk("Warning: Can fit ISA range into e820\n");
 
-	if (xen_guest)
-		xen_reserve_extra_memory(&pvh_bootparams);
-
 	pvh_bootparams.hdr.cmd_line_ptr =
 		pvh_start_info.cmdline_paddr;
 
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 89984018141c..ac0a8adb2c50 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -8,6 +8,7 @@
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
+#include <asm/setup.h>
 
 #include <xen/xen.h>
 #include <asm/xen/interface.h>
@@ -40,8 +41,9 @@ EXPORT_SYMBOL_GPL(xen_pvh);
  * hypervisor should notify us which memory ranges are suitable for creating
  * foreign mappings, but that's not yet implemented.
  */
-void __init xen_reserve_extra_memory(struct boot_params *bootp)
+static void __init pvh_reserve_extra_memory(void)
 {
+	struct boot_params *bootp = &boot_params;
 	unsigned int i, ram_pages = 0, extra_pages;
 
 	for (i = 0; i < bootp->e820_entries; i++) {
@@ -93,14 +95,21 @@ void __init xen_reserve_extra_memory(struct boot_params *bootp)
 	}
 }
 
+static void __init pvh_arch_setup(void)
+{
+	pvh_reserve_extra_memory();
+
+	if (xen_initial_domain())
+		xen_add_preferred_consoles();
+}
+
 void __init xen_pvh_init(struct boot_params *boot_params)
 {
 	xen_pvh = 1;
 	xen_domain_type = XEN_HVM_DOMAIN;
 	xen_start_flags = pvh_start_info.flags;
 
-	if (xen_initial_domain())
-		x86_init.oem.arch_setup = xen_add_preferred_consoles;
+	x86_init.oem.arch_setup = pvh_arch_setup;
 	x86_init.oem.banner = xen_banner;
 
 	xen_efi_init(boot_params);
-- 
2.49.0


