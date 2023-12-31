Return-Path: <stable+bounces-9107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5897820A3D
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926B82831D0
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBA117C7;
	Sun, 31 Dec 2023 07:17:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142017C2
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2044d093b3fso5161173fac.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007076; x=1704611876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3Iyl8ejX4hKoPagM3VQegi28csxLRTGfFKzLARtbto=;
        b=JRCBUCXKC51yT80nk8BvcBv1jctiA7H77f5cBtoAfeBis1sk9dmuj7zG0c8WVKAF0m
         Qkht1Ra77wQ6ZPlwuEgkZs7ggpRiMylybhykucxRaq8P24ze6zlyqlP5uRpkdPBDhIGA
         yD02UG4Hf/MGcmK5LQ18eX9N/i55iVf+BWD8HO+MJHvJ2LByvdaeV+xcYW2xcRrBX71X
         G6PGB99gOpHRBi27/MF9xjn2Ulen3tlc64nbtwTMBwOxEMOXmHdaa8KU93bKr6opJXgD
         IGEheikjvy3fMhhTKdR71VO3hu325e+IPVnOsLgajvFYvHyP1Elt/rp9hU0kvZtOtxQ2
         AjgQ==
X-Gm-Message-State: AOJu0Yw+ieew18LCJjCjn/lmYaRQRiHDMDhtG8iASG/qPaXXWxtEVKHR
	kQvsM72330+x30gXhOhuba4=
X-Google-Smtp-Source: AGHT+IGK/c/7cKiWPkoWIaFr73UcWXPsp8F8a+uf9+506q80xFuKfqBpIHppdaFvBqlxWpOlIUFX2w==
X-Received: by 2002:a05:6870:d146:b0:203:a98d:1d8c with SMTP id f6-20020a056870d14600b00203a98d1d8cmr18186757oac.52.1704007076108;
        Sat, 30 Dec 2023 23:17:56 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:55 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 73/73] ksmbd: fix wrong allocation size update in smb2_open()
Date: Sun, 31 Dec 2023 16:13:32 +0900
Message-Id: <20231231071332.31724-74-linkinjeon@kernel.org>
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

[ Upstream commit a9f106c765c12d2f58aa33431bd8ce8e9d8a404a ]

When client send SMB2_CREATE_ALLOCATION_SIZE create context, ksmbd update
old size to ->AllocationSize in smb2 create response. ksmbd_vfs_getattr()
should be called after it to get updated stat result.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c7e1f5d6eec7..d246ca35e922 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2516,7 +2516,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *
 	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 		XATTR_DOSINFO_ITIME;
 
-	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt), path, &da, false);
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt), path, &da, true);
 	if (rc)
 		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
 }
@@ -3185,23 +3185,6 @@ int smb2_open(struct ksmbd_work *work)
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
 
@@ -3302,6 +3285,23 @@ int smb2_open(struct ksmbd_work *work)
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


