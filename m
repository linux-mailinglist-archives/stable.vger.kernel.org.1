Return-Path: <stable+bounces-227086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIhbIpnAumkGbgIAu9opvQ
	(envelope-from <stable+bounces-227086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:11:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 785382BDED9
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D8F730AC82E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91E3DDDC8;
	Wed, 18 Mar 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhbwEzrC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF38261B9B
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845190; cv=none; b=jsBecrrMUSJlpUBVMsMyJ4IVMoOjkq35v9vlkFMZQTaAX3Fksm+E+MijZGJ7CFmcUAH/qtDMS9AURmYmu64T0JWLEgv98HZbjBg9BS1IOTTMXL4MwWCOBvdatJtxyBZtvcigm1Ca4mkT+JIkdNv4XPQfuLjuKZBt1WkcEhzXgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845190; c=relaxed/simple;
	bh=g3/iMwmhLq1blwf5jbexg4EcNgDI/PMjESd0wZ1vKCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxwzoAFG3hmQZWDdvL65HymDJ4AQzHjLDNf/IiJ2Tb/ESSnZLTcfotWTr12NXI5oH4d9ZDsRI2y6592y5yA0sqSxeQX0dm9B+2xeB+BioYvaN0B56rZF137yZ4gYmVzEytj7CbBTlowU6p9no+sOh5De6Ik2FL2wjtEQj23vbM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhbwEzrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90817C2BC87;
	Wed, 18 Mar 2026 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845190;
	bh=g3/iMwmhLq1blwf5jbexg4EcNgDI/PMjESd0wZ1vKCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhbwEzrCyuTgsKifcGx2LWqJcaktHHCDJDk3w9krjlMMdTSbqMH+m5J/yym4lLoY5
	 XoSVmVwqE1tEX+1N0FszXK+hJZbjAnVB0qO06XJXDg5cCMTcDU2rxsu26SvTwCI2Jh
	 DGCiZRnNxEiE7XUun8q4jbuCUq695OUg+SOhv8TaqbDHrWJegjQn6eHtQfDk3Q+RXD
	 OnZa3Lou0QFCYae6yHU0NSlK5L6jm2mikfChw7bI5aXFwroTLW5yW9tnQUpJnbgJt/
	 YDK11kPb2cT6BaCnLAMiAvJt3w2R7D3IB7n/HEkc7AacvfmKoYM/BN9haSccC7utfc
	 E1HQhXOQIZ2wQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: Don't log keys in SMB3 signing and encryption key generation
Date: Wed, 18 Mar 2026 10:46:27 -0400
Message-ID: <20260318144627.850113-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031718-eskimo-freeload-060c@gregkh>
References: <2026031718-eskimo-freeload-060c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227086-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 785382BDED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 441336115df26b966575de56daf7107ed474faed ]

When KSMBD_DEBUG_AUTH logging is enabled, generate_smb3signingkey() and
generate_smb3encryptionkey() log the session, signing, encryption, and
decryption key bytes. Remove the logs to avoid exposing credentials.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/auth.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index f8a192cc82f24..1a230b7fac1cc 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -795,12 +795,8 @@ static int generate_smb3signingkey(struct ksmbd_session *sess,
 	if (!(conn->dialect >= SMB30_PROT_ID && signing->binding))
 		memcpy(chann->smb3signingkey, key, SMB3_SIGN_KEY_SIZE);
 
-	ksmbd_debug(AUTH, "dumping generated AES signing keys\n");
+	ksmbd_debug(AUTH, "generated SMB3 signing key\n");
 	ksmbd_debug(AUTH, "Session Id    %llu\n", sess->id);
-	ksmbd_debug(AUTH, "Session Key   %*ph\n",
-		    SMB2_NTLMV2_SESSKEY_SIZE, sess->sess_key);
-	ksmbd_debug(AUTH, "Signing Key   %*ph\n",
-		    SMB3_SIGN_KEY_SIZE, key);
 	return 0;
 }
 
@@ -864,23 +860,9 @@ static int generate_smb3encryptionkey(struct ksmbd_conn *conn,
 	if (rc)
 		return rc;
 
-	ksmbd_debug(AUTH, "dumping generated AES encryption keys\n");
+	ksmbd_debug(AUTH, "generated SMB3 encryption/decryption keys\n");
 	ksmbd_debug(AUTH, "Cipher type   %d\n", conn->cipher_type);
 	ksmbd_debug(AUTH, "Session Id    %llu\n", sess->id);
-	ksmbd_debug(AUTH, "Session Key   %*ph\n",
-		    SMB2_NTLMV2_SESSKEY_SIZE, sess->sess_key);
-	if (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
-	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM) {
-		ksmbd_debug(AUTH, "ServerIn Key  %*ph\n",
-			    SMB3_GCM256_CRYPTKEY_SIZE, sess->smb3encryptionkey);
-		ksmbd_debug(AUTH, "ServerOut Key %*ph\n",
-			    SMB3_GCM256_CRYPTKEY_SIZE, sess->smb3decryptionkey);
-	} else {
-		ksmbd_debug(AUTH, "ServerIn Key  %*ph\n",
-			    SMB3_GCM128_CRYPTKEY_SIZE, sess->smb3encryptionkey);
-		ksmbd_debug(AUTH, "ServerOut Key %*ph\n",
-			    SMB3_GCM128_CRYPTKEY_SIZE, sess->smb3decryptionkey);
-	}
 	return 0;
 }
 
-- 
2.51.0


