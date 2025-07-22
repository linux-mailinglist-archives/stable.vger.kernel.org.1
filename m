Return-Path: <stable+bounces-164264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CD1B0DE7B
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77051885FE2
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EEC2EA17E;
	Tue, 22 Jul 2025 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIl6Z6Co"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6732EA15D
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193961; cv=none; b=XxuLVDFmEPH9d5hE2Om3YGlpylJBzkSEbNN++nUMz3jh4spuHI24HRgJOJAQXduyg6xGncks0nFuI3A+TzXoGLcmL3D2T8+hJt8beuY+U0MT6WUkInH6vOXijMc2RX5VelcmV1yQu/l/nupCESTueWSAa3jloAgXNmsz5GH7zec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193961; c=relaxed/simple;
	bh=RI8dZDd9ZT4uQ4WozM+QBiu32S5R56TIBmk2cz2pnNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=toJiYDwvTPKxSyzIblUaFbdPXZA5TRrSmUEk7eBi7pN43hWvEysRwYSeIhHFCxu04OXZQYHCMT/pRuTNISXhtzvBY9hUNg9yF+mg0SwrXteb5bkjC6gK40PTjwqKhQJgUUD12v36unXSwoNYFBX0Cg7qI0AZTKiFy9oARG/UHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIl6Z6Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7984BC4CEEB;
	Tue, 22 Jul 2025 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753193961;
	bh=RI8dZDd9ZT4uQ4WozM+QBiu32S5R56TIBmk2cz2pnNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIl6Z6Codok5NLf518r11kuFFWN07nC3TBJZhINukS/SAQRi2H0ssj8GylkT66ajT
	 6Y3ZeQ50zc5zulT+8iqEpjgzXLBscv1KBW8Asr+SLE3N/TSpXqUPjxf8wrUbAhwquh
	 p+QiUV9z90xIlkA8sesgNCGuggsVxNgnbUyveANBWful6S7CVNKNSSvp96m0YhzJ7/
	 tsJttOdhZO42B1+Xanod+n1pXaFY80Sh5yCncT1Jx6YQh1/PBWyCggROQGSPZKtoQQ
	 JsRD6mPX6yBmj5qurJfsl60ki1F5NMU2yed0Ufqhka/ud70Uuip7bS4gQ8C08atfu5
	 M3sMvoFxzZ1Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix use-after-free in crypt_message when using async crypto
Date: Tue, 22 Jul 2025 10:19:11 -0400
Message-Id: <20250722141911.953243-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072141-jujitsu-ebay-6dbf@gregkh>
References: <2025072141-jujitsu-ebay-6dbf@gregkh>
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
index aa1acc698caa2..1297acb5bf8e5 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4302,6 +4302,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	u8 key[SMB3_ENC_DEC_KEY_SIZE];
 	struct aead_request *req;
 	u8 *iv;
+	DECLARE_CRYPTO_WAIT(wait);
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
 
@@ -4350,7 +4351,11 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
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


