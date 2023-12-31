Return-Path: <stable+bounces-9115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE52B820A46
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920A9B21728
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943117C2;
	Sun, 31 Dec 2023 07:20:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6E17C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbca115636so4928971a34.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007201; x=1704612001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5PKZlXsniNhNBmJqdF6SMj3uk+01yKVxqVBWaljnJ0=;
        b=pVHvcvbE3Du35ih8DBjqRgATob9ipUXJyhFGY9ECNQuiK6l3r9ZDvzzWpwhx3IcaM9
         BTCTB4+uOVZQqxh4Kg2nKNkJVH+mdv51FNZeuWodLMIFZXaOcmnRsNN+1y6MPgoRxD9K
         OVukyZXLQAa7x2y9XpxTgv4xBKXeViMjerNfTRmeZaSrCGBxYCqO4Sbhffa3Wsf8YCZm
         N7+3tsci5ubsTbsJhY/q1UuLteb/lDgSUmjb6SGmDRMIc/5hUwa8Cu7JW7AVvVibPcha
         kQbPOvgjTFXLryBzrDS+HZbHC6HQC5c9S7wUpKsOQHv7DNS9KN6P7Rr95cU5uqzKgGF3
         OAJg==
X-Gm-Message-State: AOJu0YyMixhkrUbxD+BjU+sr4NaCdNHYDrWrKnjLcB6wgdj+wPE2Du/a
	P5ePtYy8926MOtQfH0GZH7s=
X-Google-Smtp-Source: AGHT+IEEpS1H0ta5wJeKpsDb/xGrJDW7qDlqJ891OmetuzPBpyeKrnm218Fv5inl/sdSSP+voKEA3g==
X-Received: by 2002:a05:6808:11d0:b0:3bb:e3d4:6694 with SMTP id p16-20020a05680811d000b003bbe3d46694mr3585929oiv.37.1704007201716;
        Sat, 30 Dec 2023 23:20:01 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:20:01 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 07/19] ksmbd: fix kernel-doc comment of ksmbd_vfs_kern_path_locked()
Date: Sun, 31 Dec 2023 16:19:07 +0900
Message-Id: <20231231071919.32103-8-linkinjeon@kernel.org>
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
index 183e36cda59e..533257b46fc1 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1186,9 +1186,10 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
 
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


