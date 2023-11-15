Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634457ECD36
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjKOTfF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjKOTfF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C424A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E26C433C9;
        Wed, 15 Nov 2023 19:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076901;
        bh=ZBqWhPLsaLJAo6KQ4iRPT1byk/JK5jjIRP2DqhwGWmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/XoFJuqOW2axJXwL1bAG9jjBKZ5ghn1LNvoK/tA6Yzu5ebn5h2O9BMhGzQwPUt9D
         IWDmNYHZh8uYxng8Oo50oS1QmOSXG9xnACEd/mdAejCVbUqSo4NX5b7/oKPySyqlaM
         nCdPxmwXJi9/MV4H9cQfmxWh/YGjil4XhAY/hGm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 458/550] virt: sevguest: Fix passing a stack buffer as a scatterlist target
Date:   Wed, 15 Nov 2023 14:17:22 -0500
Message-ID: <20231115191632.603281424@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit db10cb9b574675402bfd8fe1a31aafdd45b002df ]

CONFIG_DEBUG_SG highlights that get_{report,ext_report,derived_key)()}
are passing stack buffers as the @req_buf argument to
handle_guest_request(), generating a Call Trace of the following form:

    WARNING: CPU: 0 PID: 1175 at include/linux/scatterlist.h:187 enc_dec_message+0x518/0x5b0 [sev_guest]
    [..]
    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
    RIP: 0010:enc_dec_message+0x518/0x5b0 [sev_guest]
    Call Trace:
     <TASK>
    [..]
     handle_guest_request+0x135/0x520 [sev_guest]
     get_ext_report+0x1ec/0x3e0 [sev_guest]
     snp_guest_ioctl+0x157/0x200 [sev_guest]

Note that the above Call Trace was with the DEBUG_SG BUG_ON()s converted
to WARN_ON()s.

This is benign as long as there are no hardware crypto accelerators
loaded for the aead cipher, and no subsequent dma_map_sg() is performed
on the scatterlist. However, sev-guest can not assume the presence of
an aead accelerator nor can it assume that CONFIG_DEBUG_SG is disabled.

Resolve this bug by allocating virt_addr_valid() memory, similar to the
other buffers am @snp_dev instance carries, to marshal requests from
user buffers to kernel buffers.

Reported-by: Peter Gonda <pgonda@google.com>
Closes: http://lore.kernel.org/r/CAMkAt6r2VPPMZ__SQfJse8qWsUyYW3AgYbOUVM0S_Vtk=KvkxQ@mail.gmail.com
Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 45 ++++++++++++++-----------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 97dbe715e96ad..5bee58ef5f1e3 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -57,6 +57,11 @@ struct snp_guest_dev {
 
 	struct snp_secrets_page_layout *layout;
 	struct snp_req_data input;
+	union {
+		struct snp_report_req report;
+		struct snp_derived_key_req derived_key;
+		struct snp_ext_report_req ext_report;
+	} req;
 	u32 *os_area_msg_seqno;
 	u8 *vmpck;
 };
@@ -473,8 +478,8 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_report_req *req = &snp_dev->req.report;
 	struct snp_report_resp *resp;
-	struct snp_report_req req;
 	int rc, resp_len;
 
 	lockdep_assert_held(&snp_cmd_mutex);
@@ -482,7 +487,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
-	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+	if (copy_from_user(req, (void __user *)arg->req_data, sizeof(*req)))
 		return -EFAULT;
 
 	/*
@@ -496,7 +501,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 		return -ENOMEM;
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
-				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
+				  SNP_MSG_REPORT_REQ, req, sizeof(*req), resp->data,
 				  resp_len);
 	if (rc)
 		goto e_free;
@@ -511,9 +516,9 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
+	struct snp_derived_key_req *req = &snp_dev->req.derived_key;
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
 	struct snp_derived_key_resp resp = {0};
-	struct snp_derived_key_req req;
 	int rc, resp_len;
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
 	u8 buf[64 + 16];
@@ -532,11 +537,11 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
-	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+	if (copy_from_user(req, (void __user *)arg->req_data, sizeof(*req)))
 		return -EFAULT;
 
 	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
-				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
+				  SNP_MSG_KEY_REQ, req, sizeof(*req), buf, resp_len);
 	if (rc)
 		return rc;
 
@@ -552,8 +557,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 
 static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
+	struct snp_ext_report_req *req = &snp_dev->req.ext_report;
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_ext_report_req req;
 	struct snp_report_resp *resp;
 	int ret, npages = 0, resp_len;
 
@@ -562,18 +567,18 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
-	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+	if (copy_from_user(req, (void __user *)arg->req_data, sizeof(*req)))
 		return -EFAULT;
 
 	/* userspace does not want certificate data */
-	if (!req.certs_len || !req.certs_address)
+	if (!req->certs_len || !req->certs_address)
 		goto cmd;
 
-	if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
-	    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
+	if (req->certs_len > SEV_FW_BLOB_MAX_SIZE ||
+	    !IS_ALIGNED(req->certs_len, PAGE_SIZE))
 		return -EINVAL;
 
-	if (!access_ok((const void __user *)req.certs_address, req.certs_len))
+	if (!access_ok((const void __user *)req->certs_address, req->certs_len))
 		return -EFAULT;
 
 	/*
@@ -582,8 +587,8 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	 * the host. If host does not supply any certs in it, then copy
 	 * zeros to indicate that certificate data was not provided.
 	 */
-	memset(snp_dev->certs_data, 0, req.certs_len);
-	npages = req.certs_len >> PAGE_SHIFT;
+	memset(snp_dev->certs_data, 0, req->certs_len);
+	npages = req->certs_len >> PAGE_SHIFT;
 cmd:
 	/*
 	 * The intermediate response buffer is used while decrypting the
@@ -597,14 +602,14 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 
 	snp_dev->input.data_npages = npages;
 	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
-				   SNP_MSG_REPORT_REQ, &req.data,
-				   sizeof(req.data), resp->data, resp_len);
+				   SNP_MSG_REPORT_REQ, &req->data,
+				   sizeof(req->data), resp->data, resp_len);
 
 	/* If certs length is invalid then copy the returned length */
 	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
-		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
+		req->certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
-		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
+		if (copy_to_user((void __user *)arg->req_data, req, sizeof(*req)))
 			ret = -EFAULT;
 	}
 
@@ -612,8 +617,8 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 		goto e_free;
 
 	if (npages &&
-	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
-			 req.certs_len)) {
+	    copy_to_user((void __user *)req->certs_address, snp_dev->certs_data,
+			 req->certs_len)) {
 		ret = -EFAULT;
 		goto e_free;
 	}
-- 
2.42.0



