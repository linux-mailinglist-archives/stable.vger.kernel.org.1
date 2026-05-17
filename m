Return-Path: <stable+bounces-249152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPsdOO5JCmrFzAQAu9opvQ
	(envelope-from <stable+bounces-249152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 01:06:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48693564404
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 01:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF81302C90D
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 23:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795D73D6693;
	Sun, 17 May 2026 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adMpoJZC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF13C3438
	for <stable@vger.kernel.org>; Sun, 17 May 2026 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779059135; cv=none; b=eUDC+G25Q9gKYfEZgXF41J3najJRGH40EG8g9rW2z//eLKrcd3nZ++sXjJC0rRA6emU4rpWvjENZq77HLniyrm84u/cMFLxRfdnxSFhiIEC34S5dN+1wBk4S5f1zLgSJnmIfyZkjUIIfs+jtLYSVXl4VgYxmM/8bng4FkP5c0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779059135; c=relaxed/simple;
	bh=Jq57dZm4FypZLU3ZS5NJIxl1MKD4GwBgnHTlWetJ9do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKtp/YolUVruzhvNN2bqq2308PZfGhFmNN3ZQv0/jsZ1FyHfWukMM+hLRcZbxYbVLip/lABqQMUxqrsigRpme39tJiUlJ4wlbWLM9el2Hs876lwlUcyavOFl3mP8QfcteJBCBfs9fnweNk6LwfFFW71EQ35Ong8U1pT1iBp6+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adMpoJZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46577C2BCB0;
	Sun, 17 May 2026 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779059135;
	bh=Jq57dZm4FypZLU3ZS5NJIxl1MKD4GwBgnHTlWetJ9do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adMpoJZC7xQ0tN8XSgH5KK5uyCEaV9k1eFUSeb8wmaE3yYjlEJj463jamryh0KrwB
	 uy4LrBRkRdGx0nmN3nkIxMQ2gFFPmqAQtYdVIQn9WiR6d3Fd/ejKxCamLZMYTaU9tA
	 lmRFR8CShFycRix45ZtK9XYP+hC8mEyo1g6Auzk8J9lg/opJcWSCp0mGXzntMsyh9T
	 nu8EnctGIQktGxXCmQisIYTgBixNyG/RexRyP9QvwgJSjENbft4cK9z+PEHfvI5YK9
	 JtT8/wK3/bOoxrCyjZv2wgznsWRVngMZ+Y1HLs8rsq/VqXv9yLQ3KwmmFAQtYKXTrl
	 9ykfUxcH/fDzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Piyush Sachdeva <s.piyush1024@gmail.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Piyush Sachdeva <psachdeva@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: Use FullSessionKey for AES-256 encryption key derivation
Date: Sun, 17 May 2026 19:05:32 -0400
Message-ID: <20260517230532.410411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051203-superman-brunette-3ba1@gregkh>
References: <2026051203-superman-brunette-3ba1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 48693564404
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249152-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Piyush Sachdeva <s.piyush1024@gmail.com>

[ Upstream commit 5be7a0cef3229fb3b63a07c0d289daf752545424 ]

When Kerberos authentication is used with AES-256 encryption (AES-256-CCM
or AES-256-GCM), the SMB3 encryption and decryption keys must be derived
using the full session key (Session.FullSessionKey) rather than just the
first 16 bytes (Session.SessionKey).

Per MS-SMB2 section 3.2.5.3.1, when Connection.Dialect is "3.1.1" and
Connection.CipherId is AES-256-CCM or AES-256-GCM, Session.FullSessionKey
must be set to the full cryptographic key from the GSS authentication
context. The encryption and decryption key derivation (SMBC2SCipherKey,
SMBS2CCipherKey) must use this FullSessionKey as the KDF input. The
signing key derivation continues to use Session.SessionKey (first 16
bytes) in all cases.

Previously, generate_key() hardcoded SMB2_NTLMV2_SESSKEY_SIZE (16) as the
HMAC-SHA256 key input length for all derivations. When Kerberos with
AES-256 provides a 32-byte session key, the KDF for encryption/decryption
was using only the first 16 bytes, producing keys that did not match the
server's, causing mount failures with sec=krb5 and require_gcm_256=1.

Add a full_key_size parameter to generate_key() and pass the appropriate
size from generate_smb3signingkey():
 - Signing: always SMB2_NTLMV2_SESSKEY_SIZE (16 bytes)
 - Encryption/Decryption: ses->auth_key.len when AES-256, otherwise 16

Also fix cifs_dump_full_key() to report the actual session key length for
AES-256 instead of hardcoded CIFS_SESS_KEY_SIZE, so that userspace tools
like Wireshark receive the correct key for decryption.

Cc: <stable@vger.kernel.org>
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Piyush Sachdeva <psachdeva@microsoft.com>
Signed-off-by: Piyush Sachdeva <s.piyush1024@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ adapted to legacy crypto_shash API and ses->binding boolean instead of upstream's hmac_sha256 helpers and chan_lock machinery ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/ioctl.c         |  2 +-
 fs/cifs/smb2transport.c | 36 ++++++++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index e846c18b71d2d..281515ed473da 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -262,7 +262,7 @@ static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
 		break;
 	case SMB2_ENCRYPTION_AES256_CCM:
 	case SMB2_ENCRYPTION_AES256_GCM:
-		out.session_key_length = CIFS_SESS_KEY_SIZE;
+		out.session_key_length = ses->auth_key.len;
 		out.server_in_key_length = out.server_out_key_length = SMB3_GCM256_CRYPTKEY_SIZE;
 		break;
 	default:
diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index ffae3a7f46ce4..f1e981328bc87 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -291,7 +291,8 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 }
 
 static int generate_key(struct cifs_ses *ses, struct kvec label,
-			struct kvec context, __u8 *key, unsigned int key_size)
+			struct kvec context, __u8 *key, unsigned int key_size,
+			unsigned int full_key_size)
 {
 	unsigned char zero = 0x0;
 	__u8 i[4] = {0, 0, 0, 1};
@@ -312,7 +313,7 @@ static int generate_key(struct cifs_ses *ses, struct kvec label,
 	}
 
 	rc = crypto_shash_setkey(server->secmech.hmacsha256,
-		ses->auth_key.response, SMB2_NTLMV2_SESSKEY_SIZE);
+		ses->auth_key.response, full_key_size);
 	if (rc) {
 		cifs_server_dbg(VFS, "%s: Could not set with session key\n", __func__);
 		goto smb3signkey_ret;
@@ -393,10 +394,9 @@ static int
 generate_smb3signingkey(struct cifs_ses *ses,
 			const struct derivation_triplet *ptriplet)
 {
-	int rc;
-#ifdef CONFIG_CIFS_DEBUG_DUMP_KEYS
+	unsigned int full_key_size = SMB2_NTLMV2_SESSKEY_SIZE;
 	struct TCP_Server_Info *server = ses->server;
-#endif
+	int rc;
 
 	/*
 	 * All channels use the same encryption/decryption keys but
@@ -412,30 +412,46 @@ generate_smb3signingkey(struct cifs_ses *ses,
 		rc = generate_key(ses, ptriplet->signing.label,
 				  ptriplet->signing.context,
 				  cifs_ses_binding_channel(ses)->signkey,
-				  SMB3_SIGN_KEY_SIZE);
+				  SMB3_SIGN_KEY_SIZE,
+				  SMB2_NTLMV2_SESSKEY_SIZE);
 		if (rc)
 			return rc;
 	} else {
 		rc = generate_key(ses, ptriplet->signing.label,
 				  ptriplet->signing.context,
 				  ses->smb3signingkey,
-				  SMB3_SIGN_KEY_SIZE);
+				  SMB3_SIGN_KEY_SIZE,
+				  SMB2_NTLMV2_SESSKEY_SIZE);
 		if (rc)
 			return rc;
 
+		/*
+		 * Per MS-SMB2 3.2.5.3.1, signing key always uses Session.SessionKey
+		 * (first 16 bytes). Encryption/decryption keys use
+		 * Session.FullSessionKey when dialect is 3.1.1 and cipher is
+		 * AES-256-CCM or AES-256-GCM, otherwise Session.SessionKey.
+		 */
+
+		if (server->dialect == SMB311_PROT_ID &&
+		    (server->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+		     server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
+			full_key_size = ses->auth_key.len;
+
 		memcpy(ses->chans[0].signkey, ses->smb3signingkey,
 		       SMB3_SIGN_KEY_SIZE);
 
 		rc = generate_key(ses, ptriplet->encryption.label,
 				  ptriplet->encryption.context,
 				  ses->smb3encryptionkey,
-				  SMB3_ENC_DEC_KEY_SIZE);
+				  SMB3_ENC_DEC_KEY_SIZE,
+				  full_key_size);
 		if (rc)
 			return rc;
 		rc = generate_key(ses, ptriplet->decryption.label,
 				  ptriplet->decryption.context,
 				  ses->smb3decryptionkey,
-				  SMB3_ENC_DEC_KEY_SIZE);
+				  SMB3_ENC_DEC_KEY_SIZE,
+				  full_key_size);
 		if (rc)
 			return rc;
 	}
@@ -450,7 +466,7 @@ generate_smb3signingkey(struct cifs_ses *ses,
 			&ses->Suid);
 	cifs_dbg(VFS, "Cipher type   %d\n", server->cipher_type);
 	cifs_dbg(VFS, "Session Key   %*ph\n",
-		 SMB2_NTLMV2_SESSKEY_SIZE, ses->auth_key.response);
+		 (int)ses->auth_key.len, ses->auth_key.response);
 	cifs_dbg(VFS, "Signing Key   %*ph\n",
 		 SMB3_SIGN_KEY_SIZE, ses->smb3signingkey);
 	if ((server->cipher_type == SMB2_ENCRYPTION_AES256_CCM) ||
-- 
2.53.0


