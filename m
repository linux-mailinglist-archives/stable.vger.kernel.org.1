Return-Path: <stable+bounces-7741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8B081760E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109B11F24B73
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F306A74089;
	Mon, 18 Dec 2023 15:41:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF85A860
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28ba18740d6so455479a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914080; x=1703518880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pn9KbblKJuHVhBUzCHIROYNJrDdeuokqP/jF/264TIY=;
        b=BZJtlRwBBuQkWe/79X27B3XM+QfQ2hsDLZFiqOZzZNoYyAmshFBr6t5mkCJl4dc8xo
         rta/BAQdUJJ4uw8Lur8BU5m4SzOaedpFpCBt8+pxyP+Am6m3JiDNTMQZSYKQX65m1M0b
         lkCnXnnjNUXPXgJaoSl5PNw1yIDavkv/z23CnULMMYfofA7cqUZs9SzYY2U2FTruUgSZ
         a4vDOOUnoqR2///qow3etgMSPuiLBTuz/TswV4hdEwHTZZCNUWCok9SxQwCW27vezTSV
         4j7hkvMXc7ep2meJXH2br+OG2Q0dt9QVLAAwTV8ZCWqARkCZewQVJ+EBRVja8qKUVOmx
         ptiw==
X-Gm-Message-State: AOJu0YxJBcNfbqN1J3+kVINOIRQTaUSlZmUiYFFmbu8fy/8kAGMjTA4E
	FDCbb3TnTC4QRQxRr3Fb/3U=
X-Google-Smtp-Source: AGHT+IFpvtdqsWzalUYcIPWqRXcNKwk+XHQDeJM/W6aF4VtmI+XxsQ1ZAFNhI9e8nTol3GH9TgDaDA==
X-Received: by 2002:a17:90a:d48d:b0:28b:4c7a:d8b3 with SMTP id s13-20020a17090ad48d00b0028b4c7ad8b3mr1566755pju.82.1702914080525;
        Mon, 18 Dec 2023 07:41:20 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:20 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 112/154] ksmbd: Use struct_size() helper in ksmbd_negotiate_smb_dialect()
Date: Tue, 19 Dec 2023 00:34:12 +0900
Message-Id: <20231218153454.8090-113-linkinjeon@kernel.org>
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

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 5211cc8727ed9701b04976ab47602955e5641bda ]

Prefer struct_size() over open-coded versions.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index 08d95e1ecc5e..f7c907143834 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -266,7 +266,7 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
 		if (smb2_neg_size > smb_buf_length)
 			goto err_out;
 
-		if (smb2_neg_size + le16_to_cpu(req->DialectCount) * sizeof(__le16) >
+		if (struct_size(req, Dialects, le16_to_cpu(req->DialectCount)) >
 		    smb_buf_length)
 			goto err_out;
 
-- 
2.25.1


