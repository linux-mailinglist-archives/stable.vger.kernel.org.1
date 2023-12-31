Return-Path: <stable+bounces-9054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BBE820A07
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1843B1F21F58
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DAD17C7;
	Sun, 31 Dec 2023 07:14:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DA6D6EF
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc018228b4so2378419a34.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006894; x=1704611694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVUGyai1Ve5Rcu8Bwn27SHGOyyec0V6k0wQIr3XVAqM=;
        b=f/uu5E8LP572frIYsWICgAaHgBkcGGdKQ48RHqg2vM/7WPG1umUh7OoQsTVry9LRu4
         QZitUieZlP0Z3WMQLtDb8DbV0q3CkaXOQ2sAcmPnqoElx0AnEuNzrSydhY0tLHAXREn/
         rxlVL4cVJEStBvebGrCjj0yFsITr5/be69CI1p+hLJnPOPn3zWzr6yjXlITXSvjNC845
         2kSSuml/IzqkirTfHztx6R2Znit6u0D+rJcuVY4U18pAwsLrnSn7LC2BFLUNOjj5Rk2B
         5RAZBCvZbp+quB6qBnMl8vp9eYQ4MC6lTgoBBsNwsHia6UnMGkHUNAgq4WRbkbgFq9l1
         tGbg==
X-Gm-Message-State: AOJu0Yx/T12AiLNyN2BKH8tobxpggxX6VaXE5iJ92wxv1MHrSnuZrtiS
	zjIXq/HPWOFSUaKdHi5QkHQ=
X-Google-Smtp-Source: AGHT+IEY/nO2esyU+DxflndjRCp1qEcPDvUdTYwSsOT0rS2EHXWHvgKmAC4KBcYpek/YmgOzJS8Wvg==
X-Received: by 2002:a05:6871:712:b0:203:f9ea:2f30 with SMTP id f18-20020a056871071200b00203f9ea2f30mr18055931oap.76.1704006893835;
        Sat, 30 Dec 2023 23:14:53 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:53 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Coverity Scan <scan-admin@coverity.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 20/73] ksmbd: fix uninitialized pointer read in smb2_create_link()
Date: Sun, 31 Dec 2023 16:12:39 +0900
Message-Id: <20231231071332.31724-21-linkinjeon@kernel.org>
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

[ Upstream commit df14afeed2e6c1bbadef7d2f9c46887bbd6d8d94 ]

There is a case that file_present is true and path is uninitialized.
This patch change file_present is set to false by default and set to
true when patch is initialized.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index fe10c75f6f2b..028b1d1055b5 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5559,7 +5559,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
 	struct path path;
-	bool file_present = true;
+	bool file_present = false;
 	int rc;
 
 	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
@@ -5592,8 +5592,8 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
-		file_present = false;
-	}
+	} else
+		file_present = true;
 
 	if (file_info->ReplaceIfExists) {
 		if (file_present) {
-- 
2.25.1


