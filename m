Return-Path: <stable+bounces-7653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 625A1817598
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3801F23963
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9D74095;
	Mon, 18 Dec 2023 15:36:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379827408C
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ab37d0d1so5701805ad.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913798; x=1703518598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2L0LvyrFKofiric/Fy+UcRiqkiZCnCCTw5CpngV+EQ=;
        b=V0QicNjAJXRGyD7Qixd0fvA7YRzvsGShbArqm1HhPrYYSYc/QstfWPpvLs/xH3qc5j
         IFb99Ym9XA3o5wUtRXPpvkjW4Tp0OTQ2uKQQEwNbrcgkaWSLY9vwBHRDUiJQmT4u3Kmu
         duXXVhn2Bhtq6usMMmBLP6IcnwVKTvFkrP2WMDm46nwhIkzX7tVrFtfE45lZ/wm5cBOY
         Jsq28FT/mKkp0OKnZ6dG23OATNzdv5aBZRUz2/KhXFRCyAlTBnP0zXvWvvJMmuu1MG9x
         akLujUP89c4DaxjOXhPwZi9ujfhMyfVuH0jT5mx6j3WGCIzqy53zGxz58mU8XCKHHAG+
         YW3Q==
X-Gm-Message-State: AOJu0YwrvdzK5tI6NCogSLpS/PGR7d4j5PQZ7CXAcSRhH0Df4bQpF6kV
	+K7ZramaTiGxdryE79qDysENYk8Wg1k=
X-Google-Smtp-Source: AGHT+IHJn8iMuSBgZEKRdgCjCifFtbFXeSHmPxQLDt0K2r3hULSfp0yUhN4oorMnqm6SiD3mWfjsbQ==
X-Received: by 2002:a17:902:7c8c:b0:1d0:6ffd:f230 with SMTP id y12-20020a1709027c8c00b001d06ffdf230mr8099751pll.134.1702913798357;
        Mon, 18 Dec 2023 07:36:38 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:37 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 024/154] ksmbd: add support for key exchange
Date: Tue, 19 Dec 2023 00:32:44 +0900
Message-Id: <20231218153454.8090-25-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/ksmbd/auth.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 33cb94ed6f66..2048e0546116 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -29,6 +29,7 @@
 #include "mgmt/user_config.h"
 #include "crypto_ctx.h"
 #include "transport_ipc.h"
+#include "../smbfs_common/arc4.h"
 
 /*
  * Fixed format data defining GSS header and fixed string
@@ -342,6 +343,29 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
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
 
@@ -414,6 +438,9 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 	    (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC))
 		flags |= NTLMSSP_NEGOTIATE_EXTENDED_SEC;
 
+	if (cflags & NTLMSSP_NEGOTIATE_KEY_XCH)
+		flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
+
 	chgblob->NegotiateFlags = cpu_to_le32(flags);
 	len = strlen(ksmbd_netbios_name());
 	name = kmalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
-- 
2.25.1


