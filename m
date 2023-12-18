Return-Path: <stable+bounces-7721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1B18175F1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CD41C237EC
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F37849884;
	Mon, 18 Dec 2023 15:40:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DA7144D
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b6afc7302so628663a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914019; x=1703518819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0yeP+IfMY+r7Zm7NX5/Ih9QhtL4LtGwVcgH1rcqTds=;
        b=uiqUSK/TXkXnfzsBeJ2M1vBAbkaD0YTIae0AG6D85/vBcVvs7b9ucQIGff3ng2eAbj
         9fKPpU5RPfxAQPoKxYlEXVFpC8S/sNs6Bm+fdysmQZjk/2LXnctFmkUl+Ll45qwI+J4Q
         0arLpw65113qygz8Brmy2efmilVFf4mu8R9jIGqFs/EmrVuFfIvyNeHNeOYzQZtrH+4+
         Gu57fepLcT+EvK68zh8X36ThOB8DyhDN7TzCnidUkoLp6q29nxYTDl3dh3NHf1VS32pL
         wHtyzheSZnzsb4Z8ksYYH2oCyoPZgrz0YBW7wQoZM9VZ4KMa5OLnQOeKQMvpjMWlr/tP
         wY/g==
X-Gm-Message-State: AOJu0Yz6PkVu856eNR2WZVZvFb+D8mbowxhcfgqzGINUeVqbD0UU0EP5
	uc48t5Ney/SOpGYucB+xU08=
X-Google-Smtp-Source: AGHT+IFYsnSYBN9yxiLzt8hl+1V76YmBmcbbZeNxqXus5n7GEDIj3RcHYqkdbZlDwJsGhiJz62d7TQ==
X-Received: by 2002:a17:90a:9c0a:b0:288:966b:9f49 with SMTP id h10-20020a17090a9c0a00b00288966b9f49mr6937455pjp.1.1702914019518;
        Mon, 18 Dec 2023 07:40:19 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:18 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Coverity Scan <scan-admin@coverity.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 093/154] ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()
Date: Tue, 19 Dec 2023 00:33:53 +0900
Message-Id: <20231218153454.8090-94-linkinjeon@kernel.org>
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

[ Upstream commit 48b47f0caaa8a9f05ed803cb4f335fa3a7bfc622 ]

Uninitialized rd.delegated_inode can be used in vfs_rename().
Fix this by setting rd.delegated_inode to NULL to avoid the uninitialized
read.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/vfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index e31584ad80fa..8956131df631 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -743,6 +743,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	rd.new_dir		= new_path.dentry->d_inode,
 	rd.new_dentry		= new_dentry,
 	rd.flags		= flags,
+	rd.delegated_inode	= NULL,
 	err = vfs_rename(&rd);
 	if (err)
 		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
-- 
2.25.1


