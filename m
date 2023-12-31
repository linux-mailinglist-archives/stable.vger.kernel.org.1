Return-Path: <stable+bounces-9083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 618F2820A24
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81CFB20DB2
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D217C2;
	Sun, 31 Dec 2023 07:16:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A8A186C
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ba737ee9b5so592445639f.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006994; x=1704611794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCoXDOD7D9by0bZHO0yP367qI3n1VBr7KKzEK2k8+To=;
        b=DhWFt76SAAX6KrZ4HVjqvmX/5I3XTaSvSAOO1IX3TyY9Yb7aK5DnSmstzCmoSkNcxq
         6GRZCufOkJwWULD3/fNMhw9I8Gbt5d/rSTctpCDtZkKkB905xUmLcuUHpblvEh13aTjW
         ZqkzWlDV+2MCZSevHCAp34B72wYX1mEOPW4Vi4E2XFUrw0Jx4fKvnEA3WEtAzmaCsORV
         zpLM8Zd+7o4+rH19zcyDcE6IlvNAdJ/1L/oHutalHbMIslH36VVAtF7TZTvJPtyL7duS
         Fk16Bo9gil+m5iCMWMQbBhKJ2t3QHJVpI077AbpkD+W+M4sHGuZdY+UHpQ3GFp5rMBI7
         Jitw==
X-Gm-Message-State: AOJu0Yx4J7KR+HdYAl1JYFc/E4WnBjfufHc9x1oki9ze0I1R3+Yy9MeM
	OadzsW7Y1gdKUWmpLy8OpuBw/ch6Hjw=
X-Google-Smtp-Source: AGHT+IHMgDYYI13PDGIfbGNhh3SyiBILQB+/FVW5h68gY8A/BhRCNGIFi4Gl1nI/RPK1HMv/Xc97+Q==
X-Received: by 2002:a05:6e02:1888:b0:35d:5995:7990 with SMTP id o8-20020a056e02188800b0035d59957990mr23121298ilu.42.1704006994415;
        Sat, 30 Dec 2023 23:16:34 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:33 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 49/73] ksmbd: fix wrong error response status by using set_smb2_rsp_status()
Date: Sun, 31 Dec 2023 16:13:08 +0900
Message-Id: <20231231071332.31724-50-linkinjeon@kernel.org>
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

[ Upstream commit be0f89d4419dc5413a1cf06db3671c9949be0d52 ]

set_smb2_rsp_status() after __process_request() sets the wrong error
status. This patch resets all iov vectors and sets the error status
on clean one.

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 07ed0b64df0e..4f6491f4eafa 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -230,11 +230,12 @@ void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err)
 {
 	struct smb2_hdr *rsp_hdr;
 
-	if (work->next_smb2_rcv_hdr_off)
-		rsp_hdr = ksmbd_resp_buf_next(work);
-	else
-		rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	rsp_hdr->Status = err;
+
+	work->iov_idx = 0;
+	work->iov_cnt = 0;
+	work->next_smb2_rcv_hdr_off = 0;
 	smb2_set_err_rsp(work);
 }
 
-- 
2.25.1


