Return-Path: <stable+bounces-240415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIUtNoKo6WmzgQIAu9opvQ
	(envelope-from <stable+bounces-240415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 07:05:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D4F44D229
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 07:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57CA4301C3CB
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 05:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348129E113;
	Thu, 23 Apr 2026 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ge+4oGA1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A521E098
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920698; cv=none; b=Y0JgM8bbqFXtH/pX7mh2MZd8qryEJHa3N1nRlliAo/iBvMMZChRoXxDNVFpsCKSemOE+RaK804FPiMgtvR+NO89XUDqfmwCDJx1XQEvRbBJ5ozETNPf0tVtGC+ruyCUHDWFYuenwVnxCEEvp4aFQni7e4CEwUhZ7CYWgdWXAALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920698; c=relaxed/simple;
	bh=044Y19HSOZZ3yuBjVFalXQF1fKTNTNPVl3aFUaDOVmE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uK/WkJtJg6ISqJvO+pMVd9SlJ2oQdoYKaQnbYGPQuyB4WZO3JoHNICL8T1+gWlxwk16IXyL9RRdZvqOJqRYBb2noOW98t14Qa3Umi+RP6CjHvmHV5SvVGNkSHzQbtCqMv3F5qz5TTvEjyDhW/cki1QmiEVJHNt51yuLxybvJHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ge+4oGA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069FBC2BCB2;
	Thu, 23 Apr 2026 05:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776920698;
	bh=044Y19HSOZZ3yuBjVFalXQF1fKTNTNPVl3aFUaDOVmE=;
	h=Subject:To:Cc:From:Date:From;
	b=ge+4oGA11fv2lAbxycSotBC+LEBeqSE6jB0gs6LM277gUtENCKz+uz7K35UMBTiYv
	 oDTioOl0ksq6wFvRY51XrZsPzY+mW9LT4GSdIhACBwWdt56fMHL7bQTQr1vgRTuVLX
	 YKGsdBtbamNvskeWFzlT1569lnsWk8IP5RzAL8o0=
Subject: FAILED: patch "[PATCH] crypto: krb5enc - fix async decrypt skipping hash" failed to apply to 7.0-stable tree
To: phx0fer@gmail.com,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Apr 2026 07:04:55 +0200
Message-ID: <2026042355-fructose-married-6872@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240415-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,apana.org.au:email]
X-Rspamd-Queue-Id: 35D4F44D229
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 3bfbf5f0a99c991769ec562721285df7ab69240b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042355-fructose-married-6872@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3bfbf5f0a99c991769ec562721285df7ab69240b Mon Sep 17 00:00:00 2001
From: Dudu Lu <phx0fer@gmail.com>
Date: Mon, 20 Apr 2026 12:40:27 +0800
Subject: [PATCH] crypto: krb5enc - fix async decrypt skipping hash
 verification

krb5enc_dispatch_decrypt() sets req->base.complete as the skcipher
callback, which is the caller's own completion handler. When the
skcipher completes asynchronously, this signals "done" to the caller
without executing krb5enc_dispatch_decrypt_hash(), completely bypassing
the integrity verification (hash check).

Compare with the encrypt path which correctly uses
krb5enc_encrypt_done as an intermediate callback to chain into the
hash computation on async completion.

Fix by adding krb5enc_decrypt_done as an intermediate callback that
chains into krb5enc_dispatch_decrypt_hash() upon async skcipher
completion, matching the encrypt path's callback pattern.

Also fix EBUSY/EINPROGRESS handling throughout: remove
krb5enc_request_complete() which incorrectly swallowed EINPROGRESS
notifications that must be passed up to callers waiting on backlogged
requests, and add missing EBUSY checks in krb5enc_encrypt_ahash_done
for the dispatch_encrypt return value.

Fixes: d1775a177f7f ("crypto: Add 'krb5enc' hash and cipher AEAD algorithm")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>

Unset MAY_BACKLOG on the async completion path so the user won't
see back-to-back EINPROGRESS notifications.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/krb5enc.c b/crypto/krb5enc.c
index 1bfe8370cf94..fefa8d2c7532 100644
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
@@ -188,14 +182,16 @@ static void krb5enc_encrypt_ahash_done(void *data, int err)
 	struct ahash_request *ahreq = (void *)(areq_ctx->tail + ictx->reqoff);
 
 	if (err)
-		return krb5enc_request_complete(req, err);
+		goto out;
 
 	krb5enc_insert_checksum(req, ahreq->result);
 
-	err = krb5enc_dispatch_encrypt(req,
-				       aead_request_flags(req) & ~CRYPTO_TFM_REQ_MAY_SLEEP);
-	if (err != -EINPROGRESS)
-		aead_request_complete(req, err);
+	err = krb5enc_dispatch_encrypt(req, 0);
+	if (err == -EINPROGRESS)
+		return;
+
+out:
+	aead_request_complete(req, err);
 }
 
 /*
@@ -265,17 +261,16 @@ static void krb5enc_decrypt_hash_done(void *data, int err)
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
@@ -291,7 +286,7 @@ static int krb5enc_dispatch_decrypt_hash(struct aead_request *req)
 	ahash_request_set_tfm(ahreq, auth);
 	ahash_request_set_crypt(ahreq, req->dst, hash,
 				req->assoclen + req->cryptlen - authsize);
-	ahash_request_set_callback(ahreq, aead_request_flags(req),
+	ahash_request_set_callback(ahreq, flags,
 				   krb5enc_decrypt_hash_done, req);
 
 	err = crypto_ahash_digest(ahreq);
@@ -301,6 +296,21 @@ static int krb5enc_dispatch_decrypt_hash(struct aead_request *req)
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
@@ -324,7 +334,7 @@ static int krb5enc_dispatch_decrypt(struct aead_request *req)
 
 	skcipher_request_set_tfm(skreq, ctx->enc);
 	skcipher_request_set_callback(skreq, aead_request_flags(req),
-				      req->base.complete, req->base.data);
+				      krb5enc_decrypt_done, req);
 	skcipher_request_set_crypt(skreq, src, dst,
 				   req->cryptlen - authsize, req->iv);
 
@@ -339,7 +349,7 @@ static int krb5enc_decrypt(struct aead_request *req)
 	if (err < 0)
 		return err;
 
-	return krb5enc_dispatch_decrypt_hash(req);
+	return krb5enc_dispatch_decrypt_hash(req, aead_request_flags(req));
 }
 
 static int krb5enc_init_tfm(struct crypto_aead *tfm)


