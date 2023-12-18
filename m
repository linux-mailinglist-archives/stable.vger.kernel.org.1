Return-Path: <stable+bounces-7676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E34E8175B9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A9FB245C1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7943D545;
	Mon, 18 Dec 2023 15:37:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3F42390
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28b9e9e83b0so422403a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913876; x=1703518676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEKbm5US4QGKUmp9wshF8mmQHXubIiV+28NxVLsNjGA=;
        b=U9aac5EPnAGehYcYeCUIY0PAY67kMPM7b7VCQ41XiXQrvYMp4EOTmerzb9lHCWwA7Q
         AdmgKtV0UJCCW1tce1TXWsn28Mq512ofpXHUr2N01zObVxtTDYo96xjhaXQ7g86pgQD/
         Iw1UUhb1ZBdynwFd7Gn+9RHsC0HfQpv7abZnS3HW+eiJHj9ugzwowjc1oZI/TLS16yRG
         oCBuZ9IjijzQ5DgBiTrp6x2Lf89nO8WfQkUgxWJCtPGlXXOwEGBDGsKVR0Q5t+5ErM0F
         knhI2SsUYK4TrLqi2AUWe6O7GM1RxEbFmYfZtahSXI12MPkSIq1y0EGkWfG4txqopB8z
         rPEg==
X-Gm-Message-State: AOJu0Yype+D+RYkA7lME82GK2uMN1YVIUUCZ9X39ZZd+Gw5uPu3qhEfi
	ivoI5Q41cDAJwW55jIJjEN58UQkLZ5A=
X-Google-Smtp-Source: AGHT+IE6/UeYKj91jdTzNNJmxbjJyZ2YmjBj3PvDFFCs7Q9PclWOMyF/t0TEkSVB6/8NssGYz0NDDw==
X-Received: by 2002:a17:90a:6886:b0:28b:9d25:e6eb with SMTP id a6-20020a17090a688600b0028b9d25e6ebmr528401pjd.16.1702913876248;
        Mon, 18 Dec 2023 07:37:56 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:55 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 047/154] ksmbd: remove unnecessary generic_fillattr in smb2_open
Date: Tue, 19 Dec 2023 00:33:07 +0900
Message-Id: <20231218153454.8090-48-linkinjeon@kernel.org>
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

[ Upstream commit c90b31eaf9e77269d3803ed9223a2e0168b519ac ]

Remove unnecessary generic_fillattr to fix wrong
AllocationSize of SMB2_CREATE response, And
Move the call of ksmbd_vfs_getattr above the place
where stat is needed because of truncate.

This patch fixes wrong AllocationSize of SMB2_CREATE
response. Because ext4 updates inode->i_blocks only
when disk space is allocated, generic_fillattr does
not set stat.blocks properly for delayed allocation.
But ext4 returns the blocks that include the delayed
allocation blocks when getattr is called.

The issue can be reproduced with commands below:

touch ${FILENAME}
xfs_io -c "pwrite -S 0xAB 0 40k" ${FILENAME}
xfs_io -c "stat" ${FILENAME}

40KB are written, but the count of blocks is 8.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d87a051da11c..f74f2ffa0f07 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3095,12 +3095,6 @@ int smb2_open(struct ksmbd_work *work)
 	list_add(&fp->node, &fp->f_ci->m_fp_list);
 	write_unlock(&fp->f_ci->m_lock);
 
-	rc = ksmbd_vfs_getattr(&path, &stat);
-	if (rc) {
-		generic_fillattr(user_ns, d_inode(path.dentry), &stat);
-		rc = 0;
-	}
-
 	/* Check delete pending among previous fp before oplock break */
 	if (ksmbd_inode_pending_delete(fp)) {
 		rc = -EBUSY;
@@ -3187,6 +3181,10 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
+	rc = ksmbd_vfs_getattr(&path, &stat);
+	if (rc)
+		goto err_out;
+
 	if (stat.result_mask & STATX_BTIME)
 		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
 	else
@@ -3202,9 +3200,6 @@ int smb2_open(struct ksmbd_work *work)
 
 	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 
-	generic_fillattr(user_ns, file_inode(fp->filp),
-			 &stat);
-
 	rsp->StructureSize = cpu_to_le16(89);
 	rcu_read_lock();
 	opinfo = rcu_dereference(fp->f_opinfo);
-- 
2.25.1


