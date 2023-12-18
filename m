Return-Path: <stable+bounces-7774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A504F817635
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60228281D92
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E84FF63;
	Mon, 18 Dec 2023 15:43:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73415485
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2609139a12.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914189; x=1703518989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buHza0xxZgRkDrXYvyVzZ8r1b666vw7xZAbaFwMnPuw=;
        b=Or1e0cxNKmgrN0KZHgtFFdkQO+S8hTVJVCGABaOqMAUdkyoDHa3E1j4uLkDvhuUwNc
         DQbE7NfD8qBqnQW15GaKxA0Iz15XX0JEUGhtRkIMEs+HkRJFOWqUcc5rNMsswZc0Sz52
         BWzHmvykLclNF8CmOyjsMX7yHKkAh0xSyGlnp3WOjTsHIL98tmkpCDjHh7a1cyfEhdHW
         ReqMUbkRO7+bAi4PM4dQRq9l4qTq+i2W8BEwwLpsVDbKFkqSZRq5euN9teBK/pXGUnvA
         MZplxa7RnFemfYWEk+LsrJ4ga2NIFFZl/j3szuEm7MHG573QvcbyGs+75sdFb8coP2vL
         d3xw==
X-Gm-Message-State: AOJu0Yyk92s2Xz2Z+JlraOtIDrH0gqDYX8cTIXpDXpBwbmfdqBJexh3U
	ZawhoR/omvzu4fKrnhpxGnI=
X-Google-Smtp-Source: AGHT+IGF55/jwNpcWxkJ2GUcgOdA7LhLmnbuRnskBrNYtLOrElWh//6oJ+4+i6jmF00vTsY1Jvns1g==
X-Received: by 2002:a17:90a:2a4f:b0:28b:6a9c:fff0 with SMTP id d15-20020a17090a2a4f00b0028b6a9cfff0mr1043061pjg.85.1702914189150;
        Mon, 18 Dec 2023 07:43:09 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:43:08 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 145/154] ksmbd: no need to wait for binded connection termination at logoff
Date: Tue, 19 Dec 2023 00:34:45 +0900
Message-Id: <20231218153454.8090-146-linkinjeon@kernel.org>
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

[ Upstream commit 67797da8a4b82446d42c52b6ee1419a3100d78ff ]

The connection could be binded to the existing session for Multichannel.
session will be destroyed when binded connections are released.
So no need to wait for that's connection at logoff.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 28b65a43fa39..0a7a30bd531f 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
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


