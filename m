Return-Path: <stable+bounces-184593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 339FFBD42BB
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC30B506927
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3C530F93E;
	Mon, 13 Oct 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lmzI2Qlt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2630CDA6;
	Mon, 13 Oct 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367882; cv=none; b=AH/lkYphMDemN9wJrbG9UhBZMYbu++FUeMB9Cyl57+CZeQ5yTFDCPp/3qgIJQ3fqZ2qx3SeIigo6Il9NU5ZAfNtMxX88QDI0xJi6mA1KyPYM+3p4zUuP/u8A455Guf4DFSoF3H/3T2HFvSMr8Slp3mTwzy9j1CMKaSNVD7/IEWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367882; c=relaxed/simple;
	bh=ZzB6Y15FPA4rS5JYsQHrEC2zjVmCNIqkBsd0+fpnQZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOqTx8EBhnfQ88YJMBCeE64ZxS92fGYcFLO2S/QIlyOAcZxBLtROl9k72h+2mbKP0yzGX8Khhzf3D6p+UvxfxsNJ0e3C4oTAe5YxqBphEQFGAQlpbnBixQyFF3MuRkGeSv9XBzn2x/+KFmQSiw4dXFRi0mKCzyGH5KO5QrrnJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lmzI2Qlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B73AC4CEE7;
	Mon, 13 Oct 2025 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367881;
	bh=ZzB6Y15FPA4rS5JYsQHrEC2zjVmCNIqkBsd0+fpnQZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmzI2QltAIqd1YRtDJNO5L5vh7A/bkKwNHaxTWA8YRIPfMsTf01RWO2ItiX0g8CFf
	 oykdpJuqjZDeqaFomM5Z5PLsq9cV4VRLkx8lamG/40Y/RRl1n5JcmEKJSjCJGdAJ3Q
	 mdnENNh6RIkwceJLMa17H26OnhmEsFpYxjxQSX1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 165/196] smb: client: fix crypto buffers in non-linear memory
Date: Mon, 13 Oct 2025 16:45:56 +0200
Message-ID: <20251013144321.279222570@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
References: <20251013144315.184275491@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enzo Matsumiya <ematsumiya@suse.de>

[ Upstream commit 998a67b954680f26f3734040aeeed08642d49721 ]

The crypto API, through the scatterlist API, expects input buffers to be
in linear memory.  We handle this with the cifs_sg_set_buf() helper
that converts vmalloc'd memory to their corresponding pages.

However, when we allocate our aead_request buffer (@creq in
smb2ops.c::crypt_message()), we do so with kvzalloc(), which possibly
puts aead_request->__ctx in vmalloc area.

AEAD algorithm then uses ->__ctx for its private/internal data and
operations, and uses sg_set_buf() for such data on a few places.

This works fine as long as @creq falls into kmalloc zone (small
requests) or vmalloc'd memory is still within linear range.

Tasks' stacks are vmalloc'd by default (CONFIG_VMAP_STACK=y), so too
many tasks will increment the base stacks' addresses to a point where
virt_addr_valid(buf) will fail (BUG() in sg_set_buf()) when that
happens.

In practice: too many parallel reads and writes on an encrypted mount
will trigger this bug.

To fix this, always alloc @creq with kmalloc() instead.
Also drop the @sensitive_size variable/arguments since
kfree_sensitive() doesn't need it.

Backtrace:

[  945.272081] ------------[ cut here ]------------
[  945.272774] kernel BUG at include/linux/scatterlist.h:209!
[  945.273520] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
[  945.274412] CPU: 7 UID: 0 PID: 56 Comm: kworker/u33:0 Kdump: loaded Not tainted 6.15.0-lku-11779-g8e9d6efccdd7-dirty #1 PREEMPT(voluntary)
[  945.275736] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
[  945.276877] Workqueue: writeback wb_workfn (flush-cifs-2)
[  945.277457] RIP: 0010:crypto_gcm_init_common+0x1f9/0x220
[  945.278018] Code: b0 00 00 00 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 c7 c0 00 00 00 80 48 2b 05 5c 58 e5 00 e9 58 ff ff ff <0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 0f 0b 48 c7 04 24 01 00 00 00 48 8b
[  945.279992] RSP: 0018:ffffc90000a27360 EFLAGS: 00010246
[  945.280578] RAX: 0000000000000000 RBX: ffffc90001d85060 RCX: 0000000000000030
[  945.281376] RDX: 0000000000080000 RSI: 0000000000000000 RDI: ffffc90081d85070
[  945.282145] RBP: ffffc90001d85010 R08: ffffc90001d85000 R09: 0000000000000000
[  945.282898] R10: ffffc90001d85090 R11: 0000000000001000 R12: ffffc90001d85070
[  945.283656] R13: ffff888113522948 R14: ffffc90001d85060 R15: ffffc90001d85010
[  945.284407] FS:  0000000000000000(0000) GS:ffff8882e66cf000(0000) knlGS:0000000000000000
[  945.285262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  945.285884] CR2: 00007fa7ffdd31f4 CR3: 000000010540d000 CR4: 0000000000350ef0
[  945.286683] Call Trace:
[  945.286952]  <TASK>
[  945.287184]  ? crypt_message+0x33f/0xad0 [cifs]
[  945.287719]  crypto_gcm_encrypt+0x36/0xe0
[  945.288152]  crypt_message+0x54a/0xad0 [cifs]
[  945.288724]  smb3_init_transform_rq+0x277/0x300 [cifs]
[  945.289300]  smb_send_rqst+0xa3/0x160 [cifs]
[  945.289944]  cifs_call_async+0x178/0x340 [cifs]
[  945.290514]  ? __pfx_smb2_writev_callback+0x10/0x10 [cifs]
[  945.291177]  smb2_async_writev+0x3e3/0x670 [cifs]
[  945.291759]  ? find_held_lock+0x32/0x90
[  945.292212]  ? netfs_advance_write+0xf2/0x310
[  945.292723]  netfs_advance_write+0xf2/0x310
[  945.293210]  netfs_write_folio+0x346/0xcc0
[  945.293689]  ? __pfx__raw_spin_unlock_irq+0x10/0x10
[  945.294250]  netfs_writepages+0x117/0x460
[  945.294724]  do_writepages+0xbe/0x170
[  945.295152]  ? find_held_lock+0x32/0x90
[  945.295600]  ? kvm_sched_clock_read+0x11/0x20
[  945.296103]  __writeback_single_inode+0x56/0x4b0
[  945.296643]  writeback_sb_inodes+0x229/0x550
[  945.297140]  __writeback_inodes_wb+0x4c/0xe0
[  945.297642]  wb_writeback+0x2f1/0x3f0
[  945.298069]  wb_workfn+0x300/0x490
[  945.298472]  process_one_work+0x1fe/0x590
[  945.298949]  worker_thread+0x1ce/0x3c0
[  945.299397]  ? __pfx_worker_thread+0x10/0x10
[  945.299900]  kthread+0x119/0x210
[  945.300285]  ? __pfx_kthread+0x10/0x10
[  945.300729]  ret_from_fork+0x119/0x1b0
[  945.301163]  ? __pfx_kthread+0x10/0x10
[  945.301601]  ret_from_fork_asm+0x1a/0x30
[  945.302055]  </TASK>

Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than a page list")
Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index b74f769047394..ee6a6ba13f89c 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4152,7 +4152,7 @@ fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, unsigned int orig_len,
 static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct smb_rqst *rqst,
 				 int num_rqst, const u8 *sig, u8 **iv,
 				 struct aead_request **req, struct sg_table *sgt,
-				 unsigned int *num_sgs, size_t *sensitive_size)
+				 unsigned int *num_sgs)
 {
 	unsigned int req_size = sizeof(**req) + crypto_aead_reqsize(tfm);
 	unsigned int iv_size = crypto_aead_ivsize(tfm);
@@ -4169,9 +4169,8 @@ static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct smb_rqst
 	len += req_size;
 	len = ALIGN(len, __alignof__(struct scatterlist));
 	len += array_size(*num_sgs, sizeof(struct scatterlist));
-	*sensitive_size = len;
 
-	p = kvzalloc(len, GFP_NOFS);
+	p = kzalloc(len, GFP_NOFS);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
@@ -4185,16 +4184,14 @@ static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct smb_rqst
 
 static void *smb2_get_aead_req(struct crypto_aead *tfm, struct smb_rqst *rqst,
 			       int num_rqst, const u8 *sig, u8 **iv,
-			       struct aead_request **req, struct scatterlist **sgl,
-			       size_t *sensitive_size)
+			       struct aead_request **req, struct scatterlist **sgl)
 {
 	struct sg_table sgtable = {};
 	unsigned int skip, num_sgs, i, j;
 	ssize_t rc;
 	void *p;
 
-	p = smb2_aead_req_alloc(tfm, rqst, num_rqst, sig, iv, req, &sgtable,
-				&num_sgs, sensitive_size);
+	p = smb2_aead_req_alloc(tfm, rqst, num_rqst, sig, iv, req, &sgtable, &num_sgs);
 	if (IS_ERR(p))
 		return ERR_CAST(p);
 
@@ -4283,7 +4280,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	DECLARE_CRYPTO_WAIT(wait);
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
-	size_t sensitive_size;
 
 	rc = smb2_get_enc_key(server, le64_to_cpu(tr_hdr->SessionId), enc, key);
 	if (rc) {
@@ -4309,8 +4305,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 		return rc;
 	}
 
-	creq = smb2_get_aead_req(tfm, rqst, num_rqst, sign, &iv, &req, &sg,
-				 &sensitive_size);
+	creq = smb2_get_aead_req(tfm, rqst, num_rqst, sign, &iv, &req, &sg);
 	if (IS_ERR(creq))
 		return PTR_ERR(creq);
 
@@ -4340,7 +4335,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	if (!rc && enc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
 
-	kvfree_sensitive(creq, sensitive_size);
+	kfree_sensitive(creq);
 	return rc;
 }
 
-- 
2.51.0




