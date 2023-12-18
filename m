Return-Path: <stable+bounces-7759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79C2817622
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854D1280FFA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7FD74E2F;
	Mon, 18 Dec 2023 15:42:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9374E26
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28baab0762dso208758a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914139; x=1703518939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkSoNa3bRTCypWUGLTfdPodTHNJpE+VoTRRsgVSQBsg=;
        b=T5y8bYza1KbRuRw+Yvka+zNAWbxoEufq45W9qB7S1OozmS/5BPnByHoCDZeFvp6UyV
         F8AsmFQZTKofm9tEganuw0qpHkj8sluFxAkKHUSIdrruZrctMX9yy7N957LfzzC9bzr5
         hY5pdPxcCpCpaGZa3vq2gvxRuPgCCpNqQLndnR8N4Z4RRRfURs07QPbb06uYJlhCEnfY
         zi7FIqgvVxJOy6QK/5hFVbAGAhh0YVfD3Pmdb51JTN9YNOvuKRI19gtkM9N2yuYUOHJo
         e9CqQLTxdWWjQo6dBTfs8frgIrXmDv6KMPtbzYPvRbGOr5cSAmraZ2n3zpje4JCDVWyT
         ov4g==
X-Gm-Message-State: AOJu0YydfypOc4ypUkRrxZJCChvnfTyeQaAPx1jMBgRkz8MnphmopKgQ
	ZiIgPVpllGFTywJdGp23e/U=
X-Google-Smtp-Source: AGHT+IF+oppBQxlx8jOY/kCiqhBgrOz094tBTaSkZy43FkfWSUiVIaim8ZXUqjRCkMuJlIpWD40W6A==
X-Received: by 2002:a17:90a:dd41:b0:286:6cd8:ef02 with SMTP id u1-20020a17090add4100b002866cd8ef02mr19954578pjv.26.1702914139179;
        Mon, 18 Dec 2023 07:42:19 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:18 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 130/154] ksmbd: check iov vector index in ksmbd_conn_write()
Date: Tue, 19 Dec 2023 00:34:30 +0900
Message-Id: <20231218153454.8090-131-linkinjeon@kernel.org>
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

[ Upstream commit 73f949ea87c7d697210653501ca21efe57295327 ]

If ->iov_idx is zero, This means that the iov vector for the response
was not added during the request process. In other words, it means that
there is a problem in generating a response, So this patch return as
an error to avoid NULL pointer dereferencing problem.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 585f117bda8a..9e12738a56c6 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -197,6 +197,9 @@ int ksmbd_conn_write(struct ksmbd_work *work)
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


