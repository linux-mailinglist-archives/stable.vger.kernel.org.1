Return-Path: <stable+bounces-244609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNZYF5bE/Gk8TgAAu9opvQ
	(envelope-from <stable+bounces-244609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:57:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAEC4EC8E6
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3344230A7A28
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421303FD124;
	Thu,  7 May 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/yqvwly"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6E4508F8
	for <stable@vger.kernel.org>; Thu,  7 May 2026 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172748; cv=none; b=J01ZztPB/LT9cz1eIXa0dqWvnSzZM5mZSVrUuxV24v6jBlqdADkva/wIFHsP5fRhkfPoCB3tIhsqxpNdV6xWsFPZcj4r3u4DkdyQoAzniLiAf4JzVLMDnFhOFK5vPXsAtTG9u+fuBAq1+sQ2gDqO3Xu/yKq7APWo8VieQs/XOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172748; c=relaxed/simple;
	bh=DdOVwLG2B9Yti8eNvYwLrdHQJdkwU6BVOBbX5pMKj0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uX4R6B3Whk8YnGywrO6C0Vta462AxH0xpr6VFQVUbaxmpeF7UneDmoFzNhAgyMZT4IyZgzTPB5/9UqPCsq6vXHJHmAUp3llKGCqzDY5XykvV0pBKalN1ORVdpCoPD24qIEedZe0DaL/aFO8SESGlwUQ+0F5Ss46YJVvgd6abZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/yqvwly; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c801d732058so514223a12.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778172746; x=1778777546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnAzLRshVO8669/2ZpelErGyYsskkVJKiCCMm0uTTjI=;
        b=C/yqvwly8knSKxhx72eYT2NFAJHrgy/rjQ3aYgm2VMcbeU8uhkt1GBbdM+C7Eov5Cz
         h81vaLu2zpqJymv43IJFW/ZySfjBGdaGApVmow+ZUyCo6O2XRbn1CRPKqQj4+MtxClcy
         0Zh2o+w30TJ24/jJLRlZ8+ttKJANLiAAhB9N4qe/ogqchy4M28UUzH+QbeTzIAUqdXxR
         kifbiVCfxy+gMgGrdK5Fn9KUeKtCiCPvSCtuaDV5vXUtPfMpvrwqm/u9cX6qqUFXAqKN
         EZdsEPJxg8Iq+hJY5Lk/Fmr0IHWCZe/qEyw7VnKjAsm/X6rDipGQn7no8jruLsnsP9p/
         /txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172746; x=1778777546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PnAzLRshVO8669/2ZpelErGyYsskkVJKiCCMm0uTTjI=;
        b=dNmtl4MlF2c56+wJkc4LY0nASuBEd/g0boiSzCXydby4GPwQ9bcRvbjlJLcPVVH1GW
         y5AxhHUW2m1G50A7U1tXW0OdDFQvFaMvW1jWQ/a6h2hwFReiRK/Z9ty0vpSGll7vDGjk
         sMif/zqLisqUO8jXtHcoctU/H+39ikVsK5sZeRtyapqxcyw2kx3rfKpBj5g6HkiHvoC0
         QonrGkhsWUqqyrJc61+/nWJGyKWKMZibolqW+NGqFuR7IH3LG/i99wNP+XsUrPuuKSZI
         LTmDFSOpsUUDxiQQnyZnC+J/XV0vh4MgjJjcCB2Me+YyMARzp+KAkzwAkFkEPm65oGjg
         qqVw==
X-Forwarded-Encrypted: i=1; AFNElJ+Id4JiTkqslqGQs8UlVux3ZpUgzvcRK9jsuM9TizoBGc4enIfxTcfHQQ6oZfIb2Uv9CVdA2Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqgXS9sRuculA+Ai70sFjpx4rqB+wfrIPRIH5RuoBQqqjdTP8Y
	725wpTkSEtP3BQweEX7AiQeMKOH/BYwd86HOCUYzbrRn6CSsV06nvHUQ
X-Gm-Gg: AeBDievEDxJ5fBGGI1FC6S8ArMGTqh4FquM21M1JwoK6FVxTG+PCtpiGPZsmn5I4ZUz
	ZfvKodG+IvwNZLCFECVb2g8ymsol51e2mjUsCZ/AdXdZUhAH7upLHh0aFcIn+E1TIl+c+ttd/FQ
	XKPsSwet3HULKaLgoJAJXyF1CwqvWi6xSpf8n1wE0wPy5IvTN4YLTmKLd/bNMCLq4kA+SI4PKXQ
	qLEI0T9LEpXYza32zQq/9ooVpmdx0t1bi2BkU8a8UJ0WdWCdqJ31qUrGMUBXzXgSMH6kQMzZtWj
	GQ8Yr6h3l8c8Iyc0hNiVt+OgQBXaWoao2iXOe3Ps+ai/EwXOtUK6lgmXaMIhGdpkmgL2+xA4ynj
	l0SuVVGZsP8TwXempjLyrfJ4BbyW1pPp0GtehbPRzR3f+hkJQh3nD3eGUbFU7be5zdQgLGuN9S5
	tsPwkruqCrvjm0Vyjwb9HsDZ5qBkr3LhF8kMBAK+k=
X-Received: by 2002:a05:6a20:3c8d:b0:39c:4e62:b843 with SMTP id adf61e73a8af0-3aa8beb3559mr3589422637.10.1778172745848;
        Thu, 07 May 2026 09:52:25 -0700 (PDT)
Received: from localhost ([49.207.150.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82640aeeaesm104310a12.18.2026.05.07.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:52:25 -0700 (PDT)
From: Piyush Sachdeva <s.piyush1024@gmail.com>
X-Google-Original-From: Piyush Sachdeva <psachdeva@microsoft.com>
Date: Thu, 07 May 2026 22:22:13 +0530
Subject: [PATCH v3 1/2] smb: client: Use FullSessionKey for AES-256
 encryption key derivation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-kerbmi-v3-1-397ebbb53eff@microsoft.com>
References: <20260507-kerbmi-v3-0-397ebbb53eff@microsoft.com>
In-Reply-To: <20260507-kerbmi-v3-0-397ebbb53eff@microsoft.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Tom Talpey <tom@talpey.com>
Cc: samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, vaibsharma@microsoft.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5867;
 i=psachdeva@microsoft.com; h=from:subject:message-id;
 bh=DdOVwLG2B9Yti8eNvYwLrdHQJdkwU6BVOBbX5pMKj0A=;
 b=owGbwMvMwCV29FJ3ncRHDT/G02pJDJl/DjvW+i8WV/y35ffMvOw98x7ZVYXOeqxzQPfJ/OuN1
 /y/T+sL7ZjIwiDGxWAppsiy4cQdWd74XZLzPj0xgpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10DHSMGbg4BWCq1ZMY/ulXszpHKOYa/NrL2sGc8LCQ70B1S/rqbEHbMhnBszKxxxj+Cqzb4xg
 W+aR4wYEFLpfSXaW9p8/IjTxaysyzRLz0b6sOEwA=
X-Developer-Key: i=psachdeva@microsoft.com; a=openpgp;
 fpr=80350F71F916134953C3EB979E19C6F9839C3CFC
X-Rspamd-Queue-Id: 9BAEC4EC8E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244609-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[samba.org,vger.kernel.org,microsoft.com,manguebit.org,gmail.com,talpey.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spiyush1024@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

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

Signed-off-by: Piyush Sachdeva <psachdeva@microsoft.com>
Signed-off-by: Piyush Sachdeva <s.piyush1024@gmail.com>
---
 fs/smb/client/ioctl.c         |  2 +-
 fs/smb/client/smb2transport.c | 35 ++++++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 10 deletions(-)

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

-- 
2.53.0


