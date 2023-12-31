Return-Path: <stable+bounces-9101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C26820A37
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D46B217ED
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CCE17D3;
	Sun, 31 Dec 2023 07:17:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E646D6E6
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dc1fe0889fso1623483a34.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007055; x=1704611855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+BQ/2tjNWcV5etWwnVJSqvELlqX9iZLO6hkLyPJO2Y=;
        b=EqKDBf2Up1E7AAQnF12h0oIu4JERjqt/FyLSkhkNiWG95K+cUcir0lAg3zF9eO5do4
         LXaz4snjw2AqP6+Pc8u1SY2sfNTgvsabBld/zC9UkjlzZ+g+gvWB2dBosx5T8seg8QLv
         u9izd4CN9a7dggnM9OJWYWOFt8/NPf5ozMBFe7XrJ7YrlKwCUDkWE/ojvSZsIQOZVNUj
         Rst9s40vHQBqCZJ6cZnWIcQRQIDdK6PM3+tRb1ZF9a93pmdPS6hyIUq60UIBckNP4Nej
         4D+sp5e2pHeXwCPoBLt2rGfMBCTpthIbdcNbNaNcgz/5G8cfjdiKVIir9m4pJsgZn9kD
         iXlA==
X-Gm-Message-State: AOJu0YzGWiZGXjVN53QkzTKbM3iUtp1Hh6Q4AVh1aEh7fujvT4fmg/Dp
	b0YWxgO+ZzhuNkHnu8gv3EREHUtKAWE=
X-Google-Smtp-Source: AGHT+IHfoS++5RCph9TOc49YYg03SHOYA0asPwKUdjvHVjYLbTTnACkeXpQCMTbVNrnKZB9PQMQWkA==
X-Received: by 2002:a05:6870:819e:b0:204:25de:f0bf with SMTP id k30-20020a056870819e00b0020425def0bfmr17937082oae.35.1704007055598;
        Sat, 30 Dec 2023 23:17:35 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:35 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 67/73] ksmbd: set epoch in create context v2 lease
Date: Sun, 31 Dec 2023 16:13:26 +0900
Message-Id: <20231231071332.31724-68-linkinjeon@kernel.org>
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

[ Upstream commit d045850b628aaf931fc776c90feaf824dca5a1cf ]

To support v2 lease(directory lease), ksmbd set epoch in create context
v2 lease response.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/oplock.c | 5 ++++-
 fs/smb/server/oplock.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 4c74e8ea9649..037316c78506 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -104,7 +104,7 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 	lease->duration = lctx->duration;
 	memcpy(lease->parent_lease_key, lctx->parent_lease_key, SMB2_LEASE_KEY_SIZE);
 	lease->version = lctx->version;
-	lease->epoch = 0;
+	lease->epoch = le16_to_cpu(lctx->epoch);
 	INIT_LIST_HEAD(&opinfo->lease_entry);
 	opinfo->o_lease = lease;
 
@@ -1032,6 +1032,7 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	       SMB2_LEASE_KEY_SIZE);
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
+	lease2->epoch = lease1->epoch++;
 }
 
 static int add_lease_global_list(struct oplock_info *opinfo)
@@ -1364,6 +1365,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 		memcpy(buf->lcontext.LeaseKey, lease->lease_key,
 		       SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
+		buf->lcontext.Epoch = cpu_to_le16(++lease->epoch);
 		buf->lcontext.LeaseState = lease->state;
 		memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
 		       SMB2_LEASE_KEY_SIZE);
@@ -1423,6 +1425,7 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
 		lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->epoch = lc->lcontext.Epoch;
 		lreq->duration = lc->lcontext.LeaseDuration;
 		memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
 				SMB2_LEASE_KEY_SIZE);
diff --git a/fs/smb/server/oplock.h b/fs/smb/server/oplock.h
index 4b0fe6da7694..ad31439c61fe 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -34,6 +34,7 @@ struct lease_ctx_info {
 	__le32			flags;
 	__le64			duration;
 	__u8			parent_lease_key[SMB2_LEASE_KEY_SIZE];
+	__le16			epoch;
 	int			version;
 };
 
-- 
2.25.1


