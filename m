Return-Path: <stable+bounces-7770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03934817630
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421BD1C251D0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07413D576;
	Mon, 18 Dec 2023 15:42:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE13A1D4
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3113932a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914176; x=1703518976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbBRM9mE0VcQWsIp075KKd0s3qXxniuKdWuE6F8w5Uk=;
        b=CcPZjNSsPoeZHCCgcDuU4RB1nAPVlVSZezGIQzMqkdTCwysp1zy2ShxLuy3XoPIL+o
         F5TwA2wKUasopdV+3czCSKWS745ladsVpW8764nfG19p2Bg+oS5/zbhwl9yBINOeFPv2
         AgtE9+M4UXxSRWL1FnwviYN3lUuUNvQRbpzeFcW79vP/fJSTJwJVcHld8I2hx+kx7rjN
         Sxm0BN8a+j6POYO9/CkXNQ0UCkQCebKPzWmJEQlrpg4CV2FVbkSOdspZtEgqtaaks9mL
         lCwuwqGy063dcaKRGiPCLC0Bc5dhvZb5pzarNgtU9yfLXg1QuIAKbcBLQYsmHpMypLh9
         7/PQ==
X-Gm-Message-State: AOJu0YyQVWbktNuzkhoyNQ6RwyYKK8BMoTK9r97C+65UnAZjrEiX8WOo
	pRNyqCuK8ck6v+JB50CEhuVuZug6y2Qz9g==
X-Google-Smtp-Source: AGHT+IFbQmqByBf253u9I0WhRepZzmyasRWgf+g8FvEPDfphaV8OOlEzM64zqiAF0ZLVTLKniXb/5Q==
X-Received: by 2002:a17:90a:3041:b0:28b:765c:163e with SMTP id q1-20020a17090a304100b0028b765c163emr2792490pjl.16.1702914175940;
        Mon, 18 Dec 2023 07:42:55 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:55 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 141/154] ksmbd: fix kernel-doc comment of ksmbd_vfs_setxattr()
Date: Tue, 19 Dec 2023 00:34:41 +0900
Message-Id: <20231218153454.8090-142-linkinjeon@kernel.org>
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

[ Upstream commit 3354db668808d5b6d7c5e0cb19ff4c9da4bb5e58 ]

Fix argument list that the kdoc format and script verified in
ksmbd_vfs_setxattr().

fs/smb/server/vfs.c:929: warning: Function parameter or member 'path'
not described in 'ksmbd_vfs_setxattr'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 6b24355800aa..85346780704d 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -919,7 +919,7 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
 /**
  * ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
  * @user_ns:	user namespace
- * @dentry:	dentry to set XATTR at
+ * @path:	path of dentry to set XATTR at
  * @attr_name:	xattr name for setxattr
  * @attr_value:	xattr value to set
  * @attr_size:	size of xattr value
-- 
2.25.1


