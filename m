Return-Path: <stable+bounces-15500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBA3838D95
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF66289521
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D205A5D753;
	Tue, 23 Jan 2024 11:39:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB05D73B
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009986; cv=none; b=lVYeMqinPj80Bbb8u6yCuiFvfHoO3vvL5BMDjFmrGiBSzfLmG2KY8bT7pPy/OxDQXb0x/dKtZz4qYPvQtQx1C/M8jjnltICz1nh3osDA8lMSj0N1FMJLBfQTOTHMCoNNWx9FBYBb0InFpOn0QT+F6GmWuQl46KYKugN2tDGuU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009986; c=relaxed/simple;
	bh=Xcvb7sumWZC7dQS9W9UiNT5zMGeQsIvyzI2o19XbmrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SeCzLJx86MkzIMO575jOjKIrr4cVmCvIbngaEKPjFg4B0PMuGFdqbbHLZrGh70ftLRZIYNiMpSNufm8bJgmTA6vw0kDD4i/2zrGo+GDrnNrv+KvCTlaDku3rNkcwRezpxi1iU6J4yXtyZlSF9XMlq3qskw2hQ4tmI3ofw/eqFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dd7c194bb2so283483b3a.0
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706009985; x=1706614785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzS6wCzeEkjsGKjmlspMD8RMraebDbGjYFNiYgZ0t3E=;
        b=Jrnmv6GzItYGpEJKdi1Sn2k5tC/5fA3Po1u8BVxUG8URaoOv07lpbbV4iGMKbN22/e
         HEaAciBHdWeppA0IFG6D/uNXwrvAZcNLr1WqqWjA9TX8toUppFqLFUbHoUJ9WJfSS5hD
         Bz+cqk6AyhteO5QTA4z6GFHuS2zAKFB/7tZQf8xt0ijL8Dz1vyh3vrimXjQC6bBhI4cq
         PtJiLUJmw1oTDWPzsbZbNWK0rXxBTWFmu0MYVKKIi2csdO2GyDHzEskYPtAR+UH58/dN
         7D/6HL/Z5GQitH/pk82BxZX51TWgCTuQ0lZynUpHx35pujFHibjYXWGWEKZM23SEaY53
         u4Mg==
X-Gm-Message-State: AOJu0Yx3gZzgVBN+oA3VJ4xxPfgCluxcwAVwDGrlClGdSGIhZwPF08G4
	N9cAkVEYKZ5btJIGXY95DmiccqXqz+J3r+eD8AwsuQk5UecpL1Nq
X-Google-Smtp-Source: AGHT+IGv5HLmucfv7++zmrLIx6BIvfn5GbtF+tBEsKX3pO+x5nz94msGRZIVp/eusOB+7mwqybhcmw==
X-Received: by 2002:a05:6a00:21d5:b0:6db:ad3c:693f with SMTP id t21-20020a056a0021d500b006dbad3c693fmr8159218pfj.11.1706009984648;
        Tue, 23 Jan 2024 03:39:44 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r13-20020a63d90d000000b005ce033f3b54sm10139779pgg.27.2024.01.23.03.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:39:44 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 2/5] ksmbd: fix potential circular locking issue in smb2_set_ea()
Date: Tue, 23 Jan 2024 20:38:51 +0900
Message-Id: <20240123113854.194887-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123113854.194887-1-linkinjeon@kernel.org>
References: <20240123113854.194887-1-linkinjeon@kernel.org>
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
index 6826b562073e..6e2f8a2fcd72 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2321,11 +2321,12 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
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
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *attr_name = NULL, *value;
@@ -3013,7 +3014,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = smb2_set_ea(&ea_buf->ea,
 					 le32_to_cpu(ea_buf->ccontext.DataLength),
-					 &path);
+					 &path, false);
 			if (rc == -EOPNOTSUPP)
 				rc = 0;
 			else if (rc)
@@ -5990,7 +5991,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
-				   buf_len, &fp->filp->f_path);
+				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
 	{
-- 
2.25.1


