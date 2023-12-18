Return-Path: <stable+bounces-7707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F948175E3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7491F21386
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5531C42372;
	Mon, 18 Dec 2023 15:39:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67693D563
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28b4e6579a9so628001a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913972; x=1703518772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbJ/oiNzYmAlAVmBkTsbJYr2yoUYHMnzHlf8PLamM50=;
        b=uTvDIWjwUL4Q6rVKUkPsVzHUNc+LWBlLg5Gp47jC1uIfKvNj6GMHYvNx+guJ2WxOfy
         Thj68jV8umD+Rragy/ibY9Nj9179a40+tJYH5XbN+Z20Dy1OUJJ3tWiEQXinYR7nJWcx
         3bd0L3geWatyLIKd30+BmGWumjKo2zqQFUKCOO0a7qcWhOju4ftP3OMUOFP1boScf4pI
         8kPfDKarsnSwh9dL5t3SVybRvqCaCuVFoyNKDlL9G0hvXB/7IPQ6NkUoO7puK8MCZpJH
         oEY/GWH5xdhGnEC5E5TBaLtY0ZEFAipHHNRslRUU9HqwYrY5t21oR33s42KfNF1WcFjy
         751A==
X-Gm-Message-State: AOJu0YyF4HebydS7pBi5NZgDHxtDeFuZyOM71TATFyNByoAJFf6U1Erc
	M8CkZDhBJRpSmEfcy1Jyr8kTi9m4wB0=
X-Google-Smtp-Source: AGHT+IGrWNquEpqGn3GFE7GUziF6/DSLOXMiEjR2EjpmpYryP1t39tLBZsTDHSvR1m/Mxnwgi1vxFw==
X-Received: by 2002:a17:90a:ba0f:b0:28a:d065:4c52 with SMTP id s15-20020a17090aba0f00b0028ad0654c52mr3906452pjr.49.1702913972016;
        Mon, 18 Dec 2023 07:39:32 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:31 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Miao Lihua <441884205@qq.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 078/154] ksmbd: fix wrong signingkey creation when encryption is AES256
Date: Tue, 19 Dec 2023 00:33:38 +0900
Message-Id: <20231218153454.8090-79-linkinjeon@kernel.org>
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

[ Upstream commit 7a891d4b62d62566323676cb0e922ded4f37afe1 ]

MacOS and Win11 support AES256 encrytion and it is included in the cipher
array of encryption context. Especially on macOS, The most preferred
cipher is AES256. Connecting to ksmbd fails on newer MacOS clients that
support AES256 encryption. MacOS send disconnect request after receiving
final session setup response from ksmbd. Because final session setup is
signed with signing key was generated incorrectly.
For signging key, 'L' value should be initialized to 128 if key size is
16bytes.

Cc: stable@vger.kernel.org
Reported-by: Miao Lihua <441884205@qq.com>
Tested-by: Miao Lihua <441884205@qq.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/auth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index bad4c3af9540..df8fb076f6f1 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -730,8 +730,9 @@ static int generate_key(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 		goto smb3signkey_ret;
 	}
 
-	if (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
-	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
+	if (key_size == SMB3_ENC_DEC_KEY_SIZE &&
+	    (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+	     conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
 		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L256, 4);
 	else
 		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L128, 4);
-- 
2.25.1


