Return-Path: <stable+bounces-9109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8974F820A3F
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33180283256
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C6717C3;
	Sun, 31 Dec 2023 07:19:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E8185D
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3ef33e68dso52205595ad.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007178; x=1704611978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQvzpBdmVugwo42Qv8n0dBt9zDuMJ1bSzsonlSepcFM=;
        b=L00n/njNii1tvhfL2WUIE/oQ92ahZQ0ZAt9Ln1pWIeCHr+WTvHLfSr2SaWt2Ll+jDx
         Is0pGfAMW8oz7vdz+9gAgXNBoeu+hPUJBaI62j5kU6tMp+m3xq91Rb7UdGTcsrq+LXqH
         TtL6b4/OlqYd6oWh7W/HQ63lA3qGFVe5ZkhcDnBjq2qwvxnU8jVTg1Vbe1cPEpg/7jqr
         BX6BAQvnSxH9UiuU52HHePcl/J/DEipOsusxLcUThGDwsqcf5UwAfQ1ei77EkFawhWTr
         b3dVgIFhrRzyINFygMn/v4xrt0Q3TDImfx9ZsSOZ08mm6wUoDQsyYipStwt8Kx3JcHQ5
         7K5w==
X-Gm-Message-State: AOJu0YxG/fSlEp9iTv/TTNi8uRyfs8GhiiyNz1uqWz9ZECs+FAG9QuxQ
	L2sNWsZagS83q2CPKpbB7Lk=
X-Google-Smtp-Source: AGHT+IHJe93FzKrnXnyGLOYrj87AoiHjg6+RjE9p1TPwc+KAD/id5ksO7XP/txnysr9lCz/8OEd8Pw==
X-Received: by 2002:a17:902:e5c1:b0:1d3:d9d3:6a4c with SMTP id u1-20020a170902e5c100b001d3d9d36a4cmr18589967plf.60.1704007178390;
        Sat, 30 Dec 2023 23:19:38 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:19:37 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Cheng-Han Wu <hank20010209@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 01/19] ksmbd: Remove unused field in ksmbd_user struct
Date: Sun, 31 Dec 2023 16:19:01 +0900
Message-Id: <20231231071919.32103-2-linkinjeon@kernel.org>
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

From: Cheng-Han Wu <hank20010209@gmail.com>

[ Upstream commit eacc655e18d1dec9b50660d16a1ddeeb4d6c48f2 ]

fs/smb/server/mgmt/user_config.h:21: Remove the unused field 'failed_login_count' from the ksmbd_user struct.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/mgmt/user_config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/server/mgmt/user_config.h b/fs/smb/server/mgmt/user_config.h
index 6a44109617f1..e068a19fd904 100644
--- a/fs/smb/server/mgmt/user_config.h
+++ b/fs/smb/server/mgmt/user_config.h
@@ -18,7 +18,6 @@ struct ksmbd_user {
 
 	size_t			passkey_sz;
 	char			*passkey;
-	unsigned int		failed_login_count;
 };
 
 static inline bool user_guest(struct ksmbd_user *user)
-- 
2.25.1


