Return-Path: <stable+bounces-161184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11746AFD3D8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9BA1891CA1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558FF2E4985;
	Tue,  8 Jul 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GgTJ5Vi4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13511258CF7;
	Tue,  8 Jul 2025 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993838; cv=none; b=pTJCh4frPesEijJLYhiqrNAmivkCF9vlPqGcy3cYlnABnBajP84LdjZa5X9OkRuZr+rOipfleqNXwvo4VhRdqxvXyxvEHW7dunXXzZmxstj6EDVucePP/pTz45neEJVek1NWNpgv8yfTyVu5VG3RjBxuc8oJsbeDYACRRxLNeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993838; c=relaxed/simple;
	bh=dlcqTbcgYe03c3aayuNfoUqG01YZ61Ls2mmmu+UmIP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9nUXQVdFT9a+JsD+VpXFimrBTfef0j4QubO2KlVGBnd4UrqVzL5p7xiyY78YcoBQ0gPoX2YYnbUTwrn5gl8/iDS4laj+QpTSeYT1hkbYxexgEJB+RxWWzBzkcw7GfFuTOmMWnnUONrmVicMu/jhxKbsBNwgRl2QD7G+7UE5vMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GgTJ5Vi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBCEC4CEED;
	Tue,  8 Jul 2025 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993837;
	bh=dlcqTbcgYe03c3aayuNfoUqG01YZ61Ls2mmmu+UmIP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgTJ5Vi4N9SaqLgsAwJvN6L5YRI8Wq5wc+BoNmuAdmSGg99RyfnD4Td3A72nLV0UB
	 zC6ui7Vd/8cv0iJhlYu9UzwTwc1LiaAixAubAc5Aoxj8J8CnDVabKbrZdFmyxbXJI2
	 2SE3CbEn6wv0u4E+zeW2/9OledcRzuzsWg+ciTMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Kerling <pkerling@casix.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 008/160] ksmbd: allow a filename to contain special characters on SMB3.1.1 posix extension
Date: Tue,  8 Jul 2025 18:20:45 +0200
Message-ID: <20250708162231.740783832@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
User-Agent: quilt/0.68
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

[ Upstream commit dc3e0f17f74558e8a2fce00608855f050de10230 ]

If client send SMB2_CREATE_POSIX_CONTEXT to ksmbd, Allow a filename
to contain special characters.

Reported-by: Philipp Kerling <pkerling@casix.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 53 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b21601c0a457c..76334a983cd25 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2679,7 +2679,7 @@ int smb2_open(struct ksmbd_work *work)
 	int req_op_level = 0, open_flags = 0, may_flags = 0, file_info = 0;
 	int rc = 0;
 	int contxt_cnt = 0, query_disk_id = 0;
-	int maximal_access_ctxt = 0, posix_ctxt = 0;
+	bool maximal_access_ctxt = false, posix_ctxt = false;
 	int s_type = 0;
 	int next_off = 0;
 	char *name = NULL;
@@ -2706,6 +2706,27 @@ int smb2_open(struct ksmbd_work *work)
 		return create_smb2_pipe(work);
 	}
 
+	if (req->CreateContextsOffset && tcon->posix_extensions) {
+		context = smb2_find_context_vals(req, SMB2_CREATE_TAG_POSIX, 16);
+		if (IS_ERR(context)) {
+			rc = PTR_ERR(context);
+			goto err_out2;
+		} else if (context) {
+			struct create_posix *posix = (struct create_posix *)context;
+
+			if (le16_to_cpu(context->DataOffset) +
+				le32_to_cpu(context->DataLength) <
+			    sizeof(struct create_posix) - 4) {
+				rc = -EINVAL;
+				goto err_out2;
+			}
+			ksmbd_debug(SMB, "get posix context\n");
+
+			posix_mode = le32_to_cpu(posix->Mode);
+			posix_ctxt = true;
+		}
+	}
+
 	if (req->NameLength) {
 		if ((req->CreateOptions & FILE_DIRECTORY_FILE_LE) &&
 		    *(char *)req->Buffer == '\\') {
@@ -2737,9 +2758,11 @@ int smb2_open(struct ksmbd_work *work)
 				goto err_out2;
 		}
 
-		rc = ksmbd_validate_filename(name);
-		if (rc < 0)
-			goto err_out2;
+		if (posix_ctxt == false) {
+			rc = ksmbd_validate_filename(name);
+			if (rc < 0)
+				goto err_out2;
+		}
 
 		if (ksmbd_share_veto_filename(share, name)) {
 			rc = -ENOENT;
@@ -2854,28 +2877,6 @@ int smb2_open(struct ksmbd_work *work)
 			rc = -EBADF;
 			goto err_out2;
 		}
-
-		if (tcon->posix_extensions) {
-			context = smb2_find_context_vals(req,
-							 SMB2_CREATE_TAG_POSIX, 16);
-			if (IS_ERR(context)) {
-				rc = PTR_ERR(context);
-				goto err_out2;
-			} else if (context) {
-				struct create_posix *posix =
-					(struct create_posix *)context;
-				if (le16_to_cpu(context->DataOffset) +
-				    le32_to_cpu(context->DataLength) <
-				    sizeof(struct create_posix) - 4) {
-					rc = -EINVAL;
-					goto err_out2;
-				}
-				ksmbd_debug(SMB, "get posix context\n");
-
-				posix_mode = le32_to_cpu(posix->Mode);
-				posix_ctxt = 1;
-			}
-		}
 	}
 
 	if (ksmbd_override_fsids(work)) {
-- 
2.39.5




