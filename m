Return-Path: <stable+bounces-179658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668F9B587C0
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 00:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A009D7A6358
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 22:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4432D2D8768;
	Mon, 15 Sep 2025 22:44:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E682D7DC3
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976284; cv=none; b=dyxorVUC5RTeYGzi7DIOZBkP+C2JF+G27isfLloShkajm2bhEQ2eyi0S8I5oiaIM2nNOKIw+WrayGGE1sQvlQ3Fj9x483ruqqL1eHZbluEOgV7QaABKylNK/Js2f8rZuMuSSlYmewLbuF88QXNXh0YjcF7TY4PqeBytHJfM+5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976284; c=relaxed/simple;
	bh=FoDhXKL27FrqFbdKgo4qvaWBWJzf83x/wDOeD8TZ98k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dshRBVCb+JYFqWQkq0pphpSQJTO3hgExS48dRuWe+qgqr3x973do3P8C48Q6IyLgYqRqGMG+hcdAo0Xo1jgd+gaJSBtOkeGGujE6i7V/aZ01/62dOUP3+EGbEkhXtXReFFMhzOOU48k7eKAZdnU27ePlWlaMrALBCe2SJ06ntFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26495aa4967so3880435ad.2
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 15:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976281; x=1758581081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4h6TvvGvdfthwq8yZuD7RXg5Y5KodTn8R97NT7K6NI=;
        b=Qmzy+wmODCOeSVzup85zvcWugI+9hPiQOk3BdYgXEFJCl9mrY7N/U7h0mgh1NPRvgt
         jtYBhqsfPYyBb19FfX/O9BVn5JBi9lhpm27pCH2pUrPuZ/+bmi+36kv55QzjFJRkix8y
         GMxef6ayUJUxI7KRrzBDFM0735m2Nfnr66thDHl4w9YDTokbHwYteaHltAYtdtafjZbK
         UY3rg8vdcyVyYJEdHJ9RBC7li1Zlp6bHhUyfT5koZsvx94LRNozauC6UGLaEhoFE6D1W
         s8VKvOqWAY7SwdLXszZ7pa+by2yzvmT6ofuchCNHxRMraJwz5qiXY58ykCGi85wNJmBi
         cDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCZKBSX4L5sJp1XwBhOqmcWSyAeJ9axJangU2bwNB504wsUPcXtV5qnZwiciwAOMD/QZTK4BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPjLrhjcI2FFdsL2RSr1bZszlhERZPgDqY509dNRFsD/yjSxMa
	lRhSS69gWSHavFnJEi+a268Qai6XR1CJ3oG/SGnJ3eFEkct4Ro4JXBBq
X-Gm-Gg: ASbGncv76NL4Il3fycqV6bR4hzmMFPr8fE1oBLBkCRNWosm/stcFxePt8DYvAN4OGwI
	npowJuIF5A0ihsp4InPYsT+MUjmrl4HknZI3Cdm9uRBdJ81u7lUgwsJFQvZfwwZ0J9QYlP5Vt+U
	y5CRSGHKVmCRq+ew/+TnnJpDKOKKjSQ9GFFK4Ps3wPfjPGWbgUSWz9RvMPM/5Rr3/JU2D5+8IvJ
	Mje8TFx5VRyctPPjq+whAMrmtPgMYpVM2/5DFJhE+M/p/EliRHqjZ62V7nZrkXu/gnXGz4Ef838
	pocLWKBZVS6SCEeibl4Xbqxq/O9SC8y5XIHZCkAlTNO6PwIOddJsq/YK1v5VK2ttxCyKIgah3YA
	TKe1TUqyUdoK1vKg/8aus7+jX4p+Mw+PcSVaBKX7YjvjazzW8HvgqZWtKym9vUPJ7leKZmDt7iR
	bMsIV04YV+2A==
X-Google-Smtp-Source: AGHT+IHVxjXZpD31bCIVHV7+Q1p6w2ZxDlVfrTJXcV+ZPNp+MWwHnfZ/vC/wORtLF/jAvuHJqOJ52g==
X-Received: by 2002:a17:902:ec85:b0:267:bd8d:1b6 with SMTP id d9443c01a7336-267bd8d09c0mr10685795ad.6.1757976280635;
        Mon, 15 Sep 2025 15:44:40 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc53a1sm142718715ad.2.2025.09.15.15.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:44:40 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Norbert Szetei <norbert@doyensec.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Dawei Li <set_pte_at@outlook.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list),
	Yunseong Kim <ysk@kzalloc.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: Fix race condition in RPC handle list access
Date: Mon, 15 Sep 2025 22:44:09 +0000
Message-ID: <20250915224408.1132493-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'sess->rpc_handle_list' XArray manages RPC handles within a ksmbd
session. Access to this list is intended to be protected by
'sess->rpc_lock' (an rw_semaphore). However, the locking implementation was
flawed, leading to potential race conditions.

In ksmbd_session_rpc_open(), the code incorrectly acquired only a read lock
before calling xa_store() and xa_erase(). Since these operations modify
the XArray structure, a write lock is required to ensure exclusive access
and prevent data corruption from concurrent modifications.

Furthermore, ksmbd_session_rpc_method() accessed the list using xa_load()
without holding any lock at all. This could lead to reading inconsistent
data or a potential use-after-free if an entry is concurrently removed and
the pointer is dereferenced.

Fix these issues by:
1. Using down_write() and up_write() in ksmbd_session_rpc_open()
   to ensure exclusive access during XArray modification, and ensuring
   the lock is correctly released on error paths.
2. Adding down_read() and up_read() in ksmbd_session_rpc_method()
   to safely protect the lookup.

Fixes: a1f46c99d9ea ("ksmbd: fix use-after-free in ksmbd_session_rpc_open")
Fixes: b685757c7b08 ("ksmbd: Implements sess->rpc_handle_list as xarray")
Cc: stable@vger.kernel.org
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 fs/smb/server/mgmt/user_session.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 9dec4c2940bc..b36d0676dbe5 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -104,29 +104,32 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	if (!entry)
 		return -ENOMEM;
 
-	down_read(&sess->rpc_lock);
 	entry->method = method;
 	entry->id = id = ksmbd_ipc_id_alloc();
 	if (id < 0)
 		goto free_entry;
+
+	down_write(&sess->rpc_lock);
 	old = xa_store(&sess->rpc_handle_list, id, entry, KSMBD_DEFAULT_GFP);
-	if (xa_is_err(old))
+	if (xa_is_err(old)) {
+		up_write(&sess->rpc_lock);
 		goto free_id;
+	}
 
 	resp = ksmbd_rpc_open(sess, id);
-	if (!resp)
-		goto erase_xa;
+	if (!resp) {
+		xa_erase(&sess->rpc_handle_list, entry->id);
+		up_write(&sess->rpc_lock);
+		goto free_id;
+	}
 
-	up_read(&sess->rpc_lock);
+	up_write(&sess->rpc_lock);
 	kvfree(resp);
 	return id;
-erase_xa:
-	xa_erase(&sess->rpc_handle_list, entry->id);
 free_id:
 	ksmbd_rpc_id_free(entry->id);
 free_entry:
 	kfree(entry);
-	up_read(&sess->rpc_lock);
 	return -EINVAL;
 }
 
@@ -144,9 +147,14 @@ void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
+	int method;
 
+	down_read(&sess->rpc_lock);
 	entry = xa_load(&sess->rpc_handle_list, id);
-	return entry ? entry->method : 0;
+	method = entry ? entry->method : 0;
+	up_read(&sess->rpc_lock);
+
+	return method;
 }
 
 void ksmbd_session_destroy(struct ksmbd_session *sess)
-- 
2.51.0


