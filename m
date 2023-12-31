Return-Path: <stable+bounces-9110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1641E820A40
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0071F221EC
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B917C3;
	Sun, 31 Dec 2023 07:19:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DEA17C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35fcd6f8accso35006875ab.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007182; x=1704611982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEb9o4cZ6s9C+N4Vd/XX2DtCigpmHkOJ20nTRlmVNcE=;
        b=DblqLe8N/n6JpWsELVMQQzN1b+GoCfFIi9adRvhMX4oIhTDmPLzQw0PsJnLlIngeTQ
         2Pg/SoPe49NqjcxGa+TPijaiX+FfAMeYCJswRdassaBaMtVw4rVWp9agMYw8fWpULUDD
         g05FOHVB7wER6ejjEol/YqwrzpJRUmJTFHJjoh5tL9qQ1/yNNwRZkOTwsGTmONbP+Ics
         ew3JVNl7BaSCzFpCcO4r5Faw2ecwVPF5WLEwu9tReIW0QnJkcPWW6gOTUXzFan9EDOQk
         dPs5nwuNM0woU9noqH06X2ofSJ+teyMvOg6r0ErRNB2e+XifJ5MhVC4vXW5xcumXflwT
         zhqw==
X-Gm-Message-State: AOJu0YwU30KTqKmWOe2CY61ebKxU6IQT0cnx7xnOVPGReKny52BOECiV
	XxQY4Q/F6FNIuSQ07aQRtzg=
X-Google-Smtp-Source: AGHT+IF93PSUGmcPHF8VKBkx7S0hhe+tOHSukULgH9yVlE5dUMGicT1yktRlxyYZW2lBAoF9U2FXEQ==
X-Received: by 2002:a05:6e02:180e:b0:35f:e975:c346 with SMTP id a14-20020a056e02180e00b0035fe975c346mr17036865ilv.43.1704007181868;
        Sat, 30 Dec 2023 23:19:41 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:19:41 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 02/19] ksmbd: reorganize ksmbd_iov_pin_rsp()
Date: Sun, 31 Dec 2023 16:19:02 +0900
Message-Id: <20231231071919.32103-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071919.32103-1-linkinjeon@kernel.org>
References: <20231231071919.32103-1-linkinjeon@kernel.org>
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
 fs/smb/server/ksmbd_work.c | 43 +++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index 51def3ca74c0..a2ed441e837a 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
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


