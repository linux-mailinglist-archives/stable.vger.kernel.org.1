Return-Path: <stable+bounces-7686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFD38175C8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFC8283DA7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198C5BF9C;
	Mon, 18 Dec 2023 15:38:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94BE5BF8A
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28b9460a9easo497273a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913907; x=1703518707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHPlEE6/sv2A+lOgmRcdDozVcUTdzZt8AVWt3h7uALc=;
        b=BD+35HsyxeeGKlqZ22mvR6BYgVuRmTuVmqmY3xOziENy31+DGiPCQWcEjxTK4Fw6/h
         M7Q3EfzjSe7vnMYs3RLcWnk7BHo7DBZ72I3jFPYbi+TlurnSxtpPk+FtiMN4HZ7f33cl
         6Qv8iF87Rv1XktTJEaJZRzk7y712QyItFZDpgthjOKKVlhDQvpcoz1d7IvLLFEFwbadG
         volVHYBGeFzIVA3URXn2YQdBi+vyL68ga9VVgPgNX82fdA9OqdinRFwzIfWzwREmYbKZ
         EnOYtaxofLTHhAan5YQKlvEDluIvgGT56fKJ/jD86iv7Y/nCjrbq+hw3xtFyXYJomcdi
         E7eA==
X-Gm-Message-State: AOJu0YwCVx2NbvnQ/qF458CBaAp2f3UqOqnVX+WQu6UQeI8nwAULX3vP
	j/3ap5Nys3dmajy4x4LJpDc=
X-Google-Smtp-Source: AGHT+IGURrWAsQ3OMQPd/8x5Y2uyi9w4NWmhqdC6G4OZyTI0ac9ywZNWDB8DInX3TYawTlXvAGrQbw==
X-Received: by 2002:a17:90a:3048:b0:28b:9841:68e9 with SMTP id q8-20020a17090a304800b0028b984168e9mr601711pjl.10.1702913907155;
        Mon, 18 Dec 2023 07:38:27 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:26 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 057/154] ksmbd: set NTLMSSP_NEGOTIATE_SEAL flag to challenge blob
Date: Tue, 19 Dec 2023 00:33:17 +0900
Message-Id: <20231218153454.8090-58-linkinjeon@kernel.org>
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

[ Upstream commit 5bedae90b369ca1a7660b9af39591ed19009b495 ]

If NTLMSSP_NEGOTIATE_SEAL flags is set in negotiate blob from client,
Set NTLMSSP_NEGOTIATE_SEAL flag to challenge blob.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/auth.c    | 3 +++
 fs/ksmbd/smb2pdu.c | 2 +-
 fs/ksmbd/smb2pdu.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 45f0e9a75e63..bad4c3af9540 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -428,6 +428,9 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 				   NTLMSSP_NEGOTIATE_56);
 	}
 
+	if (cflags & NTLMSSP_NEGOTIATE_SEAL && smb3_encryption_negotiated(conn))
+		flags |= NTLMSSP_NEGOTIATE_SEAL;
+
 	if (cflags & NTLMSSP_NEGOTIATE_ALWAYS_SIGN)
 		flags |= NTLMSSP_NEGOTIATE_ALWAYS_SIGN;
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 933f806f14dc..8151f7782329 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -956,7 +956,7 @@ static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
  *
  * Return:	true if connection should be encrypted, else false
  */
-static bool smb3_encryption_negotiated(struct ksmbd_conn *conn)
+bool smb3_encryption_negotiated(struct ksmbd_conn *conn)
 {
 	if (!conn->ops->generate_encryptionkey)
 		return false;
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index fe391b8afa9c..e20d4d707f1b 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -1672,6 +1672,7 @@ int smb3_decrypt_req(struct ksmbd_work *work);
 int smb3_encrypt_resp(struct ksmbd_work *work);
 bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work);
 int smb2_set_rsp_credits(struct ksmbd_work *work);
+bool smb3_encryption_negotiated(struct ksmbd_conn *conn);
 
 /* smb2 misc functions */
 int ksmbd_smb2_check_message(struct ksmbd_work *work);
-- 
2.25.1


