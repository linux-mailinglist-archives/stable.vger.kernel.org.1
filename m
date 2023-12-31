Return-Path: <stable+bounces-9075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 790CC820A1C
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F18C1F2214D
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08058184C;
	Sun, 31 Dec 2023 07:16:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D617C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9b51093a0so4147716b3a.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006967; x=1704611767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NL5itqgkhphZnaGcE/QpBPoVbTm05OeuqpFCZy5WaiU=;
        b=YchRUJsQGaKW+dEmGLhscDPGBT2DTsTI6LomrPpDogNl0bTHjqbQf3y692qK64k/BB
         3hRcZU1dCeTMYODtD1WB2JY8vDdsAgtT2ny8zhtkJL7uYuT81uA0KOJhu927WMEOjqoZ
         xZ3irn9ETMP0LZ2K8wZULvPtKGelA65LSvQkK/7+PqNuU9dsMaQXaokcC4ZYuyGxEi76
         aonoWgggHAAGLQC9hcHi9CjnbRQpysM2Ewk2GA6eVg+Qm9oOh5MWItdofoZbgCbAFjLk
         j/y/h6nFd85STjACeZQB1aHpFKsTFsYLi/gLy7YB010NpH2N5iboZ1EjDRmn9Not+yiC
         kzfg==
X-Gm-Message-State: AOJu0YyhVOoisRGisgpAs2uxQ3qXxeuFSX2n6TpfOgX443/DURgQ/SU6
	TkPcDetbj+bDx8II3tS0nuGwemnvU5o=
X-Google-Smtp-Source: AGHT+IHLG1l2W+FSykI/NinyP0FQyxw56nnrOVxl827uMAIVBAH5UNhnON5PoWLhtkivzElkYI41UQ==
X-Received: by 2002:a05:6a20:3791:b0:194:ae7b:3847 with SMTP id q17-20020a056a20379100b00194ae7b3847mr13809428pze.34.1704006967126;
        Sat, 30 Dec 2023 23:16:07 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:06 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 41/73] ksmbd: remove unneeded mark_inode_dirty in set_info_sec()
Date: Sun, 31 Dec 2023 16:13:00 +0900
Message-Id: <20231231071332.31724-42-linkinjeon@kernel.org>
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

[ Upstream commit e4e14095cc68a2efefba6f77d95efe1137e751d4 ]

mark_inode_dirty will be called in notify_change().
This patch remove unneeded mark_inode_dirty in set_info_sec().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smbacl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 03f19d3de2a1..7a42728d8047 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1443,7 +1443,6 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 out:
 	posix_acl_release(fattr.cf_acls);
 	posix_acl_release(fattr.cf_dacls);
-	mark_inode_dirty(inode);
 	return rc;
 }
 
-- 
2.25.1


