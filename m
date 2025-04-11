Return-Path: <stable+bounces-132288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D61A863C6
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 18:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D469C2984
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E56D1F3FED;
	Fri, 11 Apr 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dVM6lmNf"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66024215773
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390294; cv=fail; b=b5zyu0UqTYDzHVEyFThxNRwurtFtY6ujSpjoUtlhvjGCatanGLP86IHe3cVux6qU+XF195V4kVqZTgDahLL3lOFlcP+gqD0LL8ttkVLJcmDOS1kGLG8wKpi4CsTZKq1zyuuOn6Z293ncgBDcNRsBhRlhoI40zqV/ELboaTx0Yws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390294; c=relaxed/simple;
	bh=753CZhZX5tLHCaVJXavvK7IuepJ+QUMd4d1f/SKBEZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4a9NvfcKeVUwwzxCy9K1XKBzu4UOiKQvQPNXSLj1IV+fYqGxL8U5RNUQWFI3aQL1F431uoqMjvZ1Of0QXG8lnrVqy3//Hb5wRrJ1kbJGNGuqHib+ZtZLmh5d32cUw3vPFcfdBV3Wf+yJ5wqsMrBA6yyn5BYCbCSwzFEzUgG/f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dVM6lmNf; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBNKUTWNo8CA8r+yWTColl7kKmB8iN9zOXV8oNM6+XUwVjdiDV4/THE89x3y6gL+2C3HHdb+/4CFytJRaI+mbmEuuZSFl/VKf8mJL4x8XhRL14mS6iRQivfYAWVQUTQgtEyFOyOAantf2UjB7g0tUWoob455itunHJTSmHc0wYdYvBbTFoxx8XXy2wGpKsA0oQ6uB8jj31BwKjj89+xqwEMYGYEEFATpyxuZOQu4rrIJDu8FP7VaZ52HWHyKXtYKIFbLptRXW/INbwYt+68DbeY7b0hXt7DWKv9cWYWq00GU4IaA2u6UvGIOAqVfL8hR4Z5tneEdkr/Vg2hz+cX74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0SkV4RC7WdJ3enE2CDQ4tbrjSWeCNeuXhm3ZMN0lNM=;
 b=e1BENU95dmNfURsW/W/dhncke26QigG6jObQjF0z5m4hHqwxde7W8qMholgWyOk6OYd/oR+v339RePNh6Gax1BpY6bJAPjx/TA+IkydYKyWGOe8Qw8c26Vnxg2DdX928enmixWfTeKlwJzVHrJoLODq0jKPrDpACPCDw1pnEPHHio+Q3xAvx8wm25+z9N0Q2gG1nH8sled/ELSK239KjFW4ciOa2JY/KQ/t4SZ7tbiimGCh7/2F1euINeNPTJ6Nmk9fCzAfgAl+ZQ25g0aVui6FcMmUbaBAYutJqoocdMgqEe/u2xeqdshx7NHBG4jK3+BCHggbK8GqvIX5tLfaswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0SkV4RC7WdJ3enE2CDQ4tbrjSWeCNeuXhm3ZMN0lNM=;
 b=dVM6lmNfXPtG4YXBl11rrPkzB3D37RRj6rhdscmi/w3mYbAnnEgvcVkQAe7E7IxVI8sVFAZMWKWs4xoTJ4mCZLWoohAMsNJgFxjXnYTahV00gafwPqTIyoXI7erXgFEpOVY3uCfy84vLdA5d3bz1BTC15CSv6wFW5UDDpkG0/Rw=
Received: from CH0P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::24)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 16:51:30 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:116:cafe::10) by CH0P223CA0006.outlook.office365.com
 (2603:10b6:610:116::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.27 via Frontend Transport; Fri,
 11 Apr 2025 16:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 16:51:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 11:51:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 11:51:29 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 11:51:29 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: <stable@vger.kernel.org>
CC: Roger Pau Monne <roger.pau@citrix.com>, Juergen Gross <jgross@suse.com>,
	Jason Andryuk <jason.andryuk@amd.com>
Subject: [PATCH 1/2] x86/xen: move xen_reserve_extra_memory()
Date: Fri, 11 Apr 2025 12:51:21 -0400
Message-ID: <20250411165122.18587-2-jason.andryuk@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 9feede7e-eaeb-4b8f-0377-08dd79191be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUlMWlRMQ2FaZkRyWno2eHNyRWt1K3RWejgyNlRsbXYrSXNuMTNHTjd6a3Nz?=
 =?utf-8?B?ekp3emN3S0dHT1N4bWd1VGovYjhFUXYxeDhzdGdZUHc0VU8waStueExYUkVh?=
 =?utf-8?B?ZlRxaVJTaXk3MXRsb3NNSS9mYkp1RWQ3TlNtdlowL2Zsai8yTkRVQzFnREht?=
 =?utf-8?B?SUVEb3RtWlpvOEthdkNKWDFCNDc5MG1GV3RRZUcyUk8vZGk0SmVTRkltNE9N?=
 =?utf-8?B?UzVNek15TGZYQUdSTTcrZ2ZTcm5MZHlMeGNIY0FUZ3RuRlIzTXNUTFdlaFha?=
 =?utf-8?B?OEl4bGhaOXZoNGx1azhXcDFiUWJMNnUrUUZBSnZzenY5YlJUNElqQ3lpVExP?=
 =?utf-8?B?QjF3azZtaEViaXFYUDYvYjYyM0JBc21INEp4L2Z4ZmhlR01CQWJSU1k2bHJu?=
 =?utf-8?B?RU1oclI0MW93TUcxbUYvZHRwbUlsVEZzNnVJTGI4TE5YOEhobmtPMWRnQWlB?=
 =?utf-8?B?a3BzdXBRL2grTjNSazd2VHk2ak9vM05tWUMrMW0xK2pYRHRTam1zS0Z0eEV6?=
 =?utf-8?B?c2xIK0ZOMmkzcnZHSHVlTkZnUkRBYU4vcUg5WU9hZk40TXJoQmU5VnVxS05L?=
 =?utf-8?B?RmVIQStZRW1HWHFlZjM1YVNUU09JbWVLNHg0Rit1Mkp2NHpIdG05Mk9wUUUy?=
 =?utf-8?B?clFETktkYlNJcUlFb0NJSzF6emczaFZ6M3NFMWQ4Nk8reGJOWHp6aW1uVlA3?=
 =?utf-8?B?dDVQdW9vM0Y2ZjljUTVUVXNQSlhHUHZIZEUxM2x1YzQzenZZUHc0RUpzNFRv?=
 =?utf-8?B?WW55aFA1Nm9HQU9Bc3BtS3hnUHRwL0Q1TTc2YzVVTTFMQU83bG84QjRlallq?=
 =?utf-8?B?a0IzZzdSZ1NpOHZ4cFp6N29MQkcwYWxJNm04MnllV0lrelpNdGp4UVBvRk1s?=
 =?utf-8?B?ejE3N2p2MGxkQVo3S3RURjVFOXhYNXltdDFJa2o1aWYxQkZ2dHp1MTk3ZWF1?=
 =?utf-8?B?WDk4eVc4YzMvbERVWEtVeUV0eTZtUG5NQ2VrSlErNEF6NUt2dDFheXArallu?=
 =?utf-8?B?NDc1RGxvcnVmeklmMWpjTEdqeDBqZ3hPTi9SWUVJYlN6Zlc0ZC9VZG5nZDVs?=
 =?utf-8?B?MlBCMXdWK2x2cmRCdmVxUjV3Q3dpOS9YUFFHb2lRWjN3V2NZU3MxSFRQUlFn?=
 =?utf-8?B?eTNLOGdzSjdHWm0rN1V2YVRTUldJZk9WSFJwd05HK1VuY0xSU0N5Vyt6QXox?=
 =?utf-8?B?d1dJSTMzVk16WjM4VHViaEtOSlVHWXh6V2pSZHVrTlRWSk9MRnY4K3hKQWox?=
 =?utf-8?B?dW5ZQnIvOW8zZ3pzVFhxeC93bmVlV3ZIRHFBZFZCWXd5RTNQTGVkNlpMK285?=
 =?utf-8?B?NG1FQkVwa3VyNFFEcmpSWXBRQWNHWElOU1VlN1RIVG1lYm1yRlhmaldudkQ4?=
 =?utf-8?B?djl1eG9ReXN5M0Z1UXh0OUxGRGlMWDkzZ056c1IvTllQb05mSDBKS2FIdGll?=
 =?utf-8?B?Q0t0dnBNQmxDaDJ5T25RNTRHRFBxNGxNaHlUQXIzb3QxeXJCdW1WS1RTdGtO?=
 =?utf-8?B?ZjZCQnBXZUZvekNpWElUbUtXQloyQVJQZDdocFNra0tuTmtxSjZ0TFo3UTIr?=
 =?utf-8?B?b01iL2dUa0JIR3p4U09wU0g2OG94c3Z0MHA2aFFJVkY2dHpKcFFuaUlvR3cx?=
 =?utf-8?B?b3R6TDZHZExzL2p6M0s2TnVMWHNBWHZwUmthOVF2ZDlmMVBBUjBXdFlZT0E2?=
 =?utf-8?B?akZqWFBVVFVUQWltSUlnUjhUcnJkb2trZ05jWGtzRDU5V1YyUytOdzM3aTA0?=
 =?utf-8?B?TDlxQ0JtOUxUenJGV0RreWFHa3NsUTI3WS8wWGNFY1c0SHRub0FFSjBEV0gz?=
 =?utf-8?B?a0NEejZWNUJkcWR6SlE4LzZ4S3hBNkRrSkYveW4reWlzaEJGaUhSaE12dWd3?=
 =?utf-8?B?Rm5zWXU2RE5mUTJVNUVJMUM5TW5RbTNYQ3ZkM1dMa1NkS2xtNjNNbHg2dnA1?=
 =?utf-8?B?Ujk4RGdhdGRiRUZML0hTYmdFMld3cmxBT0U5REV4a3p4S251MlFLc3RkaDJJ?=
 =?utf-8?B?a1J5NEhzZUo1Y2J4TGVmaFBBRnFNVWRUaTFMWmRyZjQ3eXNzZVNjSzFZY0Yv?=
 =?utf-8?Q?8mKbhB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:51:30.4959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9feede7e-eaeb-4b8f-0377-08dd79191be5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217

From: Roger Pau Monne <roger.pau@citrix.com>

commit fc05ea89c9ab45e70cb73e70bc0b9cdd403e0ee1 upstream

In preparation for making the function static.

No functional change.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Message-ID: <20240725073116.14626-2-roger.pau@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
[ Stable backport - move the code as it exists ]
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
For stable-6.6

This patch is code movement, but it doesn't directly apply since it
predates the removal of the Xen hypercall_page.  This version moves
the code as it exists in 6.6.

Pre-req for 4c006734898a113a64a528027274a571b04af95a backport
---
 arch/x86/xen/enlighten_pvh.c | 82 ++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 60b358c2f434..89984018141c 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -26,47 +26,6 @@
 bool __ro_after_init xen_pvh;
 EXPORT_SYMBOL_GPL(xen_pvh);
 
-void __init xen_pvh_init(struct boot_params *boot_params)
-{
-	xen_pvh = 1;
-	xen_domain_type = XEN_HVM_DOMAIN;
-	xen_start_flags = pvh_start_info.flags;
-
-	if (xen_initial_domain())
-		x86_init.oem.arch_setup = xen_add_preferred_consoles;
-	x86_init.oem.banner = xen_banner;
-
-	xen_efi_init(boot_params);
-
-	if (xen_initial_domain()) {
-		struct xen_platform_op op = {
-			.cmd = XENPF_get_dom0_console,
-		};
-		int ret = HYPERVISOR_platform_op(&op);
-
-		if (ret > 0)
-			xen_init_vga(&op.u.dom0_console,
-				     min(ret * sizeof(char),
-					 sizeof(op.u.dom0_console)),
-				     &boot_params->screen_info);
-	}
-}
-
-void __init mem_map_via_hcall(struct boot_params *boot_params_p)
-{
-	struct xen_memory_map memmap;
-	int rc;
-
-	memmap.nr_entries = ARRAY_SIZE(boot_params_p->e820_table);
-	set_xen_guest_handle(memmap.buffer, boot_params_p->e820_table);
-	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
-	if (rc) {
-		xen_raw_printk("XENMEM_memory_map failed (%d)\n", rc);
-		BUG();
-	}
-	boot_params_p->e820_entries = memmap.nr_entries;
-}
-
 /*
  * Reserve e820 UNUSABLE regions to inflate the memory balloon.
  *
@@ -133,3 +92,44 @@ void __init xen_reserve_extra_memory(struct boot_params *bootp)
 		xen_add_extra_mem(PFN_UP(e->addr), pages);
 	}
 }
+
+void __init xen_pvh_init(struct boot_params *boot_params)
+{
+	xen_pvh = 1;
+	xen_domain_type = XEN_HVM_DOMAIN;
+	xen_start_flags = pvh_start_info.flags;
+
+	if (xen_initial_domain())
+		x86_init.oem.arch_setup = xen_add_preferred_consoles;
+	x86_init.oem.banner = xen_banner;
+
+	xen_efi_init(boot_params);
+
+	if (xen_initial_domain()) {
+		struct xen_platform_op op = {
+			.cmd = XENPF_get_dom0_console,
+		};
+		int ret = HYPERVISOR_platform_op(&op);
+
+		if (ret > 0)
+			xen_init_vga(&op.u.dom0_console,
+				     min(ret * sizeof(char),
+					 sizeof(op.u.dom0_console)),
+				     &boot_params->screen_info);
+	}
+}
+
+void __init mem_map_via_hcall(struct boot_params *boot_params_p)
+{
+	struct xen_memory_map memmap;
+	int rc;
+
+	memmap.nr_entries = ARRAY_SIZE(boot_params_p->e820_table);
+	set_xen_guest_handle(memmap.buffer, boot_params_p->e820_table);
+	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
+	if (rc) {
+		xen_raw_printk("XENMEM_memory_map failed (%d)\n", rc);
+		BUG();
+	}
+	boot_params_p->e820_entries = memmap.nr_entries;
+}
-- 
2.49.0


