Return-Path: <stable+bounces-121438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DA8A5707C
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 19:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DBC189C672
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C92417E4;
	Fri,  7 Mar 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TqxdwOBf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQaePyWt"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571123F411;
	Fri,  7 Mar 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371953; cv=none; b=HtlUB6vjs6K5M7wngVB0kxjcukjrE72xkseT0Yy//gt9B9b6wjp8TaN29RIfPLhymj3IGbV2x2yT07F8DWF7yMNfLOHwF3HuRJHTfV1DpoGD7aZ1mNN39r1x6VK3r+uX01F3R/YAqKQBBBssVYGVkjIC2AKvF+vVevdZgFnapBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371953; c=relaxed/simple;
	bh=6+uvT56j5CrXhq5A9atDqahn5SDHgYAbOnqBawc8lDI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OiecRRmIcIiiuz+b8XdjS36JLZT+RvjJUQUNKz2Pv7fiFDWtm0/DAjBa8LUnyuu+VggOLdzMLQ2BchT82eZDe4JqczDJ0gJSPFl8mRF5SM1qtPbgZ4Fj8QS++AUXob5KcisLEYjbqh6ajl30wA5Yk31wpdfXltisuJ1KmPX4U1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TqxdwOBf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQaePyWt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Mar 2025 18:25:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741371948;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyRUoZ/VYkRkOOmhD+6bodu6hSbBK4ZHB5ncQD57VD0=;
	b=TqxdwOBfq0FliLvzPFUllR9jaxACaRhQbpkH4xCYfpdKN+N7/qSCPALfathCJW7rM/FKyB
	YcNsrlDHf7Fr7nR/vBlIifDZ9q0PsDK7DHI78fv9P60P2Nlqv1tsYhazGzd/HCZJk00umJ
	zUBD398KMwzbLMLnqI+gFLFYZ0o646YCsWcJBuHi3mxHD2DPHjnN6YRItsQrcom3zkPO9x
	qPoGydyD6zReQM7AtcCJN0Jza4D/AFL+Bivl7QiB5eiVcVf6R4YksHYvrBidHOe2+WTT5p
	c1nqC3/JcQ5vHHrd8P0zfbYMJdAymAcAb4+Rs7RPNgIE+vLFPehlgGLWK/4CHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741371948;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jyRUoZ/VYkRkOOmhD+6bodu6hSbBK4ZHB5ncQD57VD0=;
	b=vQaePyWtW2PwMlnco7CkX2rTFbdPZMe3Z+x9P1r4MGJs9AQpIA4D/NJwggFBRWHByg5dAK
	+DpNQdgRbOTzGZBQ==
From: "tip-bot2 for Alexey Kardashevskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt: sev-guest: Move SNP Guest Request data pages
 handling under snp_cmd_mutex
Cc: Alexey Kardashevskiy <aik@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307013700.437505-3-aik@amd.com>
References: <20250307013700.437505-3-aik@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174137194498.14745.3512028477594108437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3e385c0d6ce88ac9916dcf84267bd5855d830748
Gitweb:        https://git.kernel.org/tip/3e385c0d6ce88ac9916dcf84267bd5855d830748
Author:        Alexey Kardashevskiy <aik@amd.com>
AuthorDate:    Fri, 07 Mar 2025 12:37:00 +11:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 07 Mar 2025 14:09:33 +01:00

virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex

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
---
 arch/x86/coco/sev/core.c                | 23 +++++-----------
 arch/x86/include/asm/sev.h              |  6 ++--
 drivers/virt/coco/sev-guest/sev-guest.c | 34 +++++++++++++++++++-----
 3 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492ef..96c7bc6 100644
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
@@ -3054,7 +3042,7 @@ retry_request:
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(req, &mdesc->input, rio);
+	rc = snp_issue_guest_request(req, &req->input, rio);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -3064,7 +3052,7 @@ retry_request:
 		 * order to increment the sequence number and thus avoid
 		 * IV reuse.
 		 */
-		override_npages = mdesc->input.data_npages;
+		override_npages = req->input.data_npages;
 		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
 
 		/*
@@ -3120,7 +3108,7 @@ retry_request:
 	}
 
 	if (override_npages)
-		mdesc->input.data_npages = override_npages;
+		req->input.data_npages = override_npages;
 
 	return rc;
 }
@@ -3158,6 +3146,11 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 	 */
 	memcpy(mdesc->request, &mdesc->secret_request, sizeof(mdesc->secret_request));
 
+	/* Initialize the input address for guest request */
+	req->input.req_gpa = __pa(mdesc->request);
+	req->input.resp_gpa = __pa(mdesc->response);
+	req->input.data_gpa = req->certs_data ? __pa(req->certs_data) : 0;
+
 	rc = __handle_guest_request(mdesc, req, rio);
 	if (rc) {
 		if (rc == -EIO &&
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 1581246..ba7999f 100644
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
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 23ac177..70fbc9a 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -176,6 +176,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	struct snp_guest_req req = {};
 	int ret, npages = 0, resp_len;
 	sockptr_t certs_address;
+	struct page *page;
 
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
@@ -209,8 +210,20 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
@@ -219,10 +232,12 @@ cmd:
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
@@ -237,7 +252,7 @@ cmd:
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		report_req->certs_len = mdesc->input.data_npages << PAGE_SHIFT;
+		report_req->certs_len = req.input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_sockptr(io->req_data, report_req, sizeof(*report_req)))
 			ret = -EFAULT;
@@ -246,7 +261,7 @@ cmd:
 	if (ret)
 		goto e_free;
 
-	if (npages && copy_to_sockptr(certs_address, mdesc->certs_data, report_req->certs_len)) {
+	if (npages && copy_to_sockptr(certs_address, req.certs_data, report_req->certs_len)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
@@ -256,6 +271,13 @@ cmd:
 
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
 

