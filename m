Return-Path: <stable+bounces-9042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 185178209FB
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6F21F220B4
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E817C2;
	Sun, 31 Dec 2023 07:14:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F11184C
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-20503dc09adso1674244fac.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006852; x=1704611652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/doc2wa94THhEQ1f2Ebv6Ko3/aTv1gnTeS3Ca6UloA=;
        b=m0MDZi6LHKQjqLDVG1podWs1CCqsWwibITD3zvf87jvHkNAlx4PbppKycQ60xlUqg0
         VRqYqmePyK55RcRRjb4ml+mPsZKf2VGIxfADmEcVyjktV4/YjlFrDTZNx6bq6GZOKiC3
         5RI2QlFLrkSC68cIQDaUx+mygaq/Nw46h6OEO7DH6s9Yd8KCDk4KwX8OBqxNSboMJ740
         H4yP/Fahy7co62nYveS9PIxFONizLR+HsnIpQsWvH2WqM4CWi1xmmo6wwqEbu8cwfyDH
         UxhJ/diIJyWZNsgo7YwTE3H4g0tbpujVEZLqM/+Ed7ysNJ5dYOCPyDUTKXIscq2W9UB3
         bX6A==
X-Gm-Message-State: AOJu0YyKLuO5QlxoIzkcln0/BPr9GONCLJBJkWKpGKJhVJlBahAfkw+t
	X9gcf4ARNyEt3LlXQYy0jhA=
X-Google-Smtp-Source: AGHT+IGI6lR1Pkgt2G8icHhN8Al9FkbTyiJmdPUZnzJS5oqS6gb2YgY/nb8KkQG3HN+2QlkG8g77Tw==
X-Received: by 2002:a05:6870:9a0b:b0:204:1df:8234 with SMTP id fo11-20020a0568709a0b00b0020401df8234mr16836807oab.97.1704006851666;
        Sat, 30 Dec 2023 23:14:11 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:11 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Dawei Li <set_pte_at@outlook.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 08/73] ksmbd: Remove duplicated codes
Date: Sun, 31 Dec 2023 16:12:27 +0900
Message-Id: <20231231071332.31724-9-linkinjeon@kernel.org>
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

From: Dawei Li <set_pte_at@outlook.com>

[ Upstream commit 7010357004096e54c884813e702d71147dc081f8 ]

ksmbd_neg_token_init_mech_token() and ksmbd_neg_token_targ_resp_token()
share same implementation, unify them.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/asn1.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/smb/server/asn1.c b/fs/smb/server/asn1.c
index c03eba090368..cc6384f79675 100644
--- a/fs/smb/server/asn1.c
+++ b/fs/smb/server/asn1.c
@@ -208,9 +208,9 @@ int ksmbd_neg_token_init_mech_type(void *context, size_t hdrlen,
 	return 0;
 }
 
-int ksmbd_neg_token_init_mech_token(void *context, size_t hdrlen,
-				    unsigned char tag, const void *value,
-				    size_t vlen)
+static int ksmbd_neg_token_alloc(void *context, size_t hdrlen,
+				 unsigned char tag, const void *value,
+				 size_t vlen)
 {
 	struct ksmbd_conn *conn = context;
 
@@ -223,17 +223,16 @@ int ksmbd_neg_token_init_mech_token(void *context, size_t hdrlen,
 	return 0;
 }
 
-int ksmbd_neg_token_targ_resp_token(void *context, size_t hdrlen,
+int ksmbd_neg_token_init_mech_token(void *context, size_t hdrlen,
 				    unsigned char tag, const void *value,
 				    size_t vlen)
 {
-	struct ksmbd_conn *conn = context;
-
-	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
-	if (!conn->mechToken)
-		return -ENOMEM;
+	return ksmbd_neg_token_alloc(context, hdrlen, tag, value, vlen);
+}
 
-	memcpy(conn->mechToken, value, vlen);
-	conn->mechToken[vlen] = '\0';
-	return 0;
+int ksmbd_neg_token_targ_resp_token(void *context, size_t hdrlen,
+				    unsigned char tag, const void *value,
+				    size_t vlen)
+{
+	return ksmbd_neg_token_alloc(context, hdrlen, tag, value, vlen);
 }
-- 
2.25.1


