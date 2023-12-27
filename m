Return-Path: <stable+bounces-8610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACBF81EE31
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 11:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E5928381B
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8472C6AA;
	Wed, 27 Dec 2023 10:26:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDCF2C868
	for <stable@vger.kernel.org>; Wed, 27 Dec 2023 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9aef87d44so494769b3a.0
        for <stable@vger.kernel.org>; Wed, 27 Dec 2023 02:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672813; x=1704277613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzLjY6n9+lMwMD94UJiiPchtD1fkPXSgj5KyHgRdiMA=;
        b=J6f5jEZlqOeGYGj06va2mqiBiFusbbeWXs4zIgoRxctHZ6wSI6zXJZAAJDYdTsooys
         yYOiiaEkOTyU3scJfn9QUOLnBjuercukzcdLoFDL3a0hXhEt9On4VjWtLCl/OI5y5F4M
         KbUjHjKkd1sXYNExANSZanyyjrS1e7DZZVbg2dNkB8tUOfndUljyxpWtK3y2mvVsFtpP
         qU6tWp8l/UQwHKVCLhoz8AymgD5ZRGV85E0G91PZrsxxelSwXQls40co5mremBFBwSX2
         EBkr2mBr99RTqTvuzVirmZzj1+60ekHCmfv//v9i0ldyfkw7UbBOb4BHh1jU18trHoSO
         096w==
X-Gm-Message-State: AOJu0YwYG6SrL+MpjcZF6WryE4LATie+tzxqCLwZFK+EjBI4yYkAaoLx
	WRz5jXYDm52icG+eEWWJ1BY=
X-Google-Smtp-Source: AGHT+IHnRoYqAuwcqB9sMBBXiTE4uplawAYtLV8cIxqOiOSkMO/S1OjhDnOo9QQRgfEkEoni7ictHQ==
X-Received: by 2002:a05:6a00:2fd7:b0:6d9:aa82:2b03 with SMTP id fn23-20020a056a002fd700b006d9aa822b03mr1579767pfb.7.1703672813235;
        Wed, 27 Dec 2023 02:26:53 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id v21-20020a056a00149500b006d9cf4b56edsm3588419pfu.175.2023.12.27.02.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:26:52 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 5.15.y 8/8] ksmbd: fix wrong allocation size update in smb2_open()
Date: Wed, 27 Dec 2023 19:26:05 +0900
Message-Id: <20231227102605.4766-9-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227102605.4766-1-linkinjeon@kernel.org>
References: <20231227102605.4766-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit a9f106c765c12d2f58aa33431bd8ce8e9d8a404a ]

When client send SMB2_CREATE_ALLOCATION_SIZE create context, ksmbd update
old size to ->AllocationSize in smb2 create response. ksmbd_vfs_getattr()
should be called after it to get updated stat result.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index e1c640ed7acc..8875c04e8382 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2516,7 +2516,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *
 	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 		XATTR_DOSINFO_ITIME;
 
-	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt), path, &da, false);
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt), path, &da, true);
 	if (rc)
 		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
 }
@@ -3182,23 +3182,6 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out;
 	}
 
-	rc = ksmbd_vfs_getattr(&path, &stat);
-	if (rc)
-		goto err_out;
-
-	if (stat.result_mask & STATX_BTIME)
-		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
-	else
-		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
-	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
-		fp->f_ci->m_fattr =
-			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
-
-	if (!created)
-		smb2_update_xattrs(tcon, &path, fp);
-	else
-		smb2_new_xattrs(tcon, &path, fp);
-
 	if (file_present || created)
 		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 
@@ -3299,6 +3282,23 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
+	rc = ksmbd_vfs_getattr(&path, &stat);
+	if (rc)
+		goto err_out1;
+
+	if (stat.result_mask & STATX_BTIME)
+		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
+	else
+		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
+	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
+		fp->f_ci->m_fattr =
+			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
+
+	if (!created)
+		smb2_update_xattrs(tcon, &path, fp);
+	else
+		smb2_new_xattrs(tcon, &path, fp);
+
 	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 
 	rsp->StructureSize = cpu_to_le16(89);
-- 
2.25.1


