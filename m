Return-Path: <stable+bounces-15502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D130D838D97
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706201F24C37
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0FA5D753;
	Tue, 23 Jan 2024 11:39:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E845D749
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009993; cv=none; b=lsSMHnhrta/OuIDwW+4fOU+tCNegLStffXL0pNCcHNi+YiovdePb9r/HZ3wx45vMtKFB4YOjPcpwLmVsfuBsEXKRjZP5C4kKw7XdJ62YrIjrNCb7dIO+98w9+Ulm5HEL9w3cNsBb23Khy5oR4kCYHKSS6lqYyNWZ1mtFrVC9ucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009993; c=relaxed/simple;
	bh=KzdEb8vu6H91FjURDOlO8uP0Z7M25/vUFE12vsh8Zgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxU3WBYPD+Gi8mMykbZHVv44xp1p+QIRAk5d5AkmIOj/mepo4G2mulP5UlkGraWdCRlKPMmgHAvGVJ3eGugFDkQ+epqI5JvptGZRR/9wGWb45Uq9qjVcxiLiZyFJQiTC8YzCoannaj+caLsVtOgXLIDvUGS0DJ3sLG9RzKQtVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-210dec2442eso1159544fac.2
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706009991; x=1706614791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJFY2j2hMUN7ogfBVsnz2rooaINnZaHy1fGz4PcT+dk=;
        b=IRssouWoSgFAx6C6FGLiyrvdiHVdK7TkZ+YcCnWMTBQvmTFuqQUdBjl1bokPFDKzGO
         NklLIYFE1jP9cO0PTYFkl96d0RQpiqbdlSFxuCms2CMvf5SSJK01VSHHQMKFmgD1uRW5
         TCda+SA8BuP5WWqSovobh4GLUx04l4G6rANbXp1R7b42O9NFYOfl20/7Upns+f7LXUZC
         mTffBQlbKrrsy1qBPjGdiFcc10mLGd/ePjZbLnM1yarfdbngK3Jib987N4c+fUFUjesw
         5T466sOW560gG96453leHkIB+qecIN2bdh379t62XU0rQ2JZGnrnIgklf+SeFO9+CBm2
         OIqg==
X-Gm-Message-State: AOJu0Yw+kC/rFwfHZnKqIXlGXxNg757QnY8pyZ3xHCGDfJ+trL6O5LGT
	BMZK/lz3SGyXH6ZwZNrl4uemiZb9cBYOPwuEX1AERo+wJUv7XZoY
X-Google-Smtp-Source: AGHT+IFMWZ7IeLcWNkakDidk1QND2HlOBIhTRAkZz9NQCsnxnlYO53TRckzzgxhh4h/371IYuXR5ng==
X-Received: by 2002:a05:6871:28aa:b0:206:c25:c2d8 with SMTP id bq42-20020a05687128aa00b002060c25c2d8mr1102254oac.16.1706009991393;
        Tue, 23 Jan 2024 03:39:51 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r13-20020a63d90d000000b005ce033f3b54sm10139779pgg.27.2024.01.23.03.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:39:50 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 4/5] ksmbd: send lease break notification on FILE_RENAME_INFORMATION
Date: Tue, 23 Jan 2024 20:38:53 +0900
Message-Id: <20240123113854.194887-5-linkinjeon@kernel.org>
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

[ Upstream commit 3fc74c65b367476874da5fe6f633398674b78e5a ]

Send lease break notification on FILE_RENAME_INFORMATION request.
This patch fix smb2.lease.v2_epoch2 test failure.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/oplock.c  | 12 +++++++-----
 fs/smb/server/smb2pdu.c |  1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index e577d4f97f10..1253e9bde34c 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -541,14 +541,12 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 				continue;
 			}
 
-			if (lctx->req_state != lease->state)
-				lease->epoch++;
-
 			/* upgrading lease */
 			if ((atomic_read(&ci->op_count) +
 			     atomic_read(&ci->sop_count)) == 1) {
 				if (lease->state != SMB2_LEASE_NONE_LE &&
 				    lease->state == (lctx->req_state & lease->state)) {
+					lease->epoch++;
 					lease->state |= lctx->req_state;
 					if (lctx->req_state &
 						SMB2_LEASE_WRITE_CACHING_LE)
@@ -559,13 +557,17 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 				    atomic_read(&ci->sop_count)) > 1) {
 				if (lctx->req_state ==
 				    (SMB2_LEASE_READ_CACHING_LE |
-				     SMB2_LEASE_HANDLE_CACHING_LE))
+				     SMB2_LEASE_HANDLE_CACHING_LE)) {
+					lease->epoch++;
 					lease->state = lctx->req_state;
+				}
 			}
 
 			if (lctx->req_state && lease->state ==
-			    SMB2_LEASE_NONE_LE)
+			    SMB2_LEASE_NONE_LE) {
+				lease->epoch++;
 				lease_none_upgrade(opinfo, lctx->req_state);
+			}
 		}
 		read_lock(&ci->m_lock);
 	}
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 6e2f8a2fcd72..4cfa45c2727e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5579,6 +5579,7 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
+	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
 	kfree(new_name);
-- 
2.25.1


