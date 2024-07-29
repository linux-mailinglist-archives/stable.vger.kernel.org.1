Return-Path: <stable+bounces-62600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD793FD1D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF7D1C21EB1
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFF61741C6;
	Mon, 29 Jul 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NKdWz57V"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017B158DC6;
	Mon, 29 Jul 2024 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276502; cv=fail; b=aOVug5n5+yDycRUEwrbr0/mVDkwI1Lupeb9Rv+jQPENbNlrvQ0K+n//hqCk1stgDMV8F4ZS618kuclHjsGhE18Khl4V85ZtBeXWBrtrpmMP3/GlI2Kvp9E6Z4qMjuA3KQODT2H9QbUvHfiiBMRc8mpCAG5iUb4XrFx7nkoPrkqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276502; c=relaxed/simple;
	bh=tmBpLghpB49+LH6mue9VRp2+zj2jYmPyTmY0S3/cgyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqvOkMrpcolgs6lVEAW44MUA4hFSxblvPi9PRLEGMM1V9eP/fjvqHP5BzJdZRq7y8M/uhuuRWRZDpQVRl1r0EWiXoH7I33EU22HVNnyV9DnD2LYL4uEXL0aYvyL/CWZBre5rVmF3Hem8Dok7D+4aqs9ffKNt4BC18vY/pAYqces=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NKdWz57V; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ci+3B2aGQ2pl5M6M4I3h1zsNbEZlwhBMC9I2TTeikyqRx/EvtgSQtMA3sBa2/n5aU6B353q1rF55z2O1zbF+pw0GFQrsF0gzlouILkd9OaB1NIVfc9kzcC/gaRH7I/zLcdYZ9LXwocndrhvF8W7ZTnRzjlQZdMM2sCgiRQqcuS+H74MDTgAJNrfsOlGZQDlFp1LUvssusFFEWz+MytIZ/LcBOHgGEmWbOfM8pw0ftYf3xyIzqiLoPflL8gdvE2SaIfnnF9R96xcS0E6nwiEK5e+sIJsWEc0b5LDuN/xQ1jLGIoQBDsNc87puiCai0PHElEF5qn0fICT22+JIwnpeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJs+SwbcqD3sxLk7R3r3vqbSBY5tPGsnf+d9j1Q96Og=;
 b=AZu6Vvq28L3o+cibzTLR2droy/7STQ901QOoHKmBIM/7DcnpxTSiW2iThwI4HNDlMH/fFwTn+2DCnb0My+JbQhHuksmKJ3HVmyZTXL6Cpgw1B8E29YD4BS8glc4oEWzG02n08swztQCPOwkPRq9NDdtQLfslemFF0IQlLQShXiMefS/YqWsMWCEI1WtwXs2Un0egZ3FZN9JUnjL4LQO6n9eZMHY1Oe/anLSB2dJrg7YnLLgyQX5Lh88Lzldo1GFOnkdhoXPVXaK7hlDZgRlQFRR0N3I288/8T1LXH+eR4TBw5Xwc1dHEw22yfC8Ns9XppHAj135vwxMRrj0PdzrACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJs+SwbcqD3sxLk7R3r3vqbSBY5tPGsnf+d9j1Q96Og=;
 b=NKdWz57VvhrI6QfbMN2v420WHDF52JFZTdvIk+w+9kcDRZR+wlDu+bvssSW6C/DqVU9Re9XJJK4tpOVFUFT0EcgZ83e2vMhNvZmOzHyX/HbVaYLfRv6Bqv0+xzIw8roszmBX10oRUbF76gPPgLZHAOxb43z7uzJWFiotjl+iuWU=
Received: from MW4PR04CA0182.namprd04.prod.outlook.com (2603:10b6:303:86::7)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 18:08:17 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::1d) by MW4PR04CA0182.outlook.office365.com
 (2603:10b6:303:86::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 18:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 18:08:16 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 13:08:15 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Tom Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, Pavan Kumar
 Paluri <papaluri@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] x86/sev: Fix __reserved field in sev_config
Date: Mon, 29 Jul 2024 13:08:08 -0500
Message-ID: <20240729180808.366587-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 780b5f43-8e95-4498-c6ba-08dcaff96b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tE4Nd/T0AEBwhDMwVOJaia15L9Rfccxa5Ko3KY1vtlkdNrLta1pzF0zOHnKQ?=
 =?us-ascii?Q?+XV1h5ljtULizamBftzhWbmErRBMTxeobcTKv1XD/sXfl56Xu9ZJzEl2nx6D?=
 =?us-ascii?Q?YfhFOnAWJMPZf6gSlJ7sxza60szaJ/3lNUDeQfKLAfJFJPaPTIhPgn2U0dMQ?=
 =?us-ascii?Q?J+REFYaFw+tSaLcp14Auv9T17HgcIWF38uQByBc5EGCbEXk+Rs3rYiruFBTU?=
 =?us-ascii?Q?ELwWE4FJET08+1GAVGTtXLeRPfRK+mfullattAfPej8AjgWBv2zfIQxNjJGA?=
 =?us-ascii?Q?DRXyN2QiUD3m5RieOs11pnIZKM/mmSdZEifCSd82LDzQqX3gI8/fqezn+Vk+?=
 =?us-ascii?Q?F2yQN8yz3ObqmgrxANaxV5x8DslNT8rwmE/ROY8ZnO2cjomLC8N4BlPeKWy6?=
 =?us-ascii?Q?lReOpkQz5QDrRqrasMaObtHTc0m9LpCuOPeE4rBEw3xrB569HdvsdIAOj9oZ?=
 =?us-ascii?Q?1NV7KkJhKSNZT9C6LQxLPSuJucLKXrSaQDVwvD4OI/LxRgfaglXFP3dAECqU?=
 =?us-ascii?Q?0nAHfRvQPpVGRYLp7wntu9I5l/sgljvmZr275SzpXxDi9I/pBhL310TEyhnG?=
 =?us-ascii?Q?ZqzyB4cJjRGa13XijoBd2K+WUKSE3QwTWbUVvWTOVDI38mFj7Lb0v3FMgNKj?=
 =?us-ascii?Q?KRzxE98Go3r59UUU0T/rZeDAyXHfEkVxqYeQmKuxUxBRIfdyaV5HyxgpnZqr?=
 =?us-ascii?Q?dripN4hacpdcFQXV59IvRxER17FZnM4sVAm8ypbGLeeg3/AulG3rDHDbBKJJ?=
 =?us-ascii?Q?Bht8jlebE37q1icacM4NA9blKZ5ds3TppAwON9n+uh0YFA7y+DgC6Hkgq5RC?=
 =?us-ascii?Q?tC+sH/xCUPbENjFtNyv/XYRKBtd1RQBRRY4Dns65UmRdzh9j+z9SPyv4Q21t?=
 =?us-ascii?Q?EmDWD5g4gBvRzKD9/TjiepBPrTSgHtkIX701wfN36lBaQJ9ioar/dAHIoE9Q?=
 =?us-ascii?Q?04TuQnF0Ut8dCMFjhBFHNgo4QpnXWC7gPAJKavcLmWLFTsMIdIDPm7NSpom6?=
 =?us-ascii?Q?PddvEUlfQdMorkod2X05MjZbbpGuQbUOuYkhktnVUZx7wnya+fSNzdxNUHBg?=
 =?us-ascii?Q?PGucbvPuAY6xIHJsw6QGIVoOCELqmz5uMzb2mW5Pa+tg5+Kr0dbDLMi9u8Bz?=
 =?us-ascii?Q?Hc3WhqZaKCk4fJbdLTc3Y+ZN9+19mHGlN4Cz0i5zqeTYuXR8nD8C1aXIXkaL?=
 =?us-ascii?Q?ZCUOwzxcfOoNUtxhwD9L78CdIqKwACV1hAD49qL2Rxf3g6TXpRD/PD555G0U?=
 =?us-ascii?Q?YF8jTuUzEpO68JueMoR/jwXTUi4C0D1+dPA0qi6pEWtYN0r0y2XlZrrqsSMc?=
 =?us-ascii?Q?J2sSsZgJo1qYD6YVcU+F/90QYvdnQMJ5fbHbLhYZPddnhcyz6UW+PhdezMNp?=
 =?us-ascii?Q?0RiuyRTC0oCaMQ2wEZR+ubKDmAzOh0M57xliKCI18rnwM4oGur5qlmst1ldn?=
 =?us-ascii?Q?ZijKN2THNeBBc19GqbCnesdat1HgTQRI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:08:16.2178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 780b5f43-8e95-4498-c6ba-08dcaff96b75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245

sev_config currently has debug, ghcbs_initialized, and use_cas fields.
However, __reserved count has not been updated. Fix this.

Fixes: 34ff65901735 ("x86/sev: Use kernel provided SVSM Calling Areas")
Cc: stable@vger.kernel.org
Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
---
 arch/x86/coco/sev/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 082d61d85dfc..de1df0cb45da 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -163,7 +163,7 @@ struct sev_config {
 	       */
 	      use_cas		: 1,
 
-	      __reserved	: 62;
+	      __reserved	: 61;
 };
 
 static struct sev_config sev_cfg __read_mostly;
-- 
2.34.1


