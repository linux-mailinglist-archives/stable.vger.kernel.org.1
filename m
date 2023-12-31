Return-Path: <stable+bounces-9116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB88E820A45
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D731C2147B
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D59C1844;
	Sun, 31 Dec 2023 07:20:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4717F4
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdfed46372so4691941a12.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007206; x=1704612006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbGn67/tOZ9KvR0o4zjlyIiy0GEeEeZ4mrZ9quCveEk=;
        b=bMC43sqNmZqq2T8YxPvjDr/iViaekNI+M9Al7L25u6ab07cLWRBphp3gFv5tlUwGHr
         qva6+ke6hQ3c+DExFugwhuW6LiSHQ4feh0FSjkivP0gO7oNfzegqb+H47gRVx2JM4WD5
         cehJmMr8vgDXCxwIhp4Fj/sQH/lnTdnujNALH4WjHahL2WR5qW2QRFyE8kVE0A2AzqCF
         co+GznUefnBHuuuZm0c7YVuHVhXNksYLq2AZZKqj75Sti660+wny+EdyYFMhVUvFyJ5Y
         7Zmq6rz0IbKJyn/BJHh8wJdAoG84EVfJa8Si4PsimJZCGWABSvrqsyqaUgb1B8948CBT
         d9MA==
X-Gm-Message-State: AOJu0YwyarwQlgdc/AIGy09EfEK+ZsvmvZnLXWclkjG8L9VSA3WE0HSc
	7xPscgtn0WLvHb1hfdfNVtQ=
X-Google-Smtp-Source: AGHT+IGwP11EjLcqI4pflOBL1fp5AoAZwOdFrZShy7nkjq/sBPbO6Hjh0dMWDXuW0Mu3wlspicLs6w==
X-Received: by 2002:a05:6a20:7c1d:b0:194:95bd:e6aa with SMTP id p29-20020a056a207c1d00b0019495bde6aamr12848502pzi.19.1704007205775;
        Sat, 30 Dec 2023 23:20:05 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:20:05 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Zongmin Zhou <zhouzongmin@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 08/19] ksmbd: prevent memory leak on error return
Date: Sun, 31 Dec 2023 16:19:08 +0900
Message-Id: <20231231071919.32103-9-linkinjeon@kernel.org>
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

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

[ Upstream commit 90044481e7cca6cb3125b3906544954a25f1309f ]

When allocated memory for 'new' failed,just return
will cause memory leak of 'ar'.

Fixes: 1819a9042999 ("ksmbd: reorganize ksmbd_iov_pin_rsp()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202311031837.H3yo7JVl-lkp@intel.com/
Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/ksmbd_work.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index a2ed441e837a..2510b9f3c8c1 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -106,7 +106,7 @@ static inline void __ksmbd_iov_pin(struct ksmbd_work *work, void *ib,
 static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
 			       void *aux_buf, unsigned int aux_size)
 {
-	struct aux_read *ar;
+	struct aux_read *ar = NULL;
 	int need_iov_cnt = 1;
 
 	if (aux_size) {
@@ -123,8 +123,11 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
 		new = krealloc(work->iov,
 			       sizeof(struct kvec) * work->iov_alloc_cnt,
 			       GFP_KERNEL | __GFP_ZERO);
-		if (!new)
+		if (!new) {
+			kfree(ar);
+			work->iov_alloc_cnt -= 4;
 			return -ENOMEM;
+		}
 		work->iov = new;
 	}
 
-- 
2.25.1


