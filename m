Return-Path: <stable+bounces-12328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E292835610
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BAF1C213C2
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5B36B08;
	Sun, 21 Jan 2024 14:31:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744E33CE6
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847472; cv=none; b=AMBiEDX7EDV5p8cF+ebxGoiRVGNyxqK84WWWtF8fsdRu4BnKzbdK2PzF5bQRqCFS2GP0tmWXQ2l94Cs4j1f9aI9fjr0ghD+amK2QDrXkAVQllHbPHaJzVahdvwnvcY3HNM9BLeB3fyBsKqltKE6xqYm5oPo1NlYuXZaabBNLp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847472; c=relaxed/simple;
	bh=yW2/mVKWlqylv9po2xWHeu0bQpimOxY9fNbbZgqEPaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLPAw+TUOBXpRSYPNjjkAP35oEoZ6bXbwGudZdL8OXl3FBS4iCkOVkkCxvn38llY4AVTydCGaEr0USOs/uOr+Ba75DoxrRrsgNbIoqWggpvCqZv1kTo1GBnqXXqFqxp0Dd1EAfwYkv5/yfvdDnU3Puiyqmswxe2g2LrTU/RT7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso1046731b3a.3
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847470; x=1706452270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUvYdJmPFPMgJVtDFnTGxvP+3Gztp8jWd8NEVzb+EXk=;
        b=qoV8ykt94tGfTkfSaspNvdcAAeSQTBclRU1WGvwZOGkbiNT2MJiL2tLar5JHlIeYc1
         ggsA2R7Cwjbz7NdtTexghBOsAMlIXu3GHZ0CkfEqiVJvj24gZvLJ8pZbxBHvhky2B9Ve
         A1JVD2rLl58hGRCwpTk6bKHrjVLuveN17jeti0UI45cDa3tiqC8NPeO6P2stlzB6Exig
         yH4ZMPfjEo4SMyn0NQNbTWeDCTzRxiO4l+cRQUlWHGfDPRXj+3LfR3XW9e6NUtZSka1h
         NkxBkQ8i/4xmU5wAfZpSpnWIjVGayEJlbjLgOfCgkchRR9SuotgwAuRQZYZzosMMlwYj
         /iLw==
X-Gm-Message-State: AOJu0YzZWsjJufX8pRtwFgBl0Tn7/undmq8kB/HL4D1u4tIy0frKCfrb
	tDPFRagmdVDYxG9LawtdFpjSeoLieedErSia2VLzZDI5zJdqInen
X-Google-Smtp-Source: AGHT+IECdCbhhugVlZt9vgaUBClAdrP1QBjFgG4zcs0Tc3r2hipqKwx6L9c4CxQOhCDH5neRQsojeQ==
X-Received: by 2002:a17:902:bc47:b0:1d7:3d4b:3dbb with SMTP id t7-20020a170902bc4700b001d73d4b3dbbmr356821plz.136.1705847469858;
        Sun, 21 Jan 2024 06:31:09 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:09 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 03/11] ksmbd: fix potential circular locking issue in smb2_set_ea()
Date: Sun, 21 Jan 2024 23:30:30 +0900
Message-Id: <20240121143038.10589-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121143038.10589-1-linkinjeon@kernel.org>
References: <20240121143038.10589-1-linkinjeon@kernel.org>
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
 fs/ksmbd/smb2pdu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 8875c04e8382..5975a2bc471f 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2311,11 +2311,12 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
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
@@ -3000,7 +3001,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = smb2_set_ea(&ea_buf->ea,
 					 le32_to_cpu(ea_buf->ccontext.DataLength),
-					 &path);
+					 &path, false);
 			if (rc == -EOPNOTSUPP)
 				rc = 0;
 			else if (rc)
@@ -5994,7 +5995,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
-				   buf_len, &fp->filp->f_path);
+				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
 	{
-- 
2.25.1


