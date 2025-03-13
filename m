Return-Path: <stable+bounces-124239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3EEA5EED7
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EE03B9023
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C4526563A;
	Thu, 13 Mar 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZXSetgO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C52641D1
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856506; cv=none; b=H/W/S72aKHhSt/eTSElaOGfReIbwGBWsNklg5LKOay8oul7Az0iHsjKgTWW/yuM2iLX9pBZD0HpTBY3yM2T2VBEqXa2wCgfsIJYhTMk37UfRVulU9bBW3PIkJdPN8EUrD2wWEX7wkjBnZMKq3O/Xt9L11aqtKB5j9Rc0U0A2H3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856506; c=relaxed/simple;
	bh=JqXKnCBjt0r7Ty1yHC7ljcZXSoa7w4nvIbe5NknM6LI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDR8WpNLHI978lA2oNc3NlGzbjt5TgNQwRZdIIe2cv6q6bzoanJFozckwO1pXiDBiCNP+vaatVZ1Mj/8aXIt/jWlRZJKbdezANszEKQMxkdGLJrFgu0idQNH9m2oz02BhKicma2kNUGM1vRYcN43UbK9oBzolYl0/rwRlyFrEDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZXSetgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EB4C4CEDD;
	Thu, 13 Mar 2025 09:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856506;
	bh=JqXKnCBjt0r7Ty1yHC7ljcZXSoa7w4nvIbe5NknM6LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZXSetgOmhEPFmAJRMY7r/FioJ5ogr9LGKRF4ntHt0lDyeHILO9DuFF994pa6HCCR
	 /BcYVq3mDMbEetQzJx+qMse+xJtItk55yVx6aEMiTQHJ+4WkH/+aDJQrPl1tbdYm2i
	 dk7E/Ve+XXxljCYxFCZArw5cCIDlAkhffYW9LX+Swmd4yKmg79lWO5C3+Yano/BiXT
	 3H1ayh6IoMQseqTvTd9e9Yq6rqtxtbslimOB/P0jx37syIV4ZAMvFzTtZDPztv06dJ
	 kO//3qCMK5146RR6J8X13rraRzZjLlP6HYZaC83zyISQysFw7IZslwbvx9SBkRvwhf
	 6lsvDGaQaun+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	aik@amd.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex
Date: Thu, 13 Mar 2025 05:01:44 -0400
Message-Id: <20250312224217-281d7f5ef03b0f1c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250310100027.1228858-1-aik@amd.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 3e385c0d6ce88ac9916dcf84267bd5855d830748

Note: The patch differs from the upstream commit:
---
1:  3e385c0d6ce88 ! 1:  a6b033d98441d virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex
    @@ Metadata
      ## Commit message ##
         virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex
     
    -    Compared to the SNP Guest Request, the "Extended" version adds data pages for
    -    receiving certificates. If not enough pages provided, the HV can report to the
    -    VM how much is needed so the VM can reallocate and repeat.
    +    Compared to the SNP Guest Request, the "Extended" version adds data pages
    +    for receiving certificates. If not enough pages provided, the HV can
    +    report to the VM how much is needed so the VM can reallocate and repeat.
     
    -    Commit
    -
    -      ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
    -
    -    moved handling of the allocated/desired pages number out of scope of said
    -    mutex and create a possibility for a race (multiple instances trying to
    -    trigger Extended request in a VM) as there is just one instance of
    -    snp_msg_desc per /dev/sev-guest and no locking other than snp_cmd_mutex.
    +    Commit ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command
    +    mutex") moved handling of the allocated/desired pages number out of scope
    +    of said mutex and create a possibility for a race (multiple instances
    +    trying to trigger Extended request in a VM) as there is just one instance
    +    of snp_msg_desc per /dev/sev-guest and no locking other than snp_cmd_mutex.
     
         Fix the issue by moving the data blob/size and the GHCB input struct
    -    (snp_req_data) into snp_guest_req which is allocated on stack now and accessed
    -    by the GHCB caller under that mutex.
    +    (snp_req_data) into snp_guest_req which is allocated on stack now
    +    and accessed by the GHCB caller under that mutex.
     
    -    Stop allocating SEV_FW_BLOB_MAX_SIZE in snp_msg_alloc() as only one of four
    -    callers needs it. Free the received blob in get_ext_report() right after it is
    -    copied to the userspace. Possible future users of snp_send_guest_request() are
    -    likely to have different ideas about the buffer size anyways.
    +    Stop allocating SEV_FW_BLOB_MAX_SIZE in snp_msg_alloc() as only one of
    +    four callers needs it. Free the received blob in get_ext_report() right
    +    after it is copied to the userspace. Possible future users of
    +    snp_send_guest_request() are likely to have different ideas about
    +    the buffer size anyways.
     
         Fixes: ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
    +    Cc: stable@vger.kernel.org # 6.13
    +    Cc: Nikunj A Dadhania <nikunj@amd.com>
         Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
    -    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
    -    Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
    -    Cc: stable@vger.kernel.org
    -    Link: https://lore.kernel.org/r/20250307013700.437505-3-aik@amd.com
     
    - ## arch/x86/coco/sev/core.c ##
    -@@ arch/x86/coco/sev/core.c: struct snp_msg_desc *snp_msg_alloc(void)
    - 	if (!mdesc->response)
    - 		goto e_free_request;
    + ## arch/x86/include/asm/sev.h ##
    +@@ arch/x86/include/asm/sev.h: struct snp_guest_req {
    + 	unsigned int vmpck_id;
    + 	u8 msg_version;
    + 	u8 msg_type;
    ++
    ++	struct snp_req_data input;
    ++	void *certs_data;
    + };
      
    --	mdesc->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
    --	if (!mdesc->certs_data)
    --		goto e_free_response;
    --
    --	/* initial the input address for guest request */
    --	mdesc->input.req_gpa = __pa(mdesc->request);
    --	mdesc->input.resp_gpa = __pa(mdesc->response);
    --	mdesc->input.data_gpa = __pa(mdesc->certs_data);
    + /*
    +@@ arch/x86/include/asm/sev.h: struct snp_msg_desc {
    + 	struct snp_guest_msg secret_request, secret_response;
    + 
    + 	struct snp_secrets_page *secrets;
    +-	struct snp_req_data input;
     -
    - 	return mdesc;
    +-	void *certs_data;
      
    --e_free_response:
    --	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
    - e_free_request:
    - 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
    - e_unmap:
    -@@ arch/x86/coco/sev/core.c: void snp_msg_free(struct snp_msg_desc *mdesc)
    - 	kfree(mdesc->ctx);
    - 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
    - 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
    --	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
    - 	iounmap((__force void __iomem *)mdesc->secrets);
    + 	struct aesgcm_ctx *ctx;
      
    - 	memset(mdesc, 0, sizeof(*mdesc));
    -@@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
    +
    + ## drivers/virt/coco/sev-guest/sev-guest.c ##
    +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
      	 * sequence number must be incremented or the VMPCK must be deleted to
      	 * prevent reuse of the IV.
      	 */
    @@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc
      	switch (rc) {
      	case -ENOSPC:
      		/*
    -@@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
    +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
      		 * order to increment the sequence number and thus avoid
      		 * IV reuse.
      		 */
    @@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc
      		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
      
      		/*
    -@@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
    +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
      	}
      
      	if (override_npages)
    @@ arch/x86/coco/sev/core.c: static int __handle_guest_request(struct snp_msg_desc
      
      	return rc;
      }
    -@@ arch/x86/coco/sev/core.c: int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
    - 	 */
    - 	memcpy(mdesc->request, &mdesc->secret_request, sizeof(mdesc->secret_request));
    +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
    + 	memcpy(mdesc->request, &mdesc->secret_request,
    + 	       sizeof(mdesc->secret_request));
      
    -+	/* Initialize the input address for guest request */
    ++	/* initial the input address for guest request */
     +	req->input.req_gpa = __pa(mdesc->request);
     +	req->input.resp_gpa = __pa(mdesc->response);
     +	req->input.data_gpa = req->certs_data ? __pa(req->certs_data) : 0;
    @@ arch/x86/coco/sev/core.c: int snp_send_guest_request(struct snp_msg_desc *mdesc,
      	rc = __handle_guest_request(mdesc, req, rio);
      	if (rc) {
      		if (rc == -EIO &&
    -
    - ## arch/x86/include/asm/sev.h ##
    -@@ arch/x86/include/asm/sev.h: struct snp_guest_req {
    - 	unsigned int vmpck_id;
    - 	u8 msg_version;
    - 	u8 msg_type;
    -+
    -+	struct snp_req_data input;
    -+	void *certs_data;
    - };
    - 
    - /*
    -@@ arch/x86/include/asm/sev.h: struct snp_msg_desc {
    - 	struct snp_guest_msg secret_request, secret_response;
    - 
    - 	struct snp_secrets_page *secrets;
    --	struct snp_req_data input;
    --
    --	void *certs_data;
    - 
    - 	struct aesgcm_ctx *ctx;
    - 
    -
    - ## drivers/virt/coco/sev-guest/sev-guest.c ##
     @@ drivers/virt/coco/sev-guest/sev-guest.c: static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
      	struct snp_guest_req req = {};
      	int ret, npages = 0, resp_len;
    @@ drivers/virt/coco/sev-guest/sev-guest.c: static int get_ext_report(struct snp_gu
      	return ret;
      }
      
    +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int __init sev_guest_probe(struct platform_device *pdev)
    + 	if (!mdesc->response)
    + 		goto e_free_request;
    + 
    +-	mdesc->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
    +-	if (!mdesc->certs_data)
    +-		goto e_free_response;
    +-
    + 	ret = -EIO;
    + 	mdesc->ctx = snp_init_crypto(mdesc->vmpck, VMPCK_KEY_LEN);
    + 	if (!mdesc->ctx)
    +-		goto e_free_cert_data;
    ++		goto e_free_response;
    + 
    + 	misc = &snp_dev->misc;
    + 	misc->minor = MISC_DYNAMIC_MINOR;
    + 	misc->name = DEVICE_NAME;
    + 	misc->fops = &snp_guest_fops;
    + 
    +-	/* Initialize the input addresses for guest request */
    +-	mdesc->input.req_gpa = __pa(mdesc->request);
    +-	mdesc->input.resp_gpa = __pa(mdesc->response);
    +-	mdesc->input.data_gpa = __pa(mdesc->certs_data);
    +-
    + 	/* Set the privlevel_floor attribute based on the vmpck_id */
    + 	sev_tsm_ops.privlevel_floor = vmpck_id;
    + 
    + 	ret = tsm_register(&sev_tsm_ops, snp_dev);
    + 	if (ret)
    +-		goto e_free_cert_data;
    ++		goto e_free_response;
    + 
    + 	ret = devm_add_action_or_reset(&pdev->dev, unregister_sev_tsm, NULL);
    + 	if (ret)
    +-		goto e_free_cert_data;
    ++		goto e_free_response;
    + 
    + 	ret =  misc_register(misc);
    + 	if (ret)
    +@@ drivers/virt/coco/sev-guest/sev-guest.c: static int __init sev_guest_probe(struct platform_device *pdev)
    + 
    + e_free_ctx:
    + 	kfree(mdesc->ctx);
    +-e_free_cert_data:
    +-	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
    + e_free_response:
    + 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
    + e_free_request:
    +@@ drivers/virt/coco/sev-guest/sev-guest.c: static void __exit sev_guest_remove(struct platform_device *pdev)
    + 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
    + 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
    + 
    +-	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
    + 	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
    + 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
    + 	kfree(mdesc->ctx);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

