Return-Path: <stable+bounces-9053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1A3820A06
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F4E282F10
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8517C3;
	Sun, 31 Dec 2023 07:14:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867E17C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d2e6e14865so36606675ad.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006890; x=1704611690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nhleEin4e7SUtMNWadNds55IO74ete9WPsADox1gU0=;
        b=C1mLahANE9e13aJcxyBiXQj0znYYY9TOa8PgrrcCXlxst3xEt9ga2REHOVMjq5Ncqp
         /8ecX6MmBLt4Bs6LYOWPrVrwjtF6zkEebOt19MZr5BbWy3KFaf8DN6hUzsAGB6f+YWJs
         ii/O2apOzPyOSCSICMItYaA2TVXYsVEFj5trxEgXYwLrjbnYP4w3YAkSi17OXmRUg+Pk
         tJeRK3m1MbF8YTb+j6kA24+mMJp97Hs7K80AcIJC9Sm3yXc++VZPw8z/xYcPhJxMzvvQ
         eir4mnjpRUbueXyQD0b1Ad6YJqMu1W7c2IbZjO5HI0lfHoMoyxdTTB2g1VILD05R1jq5
         m1xg==
X-Gm-Message-State: AOJu0YxFxHodJ5gK2w3U+Lu5rCX1BH8R7bO+jZlE9Xs4pAbLQafhm4+y
	LZjcBl3NXly2wQvfqEAT6zk=
X-Google-Smtp-Source: AGHT+IH49MEA1faqQ6wwEKy0PisVFc67+fCC+qFX38Ltk6gH9M5Jix58qMTEAGdm/qR9EXP/nxJftg==
X-Received: by 2002:a05:6a00:2f53:b0:6d9:a07b:11aa with SMTP id ff19-20020a056a002f5300b006d9a07b11aamr4912978pfb.52.1704006890446;
        Sat, 30 Dec 2023 23:14:50 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:50 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Coverity Scan <scan-admin@coverity.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 19/73] ksmbd: fix uninitialized pointer read in ksmbd_vfs_rename()
Date: Sun, 31 Dec 2023 16:12:38 +0900
Message-Id: <20231231071332.31724-20-linkinjeon@kernel.org>
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

[ Upstream commit 48b47f0caaa8a9f05ed803cb4f335fa3a7bfc622 ]

Uninitialized rd.delegated_inode can be used in vfs_rename().
Fix this by setting rd.delegated_inode to NULL to avoid the uninitialized
read.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/vfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 58a6665f1c3a..5d2bb58d77e8 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -744,6 +744,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	rd.new_dir		= new_path.dentry->d_inode,
 	rd.new_dentry		= new_dentry,
 	rd.flags		= flags,
+	rd.delegated_inode	= NULL,
 	err = vfs_rename(&rd);
 	if (err)
 		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
-- 
2.25.1


