Return-Path: <stable+bounces-121336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F2A55D2F
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 02:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B400D3B4186
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 01:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B271624F9;
	Fri,  7 Mar 2025 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xj5zEFVd"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7A1474DA;
	Fri,  7 Mar 2025 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311497; cv=fail; b=cmMN7Dvlvyea6xd/dzH2Ho+K+buxOhDtMZ1pHw3RtTwt1WaGfR5MLaeXwQD2xK7B+HZC+ltdQec+oFYXuM3nBYAHmbNihr6WrTZlzsxpQpf3kFlw8jEm9MYbyAiG1BLxLL9zJjd3MI+TW/y4AoZU53F+JfCUcvXE53A18NoG1Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311497; c=relaxed/simple;
	bh=THeFKvp3j0L6RC4JPhbny5m6BTqf8iMceanexdwcbCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2r7JCgfCHfNZgIJid16ihHgC5knrjrra2bCysEREnGAArp2ox5CE2Kb+KEty+rrEtdR862t64pX7lkk3+bkMLTz8AWmL947PUPVEI6JtPL8JrOEuPCocGo7f322gVWXDIcXYgC7UMBeYMd/6zCyZ6iVX901TBhOnlYZ+4XF9oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xj5zEFVd; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NU/B/M2npBelAnuWITU3uE/ngtfD3BIgoJCAB+rJTffDhhpR/Wj4r+3LZbvXHVFvFOuD6UfuSxfCClshIgD4JX1NrPGFVK49BW5WbxyaKWS6s+naNaNyZHYdSRzYJt5bQDRRLxDoqWE8MzgzG2J9nfxwtYl+jf3XsvVTbXhls+NeglIWwFIw8UvQsqyeHdzGCIWANk0AikP9cIGi8JwkC1qzwYQDQ4s0YzG6ml39mzR1Z6roj7FU0Jk7ovxChBbUqxLdtbp5w1g6pen882bMT1J2hJenhcotn32y+PEGGtrWqrqbFVHDo24KjFoL4QdUgK8UIUCPUguiUMXYRV5KGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32janF29oiGx1bXQmQwhwfMV5OrSN1teXucjdVaVFkQ=;
 b=TB+EzkphtsEbEmqgLGf2+wShBiP5gpPwsuMm+RVqgZPk/v1aCHFxX18vPRhOez5aAFS9nvsS2WzpEDmk9gifuOGGC8Jn084zcZiSZnNFY2IxxahljHaSljN9LF4dZmr2d0/OTz0gpTK6p2nU8VzPYANa6kXIYxqX8WIBXX9yhui954nNSgy+MtLkMf7w1I8i1+F6sDIqoJPGUQtHt2fvMR9voLXuvJekDYLWhWqjAnM4rLsSuTYczzDlolx6eA9ZcAZ7HKT6jFHKHYb8eVQ8iV/FZ9s0q1hJXwz4buYoG592jcKTTVRoJn5LspM5WDwm93MrsI10grH0cOIwODPhuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32janF29oiGx1bXQmQwhwfMV5OrSN1teXucjdVaVFkQ=;
 b=Xj5zEFVdkKh235Qk/FP/GZQQrCY5LXyBkUIK3CrtsTANFHsKzMNIK7LfMO932pxN/m/bR3IuidKfWVQ5Emtvth6YE6FE7Ntr6k1KrYE00p/Q+OyC6y5dPxbW+QqqcMCj3uRR1J7YI2dXEjoiC6MCB91Qj+9bfnGswyPUbJSHZdU=
Received: from MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43) by
 DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 01:38:07 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::50) by MW2PR16CA0030.outlook.office365.com
 (2603:10b6:907::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Fri,
 7 Mar 2025 01:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 01:38:06 +0000
Received: from aiemdee.l.aik.id.au (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 19:38:00 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Ard Biesheuvel
	<ardb@kernel.org>, Pavan Kumar Paluri <papaluri@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth
	<michael.roth@amd.com>, Kevin Loughlin <kevinloughlin@google.com>,
	"Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>, Liam Merwick
	<liam.merwick@oracle.com>, "Alexey Kardashevskiy" <aik@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex
Date: Fri, 7 Mar 2025 12:37:00 +1100
Message-ID: <20250307013700.437505-3-aik@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307013700.437505-1-aik@amd.com>
References: <20250307013700.437505-1-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: d12e4289-2a72-42ad-9d33-08dd5d18b606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q3emFl5b20olSe9h0yhO4MQ3Oal1Ygu0kSBfEoRS6sHfkzjfn23C4ATp99m9?=
 =?us-ascii?Q?qS0RbTG3GfKroI0436O+HqZmRhEpcp5ya+P62oXUfVodMYm23gCEtIxhZGYk?=
 =?us-ascii?Q?3lIBjHDgHuSQ/azmT3WiKnoEZlacrtNs8Q/nguqBYvAsQzFrOAHzQVjTbuL0?=
 =?us-ascii?Q?FlOJxNXUGEuKHQwnnT/eAwT5X3GXR5mvtB7qbx0fQWoZF2Gwe+nYHiLGX7Jg?=
 =?us-ascii?Q?08NH2gpMTHxz9U1fPcKwzUtcZnNV4kwe1xJdPGYgqE/kVxqAX7zuIPWGFNlR?=
 =?us-ascii?Q?Tb7LburQ+0JAfOMTMlKcPzQjDdfNFg3PzirONQA3HmbLxgq/eRmCBXqWtgnr?=
 =?us-ascii?Q?eIRoTWNp67UpgCEmoaire/Qn1qpuTJrQPYcRYdCo9J58IQ8J5JIaPa7XhlOO?=
 =?us-ascii?Q?Llppimqd7snMd5fta3AEKlm8hzFGXvduxPdmjEIBWIMbwCO5KgesF8x/2EC+?=
 =?us-ascii?Q?Q0RdtinUcuymFaxaU1ryDFTTowq89N8pYN7zuQY46C0nw8fuhcIGXt2OQ/YM?=
 =?us-ascii?Q?wQyTnV1oU849QZCkniKMzsAx7ymDGxP1V4o49ErrnKn+EagMPirlOlBdN/jl?=
 =?us-ascii?Q?riyv3PW1uAGydvItmHKCO+EGGwQEDXRuzPbojDdWBZBYS0m5+vDCUCdS6IsL?=
 =?us-ascii?Q?7dF7GBvelVy3RMpdsKkJmwJWf1PUwu4/Ig649kcNO33ZxSCuXlVarvLDqInt?=
 =?us-ascii?Q?vM3v2c+8JXql2oJFj0upjvrvBQt8dlg39LVL6KZHfPON/uSKe+SgR9RFsSws?=
 =?us-ascii?Q?yq/wQA8SC3V+OnDvcq2KDXBbUV9lJ95GGrKo86uTvvKPaS1Bt89NscPxkmbx?=
 =?us-ascii?Q?UDCwGNx/0y0W+yAJXZiz7gon8kCCpzQIn545OMdESxUcLsF8iXYfBrz+avY3?=
 =?us-ascii?Q?qeSkIT+7LRCUkuL1KXJXMDnJedHcODM22mcBmBoozUPL+3Y9zE9cW3wjIPyK?=
 =?us-ascii?Q?YZ7PCuVJucCdtQaQoIwE9DHgLVpqvwnVHecLW0k2HtjnuY/msCZrUuaeyPHG?=
 =?us-ascii?Q?efnCyUTC/GMVec/WGS9ebH0BbapReTyBqMXlYO4fveK0Y3ZoprOQYLiEro5W?=
 =?us-ascii?Q?rARGPPah5iQQFxfPeuCYSC8RfSS+5iMPKXSw80BmxRmQR708jh1lJ4YkUxJl?=
 =?us-ascii?Q?UkaIjYCDeLpof03yllEUWrD6OO4w33cpGXiuuQ+ZTgm6wpzxg98SHD2Aq30p?=
 =?us-ascii?Q?BJ3SkmSqkDb2uwVk4ULiLS7jeO1I77A3PkDy52OXambwv+G6nlx8AjJyqUsQ?=
 =?us-ascii?Q?k4hVkXXJaO0MZ36jmQ5vohKLU4D9un3oSR3rBlMaZ4XLZZIDSXMzHH6wGfTr?=
 =?us-ascii?Q?eYCdmXHYsjkqvvPZuo9aev1OAAk2IzDSo8KFiloDJc0JUUgZYKQvnFu3bJIw?=
 =?us-ascii?Q?eEp/+QWEB3NG5oTPa2TIKG7LJ3TmgrtqoJlAPwTHAPRuD8ov14oz7psD+Vv0?=
 =?us-ascii?Q?Fv2rkE7B0CGniuyK54rTik6mUBZA/axUmNgy65onhq3rG2tLs4gH0pS7r5aY?=
 =?us-ascii?Q?AOP1N8pEFA1kpzs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 01:38:06.9400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12e4289-2a72-42ad-9d33-08dd5d18b606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451

Compared to the SNP Guest Request, the "Extended" version adds data pages
for receiving certificates. If not enough pages provided, the HV can
report to the VM how much is needed so the VM can reallocate and repeat.

Commit ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command
mutex") moved handling of the allocated/desired pages number out of scope
of said mutex and create a possibility for a race (multiple instances
trying to trigger Extended request in a VM) as there is just one instance
of snp_msg_desc per /dev/sev-guest and no locking other than snp_cmd_mutex.

Fix the issue by moving the data blob/size and the GHCB input struct
(snp_req_data) into snp_guest_req which is allocated on stack now
and accessed by the GHCB caller under that mutex.

Stop allocating SEV_FW_BLOB_MAX_SIZE in snp_msg_alloc() as only one of
four callers needs it. Free the received blob in get_ext_report() right
after it is copied to the userspace. Possible future users of
snp_send_guest_request() are likely to have different ideas about
the buffer size anyways.

Fixes: ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
Cc: stable@vger.kernel.org
Cc: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 arch/x86/include/asm/sev.h              |  6 ++--
 arch/x86/coco/sev/core.c                | 23 +++++--------
 drivers/virt/coco/sev-guest/sev-guest.c | 34 ++++++++++++++++----
 3 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 1581246491b5..ba7999f66abe 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -203,6 +203,9 @@ struct snp_guest_req {
 	unsigned int vmpck_id;
 	u8 msg_version;
 	u8 msg_type;
+
+	struct snp_req_data input;
+	void *certs_data;
 };
 
 /*
@@ -263,9 +266,6 @@ struct snp_msg_desc {
 	struct snp_guest_msg secret_request, secret_response;
 
 	struct snp_secrets_page *secrets;
-	struct snp_req_data input;
-
-	void *certs_data;
 
 	struct aesgcm_ctx *ctx;
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492efc5d94..d02eea5e3d50 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2853,19 +2853,8 @@ struct snp_msg_desc *snp_msg_alloc(void)
 	if (!mdesc->response)
 		goto e_free_request;
 
-	mdesc->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
-	if (!mdesc->certs_data)
-		goto e_free_response;
-
-	/* initial the input address for guest request */
-	mdesc->input.req_gpa = __pa(mdesc->request);
-	mdesc->input.resp_gpa = __pa(mdesc->response);
-	mdesc->input.data_gpa = __pa(mdesc->certs_data);
-
 	return mdesc;
 
-e_free_response:
-	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
 e_free_request:
 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
 e_unmap:
@@ -2885,7 +2874,6 @@ void snp_msg_free(struct snp_msg_desc *mdesc)
 	kfree(mdesc->ctx);
 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
-	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	iounmap((__force void __iomem *)mdesc->secrets);
 
 	memset(mdesc, 0, sizeof(*mdesc));
@@ -3054,7 +3042,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(req, &mdesc->input, rio);
+	rc = snp_issue_guest_request(req, &req->input, rio);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -3064,7 +3052,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 		 * order to increment the sequence number and thus avoid
 		 * IV reuse.
 		 */
-		override_npages = mdesc->input.data_npages;
+		override_npages = req->input.data_npages;
 		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
@@ -3120,7 +3108,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 	}
 
 	if (override_npages)
-		mdesc->input.data_npages = override_npages;
+		req->input.data_npages = override_npages;
 
 	return rc;
 }
@@ -3158,6 +3146,11 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 	 */
 	memcpy(mdesc->request, &mdesc->secret_request, sizeof(mdesc->secret_request));
 
+	/* initial the input address for guest request */
+	req->input.req_gpa = __pa(mdesc->request);
+	req->input.resp_gpa = __pa(mdesc->response);
+	req->input.data_gpa = req->certs_data ? __pa(req->certs_data) : 0;
+
 	rc = __handle_guest_request(mdesc, req, rio);
 	if (rc) {
 		if (rc == -EIO &&
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4699fdc9ed44..cf3fb61f4d5b 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -177,6 +177,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	struct snp_guest_req req = {};
 	int ret, npages = 0, resp_len;
 	sockptr_t certs_address;
+	struct page *page;
 
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
@@ -210,8 +211,20 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	 * the host. If host does not supply any certs in it, then copy
 	 * zeros to indicate that certificate data was not provided.
 	 */
-	memset(mdesc->certs_data, 0, report_req->certs_len);
 	npages = report_req->certs_len >> PAGE_SHIFT;
+	page = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
+			   get_order(report_req->certs_len));
+	if (!page)
+		return -ENOMEM;
+
+	req.certs_data = page_address(page);
+	ret = set_memory_decrypted((unsigned long)req.certs_data, npages);
+	if (ret) {
+		pr_err("failed to mark page shared, ret=%d\n", ret);
+		__free_pages(page, get_order(report_req->certs_len));
+		return -EFAULT;
+	}
+
 cmd:
 	/*
 	 * The intermediate response buffer is used while decrypting the
@@ -220,10 +233,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	 */
 	resp_len = sizeof(report_resp->data) + mdesc->ctx->authsize;
 	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
-	if (!report_resp)
-		return -ENOMEM;
+	if (!report_resp) {
+		ret = -ENOMEM;
+		goto e_free_data;
+	}
 
-	mdesc->input.data_npages = npages;
+	req.input.data_npages = npages;
 
 	req.msg_version = arg->msg_version;
 	req.msg_type = SNP_MSG_REPORT_REQ;
@@ -238,7 +253,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		report_req->certs_len = mdesc->input.data_npages << PAGE_SHIFT;
+		report_req->certs_len = req.input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_sockptr(io->req_data, report_req, sizeof(*report_req)))
 			ret = -EFAULT;
@@ -247,7 +262,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (ret)
 		goto e_free;
 
-	if (npages && copy_to_sockptr(certs_address, mdesc->certs_data, report_req->certs_len)) {
+	if (npages && copy_to_sockptr(certs_address, req.certs_data, report_req->certs_len)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
@@ -257,6 +272,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
 e_free:
 	kfree(report_resp);
+e_free_data:
+	if (npages) {
+		if (set_memory_encrypted((unsigned long)req.certs_data, npages))
+			WARN_ONCE(ret, "failed to restore encryption mask (leak it)\n");
+		else
+			__free_pages(page, get_order(report_req->certs_len));
+	}
 	return ret;
 }
 
-- 
2.47.1


