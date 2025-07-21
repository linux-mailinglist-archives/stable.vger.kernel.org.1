Return-Path: <stable+bounces-163561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 136D1B0C26F
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35CB18C3811
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE6E299948;
	Mon, 21 Jul 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xx+IbqYz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3762980C2
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096457; cv=none; b=IfI3gPO7crldHdL0/fOhsMzUjgkICqleg0nuddWHWUc10vdY7Y7kMOMHByQKQkmi038AzFEt9ADvKvuZvZV8moQEAJ3gzX4k1/ddhd9hwdCEEYgWSLmFWWnB6aRkQ4DRImSY2JyU5TX0uToxUUwzLOt8I9omfs5w19G4HNRzqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096457; c=relaxed/simple;
	bh=Bxm51023DAsOOWaEqag+EYUY0FtAtqOpOdS4eavAGdU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UUwNawUaT/RB/LJ1HV6fsMe5v6kzlYuybvxUKfbDQYnSg8TMxxQajfYrsZHnOqXNge30N0lSpRkLaUouNKrE7eHQdMZ/IlVEMPx61mxM0PmIfsr1sER1cFJFJa98L6azK9S3tNS3VbUWP9cOyAPZT5ubVLmpCCyTIo86qGriC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xx+IbqYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71218C4CEF1;
	Mon, 21 Jul 2025 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753096456;
	bh=Bxm51023DAsOOWaEqag+EYUY0FtAtqOpOdS4eavAGdU=;
	h=Subject:To:Cc:From:Date:From;
	b=xx+IbqYzd+oKRoFAXZj/HMGz4M5Hn+ssjDUAN/k0nvwmOlLOXTZnroYYWaEkSaQSz
	 23qul8ndhRcEVwnrzHI511xe49hNpvZ3Uyr52dkgC15XIAyrV3udWSVVxQK9lG8Wj9
	 ct9bL9ZKJ4xAC6oJJt9gopQYZZ3soBK6MnSZDNcY=
Subject: FAILED: patch "[PATCH] smb: client: fix use-after-free in crypt_message when using" failed to apply to 5.10-stable tree
To: wangzhaolong@huaweicloud.com,pc@manguebit.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 13:13:41 +0200
Message-ID: <2025072141-jujitsu-ebay-6dbf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b220bed63330c0e1733dc06ea8e75d5b9962b6b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072141-jujitsu-ebay-6dbf@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b220bed63330c0e1733dc06ea8e75d5b9962b6b6 Mon Sep 17 00:00:00 2001
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Date: Sat, 5 Jul 2025 10:51:18 +0800
Subject: [PATCH] smb: client: fix use-after-free in crypt_message when using
 async crypto

The CVE-2024-50047 fix removed asynchronous crypto handling from
crypt_message(), assuming all crypto operations are synchronous.
However, when hardware crypto accelerators are used, this can cause
use-after-free crashes:

  crypt_message()
    // Allocate the creq buffer containing the req
    creq = smb2_get_aead_req(..., &req);

    // Async encryption returns -EINPROGRESS immediately
    rc = enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req);

    // Free creq while async operation is still in progress
    kvfree_sensitive(creq, ...);

Hardware crypto modules often implement async AEAD operations for
performance. When crypto_aead_encrypt/decrypt() returns -EINPROGRESS,
the operation completes asynchronously. Without crypto_wait_req(),
the function immediately frees the request buffer, leading to crashes
when the driver later accesses the freed memory.

This results in a use-after-free condition when the hardware crypto
driver later accesses the freed request structure, leading to kernel
crashes with NULL pointer dereferences.

The issue occurs because crypto_alloc_aead() with mask=0 doesn't
guarantee synchronous operation. Even without CRYPTO_ALG_ASYNC in
the mask, async implementations can be selected.

Fix by restoring the async crypto handling:
- DECLARE_CRYPTO_WAIT(wait) for completion tracking
- aead_request_set_callback() for async completion notification
- crypto_wait_req() to wait for operation completion

This ensures the request buffer isn't freed until the crypto operation
completes, whether synchronous or asynchronous, while preserving the
CVE-2024-50047 fix.

Fixes: b0abcd65ec54 ("smb: client: fix UAF in async decryption")
Link: https://lore.kernel.org/all/8b784a13-87b0-4131-9ff9-7a8993538749@huaweicloud.com/
Cc: stable@vger.kernel.org
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1468c16ea9b8..cb659256d219 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4316,6 +4316,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	u8 key[SMB3_ENC_DEC_KEY_SIZE];
 	struct aead_request *req;
 	u8 *iv;
+	DECLARE_CRYPTO_WAIT(wait);
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
 	size_t sensitive_size;
@@ -4366,7 +4367,11 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
 	aead_request_set_ad(req, assoc_data_len);
 
-	rc = enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				  crypto_req_done, &wait);
+
+	rc = crypto_wait_req(enc ? crypto_aead_encrypt(req)
+				: crypto_aead_decrypt(req), &wait);
 
 	if (!rc && enc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);


