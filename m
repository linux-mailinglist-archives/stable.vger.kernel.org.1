Return-Path: <stable+bounces-9092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80928820A2D
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4932832A5
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8895D17C7;
	Sun, 31 Dec 2023 07:17:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B676D6E6
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbd6e377ceso2061033b6e.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007025; x=1704611825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7Vd0MYUa8dvs+MdusW36ZKvt4OgI4hiEmXSNA8fVCU=;
        b=tGzE3jXG3c5kIRHqiu9ngeIHJSuHwlz2oPOvoOXZWqvbSl2Mi8/0z4GGj4FKpfmAdn
         OuVJ5b3y2IxDJBMvTBaadloVMIlCeFPmUpaFiuyx7NexvH+YzBgNjqFRk9pigU0JXiPf
         eht9TKBlkAkfAoCYSp8VPOZdr0jZn9fPFSwg4mnkabqQ1hAAzeOUAL35BlFOB3Bqfvzx
         YHSC1+P1cVHuSny8Qya4siFlb33n00c65DI7X9eoUl976o/GzJke/KIMJOG8zbBTB9ml
         6hMLHOgza5JDuTLd82Bh3iEWTJevotLvJLuE9pRGeZpjTVs2chNeVwH5QpNSeFzV5ao1
         A5NA==
X-Gm-Message-State: AOJu0Yw/jrBkTdo0WD3BqDijsV5D7E9d6X2346wY5+XhaLf5zOw9ylyM
	p7CoqnCDYIW75LAv+6fcll501+Rt08k=
X-Google-Smtp-Source: AGHT+IHYsUQS+95f420cJqBuVyoCf+TSiYgV0NDqM1d8cbjTgr+Gy2b5VBE6pUMj7NCh6IaIc5mQCQ==
X-Received: by 2002:a05:6808:3a0f:b0:3bb:bf51:784e with SMTP id gr15-20020a0568083a0f00b003bbbf51784emr11554935oib.23.1704007025458;
        Sat, 30 Dec 2023 23:17:05 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:05 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 58/73] ksmbd: no need to wait for binded connection termination at logoff
Date: Sun, 31 Dec 2023 16:13:17 +0900
Message-Id: <20231231071332.31724-59-linkinjeon@kernel.org>
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

[ Upstream commit 67797da8a4b82446d42c52b6ee1419a3100d78ff ]

The connection could be binded to the existing session for Multichannel.
session will be destroyed when binded connections are released.
So no need to wait for that's connection at logoff.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/connection.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 4b38c3a285f6..b6fa1e285c40 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -167,23 +167,7 @@ void ksmbd_all_conn_set_status(u64 sess_id, u32 status)
 
 void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id)
 {
-	struct ksmbd_conn *bind_conn;
-
 	wait_event(conn->req_running_q, atomic_read(&conn->req_running) < 2);
-
-	down_read(&conn_list_lock);
-	list_for_each_entry(bind_conn, &conn_list, conns_list) {
-		if (bind_conn == conn)
-			continue;
-
-		if ((bind_conn->binding || xa_load(&bind_conn->sessions, sess_id)) &&
-		    !ksmbd_conn_releasing(bind_conn) &&
-		    atomic_read(&bind_conn->req_running)) {
-			wait_event(bind_conn->req_running_q,
-				atomic_read(&bind_conn->req_running) == 0);
-		}
-	}
-	up_read(&conn_list_lock);
 }
 
 int ksmbd_conn_write(struct ksmbd_work *work)
-- 
2.25.1


