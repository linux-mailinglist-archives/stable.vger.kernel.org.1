Return-Path: <stable+bounces-8070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE781A46A
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BE0B27D7D
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A62C4B5BC;
	Wed, 20 Dec 2023 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OzQ/Uf3S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A5482D0;
	Wed, 20 Dec 2023 16:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A554C433C8;
	Wed, 20 Dec 2023 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088825;
	bh=WFs72ylUxgdwsUFXmpE1BK/uveBHocdJofPfPzYVsms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OzQ/Uf3SYnvsnjAKZWFC74/ol5CVnXA1N9+SIdfMQxdxbl09D6C3L9wt4751xEgu0
	 KQz/Te7jWQe9mWzQ9ho7srPW6bGgkhh7kZAWlwBZKW1A1pvNGCRqFLlJnxszWYUFw0
	 TbhjO11MQbfI1D9oTjV889iMwEE//xeuur1JgCKQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dawei Li <set_pte_at@outlook.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 073/159] ksmbd: Remove duplicated codes
Date: Wed, 20 Dec 2023 17:08:58 +0100
Message-ID: <20231220160934.785541770@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dawei Li <set_pte_at@outlook.com>

[ Upstream commit 7010357004096e54c884813e702d71147dc081f8 ]

ksmbd_neg_token_init_mech_token() and ksmbd_neg_token_targ_resp_token()
share same implementation, unify them.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/asn1.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

--- a/fs/ksmbd/asn1.c
+++ b/fs/ksmbd/asn1.c
@@ -208,9 +208,9 @@ int ksmbd_neg_token_init_mech_type(void
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
 
@@ -223,17 +223,16 @@ int ksmbd_neg_token_init_mech_token(void
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



