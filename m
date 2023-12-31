Return-Path: <stable+bounces-9058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F6C820A0B
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5800B20FFB
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E5E17F4;
	Sun, 31 Dec 2023 07:15:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F217C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so3085344b3a.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006907; x=1704611707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJ8eCZq9Fuz0BYOyFNT22XffJVM474FPZ5RM09ZOILU=;
        b=ECBqOcs346ADlUW0g2sTOp8Cdou0c//4i0bncwBa3Jj2iImY5kxu3D3oTceabxTk1m
         XTaPuwoqIqU0SS8tzN78dZ/Tvm6NUHtnYWcmaDa2Ne9v+dn9ffkWnn18gHYJadx3pzwb
         U2h3yFvVyhPY8V8hQC193TMT7jLu6jwd/jaLvoUCxlZ5H4yt204TmvJ9tQ/0zfrAYygV
         Pk9iIUCsgx6XoocmrsE1SrlDmddXj+9vIKCCXeUjX4d9QWDnIYXitidfX2EXSIrrd0Qh
         C+j5I342RhTWbMWYS48j/25AG88bFREGDCbpxoWu9GX8kACSskQ6V9wB8gYneaaiWHx3
         HcoQ==
X-Gm-Message-State: AOJu0YyU8+o1MfbQ/lR5qBPl4B1dVO2Ij5+Z4AptPK1st+T/RltK2BD7
	6d1OlOO5AyAlXU2VoYMqh38=
X-Google-Smtp-Source: AGHT+IHaRGCXt4gl/WqREEQfDEDmbqkGFfPEtZAGkA7X/xRqFNX6txCvNph9wUhrPy+Gne/hJBvptg==
X-Received: by 2002:a05:6a21:6d8b:b0:196:a6e3:21f0 with SMTP id wl11-20020a056a216d8b00b00196a6e321f0mr2268156pzb.36.1704006907386;
        Sat, 30 Dec 2023 23:15:07 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:06 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 24/73] ksmbd: remove unused ksmbd_tree_conn_share function
Date: Sun, 31 Dec 2023 16:12:43 +0900
Message-Id: <20231231071332.31724-25-linkinjeon@kernel.org>
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

[ Upstream commit 7bd9f0876fdef00f4e155be35e6b304981a53f80 ]

Remove unused ksmbd_tree_conn_share function.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/mgmt/tree_connect.c | 11 -----------
 fs/smb/server/mgmt/tree_connect.h |  3 ---
 2 files changed, 14 deletions(-)

diff --git a/fs/smb/server/mgmt/tree_connect.c b/fs/smb/server/mgmt/tree_connect.c
index f07a05f37651..408cddf2f094 100644
--- a/fs/smb/server/mgmt/tree_connect.c
+++ b/fs/smb/server/mgmt/tree_connect.c
@@ -120,17 +120,6 @@ struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
 	return tcon;
 }
 
-struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
-						 unsigned int id)
-{
-	struct ksmbd_tree_connect *tc;
-
-	tc = ksmbd_tree_conn_lookup(sess, id);
-	if (tc)
-		return tc->share_conf;
-	return NULL;
-}
-
 int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess)
 {
 	int ret = 0;
diff --git a/fs/smb/server/mgmt/tree_connect.h b/fs/smb/server/mgmt/tree_connect.h
index 700df36cf3e3..562d647ad9fa 100644
--- a/fs/smb/server/mgmt/tree_connect.h
+++ b/fs/smb/server/mgmt/tree_connect.h
@@ -53,9 +53,6 @@ int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
 						  unsigned int id);
 
-struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
-						 unsigned int id);
-
 int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess);
 
 #endif /* __TREE_CONNECT_MANAGEMENT_H__ */
-- 
2.25.1


