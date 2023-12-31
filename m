Return-Path: <stable+bounces-9065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42913820A12
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31DB282FBE
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB7717C2;
	Sun, 31 Dec 2023 07:15:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250D185D
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cd5cdba609so6056912a12.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006933; x=1704611733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tb1e73M3EB7t9069AyFZppnv1Km0qCbsnI148CnXgKE=;
        b=XO5jMwuTRFbrYhLWl8t1+Tq5P3hXxF0OMwJ+YwPbRicROWdFlC1ZfQJ0+WKrVs/5Fn
         K611N2rAjtLy54P6nDSXcJCc1mlJwyJikmiqp6QmA9yGTjmTMhDskEwlmJ8vhkIJv1IA
         nQfXhLowYAvOlFtqEJzFr04L5Xzo6B5Enz199i0hDen4/J8sF5BDWn/oXoDFUqClh+2d
         95v20BKmKhUye4MvKigEAo3gPeXqvCnXDF9sFkfy2gHBGHRxSSxP8WE81AB4r2Z2a+tj
         c4wOUEZcjzhLEYObZzCyzU95+KfUkMTzfHgGykvykTArtbndP8uO38hxchoKyXY1ILv4
         PPWg==
X-Gm-Message-State: AOJu0YzVXghm3ssl1/Gbe7lQiH+W8MLcV4bI8sZd0ZeyVGKM7tRH1irM
	pvcQlxMHQRGtoE5uXC8vHHembakE/5s=
X-Google-Smtp-Source: AGHT+IEb/4M5ybjwnoKqGz6QKkQkv/bzE2/kBhEwZntwdDIS8z3Rrl7Br3uggNWjWv5OXSMzhenEQw==
X-Received: by 2002:a05:6a20:2444:b0:196:ccd6:f5d9 with SMTP id t4-20020a056a20244400b00196ccd6f5d9mr1700851pzc.70.1704006933629;
        Sat, 30 Dec 2023 23:15:33 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:33 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 31/73] ksmbd: Replace one-element array with flexible-array member
Date: Sun, 31 Dec 2023 16:12:50 +0900
Message-Id: <20231231071332.31724-32-linkinjeon@kernel.org>
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

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 11d5e2061e973a8d4ff2b95a114b4b8ef8652633 ]

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct smb_negotiate_req.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/317
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index f0134d16067f..f1092519c0c2 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -200,7 +200,7 @@ struct smb_hdr {
 struct smb_negotiate_req {
 	struct smb_hdr hdr;     /* wct = 0 */
 	__le16 ByteCount;
-	unsigned char DialectsArray[1];
+	unsigned char DialectsArray[];
 } __packed;
 
 struct smb_negotiate_rsp {
-- 
2.25.1


