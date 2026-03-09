Return-Path: <stable+bounces-223550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGCpLYafrmm2GwIAu9opvQ
	(envelope-from <stable+bounces-223550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:23:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D073236F8F
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22E33302AF28
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA438F225;
	Mon,  9 Mar 2026 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="un5n+vnv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1336BCE6
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051759; cv=none; b=O3eSLOcgXKopo1G4Kh9meNZlYXYe/V45Fg/JiixYr8fF8cpHw2XF4JXQytyTduP6XiJwsMUa6bRMAYrPxbarJm/A+EsUgKfL0vaiDjgB1xzjNKODmcA81Jd1y7fMQBIzJLaBNJP65mN1fFVsbF3+2grS83azfmHeJv4N73K7Vh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051759; c=relaxed/simple;
	bh=MWwyasl3fiOwoU4MTHuNU011VlG76UoGdPDsA5KU1Qs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JUAl5ipoY1pU6DJgbGDfQob03SLUgDVRt4SNpAq3x2Du03JM9qaoxZiSoB+Du3cux7Ec8RLlD6KPqiiN6LZ5Cuzq5vS3cvQYkjbv3zIt7weSNOH8SjR8/+wNTHbjYwc8SFvZpJR5eZDWr+8aiCp15iL+u+dESdswWt1aUk1ZP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=un5n+vnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A16BC4CEF7;
	Mon,  9 Mar 2026 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051758;
	bh=MWwyasl3fiOwoU4MTHuNU011VlG76UoGdPDsA5KU1Qs=;
	h=Subject:To:Cc:From:Date:From;
	b=un5n+vnvXy0RftuCA54smYYByrTMPVq9UBz+Wq2GSPisaeu+YMfyG0Viyw1kEdZub
	 s35hKFKvvlx8NRzdlaeI9fZ2cfLrMMYQI3SwkJBXlu3rOQbnJgHo99vc62emrc7lAU
	 0vEYqwUMqLxvJs3VEsbFTZvAKvNThpKG7zBQDLNw=
Subject: FAILED: patch "[PATCH] ksmbd: Compare MACs in constant time" failed to apply to 6.18-stable tree
To: ebiggers@kernel.org,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:22:35 +0100
Message-ID: <2026030935-kimono-shale-cbae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D073236F8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223550-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.239];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c5794709bc9105935dbedef8b9cf9c06f2b559fa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030935-kimono-shale-cbae@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5794709bc9105935dbedef8b9cf9c06f2b559fa Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 17 Feb 2026 20:28:29 -0800
Subject: [PATCH] ksmbd: Compare MACs in constant time

To prevent timing attacks, MAC comparisons need to be constant-time.
Replace the memcmp() with the correct function, crypto_memneq().

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/Kconfig b/fs/smb/server/Kconfig
index 2775162c535c..12594879cb64 100644
--- a/fs/smb/server/Kconfig
+++ b/fs/smb/server/Kconfig
@@ -13,6 +13,7 @@ config SMB_SERVER
 	select CRYPTO_LIB_MD5
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_SHA512
+	select CRYPTO_LIB_UTILS
 	select CRYPTO_CMAC
 	select CRYPTO_AEAD2
 	select CRYPTO_CCM
diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 580c4d303dc3..5fe8c667c6b1 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -15,6 +15,7 @@
 #include <crypto/aead.h>
 #include <crypto/md5.h>
 #include <crypto/sha2.h>
+#include <crypto/utils.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
 
@@ -165,7 +166,8 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 			     ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE,
 			     sess->sess_key);
 
-	if (memcmp(ntlmv2->ntlmv2_hash, ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE) != 0)
+	if (crypto_memneq(ntlmv2->ntlmv2_hash, ntlmv2_rsp,
+			  CIFS_HMAC_MD5_HASH_SIZE))
 		return -EINVAL;
 	return 0;
 }
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 95901a78951c..743c629fe7ec 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4,6 +4,7 @@
  *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
  */
 
+#include <crypto/utils.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
 #include <linux/syscalls.h>
@@ -8880,7 +8881,7 @@ int smb2_check_sign_req(struct ksmbd_work *work)
 	ksmbd_sign_smb2_pdu(work->conn, work->sess->sess_key, iov, 1,
 			    signature);
 
-	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
 		return 0;
 	}
@@ -8968,7 +8969,7 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	if (ksmbd_sign_smb3_pdu(conn, signing_key, iov, 1, signature))
 		return 0;
 
-	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
 		return 0;
 	}


