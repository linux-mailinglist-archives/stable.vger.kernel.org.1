Return-Path: <stable+bounces-7768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F37F81762E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D070A1F2541F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F86E498BA;
	Mon, 18 Dec 2023 15:42:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE93D564
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28ba18740d6so457502a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914168; x=1703518968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlz5/rbE1EpvoaP2dv/4ato9Jqvb/cXXY3NNqevT2Bs=;
        b=gYGa21pNxUnpx0+vXFZ+Cw2qHWnd7uc0G3I+pQ+DjZw5MEwm11s7l2RQXcmydW4yEZ
         z5qAfhPXk23jd6Q6juWCHdTYnaouYYzQ6o6Hl2nWlmSOFRIh4u6bc/MTECZAb19slqtP
         VBAsNq4yQCDjEwqLo8Gs8Km1vhG+1tETc6V+pJclA9mdqevWxyLV84MwMPWsuBLkFm1+
         MlDEu71El4RjgIUEUTJl4RwOalpXWTYgA1sR9rglXNlA0gAYkydI+6dUj/l0IutfpqCN
         mRMaakRoYidDubg7QJ/hTzMmqkcm2ilzXms/zB5pK1fiBICSLrjMRSYSc1Uxy8FQIRiN
         uMGw==
X-Gm-Message-State: AOJu0Yzo13S/PwOeq9lfKIs3HU85yQHJPCGnMQziud1LLMEqrZJJqXdC
	Ah9ERv6SHmm4s/BYMA8xgeE=
X-Google-Smtp-Source: AGHT+IFkiMp3Hj8przbyaArl3XIpN0o37IKJjQQyx0R34NSiBFnHRMOxD9KlJsYQiHoYKQSbMflhUA==
X-Received: by 2002:a17:90a:d518:b0:28b:924d:a7d8 with SMTP id t24-20020a17090ad51800b0028b924da7d8mr785786pju.51.1702914168315;
        Mon, 18 Dec 2023 07:42:48 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:47 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Cheng-Han Wu <hank20010209@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 139/154] ksmbd: Remove unused field in ksmbd_user struct
Date: Tue, 19 Dec 2023 00:34:39 +0900
Message-Id: <20231218153454.8090-140-linkinjeon@kernel.org>
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

From: Cheng-Han Wu <hank20010209@gmail.com>

[ Upstream commit eacc655e18d1dec9b50660d16a1ddeeb4d6c48f2 ]

fs/smb/server/mgmt/user_config.h:21: Remove the unused field 'failed_login_count' from the ksmbd_user struct.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/mgmt/user_config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ksmbd/mgmt/user_config.h b/fs/ksmbd/mgmt/user_config.h
index 6a44109617f1..e068a19fd904 100644
--- a/fs/ksmbd/mgmt/user_config.h
+++ b/fs/ksmbd/mgmt/user_config.h
@@ -18,7 +18,6 @@ struct ksmbd_user {
 
 	size_t			passkey_sz;
 	char			*passkey;
-	unsigned int		failed_login_count;
 };
 
 static inline bool user_guest(struct ksmbd_user *user)
-- 
2.25.1


