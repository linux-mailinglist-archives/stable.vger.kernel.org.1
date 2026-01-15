Return-Path: <stable+bounces-209955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A4D28735
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 21:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2428300F196
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DC5324B20;
	Thu, 15 Jan 2026 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b49LJRBI"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC3F29BDB1;
	Thu, 15 Jan 2026 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768509481; cv=fail; b=fbnBAd/N/2EIU4GvqhiYTSnb/+RT3By+PdCkUrIOO3H69+4/I3gnUietXd0JPWXgAbNFIC8PU19yipvbuhsXEvkiAUJf+nRS1u7EMAE2wgI0937hN0Q+vrzOU+mE4DFeymmVNilfzEWI4u2qECPDW4hGk5Bsn/V9CqPeOhLxtjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768509481; c=relaxed/simple;
	bh=J3zK4tPKe5uxJZokjpdLdY1rNppgTdluIsezENgOFoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+ybdxEKE0hw6nuEqoj07TVDRTP8XFs3MRoKUDNQHiF8P9JA44lCLlB/dD9pcws30OIN1JZVVb46nszr2FKBL1/HRrsSTf39i1Lx0L/qt36ga7di8vxF756xyBsAxMRx7OUAcCSgqwYGQOaY1DdcsJTSJO4nLCdYoH7DdmhIWGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b49LJRBI; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEHJ0VyKoxWuTKdXntNGxtkruQ0nPGBiu0hFTOdm2gYDqbdRvN+irL11W+TtXdCsFYPUpKYCwcQItWX6M8eng6xj/KHlp5xiwMZzscQvLNdWVwH9399s2utazNcJf7KtXCuW48J8MpNVjs7k5vqr2b2ItLLA/XdBIC4i/IYgd15/XJs4bAtgn4CFzaLFLi1q82H/31X1FTk3X0g0uHdffxO3cDM2tSOrMcAHcUqlSEx7HhYp80mCDA+iGPctUWD9PsnIjWhrheSBhsGZivWhehh0KHQx01zkfMlowWWJBOX3KSugQv2uMLNEgCM3uCzVB2Kw9kKPcPVcMM9gsfHYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq1nYO45/P/k6zPZ527PhG+WSLG9TOibhYcNIPOomm4=;
 b=aPjwb1W00aMRxYVPLVWrINH5uqjhR043xYbwuabpJfwpthePiu9Zk1w2CqGCzo0c9uXvr7MrPkhsu44ePq3F5AKRS6IyHie0YqPE/G8GpOHuaFlVrD6abUFoWdDFdk0MES1+AmF2munwTugspt/h9NyxnfSpH+PM8KYwqxPjduBYsJbw/C7epdlI4uOwNsqDnZnwJRocejLypgWY5ijXRtedYz3etCXvZqlM6aoepUPIVzDBg5Sx9Tl0YATTxTZVAxRQAWlHeYQtpFF5F6CdPBRGXkiyvQe+mrXfGT0PO/kTz0TYjuJAKnrEombckJ5zlXcBGjEBoRfwMVzAA3UpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq1nYO45/P/k6zPZ527PhG+WSLG9TOibhYcNIPOomm4=;
 b=b49LJRBI/woM8CM9mpiQBJJ3wsmvAWROpF20IcXr75ARmNrYH9rlTvATOEwfxgTRwBJjHho6b/VSXFaolHZWpJzY3lr5ACcjYTs0RSdKarH/isgEXxY6M3txYrd///+r8vEs5sqz3D7pm1PE+u/fHAaWbz/+NCg/7SFsEvqfXZw=
Received: from SJ0PR05CA0169.namprd05.prod.outlook.com (2603:10b6:a03:339::24)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 20:37:55 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::c8) by SJ0PR05CA0169.outlook.office365.com
 (2603:10b6:a03:339::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.2 via Frontend Transport; Thu,
 15 Jan 2026 20:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 20:37:55 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 15 Jan 2026 14:37:52 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <hansg@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <jorge.lopez2@hp.com>,
	<linux@weissschuh.net>
CC: <stable@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 2/3] platform/x86: hp-bioscfg: Fix kernel panic in GET_INSTANCE_ID macro
Date: Thu, 15 Jan 2026 14:31:11 -0600
Message-ID: <20260115203725.828434-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115203725.828434-1-mario.limonciello@amd.com>
References: <20260115203725.828434-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b24711-f996-4c7f-839b-08de5475f662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EKE17wuvypw7lz5DTT6lBS5rglsPkYXWa6rETuDzweUhXO7uev5Xgzmw7r6f?=
 =?us-ascii?Q?+xssOjE3gkl4xMxEIKqjEn99G8Q/iGqBzEmNyAunc054pvfxyoapAHhaRfau?=
 =?us-ascii?Q?ZqsboXHgWxQVSp1AlOEZ2i5Y1tWp8dUa0CtHQGFM1WAhGlPQHshyYijnX04Y?=
 =?us-ascii?Q?0XgkC6cucXBydLREMpXDycNqKXawCo8hZsLYwrg8ZEG1FhJsHlQ+rBzTJZTK?=
 =?us-ascii?Q?tZlH1PmFx7ADNn+naUWw5iyV770XRywBeRj2LhtD3jF396ksdV5f83MtOlOJ?=
 =?us-ascii?Q?jHN9Xm8ksUD+EsSqQ01Dy73nQktsv32SD7dfB73jYLjuf8dSHc0ti5jKPiBg?=
 =?us-ascii?Q?DdFAwC6vXXC+1G12wk84YPK/1rEtVHrm6ouy/UPjbVr4eOfnFVlWYYIiS1Uu?=
 =?us-ascii?Q?7DHNyW+ppiHvFmcth2zBe4xIKupCOMb+lqoSvcaXsvIgQAWXCSHdF86+bSD2?=
 =?us-ascii?Q?/l1/yEZW6bOOUGNOhWiYH7doeXaw85rztVOZ1KQu/vsGXN4io4Z/sVlXuiUb?=
 =?us-ascii?Q?8nt/+SlV+5z09nTHqhBmvrLmiI0BhJpaTR2trKGYolwp964urwfJ3VycqfjR?=
 =?us-ascii?Q?DwH5EDs7t6Imv90vaPo4G15Btm2pPtWP4Mn/m5xWoxLcrlgphMBhF6bw9f9E?=
 =?us-ascii?Q?OvZPlr1bGUCXjF6PPQ8yUtwHFX+ZTqAQUCHwiRvse8avDb5wAaONCWoyJgUJ?=
 =?us-ascii?Q?4KxM92kqGLDbeD95nYgMY2NpbHA41FR+lrq0GeFzHfoGo3w99bGWNTrPacfW?=
 =?us-ascii?Q?QG0DGGSUXH4YKDLS3YtRiyFy8m2jwBRHLxh+Gn4vVBm9pYNeFFBIjnJJeve7?=
 =?us-ascii?Q?yjY4JidkH15VsdtWgUJXQCqllesoV4Sfi5a5gX21BbgtikLpBBeb67ueWN0m?=
 =?us-ascii?Q?u9w8HDlhyN772EAYbV6Kbr19HpFvZ1lYm6tIcwkZJXiAH3ggWtc2s4JYHQQa?=
 =?us-ascii?Q?GjUyS+s3A28CVqesNjEIAmDRAJTpD0dyDZmqI9YomYcXbSInuU760em0qmUl?=
 =?us-ascii?Q?jPbpjJBwykSZjM/bVqJZLcND++BTr7OtRjZWGGFQ4CyhqMHMzlWseUWNlRy3?=
 =?us-ascii?Q?bQeNo8x21SUZyqcKSn4TbvZc9cDgUEwqhLni2hx0GlfGCh7yqb4U+WGupVuW?=
 =?us-ascii?Q?8dqioVVWv1hoX7098LWbAhbWaUmLoikimVXdu7OjCmWhn/g1o3H+aEZGMNo9?=
 =?us-ascii?Q?Nw49o6f5BVHWoQSeQ1BcnQBEeVjMCiw1W54ErjKjVWfyJm/bt1qG+v8sxAVD?=
 =?us-ascii?Q?aXwgZf6aqRFE4uIZPu0Rqa3nglFxZBnryuWaDA44tqKyJtSlWFlDCUSrWnka?=
 =?us-ascii?Q?8bIivU3YmU/YZ3cX9JDVdZiOBc5obskE/1G0cwN4R5bDVKxm8SQSWYDGFXZ7?=
 =?us-ascii?Q?QTdRdlU8PjUpPF/6JpZ/9lB/ytmVIjSobD59jQO+EsrTjYM2ewufbLf7Q7uz?=
 =?us-ascii?Q?zSPtoCKJ8IIekEexUTT2NwDeARZa32KpBfRs/yJrmCt+ycDggQym52Llap7X?=
 =?us-ascii?Q?Oq/kkCQw3B8dDaOgjPKUdZheASzWpHsHcMbOieQV0EYX2gEJyOuCJzKIVBnD?=
 =?us-ascii?Q?wjEa/w0nQXuMW1KM5KVN/+4FGbvHihwY1gDwAQLhrghTT3AY006uG2FWY6df?=
 =?us-ascii?Q?KHQZnDDFT9cE8jVctFjMJmESE+Pa4PPPG9RZ6QahB8NiP+mmdy3GWp0dtqN4?=
 =?us-ascii?Q?LQQVDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 20:37:55.3412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b24711-f996-4c7f-839b-08de5475f662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656

The GET_INSTANCE_ID macro that caused a kernel panic when accessing sysfs
attributes:

1. Off-by-one error: The loop condition used '<=' instead of '<',
   causing access beyond array bounds. Since array indices are 0-based
   and go from 0 to instances_count-1, the loop should use '<'.

2. Missing NULL check: The code dereferenced attr_name_kobj->name
   without checking if attr_name_kobj was NULL, causing a null pointer
   dereference in min_length_show() and other attribute show functions.

The panic occurred when fwupd tried to read BIOS configuration attributes:

  Oops: general protection fault [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:min_length_show+0xcf/0x1d0 [hp_bioscfg]

Add a NULL check for attr_name_kobj before dereferencing and corrects
the loop boundary to match the pattern used elsewhere in the driver.

Cc: stable@vger.kernel.org
Fixes: 5f94f181ca25 ("platform/x86: hp-bioscfg: bioscfg-h")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>"
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
index 3166ef328eba..6b6748e4be21 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -10,6 +10,7 @@
 
 #include <linux/wmi.h>
 #include <linux/types.h>
+#include <linux/string.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -285,8 +286,9 @@ enum hp_wmi_data_elements {
 	{								\
 		int i;							\
 									\
-		for (i = 0; i <= bioscfg_drv.type##_instances_count; i++) { \
-			if (!strcmp(kobj->name, bioscfg_drv.type##_data[i].attr_name_kobj->name)) \
+		for (i = 0; i < bioscfg_drv.type##_instances_count; i++) { \
+			if (bioscfg_drv.type##_data[i].attr_name_kobj &&	\
+			    !strcmp(kobj->name, bioscfg_drv.type##_data[i].attr_name_kobj->name)) \
 				return i;				\
 		}							\
 		return -EIO;						\
-- 
2.52.0


