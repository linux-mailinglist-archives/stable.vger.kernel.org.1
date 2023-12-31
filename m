Return-Path: <stable+bounces-9048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D642820A01
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4179AB21797
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F617C7;
	Sun, 31 Dec 2023 07:14:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419951844
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce2170b716so3476232a12.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006873; x=1704611673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9U1gy2iyKe/DjNXHbaYw7qexDxNTzqOKmiWrh12h24=;
        b=rIRjz0SPVzF5IHO8IDLkoek13+INPEZPxadiSdzcZPTXFb3iWho7MN5P/K1QQ2XONC
         u3CzhQPodqYDjdXnNuoJofhuZP5fDVXToAiKUU3nPrKVLx1cKrlbHiN3Z4M92GQXtAh7
         zQaD76d2tT+ZDgv4vijqDAyJi2rGECIfJCHWawmA4YGJknVZeRCU7B5wr6WKM2CCtSCB
         CBPafEj/tEtDa2IHFPk1m739jKFEMqB9bu+wTVYQ1c2ZsyVmReCAmn3ddNasor5NN1bM
         0vR/fVdL/4fCX7M0YAZosYKDb6BgDIpCBvYStFBlanibv3J0OZWDqkgbKp70Ljz/0Aa7
         sj6Q==
X-Gm-Message-State: AOJu0YxIy1/N7PcTpz5TqTpcy8Tx7O2m2cOOcbwX56qxMs88X9yCYdnp
	dUJmiwVnYgo2j+lmcTitcOc=
X-Google-Smtp-Source: AGHT+IHhQ6q7gitoDDr1+YNdAgv6VygpVgbYGEi/z4mv1C/ToKyE96IRsTCgZBLZ8UXjKf+D9LGSRQ==
X-Received: by 2002:a05:6a20:3944:b0:196:ad4e:b0d4 with SMTP id r4-20020a056a20394400b00196ad4eb0d4mr2271187pzg.66.1704006873549;
        Sat, 30 Dec 2023 23:14:33 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:33 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	David Disseldorp <ddiss@suse.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 14/73] ksmbd: set NegotiateContextCount once instead of every inc
Date: Sun, 31 Dec 2023 16:12:33 +0900
Message-Id: <20231231071332.31724-15-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
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
 fs/smb/server/smb2pdu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ee128f5d38c3..c7d43c83d233 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -847,7 +847,6 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		    "assemble SMB2_PREAUTH_INTEGRITY_CAPABILITIES context\n");
 	build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt,
 			   conn->preauth_info->Preauth_HashId);
-	rsp->NegotiateContextCount = cpu_to_le16(neg_ctxt_cnt);
 	inc_rfc1001_len(smb2_buf_len, AUTH_GSS_PADDING);
 	ctxt_size = sizeof(struct smb2_preauth_neg_context);
 	/* Round to 8 byte boundary */
@@ -859,7 +858,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 			    "assemble SMB2_ENCRYPTION_CAPABILITIES context\n");
 		build_encrypt_ctxt((struct smb2_encryption_neg_context *)pneg_ctxt,
 				   conn->cipher_type);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_encryption_neg_context) + 2;
 		/* Round to 8 byte boundary */
 		pneg_ctxt +=
@@ -874,7 +873,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		/* Temporarily set to SMB3_COMPRESS_NONE */
 		build_compression_ctxt((struct smb2_compression_capabilities_context *)pneg_ctxt,
 				       conn->compress_algorithm);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_compression_capabilities_context) + 2;
 		/* Round to 8 byte boundary */
 		pneg_ctxt += round_up(sizeof(struct smb2_compression_capabilities_context) + 2,
@@ -886,7 +885,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		ksmbd_debug(SMB,
 			    "assemble SMB2_POSIX_EXTENSIONS_AVAILABLE context\n");
 		build_posix_ctxt((struct smb2_posix_neg_context *)pneg_ctxt);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_posix_neg_context);
 		/* Round to 8 byte boundary */
 		pneg_ctxt += round_up(sizeof(struct smb2_posix_neg_context), 8);
@@ -898,10 +897,11 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
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


