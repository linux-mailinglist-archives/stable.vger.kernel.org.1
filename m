Return-Path: <stable+bounces-7755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CE881761E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017561C250F3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C19E74E09;
	Mon, 18 Dec 2023 15:42:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C39B74E0E
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b7df7d14dso1142521a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914126; x=1703518926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LWQJhjM47mDAYdCjmnme1MVNhiFsM9DTp7Vy970k8A=;
        b=gkKelRa6dl3ndGgrcg8a76OkmDcj8CIpSFNSjRNRcW2L2M32lVQ7DBOUdqG2hL8eeR
         TJRE+jmpBrUZbM2Vyipf+SjnblnRLjO7qyq0ZSga385W9IsJSqJlpztCNXtnAgGLTkak
         yMzLzIy4sh/apZgwgLohRoADCqVmIfZVHKcrDOVIk6h6dJ37/xSV4ckQ8zrxKJ3LznDA
         0kzuIVMejtyPRu23UAcK2gCUf3gDtatmvCAMYD68APRiplOa811JnqlVbBJ7rgLYzxfY
         LJfQSjwRF/6jjufiKv5ASmbw89XnPHP1jVNm6BzTjGsxcy1Pp7lqItPS5kFcc8bsCKip
         hcLw==
X-Gm-Message-State: AOJu0YxxJ5tlUtXHKWaNZFu+Ff8L7kqmPXJhaT0Qmb7ANHPNbQfTFjfn
	8gIqXonXHiNb/Bny9LoSd4Y=
X-Google-Smtp-Source: AGHT+IHR0Dfe9Q3tgt+RAbRccux3m4lOMhchwi34Xe/2/6TLtBDgGBDgRj1TjzMlxcJgt8zMXhvTCQ==
X-Received: by 2002:a17:90a:bd05:b0:28b:9865:de5f with SMTP id y5-20020a17090abd0500b0028b9865de5fmr717752pjr.56.1702914126362;
        Mon, 18 Dec 2023 07:42:06 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:05 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Steve French <stfrench@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15.y 126/154] ksmbd: remove experimental warning
Date: Tue, 19 Dec 2023 00:34:26 +0900
Message-Id: <20231218153454.8090-127-linkinjeon@kernel.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit f5069159f32c8c943e047f22731317463c8e9b84 ]

ksmbd has made significant improvements over the past two
years and is regularly tested and used.  Remove the experimental
warning.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/Kconfig  | 2 +-
 fs/ksmbd/server.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
index 7055cb5d2880..d036ab80fec3 100644
--- a/fs/ksmbd/Kconfig
+++ b/fs/ksmbd/Kconfig
@@ -1,5 +1,5 @@
 config SMB_SERVER
-	tristate "SMB3 server support (EXPERIMENTAL)"
+	tristate "SMB3 server support"
 	depends on INET
 	depends on MULTIUSER
 	depends on FILE_LOCKING
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index ff1514c79f16..f5d8e405cf6f 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -591,8 +591,6 @@ static int __init ksmbd_server_init(void)
 	if (ret)
 		goto err_crypto_destroy;
 
-	pr_warn_once("The ksmbd server is experimental\n");
-
 	return 0;
 
 err_crypto_destroy:
-- 
2.25.1


