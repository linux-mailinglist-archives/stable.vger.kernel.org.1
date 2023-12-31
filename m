Return-Path: <stable+bounces-9114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9AC820A44
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC17283256
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6959117C3;
	Sun, 31 Dec 2023 07:20:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582317F4
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dc018228b4so2379513a34.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007198; x=1704611998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7Vd0MYUa8dvs+MdusW36ZKvt4OgI4hiEmXSNA8fVCU=;
        b=Z83FHSI90mqZ2oqg+J1ZC0Fcqdlry1epZtVW9aYw/+Eb7UIP34OxKHE7twAntO1itN
         xduzbSH2AqmO/3Qq3afzd6C0tv8OAajQKa8s6cwbjcqZLWUR5yNSnz6PLKSfYp5cyzI1
         cpD5uhe7Xq08q172czMHxvamQqKYYNV9yYOz0gExr+/Alm0U0N9YBfoYcoRj6WOBihMQ
         Q8EYJtAhy2RZmFFLrkOM2axK3dSswmQKgk7KLHSdM8nQ6XlCKchejaZMiZfulRQfk+wY
         N0gQ9nq/eMPQx8BqOEbNf8tY/aVkweWAVwHaf9h5NIrsoC1nb2HzXSL147nEtobMRI3Q
         Q+5A==
X-Gm-Message-State: AOJu0YxklnszrzwDgQUvGepVcgSEuo3B329DtWtBz5wMFqHP8wBnkVJv
	1sB0BEBrbQChVyLSiwLRxcM=
X-Google-Smtp-Source: AGHT+IE7+pR7wOFgP2NHX3YWV/zmyr22kXYJxUQ2Ya1F6N8Jra8E7xlYl6vMNEmRGUfN1TOmopg8Nw==
X-Received: by 2002:a05:6808:23ce:b0:3bb:c405:e1a1 with SMTP id bq14-20020a05680823ce00b003bbc405e1a1mr8554631oib.81.1704007198176;
        Sat, 30 Dec 2023 23:19:58 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:19:57 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 06/19] ksmbd: no need to wait for binded connection termination at logoff
Date: Sun, 31 Dec 2023 16:19:06 +0900
Message-Id: <20231231071919.32103-7-linkinjeon@kernel.org>
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


