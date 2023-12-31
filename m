Return-Path: <stable+bounces-9039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207C8209F8
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FD61F22071
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253C17C2;
	Sun, 31 Dec 2023 07:14:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE4185D
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59496704246so2874543eaf.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006841; x=1704611641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzqIBgj2Z8cehN9bWd/DLS4UH/B5XJLgvXdrIpcr9YA=;
        b=qpXRhccxbafPWKbAnRDHX6WcbQaMb4LNPqWDBV9Wpc1Yd9CqtIRPHYucTV82TEw1s4
         TMkFNZllSSIAl+r3Q3caclzHVTfnD7bI/cgNOVmbVCo8SYEKqE6nM43cPAXV9k1/ZzKF
         fsiiIFV7ILFJuagB6jDFe8O8Mm07s71fWIyZkfzSnXr7/f9m3Jxevn1AE9xrUXd9C1gu
         qeYwdNihi+mGNmx8pI9a8rS/2naKCbnW0hQAW6KkHvA1tKG4b1ZKB7cJyvWiCrpQaIvj
         E8RXD4DMUgVNpOOiDS18MLUB6KprE2JdAPOwjuHEW8WWmyzOqeixZiwvGq948+ZEu3Ev
         l8vA==
X-Gm-Message-State: AOJu0Yw4INYiFqv8B3UYTHo3ZolIa5QI/B0Islf8jdFK2kkDEZXmzYFm
	MU8AGY0mLqJNYBuyx4OSbX/hu6/Xgwc=
X-Google-Smtp-Source: AGHT+IEdSbPclr6FPWtJhsdsCWQYqWuh6Y3aripUPwhPkUATRTL7DDbrRSvAc4F9fcZqGVB39egn1g==
X-Received: by 2002:a05:6870:d88c:b0:203:e866:5141 with SMTP id oe12-20020a056870d88c00b00203e8665141mr18911886oac.56.1704006840777;
        Sat, 30 Dec 2023 23:14:00 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:00 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 05/73] ksmbd: Convert to use sysfs_emit()/sysfs_emit_at() APIs
Date: Sun, 31 Dec 2023 16:12:24 +0900
Message-Id: <20231231071332.31724-6-linkinjeon@kernel.org>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

[ Upstream commit 72ee45fd46d0d3578c4e6046f66fae3218543ce3 ]

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/server.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 9804cabe72a8..0c0db2e614ef 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -442,11 +442,9 @@ static ssize_t stats_show(struct class *class, struct class_attribute *attr,
 		"reset",
 		"shutdown"
 	};
-
-	ssize_t sz = scnprintf(buf, PAGE_SIZE, "%d %s %d %lu\n", stats_version,
-			       state[server_conf.state], server_conf.tcp_port,
-			       server_conf.ipc_last_active / HZ);
-	return sz;
+	return sysfs_emit(buf, "%d %s %d %lu\n", stats_version,
+			  state[server_conf.state], server_conf.tcp_port,
+			  server_conf.ipc_last_active / HZ);
 }
 
 static ssize_t kill_server_store(struct class *class,
@@ -478,19 +476,13 @@ static ssize_t debug_show(struct class *class, struct class_attribute *attr,
 
 	for (i = 0; i < ARRAY_SIZE(debug_type_strings); i++) {
 		if ((ksmbd_debug_types >> i) & 1) {
-			pos = scnprintf(buf + sz,
-					PAGE_SIZE - sz,
-					"[%s] ",
-					debug_type_strings[i]);
+			pos = sysfs_emit_at(buf, sz, "[%s] ", debug_type_strings[i]);
 		} else {
-			pos = scnprintf(buf + sz,
-					PAGE_SIZE - sz,
-					"%s ",
-					debug_type_strings[i]);
+			pos = sysfs_emit_at(buf, sz, "%s ", debug_type_strings[i]);
 		}
 		sz += pos;
 	}
-	sz += scnprintf(buf + sz, PAGE_SIZE - sz, "\n");
+	sz += sysfs_emit_at(buf, sz, "\n");
 	return sz;
 }
 
-- 
2.25.1


