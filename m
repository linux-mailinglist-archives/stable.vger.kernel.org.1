Return-Path: <stable+bounces-9060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B14820A0D
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3DB1F21F3B
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F417F4;
	Sun, 31 Dec 2023 07:15:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570517C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b7fdde8b56so592954839f.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006915; x=1704611715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmA36hDFALBWptDaXsxRBmQ/nxzUvZ9WZkpiM87+7ZM=;
        b=EoYciHBnHSIHOxkPMerAJerOOfX3Th4+hyNqT9JNPaqKiGQN/qu1lTVhCXIGcgZ/Yy
         47LQNj7JGUxDonBR/VT5Iu/aw7Bh5Sfsz3fcKjDat62wtdFE2ppZqa9mRHBH0rBQtWRY
         oLTmz1pqv16o5vY0OM8i+OBTJus83vN3/t3xq930D/fdXWbVmjMVUvTgQlYTCEGZjKt3
         A6k8jt/30hAw8iNFYd4Bz+NZ116u8IupujbmAvjh6Ah8VVGZ896z15airLdmeK6FHbod
         uLb51zg1NecYC2kaU8WuBeA9lXNjyUqmbN06YTnOBue93k7bVaVfbdW/w24TbywYgtgj
         xNSw==
X-Gm-Message-State: AOJu0YwUnK/C8xzq4/HaK+qRXsN17yG4/+DJYYDvedGmGsbQk8I6iO+d
	sQINLd6bJbBEnCbxjX9/WoE=
X-Google-Smtp-Source: AGHT+IGXPiIL+mDf/ODotUtpAqTkhOERBz/8URwiLqxDehKow7wfpv/pSiZrEeoQfSoSKGg0d/0B7A==
X-Received: by 2002:a05:6e02:216d:b0:360:58e:1ee4 with SMTP id s13-20020a056e02216d00b00360058e1ee4mr14846922ilv.39.1704006915052;
        Sat, 30 Dec 2023 23:15:15 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:14 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 26/73] ksmbd: return a literal instead of 'err' in ksmbd_vfs_kern_path_locked()
Date: Sun, 31 Dec 2023 16:12:45 +0900
Message-Id: <20231231071332.31724-27-linkinjeon@kernel.org>
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

[ Upstream commit cf5e7f734f445588a30350591360bca2f6bf016f ]

Return a literal instead of 'err' in ksmbd_vfs_kern_path_locked().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index e6218c687fa0..d0a85774a496 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1208,7 +1208,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 
 	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, path);
 	if (!err)
-		return err;
+		return 0;
 
 	if (caseless) {
 		char *filepath;
-- 
2.25.1


