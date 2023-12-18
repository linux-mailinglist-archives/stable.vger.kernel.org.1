Return-Path: <stable+bounces-7750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3373C817619
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61081F23F39
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B15E740A2;
	Mon, 18 Dec 2023 15:41:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA874E01
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b9460a9easo502679a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914110; x=1703518910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWOshPD1Bta/fmwvhR+yiNRFID6dcWVT2sxguo6F2jM=;
        b=dgQJzScmm/Nxps5wQd/C1INRbwwlqASMmwCWTE2GD+5C+7H+cFLDBDWmvYKKRV7hwu
         iWgW5t07pmPMWbMXuHZelSbQa17U8p/D2O+h2rmgPNtoVSrsDXZmaNbkWLPEPzX7qgfG
         uqOqZG1HIyt2+akDAQKs/QajeCiAPx13Xl7u1ICb3wSS3Q1PNFglbNuPRXMXJRM11/eY
         vLI1hgR7ycxBohws+bCKAl4nbCihqIcfKuQ9vQwi4sDUkghb7mOhpei+IHLq210wfaE4
         SV+KfNuv1zRMnBVFhzZNsZvbt3JlfLbwoOMvqbpmPCYtgae7Hu3oFclB9TJW+5KFdYWV
         QdEw==
X-Gm-Message-State: AOJu0Yx6WouH0f81xTQIa6ovIZCH5bwg/4QQRty1xBRnh06V1cHszzwC
	o7ImO23YKrYetue46kJ7VOeGfciJbLvFSQ==
X-Google-Smtp-Source: AGHT+IEeNl/gtwTfH/GbBiimYQ684XVRHUT8bVnb60zve9losy2kGsBqRZoTUgpUiQ9Rg0JQ0MMlDA==
X-Received: by 2002:a17:90a:34c8:b0:28b:328a:3b36 with SMTP id m8-20020a17090a34c800b0028b328a3b36mr1811853pjf.25.1702914110598;
        Mon, 18 Dec 2023 07:41:50 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:50 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	=?UTF-8?q?Atte=20Heikkil=C3=A4?= <atteh.mailbox@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 121/154] ksmbd: fix `force create mode' and `force directory mode'
Date: Tue, 19 Dec 2023 00:34:21 +0900
Message-Id: <20231218153454.8090-122-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Atte Heikkilä <atteh.mailbox@gmail.com>

[ Upstream commit 65656f5242e500dcfeffa6a0a1519eae14724f86 ]

`force create mode' and `force directory mode' should be bitwise ORed
with the perms after `create mask' and `directory mask' have been
applied, respectively.

Signed-off-by: Atte Heikkilä <atteh.mailbox@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/mgmt/share_config.h | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/ksmbd/mgmt/share_config.h b/fs/ksmbd/mgmt/share_config.h
index 3fd338293942..5f591751b923 100644
--- a/fs/ksmbd/mgmt/share_config.h
+++ b/fs/ksmbd/mgmt/share_config.h
@@ -34,29 +34,22 @@ struct ksmbd_share_config {
 #define KSMBD_SHARE_INVALID_UID	((__u16)-1)
 #define KSMBD_SHARE_INVALID_GID	((__u16)-1)
 
-static inline int share_config_create_mode(struct ksmbd_share_config *share,
-					   umode_t posix_mode)
+static inline umode_t
+share_config_create_mode(struct ksmbd_share_config *share,
+			 umode_t posix_mode)
 {
-	if (!share->force_create_mode) {
-		if (!posix_mode)
-			return share->create_mask;
-		else
-			return posix_mode & share->create_mask;
-	}
-	return share->force_create_mode & share->create_mask;
+	umode_t mode = (posix_mode ?: (umode_t)-1) & share->create_mask;
+
+	return mode | share->force_create_mode;
 }
 
-static inline int share_config_directory_mode(struct ksmbd_share_config *share,
-					      umode_t posix_mode)
+static inline umode_t
+share_config_directory_mode(struct ksmbd_share_config *share,
+			    umode_t posix_mode)
 {
-	if (!share->force_directory_mode) {
-		if (!posix_mode)
-			return share->directory_mask;
-		else
-			return posix_mode & share->directory_mask;
-	}
+	umode_t mode = (posix_mode ?: (umode_t)-1) & share->directory_mask;
 
-	return share->force_directory_mode & share->directory_mask;
+	return mode | share->force_directory_mode;
 }
 
 static inline int test_share_config_flag(struct ksmbd_share_config *share,
-- 
2.25.1


