Return-Path: <stable+bounces-12331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E699F835614
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25EF81C21584
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC2534CDE;
	Sun, 21 Jan 2024 14:31:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A114F7F
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847482; cv=none; b=bacINQ7xvOyAyTffkoeVAXalJhFrIVNmSrXlPv+4IONGvYek+AAg/twXEW8NrcE3CFv5HeZt6nGiSGTe+zUPbB8uMEzdL7r7/i8N+74lApCwtA/1I2NcaG46PHvkgz6WWt8KyInKuL/CWiOLq+5mUhBlCT0EU05/wOZ27Jvtp8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847482; c=relaxed/simple;
	bh=kEn0SKDSTUnsjgd07VthGIJgPZeyRpikmKCP0+U0mCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYHlxT2aXIzVZPbxoQNnkmpDcSWs+qlEodDYE04qRg5dfSIIptsyHD40F/Zb3EtHxqn0aGJ7YAsqlZHPEq0EsWDvd6DqfkWrFn+SLYW6Z22Q4x2g3T/4DGuPx0IavL/+zUTIL666ekmKfmOagxuibOvjeA61+MEN8ce0fVZwjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d746ce7d13so2698615ad.0
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847480; x=1706452280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fC+aKzRsyU6xxnqSVJAhcKVMPqDAnSMcfc3NT48yoMk=;
        b=MRvRCiavC/RRU06eiABN4UFQUKeNZV0A1RM9Eb9ta3d2rWvioJphpIEDQkVBL8FEjA
         t2JDNWr6SNPPO0jWdE6EQJ/q9jU0b5ESuPudFm0gcBrUAYriQXXgsJ0fz8oHG6vCc5yB
         unQzv3VDBJZpx3nL7j7Jo1GFESFK1qML50s3q+3hnMnyguCgL0PRpgjMFgqZKMlwYW9F
         YI8YTBAddnQYIWILHK+22QeBKqSt/lZW5oKZIsHhEgMWsAABNkvCHpEP2w8JkjC9QdIJ
         7rQ3Bp2oz64SKzXOv/q23eN1Aiq/0KLS0nfZBg2SC6u8uDHP+QYTCOqyGIPnjIOUS3sx
         UjDw==
X-Gm-Message-State: AOJu0YzlDJQeKTyqMazZr9c7csT8MHb5grrZEjbT1TxxXNzV4GlFu0sH
	BODvCYyWuaWSDeVNQ48szmi26yn5X16JOwqV2gUXvL+REzQdNqEi
X-Google-Smtp-Source: AGHT+IEx3ANp4FEmiRj7FMpS2cwLWsP58oeh3Wmn50fOV97K7he0D2EfOMgE11/Ex9rg6ZPaDsnYWw==
X-Received: by 2002:a17:902:dac4:b0:1d5:c554:7778 with SMTP id q4-20020a170902dac400b001d5c5547778mr3073202plx.75.1705847480504;
        Sun, 21 Jan 2024 06:31:20 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:19 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 06/11] ksmbd: send lease break notification on FILE_RENAME_INFORMATION
Date: Sun, 21 Jan 2024 23:30:33 +0900
Message-Id: <20240121143038.10589-7-linkinjeon@kernel.org>
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

[ Upstream commit 3fc74c65b367476874da5fe6f633398674b78e5a ]

Send lease break notification on FILE_RENAME_INFORMATION request.
This patch fix smb2.lease.v2_epoch2 test failure.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c  | 12 +++++++-----
 fs/ksmbd/smb2pdu.c |  1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index d798c1d8f126..5baabcb818f0 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
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
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4d6663ab3d03..795d3554abe2 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5569,6 +5569,7 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
+	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
 	kfree(new_name);
-- 
2.25.1


