Return-Path: <stable+bounces-7656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85598175A1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEC91F2354F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5171D74E28;
	Mon, 18 Dec 2023 15:36:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D46498B0
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28b06be7cf6so1347569a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913808; x=1703518608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X9Gy7VBYErEPOyVCAqEFlv9PFeQGv+EcKxsdw+d8Jg=;
        b=kr3D1YhPJMDgxu2OpuBfB2hOiCIFXa4N/vObr5B/2ft4ZAsiJjqwKFk5C+sN1E2ZxV
         kej5KWkt4p4j9XLXd7s7AJzYAbhSIJZnyDr2QgKHwIdJOEk/1Ji49t03EX25EIi8Uvbc
         vmxmgdmdIUxsgA9+yOR6Bb0FVjidgPD0fpgsBKLvndOUqAh5DMSLzZjc+9bGJPFKC+O4
         2VqBiVAHgdr5vJheaqNeGLeMTZNkZ/6uMJ3e4jR/Ihqv2YkjmLjrMfdLgmLT1ZwufHiN
         qRMglDE8WaMv2Yk5yt82CzxVqSyllj82MywlQ1LoRhN4/0jMYyLQuTL4ppuTN2gxS3O6
         QUgA==
X-Gm-Message-State: AOJu0YxaH+TSHezGHHB0M46wcKh82N+vCjhMZNvec+WV+7zKXOe1NM9x
	ky+XaExskojHfLDIbtKDa2U=
X-Google-Smtp-Source: AGHT+IHh4d5veSGMdheCUkHtWx+dbdgUINaA0nNeDi6KMcn2VN2MyEnbwwnW6iyHw2ZeUohliEx4Yw==
X-Received: by 2002:a17:90b:1d04:b0:28b:790e:dd52 with SMTP id on4-20020a17090b1d0400b0028b790edd52mr685281pjb.23.1702913808238;
        Mon, 18 Dec 2023 07:36:48 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:47 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Steve French <stfrench@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15.y 027/154] ksmbd: shorten experimental warning on loading the module
Date: Tue, 19 Dec 2023 00:32:47 +0900
Message-Id: <20231218153454.8090-28-linkinjeon@kernel.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit adc32821409aef8d7f6d868c20a96f4901f48705 ]

ksmbd is continuing to improve.  Shorten the warning message
logged the first time it is loaded to:
   "The ksmbd server is experimental"

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index bca0fbf3c67c..049d68831ccd 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -590,7 +590,7 @@ static int __init ksmbd_server_init(void)
 	if (ret)
 		goto err_crypto_destroy;
 
-	pr_warn_once("The ksmbd server is experimental, use at your own risk.\n");
+	pr_warn_once("The ksmbd server is experimental\n");
 
 	return 0;
 
-- 
2.25.1


