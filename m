Return-Path: <stable+bounces-9055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D340A820A08
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117A91C20919
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E1517C2;
	Sun, 31 Dec 2023 07:14:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ECC17C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-595678b3e8cso94445eaf.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006897; x=1704611697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sH1JaDsyHN4bIh7fGEvg169bSGmzeYl8CRNeNSqrgz8=;
        b=iXe9Ki8d5yR56rb882GKRl/bswqXag7zNXM41CKo+sJ01UNH/UNMy2a+obNOwTSI/W
         F+OOd8Gx90Ztj2CSToGuKCL2mRH17dA2aNjwhtc8TD24sMsIBoN5/yLL26tS3+AwNvSb
         nVkK1BDyl2uLVJsbN2YmxPQ35h+9Jb2pTaYSjKV4lyZdmKscJouP5KL+z6+MjrsJIvUC
         to7+EHz0nqm3brJlBdzIq98C+/SQn10fyKliVXmbFfMfMN0GcFEw8siuNQT6esnlb0tS
         3q91hKn/p5JW2nap6e9S34Ye3u8/eIn1mqIJ+rZV7QiEdg83yndb7bcXpRp0JrqqD4zy
         kdLg==
X-Gm-Message-State: AOJu0YyQyoekYliLcx6MkERcfd+9UxHUQgaPcELTN+1DdgiR+rlWlgpP
	YfzBje8xbIP0R6fKs6VzWZ8=
X-Google-Smtp-Source: AGHT+IFI6A0FUeLx2yOvTK6JrR92OrzITWsqLw8/tQ3RslU/VL5v6Q51sutf0Y9rfa+a3ZZK54KkrA==
X-Received: by 2002:a05:6871:2215:b0:1fa:f387:e0a1 with SMTP id sc21-20020a056871221500b001faf387e0a1mr16772139oab.9.1704006896956;
        Sat, 30 Dec 2023 23:14:56 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:56 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 21/73] ksmbd: call putname after using the last component
Date: Sun, 31 Dec 2023 16:12:40 +0900
Message-Id: <20231231071332.31724-22-linkinjeon@kernel.org>
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

[ Upstream commit 6fe55c2799bc29624770c26f98ba7b06214f43e0 ]

last component point filename struct. Currently putname is called after
vfs_path_parent_lookup(). And then last component is used for
lookup_one_qstr_excl(). name in last component is freed by previous
calling putname(). And It cause file lookup failure when testing
generic/464 test of xfstest.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/vfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 5d2bb58d77e8..ebcd5a312f10 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -87,12 +87,14 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	err = vfs_path_parent_lookup(filename, flags,
 				     &parent_path, &last, &type,
 				     root_share_path);
-	putname(filename);
-	if (err)
+	if (err) {
+		putname(filename);
 		return err;
+	}
 
 	if (unlikely(type != LAST_NORM)) {
 		path_put(&parent_path);
+		putname(filename);
 		return -ENOENT;
 	}
 
@@ -109,12 +111,14 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	path->dentry = d;
 	path->mnt = share_conf->vfs_path.mnt;
 	path_put(&parent_path);
+	putname(filename);
 
 	return 0;
 
 err_out:
 	inode_unlock(parent_path.dentry->d_inode);
 	path_put(&parent_path);
+	putname(filename);
 	return -ENOENT;
 }
 
-- 
2.25.1


