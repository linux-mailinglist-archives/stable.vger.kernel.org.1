Return-Path: <stable+bounces-7632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA09817558
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5173D1F25AEF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396642375;
	Mon, 18 Dec 2023 15:35:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE763D579
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so1305037a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913724; x=1703518524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ATvpU7drvdFBomgXLARog7lifyZwAi2UUjcrbtyNoo=;
        b=jnT6uQt1xT4D1tFdCn44l6Im5Ciwuu4SYAlOydbk7TlUviRfp/ywdeMhoWmlvyyCp7
         GxILbbquYFTGRfDb17OEEIxej6zj/YzJQpMW5cYVadBnErGBIIyN8v3e1/9KBYJltk2y
         wwnsORF0z/hBM7FTURb3tMvwcy74/qPBV9cAyUWTd57329HWGwu67D8xQFptLWcASjWi
         NPKlVNoN6Q8tJ2Je5kRttNswnsAQBjQyIcC/faS/9jLqu0/BFUBnzPOYNzWTt1G9/df7
         vHiNSJQDeNKKLFMruJw7ClToMYB3bcmanfP1l8+9vSZYThejkA/0Ih7pZnwbY+ONg9nJ
         xx+Q==
X-Gm-Message-State: AOJu0YzABeOPeRywit3bEr2Avea6De0LRvoe1X4oiXv7zju+7ZWzfdRP
	gaeJyDp5OA1fEg3l461LiDQ=
X-Google-Smtp-Source: AGHT+IGsV3CMFUq1Dp8HAfW+HuiswVZBeNt0lm19av3wEGambKg1W0SVKlaGPz1hqbpYEUCmE2R1Eg==
X-Received: by 2002:a17:90b:4a41:b0:28b:228b:9bb1 with SMTP id lb1-20020a17090b4a4100b0028b228b9bb1mr2355379pjb.16.1702913723813;
        Mon, 18 Dec 2023 07:35:23 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:23 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 003/154] ksmbd: Remove redundant 'flush_workqueue()' calls
Date: Tue, 19 Dec 2023 00:32:23 +0900
Message-Id: <20231218153454.8090-4-linkinjeon@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit e8d585b2f68c0b10c966ee55146de043429085a3 ]

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/ksmbd_work.c     | 1 -
 fs/ksmbd/transport_rdma.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/ksmbd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
index fd58eb4809f6..14b9caebf7a4 100644
--- a/fs/ksmbd/ksmbd_work.c
+++ b/fs/ksmbd/ksmbd_work.c
@@ -69,7 +69,6 @@ int ksmbd_workqueue_init(void)
 
 void ksmbd_workqueue_destroy(void)
 {
-	flush_workqueue(ksmbd_wq);
 	destroy_workqueue(ksmbd_wq);
 	ksmbd_wq = NULL;
 }
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 9ca29cdb7898..86446742f4ad 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -2049,7 +2049,6 @@ int ksmbd_rdma_destroy(void)
 	smb_direct_listener.cm_id = NULL;
 
 	if (smb_direct_wq) {
-		flush_workqueue(smb_direct_wq);
 		destroy_workqueue(smb_direct_wq);
 		smb_direct_wq = NULL;
 	}
-- 
2.25.1


