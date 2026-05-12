Return-Path: <stable+bounces-245681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLmKNjA3A2ow1wEAu9opvQ
	(envelope-from <stable+bounces-245681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:20:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A63952242F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCDA83150F6B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637813A7D7A;
	Tue, 12 May 2026 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gwib9rrO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375D3A59AC
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594701; cv=none; b=hANfXuOkDDQr+pQduMDxkGHDR0VirwK/L0lRZzcev+uWTtH+doyOzkWDgoVDMUYQxqB9sQu1FCQ3FmnKnAi9wAl1VwI/sw5l5geINyblzeKUDx9enmVuvXfgS+mMzVKdwG5QHrio5urNggHkhYlJrr8t0YBKNx0yk9+BKApcDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594701; c=relaxed/simple;
	bh=5jo247Ch3xRQS2maqWo5xLEk4XW5/gvAkfRzD0m8ER4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gOMbRd92jrSDbpAo8fDK7Oo6+Y0XNy+cB0BXgNtUQlbPLtL0Nf791NFNJopCag4FlDzpjcY4T+amGt2f9gTkNkRb+FiXZgEaHkLY+6bTatyQ2oWTtwPNfz2+WMIF+Rw/wxC2N4KwuG3tJ7RP3hwh9idfIX4S4DDT9MyW/m/6438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gwib9rrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFFBC2BCB0;
	Tue, 12 May 2026 14:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594701;
	bh=5jo247Ch3xRQS2maqWo5xLEk4XW5/gvAkfRzD0m8ER4=;
	h=Subject:To:Cc:From:Date:From;
	b=Gwib9rrOpo8RYmiNNkXPbPTp8D4xbUtBsGUSCqE1b0kooaShxjR0HGYXbzy/bJqhm
	 y0AY0OF1WMuc47dlK5hnIYWQ9FhuKKUETsiNWljE+RmvTXPDmgCwyIse4yXau5W8o7
	 REhtSCvEGxQGOfo2A7+Mfqwzej7XJuchP8IQRjCw=
Subject: FAILED: patch "[PATCH] smb: client: Use FullSessionKey for AES-256 encryption key" failed to apply to 7.0-stable tree
To: s.piyush1024@gmail.com,bharathsm@microsoft.com,psachdeva@microsoft.com,stable@vger.kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:05:01 +0200
Message-ID: <2026051201-ladies-unstaffed-051b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A63952242F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245681-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 5be7a0cef3229fb3b63a07c0d289daf752545424
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051201-ladies-unstaffed-051b@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5be7a0cef3229fb3b63a07c0d289daf752545424 Mon Sep 17 00:00:00 2001
From: Piyush Sachdeva <s.piyush1024@gmail.com>
Date: Thu, 7 May 2026 22:22:13 +0530
Subject: [PATCH] smb: client: Use FullSessionKey for AES-256 encryption key
 derivation

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

diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
index 9afab3237e54..17408bb8ab65 100644
--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -296,7 +296,7 @@ static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
 		break;
 	case SMB2_ENCRYPTION_AES256_CCM:
 	case SMB2_ENCRYPTION_AES256_GCM:
-		out.session_key_length = CIFS_SESS_KEY_SIZE;
+		out.session_key_length = ses->auth_key.len;
 		out.server_in_key_length = out.server_out_key_length = SMB3_GCM256_CRYPTKEY_SIZE;
 		break;
 	default:
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 41009039b4cb..e8eeff9e50d6 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -251,7 +251,8 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
 }
 
 static void generate_key(struct cifs_ses *ses, struct kvec label,
-			 struct kvec context, __u8 *key, unsigned int key_size)
+			 struct kvec context, __u8 *key, unsigned int key_size,
+			 unsigned int full_key_size)
 {
 	unsigned char zero = 0x0;
 	__u8 i[4] = {0, 0, 0, 1};
@@ -265,7 +266,7 @@ static void generate_key(struct cifs_ses *ses, struct kvec label,
 	memset(key, 0x0, key_size);
 
 	hmac_sha256_init_usingrawkey(&hmac_ctx, ses->auth_key.response,
-				     SMB2_NTLMV2_SESSKEY_SIZE);
+				     full_key_size);
 	hmac_sha256_update(&hmac_ctx, i, 4);
 	hmac_sha256_update(&hmac_ctx, label.iov_base, label.iov_len);
 	hmac_sha256_update(&hmac_ctx, &zero, 1);
@@ -298,6 +299,7 @@ generate_smb3signingkey(struct cifs_ses *ses,
 			struct TCP_Server_Info *server,
 			const struct derivation_triplet *ptriplet)
 {
+	unsigned int full_key_size = SMB2_NTLMV2_SESSKEY_SIZE;
 	bool is_binding = false;
 	int chan_index = 0;
 
@@ -330,12 +332,24 @@ generate_smb3signingkey(struct cifs_ses *ses,
 	if (is_binding) {
 		generate_key(ses, ptriplet->signing.label,
 			     ptriplet->signing.context,
-			     ses->chans[chan_index].signkey,
-			     SMB3_SIGN_KEY_SIZE);
+			     ses->chans[chan_index].signkey, SMB3_SIGN_KEY_SIZE,
+			     SMB2_NTLMV2_SESSKEY_SIZE);
 	} else {
 		generate_key(ses, ptriplet->signing.label,
-			     ptriplet->signing.context,
-			     ses->smb3signingkey, SMB3_SIGN_KEY_SIZE);
+			     ptriplet->signing.context, ses->smb3signingkey,
+			     SMB3_SIGN_KEY_SIZE, SMB2_NTLMV2_SESSKEY_SIZE);
+
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
 
 		/* safe to access primary channel, since it will never go away */
 		spin_lock(&ses->chan_lock);
@@ -345,10 +359,13 @@ generate_smb3signingkey(struct cifs_ses *ses,
 
 		generate_key(ses, ptriplet->encryption.label,
 			     ptriplet->encryption.context,
-			     ses->smb3encryptionkey, SMB3_ENC_DEC_KEY_SIZE);
+			     ses->smb3encryptionkey, SMB3_ENC_DEC_KEY_SIZE,
+			     full_key_size);
+
 		generate_key(ses, ptriplet->decryption.label,
 			     ptriplet->decryption.context,
-			     ses->smb3decryptionkey, SMB3_ENC_DEC_KEY_SIZE);
+			     ses->smb3decryptionkey, SMB3_ENC_DEC_KEY_SIZE,
+			     full_key_size);
 	}
 
 #ifdef CONFIG_CIFS_DEBUG_DUMP_KEYS
@@ -361,7 +378,7 @@ generate_smb3signingkey(struct cifs_ses *ses,
 			&ses->Suid);
 	cifs_dbg(VFS, "Cipher type   %d\n", server->cipher_type);
 	cifs_dbg(VFS, "Session Key   %*ph\n",
-		 SMB2_NTLMV2_SESSKEY_SIZE, ses->auth_key.response);
+		 (int)ses->auth_key.len, ses->auth_key.response);
 	cifs_dbg(VFS, "Signing Key   %*ph\n",
 		 SMB3_SIGN_KEY_SIZE, ses->smb3signingkey);
 	if ((server->cipher_type == SMB2_ENCRYPTION_AES256_CCM) ||


