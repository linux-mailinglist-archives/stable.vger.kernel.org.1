Return-Path: <stable+bounces-192422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 446CEC31FAF
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 17:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A85A4EBB6B
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388EC2F7AA7;
	Tue,  4 Nov 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CtvUydB5"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604162FB619
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272644; cv=fail; b=R9hoyL9H8OUjtqU3VTtXDj1u13/5DTgN/bDboxC6MINE5ftBRykvQ9np639Rb3VTsutvO4sZWwtx4f7mCFE//ustyElcJX0iy87SSq0ITq4aJzSn6d2DYNlWDwy/R2r4TY88WgJTp01fy0DbzOIP2/uyV6FVykK4rT09mbtCuhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272644; c=relaxed/simple;
	bh=kbrlnFicAqcSLtMxRK/PplaiCagGEZLZkl96353uAEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtE8+hwHeyPTiXxhV+qijJNc3EsXUydvRPaARaoPWK2GCDQ6EcA8q3OEDUvXOvkhZ4raiZZfAa9WA2abW//MVcLaXe7BMJyvEu7vPmAvAI+kyChIT2T2X/M3G8WkHq8uEupleArQD2Z8pr7moWigCWdkbt5TqnZBzmCjFTC54wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CtvUydB5; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGkZzeLaeLS/hXOZL1MpYZa+j8d7i/YPnfk2EFSrJlvNeQhYS/hISNlgQdBiHycEO1wWi3UeTipGg/OJ5OEUlQlGipPJBAvdkSZEjcV37LJScile/RGguJBAD/22MnM5xzibRQ34RX6v5fed/eieW9jxwyGGUrhVefP0m4bP92nkimHOa9nYZLeV3yxEkeRvAD2rDHfui5ipUXQnEe4IZql9P/Gk3xCqZ6aibcSlKV5kzjf7wXmbP+juB04B4JRH90PoATBUh0HAHehntQLMEIW5y/+pks9FDEm/em2DFpX25wCiaXuc8209YWJZmmLA7un535abjWsZ1Sex7Ux9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmCBvwJoaefA6wXxLKsepqnFfT7vHVG4oXpCb3638qo=;
 b=pM4ZdrdgUD7CAxPFCUDdg4O4qhVuFyeP4+G0880o2ARgMf7FWQ7xxE4MdNqedqxdWirEpbnRM9STdYHfqEIw2hKAFh801g6rMlDsyMeY0AYXg7izevQaYnyM4Kbp9YnsdNimpmfHeFbhzLS4C4P+hPZz5YeqG59RkRRw3MKqOx/YEbwoocHEWsxeRVpQzW/mxl7vpktioHuea+MohDn+bMkJ+LHXa9rkHl+xLYiJZ92uQEjG6fJX4e2ZMgOvLvXpWPm8W0MXvf/EDns6KqRlYT0+L9uzyn5DLuv4mEWDNjppZccZRpG1y8oFzB16HB69liWZjcdsMBhSd3P1znaA1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmCBvwJoaefA6wXxLKsepqnFfT7vHVG4oXpCb3638qo=;
 b=CtvUydB5I7tdC/fxXeU00zd77D+CMyZxBGBEh8x7cM4/A24pA3RamVg70Mbm7YLMdCcg3IzwRcQQEVqHeSFilEYMx+l4A9gITNNitb3odkJOzMsY9aXMmu+UZ5sNwWJ9mn1FBAN/IPiAwxBk0wBJylha12iDbk6m3NiOuHi34vY=
Received: from BN8PR15CA0018.namprd15.prod.outlook.com (2603:10b6:408:c0::31)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 16:10:35 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:c0:cafe::db) by BN8PR15CA0018.outlook.office365.com
 (2603:10b6:408:c0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 16:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 16:10:34 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 4 Nov 2025 08:10:33 -0800
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<gourry@gourry.net>
CC: <stable@vger.kernel.org>
Subject: [PATCH] x86/CPU/AMD: Add missing terminator for zen5_rdseed_microcode
Date: Tue, 4 Nov 2025 10:10:06 -0600
Message-ID: <20251104161007.269885-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a53e6b-6eb1-4dea-84bf-08de1bbcafc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/afCeivwVCIqCLHnEgNqpA/Cx8Ogk3UvvIbiQObCf1uDcvdf0GQPNfTA0GDq?=
 =?us-ascii?Q?EMhcRAnnUCDm/2Nv0pAMmF8wB7K3gh0f+RJmMqdhyRM67Yl9UzXEL/770voV?=
 =?us-ascii?Q?Jf+609QKHbK94dZ58gj0lKtZI0MdDyG1ELoEcuPVroCfUHMZ6c4sW3oKQeZK?=
 =?us-ascii?Q?fDVfHlv2o3aB5jkybtBRHG2UScsxJfGKj8WNylrErHyQUTS1J9MNke2YwM5d?=
 =?us-ascii?Q?8KnQbof/zxx9kPBE8NnEBFGYBLKBffee2i3rnDb4ISwPiNgmMAtHYa5kc6yb?=
 =?us-ascii?Q?CIES7GRd5FW53Wr0Y4lKJcEvNMaYYmFKzQ5091tsb1zQ0iRIVmZVZZV8Sf3p?=
 =?us-ascii?Q?qAgwbMsotQ7fhzF3+hKoxR6FDy+h/DM5AEg/aJZ34fKLi8XCK26PhGcpKMwA?=
 =?us-ascii?Q?dfWB2rRVcta0lW3T0SJvgTWvNUGiW/e759kv/mq+Ooq/WcQVnJf6tdnmqwD9?=
 =?us-ascii?Q?0w/wFCg2NVMrBWmxPGPTGRXkRiy2rj33pCkOd4OJsEWMFAML1ISrMtmKVNUh?=
 =?us-ascii?Q?JkwFYsNvorDb316pKWWt6H41X9o5w9p9mPqjlF5XLu4GbFGHKSQaVHhybzwA?=
 =?us-ascii?Q?USkSahup/euUj4r8YGQNMTw9inKZWYZK9eKXnCtSfUXhszVqMN/Vas7mp89I?=
 =?us-ascii?Q?49RcMb8bhQK4TPnVoP0hGidlIyfLwawxP6kytKZf9s2LcwsZaLCb+PAC0E9I?=
 =?us-ascii?Q?yg3GipDvuvjKAlm78iiKm73Wo5lensDXEl6GI2jF9crB//GQgV0N/9SJUOR1?=
 =?us-ascii?Q?wSxgpCFSIDasHzzKbbE6cxWNdEMfXkTvaRElULZhKgfEoZuHMpsPEk2SG2xP?=
 =?us-ascii?Q?+FEoQjpWiHlYwzE6U160Xgy84i8/pXU4gF+CDKNSC0cOM9llOCg5ciXKC2Nm?=
 =?us-ascii?Q?aJsV8SStY2culzq/L/EOZjJTS/uuCDnBU805IO+rTRDjSLk3iHz1d5If3bcA?=
 =?us-ascii?Q?JJYjHOLGcS+VakYb+g+wht5J0bjcv3XosTWid0+GWKtGlhe6NCDcuhoDorDq?=
 =?us-ascii?Q?DyO3eyBsuv35RgIxvVtrdWXiWb7M3sgXW+VOKsobAAAci6PkJMuDB4GWolZt?=
 =?us-ascii?Q?1HFJXVbrTdo69ot1esBD/vx6d2XjKTNKTvsKQayAwe+60T7JxFzh90mBPwmd?=
 =?us-ascii?Q?JzbXQd6As/To/tOFHMuzoqlC/8N0LNF0OElIbF6c1xmuoAEGzG1oIreT8l6V?=
 =?us-ascii?Q?ywarJuojjGC7RIxCCbvuSpsXttSSw5dtFADvLg3Kr4+OR156SOxPddZPrMm4?=
 =?us-ascii?Q?drlqWksJLqWSaQe4ZkkmKJ++2IN7qxJKtl/u48v3FKgHKuu1iqv3M9OJKgc8?=
 =?us-ascii?Q?L0klVX9z+G42t4TSkBI1s1TlB5WnWjNZeganVF62pnd1fDsGns2wMmOBvVC5?=
 =?us-ascii?Q?hHtLxSj5rV85JmnY/I3U2OBgU8OdcGdJOjwFTDQjQWsfgtCtyLnMo2gakV8c?=
 =?us-ascii?Q?8CjKMMpv+fQq6NFUXrXmabZGDf4CC7dImBwEwHLoghKRSjdKTGv9vzt5N9YM?=
 =?us-ascii?Q?cCUGEBRQSq4JbWz5+1YO9QNfX/1vkItBos/TyeCeqVHIB4cyWiKjMagdSduC?=
 =?us-ascii?Q?bRWIOWB3SSA6MC93u14=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:10:34.9324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a53e6b-6eb1-4dea-84bf-08de1bbcafc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510

Running x86_match_min_microcode_rev() on a Zen5 CPU trips up
KASAN for an out of bounds access.

Cc: stable@vger.kernel.org
Fixes: 607b9fb2ce248 ("x86/CPU/AMD: Add RDSEED fix for Zen5")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8e36964a7721..2ba9f2d42d8c 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1038,6 +1038,7 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 static const struct x86_cpu_id zen5_rdseed_microcode[] = {
 	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
 	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
+	{},
 };
 
 static void init_amd_zen5(struct cpuinfo_x86 *c)
-- 
2.51.2


