Return-Path: <stable+bounces-9122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242DD820A4D
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1E8B210C9
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D648B17D3;
	Sun, 31 Dec 2023 07:20:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784DE17C7
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2044d093b3fso5161788fac.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007226; x=1704612026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyUJRyQrKy8b6asiZJB9fiygrzOtdkeiXZZ9wFQOYlM=;
        b=ou4Y3Qh/xVBCr3XPhxkEkKqxujh1cldHmZ1m7ehpL8fx2JgFpZEo2p8RuKlkJbWG2U
         SDMkhaCkz7JRN4mZLyL0Qm1fwSMLy+KjZh6IFm/MgdyucmGXlIBmdV1Zch91MrfePM8s
         WXqDL9aPLgv6w8j3qu4V05GneydBBD4wYh/qy+H7P3aXr/JRyuHnHfwU/Ha1/u0BY9P5
         jgFBYuZfn3sWQn53LxYgAceesTLq9Y+ST7f0BiMPj1pUcVM8px7USJ4OalmKAi+hFejt
         al9kfjmW/CmPKgJrK+bKvLIqAGKgZyY79wD7WWogVPRChGLWPMifSyK2fJLtjjCoZPbB
         DQNA==
X-Gm-Message-State: AOJu0Yx7ormFYQ6zZ5uLCGbguS30jeAaDbeparYi4nxlsLb1RwMpsbee
	Qe3GhkR1Qjrg2YACRC9OmTU=
X-Google-Smtp-Source: AGHT+IHQP4/YoFnwlwTmeK1cP2a8VUcblMct0/k4Ta3RrmXTVd2r0F+IeYLG6xE3EaMSwxupiHnuww==
X-Received: by 2002:a05:6870:d1c2:b0:204:4af:5c7d with SMTP id b2-20020a056870d1c200b0020404af5c7dmr17612153oac.101.1704007226448;
        Sat, 30 Dec 2023 23:20:26 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:20:25 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 14/19] ksmbd: set epoch in create context v2 lease
Date: Sun, 31 Dec 2023 16:19:14 +0900
Message-Id: <20231231071919.32103-15-linkinjeon@kernel.org>
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
index 50c68beb71d6..ff5c83b1fb85 100644
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


