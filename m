Return-Path: <stable+bounces-9071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 334E5820A19
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB22FB20FFE
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DB617C2;
	Sun, 31 Dec 2023 07:15:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8C185D
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-204fdd685fdso1981566fac.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006954; x=1704611754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3aD56OsRkF18EGqMRq0b0BQ9jd2cZDa+ovCtIqdOD8=;
        b=eYNbjSi14ELwI5MFMDCiZhK5LjAE8us1EQZbQoTJF/eglGe3nvHHyMu7KIWuQLez99
         pVbY7aSpNHF92BO3oqP8506uPCl7PSG65bAsxVggDRWrtM4M11YEkDAoflLswIaxqBid
         OX2Ic+7UctJrfgqsI/Fw0lerSqqvE+UxftvsXmn3XKAa52MTKj798LmdQM3/GFcKtOtg
         dVcB71J5AbEYhKXodJ44DUgCEXQJHxJl1r/BDigNyUMoX3AoOjilmSsQgYk/xzWYjErF
         +lTBakxXrzZPUi724QXd2FRyzLqi7sa+8vYSTkiHGLF8PZuJZDC9AmdRO0TEGzZ5Rx8U
         WFQA==
X-Gm-Message-State: AOJu0YyyGivG+xCDc+j84TMFhmX3L2x11PhEn3d3R03e/YBEZO/7Jjs/
	AT9jGNaM3FEzzdC9F56/me0=
X-Google-Smtp-Source: AGHT+IFTsm8CpSEgxgX/QW2oYBb9CI/+UuGyZfOH4oOs7fY2aZp1FGKkcPZiJboVZLX1Kzl5b7Mbig==
X-Received: by 2002:a05:6870:f110:b0:1fb:2f58:f1c4 with SMTP id k16-20020a056870f11000b001fb2f58f1c4mr20057364oac.48.1704006954186;
        Sat, 30 Dec 2023 23:15:54 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:53 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	=?UTF-8?q?Atte=20Heikkil=C3=A4?= <atteh.mailbox@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 37/73] ksmbd: fix `force create mode' and `force directory mode'
Date: Sun, 31 Dec 2023 16:12:56 +0900
Message-Id: <20231231071332.31724-38-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
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
 fs/smb/server/mgmt/share_config.h | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/smb/server/mgmt/share_config.h b/fs/smb/server/mgmt/share_config.h
index 3fd338293942..5f591751b923 100644
--- a/fs/smb/server/mgmt/share_config.h
+++ b/fs/smb/server/mgmt/share_config.h
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


