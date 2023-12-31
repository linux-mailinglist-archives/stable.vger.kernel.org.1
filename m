Return-Path: <stable+bounces-9045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1658209FE
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C121F1C20FDA
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7049A17C2;
	Sun, 31 Dec 2023 07:14:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9DD17D3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5955bc798a2so413484eaf.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006863; x=1704611663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBJigtlI3k6JsyT52tvX873aQPSwUiur281zLxcK9UI=;
        b=JQ9Jif29316rjDuxDjnNUNH1OTICX2r3/jF4pRiDyde93vKSKbjVU4YKkdZxbIf0Hb
         GTDOP/am01p+PZViHbkbTV1vK1+holApKTuKbpNvprlyG6/s3Uh3czOhtyV9cb9FAwmZ
         w8xVxtd/tAzKRPsULIqgWkK/yETGAa1ovenQbeH6/fN+QAbhPmrY/01PFcEUVV8mxraq
         PQSt834mguUTxA874RA3NFHNUW3NgqkbKLKSnSH88+qZD/yrp9PB7EAvZrdTRa2j0ewp
         9vsl7xOunsOgDiWtJqkioG2gdoU3DHn4nwjZvBReOI3AonK3Xa8V2j0mXEf6hCSYzDqd
         3uuw==
X-Gm-Message-State: AOJu0YwAsu1f2RYMnVPoxl5KzLVWVAWsWNMwm/89MY5pPzXpHvoaD96h
	yBkHblMkTzelk+/bNJ6+VKY=
X-Google-Smtp-Source: AGHT+IGX0piooumaIRdCAwIY5dbdnY98RU7YoIYvBRR1+uS+8Ht8mGmQgw02XmuuFeVYyxeFGKx1uw==
X-Received: by 2002:a05:6871:5229:b0:204:62c3:2a17 with SMTP id ht41-20020a056871522900b0020462c32a17mr17772563oac.25.1704006863169;
        Sat, 30 Dec 2023 23:14:23 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:22 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 11/73] ksmbd: Fix parameter name and comment mismatch
Date: Sun, 31 Dec 2023 16:12:30 +0900
Message-Id: <20231231071332.31724-12-linkinjeon@kernel.org>
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

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit 63f09a9986eb58578ed6ad0e27a6e2c54e49f797 ]

fs/ksmbd/vfs.c:965: warning: Function parameter or member 'attr_value' not described in 'ksmbd_vfs_setxattr'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3946
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/vfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 36914db8b661..187d31d98494 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -951,9 +951,9 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
  * ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
  * @user_ns:	user namespace
  * @dentry:	dentry to set XATTR at
- * @name:	xattr name for setxattr
- * @value:	xattr value to set
- * @size:	size of xattr value
+ * @attr_name:	xattr name for setxattr
+ * @attr_value:	xattr value to set
+ * @attr_size:	size of xattr value
  * @flags:	destination buffer length
  *
  * Return:	0 on success, otherwise error
-- 
2.25.1


