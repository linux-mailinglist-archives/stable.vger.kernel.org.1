Return-Path: <stable+bounces-7714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD24E8175EA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D0228453D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A6971449;
	Mon, 18 Dec 2023 15:39:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DD4878F
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3536cd414so27112505ad.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913994; x=1703518794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX76N9rFJSV6AuOaG1D49pm7RdDSvRil/Bj2SNCDjm8=;
        b=dW5LsW6pILwRcGK0z+sYyatHL6b4HMidkUb5jSYtKuq83TQ4NEl+0f+SW2J9WHSzW8
         PLZ1SK7gbVO/vz7HvQKY39en8rFoQcm0rRQTuZc/Ruvggg4wGfCJwe/wXkqAJCwiNSmi
         rGVPlhcCFYj31g4ZtF0Wbg/XsRHSMt99bcVcRtEMjdrfHjKDm+0DtR4QbASJvPZQ1mUa
         twRW1/KyM7vtOiSoAoSf5X427XBKgUpMRiNZHgmOSMtqfnaxPUNnevI3X68qePllkZ4V
         A0L+oS2OjzxKorc3ZqCGK8fZ1t5+lW7vxpX5pl/jN2lGnGey7iPkZbO85jhPtXrMgBBo
         QRvg==
X-Gm-Message-State: AOJu0Yx9xAymPpAS2UwgEOoeDfH+syi1j1hHRrAaRQz49+KJQUlmHAzJ
	dL4Xo7wlNtSnVOXzQJNOGF0=
X-Google-Smtp-Source: AGHT+IHZ0WIQErGxw79CR7q8g9UhEGh8ySAGWClKBDwf6q3YB/FLi5YQjMxUh0UHzWGbsFGoBuRokw==
X-Received: by 2002:a17:90b:4d87:b0:28b:7a11:6e70 with SMTP id oj7-20020a17090b4d8700b0028b7a116e70mr950248pjb.76.1702913993865;
        Mon, 18 Dec 2023 07:39:53 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:53 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	David Disseldorp <ddiss@suse.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 085/154] ksmbd: remove unused compression negotiate ctx packing
Date: Tue, 19 Dec 2023 00:33:45 +0900
Message-Id: <20231218153454.8090-86-linkinjeon@kernel.org>
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

From: David Disseldorp <ddiss@suse.de>

[ Upstream commit af36c51e0e111de4e908328d49cba49de758f66e ]

build_compression_ctxt() is currently unreachable due to
conn.compress_algorithm remaining zero (SMB3_COMPRESS_NONE).

It appears to have been broken in a couple of subtle ways over the
years:
- prior to d6c9ad23b421 ("ksmbd: use the common definitions for
  NEGOTIATE_PROTOCOL") smb2_compression_ctx.DataLength was set to 8,
  which didn't account for the single CompressionAlgorithms flexible
  array member.
- post d6c9ad23b421 smb2_compression_capabilities_context
  CompressionAlgorithms is a three member array, while
  CompressionAlgorithmCount is set to indicate only one member.
  assemble_neg_contexts() ctxt_size is also incorrectly incremented by
  sizeof(struct smb2_compression_capabilities_context) + 2, which
  assumes one flexible array member.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 06c184927d66..37cb9375eb62 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -787,19 +787,6 @@ static void build_encrypt_ctxt(struct smb2_encryption_neg_context *pneg_ctxt,
 	pneg_ctxt->Ciphers[0] = cipher_type;
 }
 
-static void build_compression_ctxt(struct smb2_compression_ctx *pneg_ctxt,
-				   __le16 comp_algo)
-{
-	pneg_ctxt->ContextType = SMB2_COMPRESSION_CAPABILITIES;
-	pneg_ctxt->DataLength =
-		cpu_to_le16(sizeof(struct smb2_compression_ctx)
-			- sizeof(struct smb2_neg_context));
-	pneg_ctxt->Reserved = cpu_to_le32(0);
-	pneg_ctxt->CompressionAlgorithmCount = cpu_to_le16(1);
-	pneg_ctxt->Reserved1 = cpu_to_le32(0);
-	pneg_ctxt->CompressionAlgorithms[0] = comp_algo;
-}
-
 static void build_sign_cap_ctxt(struct smb2_signing_capabilities *pneg_ctxt,
 				__le16 sign_algo)
 {
@@ -862,18 +849,8 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_encryption_neg_context) + 2;
 	}
-
-	if (conn->compress_algorithm) {
-		ctxt_size = round_up(ctxt_size, 8);
-		ksmbd_debug(SMB,
-			    "assemble SMB2_COMPRESSION_CAPABILITIES context\n");
-		/* Temporarily set to SMB3_COMPRESS_NONE */
-		build_compression_ctxt((struct smb2_compression_ctx *)
-				       (pneg_ctxt + ctxt_size),
-				       conn->compress_algorithm);
-		neg_ctxt_cnt++;
-		ctxt_size += sizeof(struct smb2_compression_ctx) + 2;
-	}
+	/* compression context not yet supported */
+	WARN_ON(conn->compress_algorithm != SMB3_COMPRESS_NONE);
 
 	if (conn->posix_ext_supported) {
 		ctxt_size = round_up(ctxt_size, 8);
-- 
2.25.1


