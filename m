Return-Path: <stable+bounces-7743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E2F817613
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2AB1C2521B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3403740A9;
	Mon, 18 Dec 2023 15:41:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A426768F5
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28b7a0d1665so519282a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914088; x=1703518888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FrXGLdgDrmWfPfecqZvPdux3z9peKLf3oPky0V4CTE=;
        b=vCJevooUzUCabffcrXVpmSFSWdQ3jLHd0yBL9WTl2mIcJiOJnNJJ4mkFWVwZ9UptKA
         Jvqlz5f5X7clF7xFtxgz5LdU83tEd/T3oUa8b8VNsfOE0fmEdI/2kXRVjjmkdXgd9LM7
         pa7x5gLgqKm92lnGOHQpCbnV9RFgh/g3uUIu093JvgxWN6C3mw5aP2igJDY458WjVWql
         iXf0/jfq/nS5X1ohaIL1bzKf+CMRQg3Kd6BeQ9U/xf3vnQ6VagRdWDkSW5c5kKD2FZj4
         Fu8fWgkvPS3yoFVLzHsrCpwT9ZS4r0piUP3mzMR39KeuMNF8oR0c2/YkxqFNiZ2406pQ
         F1CQ==
X-Gm-Message-State: AOJu0YwGjj42lO/QpMVBFgN64uW4UvN8+f/De4HBzilqjFqUNfbdKyEW
	kGmLDIVaBPmqrEBgrLjxgio=
X-Google-Smtp-Source: AGHT+IHqHaqjBYZPelhI5/Df1xmYletDoDTI7Waih9eMpTqcICU5isu2uDOmBO3/HfGAjgMNZMsW/A==
X-Received: by 2002:a17:90b:368e:b0:28a:f2c8:e168 with SMTP id mj14-20020a17090b368e00b0028af2c8e168mr3454461pjb.98.1702914088364;
        Mon, 18 Dec 2023 07:41:28 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:27 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Wang Ming <machel@vivo.com>,
	Tom Talpey <tom@talpey.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 114/154] ksmbd: Fix unsigned expression compared with zero
Date: Tue, 19 Dec 2023 00:34:14 +0900
Message-Id: <20231218153454.8090-115-linkinjeon@kernel.org>
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
 fs/ksmbd/vfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 2b938ebdfd2a..f2013963cef0 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -412,7 +412,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 {
 	char *stream_buf = NULL, *wbuf;
 	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
-	size_t size, v_len;
+	size_t size;
+	ssize_t v_len;
 	int err = 0;
 
 	ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
@@ -429,9 +430,9 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
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


