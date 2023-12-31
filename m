Return-Path: <stable+bounces-9059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8F820A0C
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5411F21FE3
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF217C7;
	Sun, 31 Dec 2023 07:15:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE14185D
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-204520717b3so4976789fac.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006911; x=1704611711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVgqCV5v/hBMPxIIIm9W47ug0A/1MiR8crBm9m353bg=;
        b=xKcWn9KSOrp+V/1hXzDAKkAB+g8l1HBtcnavyUuvs58kxmE6LqYa3jF5wpIONvGfsI
         +Vv+v+PalV2ON2dVH0HFTEYr1MWd6lC3cpVMEcPNyujIHxsnnYiswsfgMbgxEHntj5iK
         jUDy4bL5gSPJ83/QMpcVCiFjAhGbaG2a4r9nzX/qqrnqOoAh8OpDUSjAUSNUNXHtdte7
         rRoiHgwNAxhcfduSg1+iaCCOFANHOGqZ0bpvP51uTT/i+1joWHoaUuLrw0i4tWNlQ4JD
         usoryG+1+gtPOQaP7CDplrMzV4CU+3Dh8Carfeosuto9kQdcRoTlkLo+lrK9wAdiC9hb
         zKcQ==
X-Gm-Message-State: AOJu0YyeNAHKHssyGlFpzcxOd8kwC7w/dLq8bpBF/zhRKhJnmPI16rY7
	ad8UAjCKgOHV+FLCPQUPE5o=
X-Google-Smtp-Source: AGHT+IEpNPWKLM9y59BYTgh7MoQDRepxtXH3+vgIV7iOx2fHlphWfuOAZoUZgTYn5O+P8nzYLPWiWQ==
X-Received: by 2002:a05:6870:f151:b0:1fb:75a:6d36 with SMTP id l17-20020a056870f15100b001fb075a6d36mr17926185oac.93.1704006911240;
        Sat, 30 Dec 2023 23:15:11 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:10 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 25/73] ksmbd: use kzalloc() instead of __GFP_ZERO
Date: Sun, 31 Dec 2023 16:12:44 +0900
Message-Id: <20231231071332.31724-26-linkinjeon@kernel.org>
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

[ Upstream commit f87d4f85f43f0d4b12ef64b015478d8053e1a33e ]

Use kzalloc() instead of __GFP_ZERO.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index adc41b57b84c..62c33d3357fe 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
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


