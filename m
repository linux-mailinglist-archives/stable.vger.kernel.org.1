Return-Path: <stable+bounces-7763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B561E817624
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DD5283557
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5B274E1E;
	Mon, 18 Dec 2023 15:42:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804374E17
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cd870422c8so444954a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914152; x=1703518952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GinJZ1liZEnl1/AJpeeUFI7Bj9YOXqHe0sBl4Lukc28=;
        b=cVeNLBvnEshV1p6EQwEBkR+6lWnD6POuwU+7eFc+C+0ID97oo+3coonVA2Og+NYW8f
         6Ne9NsOSKDo+cTLb+Oui/WQJGHzRj05t+V6lEFHPF2QHUOeHyC0CizxrmTxiiBdZ5hC2
         90cCHsQkRW25TdSUNEjkESLqNh9Pp4AkhqjP1KS0bpf53pWvQ50ohaEfv4Q3HA7y4e0m
         ZOCyMRncfa1yI6RT8U4sDLhD/WFxeW2lLr2OfJCo8xj9PFb4WsMLdb+htV+PzJWIM7/y
         zPpS1J3c3fXhy0Pmz1C4AhbHA5pGDAgO7LIkT7zrnizTpEb/p5KBkwQtthtY6jRS7VP/
         MEwg==
X-Gm-Message-State: AOJu0YwrZW8BSlbLpKLZk4gD5uCDKYYOe8VAqNizUvOWiTtwaDjvZnlN
	Z540kiD3zJMG+6apuLqFmJuXmgcN4QcITA==
X-Google-Smtp-Source: AGHT+IEuZx3DCxp5rmhCR00EBiEP7yHJzcJIa8of1oPcLDX8QykZVZGi1F4lYkLNEaKgZzt8exYqVQ==
X-Received: by 2002:a17:90a:ab0a:b0:28a:9748:d7e6 with SMTP id m10-20020a17090aab0a00b0028a9748d7e6mr6121198pjq.23.1702914152092;
        Mon, 18 Dec 2023 07:42:32 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:31 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	luosili <rootlab@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 134/154] ksmbd: fix race condition from parallel smb2 lock requests
Date: Tue, 19 Dec 2023 00:34:34 +0900
Message-Id: <20231218153454.8090-135-linkinjeon@kernel.org>
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

[ Upstream commit 75ac9a3dd65f7eab4d12b0a0f744234b5300a491 ]

There is a race condition issue between parallel smb2 lock request.

                                            Time
                                             +
Thread A                                     | Thread A
smb2_lock                                    | smb2_lock
                                             |
 insert smb_lock to lock_list                |
 spin_unlock(&work->conn->llist_lock)        |
                                             |
                                             |   spin_lock(&conn->llist_lock);
                                             |   kfree(cmp_lock);
                                             |
 // UAF!                                     |
 list_add(&smb_lock->llist, &rollback_list)  +

This patch swaps the line for adding the smb lock to the rollback list and
adding the lock list of connection to fix the race issue.

Reported-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 924b561e8c81..560d81799647 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -7040,10 +7040,6 @@ int smb2_lock(struct ksmbd_work *work)
 
 				ksmbd_debug(SMB,
 					    "would have to wait for getting lock\n");
-				spin_lock(&work->conn->llist_lock);
-				list_add_tail(&smb_lock->clist,
-					      &work->conn->lock_list);
-				spin_unlock(&work->conn->llist_lock);
 				list_add(&smb_lock->llist, &rollback_list);
 
 				argv = kmalloc(sizeof(void *), GFP_KERNEL);
@@ -7074,9 +7070,6 @@ int smb2_lock(struct ksmbd_work *work)
 
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
-					spin_lock(&work->conn->llist_lock);
-					list_del(&smb_lock->clist);
-					spin_unlock(&work->conn->llist_lock);
 					locks_free_lock(flock);
 
 					if (work->state == KSMBD_WORK_CANCELLED) {
@@ -7096,19 +7089,16 @@ int smb2_lock(struct ksmbd_work *work)
 				}
 
 				list_del(&smb_lock->llist);
-				spin_lock(&work->conn->llist_lock);
-				list_del(&smb_lock->clist);
-				spin_unlock(&work->conn->llist_lock);
 				release_async_work(work);
 				goto retry;
 			} else if (!rc) {
+				list_add(&smb_lock->llist, &rollback_list);
 				spin_lock(&work->conn->llist_lock);
 				list_add_tail(&smb_lock->clist,
 					      &work->conn->lock_list);
 				list_add_tail(&smb_lock->flist,
 					      &fp->lock_list);
 				spin_unlock(&work->conn->llist_lock);
-				list_add(&smb_lock->llist, &rollback_list);
 				ksmbd_debug(SMB, "successful in taking lock\n");
 			} else {
 				goto out;
-- 
2.25.1


