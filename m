Return-Path: <stable+bounces-123158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BB6A5BA0B
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 08:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BCB7A903F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 07:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15D8227E8F;
	Tue, 11 Mar 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SxIEGK07"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF52236FF
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678586; cv=fail; b=GsQTGrsEoTVM1zAQvT80D+PcxheGqyewEAgSH+abe84PAnybHSqMxHPNR2SpXECFEmgvW0/wumSYotKkGI0CEu3ih3w+PF4T/nAG/BVDIwuOJ/zc7lGkaCpyg+GkS0ENhV5A+hTz+gBq+40M2qpu4WB4oPlVczO9O82wkBnDfKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678586; c=relaxed/simple;
	bh=ylgDh6V3eG7/psIVxOQwtDs1KRjDE2bxXpw7hml1X4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DA4I/lCrJDU977yIu95AvFBBBTh3eUonCz/7Hjnoeliysqz+V0Zg8+PlC3N6Ad6CLa3uhD9Pg0CN8fvuk/gtk3bCBbcDFArI8Iqyr8uY7OI+fgsG071Qh+1kF0ygpV8BwRMWYVmyv90NTatkoEvWYJtjydUdx4by9KxO1wJ7IUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SxIEGK07; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoIEM8pXSjKU9faKC68tsKzCGNEY+O5/MeOiAISo00Un4jAilx6tTyO1BULT+rdWcEcPVpZqpq+8OzYffKWbZFVfahBYqo4n1wlz/Jl/XCUzyTspwZG0p11ZeociaRisJpCdMUUU3Uu4Fp3teDpaQ63yKnXzL71f7MLWlRLOIobPWRujwLINATHPtCkhaBppvWxIEsox+CNa8yQ3AD6JG2KJicbbW/gkr4nHbTcFy9Jmisc7i1slgBeJbfzAolnuI8qVK2DDZC+YqYuQdkDG3sDcWhxUBFbbaMXlYycVsSlmlfs7XJ5GA+DD50nG0fe+1tLMezItFKTjXSib5GbvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL1M67oYn3UDUh7lxhhLEL6rc5V7EFkbBESL4u5w7Z8=;
 b=IaR4ykbpNfMFsMPgzH3VBx+I6Wn077O2M4/sDlwNSLwiQey08iT9vILUTaIdiVTnenV11UvKSs/KDpZ1kUuw5nYLXQa1NgHdz5uUlPRXhVAlnqoBNyEE3Aqp74hQCWMSGwa1++E2g7H5LvRqNnOWVCua3oYAB1N5e2SO7876zKdBNahwvzFbw2NSMSB8t+Bsy0l3K3pfUL2hOb94C25k6vlSeI4p/fMA6MgKs7el15i0mHMTggop46qebK0i/tsWffeZM1g3XtT6lYuNn9dkv7MD0V71jH65k4jOuKd3rEdNgnsyNQ11/6HQtubgNWJer4mnVDwUB+kuY9DPaEK/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL1M67oYn3UDUh7lxhhLEL6rc5V7EFkbBESL4u5w7Z8=;
 b=SxIEGK07ctF8iq+EzLAf4J2B0i9fd40CxEFwW2LuKjERqLTWJoKpAK6mntguZCik5bcanjiacEYsskwLDbuIaPBLLgxqh0mdVvUnPGQqhxWBu+vzoKNd2v1uChr+EicrkeZngKbaIl/ITBoBC19zF455U8aC4+S0Iliv6DWTlW4=
Received: from MN0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:208:52d::6)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:36:20 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::d8) by MN0PR04CA0004.outlook.office365.com
 (2603:10b6:208:52d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 07:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 07:36:20 +0000
Received: from aiemdee.l.aik.id.au (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 02:36:18 -0500
From: Alexey Kardashevskiy <aik@amd.com>
To: <stable@vger.kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, "Borislav Petkov (AMD)"
	<bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH 6.13.y] virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex
Date: Tue, 11 Mar 2025 18:36:01 +1100
Message-ID: <20250311073601.1412363-1-aik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 84fc0599-ac06-4004-100d-08dd606f6acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pp08E8SHhTExBfCB36hH3eEU0m/04VRLtMVenj6aU4EZ//sEi6dHpNNtCtkt?=
 =?us-ascii?Q?qf94nFq4jYzb6LtfbQzsT1qFoN0lYMwXHCzKCR3lD30KFN3ZWessSlVPpG3y?=
 =?us-ascii?Q?ZvwvQTZxvWTs+6dJQzghV4SNc76JusTqjS+ePH2tP/vLRGns7pohb3Wu/4lF?=
 =?us-ascii?Q?9lvIBMBU3naL4n+QUHc2hqJECqZA5140uAIwn58HpKUogNXCNxpStrJ4zJXy?=
 =?us-ascii?Q?gsoSqxmOgxeIfSed4H78CHQpMd/yJ8jf+e98fiTSXARYmGUkh3PuLr4rOUtI?=
 =?us-ascii?Q?IJrj03HoQYZdZyXZNgNWglBRFTBYYl2AHyiQLEdb/u8zUPMDC9ULslrlyoZz?=
 =?us-ascii?Q?dF3wU0G9LMuNghDkKVjBf3Mn0jeYvpk0GW5ft2PiWfCXCGcMLCaDYMxdd3TU?=
 =?us-ascii?Q?/M1y9wNtRO4zwLs/Nfk8iSRNBR5w8ef0Pz2zwtFp3OFuKiaHPIOCwV1m+GZX?=
 =?us-ascii?Q?vxpSF783V0Mz/WbMzUhqTuZ9ayGpbS0oPYDrWh68MVTeLKaSaeTt/wcLvmLx?=
 =?us-ascii?Q?FmTEhsqzw8ydO0YRpuyNDrUWCFSGM4PFCP1te6p27tud6ygMTdmXsWtgsrlA?=
 =?us-ascii?Q?klIEUihcRWFM99+UDU8QkfaxqkVtG4sP6z3TLlrGOn/mNLeE0zAH4/U2VxpU?=
 =?us-ascii?Q?D3Fnu3RPx6e9TqbYlO6BzkEO+y2I0wY6/84y/KVSLgCmK8Q3RXDha7LLnac2?=
 =?us-ascii?Q?WkZthM94vh6sZ16E9nDp8UIOrZv3dArUXPAF7i7muWlJniznnrZO/IyzYDTT?=
 =?us-ascii?Q?licY4Rs2QPAC0lfjXn2H6a5H0UWlE4Hapra8SQH0V+lHt8iq7anX5JPGTv3f?=
 =?us-ascii?Q?LiyW106NUCq9qYaOkUCgK7UpyhMyUZSstZ4GBp4UuoDBUEDnKgJVbVX3aFSv?=
 =?us-ascii?Q?a1o1FsmrzjpnM6uiYK9faF4cMe+yE/qBxgW6bCh/uSKrSa2OWn5sF2k37wLh?=
 =?us-ascii?Q?5VO9JD16sY41VKCoj5DEp9tEnrVTs/vX//9Arq8Kgkq5uUAqR42iFvhOuKie?=
 =?us-ascii?Q?dWOfvgbXBMY2W3V6ms2INKHF/9zg00wa283xzuhnXBeg71wR4BE0xLRaKkB8?=
 =?us-ascii?Q?iUjHW/wmWIMTyPOQ2cBj6buNQPtOeq2iNS3NUe90Z4n/rgPjPa0JH2Ovs7uQ?=
 =?us-ascii?Q?zFVWHwyVbioxOHR0wr7V2wygXXKqU3+1iqmOVBuMiNbCtWeUEHJvPN5O2qi2?=
 =?us-ascii?Q?lGnBRZA1rlNAJZBVMK5zAlDABjk333cWqoXaaVlDGPG34SedgjaS9AaBTZcJ?=
 =?us-ascii?Q?/gwJNfJdIh6kajtTBQ6eXujh2u60pDEAdmI08VmnoL36DeG2Ncup/dqITTJf?=
 =?us-ascii?Q?OOFEs+hRCjYes6MGd0DVCXhg8DcHDT89zBtH2Gt03+AMHasY+OXNVuSQSnth?=
 =?us-ascii?Q?kyliS4Na0Nw0G0QJ0CFkDaScwW98YJHMOBC0ySoEKitdHX/vmNH0OGsK7STA?=
 =?us-ascii?Q?jc7HdGzXt60IkcNYvpdbPFCJkHigNqBuVekcPeaQTHL2ZdHXQozJ+vz1ALiE?=
 =?us-ascii?Q?4+nJvcCbibZf/3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 07:36:20.5601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fc0599-ac06-4004-100d-08dd606f6acf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095

Compared to the SNP Guest Request, the "Extended" version adds data pages for
receiving certificates. If not enough pages provided, the HV can report to the
VM how much is needed so the VM can reallocate and repeat.

Commit

  ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")

moved handling of the allocated/desired pages number out of scope of said
mutex and create a possibility for a race (multiple instances trying to
trigger Extended request in a VM) as there is just one instance of
snp_msg_desc per /dev/sev-guest and no locking other than snp_cmd_mutex.

Fix the issue by moving the data blob/size and the GHCB input struct
(snp_req_data) into snp_guest_req which is allocated on stack now and accessed
by the GHCB caller under that mutex.

Stop allocating SEV_FW_BLOB_MAX_SIZE in snp_msg_alloc() as only one of four
callers needs it. Free the received blob in get_ext_report() right after it is
copied to the userspace. Possible future users of snp_send_guest_request() are
likely to have different ideas about the buffer size anyways.

Fixes: ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Cc: stable@vger.kernel.org # 6.13
Link: https://lore.kernel.org/r/20250307013700.437505-3-aik@amd.com
(cherry picked from commit 3e385c0d6ce88ac9916dcf84267bd5855d830748)
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


