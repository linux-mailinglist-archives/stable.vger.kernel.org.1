Return-Path: <stable+bounces-7753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE181761C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46ECD2835FA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EDA740AB;
	Mon, 18 Dec 2023 15:42:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA93498B4
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b436f6cb9so2349352a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914120; x=1703518920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DROtMtoV7QXL2xe81VSd6z/ePD8kvXXCqOuAt2W7cmY=;
        b=qXxhJjN/ICfqwBFbjJKV+wUTwMkv4vQQX65q2mwJiszpXsfxhKcem2Gn3F0QAkIWLn
         8pYEUAIjgtIIccQVg99qS5WMk238NwyZTl8yhZSbnodi9vcDR+FRrQ/trVdzeF4BdZrY
         Dm7xBmIM+BudJ2GvO3k52Ofjjctho4B8BxU6mDh4EVACfT+rVgoG85fXm6dEIZZ4zLej
         MECg1n/jfXwXKtlfpC+0jIVws2KggMWOo6rn5Y7kkFbWaCJzzihLSlI9qRFyMQ6PVB/2
         nKvtQwxM46qFC+MbczvBJZaZLSOONhuX0My5PbNLWegQIvq/3Zdyr8NFURKxAMhC2WhH
         oAtw==
X-Gm-Message-State: AOJu0Yz+eKQYyOVLMbcrTkpgzW/C7DhF8wTIygwhKYIAeCM+tIIFjENn
	FU4+2MDKAK+uh9cjdn8uPbI=
X-Google-Smtp-Source: AGHT+IFhz8G+T1pPrNxayPMtbnrP4cU0PxXPejLVgHu0II61q7JgfEwMAwEER4GxuC9fdUhhRnBsUQ==
X-Received: by 2002:a17:90a:2c0f:b0:28b:44a7:48d with SMTP id m15-20020a17090a2c0f00b0028b44a7048dmr1824804pjd.56.1702914120111;
        Mon, 18 Dec 2023 07:42:00 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:59 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 124/154] ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()
Date: Tue, 19 Dec 2023 00:34:24 +0900
Message-Id: <20231218153454.8090-125-linkinjeon@kernel.org>
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

[ Upstream commit 4b081ce0d830b684fdf967abc3696d1261387254 ]

If authblob->SessionKey.Length is bigger than session key
size(CIFS_KEY_SIZE), slub overflow can happen in key exchange codes.
cifs_arc4_crypt copy to session key array from SessionKey from client.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21940
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/auth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index ee912d24ad94..9a08e6a90b94 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -355,6 +355,9 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 		if (blob_len < (u64)sess_key_off + sess_key_len)
 			return -EINVAL;
 
+		if (sess_key_len > CIFS_KEY_SIZE)
+			return -EINVAL;
+
 		ctx_arc4 = kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
 		if (!ctx_arc4)
 			return -ENOMEM;
-- 
2.25.1


