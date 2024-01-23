Return-Path: <stable+bounces-15506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E7838DA1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645991C22811
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E75D8F8;
	Tue, 23 Jan 2024 11:40:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337095D73B
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010051; cv=none; b=YhYuPF7hL6KV+74I3Skkqy4HsBuDX5PrDnsJXpEBRHNBfKqyv/BFm+qUp6iPzL/1R1q+qGNFtV5IhpH8mMXCJfOyn+Jw4/3wVb2j95J162pGHXs+hoUEdNHLHhhQjQYuYFpKSTMdmL2zlaCkv9OkbN2Ugs7ZsL7GEHuXOsl/J2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010051; c=relaxed/simple;
	bh=0ZLTaxrMsyVZnLwZDiXk3dJAsRnlPTbpxd1Jg4In6Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=um5Z1qGaLfS6CqdlliFSl/yqvJ5ujC5XGXo6PUTV6YpHB4gF/9ikzO4fQXcerpDy5Wu8yQ8Zm5Dx/+rcKT1hNVn4lO4rQxl8uWLx4wbXQtwjmxKQVcKQTIIHD7FsFmHwNHRcFIMYW/1DJbAKcW++x7vi5UXvKcAUU5StFQUdb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e0a64d9449so2712818a34.2
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010049; x=1706614849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iLMkjD/IKsNrGLa5OjUsK9S93WOn9FspM7zQ8dq9Mk=;
        b=xLuZuiu5LrnB5xczAdCN88v28AKuwagudJUH6dC8vRSX3XVWM5XKFO2n290ewFqIDR
         1bbTWK2qKLBlSa8O+PJMLhbKXh8BOQ+jWuwOqzSri1AjLAlcgtVsnXb+Jg7IGt0G3nKM
         7Rnxw2LL0jkOVriGT1VENBhNM/B8k5KCuc10GwxD0Hk3b5VWBK3YQk38464sb4MtJEq8
         cJaQWTjDXcdxWi5UFRE+Zc7WvXqvQplvkj02DPi8swGh8CYy1jETFCaC9B15UhDxJyf1
         gfzjS38m23CGuEP2IsVO9sC8+PMKH1YzGqQweg1p5x5tM6Q67Ddq3k3mLqhqAVAdtY4u
         uImA==
X-Gm-Message-State: AOJu0YzMle3SHquBFFl85EX6LW4rv1Cn9NruAqzakV3VgKOti2VHJh1J
	vg+3J4L3H0+LY39x1I7zOrcifMVsyrs1inyJNpWw3wwY124dK/Bk
X-Google-Smtp-Source: AGHT+IEb9AlKtiVBZmMEagO2C5jlTD+miPB0iMRNBbywtG2YCU1caS8m4nolxtlYMcMXM6kXpDxaQA==
X-Received: by 2002:a9d:6296:0:b0:6dd:e1cf:221c with SMTP id x22-20020a9d6296000000b006dde1cf221cmr5612567otk.70.1706010049312;
        Tue, 23 Jan 2024 03:40:49 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id p15-20020a63c14f000000b005cfb6e7b0c7sm7543359pgi.39.2024.01.23.03.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:40:48 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 2/5] ksmbd: fix potential circular locking issue in smb2_set_ea()
Date: Tue, 23 Jan 2024 20:40:28 +0900
Message-Id: <20240123114031.199004-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123114031.199004-1-linkinjeon@kernel.org>
References: <20240123114031.199004-1-linkinjeon@kernel.org>
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
index 297ed5c5ce8d..8747fd32b25b 100644
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


