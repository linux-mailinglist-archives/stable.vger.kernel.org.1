Return-Path: <stable+bounces-83889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76B299CD0A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DBC282D8A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDF91AA7A5;
	Mon, 14 Oct 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XjxBMDtA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66E1A0724;
	Mon, 14 Oct 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916082; cv=none; b=CC7dYvIPHKh66oHWZI0AqRN5yinkjMd+wDSCPI31T7tFzf1v9iwzoZTE78i26xOuREjPZg2P3DGUYcf292pfW80kVMUxgqqWQfGUS/ncCkUZneBTUqIG9gjLh7RPGBHFGrpG7LHjZ2zHtFVEG9n9DFZNMubWSZCF9uDh2+Zmx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916082; c=relaxed/simple;
	bh=gSX5rQITFHxIhaMF+8fdu3kfdb+2O3449dGUEOinq50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU0BzdGlghbTqo4h/lCJIU9UpnmMTi1ytk5VW/Rp/YgOf6pdaYCQlqr+AVN1AfzPtvuGK4qbRtT3gXs7IFEWRV7Ho7MFB1Kzxr94al9M1pLO1nCITzDA9qWQdTPTvhOYS8Orf8yONqA1XTzQSmLH+YWrTQnloCezc5/Yu5svHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XjxBMDtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E452C4CEC3;
	Mon, 14 Oct 2024 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916082;
	bh=gSX5rQITFHxIhaMF+8fdu3kfdb+2O3449dGUEOinq50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjxBMDtAfqT16GeZYvmFKlRNWuAH/+RvZfxPmmb+n6URdmJkz1SQpYmrcwKVSbO+5
	 WrdhCviD+YuMCI68AXgTyLvfmc82UcyoC28RxvJJ/pi2n4uMv1n5P1ww5V5atW/qup
	 li6J+NI0cPO9lZle6kMd0WWOON+xSa+30+zJBc4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 079/214] smb: client: fix UAF in async decryption
Date: Mon, 14 Oct 2024 16:19:02 +0200
Message-ID: <20241014141048.070504307@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enzo Matsumiya <ematsumiya@suse.de>

[ Upstream commit b0abcd65ec545701b8793e12bc27dc98042b151a ]

Doing an async decryption (large read) crashes with a
slab-use-after-free way down in the crypto API.

Reproducer:
    # mount.cifs -o ...,seal,esize=1 //srv/share /mnt
    # dd if=/mnt/largefile of=/dev/null
    ...
    [  194.196391] ==================================================================
    [  194.196844] BUG: KASAN: slab-use-after-free in gf128mul_4k_lle+0xc1/0x110
    [  194.197269] Read of size 8 at addr ffff888112bd0448 by task kworker/u77:2/899
    [  194.197707]
    [  194.197818] CPU: 12 UID: 0 PID: 899 Comm: kworker/u77:2 Not tainted 6.11.0-lku-00028-gfca3ca14a17a-dirty #43
    [  194.198400] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-prebuilt.qemu.org 04/01/2014
    [  194.199046] Workqueue: smb3decryptd smb2_decrypt_offload [cifs]
    [  194.200032] Call Trace:
    [  194.200191]  <TASK>
    [  194.200327]  dump_stack_lvl+0x4e/0x70
    [  194.200558]  ? gf128mul_4k_lle+0xc1/0x110
    [  194.200809]  print_report+0x174/0x505
    [  194.201040]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
    [  194.201352]  ? srso_return_thunk+0x5/0x5f
    [  194.201604]  ? __virt_addr_valid+0xdf/0x1c0
    [  194.201868]  ? gf128mul_4k_lle+0xc1/0x110
    [  194.202128]  kasan_report+0xc8/0x150
    [  194.202361]  ? gf128mul_4k_lle+0xc1/0x110
    [  194.202616]  gf128mul_4k_lle+0xc1/0x110
    [  194.202863]  ghash_update+0x184/0x210
    [  194.203103]  shash_ahash_update+0x184/0x2a0
    [  194.203377]  ? __pfx_shash_ahash_update+0x10/0x10
    [  194.203651]  ? srso_return_thunk+0x5/0x5f
    [  194.203877]  ? crypto_gcm_init_common+0x1ba/0x340
    [  194.204142]  gcm_hash_assoc_remain_continue+0x10a/0x140
    [  194.204434]  crypt_message+0xec1/0x10a0 [cifs]
    [  194.206489]  ? __pfx_crypt_message+0x10/0x10 [cifs]
    [  194.208507]  ? srso_return_thunk+0x5/0x5f
    [  194.209205]  ? srso_return_thunk+0x5/0x5f
    [  194.209925]  ? srso_return_thunk+0x5/0x5f
    [  194.210443]  ? srso_return_thunk+0x5/0x5f
    [  194.211037]  decrypt_raw_data+0x15f/0x250 [cifs]
    [  194.212906]  ? __pfx_decrypt_raw_data+0x10/0x10 [cifs]
    [  194.214670]  ? srso_return_thunk+0x5/0x5f
    [  194.215193]  smb2_decrypt_offload+0x12a/0x6c0 [cifs]

This is because TFM is being used in parallel.

Fix this by allocating a new AEAD TFM for async decryption, but keep
the existing one for synchronous READ cases (similar to what is done
in smb3_calc_signature()).

Also remove the calls to aead_request_set_callback() and
crypto_wait_req() since it's always going to be a synchronous operation.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 47 ++++++++++++++++++++++++-----------------
 fs/smb/client/smb2pdu.c |  6 ++++++
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2ba43327d3f4c..e9be7b43bb6b8 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4312,7 +4312,7 @@ smb2_get_enc_key(struct TCP_Server_Info *server, __u64 ses_id, int enc, u8 *key)
  */
 static int
 crypt_message(struct TCP_Server_Info *server, int num_rqst,
-	      struct smb_rqst *rqst, int enc)
+	      struct smb_rqst *rqst, int enc, struct crypto_aead *tfm)
 {
 	struct smb2_transform_hdr *tr_hdr =
 		(struct smb2_transform_hdr *)rqst[0].rq_iov[0].iov_base;
@@ -4323,8 +4323,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	u8 key[SMB3_ENC_DEC_KEY_SIZE];
 	struct aead_request *req;
 	u8 *iv;
-	DECLARE_CRYPTO_WAIT(wait);
-	struct crypto_aead *tfm;
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
 	size_t sensitive_size;
@@ -4336,14 +4334,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 		return rc;
 	}
 
-	rc = smb3_crypto_aead_allocate(server);
-	if (rc) {
-		cifs_server_dbg(VFS, "%s: crypto alloc failed\n", __func__);
-		return rc;
-	}
-
-	tfm = enc ? server->secmech.enc : server->secmech.dec;
-
 	if ((server->cipher_type == SMB2_ENCRYPTION_AES256_CCM) ||
 		(server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
 		rc = crypto_aead_setkey(tfm, key, SMB3_GCM256_CRYPTKEY_SIZE);
@@ -4383,11 +4373,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
 	aead_request_set_ad(req, assoc_data_len);
 
-	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-				  crypto_req_done, &wait);
-
-	rc = crypto_wait_req(enc ? crypto_aead_encrypt(req)
-				: crypto_aead_decrypt(req), &wait);
+	rc = enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req);
 
 	if (!rc && enc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
@@ -4493,7 +4479,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	/* fill the 1st iov with a transform header */
 	fill_transform_hdr(tr_hdr, orig_len, old_rq, server->cipher_type);
 
-	rc = crypt_message(server, num_rqst, new_rq, 1);
+	rc = crypt_message(server, num_rqst, new_rq, 1, server->secmech.enc);
 	cifs_dbg(FYI, "Encrypt message returned %d\n", rc);
 	if (rc)
 		goto err_free;
@@ -4518,8 +4504,9 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 		 unsigned int buf_data_size, struct iov_iter *iter,
 		 bool is_offloaded)
 {
-	struct kvec iov[2];
+	struct crypto_aead *tfm;
 	struct smb_rqst rqst = {NULL};
+	struct kvec iov[2];
 	size_t iter_size = 0;
 	int rc;
 
@@ -4535,9 +4522,31 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 		iter_size = iov_iter_count(iter);
 	}
 
-	rc = crypt_message(server, 1, &rqst, 0);
+	if (is_offloaded) {
+		if ((server->cipher_type == SMB2_ENCRYPTION_AES128_GCM) ||
+		    (server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
+			tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
+		else
+			tfm = crypto_alloc_aead("ccm(aes)", 0, 0);
+		if (IS_ERR(tfm)) {
+			rc = PTR_ERR(tfm);
+			cifs_server_dbg(VFS, "%s: Failed alloc decrypt TFM, rc=%d\n", __func__, rc);
+
+			return rc;
+		}
+	} else {
+		if (unlikely(!server->secmech.dec))
+			return -EIO;
+
+		tfm = server->secmech.dec;
+	}
+
+	rc = crypt_message(server, 1, &rqst, 0, tfm);
 	cifs_dbg(FYI, "Decrypt message returned %d\n", rc);
 
+	if (is_offloaded)
+		crypto_free_aead(tfm);
+
 	if (rc)
 		return rc;
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 88dc49d670371..3d9e6e15dd900 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1265,6 +1265,12 @@ SMB2_negotiate(const unsigned int xid,
 		else
 			cifs_server_dbg(VFS, "Missing expected negotiate contexts\n");
 	}
+
+	if (server->cipher_type && !rc) {
+		rc = smb3_crypto_aead_allocate(server);
+		if (rc)
+			cifs_server_dbg(VFS, "%s: crypto alloc failed, rc=%d\n", __func__, rc);
+	}
 neg_exit:
 	free_rsp_buf(resp_buftype, rsp);
 	return rc;
-- 
2.43.0




