Return-Path: <stable+bounces-9064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F40820A11
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4876282F07
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8517F4;
	Sun, 31 Dec 2023 07:15:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8417C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso6283126a12.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006930; x=1704611730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCnHB907ZmQmup8Wrb/IELnB+PKwWlf7VspOCmJI9b4=;
        b=adFl6H54y8+mYgEyTHtx01fKwKZJZMisXnCio3deRidzBGhYvkXK/v8ogvbDXDr8Cr
         wnBECnEQbmWgrEig+0NEqP1hK9WBz23uopbz7IO/hbuazZSwixWy6GNasK7eHqjnJgSU
         C8iyahLYa4aNsuIiDNMpfxk6i8wA2Z0w7F9TLfR0Rvt9+jNTkQBTEs2zNDXYAUgCMv04
         iVW1n4xsxIniR/I9yKgZZQb6Oyqb1zusI9Rz7hJ0pUAStEW8lJfVLvEF1IcuEmLsMXrt
         HNvasI5wMpIJIdKsOxFhzoVMeoCCK1gy+7GiWKv9auBSJgR1ghOIlRwnyp0bOuAUhjxx
         IUlA==
X-Gm-Message-State: AOJu0Yzd17VAro2eNw50s0SzLLchXDRIJYFH4tJAeH86VMrX3KTjMZNX
	jlQ1GoH5lUmAX7/r+npRrcg=
X-Google-Smtp-Source: AGHT+IHaEZW9DKsdJ6UAevmTTDbp9BMny00ju0QzcMahRdQtfiWYt7HDI3SIm3BeZiFJFocmynUnmA==
X-Received: by 2002:a05:6a20:3c90:b0:196:21e2:d0f6 with SMTP id b16-20020a056a203c9000b0019621e2d0f6mr9200511pzj.60.1704006929742;
        Sat, 30 Dec 2023 23:15:29 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:29 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 30/73] ksmbd: Use struct_size() helper in ksmbd_negotiate_smb_dialect()
Date: Sun, 31 Dec 2023 16:12:49 +0900
Message-Id: <20231231071332.31724-31-linkinjeon@kernel.org>
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

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 5211cc8727ed9701b04976ab47602955e5641bda ]

Prefer struct_size() over open-coded versions.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 62c33d3357fe..b6f414a2404b 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -266,7 +266,7 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
 		if (smb2_neg_size > smb_buf_length)
 			goto err_out;
 
-		if (smb2_neg_size + le16_to_cpu(req->DialectCount) * sizeof(__le16) >
+		if (struct_size(req, Dialects, le16_to_cpu(req->DialectCount)) >
 		    smb_buf_length)
 			goto err_out;
 
-- 
2.25.1


