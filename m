Return-Path: <stable+bounces-8083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D61DD81A476
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787BAB27EE4
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D7B4B5A0;
	Wed, 20 Dec 2023 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ps5Ij9Mz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286BE4177F;
	Wed, 20 Dec 2023 16:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411FAC433C7;
	Wed, 20 Dec 2023 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088861;
	bh=qjMA3nyD5JIs4CzhkksRILUYBmLoGqqIDLlaIl3Lbqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ps5Ij9MzyDJtgbeD/5JgLND5Hf4Ac/qCPD2Zy6GCnyc4x5n43nPXlANsvzUbg4m9t
	 BgZGdDp3a3+Xv5L9CTFHtp225aYYry6HJX+bm3FIF4shza35ureAdmBPZO620qh7pS
	 2FVsxB1OeWk/rJzVYQB1P1FdZc6AdL/fpCh0YXCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Disseldorp <ddiss@suse.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 085/159] ksmbd: remove unused compression negotiate ctx packing
Date: Wed, 20 Dec 2023 17:09:10 +0100
Message-ID: <20231220160935.342782950@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |   27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -787,19 +787,6 @@ static void build_encrypt_ctxt(struct sm
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
@@ -862,18 +849,8 @@ static void assemble_neg_contexts(struct
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



