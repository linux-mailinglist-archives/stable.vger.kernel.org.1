Return-Path: <stable+bounces-7722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592638175F2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A2EB22E5B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F507145A;
	Mon, 18 Dec 2023 15:40:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776A71457
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28b9460a9easo499711a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914023; x=1703518823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUjZmEdyN8lt0fh2JwoKpm6ivjqVbrdqVgzmAf32Xp4=;
        b=W1LOP+NhhUwAzkx4h1CERU3k7hXMPoMsoZ6fanfj6+quV1nDzTgVTEfD5S8y9FHtOj
         bNDD4U5MzfNjitp2WiyFPXfEpIjRAeEmxekV1o3v9gqqI5PqH2TVZhPne6WJGEEzd/x5
         JBRw4mtikSFjvJawwdQ6fg9YrtgzfkPBbruV2Cw1NiEvIObit43LTJV9paZtYJOJQDkX
         V/hntCDwOImfkaNlaHWe2tOH4IQdoAKsHyIWGrPqNL20+5jUa7zdhe8RyO3dGjwFKpaF
         fSwyOnlmAof1DmHLY1MpOFPBF9JVhhPlFGJtqQSLcme9TmfHFhb4M8OYhdVZBFcmCcEY
         aiKA==
X-Gm-Message-State: AOJu0YzCG1kVdCDrcVgqv5o2wk0FeTnckeUvz+YrLHcJYGuW55nh7ac9
	gm4PlSgpXABLLo1K566F1pA=
X-Google-Smtp-Source: AGHT+IEll+1Ve4r025WbXVK/8rukK4uJwTxzKkrwGaoAF6stI0BeHZeaKSEGNGkujsnNQscICIXvEQ==
X-Received: by 2002:a17:90a:582:b0:28a:b561:e3ee with SMTP id i2-20020a17090a058200b0028ab561e3eemr5453920pji.54.1702914023470;
        Mon, 18 Dec 2023 07:40:23 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:23 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Coverity Scan <scan-admin@coverity.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 094/154] ksmbd: fix uninitialized pointer read in smb2_create_link()
Date: Tue, 19 Dec 2023 00:33:54 +0900
Message-Id: <20231218153454.8090-95-linkinjeon@kernel.org>
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

[ Upstream commit df14afeed2e6c1bbadef7d2f9c46887bbd6d8d94 ]

There is a case that file_present is true and path is uninitialized.
This patch change file_present is set to false by default and set to
true when patch is initialized.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index c492e7f73a7e..0e6f39f05af2 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5529,7 +5529,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
 	struct path path;
-	bool file_present = true;
+	bool file_present = false;
 	int rc;
 
 	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
@@ -5562,8 +5562,8 @@ static int smb2_create_link(struct ksmbd_work *work,
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


