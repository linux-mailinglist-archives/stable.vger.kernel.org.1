Return-Path: <stable+bounces-124941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CB9A691FE
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A531B83D93
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D59D1C1F0F;
	Wed, 19 Mar 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CGz4Emnc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD618C322;
	Wed, 19 Mar 2025 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394841; cv=none; b=ZqG1R5nVNAW/lZDkk+lGs/sqKki8J/ImHGgpHHmqLH+Yi+bb206LyQLao3QRhBtH8HiXCyZgmSOp05skM9rjslBQ0JaLD5B6cjxkDkxilWO10Pu/R4FUp/laZaHoF8Q7X4ENrRULMZUF02rnbD6JS6qOhVp92gsrMV17ZeRj1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394841; c=relaxed/simple;
	bh=5qai4ggVuxTeQ4pPyvuepTpHIPuZ03v8RVFiaCNzInk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WboBNvnnSNcEuFalwbFzSpcyQFWnd1YlQba7sDCKhMw+4TC1K0k8wgAspmJyNRMgYgdD0u53E5Y3uAxlDFHx2FkOEUr1vANzPOcL9wbFuQCbN3bBVv8j/NbLOi+D/+02ORmKtM4AMM6BIapUHPnj47aOWougZHbXJyoLEwL4jKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CGz4Emnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8799FC4CEE8;
	Wed, 19 Mar 2025 14:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394840;
	bh=5qai4ggVuxTeQ4pPyvuepTpHIPuZ03v8RVFiaCNzInk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGz4EmnceS2LCSqxPw4tR4r470mMhKyONSo3KL2g53EH3WpdbAQf45f68rRmPyvU7
	 6k4N+POTM3wmlaVOj4FwiVrk4vI4gKC34pVuGY20iHEtovdh77zJ1R0MUAAwDhrJ54
	 7MxTSE+x134vECc+8g0uNZqTqHB/bHrvToWK/45k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Kardashevskiy <aik@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH 6.13 004/241] virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex
Date: Wed, 19 Mar 2025 07:27:54 -0700
Message-ID: <20250319143027.805085158@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kardashevskiy <aik@amd.com>

commit 3e385c0d6ce88ac9916dcf84267bd5855d830748 upstream.

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
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250307013700.437505-3-aik@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

---
 arch/x86/include/asm/sev.h              |    6 +--
 drivers/virt/coco/sev-guest/sev-guest.c |   63 +++++++++++++++++++-------------
 2 files changed, 42 insertions(+), 27 deletions(-)

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
 
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -249,7 +249,7 @@ retry_request:
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(req, &mdesc->input, rio);
+	rc = snp_issue_guest_request(req, &req->input, rio);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -259,7 +259,7 @@ retry_request:
 		 * order to increment the sequence number and thus avoid
 		 * IV reuse.
 		 */
-		override_npages = mdesc->input.data_npages;
+		override_npages = req->input.data_npages;
 		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
@@ -315,7 +315,7 @@ retry_request:
 	}
 
 	if (override_npages)
-		mdesc->input.data_npages = override_npages;
+		req->input.data_npages = override_npages;
 
 	return rc;
 }
@@ -354,6 +354,11 @@ static int snp_send_guest_request(struct
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
@@ -495,6 +500,7 @@ static int get_ext_report(struct snp_gue
 	struct snp_guest_req req = {};
 	int ret, npages = 0, resp_len;
 	sockptr_t certs_address;
+	struct page *page;
 
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
@@ -528,8 +534,20 @@ static int get_ext_report(struct snp_gue
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
@@ -538,10 +556,12 @@ cmd:
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
@@ -556,7 +576,7 @@ cmd:
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		report_req->certs_len = mdesc->input.data_npages << PAGE_SHIFT;
+		report_req->certs_len = req.input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_sockptr(io->req_data, report_req, sizeof(*report_req)))
 			ret = -EFAULT;
@@ -565,7 +585,7 @@ cmd:
 	if (ret)
 		goto e_free;
 
-	if (npages && copy_to_sockptr(certs_address, mdesc->certs_data, report_req->certs_len)) {
+	if (npages && copy_to_sockptr(certs_address, req.certs_data, report_req->certs_len)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
@@ -575,6 +595,13 @@ cmd:
 
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
 
@@ -1048,35 +1075,26 @@ static int __init sev_guest_probe(struct
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
@@ -1088,8 +1106,6 @@ static int __init sev_guest_probe(struct
 
 e_free_ctx:
 	kfree(mdesc->ctx);
-e_free_cert_data:
-	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
 e_free_response:
 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
 e_free_request:
@@ -1104,7 +1120,6 @@ static void __exit sev_guest_remove(stru
 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 
-	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
 	kfree(mdesc->ctx);



