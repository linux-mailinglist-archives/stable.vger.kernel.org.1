Return-Path: <stable+bounces-7672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9088175B3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3961C24D94
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2294FF7F;
	Mon, 18 Dec 2023 15:37:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D34FF8F
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28b400f08a4so2104604a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913861; x=1703518661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLKnrQRXc5yPlfGcLCQkrkgV4pkt/aWpnz6dlSDTTgE=;
        b=uldqzVa0pNMsB7Ajreb9Y+4gS0ZXsXiJCN3uaKtSofwwoau0QVh8uWvoP9NPmybVe+
         BDVqJ936MfngMRgIV3FinbKHHKqKZEFFYlT0YsFMYpwo7hfjNX8Z12bsajt7y6JxZF/l
         ona3D6f17IY4XbggTYAv023/nlANDpIjgQ7Vt+iRWMhqElnr9GsPLrfmvq9Vv9iPZtCa
         +ol+HwLphWxwBIsckSKzhRZ5uDGNlGk1rlJd18KYJOfyj0zvMvLOmtOm+n9c+XDfvf0L
         7R/5MiwlUz7jSEZELWP8/gkG197Pxq0g+XWgtkPKRHZWXJ95MYPkKPbb2uqCnTlj6m0G
         r/ig==
X-Gm-Message-State: AOJu0YyIIp/DsOOefnYp6BuZklrjK/cdQdPFE60QVfv4V7SR2ueAd66S
	jgzBB86ywFLNNY2KDKhEfTzUvdu2h3E=
X-Google-Smtp-Source: AGHT+IHWdr9hQ5ZK4c6dL6hiMWoZiHe2wEQ+eOMlUF4dDf8skc0fCiY8eOCSr3EFPjOHshb8VLa4OA==
X-Received: by 2002:a17:90b:1994:b0:28b:6808:11db with SMTP id mv20-20020a17090b199400b0028b680811dbmr1129322pjb.44.1702913860972;
        Mon, 18 Dec 2023 07:37:40 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:40 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 043/154] ksmbd: remove duplicate flag set in smb2_write
Date: Tue, 19 Dec 2023 00:33:03 +0900
Message-Id: <20231218153454.8090-44-linkinjeon@kernel.org>
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

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 745bbc0995c25917dfafb645b8efb29813ef9e0b ]

The writethrough flag is set again if is_rdma_channel is false.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 85afa551b11b..1c674a7b2b39 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6564,6 +6564,7 @@ int smb2_write(struct ksmbd_work *work)
 		goto out;
 	}
 
+	ksmbd_debug(SMB, "flags %u\n", le32_to_cpu(req->Flags));
 	if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
 		writethrough = true;
 
@@ -6577,10 +6578,6 @@ int smb2_write(struct ksmbd_work *work)
 		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
 				    le16_to_cpu(req->DataOffset));
 
-		ksmbd_debug(SMB, "flags %u\n", le32_to_cpu(req->Flags));
-		if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
-			writethrough = true;
-
 		ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
 			    fp->filp->f_path.dentry, offset, length);
 		err = ksmbd_vfs_write(work, fp, data_buf, length, &offset,
-- 
2.25.1


