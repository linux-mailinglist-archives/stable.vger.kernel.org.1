Return-Path: <stable+bounces-9119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4B4820A48
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83DE1F221DC
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23017D3;
	Sun, 31 Dec 2023 07:20:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA217C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so4344386b3a.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007216; x=1704612016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sobATgJh35MJBD1oALYJWZRr9Hpf+Z7wdE8AQYh63gw=;
        b=sdYpkCoNzIXxe77Ru3E4YRzak34qwbpiH5cz7aHz8fSBAFBIU+Azl8LuSv3H7Ak089
         72i5b1XU78L0prFiIi6F4JgEIdP+vulgfq0/+WYZZCF/nkUuMXLA+tv+Feytn/9dEFRP
         IzyJkUkpvbiZ7lwUnElgpKExILXbS6r4c2izBYBvfYUeCU0LxlAxINh0HOgZZKdXsIFF
         V9ZV++i1xaU+aGYtc69b35BghgEOq1VSJ6UD4Vg0LUJrvIted11D/aoLdTP0Min82Gmc
         MWYgcD9XQYknYOyLj+n+JRvzlSGZBtyp4rHka52O7ykkITR5UchSXLjur3xpTH8esc8I
         fuvw==
X-Gm-Message-State: AOJu0Yz2hgIkUv5essSghMIyh3TLEmgMnc2Pk7mTcREA0MQ04JnMGPuf
	Gp06LiC9wLsFkTb/w1rQ/YI=
X-Google-Smtp-Source: AGHT+IEuWEcizTlD+gaPTOVcOmJp3sxSPB3/hGhrYzweazf0ppRKVHJbkSEZXcmn5KII+eugBGQYJA==
X-Received: by 2002:a05:6a00:26df:b0:6d9:9ee8:9a2b with SMTP id p31-20020a056a0026df00b006d99ee89a2bmr12790550pfw.13.1704007216540;
        Sat, 30 Dec 2023 23:20:16 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:20:16 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 11/19] ksmbd: release interim response after sending status pending response
Date: Sun, 31 Dec 2023 16:19:11 +0900
Message-Id: <20231231071919.32103-12-linkinjeon@kernel.org>
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

[ Upstream commit 2a3f7857ec742e212d6cee7fbbf7b0e2ae7f5161 ]

Add missing release async id and delete interim response entry after
sending status pending response. This only cause when smb2 lease is enable.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/ksmbd_work.c | 3 +++
 fs/smb/server/oplock.c     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index 2510b9f3c8c1..d7c676c151e2 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -56,6 +56,9 @@ void ksmbd_free_work_struct(struct ksmbd_work *work)
 	kfree(work->tr_buf);
 	kvfree(work->request_buf);
 	kfree(work->iov);
+	if (!list_empty(&work->interim_entry))
+		list_del(&work->interim_entry);
+
 	if (work->async_id)
 		ksmbd_release_id(&work->conn->async_ida, work->async_id);
 	kmem_cache_free(work_cache, work);
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 9bc0103720f5..50c68beb71d6 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -833,7 +833,8 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 					     interim_entry);
 			setup_async_work(in_work, NULL, NULL);
 			smb2_send_interim_resp(in_work, STATUS_PENDING);
-			list_del(&in_work->interim_entry);
+			list_del_init(&in_work->interim_entry);
+			release_async_work(in_work);
 		}
 		INIT_WORK(&work->work, __smb2_lease_break_noti);
 		ksmbd_queue_work(work);
-- 
2.25.1


