Return-Path: <stable+bounces-7734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C004817607
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3D01F23E24
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80A768ED;
	Mon, 18 Dec 2023 15:41:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B373489
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28b82dc11e6so482335a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914058; x=1703518858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzeCBQCmy9vQjDvCszg+U14lQb+T/aIh3SR/wNe9RsM=;
        b=wXCZxQvtbqetKqOh+hFJHg1rs2E1OyaNYBhyhmzyBITikpEfJLCoyIEfPp/bQXOAz0
         Ux1JaezZrc/o5lvxtmS/FDxMHvQtPviTu0NgWfzo49xGAlzxtEkmCpysex9Z9kSlHu62
         DxPEsiVi+qUXCkFP/CioY6woX8vPDhqKUYVWf3PTsbE8mp60tvOoYilLQ739HqUMLkt2
         kVFBozIHqq4/XnwzNrpQw40Qgs+/MD5s8VV0jHTDx91i0bpXD8AdKtoWCSEB0xabzsxb
         GWyGLdPzCcn+diS8rCVe6CyDqhYeFDTVJouQnvHJt8vcB3kv3gAtIeo9SrT9bgPKCaMN
         oByw==
X-Gm-Message-State: AOJu0YwtAdtDJwYfIF+SBsKUYQzDzNrCla024rFwbgfiKT2y+WE6YTLl
	PeFmMcZw15XDWogYBS/morw=
X-Google-Smtp-Source: AGHT+IG6plTWjuZH7XFjDhtEqmjo7zhfbPMyjMDh173UesS6ulnrdI0QVXKG0RV4CT43/8giLzWDug==
X-Received: by 2002:a17:90a:b78d:b0:28a:d721:adef with SMTP id m13-20020a17090ab78d00b0028ad721adefmr4312837pjr.19.1702914058445;
        Mon, 18 Dec 2023 07:40:58 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:40:58 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 105/154] ksmbd: use kzalloc() instead of __GFP_ZERO
Date: Tue, 19 Dec 2023 00:34:05 +0900
Message-Id: <20231218153454.8090-106-linkinjeon@kernel.org>
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

[ Upstream commit f87d4f85f43f0d4b12ef64b015478d8053e1a33e ]

Use kzalloc() instead of __GFP_ZERO.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index d937e2f45c82..08d95e1ecc5e 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -359,8 +359,8 @@ static int smb1_check_user_session(struct ksmbd_work *work)
  */
 static int smb1_allocate_rsp_buf(struct ksmbd_work *work)
 {
-	work->response_buf = kmalloc(MAX_CIFS_SMALL_BUFFER_SIZE,
-			GFP_KERNEL | __GFP_ZERO);
+	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE,
+			GFP_KERNEL);
 	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 
 	if (!work->response_buf) {
-- 
2.25.1


