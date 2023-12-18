Return-Path: <stable+bounces-7725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B28175F6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459121C2316E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB872040;
	Mon, 18 Dec 2023 15:40:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932387144D
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so2672153a12.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914032; x=1703518832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isAiZOQEp0YwnvEguvezuM1YAYzQZtW43raGZ4qH6A0=;
        b=Pd34C+e3ZQFnxo83jz5t+gYxyvlmWVF1TrkjhNtVQ69cQujNpmQyoC3P+ZVFdZleiK
         J1xcr0EcrYsuUXWgqmzylrPO8XT5EQJN2C2kKzJ9RaMnXl9aqvOWaM54mZE8jfwcDHlF
         q1m5B7JVVbQzI3L2yil0jyRHoOuS95W2mBH1AENn2izDviC49FGLLE6X80ZvvIvzm4T6
         AklxGzgfZOR+Kg8Wl7KZYiLjzqzFqHCPSxOkoIGXzGsWnaZaJMoN51PzTYFZ041+uNzG
         MpSAM4LYVEqRiUwGUxQ2t+10hXukog6EHjwyEFrnyBI6rkWa8CxqM7OsrIWolva2rzqg
         8N6A==
X-Gm-Message-State: AOJu0YybsgsOLm2N5GETxJiacm+ZaZ89IZNVKOudrRrdI5xvzWjfYSti
	uda5xlUNpHvKwm09ECJoD84=
X-Google-Smtp-Source: AGHT+IEQR2cR6N/L9mHOwM4SnEcTpGswYWHIwMnqWAEGX1vcrla4OMysYy454uYNkkbN1DXeL6wTgQ==
X-Received: by 2002:a17:90b:3585:b0:28b:8431:6cf with SMTP id mm5-20020a17090b358500b0028b843106cfmr1018571pjb.86.1702914031992;
        Mon, 18 Dec 2023 07:40:31 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:31 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 097/154] ksmbd: call putname after using the last component
Date: Tue, 19 Dec 2023 00:33:57 +0900
Message-Id: <20231218153454.8090-98-linkinjeon@kernel.org>
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
 fs/ksmbd/vfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 8956131df631..a48d53c4587c 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -86,12 +86,14 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
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
 
@@ -108,12 +110,14 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
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


