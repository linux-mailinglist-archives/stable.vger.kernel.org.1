Return-Path: <stable+bounces-7775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC435817636
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8355283A28
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1154FF84;
	Mon, 18 Dec 2023 15:43:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25D15485
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3114140a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914192; x=1703518992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6CONKZPfMUX5eOtnLQsGbMz2gM8WCFUP+CKLvBXxn4=;
        b=lGocJHiiC5qiqqbdgjLU0/0pTm+gCFP5NycYiPWunoHk2lQJVmz8uwkmNuQHues5kF
         Orhh6tuhTx7CER8mNGUy5lxQ8/k0PFts+rOf5G2FwvZ9UdmGKkJzu5EGdVKDP22HXVyb
         VVn2LG/LY37fs0PfHiduzijn92UGTSYJLXKSAP+I1NI1HfCWxVZ2lkdyw6vcIpMDJURc
         npXWHdmqjKlQmmTf9SVMB9wpmrYpjE48oxN7UP/b9tFYHJFUwWOqNoOQmWdEUQ/nl+Rq
         u3S9cGmjEA8mmgqwyTsZuvdDQSbI/cNmQbPGNJwZpNTnB64O/kDwGx+8SzZDSPomSr38
         PB4Q==
X-Gm-Message-State: AOJu0Yx/XoDaE4Ux0f86T0UoR4+hjsLFIxh+m6a1fIIQ1PeHcxew1DHU
	FGdZ6VewuLkKYhFX3NLskWQ=
X-Google-Smtp-Source: AGHT+IEdpcjPfV01BbYHCAEQ5AHl+cDg4UQHxPo/lwLdshrZuhJae9bhNtbv1R8wokSdxDQxnnvwJQ==
X-Received: by 2002:a17:90a:94cc:b0:28b:9c35:f2b8 with SMTP id j12-20020a17090a94cc00b0028b9c35f2b8mr998954pjw.39.1702914192643;
        Mon, 18 Dec 2023 07:43:12 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:43:12 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 146/154] ksmbd: fix kernel-doc comment of ksmbd_vfs_kern_path_locked()
Date: Tue, 19 Dec 2023 00:34:46 +0900
Message-Id: <20231218153454.8090-147-linkinjeon@kernel.org>
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

[ Upstream commit f6049712e520287ad695e9d4f1572ab76807fa0c ]

Fix argument list that the kdoc format and script verified in
ksmbd_vfs_kern_path_locked().

fs/smb/server/vfs.c:1207: warning: Function parameter or member 'parent_path'
not described in 'ksmbd_vfs_kern_path_locked'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/vfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index ffcc8f8f35bf..84571bacadef 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1179,9 +1179,10 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
 
 /**
  * ksmbd_vfs_kern_path_locked() - lookup a file and get path info
- * @name:	file path that is relative to share
- * @flags:	lookup flags
- * @path:	if lookup succeed, return path info
+ * @name:		file path that is relative to share
+ * @flags:		lookup flags
+ * @parent_path:	if lookup succeed, return parent_path info
+ * @path:		if lookup succeed, return path info
  * @caseless:	caseless filename lookup
  *
  * Return:	0 on success, otherwise error
-- 
2.25.1


