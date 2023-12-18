Return-Path: <stable+bounces-7766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D0C81762C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD08B21D18
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE3576093;
	Mon, 18 Dec 2023 15:42:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66FF7608A
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cd5cdba609so2698120a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914162; x=1703518962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWNSQrj6uOy5kb8DvXc3jp1II+2eGTsozNpv1ljOeKc=;
        b=H3iKtWpYE9y/zJb9W5YMjBR94kwj/nGs0IAVa1xN78Armmse5sKZKQ72+UGciZUesc
         1yi7ns2xB8F95JvXFXuIQpmBofks4pq87mkIJYG98eD13LSRZB/z3PxXWgetmsiq+VES
         Sy7HBLu3V9H5s9hRaOqpO+oU/L5P/yD17nXLTtCD3NFKbBpoB1xPP2PVIZGVCOR54ZZS
         dLAk+nUXV8VjN3OV/obTFMRowh6PdmXHeXKqlZLlikANwg76U17+PapRvmV3PpgkWPyH
         b1LA++DM6k8/nVM0JSyyrAXKllCZzBA/VpTuIisKGqNWl3Si+sGB9/B/16gQC0taaaAS
         fStg==
X-Gm-Message-State: AOJu0Yz1NskiTgT1ESXlQS1CE2Qe6MethdsY6IJTgkSi+aPvv+C++g1w
	Hd+AfnvKD38E5r8nVQUJbAk=
X-Google-Smtp-Source: AGHT+IHJ5+ZU7XTtRaeeWt/EUdgjF5b5FcxFiYbkg5jg6mRf5wfV6Dkipyv/ZSKlL0QalUEWOuZV5Q==
X-Received: by 2002:a17:90a:d310:b0:28b:af00:6e27 with SMTP id p16-20020a17090ad31000b0028baf006e27mr185326pju.72.1702914161845;
        Mon, 18 Dec 2023 07:42:41 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:41 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Coverity Scan <scan-admin@coverity.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 137/154] ksmbd: fix Null pointer dereferences in ksmbd_update_fstate()
Date: Tue, 19 Dec 2023 00:34:37 +0900
Message-Id: <20231218153454.8090-138-linkinjeon@kernel.org>
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
 fs/ksmbd/vfs_cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index f600279b0a9e..38f414e803ad 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
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


