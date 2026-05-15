Return-Path: <stable+bounces-247402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C1OqFGDABmo2ngIAu9opvQ
	(envelope-from <stable+bounces-247402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:42:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C54F754A138
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAF5C301E945
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF0382F1B;
	Fri, 15 May 2026 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="dogdxfVT"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636D3016F7
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827355; cv=none; b=O1BniazAgGUykLdhGy4VzFGnvUVQ7V0ruzWp1OGa6fYytQakupGaKIZk2Rroq7p3tZhBcUIQEqvJ2U5u3FgP50OoDLT/i/3f2IckSqxFDH/0JJsK6Y8uA6OwVgxx7QrDu9quqEj/ICQjT4ywVNAM5yxO+E4BaVAtebmyazEErqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827355; c=relaxed/simple;
	bh=cBliRQreQ5Z8fGd8hc8VuDT9dT4MHhfSsLEWXio4x9I=;
	h=From:To:Subject:Date:Message-Id; b=t15w/LU5DMWWxgCPxAf/qkUydY96oJPGhG3sQ6PRf08TcutWRzUX6qOum0fGyIXxIBrcwgicSkhl/xK+vZc2QqMR4/YdcjwXz8fgPjGoROIGWGbdPjMAA+EB31q7Pg9D9yv5e06wp9ziI5xQwSvIVu2YuMHaxWYQSoSI6sEB3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=dogdxfVT; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=dogdxfVTDp6i6FhSljRQeFMxtCqtk3fHro/Ye4EShG/gmw572n8UMbrSdCt3joNSk8pxVuribe0hp
	 WlXCJskXZPG/sTojfumy7etB3y69s7wcD6yMETnPxDaZeBHB9uUhzkjbz+og2+NnEmmpDbsfnH3s+P
	 2XjgUTHwXzn5/jAQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.248.164])
	by rmsmtp-lg-appmail-05-12083 (RichMail) with SMTP id 2f336a06c050e7a-4ebc6;
	Fri, 15 May 2026 14:42:26 +0800 (CST)
X-RM-TRANSID:2f336a06c050e7a-4ebc6
From: Rajani Kantha <681739313@139.com>
To: ebiggers@kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] ksmbd: Compare MACs in constant time
Date: Fri, 15 May 2026 14:42:19 +0800
Message-Id: <20260515064219.3087-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: C54F754A138
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247402-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	NEURAL_SPAM(0.00)[0.865];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Eric Biggers <ebiggers@kernel.org>

commit c5794709bc9105935dbedef8b9cf9c06f2b559fa upstream.

To prevent timing attacks, MAC comparisons need to be constant-time.
Replace the memcmp() with the correct function, crypto_memneq().

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 fs/ksmbd/Kconfig   | 1 +
 fs/ksmbd/auth.c    | 4 +++-
 fs/ksmbd/smb2pdu.c | 5 +++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
index d036ab80fec3..9f22849c50d9 100644
--- a/fs/ksmbd/Kconfig
+++ b/fs/ksmbd/Kconfig
@@ -10,6 +10,7 @@ config SMB_SERVER
 	select CRYPTO_HMAC
 	select CRYPTO_ECB
 	select CRYPTO_LIB_DES
+	select CRYPTO_LIB_UTILS
 	select CRYPTO_SHA256
 	select CRYPTO_CMAC
 	select CRYPTO_SHA512
diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 647692ca78a2..1fc76e41622c 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -13,6 +13,7 @@
 #include <linux/xattr.h>
 #include <crypto/hash.h>
 #include <crypto/aead.h>
+#include <crypto/utils.h>
 #include <linux/random.h>
 #include <linux/scatterlist.h>
 
@@ -281,7 +282,8 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 		goto out;
 	}
 
-	if (memcmp(ntlmv2->ntlmv2_hash, ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE) != 0)
+	if (crypto_memneq(ntlmv2->ntlmv2_hash, ntlmv2_rsp,
+			  CIFS_HMAC_MD5_HASH_SIZE))
 		rc = -EINVAL;
 out:
 	if (ctx)
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 978a103e72bb..163b51ef5dda 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4,6 +4,7 @@
  *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
  */
 
+#include <crypto/utils.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
 #include <linux/syscalls.h>
@@ -8433,7 +8434,7 @@ int smb2_check_sign_req(struct ksmbd_work *work)
 				signature))
 		return 0;
 
-	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
 		return 0;
 	}
@@ -8521,7 +8522,7 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	if (ksmbd_sign_smb3_pdu(conn, signing_key, iov, 1, signature))
 		return 0;
 
-	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+	if (crypto_memneq(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
 		pr_err("bad smb2 signature\n");
 		return 0;
 	}
-- 
2.17.1



