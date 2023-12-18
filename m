Return-Path: <stable+bounces-7633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF3817559
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9311F25B14
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B73D3D546;
	Mon, 18 Dec 2023 15:35:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65C3D545
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28b09aeca73so2274327a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913727; x=1703518527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz6FXJS/zHH8QEdVvn6Tt4cqBUIAyUtKq/NZ8AV1A5Y=;
        b=AdksefZj+7Lsy4S2z8gmjq/hH14iRP9dfRugP4lvUGXUHMuu4N2FMw5ciE8tn+Zj1d
         Q3HJd96ZCETjcuOS+S5/+wSFkATWBS46uSHuvKZlpwJgO614IpmM2s2E5U4v0RqXhrEU
         mfQ8XcepC0PG+Nwbf3wmNtD6EzrJyo/YH7pwRsybIXFptLNlLLV9Ey3T2nto5wXP98FU
         zfHfJeB0eIJlQ1hpqM1fPLI8ecVtgTSBX3k3RdvrHWm3ujLVEoIXISeXRUJ6anes8nm0
         2cMYrOuQYv6NIF/LMguyBF4ZAhrABpG1hhYUVREqYm9PbNAeyhE1rajWNCGf0CT2PDeO
         9BDw==
X-Gm-Message-State: AOJu0YxZ7czY2BkQfKxrFH44Mu78SLfpf3RZEkaDJKuEMN5P3X3afM6t
	4+9Lt02Adi3QsX5zn7WsR9s=
X-Google-Smtp-Source: AGHT+IF/6GCCDxbUctUQf5PQ1Kuq1Lw27kZVZv+11eu46LLE2INSo3fvaO6g9hwEfL039YAZYrewYA==
X-Received: by 2002:a17:90a:e7cf:b0:28b:4965:df91 with SMTP id kb15-20020a17090ae7cf00b0028b4965df91mr4622102pjb.10.1702913727424;
        Mon, 18 Dec 2023 07:35:27 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:26 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 004/154] ksmbd: remove md4 leftovers
Date: Tue, 19 Dec 2023 00:32:24 +0900
Message-Id: <20231218153454.8090-5-linkinjeon@kernel.org>
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

[ Upstream commit 561a1cf57535154f094f31167a9170197caae686 ]

As NTLM authentication is removed, md4 is no longer used.
ksmbd remove md4 leftovers, i.e. select CRYPTO_MD4, MODULE_SOFTDEP md4.

Acked-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/Kconfig  | 1 -
 fs/ksmbd/server.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
index 6af339cfdc04..e1fe17747ed6 100644
--- a/fs/ksmbd/Kconfig
+++ b/fs/ksmbd/Kconfig
@@ -6,7 +6,6 @@ config SMB_SERVER
 	select NLS
 	select NLS_UTF8
 	select CRYPTO
-	select CRYPTO_MD4
 	select CRYPTO_MD5
 	select CRYPTO_HMAC
 	select CRYPTO_ECB
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index eb45d56b3577..bca0fbf3c67c 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -628,7 +628,6 @@ MODULE_DESCRIPTION("Linux kernel CIFS/SMB SERVER");
 MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: ecb");
 MODULE_SOFTDEP("pre: hmac");
-MODULE_SOFTDEP("pre: md4");
 MODULE_SOFTDEP("pre: md5");
 MODULE_SOFTDEP("pre: nls");
 MODULE_SOFTDEP("pre: aes");
-- 
2.25.1


