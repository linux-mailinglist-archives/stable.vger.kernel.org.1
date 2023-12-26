Return-Path: <stable+bounces-8582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12781E701
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 11:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13991F220BE
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B684E1A9;
	Tue, 26 Dec 2023 10:54:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADFF4E1A5
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b6218d102so3301118a91.0
        for <stable@vger.kernel.org>; Tue, 26 Dec 2023 02:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703588063; x=1704192863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTrI2LjaUmQpkhFvm46MUGMAd34wpXMPUGLlvRFc5Cs=;
        b=q15IEaP9+mIzYiuNCJPnEkSe0kCtCvZv9bos8BVHxmUqEXrun3DzBDRm5Y78Wah/ai
         TvW4vk1XLjYf+hLUnsQ8mBpFIGg/sJvWmTpunIbfN0SrwfLYiQTQUxTyWhDm1O7QiMjn
         C1LzjL0TD2ZhX+Y31tElbBqv+ffrC83SWdXimgd7bLKtCBVBENVVazLa9MhPsmi7drJO
         7hMs1VK0uu1KSCEwWcLH68ASa9MdSziYoQAPl5dIKv61CWOIOOqFLBrcQ559j1YodyRx
         Mc4HmTM5n3di8twwS20xAhsQ7zMXan1zRvGK+t0vF3uRGeZqY0xsxkSxTNOD6Ek1krar
         Od7A==
X-Gm-Message-State: AOJu0YwpU0/gKD3xcAFxUeyDLjnll/fLgNlAqtM+XMZf9KOsnuHHa9Il
	fDRItBMtSR2xlJKE4JAGRWzhsHFQ7vc=
X-Google-Smtp-Source: AGHT+IG5VHUGu/etsEwtARtFVx/rEM+qkGVvqZURGjaICMcyH5z8zwsw7qOBL987AFDZQsSaMxsmHg==
X-Received: by 2002:a17:90b:e95:b0:28b:a7dc:c410 with SMTP id fv21-20020a17090b0e9500b0028ba7dcc410mr3115557pjb.17.1703588063058;
        Tue, 26 Dec 2023 02:54:23 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id sg4-20020a17090b520400b0028be1050020sm10874972pjb.29.2023.12.26.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:54:22 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 7/8] ksmbd: avoid duplicate opinfo_put() call on error of smb21_lease_break_ack()
Date: Tue, 26 Dec 2023 19:53:32 +0900
Message-Id: <20231226105333.5150-8-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226105333.5150-1-linkinjeon@kernel.org>
References: <20231226105333.5150-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 658609d9a618d8881bf549b5893c0ba8fcff4526 ]

opinfo_put() could be called twice on error of smb21_lease_break_ack().
It will cause UAF issue if opinfo is referenced on other places.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index c1dde4204366..e1c640ed7acc 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8221,6 +8221,11 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 			    le32_to_cpu(req->LeaseState));
 	}
 
+	if (ret < 0) {
+		rsp->hdr.Status = err;
+		goto err_out;
+	}
+
 	lease_state = lease->state;
 	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
@@ -8228,11 +8233,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	wake_up_interruptible_all(&opinfo->oplock_brk);
 	opinfo_put(opinfo);
 
-	if (ret < 0) {
-		rsp->hdr.Status = err;
-		goto err_out;
-	}
-
 	rsp->StructureSize = cpu_to_le16(36);
 	rsp->Reserved = 0;
 	rsp->Flags = 0;
-- 
2.25.1


