Return-Path: <stable+bounces-9066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0679C820A13
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E701F21FE3
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A48E17C3;
	Sun, 31 Dec 2023 07:15:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2C317D3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so6275484a12.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006937; x=1704611737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwBf2+9dk7opEH7vShGglFUOGY/Z/nYy0unccfmNrqU=;
        b=mEtsWk040O85Fb7kKS9ql8hYdsDKFpDb/FZpHRNOQIvMKmo9t5zQQv9M49RyyPhrGp
         sQ1u0Flq2JM+FDNLUayVyHMp22qdMrGBDLJi5gGfqNZl06M/NgWuBNkxoNxXiX9DQpxH
         Ye5E3bjKWjNbJM03Q6gFNf6RAemHyFPO+Za6krdmg8s3fzWtRR6Z95aLSnuKWmQRIQzA
         qKqGkRggDyLvWPSWfpX84ubQS7U7ktfETpWtABKEUsdejcQtXMqrregAmWFMR8Wxxz6F
         5mGNJ4OM15v2zLyUnktkfD2chFks0sChdfwL8Q8hxyCyuJQ7OthqLz6KD6Iied1ZAsXz
         gKvQ==
X-Gm-Message-State: AOJu0Yzs2IypOKKKTFr3zWA8TWKAe7RFcoHVCVEB0PWFF8on8WGQeLoE
	dD1V2XearCJW1VEM/wBe3QiP+ssE7Lg=
X-Google-Smtp-Source: AGHT+IGLEu/sZkr14eSTOZ6CiKyqahYAOJNy5ymlWegKfXDUbdYfhkqXUNC4SwE1K1sBDKam9Rtjig==
X-Received: by 2002:a05:6a20:748b:b0:196:6b0f:e9c3 with SMTP id p11-20020a056a20748b00b001966b0fe9c3mr6130440pzd.59.1704006937204;
        Sat, 30 Dec 2023 23:15:37 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:36 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Wang Ming <machel@vivo.com>,
	Tom Talpey <tom@talpey.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 32/73] ksmbd: Fix unsigned expression compared with zero
Date: Sun, 31 Dec 2023 16:12:51 +0900
Message-Id: <20231231071332.31724-33-linkinjeon@kernel.org>
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

From: Wang Ming <machel@vivo.com>

[ Upstream commit 0266a2f791294e0b4ba36f4a1d89b8615ea3cac0 ]

The return value of the ksmbd_vfs_getcasexattr() is signed.
However, the return value is being assigned to an unsigned
variable and subsequently recasted, causing warnings. Use
a signed type.

Signed-off-by: Wang Ming <machel@vivo.com>
Acked-by: Tom Talpey <tom@talpey.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/vfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index d05d2d1274b0..73ce3fb6e405 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -413,7 +413,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 {
 	char *stream_buf = NULL, *wbuf;
 	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
-	size_t size, v_len;
+	size_t size;
+	ssize_t v_len;
 	int err = 0;
 
 	ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
@@ -430,9 +431,9 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				       fp->stream.name,
 				       fp->stream.size,
 				       &stream_buf);
-	if ((int)v_len < 0) {
+	if (v_len < 0) {
 		pr_err("not found stream in xattr : %zd\n", v_len);
-		err = (int)v_len;
+		err = v_len;
 		goto out;
 	}
 
-- 
2.25.1


