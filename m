Return-Path: <stable+bounces-9084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0988820A25
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5378FB20C21
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2317D3;
	Sun, 31 Dec 2023 07:16:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94417C7
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so3120629a12.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006998; x=1704611798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+ovXTOypz15lb6/lEeK7fDh3tb0jPKQ50aK9+kZWHY=;
        b=SqU5mDQ6BYVNqLeTg4jQmz+LwhYhg1Q87/+jCbwyhnhqnFuKhH4X6J1mbjowX+Y4Fc
         n6V0AxlcO6IHci9BAWFTxSaXJR838bDFfz3JCzlxreZTQUg6TWVPdyZ0du9YYlVfq4Zc
         YET2FBsyqq8x/Vaf+oCGIIKT52ffCOrvJRrXxbTL4wGQ/rY7y2Tdb7oVDBSrRMEzGi7N
         UieNlDGZfS1JqGLVeLLfrsN9lGWfXg1tPJ3sqmqx62vbmHlo8vUa+uH5AmEl0BMSieAO
         FMe9qddf/NFdnAioXvfdAHYekRjzgW8YF6eZNndLf4cMAUpAp1rfhu+Yzu8B5BNC5VW0
         Ceug==
X-Gm-Message-State: AOJu0YxqDxl32XnmYKAn/KKfbDDtt2lt9ArOPDT2cWCloqzW4OHm+Md/
	TCZtqtBTmHsMc9Dh87whlds=
X-Google-Smtp-Source: AGHT+IEu3cBfJ+nqPXKx2poFfqj3rQ5MdTGqJ/GclYc5DVlQzE6oN22Qka9eIAyfR7Rirv5ZU/t46Q==
X-Received: by 2002:a05:6a20:7f86:b0:196:8da7:dbc9 with SMTP id d6-20020a056a207f8600b001968da7dbc9mr3382419pzj.33.1704006997837;
        Sat, 30 Dec 2023 23:16:37 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:37 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Coverity Scan <scan-admin@coverity.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 50/73] ksmbd: fix Null pointer dereferences in ksmbd_update_fstate()
Date: Sun, 31 Dec 2023 16:13:09 +0900
Message-Id: <20231231071332.31724-51-linkinjeon@kernel.org>
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

[ Upstream commit 414849040fcf11d45025b8ae26c9fd91da1465da ]

Coverity Scan report the following one. This report is a false alarm.
Because fp is never NULL when rc is zero. This patch add null check for fp
in ksmbd_update_fstate to make alarm silence.

*** CID 1568583:  Null pointer dereferences  (FORWARD_NULL)
/fs/smb/server/smb2pdu.c: 3408 in smb2_open()
3402                    path_put(&path);
3403                    path_put(&parent_path);
3404            }
3405            ksmbd_revert_fsids(work);
3406     err_out1:
3407            if (!rc) {
>>>     CID 1568583:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "fp" to "ksmbd_update_fstate", which dereferences it.
3408                    ksmbd_update_fstate(&work->sess->file_table, fp, FP_INITED);
3409                    rc = ksmbd_iov_pin_rsp(work, (void *)rsp, iov_len);
3410            }
3411            if (rc) {
3412                    if (rc == -EINVAL)
3413                            rsp->hdr.Status = STATUS_INVALID_PARAMETER;

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/vfs_cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index f600279b0a9e..38f414e803ad 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -602,6 +602,9 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
 			 unsigned int state)
 {
+	if (!fp)
+		return;
+
 	write_lock(&ft->lock);
 	fp->f_state = state;
 	write_unlock(&ft->lock);
-- 
2.25.1


