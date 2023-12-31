Return-Path: <stable+bounces-9093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B7D820A2F
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C41F220FD
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17AA17C2;
	Sun, 31 Dec 2023 07:17:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF61844
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbce1202ebso2589168b6e.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007028; x=1704611828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZsWTLJRUq+T5riyck95j8W/jNoQs8XQAIf96MbStF8=;
        b=qb45c/mYvFdkyERhNbh9XcacGCSuym15w34ZFs00Wu3u+2IfwlkcaQZid08H1TTTm5
         sfnbv6kjxZMy7etpnpDNzQAfOhXmOhe5JERqsxcUxjRGJqx8E5igUe4GyL6ajQyvNMsg
         Xs1ITVlqmJR+AkUDzjmW4pwNoyj4kM7PYIAc/YbHO/QFhxZirlslM+kUfaR2nqX1qFWo
         P2cQLXE/ydycR5q0IUu7aoyz9RPI+qmWAiD2rzzawUMykxqt/1waXpriX+zDdS1WybiY
         xGGQlfKrwSyq3tplkRls1zlZ1WuQe6JSH6awQ/NM/o8hjqe/SL3XObIFX2HzqfHitXvm
         IBaw==
X-Gm-Message-State: AOJu0Ywmm5PWVA6ugyueaZASH43xVF1qKp8pe4zajnprZoURKT+SYsc0
	O6bDlwTDELUyGGaX9qTMmcQ=
X-Google-Smtp-Source: AGHT+IEY+F2UR3ViHJ2ZSoiffZBtqmpT4lPE57eByf0PSLIhVwsYYPQlwak0VG/YDt9Sc4bcszZOHA==
X-Received: by 2002:a05:6808:2226:b0:3b9:df4a:978b with SMTP id bd38-20020a056808222600b003b9df4a978bmr18356861oib.82.1704007028754;
        Sat, 30 Dec 2023 23:17:08 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:08 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 59/73] ksmbd: fix kernel-doc comment of ksmbd_vfs_kern_path_locked()
Date: Sun, 31 Dec 2023 16:13:18 +0900
Message-Id: <20231231071332.31724-60-linkinjeon@kernel.org>
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

[ Upstream commit f6049712e520287ad695e9d4f1572ab76807fa0c ]

Fix argument list that the kdoc format and script verified in
ksmbd_vfs_kern_path_locked().

fs/smb/server/vfs.c:1207: warning: Function parameter or member 'parent_path'
not described in 'ksmbd_vfs_kern_path_locked'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/vfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index e2e454eba409..d4298a751d4a 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1178,9 +1178,10 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
 
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


