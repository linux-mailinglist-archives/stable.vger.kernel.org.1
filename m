Return-Path: <stable+bounces-7702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B988175DE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7B91C2501D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5015D73B;
	Mon, 18 Dec 2023 15:39:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65065BFAB
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso1463094a12.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913956; x=1703518756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TTrSwsMiRh5F66l6q7MJsRdn7qwHi2jRZVt/UVfe2U=;
        b=VO33KTkHR+pTFJZC8i/t2SNndhaHzPsvTXpCdAT2pN4vuJ0CxbMRf9uxiUwDPj3GCr
         Y5o+zrmv3o2ov7BIDnMfU9EqlV7E/idHkjorAcchpGmuhr7Dz9oaRNdVEeEnIht2S6B0
         87AFOdimZ8jbfNatwe6L2G4eGb7GMdNBXpNoYfK+V7hxtrytjKHmfA9ZgXw2vf++JSOI
         oQPQU4yTY7tvCEtlj+C5ZtZKU4u1uxkbmA6AI+B9tKatNVYiCZd/a3OblA0aJKpOwQzE
         AXtp0u6TEiD0BcAni7P/6klHcL4DsIa/Czw/XEhPNxeNvktcsfOgA4tgMnWJn51xLGqS
         kmVA==
X-Gm-Message-State: AOJu0Yy/Tbmg9d/n+4mSaa0Tt3U0JM2zMA0NB28AxS26q+BS6I5lHOVE
	oPHXxfWvFfet5YReulyPRsg=
X-Google-Smtp-Source: AGHT+IHKb9CuIuqvufxzm+H1xm66YCb/LVQ2kpgJztUU0vuI2aJ3jq8s9ZGhqW/mUx+XwGV9VkPHgQ==
X-Received: by 2002:a17:90a:1fc4:b0:28b:6aea:1a91 with SMTP id z4-20020a17090a1fc400b0028b6aea1a91mr1199083pjz.3.1702913956310;
        Mon, 18 Dec 2023 07:39:16 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:15 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Dawei Li <set_pte_at@outlook.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 073/154] ksmbd: Remove duplicated codes
Date: Tue, 19 Dec 2023 00:33:33 +0900
Message-Id: <20231218153454.8090-74-linkinjeon@kernel.org>
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

From: Dawei Li <set_pte_at@outlook.com>

[ Upstream commit 7010357004096e54c884813e702d71147dc081f8 ]

ksmbd_neg_token_init_mech_token() and ksmbd_neg_token_targ_resp_token()
share same implementation, unify them.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/asn1.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/ksmbd/asn1.c b/fs/ksmbd/asn1.c
index c03eba090368..cc6384f79675 100644
--- a/fs/ksmbd/asn1.c
+++ b/fs/ksmbd/asn1.c
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


