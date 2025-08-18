Return-Path: <stable+bounces-169947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDA1B29E46
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147A9188F6EB
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818C19D08F;
	Mon, 18 Aug 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tDgFP00P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D64E30F7F8
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510342; cv=none; b=vEfMQih4LTDj+gY+AWpb4Dn1KqzRKrsrIZlNplPBRv35HkC1tJ22ksPltinEDEe4cY7CYlzVQ9OLzPW+Xu4zlvVz/haF1BINPqeZaYMqrJUYu1xV2YSD5RLNuq1OHA2wbZCPiifi67NPUhTGRnFJfETJ4qvBG0HxWAnKNb5ejZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510342; c=relaxed/simple;
	bh=NTt1PWNpGVPSUZCvrOGVyCJ0iCS0l9s417+uUhzretM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HBaG5Nf7hoMufvMC3OPLRBOOMY0nQ078LxOBA+zcDyqPBLdtx3JYsMhZbE52YTY/PoLF4FKR+KeT3HIF8egpvDc0/y2t9u8ViOX6FKXBd9ZUb6bSwn1eEzS7DEhGJEecXnd+C9Ltmeq3IHdLCfg9xsSy4Yp28hP7soHkba9KnSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tDgFP00P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC43C4CEEB;
	Mon, 18 Aug 2025 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755510342;
	bh=NTt1PWNpGVPSUZCvrOGVyCJ0iCS0l9s417+uUhzretM=;
	h=Subject:To:Cc:From:Date:From;
	b=tDgFP00PEcPXsX9sKhWVxneBx466QCXjRhpmdy+tve1hcAp/yD6Pnw+t7oRvKkdvf
	 Od2KKu0O9+SQWBdkyxL0U9yDWT8Sz9yeoVIeA2SKNWB86eyyNokUYT8MizT7EWhvbj
	 fbWNRSo24bd2SK/UNL2CN68I8rMFMqskgp5wdojo=
Subject: FAILED: patch "[PATCH] virt: sev-guest: Satisfy linear mapping requirement in" failed to apply to 6.16-stable tree
To: thomas.lendacky@amd.com,bp@alien8.de,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 11:45:39 +0200
Message-ID: <2025081839-unmoral-mulch-990f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x c08ba63078dd6046c279df37795cb77e784e1ec9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081839-unmoral-mulch-990f@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c08ba63078dd6046c279df37795cb77e784e1ec9 Mon Sep 17 00:00:00 2001
From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Wed, 16 Jul 2025 15:41:35 -0500
Subject: [PATCH] virt: sev-guest: Satisfy linear mapping requirement in
 get_derived_key()

Commit

  7ffeb2fc2670 ("x86/sev: Document requirement for linear mapping of guest request buffers")

added a check that requires the guest request buffers to be in the linear
mapping. The get_derived_key() function was passing a buffer that was
allocated on the stack, resulting in the call to snp_send_guest_request()
returning an error.

Update the get_derived_key() function to use an allocated buffer instead
of a stack buffer.

Fixes: 7ffeb2fc2670 ("x86/sev: Document requirement for linear mapping of guest request buffers")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/9b764ca9fc79199a091aac684c4926e2080ca7a8.1752698495.git.thomas.lendacky@amd.com

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index d2b3ae7113ab..b01ec99106cd 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -116,13 +116,11 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
+	struct snp_derived_key_resp *derived_key_resp __free(kfree) = NULL;
 	struct snp_derived_key_req *derived_key_req __free(kfree) = NULL;
-	struct snp_derived_key_resp derived_key_resp = {0};
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_guest_req req = {};
 	int rc, resp_len;
-	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
-	u8 buf[64 + 16];
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -132,8 +130,9 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(derived_key_resp.data) + mdesc->ctx->authsize;
-	if (sizeof(buf) < resp_len)
+	resp_len = sizeof(derived_key_resp->data) + mdesc->ctx->authsize;
+	derived_key_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
+	if (!derived_key_resp)
 		return -ENOMEM;
 
 	derived_key_req = kzalloc(sizeof(*derived_key_req), GFP_KERNEL_ACCOUNT);
@@ -149,23 +148,21 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	req.vmpck_id = mdesc->vmpck_id;
 	req.req_buf = derived_key_req;
 	req.req_sz = sizeof(*derived_key_req);
-	req.resp_buf = buf;
+	req.resp_buf = derived_key_resp;
 	req.resp_sz = resp_len;
 	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
 	rc = snp_send_guest_request(mdesc, &req);
 	arg->exitinfo2 = req.exitinfo2;
-	if (rc)
-		return rc;
-
-	memcpy(derived_key_resp.data, buf, sizeof(derived_key_resp.data));
-	if (copy_to_user((void __user *)arg->resp_data, &derived_key_resp,
-			 sizeof(derived_key_resp)))
-		rc = -EFAULT;
+	if (!rc) {
+		if (copy_to_user((void __user *)arg->resp_data, derived_key_resp,
+				 sizeof(derived_key_resp->data)))
+			rc = -EFAULT;
+	}
 
 	/* The response buffer contains the sensitive data, explicitly clear it. */
-	memzero_explicit(buf, sizeof(buf));
-	memzero_explicit(&derived_key_resp, sizeof(derived_key_resp));
+	memzero_explicit(derived_key_resp, sizeof(*derived_key_resp));
+
 	return rc;
 }
 


