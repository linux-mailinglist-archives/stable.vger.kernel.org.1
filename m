Return-Path: <stable+bounces-164306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A7FB0E5DB
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF8F3B0314
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A2228C86F;
	Tue, 22 Jul 2025 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJhRrba1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF828C864
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221504; cv=none; b=KdDE7Uu2kP/1WTkvDl7f0LlJmi4Kj8GLXCNMbppTAJjaqPXhmRVTSSb/8cOUq5+017KCAONOR1gocD0FrbIvqpkCde+LcZH8uUzWCV+RuLdVbWKZLma3791FAbEL4rSpJ8o6bVxyDhXFd7vfCMGIHOIT/7deDCLbWNAVcGrddH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221504; c=relaxed/simple;
	bh=WrSYgFPim88QUObs6C7hbchpKkJ9jIMhkTURVdhQ34Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2L5QqPKcl7JYC25BIEtnbWPtdrIG4sHwjkoX4twQrF+gFF3TVryXxe/XRP/dPVlFkSjzLZZrWI76RWokIa4zwrziBVI9/1qw+PPwsrjch5IrroAGEHRgWz2c0+jqNrQYdjQDEbwPgWFROmCftWbCVkUloHGgP7sWVK0DbNxUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJhRrba1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6B0C4CEF5;
	Tue, 22 Jul 2025 21:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221504;
	bh=WrSYgFPim88QUObs6C7hbchpKkJ9jIMhkTURVdhQ34Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJhRrba1V8HSJELIYXsaBCQDDK6vlsF7n1UKUAdtRC8Dfth0a5Z3+aesT+mepHstL
	 QeEH02f3KJwM1y5YD2GhjVCSooSNojPM1RPRbuFWBI5oiFpp5KG3T4SlIhRfN+GkGU
	 jgSwqTKHw/ISzqiwbBawzhMHDE0Jiybhyt0QSsCBwFqybxCAx1AI2Pqmr4RkDgLZx/
	 rbb1Dwgd7gX4Gpwl2XxStEDyx4Z906JQ8rPD/HY+Ri/Bsuf32P7SozI6kJPAu+4whE
	 4Vn+DtOt5M/VpuXw0GACDm9cvVv59SmSTO/eUxW8gP29WQcK6jObA1TyzN8Wj1mEMr
	 K0xr17Iy9ucGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix use-after-free in crypt_message when using async crypto
Date: Tue, 22 Jul 2025 17:58:19 -0400
Message-Id: <20250722215819.981600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072141-busybody-favoring-f21d@gregkh>
References: <2025072141-busybody-favoring-f21d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Zhaolong <wangzhaolong@huaweicloud.com>

[ Upstream commit b220bed63330c0e1733dc06ea8e75d5b9962b6b6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index da9305f0b6f53..619905fc694e4 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4552,6 +4552,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	u8 key[SMB3_ENC_DEC_KEY_SIZE];
 	struct aead_request *req;
 	u8 *iv;
+	DECLARE_CRYPTO_WAIT(wait);
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
 
@@ -4600,7 +4601,11 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
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
-- 
2.39.5


