Return-Path: <stable+bounces-229300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L8RJAVdwWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:32:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 058EC2F6710
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFEC330DFB3D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED63D3B5306;
	Mon, 23 Mar 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IFHdy9Uz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2725392A;
	Mon, 23 Mar 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278684; cv=none; b=CgGpHWAHYy2+xilgc26/j42x54ubx9EdSKO9/3YOjFfxfOSMDPGNMfzwMhDKjb+U3PVDHRJxuEuGlBq3irLS1j1lu47RcVMaZDAOWM4oXKVAAj93lYLUBTNuUU2UiFRU+gLgYiWIoJHeUELSxWuIl7/l3623UF4IoQLhhA/8Bvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278684; c=relaxed/simple;
	bh=dqvrWmMIL4NOHrbNNpsSmoulsEReZFjfzXYNk8MKwt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AI7pZWIWBPef834JIYkX3p2k0qiBS5IR4soXk4xpa2wZLCR1S5nPLuRJt2QRcojl/06dGgRPJU8nKRZRf0p68bVXLvuuEnbJIJdZ0GiEWPzulYcmWQbG8R+TTwbbIyYvzvqqYo51tBHFUiovyHfNMlYA0/RJAK/n9HCCFnOsK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IFHdy9Uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7A2C4CEF7;
	Mon, 23 Mar 2026 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278684;
	bh=dqvrWmMIL4NOHrbNNpsSmoulsEReZFjfzXYNk8MKwt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFHdy9UzJFEaEvDGCyUrGqmj0wtNRhF/Q6nhW5eoiA40jFR5y1Wim2RxQRg2catzQ
	 fzNHiPQLmjvpBPKrX/kdx7//zmHKUe8wSj7m6ekRa1BAAFhoX4eDm/+aWUYn137t52
	 r7llRZGiqS5HeMWvfIgoafCbSxF9JojyFstn0LTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 387/567] ksmbd: Dont log keys in SMB3 signing and encryption key generation
Date: Mon, 23 Mar 2026 14:45:07 +0100
Message-ID: <20260323134543.428664081@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229300-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 058EC2F6710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/auth.c |   22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -797,12 +797,8 @@ static int generate_smb3signingkey(struc
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
 
@@ -866,23 +862,9 @@ static int generate_smb3encryptionkey(st
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
 



