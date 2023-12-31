Return-Path: <stable+bounces-9098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06CF820A34
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5AD1C21823
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBEA17C2;
	Sun, 31 Dec 2023 07:17:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53617F4
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28cb3bc3fe7so866084a91.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007046; x=1704611846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taz8AJ3hq0bS+3anPgZ9lPQj8/eGl1/hoM0LWxr6aog=;
        b=ei1YqqSjQXaDnL1XcXsdZNWoDHBiWvZVqN7wxBVevCbWLFrBbToZvBsiCXupd9sJAO
         ElsxhQIXiAi+dj7d5bHOiW74tTSCRjaJFMvO6AMLKkUSrBvnYxiAHH+56v4hymFuTtoD
         QERdVAMP8R94eaHAu2gNgbvMpT8CaLWgAduIqKUenlGkX3KvJ90PhjYvJzZAvH96/pYt
         9luLFyltv8gpC2FEwFUlwohodUYaM76CsrMn2C+7fxOGYnNSrDbBp/V+umhqLyaOwVrO
         AEFFcjGHorsF4dy3P5Npea11vjXEIh4tgZaoismUfYsTzap9KmCPE1bItlKdQRQ2apev
         aDEA==
X-Gm-Message-State: AOJu0Yz3V7t4mG2Pos9rqtx2dpjsbRgVqgeD9XKlkc2V1MDickTarcLI
	4jMGC0pSlNljY2cWvBU2Ifw=
X-Google-Smtp-Source: AGHT+IGBzoaD8ia2vfChwPO68TUWD7RHXsk21LoJCOY0S8HYQHSpqEP8oykwt5uSeBpWaUNS4Kj/XQ==
X-Received: by 2002:a17:90a:5182:b0:28b:6beb:2501 with SMTP id u2-20020a17090a518200b0028b6beb2501mr16979068pjh.37.1704007045901;
        Sat, 30 Dec 2023 23:17:25 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:25 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 64/73] ksmbd: release interim response after sending status pending response
Date: Sun, 31 Dec 2023 16:13:23 +0900
Message-Id: <20231231071332.31724-65-linkinjeon@kernel.org>
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
index 90a035c27130..4c74e8ea9649 100644
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


