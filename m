Return-Path: <stable+bounces-7747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6903D817614
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAFE1C251BE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21F6740B5;
	Mon, 18 Dec 2023 15:41:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C9498A8
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b0c586c51so1361770a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914101; x=1703518901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BG/z57vMaU/d6rH0hgQXONAJmtwIQQU/RuYV5cUBexQ=;
        b=vLa1vd3nnS91LbtcSqwMJe0skrJxDKyLTN0y3ZidFwr0tghUvXLymRRBQcGYk8k5YV
         xlHnLTU4NAzI2E2aGNnJfkuzVRKR7kfd3VxoERe+/TFbd5KxgfkZ/jryCnpbixkRnrCY
         YeqWA68+7SxFVyXf9A+FjHfV+1Ds5xLZ53jKhyMmdeZgMURziK8Fsj/ssmyEmbL/UFpq
         ETA3HkkJNQ0NLaLC72j/9PCEf4+6fQ7FIG84hGOQwdviDc/lYzqES4O1OVpNcFzm6PST
         T4WT+KcQa/HpyVL46s5NyNWAURIC/v2lbGXc2gQAsqx/T09X8fedLI/u9rsrevciXblA
         4HHQ==
X-Gm-Message-State: AOJu0Yz7aIxyV7SVXgomMA5c9MblEDlNcWdp+A0a6tohEcckqtfK0+Ar
	wjxqj6v6B+OU7o+yvD/XQeI=
X-Google-Smtp-Source: AGHT+IFwvxNO145M6s7QVGxeNFUTg7IS1juQWqL89HNxFe+KGlxvSWYCprKY7SzL5ZbVKlAFeTH/Hw==
X-Received: by 2002:a17:90b:ed8:b0:28b:4d3c:211b with SMTP id gz24-20020a17090b0ed800b0028b4d3c211bmr914728pjb.54.1702914100761;
        Mon, 18 Dec 2023 07:41:40 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:40 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Yang Yingliang <yangyingliang@huawei.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 118/154] ksmbd: switch to use kmemdup_nul() helper
Date: Tue, 19 Dec 2023 00:34:18 +0900
Message-Id: <20231218153454.8090-119-linkinjeon@kernel.org>
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

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 084ba46fc41c21ba827fd92e61f78def7a6e52ea ]

Use kmemdup_nul() helper instead of open-coding to
simplify the code.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/asn1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ksmbd/asn1.c b/fs/ksmbd/asn1.c
index cc6384f79675..4a4b2b03ff33 100644
--- a/fs/ksmbd/asn1.c
+++ b/fs/ksmbd/asn1.c
@@ -214,12 +214,10 @@ static int ksmbd_neg_token_alloc(void *context, size_t hdrlen,
 {
 	struct ksmbd_conn *conn = context;
 
-	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
+	conn->mechToken = kmemdup_nul(value, vlen, GFP_KERNEL);
 	if (!conn->mechToken)
 		return -ENOMEM;
 
-	memcpy(conn->mechToken, value, vlen);
-	conn->mechToken[vlen] = '\0';
 	return 0;
 }
 
-- 
2.25.1


