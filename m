Return-Path: <stable+bounces-7765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B2381762A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B438BB21F0B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2974E1B;
	Mon, 18 Dec 2023 15:42:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CF74E31
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c690c3d113so2619534a12.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914158; x=1703518958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZW7u1LcwjKq7HrYZ4HajLppappBf388Q4cXRqrjV7c=;
        b=c4VkalhFVwktOkxsxhQbnI1kkCRz2dQcpRQtn2UycTJV/KW3+vY2BZKg3J/BIKdAay
         Nkc/yNvkYRPovKUbzUXUoiFaBOcLpYBfbRxYBOFurEl+jBWIsb31emhG2a4qGjdH33Vs
         kO/c4oaOV9JS7cUcvCJtt/rJXW/0aPjLAABE7W328RFSocO2ffLYBorxSqGOn7BINxtL
         yZx3DNzswavGMhnGcCSdS1zJJLEo6ZOv4ZGWzdQmbjd6A8PCEQR51MtefPGZAjyJVSg6
         H2QQ0fwPuf8Y+8N2qzp3JbOGHejQat4vkA2gBxesBVeBPodNqy6eYr4JA2IDGOrhdV1T
         m0AQ==
X-Gm-Message-State: AOJu0YwR7khCZ1wE7z7GikA5beS88S8igHcqlVUf/ruLLLIcEAChRKPC
	vQyd+AS75JzZQcz/0gzE2aE=
X-Google-Smtp-Source: AGHT+IFsHjWJ+xF4TRLFGHkVZbwsWzyj8wA6j2+4/kvr8iK8yKVIrMewS8FTxb+JY7t8Z9t4LcJB3g==
X-Received: by 2002:a17:90b:3b82:b0:28b:142f:d48a with SMTP id pc2-20020a17090b3b8200b0028b142fd48amr3469813pjb.18.1702914158181;
        Mon, 18 Dec 2023 07:42:38 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:37 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 136/154] ksmbd: fix wrong error response status by using set_smb2_rsp_status()
Date: Tue, 19 Dec 2023 00:34:36 +0900
Message-Id: <20231218153454.8090-137-linkinjeon@kernel.org>
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

[ Upstream commit be0f89d4419dc5413a1cf06db3671c9949be0d52 ]

set_smb2_rsp_status() after __process_request() sets the wrong error
status. This patch resets all iov vectors and sets the error status
on clean one.

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 358ff5bf6dcc..19cee16bb3eb 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -231,11 +231,12 @@ void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err)
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


