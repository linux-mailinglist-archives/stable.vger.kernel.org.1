Return-Path: <stable+bounces-76927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C3B97EF74
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 18:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736931C2153F
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF5919F136;
	Mon, 23 Sep 2024 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aD3SrH2w"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839519F401;
	Mon, 23 Sep 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109905; cv=fail; b=Vfr5EH7w17K8HILdwqqhBin/NZ1HTZKNMCD/OJaAKsN/2Cn5j0ZP6GU26XN95o23+2T0d5gFQCw3bg36aityI0vJEtVCnrm/pwuzqf3YelaUuxd3SJJ//cdOHx59b4dhDXKpj0HDEyLBNDqrBtkYadcD8IMmvjiodOUogCh/MIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109905; c=relaxed/simple;
	bh=oepHvrRteVtu3NOBg6KdRGvXg2IgwF0+gR5R1nRQu7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fp+B63zPCMxdi+APx4V/bf0qd1Tmc4+hnd/cWtQMQwIcm/hNhklxSjSdmHAJTE+0PD9SCW0TcCJxYtBlvk3oKWgn6UOcHGu3hlCIyED8Xxa3OwToehaMxTRUca4ZcKXS7vIWiI0bQREOUBHngQmCozVrb1G3G2UPHvwfCmeMW9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aD3SrH2w; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xp1dMKw55ZTNvcSIo6xq3lT/PWIHkrGELT2tYp85LFd73Fdj2g/QS0yJ7StH77sZFpGUNJ0UcmtDrLJjMBNbcK3mZ7qqlFfuSLKOMlZ56fT1NLmPjztE9/chRXs1Ua8i3yuqoVGV9nrQ5IEozmIXlmUVknVx9/BxHEHsrBFvkQR77yUvZmV6BB6xGFcZw/Qiupn5K0pppacwtx1QSpM6k8QglN5C6Oojgz5Ex3q3C2MUToJkegDRvEUI4E9gLeWM311hPsE3vijkH862asZm+YB3JxrLersZL5Bxk/nFhaI/U/oncFELWOZ9y3HQ2d6Oecn9JjHtSNWGkJTqPJU6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B355m/4W5GLciv/FJHSD7AK9150IeMXXIRPSVjEw0Y=;
 b=t1dQwH7hQQ1UpaTyl9nkX3tYfwzvxk0CMs+0oOlQ9JBmN0jVMhe++UKncf5kD60r2drFSHqDMKTbu/A3bfBnu2fL4+BhV15WZHjK8r+GzVWueAYHpjaXHIy47oTSZ1Yk+P81h3qUw2uMaX5x2s559Bo4PIL33zk8pKDUlbJTxAKTm4FV38DMknZ1AkndyW6jVHROFm9dVKWuTENsvutjYCATzP69kiz+Y0s+3I/4HFZa1VB42vGcP+XRwa9sfSLXG0ChPvGDQ0E9zse4MCsZZDOKDreO+xCAKuy+qt6dJVh6OR3V0PSMnQ87Nb0a3Vxv4XUp6W7uKeVuy6V4JHgk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B355m/4W5GLciv/FJHSD7AK9150IeMXXIRPSVjEw0Y=;
 b=aD3SrH2wklTgBwUrQAWG/ZNmnIwO8Mj4HJkaUd72OU3Plt1OAOdq6gUoMB/AG3oLs3XFh5Hd8gk+9Eese4cO8QWbI5ugaFD/zKcFdTm4rpDIW1V1m7bT0oL9+7VizL7dhQ7/mp3T62hA4e223mt8Nip1lsDBIiNiYhQMCwS/QEY=
Received: from MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::13)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 16:44:58 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::43) by MW4P223CA0008.outlook.office365.com
 (2603:10b6:303:80::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Mon, 23 Sep 2024 16:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 16:44:57 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 11:44:56 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, John Allen <john.allen@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2] x86/CPU/AMD: Only apply Zenbleed fix for Zen2 during late microcode load
Date: Mon, 23 Sep 2024 16:44:04 +0000
Message-ID: <20240923164404.27227-1-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 754b7555-f625-444f-393e-08dcdbef0f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SxM7mhbTDsR+MEkmL+J+xbKnsnUILFQAtmuWtzl9U270kzMtMjTgY5fZXf58?=
 =?us-ascii?Q?yuyC5Citbt2Gsn8C2bu9Ei8t8om3GBceCdHPs1KWcP/taXnH5CLmLZPdazgS?=
 =?us-ascii?Q?uA6mPx+xCDZv/RvfSa5SaNhtF96af+rhojkp0NrCLOwDeS9Y0bITthpgaxvR?=
 =?us-ascii?Q?O5lHW2X260uIB+4QyIqIa5XfF/SCEvUZPbJtTxIzYmMtSQ+MSUssX0oXYb8K?=
 =?us-ascii?Q?pIc0NrF59Y8JcMt5fU3gwjzuKeXJbUrWuuGw1z3VLYs9BS9KvmdbU2OU3v3H?=
 =?us-ascii?Q?uT0Vchb9QrOSWXAIDzVo7qYRP87629bArlliZZWDG9iKljwutWSjk14Fqz04?=
 =?us-ascii?Q?cPleOMk2COOpvSMwd7VnFtJnr6zRmH3ROV4OjkQBS/9eHy35JiaVXqWWhPsK?=
 =?us-ascii?Q?37JTertHKD+uEQPBXKvmF+wFuCrnMtAhreXETBwwSofPsf3QWdDivpkABlkV?=
 =?us-ascii?Q?5Vsx+Iw95DlcDS9eN+sVRzwYatpGbyc7WsTF8BrIDxqdATeg5Pk/54Cg/iTm?=
 =?us-ascii?Q?GsEtacBDzHMPmb6a+WueA5aJj2FsIIIqexOVQnT72UbUZr625atWDR4IOlF7?=
 =?us-ascii?Q?dMwUdAY7iBTBHIPMHBOcTE9lf+VXV3DqovM+24Bgt78smt2F1tX23NYo1kbr?=
 =?us-ascii?Q?BFBgnDG6pLTWnoCb4fhVv9MQTA6dfewzeyHpNykd6COxh575tg+QDSoH60w1?=
 =?us-ascii?Q?DQHHkmnRy0h552GmtDASq2yl7iqBpiwac+78V6SZfPniW8LNBGXODyyog5mB?=
 =?us-ascii?Q?0BaMgmTAemXzK/vjonMdlN/eVe4K3+YPCa5hwjK4OHRl5Qpip58xk78gUCJ5?=
 =?us-ascii?Q?FIntgiSeHsLPdbtl74M4EJgaucUEi8qSeMmp1bWYrHoENxVXjmxkgeNy97sr?=
 =?us-ascii?Q?/r+HFrnXJXsp0MgVXeQHApjE6beINk4imEIWj0jLecD1Zbl56ACHhVb12sV2?=
 =?us-ascii?Q?cNBbcM+xHstXZA6KAtEskDEDMER0KBdO6aLuD1USucpCmWE0Vir53POooYPH?=
 =?us-ascii?Q?mYT2kBxpFW+gXiIa4LU91aiAKudhSyOwdolZeuKSMN3y0ht5RZgPqTzYahsU?=
 =?us-ascii?Q?vtLZoW8Y0xqn0HmpD3EoIPjeJr5VkwJ4nNCN5P0K882c98g8LFrk8SY65f0P?=
 =?us-ascii?Q?dwhoHvYKMy4MHcEO6AVa/RPviJ6lmy65Hdd0p6OaH74acGYZRo6Xc+5zS/1L?=
 =?us-ascii?Q?d+tOvBr8cnwDt/HQMGMn5wY0VfTjPkWqg7H/oP+B16dQaJQNXeWet9IYQIqO?=
 =?us-ascii?Q?hWg5oF+THJqt7p11UNBWHoE8lcAP2Jqg5R9hBAALcT0V6/7uafMvG+iWlqNI?=
 =?us-ascii?Q?lk0zeZAaV2206KuwxRKt0wU7uKJ0ZPyfUtOOadrpwzLKDWNOcG5NyvkJeRqG?=
 =?us-ascii?Q?f15sXBnDNbhOY9MKohN8fpirTryL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 16:44:57.4986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 754b7555-f625-444f-393e-08dcdbef0f16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757

A problem was introduced with commit f69759be251d ("x86/CPU/AMD: Move
Zenbleed check to the Zen2 init function") where a bit in the DE_CFG MSR
is getting set after a microcode late load.

The problem seems to be that the microcode late load path calls into
amd_check_microcode() and subsequently zen2_zenbleed_check(). Since the
patch removes the cpu_has_amd_erratum() check from zen2_zenbleed_check(),
this will cause all non-Zen2 CPUs to go through the function and set
the bit in the DE_CFG MSR.

Call into the zenbleed fix path on Zen2 CPUs only.

Fixes: f69759be251d ("x86/CPU/AMD: Move Zenbleed check to the Zen2 init function")
Cc: <stable@vger.kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Clean up commit description
---
 arch/x86/kernel/cpu/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 015971adadfc..368344e1394b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1202,5 +1202,6 @@ void amd_check_microcode(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return;
 
-	on_each_cpu(zenbleed_check_cpu, NULL, 1);
+	if (boot_cpu_has(X86_FEATURE_ZEN2))
+		on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
-- 
2.34.1


