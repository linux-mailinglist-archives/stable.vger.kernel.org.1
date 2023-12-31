Return-Path: <stable+bounces-9087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0B3820A28
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942F11C20A3A
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4017C3;
	Sun, 31 Dec 2023 07:16:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7BE17C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35fe9a6609eso57746705ab.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007008; x=1704611808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEb9o4cZ6s9C+N4Vd/XX2DtCigpmHkOJ20nTRlmVNcE=;
        b=I2rCKNhIRFc9KSldyyUcEVgLd+9XP+o6YFxLhyfumznzwojdImujHB6QID2/vKb9k4
         0fjAU7+xbmngmxWH+bywy5dATR8laN7dgiEkTgUDxtZerrpWwfljfgEuzieXyMvy5v1K
         5ftoEK+wlTb4Zn0q4iKt8SSgt4A9auN99O9DwTRgTmdaqPro9GnnV2YKaHyL31NSYHJp
         2KyDesmLhKfXWW7egI/orXFeiEC7vs8eKOVyio6AVrSTzDj6UiJAJ0mIRyxwjlRsrXmd
         4p8N66tJcjd2n9i8cOCH4+k4G9Mrlgz8jfAw2GVvOQruBiGQHD9tUiy9/NcDOqkmhE2C
         jg6g==
X-Gm-Message-State: AOJu0YxNbtHboPU0T3Rc77Tx1eAoHOKUtwwZ3NglW2UzXlvJhQwWfDrS
	nW1NSWWoj5LmpxikVZl3tnM=
X-Google-Smtp-Source: AGHT+IH4akq+wH1Qh+Dd5Kzj7iSWJlAXstQeWhSQZTehydvChfh4M3VWK7AbZ2ESarhxUTxJiR7lXQ==
X-Received: by 2002:a05:6e02:1a02:b0:35f:eb24:bb54 with SMTP id s2-20020a056e021a0200b0035feb24bb54mr21663359ild.99.1704007008392;
        Sat, 30 Dec 2023 23:16:48 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:47 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 53/73] ksmbd: reorganize ksmbd_iov_pin_rsp()
Date: Sun, 31 Dec 2023 16:13:12 +0900
Message-Id: <20231231071332.31724-54-linkinjeon@kernel.org>
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


