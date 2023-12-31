Return-Path: <stable+bounces-9068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C93820A15
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944051C21272
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0335F17C7;
	Sun, 31 Dec 2023 07:15:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559D17C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbd6e377ceso2060575b6e.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006944; x=1704611744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/A8EWBpehuEkg/BMVxQ9jqeryhSnS612Qw17HTDOdQ=;
        b=Ux9xJGFWhBGmxKiW8TlENLkwppcS5reY/byKGOeMiPbQJ3M5O19hoKuJbfKSYfgrkk
         2WShpl7Qr/yKl0DiPjXLAA0ZlJSzLwptbE7Tu/xRM5nM/BmuJHHm6hzEnYqzFEZffBoP
         tzRZajwnXTkF/4cHmObyuYpu1ZkYS4Kt9NFNW3f/hJVrmnTY3LM/CVczk67v8YbsDTcb
         SQ1u4HL5sr1Skz1kQIuZJBXjrU5BRvoJ5hjprt3lrdleG4jLXgZId2DeSph+NZRGlL/J
         5MKTFpuEIDJ6U6cpMAf9GugVOcixpZgHKlE1NscSt2SLB5m0F0/tB2rN1KnBhXfHXj76
         FjRw==
X-Gm-Message-State: AOJu0YwzWDwMZhzkdr48Z1hLXIZyN5vbwm6yjKCSpdPhDqoeFHEmGa03
	N8QDKCkNZEVaQZwRaOCLjZzk1dHsT3M=
X-Google-Smtp-Source: AGHT+IEQMCsqcG0+k5qHFUFCM6yobvDG6xT4oPghLVT+BtXgTBzjoUt+3P0VqZtYAcjX40g14kmkSw==
X-Received: by 2002:a05:6808:1208:b0:3bb:da55:58a7 with SMTP id a8-20020a056808120800b003bbda5558a7mr5329168oil.16.1704006943833;
        Sat, 30 Dec 2023 23:15:43 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:43 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Yang Yingliang <yangyingliang@huawei.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 34/73] ksmbd: switch to use kmemdup_nul() helper
Date: Sun, 31 Dec 2023 16:12:53 +0900
Message-Id: <20231231071332.31724-35-linkinjeon@kernel.org>
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

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 084ba46fc41c21ba827fd92e61f78def7a6e52ea ]

Use kmemdup_nul() helper instead of open-coding to
simplify the code.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/asn1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/smb/server/asn1.c b/fs/smb/server/asn1.c
index cc6384f79675..4a4b2b03ff33 100644
--- a/fs/smb/server/asn1.c
+++ b/fs/smb/server/asn1.c
@@ -214,12 +214,10 @@ static int ksmbd_neg_token_alloc(void *context, size_t hdrlen,
 {
 	struct ksmbd_conn *conn = context;
 
-	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
+	conn->mechToken = kmemdup_nul(value, vlen, GFP_KERNEL);
 	if (!conn->mechToken)
 		return -ENOMEM;
 
-	memcpy(conn->mechToken, value, vlen);
-	conn->mechToken[vlen] = '\0';
 	return 0;
 }
 
-- 
2.25.1


