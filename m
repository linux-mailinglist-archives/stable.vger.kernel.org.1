Return-Path: <stable+bounces-58209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3643D92A1AA
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 13:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EE51F22391
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE157E57F;
	Mon,  8 Jul 2024 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sc0X87pG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC773461
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439561; cv=none; b=uoA7JQLcfdsSrxMTREBgwcU5al/V2Vop4IKw9FQskd/jKGJP79F8EVFZF+3xzhOZQyIhdZ20HHCBT2LuN7wj/XSw7we0/EbsxmQXK1wcipPoUgrmyt1FmmibDRT+50pf11nJfqP3TqmQ8M5jMkICdIf2quVBFe2kfXUHZIwFD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439561; c=relaxed/simple;
	bh=IBFGQ2d0FGqrKmJq965I0HGs1L8YIIhGQTcDKq1lWlg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JqCoderfYyJ13OGz0qghtJU9hajGuOTdDMdn33kCvTB3ZBT2S1vCayAkfsMbaJ2kW1jsqZtWMXpgImDtC4XTNLgk5xyfbowwb6Y6MM6wGKBNHBFwJzwMjzEAa1I6qNPJRGe8iE7qU2sEzRliq6e+IuvtUUUzj+itGLKvsY5V+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sc0X87pG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61847C3277B;
	Mon,  8 Jul 2024 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720439560;
	bh=IBFGQ2d0FGqrKmJq965I0HGs1L8YIIhGQTcDKq1lWlg=;
	h=Subject:To:Cc:From:Date:From;
	b=Sc0X87pGM2trZQTWfFgL4jR8KFSTcbg25Tgn9zGTwLVUTZx9HXbw8TqricL9c8Hdj
	 8If33yuK/Y462+2GoErfyw5LmtHxd76JsW8Juft+a4GnjgF/nD/q/tecW1nFGgJNj1
	 F/tVrYjAWV6yvjmiYXzudpJde7+LxCgJsQ7LU+Fk=
Subject: FAILED: patch "[PATCH] tpm: Address !chip->auth in tpm_buf_append_hmac_session*()" failed to apply to 6.9-stable tree
To: jarkko@kernel.org,mpe@ellerman.id.au,stefanb@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jul 2024 13:52:37 +0200
Message-ID: <2024070837-moonlike-computing-e29c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 7ca110f2679b7d1f3ac1afc90e6ffbf0af3edf0d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070837-moonlike-computing-e29c@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_session*()")
a61809a33239 ("tpm: Address !chip->auth in tpm_buf_append_name()")
f09fc6cee0dc ("tpm: Rename TPM2_OA_TMPL to TPM2_OA_NULL_KEY and make it local")
eb24c9788cd9 ("tpm: disable the TPM if NULL name changes")
1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
699e3efd6c64 ("tpm: Add HMAC session start and end functions")
033ee84e5f01 ("tpm: Add TCG mandated Key Derivation Functions (KDFs)")
d2add27cf2b8 ("tpm: Add NULL primary creation")
17d89b2e2f76 ("tpm: Move buffer handling from static inlines to real functions")
cf792e903aff ("tpm: Remove unused tpm_buf_tag()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ca110f2679b7d1f3ac1afc90e6ffbf0af3edf0d Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Wed, 3 Jul 2024 18:47:46 +0300
Subject: [PATCH] tpm: Address !chip->auth in tpm_buf_append_hmac_session*()

Unless tpm_chip_bootstrap() was called by the driver, !chip->auth can
cause a null derefence in tpm_buf_hmac_session*().  Thus, address
!chip->auth in tpm_buf_hmac_session*() and remove the fallback
implementation for !TCG_TPM2_HMAC.

Cc: stable@vger.kernel.org # v6.9+
Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Closes: https://lore.kernel.org/linux-integrity/20240617193408.1234365-1-stefanb@linux.ibm.com/
Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Tested-by: Michael Ellerman <mpe@ellerman.id.au> # ppc
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index b3ed35e7ec00..2281d55df545 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -272,6 +272,110 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
+/**
+ * tpm_buf_append_hmac_session() - Append a TPM session element
+ * @chip: the TPM chip structure
+ * @buf: The buffer to be appended
+ * @attributes: The session attributes
+ * @passphrase: The session authority (NULL if none)
+ * @passphrase_len: The length of the session authority (0 if none)
+ *
+ * This fills in a session structure in the TPM command buffer, except
+ * for the HMAC which cannot be computed until the command buffer is
+ * complete.  The type of session is controlled by the @attributes,
+ * the main ones of which are TPM2_SA_CONTINUE_SESSION which means the
+ * session won't terminate after tpm_buf_check_hmac_response(),
+ * TPM2_SA_DECRYPT which means this buffers first parameter should be
+ * encrypted with a session key and TPM2_SA_ENCRYPT, which means the
+ * response buffer's first parameter needs to be decrypted (confusing,
+ * but the defines are written from the point of view of the TPM).
+ *
+ * Any session appended by this command must be finalized by calling
+ * tpm_buf_fill_hmac_session() otherwise the HMAC will be incorrect
+ * and the TPM will reject the command.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
+				 u8 attributes, u8 *passphrase,
+				 int passphrase_len)
+{
+#ifdef CONFIG_TCG_TPM2_HMAC
+	u8 nonce[SHA256_DIGEST_SIZE];
+	struct tpm2_auth *auth;
+	u32 len;
+#endif
+
+	if (!tpm2_chip_auth(chip)) {
+		/* offset tells us where the sessions area begins */
+		int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+		u32 len = 9 + passphrase_len;
+
+		if (tpm_buf_length(buf) != offset) {
+			/* not the first session so update the existing length */
+			len += get_unaligned_be32(&buf->data[offset]);
+			put_unaligned_be32(len, &buf->data[offset]);
+		} else {
+			tpm_buf_append_u32(buf, len);
+		}
+		/* auth handle */
+		tpm_buf_append_u32(buf, TPM2_RS_PW);
+		/* nonce */
+		tpm_buf_append_u16(buf, 0);
+		/* attributes */
+		tpm_buf_append_u8(buf, 0);
+		/* passphrase */
+		tpm_buf_append_u16(buf, passphrase_len);
+		tpm_buf_append(buf, passphrase, passphrase_len);
+		return;
+	}
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+	/*
+	 * The Architecture Guide requires us to strip trailing zeros
+	 * before computing the HMAC
+	 */
+	while (passphrase && passphrase_len > 0 && passphrase[passphrase_len - 1] == '\0')
+		passphrase_len--;
+
+	auth = chip->auth;
+	auth->attrs = attributes;
+	auth->passphrase_len = passphrase_len;
+	if (passphrase_len)
+		memcpy(auth->passphrase, passphrase, passphrase_len);
+
+	if (auth->session != tpm_buf_length(buf)) {
+		/* we're not the first session */
+		len = get_unaligned_be32(&buf->data[auth->session]);
+		if (4 + len + auth->session != tpm_buf_length(buf)) {
+			WARN(1, "session length mismatch, cannot append");
+			return;
+		}
+
+		/* add our new session */
+		len += 9 + 2 * SHA256_DIGEST_SIZE;
+		put_unaligned_be32(len, &buf->data[auth->session]);
+	} else {
+		tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
+	}
+
+	/* random number for our nonce */
+	get_random_bytes(nonce, sizeof(nonce));
+	memcpy(auth->our_nonce, nonce, sizeof(nonce));
+	tpm_buf_append_u32(buf, auth->handle);
+	/* our new nonce */
+	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
+	tpm_buf_append_u8(buf, auth->attrs);
+	/* and put a placeholder for the hmac */
+	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
+#endif
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_hmac_session);
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 
 static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
@@ -457,82 +561,6 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	crypto_free_kpp(kpp);
 }
 
-/**
- * tpm_buf_append_hmac_session() - Append a TPM session element
- * @chip: the TPM chip structure
- * @buf: The buffer to be appended
- * @attributes: The session attributes
- * @passphrase: The session authority (NULL if none)
- * @passphrase_len: The length of the session authority (0 if none)
- *
- * This fills in a session structure in the TPM command buffer, except
- * for the HMAC which cannot be computed until the command buffer is
- * complete.  The type of session is controlled by the @attributes,
- * the main ones of which are TPM2_SA_CONTINUE_SESSION which means the
- * session won't terminate after tpm_buf_check_hmac_response(),
- * TPM2_SA_DECRYPT which means this buffers first parameter should be
- * encrypted with a session key and TPM2_SA_ENCRYPT, which means the
- * response buffer's first parameter needs to be decrypted (confusing,
- * but the defines are written from the point of view of the TPM).
- *
- * Any session appended by this command must be finalized by calling
- * tpm_buf_fill_hmac_session() otherwise the HMAC will be incorrect
- * and the TPM will reject the command.
- *
- * As with most tpm_buf operations, success is assumed because failure
- * will be caused by an incorrect programming model and indicated by a
- * kernel message.
- */
-void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
-				 u8 attributes, u8 *passphrase,
-				 int passphrase_len)
-{
-	u8 nonce[SHA256_DIGEST_SIZE];
-	u32 len;
-	struct tpm2_auth *auth = chip->auth;
-
-	/*
-	 * The Architecture Guide requires us to strip trailing zeros
-	 * before computing the HMAC
-	 */
-	while (passphrase && passphrase_len > 0
-	       && passphrase[passphrase_len - 1] == '\0')
-		passphrase_len--;
-
-	auth->attrs = attributes;
-	auth->passphrase_len = passphrase_len;
-	if (passphrase_len)
-		memcpy(auth->passphrase, passphrase, passphrase_len);
-
-	if (auth->session != tpm_buf_length(buf)) {
-		/* we're not the first session */
-		len = get_unaligned_be32(&buf->data[auth->session]);
-		if (4 + len + auth->session != tpm_buf_length(buf)) {
-			WARN(1, "session length mismatch, cannot append");
-			return;
-		}
-
-		/* add our new session */
-		len += 9 + 2 * SHA256_DIGEST_SIZE;
-		put_unaligned_be32(len, &buf->data[auth->session]);
-	} else {
-		tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
-	}
-
-	/* random number for our nonce */
-	get_random_bytes(nonce, sizeof(nonce));
-	memcpy(auth->our_nonce, nonce, sizeof(nonce));
-	tpm_buf_append_u32(buf, auth->handle);
-	/* our new nonce */
-	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
-	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
-	tpm_buf_append_u8(buf, auth->attrs);
-	/* and put a placeholder for the hmac */
-	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
-	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
-}
-EXPORT_SYMBOL(tpm_buf_append_hmac_session);
-
 /**
  * tpm_buf_fill_hmac_session() - finalize the session HMAC
  * @chip: the TPM chip structure
@@ -563,6 +591,9 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	u8 cphash[SHA256_DIGEST_SIZE];
 	struct sha256_state sctx;
 
+	if (!auth)
+		return;
+
 	/* save the command code in BE format */
 	auth->ordinal = head->ordinal;
 
@@ -721,6 +752,9 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 	u32 cc = be32_to_cpu(auth->ordinal);
 	int parm_len, len, i, handles;
 
+	if (!auth)
+		return rc;
+
 	if (auth->session >= TPM_HEADER_SIZE) {
 		WARN(1, "tpm session not filled correctly\n");
 		goto out;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4d3071e885a0..e93ee8d936a9 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -502,10 +502,6 @@ static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
 
 void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u32 handle, u8 *name);
-
-#ifdef CONFIG_TCG_TPM2_HMAC
-
-int tpm2_start_auth_session(struct tpm_chip *chip);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
@@ -515,9 +511,27 @@ static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 						   u8 *passphrase,
 						   int passphraselen)
 {
-	tpm_buf_append_hmac_session(chip, buf, attributes, passphrase,
-				    passphraselen);
+	struct tpm_header *head;
+	int offset;
+
+	if (tpm2_chip_auth(chip)) {
+		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase, passphraselen);
+	} else  {
+		offset = buf->handles * 4 + TPM_HEADER_SIZE;
+		head = (struct tpm_header *)buf->data;
+
+		/*
+		 * If the only sessions are optional, the command tag must change to
+		 * TPM2_ST_NO_SESSIONS.
+		 */
+		if (tpm_buf_length(buf) == offset)
+			head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+	}
 }
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+
+int tpm2_start_auth_session(struct tpm_chip *chip);
 void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
 int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 				int rc);
@@ -532,48 +546,6 @@ static inline int tpm2_start_auth_session(struct tpm_chip *chip)
 static inline void tpm2_end_auth_session(struct tpm_chip *chip)
 {
 }
-static inline void tpm_buf_append_hmac_session(struct tpm_chip *chip,
-					       struct tpm_buf *buf,
-					       u8 attributes, u8 *passphrase,
-					       int passphraselen)
-{
-	/* offset tells us where the sessions area begins */
-	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
-	u32 len = 9 + passphraselen;
-
-	if (tpm_buf_length(buf) != offset) {
-		/* not the first session so update the existing length */
-		len += get_unaligned_be32(&buf->data[offset]);
-		put_unaligned_be32(len, &buf->data[offset]);
-	} else {
-		tpm_buf_append_u32(buf, len);
-	}
-	/* auth handle */
-	tpm_buf_append_u32(buf, TPM2_RS_PW);
-	/* nonce */
-	tpm_buf_append_u16(buf, 0);
-	/* attributes */
-	tpm_buf_append_u8(buf, 0);
-	/* passphrase */
-	tpm_buf_append_u16(buf, passphraselen);
-	tpm_buf_append(buf, passphrase, passphraselen);
-}
-static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
-						   struct tpm_buf *buf,
-						   u8 attributes,
-						   u8 *passphrase,
-						   int passphraselen)
-{
-	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
-	struct tpm_header *head = (struct tpm_header *) buf->data;
-
-	/*
-	 * if the only sessions are optional, the command tag
-	 * must change to TPM2_ST_NO_SESSIONS
-	 */
-	if (tpm_buf_length(buf) == offset)
-		head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-}
 static inline void tpm_buf_fill_hmac_session(struct tpm_chip *chip,
 					     struct tpm_buf *buf)
 {


