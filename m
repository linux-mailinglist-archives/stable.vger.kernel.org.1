Return-Path: <stable+bounces-9111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4EE820A41
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BE21F22174
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2238A17C2;
	Sun, 31 Dec 2023 07:19:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29796D6EF
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so4344256b3a.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007187; x=1704611987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5F99GfwAyNe3UJDSecnyHEoPigx9TapDPC9Z3M9gPo=;
        b=cZn5l3czAdJ3dRwztGn+fE4kU9In7naeHJFLgMLJjaHhHF316MN0crKOJJeEwQLSl9
         45YsAxKVHAqJwj/ffiwK0+9nbEpK71kmujN/KpTQEf87/U9KzH3/RAO5pw9I3Uz6hr5S
         4v8gxVQKYrJ09a6rB0yl0sJ2qq+vxW0PClN7oHf67I+GhvbCkORtEzJs+URDYNeLeoyz
         M0rGIHHa0gc5KNPE8HPbi13wjq4f5f8kKt0UF6QUEtVgzsaWc2wHtyihxFqLBOdnlt/4
         IDzTCm4OJeOarN9drSnGv6QSh2SoZyNPAxFxlguoBgUO4kGy5QZ5p3tG9SR8ZwnpyVvi
         bAxQ==
X-Gm-Message-State: AOJu0YygxswfsrOffiPluAEU/7O55ZHjI8zGfwtWAoCtLY5bFGHZP14U
	4aMqUg+3ZheiMTewODbLg24=
X-Google-Smtp-Source: AGHT+IErRAB1VyW0aEJZKrL+h/fyJMBu8IKonIwRsI51ZJCb6bCt79QBg2D9QhcgBzm4RWDHdNZOMg==
X-Received: by 2002:aa7:9a8b:0:b0:6d9:3997:7f7b with SMTP id x11-20020aa79a8b000000b006d939977f7bmr14031352pfi.28.1704007187207;
        Sat, 30 Dec 2023 23:19:47 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:19:46 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 03/19] ksmbd: fix kernel-doc comment of ksmbd_vfs_setxattr()
Date: Sun, 31 Dec 2023 16:19:03 +0900
Message-Id: <20231231071919.32103-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071919.32103-1-linkinjeon@kernel.org>
References: <20231231071919.32103-1-linkinjeon@kernel.org>
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
 fs/smb/server/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 5a41c0b4e933..183e36cda59e 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -906,7 +906,7 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
 /**
  * ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
  * @idmap:	idmap of the relevant mount
- * @dentry:	dentry to set XATTR at
+ * @path:	path of dentry to set XATTR at
  * @attr_name:	xattr name for setxattr
  * @attr_value:	xattr value to set
  * @attr_size:	size of xattr value
-- 
2.25.1


