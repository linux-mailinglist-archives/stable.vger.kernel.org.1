Return-Path: <stable+bounces-7712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D78175E7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0ED28407C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B715D72F;
	Mon, 18 Dec 2023 15:39:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1171446
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28b9460a9easo498933a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913988; x=1703518788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1PbRt6iAqPIycg58fpuBssryL3nUXYhHeP+fbMI0CM=;
        b=n0TNpyL9SD31CW4HLaRwvOIJgsVi9EYDLceDSbP4AMsFNiWvHfh8MWHXVR9pPxU+1I
         BVWxEXh+8RtQKOxu9JONrJYIjEyltctpQyLWMGKYMaYv2NfvqO1Aqk9Wg6WUVrZV8d+E
         EahDYARpjOyoQPL0QHBSVUGXA8BFhhzkXeq24Fvn2Z1fJOJCtZn/1U1WTwAec9uml9d6
         B30hHXwbOEqcUKOPWJ6owSZytti4D2VYmvQs66Pnv/Ajb5WoOr+a/j0iDm1rM1C1zRMc
         Gy6pQUbCxAUFc5VU2p8ENX/drh3pf1VFsufyqhOKmm8hwAMv7kSqv2+GPgku2ThrMyU5
         g1tg==
X-Gm-Message-State: AOJu0Yz6rupSe2PpfHjA6iHeZtMTZypCmNibc8HQmP/IJrw4tWbfG1b5
	IB6nPK2ryo4HJcFmW5EqDRTmVE7NRK0=
X-Google-Smtp-Source: AGHT+IFMusY9PBihfQcqruU0HWglFHjt+NcRIx/iaepJC4H/KzOixe9zZRJRC2QrMiYVQy4Aj+k2xw==
X-Received: by 2002:a17:90b:397:b0:28b:a896:9ef1 with SMTP id ga23-20020a17090b039700b0028ba8969ef1mr346685pjb.86.1702913987487;
        Mon, 18 Dec 2023 07:39:47 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:47 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	David Disseldorp <ddiss@suse.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 083/154] ksmbd: set NegotiateContextCount once instead of every inc
Date: Tue, 19 Dec 2023 00:33:43 +0900
Message-Id: <20231218153454.8090-84-linkinjeon@kernel.org>
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

[ Upstream commit 34e8ccf9ce24b6b2e275bbe35cd392e18fbbd369 ]

There are no early returns, so marshalling the incremented
NegotiateContextCount with every context is unnecessary.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 472aa5fa0d10..d8985fe42ac6 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -848,7 +848,6 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		    "assemble SMB2_PREAUTH_INTEGRITY_CAPABILITIES context\n");
 	build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt,
 			   conn->preauth_info->Preauth_HashId);
-	rsp->NegotiateContextCount = cpu_to_le16(neg_ctxt_cnt);
 	inc_rfc1001_len(smb2_buf_len, AUTH_GSS_PADDING);
 	ctxt_size = sizeof(struct smb2_preauth_neg_context);
 	/* Round to 8 byte boundary */
@@ -860,7 +859,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 			    "assemble SMB2_ENCRYPTION_CAPABILITIES context\n");
 		build_encrypt_ctxt((struct smb2_encryption_neg_context *)pneg_ctxt,
 				   conn->cipher_type);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_encryption_neg_context) + 2;
 		/* Round to 8 byte boundary */
 		pneg_ctxt +=
@@ -875,7 +874,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		/* Temporarily set to SMB3_COMPRESS_NONE */
 		build_compression_ctxt((struct smb2_compression_ctx *)pneg_ctxt,
 				       conn->compress_algorithm);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_compression_ctx) + 2;
 		/* Round to 8 byte boundary */
 		pneg_ctxt += round_up(sizeof(struct smb2_compression_ctx) + 2,
@@ -887,7 +886,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		ksmbd_debug(SMB,
 			    "assemble SMB2_POSIX_EXTENSIONS_AVAILABLE context\n");
 		build_posix_ctxt((struct smb2_posix_neg_context *)pneg_ctxt);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_posix_neg_context);
 		/* Round to 8 byte boundary */
 		pneg_ctxt += round_up(sizeof(struct smb2_posix_neg_context), 8);
@@ -899,10 +898,11 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 			    "assemble SMB2_SIGNING_CAPABILITIES context\n");
 		build_sign_cap_ctxt((struct smb2_signing_capabilities *)pneg_ctxt,
 				    conn->signing_algorithm);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_signing_capabilities) + 2;
 	}
 
+	rsp->NegotiateContextCount = cpu_to_le16(neg_ctxt_cnt);
 	inc_rfc1001_len(smb2_buf_len, ctxt_size);
 }
 
-- 
2.25.1


