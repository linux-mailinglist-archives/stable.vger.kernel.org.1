Return-Path: <stable+bounces-222882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D2xHSnipmlAYgAAu9opvQ
	(envelope-from <stable+bounces-222882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 14:29:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C430A1F03C1
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 553653017AB9
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E7935DA71;
	Tue,  3 Mar 2026 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gWXFIxOF"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A521E230E
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544431; cv=none; b=hXExJlc65Rlu2Sn0r+KaWL2HjMGihybJNMkjhTBvkFqJTsgbDaOcynbtN35mO20ksraqVdcgbI1YOwezPYR/gp79QD4Rx61YQk+3H4nZsKtX8Bx+TtFlwlId1PmqAeEC/G5noai3ReINxT4pQHqRzhRxhyYOJQLV7uXKbyJz7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544431; c=relaxed/simple;
	bh=mUMrdakD2E2fCijWUN65nGHOcPP0GmwQVunxzTqzb6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HI0q1eQU5b4qZ2F/pjczL+cphTowkNKX+MsXzf1XvgDx4D4UKKT/htJgox/rwXHNuyQWWE416IDzc3tZHWGwO8HxR0GXs4EDkLNyzMPcZHltvfop2Xe9nlt8IpkK4ANSDv9IjB/OdXKHENL1xuM2hSzQsB/wYvXfloWf2T84tBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gWXFIxOF; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772544418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f0qiNaEKV3DuWlJ//lUJCPANMLZgJ3EU67P3T6dkEA4=;
	b=gWXFIxOF5+4P5jdftt2f/L9LN0chFjJEyC4KGA12nSrTALD9os5jhQNtnLcrXMLckfrtGb
	1VHJaxE4KeyCDzEz0/5MMlcMioIa9I2c6UvGP3/rckFsbTaqMqeS7NCxbkollbRxFJVr1Q
	T8js4R/JReSvPr6FiYxbXzwYZPb7RXY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Namjae Jeon <namjae.jeon@samsung.com>,
	Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ksmbd: Don't log keys in SMB3 signing and encryption key generation
Date: Tue,  3 Mar 2026 14:25:53 +0100
Message-ID: <20260303132552.65235-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C430A1F03C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222882-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,chromium.org,talpey.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

When KSMBD_DEBUG_AUTH logging is enabled, generate_smb3signingkey() and
generate_smb3encryptionkey() log the session, signing, encryption, and
decryption key bytes. Remove the logs to avoid exposing credentials.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/smb/server/auth.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 5fe8c667c6b1..af5f40304331 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -589,12 +589,8 @@ static int generate_smb3signingkey(struct ksmbd_session *sess,
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
 
@@ -652,23 +648,9 @@ static void generate_smb3encryptionkey(struct ksmbd_conn *conn,
 		     ptwin->decryption.context,
 		     sess->smb3decryptionkey, SMB3_ENC_DEC_KEY_SIZE);
 
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
 }
 
 void ksmbd_gen_smb30_encryptionkey(struct ksmbd_conn *conn,
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


