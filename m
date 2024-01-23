Return-Path: <stable+bounces-15512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F583838DAE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCD428A7F8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A730C5A114;
	Tue, 23 Jan 2024 11:42:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379804BAA8
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010168; cv=none; b=TvyGN65dhOUx20SkkgfckF0Vws7In4duqw3yy9TmSbUUkFIfTZy0O2iLaZfXKu8dEAW/4vXA14r15PN7F2sJktk+VtEJPdRSFG6VR19aCY0DZdFljO09Gc2EFvvWwmaI+0w6c3hGBPhFsCv9F/IswBJTAjjd0QroD4yGF+XGtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010168; c=relaxed/simple;
	bh=kDW7JireNgri9aQvdyFgbVR3ZkRN7UCxsa7pM1nNIkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGpgHmYhKOVaKiWU4OCq9hEVPgcq7HviqvZx/fAuu/NnGKI2My1alSm5kqsQ83wql+59AblVeb5XBt0UKdOaxi2b8JXsexm0uCeWGOBRcgTp3/5KMYomuUvHz6qMC3CO5BfOrTERCIaF6ENzvGrMF6TcsFoGgZEwpLgii2925Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bdca4f495cso71138b6e.3
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010166; x=1706614966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhfMhX9ZGuXBzS/Emfol+GSivOyEklHbON1jC9W8mxQ=;
        b=GnwA+T39H2/f8pCPA7UwPZP+iT4yKeeqt3cNl9P6GHsW3R5j/bKdPLXX4GMiu+ZC8+
         pUKg98VDnbcL5ZkWKwrvDHhMiTclRXU/CZ/tUva0FjOEW86aVPWFckzm0UOwADCDDvOx
         N8D6rpiahvD5qUJjWKkOA4ujkU4gQDsYoV8i9C8CVWQKi8NMwDSKU0wf7vEizk5FxY9E
         q7LFGR/9DfmcRuLOIYmNTETXDU16yVLSbwccNWSi2RgHKo2SD2t9U+p5mXlFnUHY5JzG
         /OGPsnzIyrYCC17V/wkDEY+lOE0ZURjfXNLwLiVmKKkSGevVm/Czm2LLLHBSIZ6MCT7G
         3V4Q==
X-Gm-Message-State: AOJu0YyuMg48uBEf3GokUGawf+VlzUoSk1ZL4AVOz1LfNSZULvG3A4rR
	Bsr4hoEY4DfJtImc7DsE2t4J37Jx40COlsjF1HhACleUCsrc5fEs
X-Google-Smtp-Source: AGHT+IFZ+ifT0W9lBN7B1tlY1En9U7VrYTt4N0KfXQRTSWwQeTFr7qw5UXLnwJ8/O794VSZW6x0IsQ==
X-Received: by 2002:a05:6808:3014:b0:3bd:9811:2dee with SMTP id ay20-20020a056808301400b003bd98112deemr3625472oib.92.1706010166262;
        Tue, 23 Jan 2024 03:42:46 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id c20-20020aa781d4000000b006d9a6a9992dsm11405182pfn.123.2024.01.23.03.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:42:45 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.7.y 2/5] ksmbd: fix potential circular locking issue in smb2_set_ea()
Date: Tue, 23 Jan 2024 20:42:25 +0900
Message-Id: <20240123114228.205260-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123114228.205260-1-linkinjeon@kernel.org>
References: <20240123114228.205260-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 6fc0a265e1b932e5e97a038f99e29400a93baad0 ]

smb2_set_ea() can be called in parent inode lock range.
So add get_write argument to smb2_set_ea() not to call nested
mnt_want_write().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 948665f8370f..b67b2a7c1a43 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2323,11 +2323,12 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
  * @eabuf:	set info command buffer
  * @buf_len:	set info command buffer length
  * @path:	dentry path for get ea
+ * @get_write:	get write access to a mount
  *
  * Return:	0 on success, otherwise error
  */
 static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
-		       const struct path *path)
+		       const struct path *path, bool get_write)
 {
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	char *attr_name = NULL, *value;
@@ -3015,7 +3016,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = smb2_set_ea(&ea_buf->ea,
 					 le32_to_cpu(ea_buf->ccontext.DataLength),
-					 &path);
+					 &path, false);
 			if (rc == -EOPNOTSUPP)
 				rc = 0;
 			else if (rc)
@@ -5992,7 +5993,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
-				   buf_len, &fp->filp->f_path);
+				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
 	{
-- 
2.25.1


