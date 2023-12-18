Return-Path: <stable+bounces-7705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF68175E2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC23B2294F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9372A5D74E;
	Mon, 18 Dec 2023 15:39:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9893D549
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3c394c1f4so4317625ad.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913966; x=1703518766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xw9tXho1DIJEjn4YIfcca3TZxKttf08OVeVkRDzk8lY=;
        b=PQ3kRqefdQpkj8Rjjf385oXOgI4Xnwo87rpsDnutComsCgHrBxLpDtWkB7WBcMIPoP
         J78i7faCRO1DqBmnMmVAv7WWT7lteEQn1D7EMpzDKhfTU6aCM+iNIQFaafpHhOjxaAkr
         JonamTz3lxACg7IObGIV2hMilr9Q/sPW4MYnLcFLWEGsPFPjAHJiKNbMZCyC9W6elx51
         JtXgdO9uRfbJ8CXPHpkwfxjBunkZzM4Nix68o7T2VHGr38OpArX0vGtn9mqTCQx1cn6G
         v5seQ3PQQflCtTNhUqYrMx74Z/z8IImvFNclbBzSssh1mkyT7QCb7Eee3ovNIMo5JtUz
         Tp/g==
X-Gm-Message-State: AOJu0Yxf9juTXcmrYK50930coPDVFRTNIFWEcIVFtFpS4xb/a65C/2FV
	DkuRYInDt9Z2zXuGpiVCbIw=
X-Google-Smtp-Source: AGHT+IHWHIYM/KebPduy9XDFQfehnEQRaUM5nsrKxlhuxaShzXDpOYj0iXfBlbTtA5xgD3AI3baghw==
X-Received: by 2002:a17:90b:3b87:b0:28b:7643:e65c with SMTP id pc7-20020a17090b3b8700b0028b7643e65cmr662494pjb.56.1702913965704;
        Mon, 18 Dec 2023 07:39:25 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:25 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 076/154] ksmbd: Fix parameter name and comment mismatch
Date: Tue, 19 Dec 2023 00:33:36 +0900
Message-Id: <20231218153454.8090-77-linkinjeon@kernel.org>
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
 fs/ksmbd/vfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index d7814397764c..90f657f3b48f 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -950,9 +950,9 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
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


