Return-Path: <stable+bounces-7777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34986817639
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D782D281943
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816E649894;
	Mon, 18 Dec 2023 15:43:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55E5A847
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28abb389323so1235349a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914199; x=1703518999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIL6IWYBOCWRd3aKhNZC6formKl4f9lQ5CQpCEEALM0=;
        b=c1jZJj1FCiQvrq8oIOSjgQ49NjrhcWrv5xhBo+lteQhPZ/N5YN2DSLpznqHrtKIJ2J
         e7AHHytxwalp/mLZK2sflMKYBX2BXukTqQr8P5OOfN3yMc3IqJ2MATFlGk5EOJUpaJhp
         cauAsvJ+1iCULqDRbjgFXvGgVBysH2y0paKDaILN9IQnnjh9IqdviftYdjM1/LIBhvDp
         jZ0drmdT+lA+GAPmfNzjzkUVX639LPOXylU5iid+P7cDxFQB/LDHaY89qfliTiGXVm1X
         AZIQyFSNNBHx/tUS/oHOYDjzVtaKI56RuQJ/fS4HhlIBQ/kjidxDmmaw6Q/OefbLiVaE
         xBJg==
X-Gm-Message-State: AOJu0YyqNC4EHnTN1bhKazwdhAVtrHmpymM0a5iNeQJL+SGrhycJAvwl
	StkW8XWu0D64Q28VuwlJwuE=
X-Google-Smtp-Source: AGHT+IFH1yd49QKwcOjY2parpgHHN/KFw/EsnbtQDiBicdpQmYWvgSYbe5qVLFrTXx6mMxo/+wTyrQ==
X-Received: by 2002:a17:90a:730c:b0:28a:cbce:71ab with SMTP id m12-20020a17090a730c00b0028acbce71abmr4513887pjk.13.1702914199494;
        Mon, 18 Dec 2023 07:43:19 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:43:19 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Zongmin Zhou <zhouzongmin@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 148/154] ksmbd: prevent memory leak on error return
Date: Tue, 19 Dec 2023 00:34:48 +0900
Message-Id: <20231218153454.8090-149-linkinjeon@kernel.org>
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
 fs/ksmbd/ksmbd_work.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
index a2ed441e837a..2510b9f3c8c1 100644
--- a/fs/ksmbd/ksmbd_work.c
+++ b/fs/ksmbd/ksmbd_work.c
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


