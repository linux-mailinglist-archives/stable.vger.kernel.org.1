Return-Path: <stable+bounces-8022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FCD81A419
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D4CB26779
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D7D487AC;
	Wed, 20 Dec 2023 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="07I6C86g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FBF482E5;
	Wed, 20 Dec 2023 16:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1B2C433C7;
	Wed, 20 Dec 2023 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088694;
	bh=/2mAhGIrgsV56ow387Ety1su+T5fB0QrXNRJ+fZOy8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=07I6C86gu5Y8hjmhUy8GLJKJznFqnKTq2YpIo0BRqvUZD6Z1YNH1pA5rKlo/ZDkR4
	 eyqiNN7XdcDl98hg9OziPenEWXjlP9Qgk591TE//XpD7tkJsgvUyCztAu8MbKVlOOH
	 5IH/Tseh5mqonJahu3sDrdpyjKUYgbQPuIgYGRDo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 024/159] ksmbd: add support for key exchange
Date: Wed, 20 Dec 2023 17:08:09 +0100
Message-ID: <20231220160932.404226580@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit f9929ef6a2a55f03aac61248c6a3a987b8546f2a ]

When mounting cifs client, can see the following warning message.

CIFS: decode_ntlmssp_challenge: authentication has been weakened as server
does not support key exchange

To remove this warning message, Add support for key exchange feature to
ksmbd. This patch decrypts 16-byte ciphertext value sent by the client
using RC4 with session key. The decrypted value is the recovered secondary
key that will use instead of the session key for signing and sealing.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/auth.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -29,6 +29,7 @@
 #include "mgmt/user_config.h"
 #include "crypto_ctx.h"
 #include "transport_ipc.h"
+#include "../smbfs_common/arc4.h"
 
 /*
  * Fixed format data defining GSS header and fixed string
@@ -342,6 +343,29 @@ int ksmbd_decode_ntlmssp_auth_blob(struc
 				nt_len - CIFS_ENCPWD_SIZE,
 				domain_name, conn->ntlmssp.cryptkey);
 	kfree(domain_name);
+
+	/* The recovered secondary session key */
+	if (conn->ntlmssp.client_flags & NTLMSSP_NEGOTIATE_KEY_XCH) {
+		struct arc4_ctx *ctx_arc4;
+		unsigned int sess_key_off, sess_key_len;
+
+		sess_key_off = le32_to_cpu(authblob->SessionKey.BufferOffset);
+		sess_key_len = le16_to_cpu(authblob->SessionKey.Length);
+
+		if (blob_len < (u64)sess_key_off + sess_key_len)
+			return -EINVAL;
+
+		ctx_arc4 = kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
+		if (!ctx_arc4)
+			return -ENOMEM;
+
+		cifs_arc4_setkey(ctx_arc4, sess->sess_key,
+				 SMB2_NTLMV2_SESSKEY_SIZE);
+		cifs_arc4_crypt(ctx_arc4, sess->sess_key,
+				(char *)authblob + sess_key_off, sess_key_len);
+		kfree_sensitive(ctx_arc4);
+	}
+
 	return ret;
 }
 
@@ -414,6 +438,9 @@ ksmbd_build_ntlmssp_challenge_blob(struc
 	    (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC))
 		flags |= NTLMSSP_NEGOTIATE_EXTENDED_SEC;
 
+	if (cflags & NTLMSSP_NEGOTIATE_KEY_XCH)
+		flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
+
 	chgblob->NegotiateFlags = cpu_to_le32(flags);
 	len = strlen(ksmbd_netbios_name());
 	name = kmalloc(2 + UNICODE_LEN(len), GFP_KERNEL);



