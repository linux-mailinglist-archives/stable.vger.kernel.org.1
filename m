Return-Path: <stable+bounces-241356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF/+Aj5+72lKBwEAu9opvQ
	(envelope-from <stable+bounces-241356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:18:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA63475062
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9B37301B054
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717EA3B6367;
	Mon, 27 Apr 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ERWODKkR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11DC3B5837;
	Mon, 27 Apr 2026 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302775; cv=none; b=FPa2IZM8VnJdkfvDdLRu9/0GvyTx9TNhqcQHCig6KimY1MqHkADrfQ2WrUZW2pcgNO3Vf/7j3tor4Ksy9nSs22LEP3ynwXwG2cPxAt2cWXpc62IO68kn65MFTdvXrUEaT1vM3mLQPSR2uVdCzBDaoeZ0v0lRYULtW0XhitXUNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302775; c=relaxed/simple;
	bh=dCyRfzCeQVFwFFRCILeK6cfZSRU1u6f6iGqlIkf0cQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+tYr+9Y8oMvHJOjI7jQ03/tvd8WvPFOtBxs2a6RupYOZkG3Ffq2ER+eU4eSNHZycgqwMzn4nkEtjT6RVMDTPbsUm0yuB7BYGPIjOEaB/25oHASzor/Ep/FJZ0TwpEFUp2NSMb+pk/owZ2geZHOWr9cT8ZxFZiJHpyj5swCX3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ERWODKkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A359C2BCB4;
	Mon, 27 Apr 2026 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777302774;
	bh=dCyRfzCeQVFwFFRCILeK6cfZSRU1u6f6iGqlIkf0cQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERWODKkRuc1xR5KG0udZm/5783+J8D2nvpFridONgxucVQ2QCM4guo+IEiLDqkixu
	 +YlFWxESWMZSfpbyuYUebT/Ugfxyu4H9zTSTLGWamwUJ68fRhCTXqfVSNKrpYB/4Jr
	 n9BmIW3bvI5BT1BfudCFNjRiK/OMFwopPycX0Dwg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.0.2
Date: Mon, 27 Apr 2026 09:12:16 -0600
Message-ID: <2026042716-vitally-apron-a3ff@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026042716-hamster-implement-77c1@gregkh>
References: <2026042716-hamster-implement-77c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CEA63475062
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241356-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]

diff --git a/Makefile b/Makefile
index edd04bdf3a39..b17ca865bcee 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 0
-SUBLEVEL = 1
+SUBLEVEL = 2
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/crypto/authencesn.c b/crypto/authencesn.c
index c0a01d738d9b..af3d584e584f 100644
--- a/crypto/authencesn.c
+++ b/crypto/authencesn.c
@@ -228,9 +228,11 @@ static int crypto_authenc_esn_decrypt_tail(struct aead_request *req,
 
 decrypt:
 
-	if (src != dst)
-		src = scatterwalk_ffwd(areq_ctx->src, src, assoclen);
 	dst = scatterwalk_ffwd(areq_ctx->dst, dst, assoclen);
+	if (req->src == req->dst)
+		src = dst;
+	else
+		src = scatterwalk_ffwd(areq_ctx->src, src, assoclen);
 
 	skcipher_request_set_tfm(skreq, ctx->enc);
 	skcipher_request_set_callback(skreq, flags,
diff --git a/crypto/krb5enc.c b/crypto/krb5enc.c
index a1de55994d92..fefa8d2c7532 100644
--- a/crypto/krb5enc.c
+++ b/crypto/krb5enc.c
@@ -39,12 +39,6 @@ struct krb5enc_request_ctx {
 	char tail[];
 };
 
-static void krb5enc_request_complete(struct aead_request *req, int err)
-{
-	if (err != -EINPROGRESS)
-		aead_request_complete(req, err);
-}
-
 /**
  * crypto_krb5enc_extractkeys - Extract Ke and Ki keys from the key blob.
  * @keys: Where to put the key sizes and pointers
@@ -127,7 +121,7 @@ static void krb5enc_encrypt_done(void *data, int err)
 {
 	struct aead_request *req = data;
 
-	krb5enc_request_complete(req, err);
+	aead_request_complete(req, err);
 }
 
 /*
@@ -154,7 +148,7 @@ static int krb5enc_dispatch_encrypt(struct aead_request *req,
 		dst = scatterwalk_ffwd(areq_ctx->dst, req->dst, req->assoclen);
 
 	skcipher_request_set_tfm(skreq, enc);
-	skcipher_request_set_callback(skreq, aead_request_flags(req),
+	skcipher_request_set_callback(skreq, flags,
 				      krb5enc_encrypt_done, req);
 	skcipher_request_set_crypt(skreq, src, dst, req->cryptlen, req->iv);
 
@@ -188,13 +182,16 @@ static void krb5enc_encrypt_ahash_done(void *data, int err)
 	struct ahash_request *ahreq = (void *)(areq_ctx->tail + ictx->reqoff);
 
 	if (err)
-		return krb5enc_request_complete(req, err);
+		goto out;
 
 	krb5enc_insert_checksum(req, ahreq->result);
 
 	err = krb5enc_dispatch_encrypt(req, 0);
-	if (err != -EINPROGRESS)
-		aead_request_complete(req, err);
+	if (err == -EINPROGRESS)
+		return;
+
+out:
+	aead_request_complete(req, err);
 }
 
 /*
@@ -264,17 +261,16 @@ static void krb5enc_decrypt_hash_done(void *data, int err)
 {
 	struct aead_request *req = data;
 
-	if (err)
-		return krb5enc_request_complete(req, err);
-
-	err = krb5enc_verify_hash(req);
-	krb5enc_request_complete(req, err);
+	if (!err)
+		err = krb5enc_verify_hash(req);
+	aead_request_complete(req, err);
 }
 
 /*
  * Dispatch the hashing of the plaintext after we've done the decryption.
  */
-static int krb5enc_dispatch_decrypt_hash(struct aead_request *req)
+static int krb5enc_dispatch_decrypt_hash(struct aead_request *req,
+					 unsigned int flags)
 {
 	struct crypto_aead *krb5enc = crypto_aead_reqtfm(req);
 	struct aead_instance *inst = aead_alg_instance(krb5enc);
@@ -290,7 +286,7 @@ static int krb5enc_dispatch_decrypt_hash(struct aead_request *req)
 	ahash_request_set_tfm(ahreq, auth);
 	ahash_request_set_crypt(ahreq, req->dst, hash,
 				req->assoclen + req->cryptlen - authsize);
-	ahash_request_set_callback(ahreq, aead_request_flags(req),
+	ahash_request_set_callback(ahreq, flags,
 				   krb5enc_decrypt_hash_done, req);
 
 	err = crypto_ahash_digest(ahreq);
@@ -300,6 +296,21 @@ static int krb5enc_dispatch_decrypt_hash(struct aead_request *req)
 	return krb5enc_verify_hash(req);
 }
 
+static void krb5enc_decrypt_done(void *data, int err)
+{
+	struct aead_request *req = data;
+
+	if (err)
+		goto out;
+
+	err = krb5enc_dispatch_decrypt_hash(req, 0);
+	if (err == -EINPROGRESS)
+		return;
+
+out:
+	aead_request_complete(req, err);
+}
+
 /*
  * Dispatch the decryption of the ciphertext.
  */
@@ -323,7 +334,7 @@ static int krb5enc_dispatch_decrypt(struct aead_request *req)
 
 	skcipher_request_set_tfm(skreq, ctx->enc);
 	skcipher_request_set_callback(skreq, aead_request_flags(req),
-				      req->base.complete, req->base.data);
+				      krb5enc_decrypt_done, req);
 	skcipher_request_set_crypt(skreq, src, dst,
 				   req->cryptlen - authsize, req->iv);
 
@@ -338,7 +349,7 @@ static int krb5enc_decrypt(struct aead_request *req)
 	if (err < 0)
 		return err;
 
-	return krb5enc_dispatch_decrypt_hash(req);
+	return krb5enc_dispatch_decrypt_hash(req, aead_request_flags(req));
 }
 
 static int krb5enc_init_tfm(struct crypto_aead *tfm)
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index aebf4dad545e..c16bb7d7067b 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1860,7 +1860,10 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
 
 	ret = __sev_do_cmd_locked(SEV_CMD_PEK_CSR, &data, &argp->error);
 
-	 /* If we query the CSR length, FW responded with expected data. */
+	/*
+	 * Firmware will returns the length of the CSR blob (either the minimum
+	 * required length or the actual length written), return it to the user.
+	 */
 	input.length = data.len;
 
 	if (copy_to_user((void __user *)argp->data, &input, sizeof(input))) {
@@ -1868,6 +1871,9 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
 		goto e_free_blob;
 	}
 
+	if (ret || WARN_ON_ONCE(argp->error))
+		goto e_free_blob;
+
 	if (blob) {
 		if (copy_to_user(input_address, blob, input.length))
 			ret = -EFAULT;
@@ -2218,6 +2224,9 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd *argp)
 		goto e_free;
 	}
 
+	if (ret || WARN_ON_ONCE(argp->error))
+		goto e_free;
+
 	if (id_blob) {
 		if (copy_to_user(input_address, id_blob, data.len)) {
 			ret = -EFAULT;
@@ -2334,7 +2343,10 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 
 	ret = __sev_do_cmd_locked(SEV_CMD_PDH_CERT_EXPORT, &data, &argp->error);
 
-	/* If we query the length, FW responded with expected data. */
+	/*
+	 * Firmware will return the length of the blobs (either the minimum
+	 * required length or the actual length written), return 'em to the user.
+	 */
 	input.cert_chain_len = data.cert_chain_len;
 	input.pdh_cert_len = data.pdh_cert_len;
 
@@ -2343,6 +2355,9 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 		goto e_free_cert;
 	}
 
+	if (ret || WARN_ON_ONCE(argp->error))
+		goto e_free_cert;
+
 	if (pdh_blob) {
 		if (copy_to_user(input_pdh_cert_address,
 				 pdh_blob, input.pdh_cert_len)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 569c5a89ff10..124fb38eb465 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -22,7 +22,7 @@
  */
 #include "amdgpu_ids.h"
 
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/dma-fence-array.h>
 
 
@@ -40,8 +40,8 @@
  * VMs are looked up from the PASID per amdgpu_device.
  */
 
-static DEFINE_IDR(amdgpu_pasid_idr);
-static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
+static DEFINE_XARRAY_FLAGS(amdgpu_pasid_xa, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1);
+static u32 amdgpu_pasid_xa_next;
 
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
@@ -62,36 +62,37 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
-	int pasid;
+	u32 pasid;
+	int r;
 
 	if (bits == 0)
 		return -EINVAL;
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	/* TODO: Need to replace the idr with an xarry, and then
-	 * handle the internal locking with ATOMIC safe paths.
-	 */
-	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_ATOMIC);
-	spin_unlock(&amdgpu_pasid_idr_lock);
-
-	if (pasid >= 0)
-		trace_amdgpu_pasid_allocated(pasid);
+	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+			    XA_LIMIT(1, (1U << bits) - 1),
+			    &amdgpu_pasid_xa_next, GFP_KERNEL);
+	if (r < 0)
+		return r;
 
+	trace_amdgpu_pasid_allocated(pasid);
 	return pasid;
 }
 
 /**
  * amdgpu_pasid_free - Free a PASID
  * @pasid: PASID to free
+ *
+ * Called in IRQ context.
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
+
 	trace_amdgpu_pasid_freed(pasid);
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	__xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -634,7 +635,5 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
  */
 void amdgpu_pasid_mgr_cleanup(void)
 {
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_destroy(&amdgpu_pasid_idr);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_destroy(&amdgpu_pasid_xa);
 }
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 5856975f32e1..c19400701467 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -386,7 +386,6 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
 
 	if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
 		return -EFAULT;
-	/* vtl0_mem.last_pfn is excluded in the pagemap range for VTL0 as per design */
 	if (vtl0_mem.last_pfn <= vtl0_mem.start_pfn) {
 		dev_err(vtl->module_dev, "range start pfn (%llx) > end pfn (%llx)\n",
 			vtl0_mem.start_pfn, vtl0_mem.last_pfn);
@@ -397,6 +396,10 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
 	if (!pgmap)
 		return -ENOMEM;
 
+	/*
+	 * vtl0_mem.last_pfn is excluded in the pagemap range for VTL0 as per design.
+	 * last_pfn is not reserved or wasted, and reflects 'start_pfn + size' of pagemap range.
+	 */
 	pgmap->ranges[0].start = PFN_PHYS(vtl0_mem.start_pfn);
 	pgmap->ranges[0].end = PFN_PHYS(vtl0_mem.last_pfn) - 1;
 	pgmap->nr_range = 1;
@@ -405,8 +408,11 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
 	/*
 	 * Determine the highest page order that can be used for the given memory range.
 	 * This works best when the range is aligned; i.e. both the start and the length.
+	 * Clamp to MAX_FOLIO_ORDER to avoid a WARN in memremap_pages() when the range
+	 * alignment exceeds the maximum supported folio order for this kernel config.
 	 */
-	pgmap->vmemmap_shift = count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn);
+	pgmap->vmemmap_shift = min(count_trailing_zeros(vtl0_mem.start_pfn | vtl0_mem.last_pfn),
+				   MAX_FOLIO_ORDER);
 	dev_dbg(vtl->module_dev,
 		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page order: %lu\n",
 		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap->vmemmap_shift);
@@ -415,7 +421,7 @@ static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user *arg)
 	if (IS_ERR(addr)) {
 		dev_err(vtl->module_dev, "devm_memremap_pages error: %ld\n", PTR_ERR(addr));
 		kfree(pgmap);
-		return -EFAULT;
+		return PTR_ERR(addr);
 	}
 
 	/* Don't free pgmap, since it has to stick around until the memory
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index b0e24ee724e4..36567fc17dcc 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -64,10 +64,7 @@ const fn th1520_pwm_fp(n: u32) -> usize {
 fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
     const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
 
-    (match ns.checked_mul(rate_hz) {
-        Some(product) => product,
-        None => u64::MAX,
-    }) / NSEC_PER_SEC_U64
+    ns.saturating_mul(rate_hz) / NSEC_PER_SEC_U64
 }
 
 fn cycles_to_ns(cycles: u64, rate_hz: u64) -> u64 {
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 8c76400ba631..aa8ba4cdfe34 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1491,10 +1491,10 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 
 	f2fs_compress_free_page(page);
 
-	dec_page_count(sbi, type);
-
-	if (atomic_dec_return(&cic->pending_pages))
+	if (atomic_dec_return(&cic->pending_pages)) {
+		dec_page_count(sbi, type);
 		return;
+	}
 
 	for (i = 0; i < cic->nr_rpages; i++) {
 		WARN_ON(!cic->rpages[i]);
@@ -1504,6 +1504,14 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 
 	page_array_free(sbi, cic->rpages, cic->nr_rpages);
 	kmem_cache_free(cic_entry_slab, cic);
+
+	/*
+	 * Make sure dec_page_count() is the last access to sbi.
+	 * Once it drops the F2FS_WB_CP_DATA counter to zero, the
+	 * unmount thread can proceed to destroy sbi and
+	 * sbi->page_array_slab.
+	 */
+	dec_page_count(sbi, type);
 }
 
 static int f2fs_write_raw_pages(struct compress_ctx *cc,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 338df7a2aea6..adc8befe119a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -173,7 +173,8 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		while (nr_pages--)
 			dec_page_count(F2FS_F_SB(folio), __read_io_type(folio));
 
-		if (F2FS_F_SB(folio)->node_inode && is_node_folio(folio) &&
+		if (bio->bi_status == BLK_STS_OK &&
+			F2FS_F_SB(folio)->node_inode && is_node_folio(folio) &&
 			f2fs_sanity_check_node_footer(F2FS_F_SB(folio),
 				folio, folio->index, NODE_TYPE_REGULAR, true))
 			bio->bi_status = BLK_STS_IOERR;
@@ -386,6 +387,8 @@ static void f2fs_write_end_io(struct bio *bio)
 				folio->index, NODE_TYPE_REGULAR, true);
 			f2fs_bug_on(sbi, folio->index != nid_of_node(folio));
 		}
+		if (f2fs_in_warm_node_list(sbi, folio))
+			f2fs_del_fsync_node_entry(sbi, folio);
 
 		dec_page_count(sbi, type);
 
@@ -397,8 +400,6 @@ static void f2fs_write_end_io(struct bio *bio)
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
-		if (f2fs_in_warm_node_list(sbi, folio))
-			f2fs_del_fsync_node_entry(sbi, folio);
 		folio_clear_f2fs_gcing(folio);
 		folio_end_writeback(folio);
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bb34e864d0ef..65c0d20df3a4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3989,7 +3989,7 @@ bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
-bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
 void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e360f08a9586..6ef21deeef1c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -964,6 +964,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			return err;
 
 		err = f2fs_create_whiteout(idmap, old_dir, &whiteout, &fname);
+		f2fs_free_filename(&fname);
 		if (err)
 			return err;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6a97fe76712b..8390994a8826 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1880,7 +1880,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
  *
  * Return true if issued all discard cmd or no discard cmd need issue, otherwise return false.
  */
-bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_policy dpolicy;
@@ -1897,7 +1897,7 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
 	/* just to make sure there is no pending discard commands */
 	__wait_all_discard_cmd(sbi, NULL);
 
-	f2fs_bug_on(sbi, atomic_read(&dcc->discard_cmd_cnt));
+	f2fs_bug_on(sbi, need_check && atomic_read(&dcc->discard_cmd_cnt));
 	return !dropped;
 }
 
@@ -2367,7 +2367,7 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 	 * Recovery can cache discard commands, so in error path of
 	 * fill_super(), it needs to give a chance to handle them.
 	 */
-	f2fs_issue_discard_timeout(sbi);
+	f2fs_issue_discard_timeout(sbi, true);
 
 	kfree(dcc);
 	SM_I(sbi)->dcc_info = NULL;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8774c60b4be4..40079fd7886b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2009,7 +2009,7 @@ static void f2fs_put_super(struct super_block *sb)
 	}
 
 	/* be sure to wait for any on-going discard commands */
-	done = f2fs_issue_discard_timeout(sbi);
+	done = f2fs_issue_discard_timeout(sbi, true);
 	if (f2fs_realtime_discard_enable(sbi) && !sbi->discard_blks && done) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
@@ -2152,7 +2152,7 @@ static int f2fs_unfreeze(struct super_block *sb)
 	 * will recover after removal of snapshot.
 	 */
 	if (test_opt(sbi, DISCARD) && !f2fs_hw_support_discard(sbi))
-		f2fs_issue_discard_timeout(sbi);
+		f2fs_issue_discard_timeout(sbi, true);
 
 	clear_sbi_flag(F2FS_SB(sb), SBI_IS_FREEZING);
 	return 0;
@@ -2957,7 +2957,12 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 			need_stop_discard = true;
 		} else {
 			f2fs_stop_discard_thread(sbi);
-			f2fs_issue_discard_timeout(sbi);
+			/*
+			 * f2fs_ioc_fitrim() won't race w/ "remount ro"
+			 * so it's safe to check discard_cmd_cnt in
+			 * f2fs_issue_discard_timeout().
+			 */
+			f2fs_issue_discard_timeout(sbi, flags & SB_RDONLY);
 			need_restart_discard = true;
 		}
 	}
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3c75ee025bda..d63baa1b6fec 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -570,28 +570,30 @@ void inode_switch_wbs_work_fn(struct work_struct *work)
 	struct inode_switch_wbs_context *isw, *next_isw;
 	struct llist_node *list;
 
+	list = llist_del_all(&new_wb->switch_wbs_ctxs);
 	/*
-	 * Grab out reference to wb so that it cannot get freed under us
+	 * Nothing to do? That would be a problem as references held by isw
+	 * items protect wb from freeing...
+	 */
+	if (WARN_ON_ONCE(!list))
+		return;
+
+	/*
+	 * Grab our reference to wb so that it cannot get freed under us
 	 * after we process all the isw items.
 	 */
 	wb_get(new_wb);
-	while (1) {
-		list = llist_del_all(&new_wb->switch_wbs_ctxs);
-		/* Nothing to do? */
-		if (!list)
-			break;
-		/*
-		 * In addition to synchronizing among switchers, I_WB_SWITCH
-		 * tells the RCU protected stat update paths to grab the i_page
-		 * lock so that stat transfer can synchronize against them.
-		 * Let's continue after I_WB_SWITCH is guaranteed to be
-		 * visible.
-		 */
-		synchronize_rcu();
+	/*
+	 * In addition to synchronizing among switchers, I_WB_SWITCH
+	 * tells the RCU protected stat update paths to grab the i_page
+	 * lock so that stat transfer can synchronize against them.
+	 * Let's continue after I_WB_SWITCH is guaranteed to be
+	 * visible.
+	 */
+	synchronize_rcu();
 
-		llist_for_each_entry_safe(isw, next_isw, list, list)
-			process_inode_switch_wbs(new_wb, isw);
-	}
+	llist_for_each_entry_safe(isw, next_isw, list, list)
+		process_inode_switch_wbs(new_wb, isw);
 	wb_put(new_wb);
 }
 
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 140bd5730d99..f902a7fb4630 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -121,7 +121,7 @@ static ssize_t fuse_conn_max_background_write(struct file *file,
 					      const char __user *buf,
 					      size_t count, loff_t *ppos)
 {
-	unsigned val;
+	unsigned int val = 0;
 	ssize_t ret;
 
 	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
@@ -163,7 +163,7 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 						    const char __user *buf,
 						    size_t count, loff_t *ppos)
 {
-	unsigned val;
+	unsigned int val = 0;
 	struct fuse_conn *fc;
 	ssize_t ret;
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0b0241f47170..24ee9e870263 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -570,6 +570,11 @@ static void request_wait_answer(struct fuse_req *req)
 		if (!err)
 			return;
 
+		if (req->args->abort_on_kill) {
+			fuse_abort_conn(fc);
+			return;
+		}
+
 		if (test_bit(FR_URING, &req->flags))
 			removed = fuse_uring_remove_pending_req(req);
 		else
@@ -676,7 +681,8 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 			fuse_force_creds(req);
 
 		__set_bit(FR_WAITING, &req->flags);
-		__set_bit(FR_FORCE, &req->flags);
+		if (!args->abort_on_kill)
+			__set_bit(FR_FORCE, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
 		req = fuse_get_req(idmap, fm, false);
@@ -1011,6 +1017,9 @@ static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop
 	folio_clear_uptodate(newfolio);
 	folio_clear_mappedtodisk(newfolio);
 
+	if (folio_test_large(newfolio))
+		goto out_fallback_unlock;
+
 	if (fuse_check_folio(newfolio) != 0)
 		goto out_fallback_unlock;
 
@@ -2590,9 +2599,8 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 
 static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 {
-	int res;
 	int oldfd;
-	struct fuse_dev *fud = NULL;
+	struct fuse_dev *fud;
 
 	if (get_user(oldfd, argp))
 		return -EFAULT;
@@ -2605,17 +2613,15 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	 * Check against file->f_op because CUSE
 	 * uses the same ioctl handler.
 	 */
-	if (fd_file(f)->f_op == file->f_op)
-		fud = __fuse_get_dev(fd_file(f));
+	if (fd_file(f)->f_op != file->f_op)
+		return -EINVAL;
 
-	res = -EINVAL;
-	if (fud) {
-		mutex_lock(&fuse_mutex);
-		res = fuse_device_clone(fud->fc, file);
-		mutex_unlock(&fuse_mutex);
-	}
+	fud = fuse_get_dev(fd_file(f));
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
 
-	return res;
+	guard(mutex)(&fuse_mutex);
+	return fuse_device_clone(fud->fc, file);
 }
 
 static long fuse_dev_ioctl_backing_open(struct file *file,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..23a241f18623 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -345,6 +345,7 @@ struct fuse_args {
 	bool is_ext:1;
 	bool is_pinned:1;
 	bool invalidate_vmap:1;
+	bool abort_on_kill:1;
 	struct fuse_in_arg in_args[4];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c795abe47a4f..bc05c9479f57 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1551,6 +1551,7 @@ int fuse_send_init(struct fuse_mount *fm)
 	int err;
 
 	if (fm->fc->sync_init) {
+		ia->args.abort_on_kill = true;
 		err = fuse_simple_request(fm, &ia->args);
 		/* Ignore size of init reply */
 		if (err > 0)
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..aae657fd56c0 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -41,6 +41,10 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	unsigned int offset;
 	void *addr;
 
+	/* Dirent doesn't fit in readdir cache page?  Skip caching. */
+	if (reclen > PAGE_SIZE)
+		return;
+
 	spin_lock(&fi->rdc.lock);
 	/*
 	 * Is cache already completed?  Or this entry does not go at the end of
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 272e45276143..037df47fa9f3 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2791,13 +2791,14 @@ static inline bool check_file_record(const struct MFT_REC *rec,
 	u16 fn = le16_to_cpu(rec->rhdr.fix_num);
 	u16 ao = le16_to_cpu(rec->attr_off);
 	u32 rs = sbi->record_size;
+	u32 used = le32_to_cpu(rec->used);
 
 	/* Check the file record header for consistency. */
 	if (rec->rhdr.sign != NTFS_FILE_SIGNATURE ||
 	    fo > (SECTOR_SIZE - ((rs >> SECTOR_SHIFT) + 1) * sizeof(short)) ||
 	    (fn - 1) * SECTOR_SIZE != rs || ao < MFTRECORD_FIXUP_OFFSET_1 ||
 	    ao > sbi->record_size - SIZEOF_RESIDENT || !is_rec_inuse(rec) ||
-	    le32_to_cpu(rec->total) != rs) {
+	    le32_to_cpu(rec->total) != rs || used > rs || used < ao) {
 		return false;
 	}
 
@@ -2809,6 +2810,15 @@ static inline bool check_file_record(const struct MFT_REC *rec,
 		return false;
 	}
 
+	/*
+	 * The do_action() handlers compute memmove lengths as
+	 * "rec->used - <offset of validated attr>", which underflows when
+	 * rec->used is smaller than the attribute walk reached.  At this
+	 * point attr is the ATTR_END marker; rec->used must cover it.
+	 */
+	if (used < PtrOffset(rec, attr) + sizeof(attr->type))
+		return false;
+
 	return true;
 }
 
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index c920039d733c..4ec204d2c774 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -758,6 +758,77 @@ static void dump_ace(struct smb_ace *pace, char *end_of_acl)
 }
 #endif
 
+static int validate_dacl(struct smb_acl *pdacl, char *end_of_acl)
+{
+	int i, ace_hdr_size, ace_size, min_ace_size;
+	u16 dacl_size, num_aces;
+	char *acl_base, *end_of_dacl;
+	struct smb_ace *pace;
+
+	if (!pdacl)
+		return 0;
+
+	if (end_of_acl < (char *)pdacl + sizeof(struct smb_acl)) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	dacl_size = le16_to_cpu(pdacl->size);
+	if (dacl_size < sizeof(struct smb_acl) ||
+	    end_of_acl < (char *)pdacl + dacl_size) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	num_aces = le16_to_cpu(pdacl->num_aces);
+	if (!num_aces)
+		return 0;
+
+	ace_hdr_size = offsetof(struct smb_ace, sid) +
+		offsetof(struct smb_sid, sub_auth);
+	min_ace_size = ace_hdr_size + sizeof(__le32);
+	if (num_aces > (dacl_size - sizeof(struct smb_acl)) / min_ace_size) {
+		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+		return -EINVAL;
+	}
+
+	end_of_dacl = (char *)pdacl + dacl_size;
+	acl_base = (char *)pdacl;
+	ace_size = sizeof(struct smb_acl);
+
+	for (i = 0; i < num_aces; ++i) {
+		if (end_of_dacl - acl_base < ace_size) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+
+		pace = (struct smb_ace *)(acl_base + ace_size);
+		acl_base = (char *)pace;
+
+		if (end_of_dacl - acl_base < ace_hdr_size ||
+		    pace->sid.num_subauth == 0 ||
+		    pace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+
+		ace_size = ace_hdr_size + sizeof(__le32) * pace->sid.num_subauth;
+		if (end_of_dacl - acl_base < ace_size ||
+		    le16_to_cpu(pace->size) < ace_size) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+
+		ace_size = le16_to_cpu(pace->size);
+		if (end_of_dacl - acl_base < ace_size) {
+			cifs_dbg(VFS, "ACL too small to parse ACE\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 		       struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 		       struct cifs_fattr *fattr, bool mode_from_special_sid)
@@ -765,7 +836,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	int i;
 	u16 num_aces = 0;
 	int acl_size;
-	char *acl_base;
+	char *acl_base, *end_of_dacl;
 	struct smb_ace **ppace;
 
 	/* BB need to add parm so we can store the SID BB */
@@ -777,12 +848,8 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 		return;
 	}
 
-	/* validate that we do not go past end of acl */
-	if (end_of_acl < (char *)pdacl + sizeof(struct smb_acl) ||
-	    end_of_acl < (char *)pdacl + le16_to_cpu(pdacl->size)) {
-		cifs_dbg(VFS, "ACL too small to parse DACL\n");
+	if (validate_dacl(pdacl, end_of_acl))
 		return;
-	}
 
 	cifs_dbg(NOISY, "DACL revision %d size %d num aces %d\n",
 		 le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
@@ -793,6 +860,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	   user/group/other have no permissions */
 	fattr->cf_mode &= ~(0777);
 
+	end_of_dacl = (char *)pdacl + le16_to_cpu(pdacl->size);
 	acl_base = (char *)pdacl;
 	acl_size = sizeof(struct smb_acl);
 
@@ -800,37 +868,18 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	if (num_aces > 0) {
 		umode_t denied_mode = 0;
 
-		if (num_aces > (le16_to_cpu(pdacl->size) - sizeof(struct smb_acl)) /
-				(offsetof(struct smb_ace, sid) +
-				 offsetof(struct smb_sid, sub_auth) + sizeof(__le16)))
-			return;
-
 		ppace = kmalloc_objs(struct smb_ace *, num_aces);
 		if (!ppace)
 			return;
 
 		for (i = 0; i < num_aces; ++i) {
-			if (end_of_acl - acl_base < acl_size)
-				break;
-
 			ppace[i] = (struct smb_ace *) (acl_base + acl_size);
-			acl_base = (char *)ppace[i];
-			acl_size = offsetof(struct smb_ace, sid) +
-				offsetof(struct smb_sid, sub_auth);
-
-			if (end_of_acl - acl_base < acl_size ||
-			    ppace[i]->sid.num_subauth == 0 ||
-			    ppace[i]->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
-			    (end_of_acl - acl_base <
-			     acl_size + sizeof(__le32) * ppace[i]->sid.num_subauth) ||
-			    (le16_to_cpu(ppace[i]->size) <
-			     acl_size + sizeof(__le32) * ppace[i]->sid.num_subauth))
-				break;
 
 #ifdef CONFIG_CIFS_DEBUG2
-			dump_ace(ppace[i], end_of_acl);
+			dump_ace(ppace[i], end_of_dacl);
 #endif
 			if (mode_from_special_sid &&
+			    ppace[i]->sid.num_subauth >= 3 &&
 			    (compare_sids(&(ppace[i]->sid),
 					  &sid_unix_NFS_mode) == 0)) {
 				/*
@@ -870,6 +919,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 				(void *)ppace[i],
 				sizeof(struct smb_ace)); */
 
+			acl_base = (char *)ppace[i];
 			acl_size = le16_to_cpu(ppace[i]->size);
 		}
 
@@ -1293,10 +1343,9 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
 		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
-		if (end_of_acl < (char *)dacl_ptr + le16_to_cpu(dacl_ptr->size)) {
-			cifs_dbg(VFS, "Server returned illegal ACL size\n");
-			return -EINVAL;
-		}
+		rc = validate_dacl(dacl_ptr, end_of_acl);
+		if (rc)
+			return rc;
 	}
 
 	owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
@@ -1662,6 +1711,12 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
 			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
+			rc = validate_dacl(dacl_ptr, (char *)pntsd + secdesclen);
+			if (rc) {
+				kfree(pntsd);
+				cifs_put_tlink(tlink);
+				return rc;
+			}
 			if (mode_from_sid)
 				nsecdesclen +=
 					le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 69b38f0ccf2b..e9eeb9f8a561 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3610,7 +3610,6 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx)
 	server = mnt_ctx->server;
 	ctx = mnt_ctx->fs_ctx;
 	cifs_sb = mnt_ctx->cifs_sb;
-	sbflags = cifs_sb_flags(cifs_sb);
 
 	/* search for existing tcon to this server share */
 	tcon = cifs_get_tcon(mnt_ctx->ses, ctx);
@@ -3625,9 +3624,10 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx)
 	 * path (i.e., do not remap / and \ and do not map any special characters)
 	 */
 	if (tcon->posix_extensions) {
-		sbflags |= CIFS_MOUNT_POSIX_PATHS;
-		sbflags &= ~(CIFS_MOUNT_MAP_SFM_CHR |
-			     CIFS_MOUNT_MAP_SPECIAL_CHR);
+		atomic_or(CIFS_MOUNT_POSIX_PATHS, &cifs_sb->mnt_cifs_flags);
+		atomic_andnot(CIFS_MOUNT_MAP_SFM_CHR |
+			      CIFS_MOUNT_MAP_SPECIAL_CHR,
+			      &cifs_sb->mnt_cifs_flags);
 	}
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
@@ -3651,6 +3651,7 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx)
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 		tcon->unix_ext = 0; /* server does not support them */
 
+	sbflags = cifs_sb_flags(cifs_sb);
 	/* do not care if a following call succeed - informational */
 	if (!tcon->pipe && server->ops->qfs_tcon) {
 		server->ops->qfs_tcon(mnt_ctx->xid, tcon, cifs_sb);
@@ -3675,7 +3676,6 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx)
 
 out:
 	mnt_ctx->tcon = tcon;
-	atomic_set(&cifs_sb->mnt_cifs_flags, sbflags);
 	return rc;
 }
 
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 9694117050a6..e198e3dda917 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -49,7 +49,6 @@ void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
 
 	if (!CIFSSMBQFSUnixInfo(xid, tcon)) {
 		__u64 cap = le64_to_cpu(tcon->fsUnixInfo.Capability);
-		unsigned int sbflags;
 
 		cifs_dbg(FYI, "unix caps which server supports %lld\n", cap);
 		/*
@@ -76,29 +75,27 @@ void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
 		if (cap & CIFS_UNIX_TRANSPORT_ENCRYPTION_MANDATORY_CAP)
 			cifs_dbg(VFS, "per-share encryption not supported yet\n");
 
-		if (cifs_sb)
-			sbflags = cifs_sb_flags(cifs_sb);
-
 		cap &= CIFS_UNIX_CAP_MASK;
 		if (ctx && ctx->no_psx_acl)
 			cap &= ~CIFS_UNIX_POSIX_ACL_CAP;
 		else if (CIFS_UNIX_POSIX_ACL_CAP & cap) {
 			cifs_dbg(FYI, "negotiated posix acl support\n");
-			if (cifs_sb)
-				sbflags |= CIFS_MOUNT_POSIXACL;
+			if (cifs_sb) {
+				atomic_or(CIFS_MOUNT_POSIXACL,
+					  &cifs_sb->mnt_cifs_flags);
+			}
 		}
 
 		if (ctx && ctx->posix_paths == 0)
 			cap &= ~CIFS_UNIX_POSIX_PATHNAMES_CAP;
 		else if (cap & CIFS_UNIX_POSIX_PATHNAMES_CAP) {
 			cifs_dbg(FYI, "negotiate posix pathnames\n");
-			if (cifs_sb)
-				sbflags |= CIFS_MOUNT_POSIX_PATHS;
+			if (cifs_sb) {
+				atomic_or(CIFS_MOUNT_POSIX_PATHS,
+					  &cifs_sb->mnt_cifs_flags);
+			}
 		}
 
-		if (cifs_sb)
-			atomic_set(&cifs_sb->mnt_cifs_flags, sbflags);
-
 		cifs_dbg(FYI, "Negotiate caps 0x%x\n", (int)cap);
 #ifdef CONFIG_CIFS_DEBUG2
 		if (cap & CIFS_UNIX_FCNTL_CAP)
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 509fcea28a42..3600705255f8 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1783,6 +1783,12 @@ smb2_ioctl_query_info(const unsigned int xid,
 		qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
 		if (le32_to_cpu(qi_rsp->OutputBufferLength) < qi.input_buffer_length)
 			qi.input_buffer_length = le32_to_cpu(qi_rsp->OutputBufferLength);
+		if (qi.input_buffer_length > 0 &&
+		    struct_size(qi_rsp, Buffer, qi.input_buffer_length) >
+		    rsp_iov[1].iov_len) {
+			rc = -EFAULT;
+			goto out;
+		}
 		if (copy_to_user(&pqi->input_buffer_length,
 				 &qi.input_buffer_length,
 				 sizeof(qi.input_buffer_length))) {
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 26cfce344861..48f0c51740cf 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -237,7 +237,7 @@ int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id)
 {
 	struct ksmbd_conn *conn;
 	int rc, retry_count = 0, max_timeout = 120;
-	int rcount = 1, bkt;
+	int rcount, bkt;
 
 retry_idle:
 	if (retry_count >= max_timeout)
@@ -246,8 +246,7 @@ int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id)
 	down_read(&conn_list_lock);
 	hash_for_each(conn_list, bkt, conn, hlist) {
 		if (conn->binding || xa_load(&conn->sessions, sess_id)) {
-			if (conn == curr_conn)
-				rcount = 2;
+			rcount = (conn == curr_conn) ? 2 : 1;
 			if (atomic_read(&conn->req_running) >= rcount) {
 				rc = wait_event_timeout(conn->req_running_q,
 					atomic_read(&conn->req_running) < rcount,
diff --git a/fs/smb/server/mgmt/user_config.c b/fs/smb/server/mgmt/user_config.c
index a3183fe5c536..cf45841d9d1b 100644
--- a/fs/smb/server/mgmt/user_config.c
+++ b/fs/smb/server/mgmt/user_config.c
@@ -56,12 +56,6 @@ struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp,
 		goto err_free;
 
 	if (resp_ext) {
-		if (resp_ext->ngroups > NGROUPS_MAX) {
-			pr_err("ngroups(%u) from login response exceeds max groups(%d)\n",
-					resp_ext->ngroups, NGROUPS_MAX);
-			goto err_free;
-		}
-
 		user->sgid = kmemdup(resp_ext->____payload,
 				     resp_ext->ngroups * sizeof(gid_t),
 				     KSMBD_DEFAULT_GFP);
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 39be2d2be86c..a86589408835 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -382,12 +382,10 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
 		return;
 
 	delete_proc_session(sess);
-
+	ksmbd_tree_conn_session_logoff(sess);
+	ksmbd_destroy_file_table(sess);
 	if (sess->user)
 		ksmbd_free_user(sess->user);
-
-	ksmbd_tree_conn_session_logoff(sess);
-	ksmbd_destroy_file_table(&sess->file_table);
 	ksmbd_launch_ksmbd_durable_scavenger();
 	ksmbd_session_rpc_clear_list(sess);
 	free_channel_list(sess);
@@ -618,7 +616,7 @@ void destroy_previous_session(struct ksmbd_conn *conn,
 		goto out;
 	}
 
-	ksmbd_destroy_file_table(&prev_sess->file_table);
+	ksmbd_destroy_file_table(prev_sess);
 	prev_sess->state = SMB2_SESSION_EXPIRED;
 	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_SETUP);
 	ksmbd_launch_ksmbd_durable_scavenger();
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 9b2bb8764a80..cd3f28b0e7cb 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1841,6 +1841,7 @@ int smb2_check_durable_oplock(struct ksmbd_conn *conn,
 			      struct ksmbd_share_config *share,
 			      struct ksmbd_file *fp,
 			      struct lease_ctx_info *lctx,
+			      struct ksmbd_user *user,
 			      char *name)
 {
 	struct oplock_info *opinfo = opinfo_get(fp);
@@ -1849,6 +1850,12 @@ int smb2_check_durable_oplock(struct ksmbd_conn *conn,
 	if (!opinfo)
 		return 0;
 
+	if (ksmbd_vfs_compare_durable_owner(fp, user) == false) {
+		ksmbd_debug(SMB, "Durable handle reconnect failed: owner mismatch\n");
+		ret = -EBADF;
+		goto out;
+	}
+
 	if (opinfo->is_lease == false) {
 		if (lctx) {
 			pr_err("create context include lease\n");
diff --git a/fs/smb/server/oplock.h b/fs/smb/server/oplock.h
index 921e3199e4df..d91a8266e065 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -126,5 +126,6 @@ int smb2_check_durable_oplock(struct ksmbd_conn *conn,
 			      struct ksmbd_share_config *share,
 			      struct ksmbd_file *fp,
 			      struct lease_ctx_info *lctx,
+			      struct ksmbd_user *user,
 			      char *name);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a344937595f4..135c74e6c4be 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3013,7 +3013,8 @@ int smb2_open(struct ksmbd_work *work)
 		}
 
 		if (dh_info.reconnected == true) {
-			rc = smb2_check_durable_oplock(conn, share, dh_info.fp, lc, name);
+			rc = smb2_check_durable_oplock(conn, share, dh_info.fp,
+					lc, sess->user, name);
 			if (rc) {
 				ksmbd_put_durable_fd(dh_info.fp);
 				goto err_out2;
@@ -4821,6 +4822,8 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		/* align next xattr entry at 4 byte bundary */
 		alignment_bytes = ((next_offset + 3) & ~3) - next_offset;
 		if (alignment_bytes) {
+			if (buf_free_len < alignment_bytes)
+				break;
 			memset(ptr, '\0', alignment_bytes);
 			ptr += alignment_bytes;
 			next_offset += alignment_bytes;
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 061a305bf9c8..4bbc2c27e680 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -596,6 +596,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 	struct smb_sid *sid;
 	struct smb_ace *ntace;
 	int i, j;
+	u16 ace_sz;
 
 	if (!fattr->cf_acls)
 		goto posix_default_acl;
@@ -640,8 +641,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 			flags = 0x03;
 
 		ntace = (struct smb_ace *)((char *)pndace + *size);
-		*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
+		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
 				pace->e_perm, 0777);
+		if (check_add_overflow(*size, ace_sz, size))
+			break;
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
@@ -650,8 +653,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		if (S_ISDIR(fattr->cf_mode) &&
 		    (pace->e_tag == ACL_USER || pace->e_tag == ACL_GROUP)) {
 			ntace = (struct smb_ace *)((char *)pndace + *size);
-			*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
+			ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
 					0x03, pace->e_perm, 0777);
+			if (check_add_overflow(*size, ace_sz, size))
+				break;
 			(*num_aces)++;
 			if (pace->e_tag == ACL_USER)
 				ntace->access_req |=
@@ -691,8 +696,10 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 		}
 
 		ntace = (struct smb_ace *)((char *)pndace + *size);
-		*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
+		ace_sz = fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
 				pace->e_perm, 0777);
+		if (check_add_overflow(*size, ace_sz, size))
+			break;
 		(*num_aces)++;
 		if (pace->e_tag == ACL_USER)
 			ntace->access_req |=
@@ -728,7 +735,8 @@ static void set_ntacl_dacl(struct mnt_idmap *idmap,
 				break;
 
 			memcpy((char *)pndace + size, ntace, nt_ace_size);
-			size += nt_ace_size;
+			if (check_add_overflow(size, nt_ace_size, &size))
+				break;
 			aces_size -= nt_ace_size;
 			ntace = (struct smb_ace *)((char *)ntace + nt_ace_size);
 			num_aces++;
@@ -1106,8 +1114,24 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		goto free_parent_pntsd;
 	}
 
-	aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2,
-			    KSMBD_DEFAULT_GFP);
+	aces_size = pdacl_size - sizeof(struct smb_acl);
+
+	/*
+	 * Validate num_aces against the DACL payload before allocating.
+	 * Each ACE must be at least as large as its fixed-size header
+	 * (up to the SID base), so num_aces cannot exceed the payload
+	 * divided by the minimum ACE size.  This mirrors the existing
+	 * check in parse_dacl().
+	 */
+	if (num_aces > aces_size / (offsetof(struct smb_ace, sid) +
+				    offsetof(struct smb_sid, sub_auth) +
+				    sizeof(__le16))) {
+		rc = -EINVAL;
+		goto free_parent_pntsd;
+	}
+
+	aces_base = kmalloc_array(num_aces * 2, sizeof(struct smb_ace),
+				  KSMBD_DEFAULT_GFP);
 	if (!aces_base) {
 		rc = -ENOMEM;
 		goto free_parent_pntsd;
@@ -1116,7 +1140,6 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	aces = (struct smb_ace *)aces_base;
 	parent_aces = (struct smb_ace *)((char *)parent_pdacl +
 			sizeof(struct smb_acl));
-	aces_size = acl_len - sizeof(struct smb_acl);
 
 	if (pntsd_type & DACL_AUTO_INHERITED)
 		inherited_flags = INHERITED_ACE;
@@ -1124,11 +1147,14 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	for (i = 0; i < num_aces; i++) {
 		int pace_size;
 
-		if (offsetof(struct smb_ace, access_req) > aces_size)
+		if (aces_size < offsetof(struct smb_ace, sid) +
+		    CIFS_SID_BASE_SIZE)
 			break;
 
 		pace_size = le16_to_cpu(parent_aces->size);
-		if (pace_size > aces_size)
+		if (pace_size > aces_size ||
+		    pace_size < offsetof(struct smb_ace, sid) +
+				CIFS_SID_BASE_SIZE)
 			break;
 
 		aces_size -= pace_size;
@@ -1342,10 +1368,13 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = acl_size - sizeof(struct smb_acl);
 		for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-			if (offsetof(struct smb_ace, access_req) > aces_size)
+			if (offsetof(struct smb_ace, sid) +
+			    aces_size < CIFS_SID_BASE_SIZE)
 				break;
 			ace_size = le16_to_cpu(ace->size);
-			if (ace_size > aces_size)
+			if (ace_size > aces_size ||
+			    ace_size < offsetof(struct smb_ace, sid) +
+				       CIFS_SID_BASE_SIZE)
 				break;
 			aces_size -= ace_size;
 			granted |= le32_to_cpu(ace->access_req);
@@ -1360,13 +1389,19 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = acl_size - sizeof(struct smb_acl);
 	for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-		if (offsetof(struct smb_ace, access_req) > aces_size)
+		if (offsetof(struct smb_ace, sid) +
+		    aces_size < CIFS_SID_BASE_SIZE)
 			break;
 		ace_size = le16_to_cpu(ace->size);
-		if (ace_size > aces_size)
+		if (ace_size > aces_size ||
+		    ace_size < offsetof(struct smb_ace, sid) +
+			       CIFS_SID_BASE_SIZE)
 			break;
 		aces_size -= ace_size;
 
+		if (ace->sid.num_subauth > SID_MAX_SUB_AUTHORITIES)
+			break;
+
 		if (!compare_sids(&sid, &ace->sid) ||
 		    !compare_sids(&sid_unix_NFS_mode, &ace->sid)) {
 			found = 1;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 2dbabe2d8005..1c5645238bd3 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -13,6 +13,7 @@
 #include <net/genetlink.h>
 #include <linux/socket.h>
 #include <linux/workqueue.h>
+#include <linux/overflow.h>
 
 #include "vfs_cache.h"
 #include "transport_ipc.h"
@@ -497,7 +498,9 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 	{
 		struct ksmbd_rpc_command *resp = entry->response;
 
-		msg_sz = sizeof(struct ksmbd_rpc_command) + resp->payload_sz;
+		if (check_add_overflow(sizeof(struct ksmbd_rpc_command),
+				       resp->payload_sz, &msg_sz))
+			return -EINVAL;
 		break;
 	}
 	case KSMBD_EVENT_SPNEGO_AUTHEN_REQUEST:
@@ -516,8 +519,9 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 			if (resp->payload_sz < resp->veto_list_sz)
 				return -EINVAL;
 
-			msg_sz = sizeof(struct ksmbd_share_config_response) +
-					resp->payload_sz;
+			if (check_add_overflow(sizeof(struct ksmbd_share_config_response),
+					       resp->payload_sz, &msg_sz))
+				return -EINVAL;
 		}
 		break;
 	}
@@ -526,6 +530,12 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 		struct ksmbd_login_response_ext *resp = entry->response;
 
 		if (resp->ngroups) {
+			if (resp->ngroups < 0 ||
+			    resp->ngroups > NGROUPS_MAX) {
+				pr_err("ngroups(%d) from login response exceeds max groups(%d)\n",
+				       resp->ngroups, NGROUPS_MAX);
+				return -EINVAL;
+			}
 			msg_sz = sizeof(struct ksmbd_login_response_ext) +
 					resp->ngroups * sizeof(gid_t);
 		}
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 7e29b06820e2..13b711ea575d 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -183,6 +183,8 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 	t = alloc_transport(client_sk);
 	if (!t) {
 		sock_release(client_sk);
+		if (server_conf.max_connections)
+			atomic_dec(&active_num_conn);
 		return -ENOMEM;
 	}
 
@@ -279,7 +281,7 @@ static int ksmbd_kthread_fn(void *p)
 
 skip_max_ip_conns_limit:
 		if (server_conf.max_connections &&
-		    atomic_inc_return(&active_num_conn) >= server_conf.max_connections) {
+		    atomic_inc_return(&active_num_conn) > server_conf.max_connections) {
 			pr_info_ratelimited("Limit the maximum number of connections(%u)\n",
 					    atomic_read(&active_num_conn));
 			atomic_dec(&active_num_conn);
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 168f2dd7e200..3551f01a3fa0 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -19,6 +19,7 @@
 #include "misc.h"
 #include "mgmt/tree_connect.h"
 #include "mgmt/user_session.h"
+#include "mgmt/user_config.h"
 #include "smb_common.h"
 #include "server.h"
 #include "smb2pdu.h"
@@ -463,9 +464,11 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 	 * there are not accesses to fp->lock_list.
 	 */
 	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
-		spin_lock(&fp->conn->llist_lock);
-		list_del(&smb_lock->clist);
-		spin_unlock(&fp->conn->llist_lock);
+		if (!list_empty(&smb_lock->clist) && fp->conn) {
+			spin_lock(&fp->conn->llist_lock);
+			list_del(&smb_lock->clist);
+			spin_unlock(&fp->conn->llist_lock);
+		}
 
 		list_del(&smb_lock->flist);
 		locks_free_lock(smb_lock->fl);
@@ -474,6 +477,8 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 
 	if (ksmbd_stream_fd(fp))
 		kfree(fp->stream.name);
+	kfree(fp->owner.name);
+
 	kmem_cache_free(filp_cache, fp);
 }
 
@@ -785,11 +790,13 @@ void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
 }
 
 static int
-__close_file_table_ids(struct ksmbd_file_table *ft,
+__close_file_table_ids(struct ksmbd_session *sess,
 		       struct ksmbd_tree_connect *tcon,
 		       bool (*skip)(struct ksmbd_tree_connect *tcon,
-				    struct ksmbd_file *fp))
+				    struct ksmbd_file *fp,
+				    struct ksmbd_user *user))
 {
+	struct ksmbd_file_table *ft = &sess->file_table;
 	struct ksmbd_file *fp;
 	unsigned int id = 0;
 	int num = 0;
@@ -802,7 +809,7 @@ __close_file_table_ids(struct ksmbd_file_table *ft,
 			break;
 		}
 
-		if (skip(tcon, fp) ||
+		if (skip(tcon, fp, sess->user) ||
 		    !atomic_dec_and_test(&fp->refcount)) {
 			id++;
 			write_unlock(&ft->lock);
@@ -854,7 +861,8 @@ static inline bool is_reconnectable(struct ksmbd_file *fp)
 }
 
 static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
-			       struct ksmbd_file *fp)
+			       struct ksmbd_file *fp,
+			       struct ksmbd_user *user)
 {
 	return fp->tcon != tcon;
 }
@@ -989,16 +997,74 @@ void ksmbd_stop_durable_scavenger(void)
 	kthread_stop(server_conf.dh_task);
 }
 
+/*
+ * ksmbd_vfs_copy_durable_owner - Copy owner info for durable reconnect
+ * @fp: ksmbd file pointer to store owner info
+ * @user: user pointer to copy from
+ *
+ * This function binds the current user's identity to the file handle
+ * to satisfy MS-SMB2 Step 8 (SecurityContext matching) during reconnect.
+ *
+ * Return: 0 on success, or negative error code on failure
+ */
+static int ksmbd_vfs_copy_durable_owner(struct ksmbd_file *fp,
+		struct ksmbd_user *user)
+{
+	if (!user)
+		return -EINVAL;
+
+	/* Duplicate the user name to ensure identity persistence */
+	fp->owner.name = kstrdup(user->name, GFP_KERNEL);
+	if (!fp->owner.name)
+		return -ENOMEM;
+
+	fp->owner.uid = user->uid;
+	fp->owner.gid = user->gid;
+
+	return 0;
+}
+
+/**
+ * ksmbd_vfs_compare_durable_owner - Verify if the requester is original owner
+ * @fp: existing ksmbd file pointer
+ * @user: user pointer of the reconnect requester
+ *
+ * Compares the UID, GID, and name of the current requester against the
+ * original owner stored in the file handle.
+ *
+ * Return: true if the user matches, false otherwise
+ */
+bool ksmbd_vfs_compare_durable_owner(struct ksmbd_file *fp,
+		struct ksmbd_user *user)
+{
+	if (!user || !fp->owner.name)
+		return false;
+
+	/* Check if the UID and GID match first (fast path) */
+	if (fp->owner.uid != user->uid || fp->owner.gid != user->gid)
+		return false;
+
+	/* Validate the account name to ensure the same SecurityContext */
+	if (strcmp(fp->owner.name, user->name))
+		return false;
+
+	return true;
+}
+
 static bool session_fd_check(struct ksmbd_tree_connect *tcon,
-			     struct ksmbd_file *fp)
+			     struct ksmbd_file *fp, struct ksmbd_user *user)
 {
 	struct ksmbd_inode *ci;
 	struct oplock_info *op;
 	struct ksmbd_conn *conn;
+	struct ksmbd_lock *smb_lock, *tmp_lock;
 
 	if (!is_reconnectable(fp))
 		return false;
 
+	if (ksmbd_vfs_copy_durable_owner(fp, user))
+		return false;
+
 	conn = fp->conn;
 	ci = fp->f_ci;
 	down_write(&ci->m_lock);
@@ -1011,6 +1077,12 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	}
 	up_write(&ci->m_lock);
 
+	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
+		spin_lock(&fp->conn->llist_lock);
+		list_del_init(&smb_lock->clist);
+		spin_unlock(&fp->conn->llist_lock);
+	}
+
 	fp->conn = NULL;
 	fp->tcon = NULL;
 	fp->volatile_id = KSMBD_NO_FID;
@@ -1024,7 +1096,7 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
 {
-	int num = __close_file_table_ids(&work->sess->file_table,
+	int num = __close_file_table_ids(work->sess,
 					 work->tcon,
 					 tree_conn_fd_check);
 
@@ -1033,7 +1105,7 @@ void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
 
 void ksmbd_close_session_fds(struct ksmbd_work *work)
 {
-	int num = __close_file_table_ids(&work->sess->file_table,
+	int num = __close_file_table_ids(work->sess,
 					 work->tcon,
 					 session_fd_check);
 
@@ -1090,6 +1162,9 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 {
 	struct ksmbd_inode *ci;
 	struct oplock_info *op;
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_lock *smb_lock;
+	unsigned int old_f_state;
 
 	if (!fp->is_durable || fp->conn || fp->tcon) {
 		pr_err("Invalid durable fd [%p:%p]\n", fp->conn, fp->tcon);
@@ -1101,9 +1176,23 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 		return -EBADF;
 	}
 
-	fp->conn = work->conn;
+	old_f_state = fp->f_state;
+	fp->f_state = FP_NEW;
+	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
+	if (!has_file_id(fp->volatile_id)) {
+		fp->f_state = old_f_state;
+		return -EBADF;
+	}
+
+	fp->conn = conn;
 	fp->tcon = work->tcon;
 
+	list_for_each_entry(smb_lock, &fp->lock_list, flist) {
+		spin_lock(&conn->llist_lock);
+		list_add_tail(&smb_lock->clist, &conn->lock_list);
+		spin_unlock(&conn->llist_lock);
+	}
+
 	ci = fp->f_ci;
 	down_write(&ci->m_lock);
 	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry) {
@@ -1114,13 +1203,10 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	}
 	up_write(&ci->m_lock);
 
-	fp->f_state = FP_NEW;
-	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
-	if (!has_file_id(fp->volatile_id)) {
-		fp->conn = NULL;
-		fp->tcon = NULL;
-		return -EBADF;
-	}
+	fp->owner.uid = fp->owner.gid = 0;
+	kfree(fp->owner.name);
+	fp->owner.name = NULL;
+
 	return 0;
 }
 
@@ -1135,12 +1221,14 @@ int ksmbd_init_file_table(struct ksmbd_file_table *ft)
 	return 0;
 }
 
-void ksmbd_destroy_file_table(struct ksmbd_file_table *ft)
+void ksmbd_destroy_file_table(struct ksmbd_session *sess)
 {
+	struct ksmbd_file_table *ft = &sess->file_table;
+
 	if (!ft->idr)
 		return;
 
-	__close_file_table_ids(ft, NULL, session_fd_check);
+	__close_file_table_ids(sess, NULL, session_fd_check);
 	idr_destroy(ft->idr);
 	kfree(ft->idr);
 	ft->idr = NULL;
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 78b506c5ef03..866f32c10d4d 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -68,6 +68,13 @@ enum {
 	FP_CLOSED
 };
 
+/* Owner information for durable handle reconnect */
+struct durable_owner {
+	unsigned int uid;
+	unsigned int gid;
+	char *name;
+};
+
 struct ksmbd_file {
 	struct file			*filp;
 	u64				persistent_id;
@@ -114,6 +121,7 @@ struct ksmbd_file {
 	bool				is_resilient;
 
 	bool                            is_posix_ctxt;
+	struct durable_owner		owner;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
@@ -140,7 +148,7 @@ static inline bool ksmbd_stream_fd(struct ksmbd_file *fp)
 }
 
 int ksmbd_init_file_table(struct ksmbd_file_table *ft);
-void ksmbd_destroy_file_table(struct ksmbd_file_table *ft);
+void ksmbd_destroy_file_table(struct ksmbd_session *sess);
 int ksmbd_close_fd(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_fd_fast(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id);
@@ -166,6 +174,8 @@ void ksmbd_free_global_file_table(void);
 void ksmbd_set_fd_limit(unsigned long limit);
 void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
 			 unsigned int state);
+bool ksmbd_vfs_compare_durable_owner(struct ksmbd_file *fp,
+		struct ksmbd_user *user);
 
 /*
  * INODE hash
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index e0645a34b55b..32ff92b6342b 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -357,7 +357,7 @@ struct mshv_vtl_sint_post_msg {
 
 struct mshv_vtl_ram_disposition {
 	__u64 start_pfn;
-	__u64 last_pfn;
+	__u64 last_pfn; /* last_pfn is excluded from the range [start_pfn, last_pfn) */
 };
 
 struct mshv_vtl_set_poll_file {
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index bb2d88205e5a..7bbefa8a422f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2717,7 +2717,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 {
 	struct sk_buff *skb = NULL;
 	struct net_device *dev;
-	struct virtio_net_hdr *vnet_hdr = NULL;
+	struct virtio_net_hdr vnet_hdr;
+	bool has_vnet_hdr = false;
 	struct sockcm_cookie sockc;
 	__be16 proto;
 	int err, reserve = 0;
@@ -2818,16 +2819,20 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		hlen = LL_RESERVED_SPACE(dev);
 		tlen = dev->needed_tailroom;
 		if (vnet_hdr_sz) {
-			vnet_hdr = data;
 			data += vnet_hdr_sz;
 			tp_len -= vnet_hdr_sz;
-			if (tp_len < 0 ||
-			    __packet_snd_vnet_parse(vnet_hdr, tp_len)) {
+			if (tp_len < 0) {
+				tp_len = -EINVAL;
+				goto tpacket_error;
+			}
+			memcpy(&vnet_hdr, data - vnet_hdr_sz, sizeof(vnet_hdr));
+			if (__packet_snd_vnet_parse(&vnet_hdr, tp_len)) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
 			copylen = __virtio16_to_cpu(vio_le(),
-						    vnet_hdr->hdr_len);
+						    vnet_hdr.hdr_len);
+			has_vnet_hdr = true;
 		}
 		copylen = max_t(int, copylen, dev->hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
@@ -2864,12 +2869,12 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			}
 		}
 
-		if (vnet_hdr_sz) {
-			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
+		if (has_vnet_hdr) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
-			virtio_net_hdr_set_proto(skb, vnet_hdr);
+			virtio_net_hdr_set_proto(skb, &vnet_hdr);
 		}
 
 		skb->destructor = tpacket_destruct_skb;
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 6301d79ee35a..3ec3d89fdf14 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -502,6 +502,10 @@ static int rxrpc_preparse(struct key_preparsed_payload *prep)
 	if (v1->security_index != RXRPC_SECURITY_RXKAD)
 		goto error;
 
+	ret = -EKEYREJECTED;
+	if (v1->ticket_length > AFSTOKEN_RK_TIX_MAX)
+		goto error;
+
 	plen = sizeof(*token->kad) + v1->ticket_length;
 	prep->quotalen += plen + sizeof(*token);
 
diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
index 15d585c80798..1b129b118b0f 100644
--- a/scripts/dtc/dtc-lexer.l
+++ b/scripts/dtc/dtc-lexer.l
@@ -39,8 +39,6 @@ extern bool treesource_error;
 #define DPRINT(fmt, ...)	do { } while (0)
 #endif
 
-static int dts_version = 1;
-
 #define BEGIN_DEFAULT()		DPRINT("<V1>\n"); \
 				BEGIN(V1); \
 
@@ -101,7 +99,6 @@ static void PRINTF(1, 2) lexical_error(const char *fmt, ...);
 
 <*>"/dts-v1/"	{
 			DPRINT("Keyword: /dts-v1/\n");
-			dts_version = 1;
 			BEGIN_DEFAULT();
 			return DT_V1;
 		}
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index bd42f06bb8ed..92543d4f91b5 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -188,6 +188,18 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     append_crate_with_generated("uapi", ["core", "ffi", "pin_init"])
     append_crate_with_generated("kernel", ["core", "macros", "build_error", "pin_init", "ffi", "bindings", "uapi"])
 
+    scripts = srctree / "scripts"
+    makefile = (scripts / "Makefile").read_text()
+    for path in scripts.glob("*.rs"):
+        name = path.stem
+        if f"{name}-rust" not in makefile:
+            continue
+        append_crate(
+            name,
+            path,
+            ["std"],
+        )
+
     def is_root_crate(build_file, target):
         try:
             contents = build_file.read_text()
@@ -204,7 +216,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     for folder in extra_dirs:
         for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
-            name = path.name.replace(".rs", "")
+            name = path.stem
 
             # Skip those that are not crate roots.
             if not is_root_crate(path.parent / "Makefile", name) and \
diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 45f9d6487388..ae74e1b69eb3 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7605,6 +7605,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x3802, "DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 3a71bab8a477..51177ebfb8c6 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -384,7 +384,7 @@ static void card_free(struct snd_card *card)
 	snd_usb_caiaq_input_free(cdev);
 #endif
 	snd_usb_caiaq_audio_free(cdev);
-	usb_reset_device(cdev->chip.dev);
+	usb_put_dev(cdev->chip.dev);
 }
 
 static int create_card(struct usb_device *usb_dev,
@@ -410,7 +410,7 @@ static int create_card(struct usb_device *usb_dev,
 		return err;
 
 	cdev = caiaqdev(card);
-	cdev->chip.dev = usb_dev;
+	cdev->chip.dev = usb_get_dev(usb_dev);
 	cdev->chip.card = card;
 	cdev->chip.usb_id = USB_ID(le16_to_cpu(usb_dev->descriptor.idVendor),
 				  le16_to_cpu(usb_dev->descriptor.idProduct));
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ac8c71ba9483..1ced9ba8be40 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1204,6 +1204,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->min = -11264; /* Mute under it */
 		}
 		break;
+	case USB_ID(0x31b2, 0x0111): /* MOONDROP JU Jiu */
+		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
+			usb_audio_info(chip,
+				       "set volume quirk for MOONDROP JU Jiu\n");
+			cval->min = -10880; /* Mute under it */
+		}
+		break;
 	}
 }
 

