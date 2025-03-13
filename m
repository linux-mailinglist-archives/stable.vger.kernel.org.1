Return-Path: <stable+bounces-124250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7195DA5EF30
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5777AE786
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7F264F9E;
	Thu, 13 Mar 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH4XdpMg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5D264630
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856934; cv=none; b=Ji8H7Lx8j0jPVFNHDQIqk0dgBMlDzLqnMVycxdOUjq+b+XgrYScFvVI9HDy7o51qxI1S/lsEO4MGlrQW8jvFlMcWUywijhyJxH+6G+LZLC652X/sEvLWWr2y77oxo0D7Fjl8/g7572LYH7n9g9kQltYYLh3pwpNtukJfoW3fCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856934; c=relaxed/simple;
	bh=X1WxZBS1fvNuuZNXwklFqMv+ls3ULCDC+yPsqMJV5B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFQAvuhwG3aYlICWhB5MPljAdvwSGiY5Pbj9nyCgvZvvqQniKWKN/q2gjqYQooly6GzxT4s9LXW724yi77CHJFAJErJdyGV1xsnty6P4EPECCek/NuxCSXd1ZNU2ktuUlmL7iBNjDhArcVf2HOcvnfFRAl+uhG/GuACHAZadj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH4XdpMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CB7C4CEEA;
	Thu, 13 Mar 2025 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856934;
	bh=X1WxZBS1fvNuuZNXwklFqMv+ls3ULCDC+yPsqMJV5B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PH4XdpMgpCNVSreeGyli4d1s8iYgjq6je2W/neCD+og6z0EthuNLPcbOeYyhqYFRB
	 2zGebDvLHgFoYBIWRn6CUn6GgVuCmo3P2oshGmdww8mZXcD+ncfB7RE7g2UH9vsklf
	 Iqkb4DD3/toCnbq//sj/lK2khq3o3hr2ZuJFyBaB9Eo3bjFLFGHE+za3kd3P0OZwLj
	 6muEHeLD2USUZ7whiPwiDU0SVgPXl6BR8njB/bisWxOl3VgA/meZLARYzWAivY/DuU
	 T6NXoaWDllV/mQm5ZQfqox6NIAw0hOrRRru5g7abwcrG1EQUdgkFstNfZ0xLvlrq4r
	 WYmHvV3+e3T/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	aik@amd.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex
Date: Thu, 13 Mar 2025 05:08:52 -0400
Message-Id: <20250312223932-352a4f3bf0ca25bb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311073601.1412363-1-aik@amd.com>
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
1:  3e385c0d6ce88 ! 1:  796b69e2edd7a virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex
    @@ Commit message
         Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
         Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
         Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
    -    Cc: stable@vger.kernel.org
    +    Cc: stable@vger.kernel.org # 6.13
         Link: https://lore.kernel.org/r/20250307013700.437505-3-aik@amd.com
    +    (cherry picked from commit 3e385c0d6ce88ac9916dcf84267bd5855d830748)
     
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

