Return-Path: <stable+bounces-7630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D894F817555
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8831F24338
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D7D3D549;
	Mon, 18 Dec 2023 15:35:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B71D137
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28659348677so2283999a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913716; x=1703518516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qj8vQIjrHjzCzEKOjGQVavsX/ui0Ymilh3dPSvh0F5I=;
        b=Vzh84/rYqK5q4CGVXM8k2b1WWQPMxmSoOrIy+diU248tLI+fBRoB1PDJuqoXJkPlbK
         A5TetOQsuZNzt2yN54Qt2yXbUCDR2A+FHVY6b1q9XFLkp6BCCPprtrmpYvJ2WFIkscq6
         nxTU+O/8wpf9zJcg6ud+9TJ1RI6SPt6OzEESIWcH4r1VU22ozSaksx+6fdNlFEmPVbKM
         YKmzGWjeyDThLml4JaO6qmCKjQwuZKuANxtNsingkEmq5xjeWNzEmI6b6Jm+m9sc8D8p
         RzDbAfpob/+SOQ9BBbiSGsVDXXmXzhIMYVMpapiQCbuPefRP+tiiFpWgd6G3hFNDzTWI
         fLxQ==
X-Gm-Message-State: AOJu0YxhHkVJYkJgAbwDbxhLCDMizgK0JvRu1ihtFS+wKJKX5sibsp9v
	Q096AwyxwwUEcJ/s8KJRvNI=
X-Google-Smtp-Source: AGHT+IEBv0JXpO4Pvk/nQODSq/uBeoLxU3BZhMGOj6yBnjNlopK9G9b7uEkIVwI2CupW+wQlwkNGWA==
X-Received: by 2002:a17:90a:2c9:b0:286:b6c0:e0ea with SMTP id d9-20020a17090a02c900b00286b6c0e0eamr20017804pjd.24.1702913716039;
        Mon, 18 Dec 2023 07:35:16 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:15 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Ralph Boehme <slow@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 001/154] ksmbd: use ksmbd_req_buf_next() in ksmbd_verify_smb_message()
Date: Tue, 19 Dec 2023 00:32:21 +0900
Message-Id: <20231218153454.8090-2-linkinjeon@kernel.org>
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

From: Ralph Boehme <slow@samba.org>

[ Upstream commit a088ac859f8124d491f02a19d080fc5ee4dbd202 ]

Use ksmbd_req_buf_next() in ksmbd_verify_smb_message().

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Ralph Boehme <slow@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index af583e426621..44dbc73d0d1c 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -134,7 +134,7 @@ int ksmbd_lookup_protocol_idx(char *str)
  */
 int ksmbd_verify_smb_message(struct ksmbd_work *work)
 {
-	struct smb2_hdr *smb2_hdr = work->request_buf + work->next_smb2_rcv_hdr_off;
+	struct smb2_hdr *smb2_hdr = ksmbd_req_buf_next(work);
 	struct smb_hdr *hdr;
 
 	if (smb2_hdr->ProtocolId == SMB2_PROTO_NUMBER)
-- 
2.25.1


