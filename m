Return-Path: <stable+bounces-274289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bKaSAP1LVmoT3AAAu9opvQ
	(envelope-from <stable+bounces-274289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:47:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E97756084
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:47:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="zqvo/2o2";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274289-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274289-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 584CE3049E06
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFA03A4F55;
	Tue, 14 Jul 2026 14:39:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1E3D9DD7
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:39:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039985; cv=none; b=tq7Qh6CFi0p5UG+fLPs3U4SYYqJdfvlUGOO5GL08uZWoTIj+X1R0ak/1SKISDd8ACdzCqLGyfRGG3OfyC1HwY6HLO6Sqfpig7TPSkTbjDgHYHuggVI1fQfr1hIEOlJkAXwuJ0k+aiWED7SnrDiiOLy4YHAXvj57mdyis09X3BzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039985; c=relaxed/simple;
	bh=QUfWLxYnrTatekuzlfrvHj4mSABHQM3uQTD3LIOER+E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bwc/EaAGcNuHdJ3MBXSmcRUOeWgdomuQTDbi9jPuzUOHZyO4avCQBpIXgiwPKPrKbyUmeyCc6TDeyxiGmAoSExdSrXfeMAplq0kJGR6bNj6zaSQe+vRaDzZK08hKoQQ/azxAY5KxOR3HcG2rlfKflAjxV5peIMlvpSPUyTkTQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zqvo/2o2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A8D1F000E9;
	Tue, 14 Jul 2026 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784039983;
	bh=xLtyv03InINs8JuCZY199wOxZESv96LQoTyu0hVIiC0=;
	h=Subject:To:Cc:From:Date;
	b=zqvo/2o2GR/ldz3nfSkewpH5E/iZSS2gdevlodPKEsQIMXd/p3Cs+GBupTZYrORZg
	 nOA1KGyy/S+tVi4bkiepZwJU0OaxQCAsGi0qAQRo1JAJwV1+ZKw/b0rG7PylpZtkhI
	 ZgmyZkXhuVsAOPVK3ibEyM5G0tTwnSYY1HjBZ+FM=
Subject: FAILED: patch "[PATCH] ksmbd: validate NTLMv2 response before updating session key" failed to apply to 6.6-stable tree
To: lihaofeng@kylinos.cn,chenxiaosong@kylinos.cn,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:39:28 +0200
Message-ID: <2026071428-stays-dinghy-8521@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274289-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lihaofeng@kylinos.cn,m:chenxiaosong@kylinos.cn,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gregkh:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33E97756084


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 954d196bebb2b50151cb96454c72dc113b2af1ac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071428-stays-dinghy-8521@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 954d196bebb2b50151cb96454c72dc113b2af1ac Mon Sep 17 00:00:00 2001
From: Haofeng Li <lihaofeng@kylinos.cn>
Date: Tue, 23 Jun 2026 09:30:26 +0800
Subject: [PATCH] ksmbd: validate NTLMv2 response before updating session key

ksmbd_auth_ntlmv2() derives the NTLMv2 session key into
sess->sess_key before it verifies the NTLMv2 response.
ksmbd_decode_ntlmssp_auth_blob() then continues into KEY_XCH even
when ksmbd_auth_ntlmv2() failed.

With SMB3 multichannel binding, the failed authentication operates on
an existing session and the session setup error path does not expire
binding sessions. A client can send a binding session setup with a
bad NT proof and KEY_XCH and still modify sess->sess_key before
STATUS_LOGON_FAILURE is returned.

Relevant path:

  smb2_sess_setup()
    -> conn->binding = true
    -> ntlm_authenticate()
       -> session_user()
       -> ksmbd_decode_ntlmssp_auth_blob()
          -> ksmbd_auth_ntlmv2()
             -> calc_ntlmv2_hash()
             -> hmac_md5_usingrawkey(..., sess->sess_key)
             -> crypto_memneq() returns mismatch
          -> KEY_XCH arc4_crypt(..., sess->sess_key, ...)
    -> out_err without expiring the binding session

Derive the base session key into a local buffer and copy it to
sess->sess_key only after the proof matches. Return immediately on
authentication failure so KEY_XCH is only processed after successful
authentication.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Fixes: f9929ef6a2a5 ("ksmbd: add support for key exchange")
Cc: stable@vger.kernel.org
Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index e99409fa721c..86f521e849d5 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -142,6 +142,7 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 {
 	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
 	char ntlmv2_rsp[CIFS_HMAC_MD5_HASH_SIZE];
+	char sess_key[SMB2_NTLMV2_SESSKEY_SIZE];
 	struct hmac_md5_ctx ctx;
 	int rc;
 
@@ -164,12 +165,21 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 	/* Generate the session key */
 	hmac_md5_usingrawkey(ntlmv2_hash, CIFS_HMAC_MD5_HASH_SIZE,
 			     ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE,
-			     sess->sess_key);
+			     sess_key);
 
 	if (crypto_memneq(ntlmv2->ntlmv2_hash, ntlmv2_rsp,
-			  CIFS_HMAC_MD5_HASH_SIZE))
-		return -EINVAL;
-	return 0;
+			  CIFS_HMAC_MD5_HASH_SIZE)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	memcpy(sess->sess_key, sess_key, sizeof(sess_key));
+	rc = 0;
+out:
+	memzero_explicit(ntlmv2_hash, sizeof(ntlmv2_hash));
+	memzero_explicit(ntlmv2_rsp, sizeof(ntlmv2_rsp));
+	memzero_explicit(sess_key, sizeof(sess_key));
+	return rc;
 }
 
 /**
@@ -226,6 +236,8 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 				nt_len - CIFS_ENCPWD_SIZE,
 				domain_name, conn->ntlmssp.cryptkey);
 	kfree(domain_name);
+	if (ret)
+		return ret;
 
 	/* The recovered secondary session key */
 	if (conn->ntlmssp.client_flags & NTLMSSP_NEGOTIATE_KEY_XCH) {


