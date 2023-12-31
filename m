Return-Path: <stable+bounces-9074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1105820A1B
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E7A1F22134
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756917F4;
	Sun, 31 Dec 2023 07:16:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0F17C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-203fb334415so4567201fac.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006964; x=1704611764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72spdDBRznUUjvUb3rHjcZdt+i+YXovU67asTy/UmZo=;
        b=i8qg+hahJXmuTggGhPpEYFC2KIb11Xnr5uynPamnoGQ1DQ+xcuwNUUXdTk3fbzW3aW
         FqWiiZ07Np+O18ZDipSs4WndzYfBPBU0ApGIdXYN2tkPLiZcX9Gc1tXyRszukK2F+MsN
         qsrlrkVZ7f+7cC9dtbI0TYY5ZMSIXDq7F6zC9iEmoqfgWxu2M0UAYzAcuC9AdIyI7J+e
         g0wugwBeyIOyyjv1HeBHnhYuFbraSSQTLFlLuQv7NZaEkOGBARLl4pmsbWe8PBkBn6oz
         eR1/DVeTl8TyGUzuAt6pudAriveyzs2EpKG/d3JDqHuq1XP6FefMzrfQTj1X0o/AnZ6l
         nf/w==
X-Gm-Message-State: AOJu0Yw+fp6MGZI2Ln3wB5x4EU65H17ATOTqnTFAH4gJQ6dDFBZ3AWMa
	PlqkHf7U5Q5RnE9BCPiBFIA=
X-Google-Smtp-Source: AGHT+IHlUwIM3l5rae1AFLr3PA3OVDBZuyo1G8uLo+bZXmiuX+4h0e3W7n3/dscUj+WO2IpiX4nNpw==
X-Received: by 2002:a05:6870:b61f:b0:204:eff:c61c with SMTP id cm31-20020a056870b61f00b002040effc61cmr17067258oab.24.1704006963962;
        Sat, 30 Dec 2023 23:16:03 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:03 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Steve French <stfrench@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.1.y 40/73] ksmbd: remove experimental warning
Date: Sun, 31 Dec 2023 16:12:59 +0900
Message-Id: <20231231071332.31724-41-linkinjeon@kernel.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit f5069159f32c8c943e047f22731317463c8e9b84 ]

ksmbd has made significant improvements over the past two
years and is regularly tested and used.  Remove the experimental
warning.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/Kconfig  | 2 +-
 fs/smb/server/server.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/smb/server/Kconfig b/fs/smb/server/Kconfig
index 7055cb5d2880..d036ab80fec3 100644
--- a/fs/smb/server/Kconfig
+++ b/fs/smb/server/Kconfig
@@ -1,5 +1,5 @@
 config SMB_SERVER
-	tristate "SMB3 server support (EXPERIMENTAL)"
+	tristate "SMB3 server support"
 	depends on INET
 	depends on MULTIUSER
 	depends on FILE_LOCKING
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index ff1514c79f16..f5d8e405cf6f 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -591,8 +591,6 @@ static int __init ksmbd_server_init(void)
 	if (ret)
 		goto err_crypto_destroy;
 
-	pr_warn_once("The ksmbd server is experimental\n");
-
 	return 0;
 
 err_crypto_destroy:
-- 
2.25.1


