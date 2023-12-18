Return-Path: <stable+bounces-7697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0B18175D9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B079E1C24FA6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B7760B8;
	Mon, 18 Dec 2023 15:39:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700385BFB6
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28abb389323so1228459a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913941; x=1703518741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbTfF+FK/VZJ7v64wpmo1fZueAmvmEHoo6Eweg7ERL8=;
        b=jpZjVo0SUodbjlEan0lDBGybX9oExAcx82jLjJkvuWUenIX+yKPFFqeKYYDqwShY2K
         T+nGnSP1LCP+wESAqhr9eIRPu2DI2PZ7uOcG57Nxx6e2V3wYxddGOYnyfc6gnXkM8JuB
         i88U/RyNDnNFh3xJr9jHtr6PE/MBmUQfLLzHuEZcNBiN1/0Pz2CpheOPi0MJKEuu/koz
         +Gyi3p+XOf4+PnqiS9gUn6KS80eUVLBxuhI38QImU6lQ5w035W2cFDD4Iw18gE0bLYQJ
         ZXuJA3KYViFuAIjDm/+4q7muU/4+ZrQkpMvBgjVWzBNgOVSMMR3oefaAuTwOtTGrL983
         Dh7w==
X-Gm-Message-State: AOJu0YzkMfgFuHevsLFfPpClAM1AwsqvPhVnRj4Ai2p63tj0PIlp2ZZ5
	FYfYg30EPFARWp/3kQgfipo=
X-Google-Smtp-Source: AGHT+IFwE5NlgJYA0D2N5U6weMMAXxiREyNrUwRXNXlcyt7iXZ59eD28PtCRM4IiErvL3x3peZsT+g==
X-Received: by 2002:a17:90a:34c8:b0:28b:328a:3b36 with SMTP id m8-20020a17090a34c800b0028b328a3b36mr1806853pjf.25.1702913940960;
        Mon, 18 Dec 2023 07:39:00 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:00 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 068/154] ksmbd: Convert to use sysfs_emit()/sysfs_emit_at() APIs
Date: Tue, 19 Dec 2023 00:33:28 +0900
Message-Id: <20231218153454.8090-69-linkinjeon@kernel.org>
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
 fs/ksmbd/server.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 1d5e46d71070..b9f11ef91ee4 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -439,11 +439,9 @@ static ssize_t stats_show(struct class *class, struct class_attribute *attr,
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
@@ -475,19 +473,13 @@ static ssize_t debug_show(struct class *class, struct class_attribute *attr,
 
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


