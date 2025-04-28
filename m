Return-Path: <stable+bounces-136907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F9A9F583
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5931769FD
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704110785;
	Mon, 28 Apr 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L9EgJp+2"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B102027A91A
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857193; cv=fail; b=Pks6+NoxqB2Exbj1aIXb3G4P3nuygGv3GAIaSDUVzcN63xzIDAgkmMFxmWV4DDJFIb9XbRz6qhAA/BKe2fe7dc1tCdJEGMueNUhsf45auYRGUtXD5LtFPqwSWEUHnPz1duiosCIWRHZcz6Lbg3vDtS/whsARvXllT59t0tqhKP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857193; c=relaxed/simple;
	bh=VBeAzUoMcARvUWArHi3e2ZmVk5bNbwJt51mAY0wynsA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ja63wGkTTZ92t4HI3+QyK1P/BNbRmglOgwxRgLq9nHkIarWRpQXR78fkolLpCnSHU09HLAE8d4Rjpsc391EF2yaVRWBCsXN7S23n/wM50/gOseh7DKxEy3SmNoKV0q0lrKKJf2SRKS70i/eLbUGj9Lyw37VTHq/oznzqSvSF58w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L9EgJp+2; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cp/hI9Xwh2N73GrSAkG0S6fK2pQfY1jVfLYiDFd0DYnsma5UbR+b91v4iTjj0iJAhQjMezfMcn7nAC7hcEbVDxu+OUdGyLpZhRjXW2D68xQh5ZPS8ItgMRPrahpnPUY5Kbw1XjgHhtYxt2oC2x/YhHduaqo4uTMFHyuHIX88SdybMVenTn5lJWaFXmf7S3HdOMr42MFeyyqT75run7P88rfWmuurSPtfn/hQ2gAR034ff7CWC4IoFBYg9Ug7jW3UM8sVsoyzgkQ4oinRKQNGNXMjxoD0aMDG1X4fbjPdopp5I/rQmiz3Aq2tWEZd+T7GvJq03GrhO1pi6/Q012DygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSmBcZyI+sjE8DAF5ftNUPh7rhj2CVjzjaq9giK2Q9Y=;
 b=KeT8kEzifJ5N+M4i27mJmn1tkijgGcR67IMhhbqXSexWx8IaOdDlufst4Eiv++02V9FDEd3TXwyI0JfmXndCKLm2S2lUN1Pb7jWXfIUqfohhNKEUsMHC2eA8bLK8PEu7ex7ADI+si0jWTbMnpXks5F1eRoX2phUnRVvwQJxc85ZRbvjoTTfWiRsnF14QFs+7kxPJvDbO28fiT8xP8tIpJT27ggohVoX2MI1AqHVIXOLzq5kQv+AUViPRy2KfKwH527lf1VWo388pf4TMSQjVtvjeqyPfmiVg7mL+McR0BsVEMfUs5cZS01c+WLhxzoQ790YwOZJywLQa6x83dFgziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSmBcZyI+sjE8DAF5ftNUPh7rhj2CVjzjaq9giK2Q9Y=;
 b=L9EgJp+2kv3KQnQflHgH28w8VLIiMdtONor4Dk1T7A9LgYESZCDtjKg7c7AeCPU/jjx2eNH5cIIQJVJUbOVj726pKyDZE2pbOgcAXOakkXWyhPX1/9Izuycm96UarcfVZW+UKVFHHFMCmWbu4rHtPQBFX5QTgAvhnJAfQA8qqd4=
Received: from BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Mon, 28 Apr
 2025 16:19:46 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:60:cafe::d7) by BN8PR12CA0012.outlook.office365.com
 (2603:10b6:408:60::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 28 Apr 2025 16:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 16:19:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 11:19:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 11:19:29 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 11:19:28 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: <stable@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 6.6.y] x86/pvh: Call C code via the kernel virtual mapping
Date: Mon, 28 Apr 2025 12:19:26 -0400
Message-ID: <20250428161926.21452-1-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8e0336-823b-401c-dbaf-08dd86707e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+2qz7+wNyQktGEwdhNl3Bv1QbuWyODStQAKpv+ljtzqTojcrGPKJFdKmWSKi?=
 =?us-ascii?Q?za/NFxyoRxTRBVnsXobF6uPWXs4DKGsqD/s8R6TgsoESysRZ/745kzbQyGL8?=
 =?us-ascii?Q?NiBMwCbeGPhP8QLtLM24/xCf6P1glPIC/G4+7Pm4FHVfRHngPYWgwsGLtodP?=
 =?us-ascii?Q?HBGLeucDjDSJ3hRHz7CmmJ7lObV9B3rX1+Ufoup/U9kRXH1Go5fgvGUmKscH?=
 =?us-ascii?Q?oVVIQn6r7+5A9oHR41uYoVJQ791U2pdeXa0G9ezs3NYl2JAUz/sKfTgPP+tH?=
 =?us-ascii?Q?OTcxdlbywCgTpCVR6E9FnhiBMfQ6eVD9de7AoVme+CBuhIw/lElHeNMomAYw?=
 =?us-ascii?Q?Fc/o07H182ZCbRqCbaN3DsUd3CmMW6EPjE8ktM9y5jxZvlSUTlfV025Xy4qn?=
 =?us-ascii?Q?nnw7pJA8TnFvhpbcdnk43h46KrcFqqPqXsvaBJ9BsaMofcKyM5DXdVbB+me1?=
 =?us-ascii?Q?BKLM5jY3oPUkCs+g7U0wMCY9lkADGTBsj6CyBpiuUCwM/minodTVALAUrBwx?=
 =?us-ascii?Q?VeO045gvBq4U1K0PXn41DRshAz0jzYw2FGB8e+zRWBNQzioxRCBcayzoFy7Z?=
 =?us-ascii?Q?klUQYjgU5HGJGEIwWNOnnf6nJD4OUSzFJp9D9Q5QWLvJG7ioi37G+qS3kgXf?=
 =?us-ascii?Q?jGkgVBxbfzL6er8de03pb/gHKxMOEL5b8GBXrFQOJc7LFPiM+7MR+GpgrnUD?=
 =?us-ascii?Q?0j6fac5qZ7MzAUlWmtoX/KJS77StfxoJAwm348jTuc448HRU5JlM/e+ZrI52?=
 =?us-ascii?Q?Hb1g2WPU08szDvwa9BugSjMSaOmDkDurH68+TwhWHNnhwJKe73+gEgySzKy9?=
 =?us-ascii?Q?1mGFN18OXJ0NEt9QrH1jcwa4V/Ln0Y5MYGOhiSej3tUx3bzjkAIAcbizJNB3?=
 =?us-ascii?Q?3UGU38h6SpB5hg8vYrSB48Tdnt4lLprqCgSVJt53MtzuYPDzaLy2B2p1POEa?=
 =?us-ascii?Q?QdMQ6dro8UwJUKm4qN/LPtzR3P84jlpHWGpHO2STaBAv8gKa6xW69oO/ojea?=
 =?us-ascii?Q?gq4G3kX+COof4Gpf4ARMBbQ+JT6yCSGP2ykKJ1BtQ3U4s/5Vd2vJaibl0D2E?=
 =?us-ascii?Q?A5Dql5YM4knQgZcoWIPyAujImVsIfHNF3Va6E6krA6v9EJHWzdYI3bary8Ib?=
 =?us-ascii?Q?vQ4zPyabJPzn6nhk1Tb55ErZQbMNiGhwoVwW/JejdnGrrD1BzHDcgEL9m9A6?=
 =?us-ascii?Q?14P1za+ZwGrT1BeLHz+g8dTbVfi/qXe8wQFTSudAnUlV0+cDVCLwnTxZTdpa?=
 =?us-ascii?Q?w1S9fqnOTAZeCT1us5HrIuVOvKvuJVGdyLzKKtuhXmlyXe8uJPn8PbX8KBpM?=
 =?us-ascii?Q?q3gTVU+S4lYKAD7/kKyMjbm8TjbW7lJnIaIEFgBS5kU1RV2UKX+qXCz7gk5n?=
 =?us-ascii?Q?BPJWNpMnY1x9yWXYRxW6vVZqbIZO+0i3JQLSWx//CmDvTTTU/nhMfcHJgfsV?=
 =?us-ascii?Q?LHAdA7Cp0XYw0xvNFV+cblUDgZnW3DKW5PVarX2Riw3mI+0iMXxRS2uxB8pL?=
 =?us-ascii?Q?f00ljBFLZwL1+T8bUUcwv5Lp1L32fZWgTERz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 16:19:46.4756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8e0336-823b-401c-dbaf-08dd86707e04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit e8fbc0d9cab6c1ee6403f42c0991b0c1d5dbc092 ]

Calling C code via a different mapping than it was linked at is
problematic, because the compiler assumes that RIP-relative and absolute
symbol references are interchangeable. GCC in particular may use
RIP-relative per-CPU variable references even when not using -fpic.

So call xen_prepare_pvh() via its kernel virtual mapping on x86_64, so
that those RIP-relative references produce the correct values. This
matches the pre-existing behavior for i386, which also invokes
xen_prepare_pvh() via the kernel virtual mapping before invoking
startup_32 with paging disabled again.

Fixes: 7243b93345f7 ("xen/pvh: Bootstrap PVH guest")
Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Message-ID: <20241009160438.3884381-8-ardb+git@google.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
[ Stable context update ]
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
Stable backport for 6.6.

This was added to 6.1, 5.15, and 5.10, but it is also needed for 6.6.

Direct cherry-pick needed context fixups, which are made here.  This
upstream commit was previously included in stable, but with the pre-req
of b464b461d27d ("x86/pvh: Set phys_base when calling
xen_prepare_pvh()").  Both were subsequently reverted as b464b461d27d
caused regressions.  This backport, e8fbc0d9cab6, in isolation is
correct.

This fixes a regression introduced by the backport of upstream commit
b4845bb6383821a9516ce30af3a27dc873e37fd4 ("x86/xen: add central
hypercall functions")

b4845bb63838 adds a comparison between rip-relative xen_hypercall_amd()
and kernel virtual address of xen_hypercall_amd() to determine whether
to use the AMD or Intel variant.  When running from the identity mapped
address, the comparison always fail.  The leads to calling
xen_hypercall_intel(), even on AMD processors, which faults and halts
boot.  This affects PVH dom0 - domU doesn't seem to be affected.

This patch performs the rip-relative mapping from the kernel virtual
mapping, so the values can be properly compared.
---
 arch/x86/platform/pvh/head.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index c4365a05ab83..fc46b4dfbd74 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -100,7 +100,12 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	xor %edx, %edx
 	wrmsr
 
-	call xen_prepare_pvh
+	/* Call xen_prepare_pvh() via the kernel virtual mapping */
+	leaq xen_prepare_pvh(%rip), %rax
+	subq phys_base(%rip), %rax
+	addq $__START_KERNEL_map, %rax
+	ANNOTATE_RETPOLINE_SAFE
+	call *%rax
 
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi
-- 
2.49.0


