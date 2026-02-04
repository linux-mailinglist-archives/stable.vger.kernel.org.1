Return-Path: <stable+bounces-213724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPgxL01gg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:05:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F5FE7E2B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3436C30268E0
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182ED29B76F;
	Wed,  4 Feb 2026 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1e37t/Fl"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37828853A;
	Wed,  4 Feb 2026 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217295; cv=fail; b=MaEX3yDmTjCHQK0ILgAh+Sn3y+4H57TcYDOejUP7Sv/0dNtfTL3s6DoYXcZTxoTHET0QdiaEV8f9yqKEHfWnNivvKIusrsBLj1fw8YY2NHyO6CfM3gv33GDVMQzlxBjzc+4DEE2uVFqf7hmQk+HEUC55vC6qg86urT7wBdAXbdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217295; c=relaxed/simple;
	bh=DyoITR9HecubO8yFK5cbsxUXYOGo0j9QuWt7YTwrbSw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JIQRAm1qG61+MtkmPDPBG9URjJh1jx8Be2VFocDUH7sUcIW2CnrLNHehKhy94w2VE+Pq/SHz66+oqv5MHXNUShXVeOyj2e/F46OoQi2waRGK3IuHvp1oX6osVHfyNoHfjQaDCYNGyKfOENRa8sx/hWzJTBk20OuWx5Fuj55xwLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1e37t/Fl; arc=fail smtp.client-ip=52.101.46.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reJFWv1Jf79q5cz5/V/mNCHc7NZioOVxkOKjUwztsAlbRHj6iJqZ5aGKA6rroKovhgB2NByZI8rVqgk34dYL3qWZnHUMvOWw+G9DvNdQa4yAidR+2ldIRS1MCsgMoZDr6d+LhP5S/o5K23ZMDyy+6YkZ7vhdEzk73bzVrjv4JjRxjD+tUi6a0Iy13dxll9gHsxgjwMMrBDgurwssRGZipYdS9hVC6mnXw0MNlQfpp7EanAEiyDnDyK7HFyD61QZ2wOVt2MxxnsiLbKbIyerJt0uvrGi1hyr94I2jsQr34cbIdiHVMLYXsyx7DQfG18VqhvijQVJNVF9yFVyNv8gzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwrIt75+Y3n2yEdRS9ik5AcLrpQRh/5q5XGiZoCnjSw=;
 b=yNvJpSuQtK+c3kjrZd6rzBjhtByn401Wh8uZW0qWzua4cuZVZATJ3NGoyHa0vtQOYIkateodvfokXvpkbzNZm/OrVxWO/VvbLwePBCl/zXKsxN4DA1pdZx858O9SlXpp9mOfvPPj/GO0RW5QSmvc+CWlP0fxUwwcyiTCDxghRuekDGDCPL2W967RNM+bAZ/ZV7pN4SvSmDwBeQDf5yOepG9xUT8MGTMGXH1mGxtGNXznqSWcsIttWWF6Urv0qjtboYLNa6csshQolQDMnY//yqhAO40qSlCCebi8m6lRj9Kzr1+jgcE5ku2hSaRwcudLGSYtovej/ruL9/2Fo4R/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwrIt75+Y3n2yEdRS9ik5AcLrpQRh/5q5XGiZoCnjSw=;
 b=1e37t/Flzoz6q/dUH6hJ1Upg5e/ZCiQS4zmiJ4x3HOIckS9zYTFY4EZVzBQgTl8tO+MMReziRZziUIxMN1wdk/9RAP08XkTh0M3TY26P5+onNzJZtLq2c2JVhbT+rQIuCFoSzeo8pjOvvNJQGJSTinkaV5Mzi+EqI4N+K9KqLcU=
Received: from DM6PR07CA0119.namprd07.prod.outlook.com (2603:10b6:5:330::11)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 15:01:28 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::2f) by DM6PR07CA0119.outlook.office365.com
 (2603:10b6:5:330::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 15:01:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 15:01:27 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 09:01:26 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<stable@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Kevin Hui
	<kevinhui@meta.com>
Subject: [PATCH] x86/boot/sev: Move SEV decompressor variables into the .data section
Date: Wed, 4 Feb 2026 09:01:00 -0600
Message-ID: <5648b7de5b0a5d0dfef3785f9582b718678c6448.1770217260.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fb71a5-cebd-409e-9f9d-08de63fe4577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WTieGZ0pL6V1gTR30wuI/v7IdkG5qCXBOnDNzGnmA0kPuRb+Uj79aMmnXWMS?=
 =?us-ascii?Q?kjUeGiz+ZZjCFCYbCsyTHpnl5CGPK1f6b6gftFYYMAhv+5uIw554w4pvtUB6?=
 =?us-ascii?Q?BTJH4xv/JD8jMobxJ/2ilGdJKR6opYlGUxES30FtcrYdNfUzJjOKSCx/1kGR?=
 =?us-ascii?Q?hPsMhDx0fORzmKrKg4Qg/AvoODyGQAh31FyRTBz0FdAPfrMs7ebs2Z8JEVHt?=
 =?us-ascii?Q?fxSa6tITQ6HIR9XTwCIKn6FKrVBhJDVNxNCjQ2tfVtvmpgtSsv8gSGgDJXir?=
 =?us-ascii?Q?R3GcXcS+o1NJT3zsqBgVt8zcQZdO0m6iLRFXMoQBfcMbkG4B2v6MgxRqLetF?=
 =?us-ascii?Q?XdpTjJiQxZhNWCiIs46MXm/oDUhw0cKRgbw0bYuXc5kIlo3JLd6kYUAL8EQI?=
 =?us-ascii?Q?2vbvlr4erIVsIi98Uu8KPXae98G2XdoZUs/C7CLeBn4HeXFTOA1yHlX2tHna?=
 =?us-ascii?Q?EUFO1Pdtn59fC4wxSk6XSvJkkF0N+Osq5L81C6amSfFed41n9AA9BYO+9klV?=
 =?us-ascii?Q?jdq4ciu7qd1RdqsYJNXPp+ZSspcO/TlP2uFZ3UC2cf40TPcnTCooabQ0SafZ?=
 =?us-ascii?Q?M++ik4ZZN+9g99p91/5LaMyzHFvqAUH7DbhFCwCZ7WlY67fJAzn2ZHvaF1nt?=
 =?us-ascii?Q?eWD2+njwZ/XLSJJWc7hndUAGPoFkvQ0ExTak01anZK7WIFJxoHqF6JLh02Re?=
 =?us-ascii?Q?Qi+Kxp1oe7KgT0FWpTScI8ucypWnxxV6s+O4WS2VaiNRMfo9dsqPwpoFgE8B?=
 =?us-ascii?Q?myOKULGYI0FIDXXi2Menedsxv1Rj6MFKb+Nz7/h4EZROp6BKrxIM+1fi6ubB?=
 =?us-ascii?Q?PAhZO8Ebbre7yTOzZkdmCT6h6HlqEzKTa83jqX1akFlJ8ZQSFEBN97Hn7CgA?=
 =?us-ascii?Q?3hiepsvg4ZEARphPnq6oqXmrd+aZyL27HPkcsHrcFh56NIHosKa2/hY5KJqm?=
 =?us-ascii?Q?2kPBJoEoKBGfQ3LMKnD4trNTRqc7VvjJsefpav907Zuf8+GA7KYz4/wj1Iho?=
 =?us-ascii?Q?YYLiGYXhXxubhv6bGGgW27JbRRXP/aGp+OWkTtGOv8N1aq6csQwF7lRHXbd1?=
 =?us-ascii?Q?jkQHfVxjsk24OcZ2YNNUj9NQyDOPGFAptK2r1B6QkFINA164H+d0Qfsgtj49?=
 =?us-ascii?Q?JZcndmkkUxF4mGevpY+rWj+sG5PnmspNZoDhiH+MOgJcIP/K9nUPFQ4sexAd?=
 =?us-ascii?Q?X4VbwBibw2Ct2L2J+7raqf7TfJuaX2GBlRLlEUSpfHr1i/YTF/YxKCe9ZlpM?=
 =?us-ascii?Q?ZaKb0zL+hDONbcr4FaE6p2FODzuqWclDE5fuDZe9xlVQXflM+gXyCdxvA9Qb?=
 =?us-ascii?Q?PARyDo5rUK/GH6Xr5PuOKAi80a/+hHUvzO3+7RoyY4V8eArRmRZHYEfqJNFj?=
 =?us-ascii?Q?sMdlQEo1HYz7iB6vKC8DsbA6UjwriSdz/VLQpkOUNVkMnJph8bUc8onsnTKn?=
 =?us-ascii?Q?ONIw+ANB540MsvjPnxon4s1eQ1GLMOPljD/r+GUqxGHvCcF31qfWGHhlgaxJ?=
 =?us-ascii?Q?QENLEygp9yb+0ODt00sRJ1ArcrR+o8zCyaIL5hIjlQDiMrbqjjtuy+Q8Vgu8?=
 =?us-ascii?Q?G2Sn3MZz55MlV0V5iwgv6pD2ZOGQ0Tolc3JIauXsFI/BS/f5f0Y2EvXOcDY/?=
 =?us-ascii?Q?+Rls41YFpRYap+rxOWD4i+cUrLDpSViceT3P2MLumWZXgK5ZWRew/rQ1J6rm?=
 =?us-ascii?Q?FZax6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4+XBH1/eXPoZXFNBe892RvDqXVYHpjaWJb3Dj9OCQrlnzGUqWdP3XNKiq9vY62866Cx4R/5gQc2H0d+HgJmd6k+MSU+m8NoTAkEyx8c8f6nZ7gXaCCCQBNeksik4vAF4Fybsbzx/H2UQgmVm8zwIfcfvoNP4WGuHHGE0w6ukPZ3uJRNeXXzJzr1hkgWPDKuDEcnpcU8OvJp/eDdfEll6W07K3m7tmNYUdqeEJgYqKnNTXzF+Y15yI/wkHEAh+gEbFoMt4CtEMiakjRGQn6lzz77eb7WsEag/W/cMpiV4cfRCFTrOe53ttDCUjipUeMmLUOrqhjEmpbTXUifcGAUWvRGQ9bUOun1RIub5vI4jtl8jSBgn2OYX1HM5rmb8maeIrIFt/eilLsaKZFVadnHDXqR181gvhjb9oOUZ2n8zIk4hhIhmgjJCusqRQHRtK0vQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:01:27.1080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fb71a5-cebd-409e-9f9d-08de63fe4577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213724-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,amd.com:email,amd.com:dkim,amd.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.lendacky@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 84F5FE7E2B
X-Rspamd-Action: no action

As part of the work to remove the dependency on calling into the
decompressor code (startup_64()) for a UEFI boot, a call to rmpadjust()
was removed from sev_enable() in favor of checking the value of the
snp_vmpl variable. When booting through a non-UEFI path and calling
startup_64(), the call to sev_enable() is performed before the BSS section
is zeroed. With the removal of the rmpadjust() call and the corresponding
check of the return code, the snp_vmpl variable is checked. Since the
kernel is running at VMPL0, the snp_vmpl variable will not have been set
and should be the default value of 0. However, since the call occurs
before the BSS is zeroed, the snp_vmpl variable may not actually be zero,
which will cause the guest boot to fail.

Since the decompressor relocates itself, the BSS would need to be cleared
both before and after the relocation, but this would, in effect, cause all
of the changes to BSS variables before relocation to be lost after
relocation.

Instead, move the snp_vmpl variable into the .data section so that it is
initialized and the value made safe during relocation. As a pre-caution
against future changes, move other SEV-related decompressor variables into
the .data section, too.

Fixes: 68a501d7fd82 ("x86/boot: Drop redundant RMPADJUST in SEV SVSM presence check")
Cc: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Kevin Hui <kevinhui@meta.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c     | 8 ++++----
 arch/x86/boot/startup/sev-shared.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c8c1464b3a56..46b54720d91d 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -28,17 +28,17 @@
 #include "sev.h"
 
 static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
-struct ghcb *boot_ghcb;
+struct ghcb *boot_ghcb __section(".data");
 
 #undef __init
 #define __init
 
 #define __BOOT_COMPRESSED
 
-u8 snp_vmpl;
-u16 ghcb_version;
+u8 snp_vmpl __section(".data");
+u16 ghcb_version __section(".data");
 
-u64 boot_svsm_caa_pa;
+u64 boot_svsm_caa_pa __section(".data");
 
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index a0fa8bb2b945..d9ac3a929d33 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -31,7 +31,7 @@ static u32 cpuid_std_range_max __ro_after_init;
 static u32 cpuid_hyp_range_max __ro_after_init;
 static u32 cpuid_ext_range_max __ro_after_init;
 
-bool sev_snp_needs_sfw;
+bool sev_snp_needs_sfw __section(".data");
 
 void __noreturn
 sev_es_terminate(unsigned int set, unsigned int reason)

base-commit: 659e9d68ebea99eb9010d4f5756a3853c04dd6ce
-- 
2.51.1


