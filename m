Return-Path: <stable+bounces-132280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5615A862E5
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 18:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421BB188B8FC
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B56C2144D5;
	Fri, 11 Apr 2025 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YF9Q+fkc"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D8214228
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387725; cv=fail; b=iofP7HJ1fmAbuim2177Hu39+zggsJgSA9c5MYfHa5mNwxt0PN/P1uaIaL6WmqxYXZsDzZRfbkR5aGFbjTcGsCYdf8NVvzZO1nMiWYCozx6/6JEdpWnW0wITgdxnAi749ConSyv/S7zwHcRosDNJHyWNGcgsVMXUR8/vSvPTmVsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387725; c=relaxed/simple;
	bh=K2meyDSiVOHSuPAPoSFq0Fcae/AGn+sYj6tgUY9Mxyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A/Q3ql+9u04Oskh1ImzfdGcJ17kBdfIp7o8cEV3hDb4KQUAGeihNg72IipT7gM+NDslbdNkhoCH3n41I58HvlgklL0xHUSG1FLGsnlIuQoVzTwPDDuTTRkz+JKioYu53a6hl7VASYpJ6qJkvtYQ2goRhrSdjjZAhVBOgZDmoOws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YF9Q+fkc; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l030kCwl2IN3bRdw70/QytCiHO4xxxxa+SYg+alCYPSLz/Wtj9FhR1MEUVsom03Ckqm+BvfIwM5a8J8TuKuxsdTz2nMD3adRb38DYXHRmMCZZLzqSEyQ6yTCI01fftSG26ccQR1lhohFSWwDWFpZqYA190j3rysZ0mywTwcQabrNs2w8iFccmKyjo2K2pF7GKnGMqPkVFQvEEqjQJM6k+xRzcIGT3b6CblBTA0fh7V4OzVNxLN9KrnvSm4lEyEs7CFDpLmZ3au8RM7Ky18hhIVWFkgc4ldVtzcjl2TFVA1a2BgH315fDSviHtHfV7twI27ywiyMfL4PxS8AMaYk8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veGPxg2+vFG3ljGtsioLvT7Mx3S+sjPSoa6XNLFjMbo=;
 b=LzW1IZ6aqoU7Cc3Qie7FGhf0Lg4qDDNIzJxpcXkd3Hw7W7emEOmjb4r5zKChCFQvVAL0l7qINI2JDAlik/cdj/ftiEmVhDc8wSzWvoB3yIuiLLZFhp8MnnnwYR7CZuvmPTeYmI+KC6LKESdNq+5tbbZ++VlhL8noUglFuBwVYDDXKiz3g5a9bWFoRitJYK0Xatm2+viJ/BZCKUSq9TKRzLD+J+1cqOnu1IXJrfkQrQEeyAHovF7lWkjGay05fOErzvxPeiTrkzX3ImCgBJ/rCHyyIUZY44sUOppZLiOkC5Oqdben+TonMFNdwXW49u0Zm3pJ+yjhFHHje2ZmxJYt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veGPxg2+vFG3ljGtsioLvT7Mx3S+sjPSoa6XNLFjMbo=;
 b=YF9Q+fkcKcYLhKdKJJHcfTR8EfiL64DGk/Mr14GaT0WLFl44rtDBix8VgQ8nJQxdPAz9oVgV18lXcVLBcG55lgbt2UxSV8pT27BYrMB2kaYeYGn/W1L4Z2K9X5bi94Tmgpug2RN7MrGP9oyTfYB5q3fk8lSVfKvWUCCsSEtpRbU=
Received: from BYAPR11CA0080.namprd11.prod.outlook.com (2603:10b6:a03:f4::21)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 16:08:36 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::69) by BYAPR11CA0080.outlook.office365.com
 (2603:10b6:a03:f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.22 via Frontend Transport; Fri,
 11 Apr 2025 16:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 16:08:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 11:08:34 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 11:08:33 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: <stable@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/pvh: Call C code via the kernel virtual mapping
Date: Fri, 11 Apr 2025 12:08:33 -0400
Message-ID: <20250411160833.12944-1-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 6650dd8c-4fb4-41cb-f3b4-08dd79131d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evYJsXcaBp/6mupa7H1ZyFYlthxIEbpJjp3HYhIXDYw+/EtfQ0skWuR/pnVU?=
 =?us-ascii?Q?42PC7zgunaQzJoT1S/Mn/wZoXcg1xSSqIyPxsxT5AWecc+O9SzoGY3pwI3yW?=
 =?us-ascii?Q?In+pwKOciJoIqw8ihnHIxEAGYnLCzINm+nI6k9MthVdnMcURcoRyTCNquc9B?=
 =?us-ascii?Q?Pq9Y9RrGgsmkQA82JMIuReE/K2ZYh9knUk3a6D3A47cgiFh8QxMtfzCLn2uO?=
 =?us-ascii?Q?rLqB2/USOtoFbekqD9X1pNc33JE7tzaj7l0XbmrsDyNqFZ0FCRvmw/PJViPk?=
 =?us-ascii?Q?fUyVgJ6Fvf2yTupNmcQd9qh6L/qzcQ/2P+2wwLuYgAl8pqaSiJJVa7atXhGW?=
 =?us-ascii?Q?c1sLZ7c6lFlEfegHU46JNkflaeJs0YmIW6qreAPh+vg5jQKWC4ylWZElXgkw?=
 =?us-ascii?Q?6230SSfW5m4eTr+7CdPwepx3r414E9z9wjibSsglu948HhzlPDp03X9c6xSs?=
 =?us-ascii?Q?BBGysrmHmyhxZ8TciO7g5JkmVYizZutl3Ee8YFT4ADGzeFOiGEhkzsPLhFtK?=
 =?us-ascii?Q?pEk9bxNrRl4i48fDv+GDrgvD5ACyNw0/D2J764JejtTjmJ/orIq3L6jPVPuX?=
 =?us-ascii?Q?Hi5TbXGn86e27Ss5luzaK1d9wXdiJCSOOHu5kEtensacKlcr0YulFa0uzX1T?=
 =?us-ascii?Q?s2fFrQNe7/GIN29wit2T0AeCZgR8VGB6gHhh75e5Ca5ds+QhZGRKtyDUXIC5?=
 =?us-ascii?Q?kACvJ8FKAWKco9FB8kYYpsaAMnNDIbkroQx4W/I4kBpnosKgkNOHF7ZGecoL?=
 =?us-ascii?Q?Q3VuXqX6yWQWCLstBsqHZ6JUNV+PK5KHoBbyICzrKnFQ9UBQ7Ug9BEB9C1NV?=
 =?us-ascii?Q?bEJGSLyXODWKeb2ObI+v96x8QzGhewp/aN94iD5YDyLfhcaxlJBsyQy45Y4s?=
 =?us-ascii?Q?dBKJyjziBrVGfebLPWsLLSJL604azxAHhta1Ul/xPGOW47vQEbcIAuGFfPub?=
 =?us-ascii?Q?NMUqGyuRvQZ0chYtCvo4kOasUHMZclRbJOQzJM4nGBVSMmhx4Ap6Cntj/Vhn?=
 =?us-ascii?Q?DrInI6V6NtTF8YM0sIc6N3eYSWD5M+ixgvATNRX9A+YwUt+EaZWK1lTL7ULm?=
 =?us-ascii?Q?8FuSj2NYZVvGkR0OXATqGsj0KD+LD9PPEV0f5HGHWaVlJyv3eUoilNEeyIwM?=
 =?us-ascii?Q?WZBBZo2JeVkh8b8vC44u33PGbLocNEsNjvrV2BxLoDHQUUJGXqqVoiIpoglM?=
 =?us-ascii?Q?lbWByPtVvRaEWf8xJHvgkYHJgsCIG4ZqO7aSpe4F8AbgRXiUsnecfsodJ3Ue?=
 =?us-ascii?Q?N+UVBe3l1EdU+ckZ7obhLIPTExZD4KJazCwGsF8oi8MMV5Ao5Z2w8pxy6Mue?=
 =?us-ascii?Q?glVdJObsNVlz+V4fgcuYfk3QfhvHwR5sHalnQPZOHZXSoKFwK0XwnuPGYMBI?=
 =?us-ascii?Q?7LJob3iqNxh4l02TSvetDYQrNdHlgWSZi9eqNK+qjbuH5FCYH8/7lk76Bj3q?=
 =?us-ascii?Q?8GRDWXk0IB1Zy1WB+VhIpnGJNYGZCkvY/Ug8AMk9475f2O1KjyJmDOiVpfD1?=
 =?us-ascii?Q?mvdhVKzle9FnWtsnExKLjygvZl2mOhfj3WQR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:08:35.3734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6650dd8c-4fb4-41cb-f3b4-08dd79131d0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

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
Stable backport for 6.6 .. 5.10.

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


