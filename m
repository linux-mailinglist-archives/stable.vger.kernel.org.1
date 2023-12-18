Return-Path: <stable+bounces-7769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8156F81762F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930BC2833D2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9C3D566;
	Mon, 18 Dec 2023 15:42:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112933D54B
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b47d9ae0cso885791a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914171; x=1703518971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fv/WVPr6OilD9TiqJA1fOTCjr8bPcqjWwB8mdWJWdA=;
        b=KbM3VrbKg1rqqOo6JVh9xpyZm76DWP6sbZgrpi6RJFjZNPs1FILz3AxAEKE0DLxAmj
         mmAoE7ATrnUYrPoRc5tg528nO8Omm0Y/mkLQpkbbpj8mTZ1fHxIRjD/H3VKUVa9v7Jt4
         6TKcaaWZ9WAbpv3L7tqFgHMJ9sOod5iG+EMYo1a0MDGl0wGOAJYaPvQEZG1YTOjHZWF4
         w7XQflTlLIADB+OWFk08NHYtPvy9SWizt9p/J4HIhk7P3qlls9fUltk+OpNxh59Pj3D0
         MKOP1Io0qmKHlfPtP8+paSdRo5sfN3jXohtrYf5sh3M3AGqZN+nsB9uKOKnwZIMBCOmw
         StDQ==
X-Gm-Message-State: AOJu0YzwUwteKq9lP0K/5Tscq1RLU51SYGLPJHb3+rL8Hru7QywouEaF
	Jdqz9egD6mmQJknslOsl3fM=
X-Google-Smtp-Source: AGHT+IE3aGl1O0hFBMizXKFq8OXeJ7qY15ceFz0uMW+nCIJSIv0+li3LIcY9IYyWaKiLvLDZgW7E9g==
X-Received: by 2002:a17:90a:68ca:b0:28b:9885:418 with SMTP id q10-20020a17090a68ca00b0028b98850418mr623478pjj.35.1702914171431;
        Mon, 18 Dec 2023 07:42:51 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:51 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 140/154] ksmbd: reorganize ksmbd_iov_pin_rsp()
Date: Tue, 19 Dec 2023 00:34:40 +0900
Message-Id: <20231218153454.8090-141-linkinjeon@kernel.org>
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

[ Upstream commit 1819a904299942b309f687cc0f08b123500aa178 ]

If ksmbd_iov_pin_rsp fail, io vertor should be rollback.
This patch moves memory allocations to before setting the io vector
to avoid rollbacks.

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/ksmbd_work.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/ksmbd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
index 51def3ca74c0..a2ed441e837a 100644
--- a/fs/ksmbd/ksmbd_work.c
+++ b/fs/ksmbd/ksmbd_work.c
@@ -95,11 +95,28 @@ bool ksmbd_queue_work(struct ksmbd_work *work)
 	return queue_work(ksmbd_wq, &work->work);
 }
 
-static int ksmbd_realloc_iov_pin(struct ksmbd_work *work, void *ib,
-				 unsigned int ib_len)
+static inline void __ksmbd_iov_pin(struct ksmbd_work *work, void *ib,
+				   unsigned int ib_len)
 {
+	work->iov[++work->iov_idx].iov_base = ib;
+	work->iov[work->iov_idx].iov_len = ib_len;
+	work->iov_cnt++;
+}
+
+static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
+			       void *aux_buf, unsigned int aux_size)
+{
+	struct aux_read *ar;
+	int need_iov_cnt = 1;
 
-	if (work->iov_alloc_cnt <= work->iov_cnt) {
+	if (aux_size) {
+		need_iov_cnt++;
+		ar = kmalloc(sizeof(struct aux_read), GFP_KERNEL);
+		if (!ar)
+			return -ENOMEM;
+	}
+
+	if (work->iov_alloc_cnt < work->iov_cnt + need_iov_cnt) {
 		struct kvec *new;
 
 		work->iov_alloc_cnt += 4;
@@ -111,16 +128,6 @@ static int ksmbd_realloc_iov_pin(struct ksmbd_work *work, void *ib,
 		work->iov = new;
 	}
 
-	work->iov[++work->iov_idx].iov_base = ib;
-	work->iov[work->iov_idx].iov_len = ib_len;
-	work->iov_cnt++;
-
-	return 0;
-}
-
-static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
-			       void *aux_buf, unsigned int aux_size)
-{
 	/* Plus rfc_length size on first iov */
 	if (!work->iov_idx) {
 		work->iov[work->iov_idx].iov_base = work->response_buf;
@@ -129,19 +136,13 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
 		work->iov_cnt++;
 	}
 
-	ksmbd_realloc_iov_pin(work, ib, len);
+	__ksmbd_iov_pin(work, ib, len);
 	inc_rfc1001_len(work->iov[0].iov_base, len);
 
 	if (aux_size) {
-		struct aux_read *ar;
-
-		ksmbd_realloc_iov_pin(work, aux_buf, aux_size);
+		__ksmbd_iov_pin(work, aux_buf, aux_size);
 		inc_rfc1001_len(work->iov[0].iov_base, aux_size);
 
-		ar = kmalloc(sizeof(struct aux_read), GFP_KERNEL);
-		if (!ar)
-			return -ENOMEM;
-
 		ar->buf = aux_buf;
 		list_add(&ar->entry, &work->aux_read_list);
 	}
-- 
2.25.1


