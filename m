Return-Path: <stable+bounces-7680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C08175C1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF26B2239E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B45A852;
	Mon, 18 Dec 2023 15:38:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B325A840
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28b436f6cb9so2343293a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913889; x=1703518689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkTme9/MHLqPrLyWlWQBBxCypSnVtDPsNGXa0TbyjI4=;
        b=EcLKRa56D/dh1DJbMdNNBKKMoOEXx1NIu5EFv1CW39oJsawVpZ6QgtNqYaFAQkn62k
         Byl+Izm28UBTrDQf7zpVta2F9ET96jn7CBmnf3I0brzwfInA4B2nV4MKgOCMe0NsSG1+
         QCACYmVPvIrLmAsJni/Ob0L5QeXquncFsS4PtxOvGqiwFunh7WC5TReFo246TjbE6u9L
         mfkinpDKMik/zJSB+dufmSc27+VrwI7Np5Yx+GBVoIHuvDWMfxx5pmA8XbGO91oPB6xW
         wf2c79T8UPUKl8g36kQBz+OApis2saNlQYtvtdz70EvolXAEvlJJcG+VsblxMJXXctN4
         pEOw==
X-Gm-Message-State: AOJu0Yxt74Jij+QkP31BO31ZUah0evSEP5jsV92Jz2CQSrKmiYSc82fZ
	pPO4yT7IaVk8Yn4CCmhZzFg=
X-Google-Smtp-Source: AGHT+IEdgVlHDhG+A/hXMIxsz6Ds+0gqZWlsbOevME5Zn1n8L0rP1VlvuFSM+2qkBkZVXBraRzlpTA==
X-Received: by 2002:a17:90a:de14:b0:286:9464:1bc9 with SMTP id m20-20020a17090ade1400b0028694641bc9mr10906037pjv.26.1702913889421;
        Mon, 18 Dec 2023 07:38:09 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:09 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 051/154] ksmbd: remove generic_fillattr use in smb2_open()
Date: Tue, 19 Dec 2023 00:33:11 +0900
Message-Id: <20231218153454.8090-52-linkinjeon@kernel.org>
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

[ Upstream commit 823d0d3e2b05791ba8cbab22574b947c21f89c18 ]

Removed the use of unneeded generic_fillattr() in smb2_open().

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 8f929807f4c8..4a68cf9624f7 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2809,7 +2809,6 @@ int smb2_open(struct ksmbd_work *work)
 	} else {
 		file_present = true;
 		user_ns = mnt_user_ns(path.mnt);
-		generic_fillattr(user_ns, d_inode(path.dentry), &stat);
 	}
 	if (stream_name) {
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
@@ -2818,7 +2817,8 @@ int smb2_open(struct ksmbd_work *work)
 				rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
 			}
 		} else {
-			if (S_ISDIR(stat.mode) && s_type == DATA_STREAM) {
+			if (file_present && S_ISDIR(d_inode(path.dentry)->i_mode) &&
+			    s_type == DATA_STREAM) {
 				rc = -EIO;
 				rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
 			}
@@ -2835,7 +2835,8 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 	if (file_present && req->CreateOptions & FILE_NON_DIRECTORY_FILE_LE &&
-	    S_ISDIR(stat.mode) && !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
+	    S_ISDIR(d_inode(path.dentry)->i_mode) &&
+	    !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
 		ksmbd_debug(SMB, "open() argument is a directory: %s, %x\n",
 			    name, req->CreateOptions);
 		rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
@@ -2845,7 +2846,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	if (file_present && (req->CreateOptions & FILE_DIRECTORY_FILE_LE) &&
 	    !(req->CreateDisposition == FILE_CREATE_LE) &&
-	    !S_ISDIR(stat.mode)) {
+	    !S_ISDIR(d_inode(path.dentry)->i_mode)) {
 		rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
 		rc = -EIO;
 		goto err_out;
-- 
2.25.1


