Return-Path: <stable+bounces-9086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF20A820A27
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857711F22127
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAFA17C2;
	Sun, 31 Dec 2023 07:16:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAC186C
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3ef33e68dso52201655ad.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007005; x=1704611805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQvzpBdmVugwo42Qv8n0dBt9zDuMJ1bSzsonlSepcFM=;
        b=Y+bqhcyS2nALJlK5VaQWqkYr2RJQ3vsvQQ2aehJlbqOuPa40zfTbfiP285N4h45psL
         EmWAGQZTDIMnfFU9lG0sBooPTkpqRMYgqO3XNn7VEeW5bkWzBWvgn+s4ZIAv8tXRo45v
         rjZVJBzyq04iaPPmXFek82yvfIHKTXMO/MKUbPOu/zdjQ+p4Kyeum9UV9a7IY9dCL7uV
         Q24UFHrVxcgWefTOV4zKfYrHViZdxdE8gB2Hc17o6WcBoFBB/0QHLhwaF9LGWK2FZR+u
         L+ha3CUBLnoqf/9Ycm3gurFGuANNYv5kM+cR4zbVR2dd4/q1iYPNoueVloWqEwEqDRE3
         stsg==
X-Gm-Message-State: AOJu0YzJA0ZWXdCFYwz0lgqSChpy6v6d2dgureRJOCZQBbIe+nozTfs4
	DLOfmVNNtcSUFilusk4SQ+Y=
X-Google-Smtp-Source: AGHT+IGnujEYfHwJmD8v6uddfLH51eADkloTUU3XJqyZBbINlHylsHaWLRG252OMEfKrdaQyRwVT/A==
X-Received: by 2002:a17:902:ea94:b0:1d3:eaaa:a2fd with SMTP id x20-20020a170902ea9400b001d3eaaaa2fdmr19270104plb.48.1704007005238;
        Sat, 30 Dec 2023 23:16:45 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:44 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Cheng-Han Wu <hank20010209@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 52/73] ksmbd: Remove unused field in ksmbd_user struct
Date: Sun, 31 Dec 2023 16:13:11 +0900
Message-Id: <20231231071332.31724-53-linkinjeon@kernel.org>
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


