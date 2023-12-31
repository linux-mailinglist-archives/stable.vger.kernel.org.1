Return-Path: <stable+bounces-9088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF590820A29
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B223283144
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314B417D3;
	Sun, 31 Dec 2023 07:16:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406817C7
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dbff975a2aso2977001a34.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007012; x=1704611812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2mKucczCmGBjbvLaVq4v4/YnistZDTaSlCoaM7SFbA=;
        b=Rm8HfRVn30EvZTwxBf0biKade0BO5REfh3/qnKheGSJhA5DcSrv84LtosH7sOfGGG+
         jI7ij6ekRcgvzuCOJAi13XR+LTIiJesXLW2N+1qb7P27lHyzXuKd4zRnm1g8KXnqzuDW
         UOs6rd16YLDC5zGu4sFM4OXTQcHSPhRlHj5OZShKT3Cb4mXZXpktk62IBOzUbYMHdg6h
         QG4VBGSFfZDAbScxx1obUleSFYLVlbboNH8KSdpYDkCw9ch9Wsqyx7BQRcG9M3TJf9+9
         y7Y38nB9MLorIVtChQFysPAkac4JNWP3ECOTOBGFFXOgRSklqJy3k8foWfPqb0VizteF
         Va+g==
X-Gm-Message-State: AOJu0YwmXnfrQ42sCVNMLDpt1OoLps3rscBSVGu+HSVeiw2BrC09bBPD
	Ri9OBNF0bb/a5KSblXdxzqM=
X-Google-Smtp-Source: AGHT+IFtci6B9oyP2s3aMyRE2alqcyHGq1sJw4utPIxQHa9/frxYHax04sIIxX/Gpsw41pP05ThmZA==
X-Received: by 2002:a05:6830:3d10:b0:6db:b4d4:d951 with SMTP id eu16-20020a0568303d1000b006dbb4d4d951mr12506835otb.74.1704007011921;
        Sat, 30 Dec 2023 23:16:51 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:51 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 54/73] ksmbd: fix kernel-doc comment of ksmbd_vfs_setxattr()
Date: Sun, 31 Dec 2023 16:13:13 +0900
Message-Id: <20231231071332.31724-55-linkinjeon@kernel.org>
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
index 6f54ea1df0c5..071c344dd033 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -920,7 +920,7 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
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


