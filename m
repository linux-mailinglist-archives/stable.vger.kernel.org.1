Return-Path: <stable+bounces-138431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF0FAA184C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525309A596E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76627253F0C;
	Tue, 29 Apr 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="igRPpR2/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303FA253B42;
	Tue, 29 Apr 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949229; cv=none; b=DhKPZE9MEYChUkLUR9YL9lUOOsKZQG/WUjBOlcs5tFc/MkDKQIVN09dz0wvY0xyQso4QSPWrglanBwZfl1/VyoQrWrsRBlaEX97Jg5kWuPzQIb/5opfsJSbYyy6Y5HgtUXI54V4taBzIW2ICJ3JQunti3hyNSetzIEZJi7CDHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949229; c=relaxed/simple;
	bh=Fp4vD70U5Jv2ZDe+Mt09BEQLCPBKwgIuK2kbF9V0zog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXNTRzhnwPtlqf6+GzWUobh89MK7C/58xpqzPPh03Eg0XLrY2L3e7Th6fQiko2BgqTRwXHUyRJxhGu+MSt5aZRfKXZ7EFdRmpHYfsVldgDja+8QFKV7ymo1e+Qa5OcA+bc9b3IfEc6QQ9rzs7cWmM7hqujA6QBdEBCdwYQbd/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=igRPpR2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B31C4CEE3;
	Tue, 29 Apr 2025 17:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949229;
	bh=Fp4vD70U5Jv2ZDe+Mt09BEQLCPBKwgIuK2kbF9V0zog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igRPpR2/oIdJzxfL+q+ogQ3zdOEVTPvSYrvPOmaRnj2FzuYSmzT8zIljS2GqH3A9p
	 xWs3Gd1JcQfsfygIqgyXS++8IMV1fVccLqB99cbKnsQEhdEuw2GT5BLcF3FRNyYoNI
	 aCZSmdFOTWyQNV1pBJmLQMG6piE9Czs48FcM9mA8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>,
	Jianqi Ren <jianqi.ren.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>
Subject: [PATCH 5.15 224/373] smb: client: fix UAF in async decryption
Date: Tue, 29 Apr 2025 18:41:41 +0200
Message-ID: <20250429161132.363035699@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enzo Matsumiya <ematsumiya@suse.de>

commit b0abcd65ec545701b8793e12bc27dc98042b151a upstream.

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
[In linux-5.15, dec and enc fields are named ccmaesdecrypt and ccmaesencrypt.]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/smb2ops.c |   48 ++++++++++++++++++++++++++++--------------------
 fs/cifs/smb2pdu.c |    6 ++++++
 2 files changed, 34 insertions(+), 20 deletions(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4541,7 +4541,7 @@ smb2_get_enc_key(struct TCP_Server_Info
  */
 static int
 crypt_message(struct TCP_Server_Info *server, int num_rqst,
-	      struct smb_rqst *rqst, int enc)
+	      struct smb_rqst *rqst, int enc, struct crypto_aead *tfm)
 {
 	struct smb2_transform_hdr *tr_hdr =
 		(struct smb2_transform_hdr *)rqst[0].rq_iov[0].iov_base;
@@ -4552,8 +4552,6 @@ crypt_message(struct TCP_Server_Info *se
 	u8 key[SMB3_ENC_DEC_KEY_SIZE];
 	struct aead_request *req;
 	u8 *iv;
-	DECLARE_CRYPTO_WAIT(wait);
-	struct crypto_aead *tfm;
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
 
@@ -4564,15 +4562,6 @@ crypt_message(struct TCP_Server_Info *se
 		return rc;
 	}
 
-	rc = smb3_crypto_aead_allocate(server);
-	if (rc) {
-		cifs_server_dbg(VFS, "%s: crypto alloc failed\n", __func__);
-		return rc;
-	}
-
-	tfm = enc ? server->secmech.ccmaesencrypt :
-						server->secmech.ccmaesdecrypt;
-
 	if ((server->cipher_type == SMB2_ENCRYPTION_AES256_CCM) ||
 		(server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
 		rc = crypto_aead_setkey(tfm, key, SMB3_GCM256_CRYPTKEY_SIZE);
@@ -4611,11 +4600,7 @@ crypt_message(struct TCP_Server_Info *se
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
@@ -4704,7 +4689,7 @@ smb3_init_transform_rq(struct TCP_Server
 	/* fill the 1st iov with a transform header */
 	fill_transform_hdr(tr_hdr, orig_len, old_rq, server->cipher_type);
 
-	rc = crypt_message(server, num_rqst, new_rq, 1);
+	rc = crypt_message(server, num_rqst, new_rq, 1, server->secmech.ccmaesencrypt);
 	cifs_dbg(FYI, "Encrypt message returned %d\n", rc);
 	if (rc)
 		goto err_free;
@@ -4730,8 +4715,9 @@ decrypt_raw_data(struct TCP_Server_Info
 		 unsigned int npages, unsigned int page_data_size,
 		 bool is_offloaded)
 {
-	struct kvec iov[2];
+	struct crypto_aead *tfm;
 	struct smb_rqst rqst = {NULL};
+	struct kvec iov[2];
 	int rc;
 
 	iov[0].iov_base = buf;
@@ -4746,9 +4732,31 @@ decrypt_raw_data(struct TCP_Server_Info
 	rqst.rq_pagesz = PAGE_SIZE;
 	rqst.rq_tailsz = (page_data_size % PAGE_SIZE) ? : PAGE_SIZE;
 
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
+		if (unlikely(!server->secmech.ccmaesdecrypt))
+			return -EIO;
+
+		tfm = server->secmech.ccmaesdecrypt;
+	}
+
+	rc = crypt_message(server, 1, &rqst, 0, tfm);
 	cifs_dbg(FYI, "Decrypt message returned %d\n", rc);
 
+	if (is_offloaded)
+		crypto_free_aead(tfm);
+
 	if (rc)
 		return rc;
 
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1063,6 +1063,12 @@ SMB2_negotiate(const unsigned int xid, s
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



