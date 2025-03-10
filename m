Return-Path: <stable+bounces-121682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449FA59093
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B4D3A775C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6714B092;
	Mon, 10 Mar 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hcqz7afB"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3729A2
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600850; cv=fail; b=C28ISoEVmT862Lg32X+pJLhbJ6xbMZ0JfuAUbHGYhVy4qHvMmHfo2uY7q14Lt6zSY9mo/FIRa27zmCaxxMXz2eFDekJunLlTluACjYYz4eUN06stR1/jyrM9HQqUBfbO+KnkQ/0TB38A6+0zPuJyoFovd4aT+RI5xSc0L2i8IXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600850; c=relaxed/simple;
	bh=lPOVzjds5+42u4PZGAG+T/xMQy+MTO/8g4M1bZOhefg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZiKGqeRTVuhpZOu5EihWTZ4nl3YB4QADjN4OWrJ/X9A/dh/ryMZfIsL3jr12HqSgaL88ZFqhW7EzeIRKLaIKwqY4Dw3+O9vS+bIDmL4Y4umbm2DpIg+J2xEJasH1sUQe9C/B6BwGc2J3fvWPqejwqnl2Le7f1RVhp9njOiuIFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hcqz7afB; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDW9jwl7BfGI8Ypv7SdGFubA0d6wp56dgo6DSHRkREbIquahYNIMyD9mb1/2ioXKz9CzhdM7p+NdYhxR2JgZzEDTwOYmoY1llKEWlccdI2ZVTiNggw6von2BsycBZwDyu6eRvEQiwliuVM+CMwct80wZqxbHp2dBh2Oi804mOIkorZljCRWSjE+31m3YY2JlSXLbf3zP2jcyS4Wdl9sIjMbTuuZOzUOKpLjI2AJocLMTx12eR0PVAEVzxIxvanUzhzHizCGGiYvaDmYCFmvfiFXsk8Z8Wyys4UuobDiaNpE/xih9YASVrqVs9W3GHeczAxmYYS0BnHd/+kA8WYo1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fYp7M19MLhFZXchkZs8w4TZsPZ2VK5/v2PJcLXrCZ4=;
 b=IGinCqrxmXwOMRqABBfT2r5tqNoMrDf19lNDSKWsSynrTHcpg8xVzWusj0sWfmBaWrfMy/Jo2stM5ElO/hkSIsqkhpzaMThCuuJJzas8ae9woqNm/N2gEVAznMH6w7+Ij+mPris3rKMnvmGb323NIIOGU7N1yCkCiKxesgGLsVFaPCzmXK0WVwKrXQcc203RGvseZDFvGauWUln7jUTevFQ/cd18g6HSmrwio0wOW7A0Iq3mhVAVlndWqwtAS0CHCuhjrJto//E6HCjqK7M3jwzGIMvk1iWOCoXlPDwQoPeVeEC0Aol3dCmU1WpBAKLssu0VvSfqdDu7BjwyHZfnWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fYp7M19MLhFZXchkZs8w4TZsPZ2VK5/v2PJcLXrCZ4=;
 b=Hcqz7afBN/hsgnDq2M+/GMzmFhQuHaZPE+JyTNgIwuToi5jzIT7nnLrcjc28SNOuGk5AXaR/LTJwfiob+UDASgSK00GXlrYPI/8WEccWProwk+AtXWIxtHIYXGhllHW/uxZkf0NwCJIjWKruP4+9Vuvbe1S3tGl8Eqen0qk8St8=
Received: from LV3P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::22)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:00:43 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::9b) by LV3P220CA0003.outlook.office365.com
 (2603:10b6:408:234::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 10:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 10:00:43 +0000
Received: from aiemdee.l.aik.id.au (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 05:00:37 -0500
From: Alexey Kardashevskiy <aik@amd.com>
To: <stable@vger.kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH 6.13.y] virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex
Date: Mon, 10 Mar 2025 21:00:27 +1100
Message-ID: <20250310100027.1228858-1-aik@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025030957-magnetism-lustily-55d9@gregkh>
References: <2025030957-magnetism-lustily-55d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: d58ab716-7514-4dc5-594d-08dd5fba6bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zDcf1OCbKA06/5rcI1uTM5GiLRlIZUXF9z0QW7rr35aCOJYYK41UrR+NdKln?=
 =?us-ascii?Q?2QqzWOg3CJ+NvN2MeDSl/kWebCK9Qm+/niLvV56OSATCa+2LjPQO+pVeq4v+?=
 =?us-ascii?Q?1kMoZjYNlUXM5I6SeYygR4U9GXoxkgiZLVoLDdX4gGCtSkmU5qqsAwXxJwt+?=
 =?us-ascii?Q?HfWAou9fWo8VQoqUJaqkXn4zhrGSr1jhUVxwigPyyR7UflxVKjwmPIeWpmUa?=
 =?us-ascii?Q?gJPdRxw3AZCsz8L3PGeRvQzNPPUe0ouPYJLTTOfprfnqYjOS0TnWYc4leuCV?=
 =?us-ascii?Q?mxtydvCV7sSrABgJ09TYyo7wVC/Nyz1kF0M0PWi8QEbUxPEA1NUki4CCR/od?=
 =?us-ascii?Q?RvuL4RMWkAciNYtgUZEukygXb/UuABaxS0t65c5qhZ1+uzS2MrXCXO0gm6Mm?=
 =?us-ascii?Q?r9KeAmP+8I+ibGyCbr+Reejh8uqX4DeCr7bYHXBeAWikeFdY7ApDiURmGD5z?=
 =?us-ascii?Q?XjHDgpyfi/vPPIXbQArTQ9xPXXGCGdlWVWWWOp8YjLtGljRYsh0vsGA/fuJb?=
 =?us-ascii?Q?h0k7gx+2yJwxH42QtiiNB6uwI3mh3fO+NW12iWXqy/KRO6oWyGK+WfPgUKGj?=
 =?us-ascii?Q?R580guIbQQsKwjrHtU8SysyGHRL/mMtCEcQj0DlZo1ijRdYp0YTLr5bTW7Qg?=
 =?us-ascii?Q?/yewVzYrj2xuNAQ2RCqLOkY0Iok467CnQ7V71k5jq8V5PJCE7qWYcUYy0VQo?=
 =?us-ascii?Q?7VWBMhLbRSsyGDuacA4i4hF5mafmbQCjvLQwY1CO+faGVt41F9LcFys2DUFq?=
 =?us-ascii?Q?4jG0Z3RbJmZbRXjfVet2tBO9SmBC+/WoGeA3OL+QDEvlSMkjpqgAUJjEww70?=
 =?us-ascii?Q?V5YzqgEXe4n0YLWV6WAGvjKovLz2dRLwgIRP4LTuPcDaQc6Cx8ZO4zBG3WT4?=
 =?us-ascii?Q?z0jYIKze8B+paRwFM4kn4Z3jNF1weqIVKlEMgKCZ7skSkeRWTmJhSO0iI+Bw?=
 =?us-ascii?Q?zvjaKXVGUhOOAjLPVqTEiUF4UHzkeN84Art7NSqUVYrrcANHTM3OtS/6MYr5?=
 =?us-ascii?Q?xbyFFGnIVeEHq6gWTZCllyoaYj3nMA03t2+B2aQVRsTQ7FPt/b1BCBrGfodl?=
 =?us-ascii?Q?Ys3v7cN/UhcCBtub45kHs++oSYtdDsrVRHBClUjDXr5ICYHhCQ1VRE9NqaXK?=
 =?us-ascii?Q?ZU3nJlSEs56ZyjRG5TO/Fz45IldBAA2UriWhwZjrUFoR6WELIk/Owu0DMzPl?=
 =?us-ascii?Q?U9cf6s3wEqgRb4btYapPwxvkjQ9/bZW+jV5IKfGuJ6TIm7PsQg3TwUjBF+Nh?=
 =?us-ascii?Q?JCGgeM8EyCMJ33yQNVheciDccMpETwzwOSkK1LystOqaFPJwyd/zaVLuWlyI?=
 =?us-ascii?Q?821Vsr9qrQeR8zEQZ5fLWKaWZyZ7xbvpIjyu4Vtlw9aoS8NcYa81LVPsp03I?=
 =?us-ascii?Q?gieQJ+QGmKuFOp0pd1fuplK3apN0FS2fGqzJgDag6r8E7XC4E8X8bMVvX677?=
 =?us-ascii?Q?s1fSC/JTnvJJ/IK4RIXXMzxWMoLFP5T7ycRAnao4BxnfzJhdVyMc+UxLVq/S?=
 =?us-ascii?Q?XqG7swysee72Spc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:00:43.2792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d58ab716-7514-4dc5-594d-08dd5fba6bc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367

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
Cc: stable@vger.kernel.org # 6.13
Cc: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---
 arch/x86/include/asm/sev.h              |  6 +--
 drivers/virt/coco/sev-guest/sev-guest.c | 63 +++++++++++++++----------
 2 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 91f08af31078..82d9250aac34 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -185,6 +185,9 @@ struct snp_guest_req {
 	unsigned int vmpck_id;
 	u8 msg_version;
 	u8 msg_type;
+
+	struct snp_req_data input;
+	void *certs_data;
 };
 
 /*
@@ -245,9 +248,6 @@ struct snp_msg_desc {
 	struct snp_guest_msg secret_request, secret_response;
 
 	struct snp_secrets_page *secrets;
-	struct snp_req_data input;
-
-	void *certs_data;
 
 	struct aesgcm_ctx *ctx;
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index af64e6191f74..480159606434 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -249,7 +249,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(req, &mdesc->input, rio);
+	rc = snp_issue_guest_request(req, &req->input, rio);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -259,7 +259,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 		 * order to increment the sequence number and thus avoid
 		 * IV reuse.
 		 */
-		override_npages = mdesc->input.data_npages;
+		override_npages = req->input.data_npages;
 		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
@@ -315,7 +315,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 	}
 
 	if (override_npages)
-		mdesc->input.data_npages = override_npages;
+		req->input.data_npages = override_npages;
 
 	return rc;
 }
@@ -354,6 +354,11 @@ static int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 	memcpy(mdesc->request, &mdesc->secret_request,
 	       sizeof(mdesc->secret_request));
 
+	/* initial the input address for guest request */
+	req->input.req_gpa = __pa(mdesc->request);
+	req->input.resp_gpa = __pa(mdesc->response);
+	req->input.data_gpa = req->certs_data ? __pa(req->certs_data) : 0;
+
 	rc = __handle_guest_request(mdesc, req, rio);
 	if (rc) {
 		if (rc == -EIO &&
@@ -495,6 +500,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	struct snp_guest_req req = {};
 	int ret, npages = 0, resp_len;
 	sockptr_t certs_address;
+	struct page *page;
 
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
@@ -528,8 +534,20 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
@@ -538,10 +556,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
@@ -556,7 +576,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		report_req->certs_len = mdesc->input.data_npages << PAGE_SHIFT;
+		report_req->certs_len = req.input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_sockptr(io->req_data, report_req, sizeof(*report_req)))
 			ret = -EFAULT;
@@ -565,7 +585,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (ret)
 		goto e_free;
 
-	if (npages && copy_to_sockptr(certs_address, mdesc->certs_data, report_req->certs_len)) {
+	if (npages && copy_to_sockptr(certs_address, req.certs_data, report_req->certs_len)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
@@ -575,6 +595,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
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
 
@@ -1048,35 +1075,26 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (!mdesc->response)
 		goto e_free_request;
 
-	mdesc->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
-	if (!mdesc->certs_data)
-		goto e_free_response;
-
 	ret = -EIO;
 	mdesc->ctx = snp_init_crypto(mdesc->vmpck, VMPCK_KEY_LEN);
 	if (!mdesc->ctx)
-		goto e_free_cert_data;
+		goto e_free_response;
 
 	misc = &snp_dev->misc;
 	misc->minor = MISC_DYNAMIC_MINOR;
 	misc->name = DEVICE_NAME;
 	misc->fops = &snp_guest_fops;
 
-	/* Initialize the input addresses for guest request */
-	mdesc->input.req_gpa = __pa(mdesc->request);
-	mdesc->input.resp_gpa = __pa(mdesc->response);
-	mdesc->input.data_gpa = __pa(mdesc->certs_data);
-
 	/* Set the privlevel_floor attribute based on the vmpck_id */
 	sev_tsm_ops.privlevel_floor = vmpck_id;
 
 	ret = tsm_register(&sev_tsm_ops, snp_dev);
 	if (ret)
-		goto e_free_cert_data;
+		goto e_free_response;
 
 	ret = devm_add_action_or_reset(&pdev->dev, unregister_sev_tsm, NULL);
 	if (ret)
-		goto e_free_cert_data;
+		goto e_free_response;
 
 	ret =  misc_register(misc);
 	if (ret)
@@ -1088,8 +1106,6 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 
 e_free_ctx:
 	kfree(mdesc->ctx);
-e_free_cert_data:
-	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
 e_free_response:
 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
 e_free_request:
@@ -1104,7 +1120,6 @@ static void __exit sev_guest_remove(struct platform_device *pdev)
 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 
-	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
 	kfree(mdesc->ctx);
-- 
2.47.1


