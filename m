Return-Path: <stable+bounces-121566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DDAA58304
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 11:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F66C16BD44
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CE91487F6;
	Sun,  9 Mar 2025 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Em/vZS6L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91174C2C8
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741516274; cv=none; b=Y1Zdo9WZcvn2RUeyaOXemsVup2ak9oUoh1qNaP4yXlam/YuOERa1lvAUqnL7JkCopVCFe6kus/XEDb0GTxTCKBlb+neAHXw/6k43FMPhj6hXl/2WoicrplsGuKUzQacku+oXqvYHfkoNtPdfjZhCGcUUQZOBbX/ZWmHyOEQsmAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741516274; c=relaxed/simple;
	bh=2SRehyW1CT8hbnowa+vBfuq4cqME4g8qTQncrrSd8bQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AcnSaDSPD57b9swcsx27kNcm/FrbbYBVuHTz1QjAEAomysJ4o8gOIArlBoMIJfF7O2LAxWToXXgE4TBDHf2Ta7AZ9la5ntG0JiEWXzO6Tn9rpfyffg5fzX1pAEKB7Zi01hNcq54yeM+CAjmVC62ommJ3CBbmbAvHDbvlrUF5IDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Em/vZS6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F69C4CEE5;
	Sun,  9 Mar 2025 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741516273;
	bh=2SRehyW1CT8hbnowa+vBfuq4cqME4g8qTQncrrSd8bQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Em/vZS6Ltkenr5jV0IR2DAlTqmoBMG8naXOB9/wNZNxl4T92gIUrSivwWT/o2BKIu
	 HITSmgiOnWuP7KGriB3Exo2v14j7rpb8gF0SndnKQhknNJqXQ2wC0yOim0TwP9CSjR
	 ZeDczq5inKnDUQFBkKoH5RlzgJRgiZD7fiDXsSo8=
Subject: FAILED: patch "[PATCH] virt: sev-guest: Move SNP Guest Request data pages handling" failed to apply to 6.13-stable tree
To: aik@amd.com,bp@alien8.de,nikunj@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 11:29:57 +0100
Message-ID: <2025030957-magnetism-lustily-55d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x 3e385c0d6ce88ac9916dcf84267bd5855d830748
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030957-magnetism-lustily-55d9@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e385c0d6ce88ac9916dcf84267bd5855d830748 Mon Sep 17 00:00:00 2001
From: Alexey Kardashevskiy <aik@amd.com>
Date: Fri, 7 Mar 2025 12:37:00 +1100
Subject: [PATCH] virt: sev-guest: Move SNP Guest Request data pages handling
 under snp_cmd_mutex

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

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492efc5d94..96c7bc698e6b 100644
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
 
+	/* Initialize the input address for guest request */
+	req->input.req_gpa = __pa(mdesc->request);
+	req->input.resp_gpa = __pa(mdesc->response);
+	req->input.data_gpa = req->certs_data ? __pa(req->certs_data) : 0;
+
 	rc = __handle_guest_request(mdesc, req, rio);
 	if (rc) {
 		if (rc == -EIO &&
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
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 23ac177472be..70fbc9a3e703 100644
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
@@ -219,10 +232,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
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
@@ -237,7 +252,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		report_req->certs_len = mdesc->input.data_npages << PAGE_SHIFT;
+		report_req->certs_len = req.input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_sockptr(io->req_data, report_req, sizeof(*report_req)))
 			ret = -EFAULT;
@@ -246,7 +261,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (ret)
 		goto e_free;
 
-	if (npages && copy_to_sockptr(certs_address, mdesc->certs_data, report_req->certs_len)) {
+	if (npages && copy_to_sockptr(certs_address, req.certs_data, report_req->certs_len)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
@@ -256,6 +271,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
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
 


