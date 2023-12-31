Return-Path: <stable+bounces-9094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5839820A30
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034221C20E45
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0498317C3;
	Sun, 31 Dec 2023 07:17:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492317D3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bae735875bso315685639f.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007032; x=1704611832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbGn67/tOZ9KvR0o4zjlyIiy0GEeEeZ4mrZ9quCveEk=;
        b=joR2+bGU7IiWbfs/uahYeyZDtGfcA+ILQU6zjiKfN1gfemt0F5SnSrPhCQAX98uLK+
         zxYiYbOcov9RwgDwk7bKLkFwFvSkGksZK0roE2kR1E3LpLbR/M/O8wLqQia4f0ymsNLe
         yA9jyrVfBibbWb23dDmWqKBZ7vGAt6ECX3YXsWRkYxv7Iil3IKMln5Yb3w93rEe9gpL3
         o89hNMXw8S1oHLYAMI6ayfQSES6JRZF9XfDB/crvc+KPjUwQGa3i2rjtP497+MXCoZog
         DU/c2Zl76voRHXxlA/1vtZXIl8Dhxlcl5gnsBF3P6IaFQ/RQPYXj1vMC9XJ9hCcv+7dY
         ZEpg==
X-Gm-Message-State: AOJu0YwK1wqlNjm7Xo7JSqVCeIE0GG+lJ3OGSJUuK/B4OAHS0BPR+Kjh
	rttbBWa3zChIWunUeYiJ18E=
X-Google-Smtp-Source: AGHT+IH98EPFsloc+iY/6kATi8HGAo8klcnc+FVR417/1HRlNqG7dRmvmALbnT6hsJqR8upUD4U2wg==
X-Received: by 2002:a05:6e02:3706:b0:360:6fd:321e with SMTP id ck6-20020a056e02370600b0036006fd321emr15729464ilb.124.1704007032663;
        Sat, 30 Dec 2023 23:17:12 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:12 -0800 (PST)
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
Subject: [PATCH 6.1.y 60/73] ksmbd: prevent memory leak on error return
Date: Sun, 31 Dec 2023 16:13:19 +0900
Message-Id: <20231231071332.31724-61-linkinjeon@kernel.org>
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


