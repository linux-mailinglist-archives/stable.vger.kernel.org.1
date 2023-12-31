Return-Path: <stable+bounces-9078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764FF820A1F
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8646B213F6
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E5F17D3;
	Sun, 31 Dec 2023 07:16:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FA17C7
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-20400d5b54eso6193749fac.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006977; x=1704611777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmqP+DHdRVWs48nDLoFtbY8YbIxOZtrJROh69AYbY84=;
        b=EL8hF9jSJf/IgDapfBiiX8qwusCXWyUkgaYs7ElLCAisRpQ+H8asgQwdEUX8+U7Nsb
         suumY46uQxOF4AAluDFYZZSKmWSq+pFmqdmwpeBeUvdtEuDQH9tAIL+buDg6gpM74/TI
         pFKl7JxPw9pNexv1Gs3mkwNuqn6QmKJi6KUlUE1nlLiA9UTJUMmHY5HJTEgS4UgLYZj+
         WQUgo6b1XaGTtgRJQc8g8+JPcwpoRiYeKpUr9P6ac960IPEEn+OaHkUO+I8uvZdVAAmF
         NB880P90X0G1PU9WuCZtSG45hQ1hk4tHNRfU9j/I1jgk6SOELNeVlIZgHx0Y4NqZrJFO
         zAqQ==
X-Gm-Message-State: AOJu0YwpYP5+CYhhf+TwLqQLrZfdEAahiovxIpZDmha1rCFuxTWObUQ6
	Gqee+K8Pf/aUPCVe81/sxxM=
X-Google-Smtp-Source: AGHT+IFglODwEY3xM/frhYPveRnV8sjcgKCZiRMjozFUDk50Ep1rUyrDOWwtiMraKJgrBX8GEYc63Q==
X-Received: by 2002:a05:6870:330b:b0:203:180b:9b31 with SMTP id x11-20020a056870330b00b00203180b9b31mr18039406oae.93.1704006977138;
        Sat, 30 Dec 2023 23:16:17 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:16 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 44/73] ksmbd: check iov vector index in ksmbd_conn_write()
Date: Sun, 31 Dec 2023 16:13:03 +0900
Message-Id: <20231231071332.31724-45-linkinjeon@kernel.org>
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

[ Upstream commit 73f949ea87c7d697210653501ca21efe57295327 ]

If ->iov_idx is zero, This means that the iov vector for the response
was not added during the request process. In other words, it means that
there is a problem in generating a response, So this patch return as
an error to avoid NULL pointer dereferencing problem.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/connection.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index d1f4ed18a227..4b38c3a285f6 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -199,6 +199,9 @@ int ksmbd_conn_write(struct ksmbd_work *work)
 	if (work->send_no_response)
 		return 0;
 
+	if (!work->iov_idx)
+		return -EINVAL;
+
 	ksmbd_conn_lock(conn);
 	sent = conn->transport->ops->writev(conn->transport, work->iov,
 			work->iov_cnt,
-- 
2.25.1


