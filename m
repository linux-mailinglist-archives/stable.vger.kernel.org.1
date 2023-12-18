Return-Path: <stable+bounces-7638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769E3817562
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AD51F23B57
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286D53D564;
	Mon, 18 Dec 2023 15:35:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2713D54C
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d2e6e14865so12285105ad.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913746; x=1703518546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J519Vwjn76CztkA7dA2vHNA/T8eSr5wcpSxIQSKYBo=;
        b=uaB4iAOaaHiiq486M52R4iDO16sf8UkViP1/u4cKz8uEEUnH7lpRj4Ck3fbkZfx7k5
         GilZrEkDxlOfylqumtK6ItmIguJA2/SH5ql93hCtHqybxgrFGdMNhEnY7+Vcf3H0W8I6
         Fxf8rXsBxTzLBW85TgwBJX8PJZVaXRKu10an6eo78wTvNRJCR0nE7oNpMaDbpd3/qwij
         qQneU5Zxg1UyBIHdpJk5UoiW6dAv8nau5BSM1/DF1WruG3TLwfC1WJ5G7C5erulX6AS/
         IvigmIqZMOJY0CuVrpCMGEd2C/Vu9OXShnjoXw2kOd9PI1dkwzPf8O2xfPG7N+YVl/gT
         WRpw==
X-Gm-Message-State: AOJu0YzTHKmYY8VBsSCqzsf/pMu3WY9CYNRUFz6arA7iQwlQC4MQ3WMT
	EgYUuKVk3NN2Ro/shuhMSc8=
X-Google-Smtp-Source: AGHT+IGCVt9uaKp5dsZWvhAjEmPODRQY+tJlanUHgm95EOGUenYnlPB20udU/aee9CyBPewP4MM1Zg==
X-Received: by 2002:a17:90b:19d3:b0:28b:9c47:72d3 with SMTP id nm19-20020a17090b19d300b0028b9c4772d3mr531823pjb.94.1702913746010;
        Mon, 18 Dec 2023 07:35:46 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:45 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 009/154] ksmbd: Remove unused parameter from smb2_get_name()
Date: Tue, 19 Dec 2023 00:32:29 +0900
Message-Id: <20231218153454.8090-10-linkinjeon@kernel.org>
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

From: Marios Makassikis <mmakassikis@freebox.fr>

[ Upstream commit 80917f17e3f99027661a45262c310139e53a9faa ]

The 'share' parameter is no longer used by smb2_get_name() since
commit 265fd1991c1d ("ksmbd: use LOOKUP_BENEATH to prevent the out of
share access").

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index e693595b9cf3..bf537080b2e0 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -651,7 +651,6 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 
 /**
  * smb2_get_name() - get filename string from on the wire smb format
- * @share:	ksmbd_share_config pointer
  * @src:	source buffer
  * @maxlen:	maxlen of source string
  * @nls_table:	nls_table pointer
@@ -659,8 +658,7 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
  * Return:      matching converted filename on success, otherwise error ptr
  */
 static char *
-smb2_get_name(struct ksmbd_share_config *share, const char *src,
-	      const int maxlen, struct nls_table *local_nls)
+smb2_get_name(const char *src, const int maxlen, struct nls_table *local_nls)
 {
 	char *name;
 
@@ -2604,8 +2602,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out1;
 		}
 
-		name = smb2_get_name(share,
-				     req->Buffer,
+		name = smb2_get_name(req->Buffer,
 				     le16_to_cpu(req->NameLength),
 				     work->conn->local_nls);
 		if (IS_ERR(name)) {
@@ -5481,8 +5478,7 @@ static int smb2_rename(struct ksmbd_work *work,
 		goto out;
 	}
 
-	new_name = smb2_get_name(share,
-				 file_info->FileName,
+	new_name = smb2_get_name(file_info->FileName,
 				 le32_to_cpu(file_info->FileNameLength),
 				 local_nls);
 	if (IS_ERR(new_name)) {
@@ -5593,8 +5589,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (!pathname)
 		return -ENOMEM;
 
-	link_name = smb2_get_name(share,
-				  file_info->FileName,
+	link_name = smb2_get_name(file_info->FileName,
 				  le32_to_cpu(file_info->FileNameLength),
 				  local_nls);
 	if (IS_ERR(link_name) || S_ISDIR(file_inode(filp)->i_mode)) {
-- 
2.25.1


