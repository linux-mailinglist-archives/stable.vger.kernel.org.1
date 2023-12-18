Return-Path: <stable+bounces-7698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C738175DA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5EE1C24F72
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF445D756;
	Mon, 18 Dec 2023 15:39:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2B3760AE
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28659348677so2287426a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913944; x=1703518744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL68P2Is+mGh9YbHn4fkzC4Vq9kDLB0Mu7Bv7dXB/3g=;
        b=sQMT0nIPJF4F/qiuAiGQRz5mQdIgfqpYjl8BYqhej/E/kJ7t9ZByo1qQqY3ZnSz7qN
         luwNGSFUrS7hv26OSP4s5AvdR5WFJXUFaKK7TGG6IoF9GAan85NB1Z4fWbP7cNFSAALu
         ogD/VM9mi86Vx0ifcATIR3NI8+mMsiQul9Wqh8IoXly9Hv3YAp7RVlltGRz2y87uBN4O
         cJTx1xzuCLTB7WC7e9GE/81nDAy0gVqRQVfC7SrgXfxiPDb6AdXpgiC8n57xFuaPqXMx
         bw4ko16wKkd0ufcN5zxm2xTFdzkZzrA6WEMl+/PlVwkj0AQIlaWwVGPRryJNUGDV8ulY
         T31Q==
X-Gm-Message-State: AOJu0YyyKoYuNH9W5hkHA3Ex19mlVIJHkh/cy+XWHXrhtbWuSwpKMFWj
	1TiM2LP69oj09zHcNZqoGEE=
X-Google-Smtp-Source: AGHT+IE2/1IBo1WZ0RIlunMbbei8UQTaQBDb4fE75zq+/cEHy2ZgBbceEmp+jDd0jvDVnGBnCLpcoA==
X-Received: by 2002:a17:90a:2f64:b0:28b:430d:ad20 with SMTP id s91-20020a17090a2f6400b0028b430dad20mr5010605pjd.3.1702913943896;
        Mon, 18 Dec 2023 07:39:03 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:03 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 069/154] ksmbd: send proper error response in smb2_tree_connect()
Date: Tue, 19 Dec 2023 00:33:29 +0900
Message-Id: <20231218153454.8090-70-linkinjeon@kernel.org>
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

From: Marios Makassikis <mmakassikis@freebox.fr>

[ Upstream commit cdfb2fef522d0c3f9cf293db51de88e9b3d46846 ]

Currently, smb2_tree_connect doesn't send an error response packet on
error.

This causes libsmb2 to skip the specific error code and fail with the
following:
 smb2_service failed with : Failed to parse fixed part of command
 payload. Unexpected size of Error reply. Expected 9, got 8

Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index c29c22490f8d..14619b074bc3 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1969,13 +1969,13 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	if (conn->posix_ext_supported)
 		status.tree_conn->posix_extensions = true;
 
-out_err1:
 	rsp->StructureSize = cpu_to_le16(16);
+	inc_rfc1001_len(work->response_buf, 16);
+out_err1:
 	rsp->Capabilities = 0;
 	rsp->Reserved = 0;
 	/* default manual caching */
 	rsp->ShareFlags = SMB2_SHAREFLAG_MANUAL_CACHING;
-	inc_rfc1001_len(work->response_buf, 16);
 
 	if (!IS_ERR(treename))
 		kfree(treename);
@@ -2008,6 +2008,9 @@ int smb2_tree_connect(struct ksmbd_work *work)
 		rsp->hdr.Status = STATUS_ACCESS_DENIED;
 	}
 
+	if (status.ret != KSMBD_TREE_CONN_STATUS_OK)
+		smb2_set_err_rsp(work);
+
 	return rc;
 }
 
-- 
2.25.1


