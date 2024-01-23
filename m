Return-Path: <stable+bounces-15514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A63838DB0
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661D71F238A3
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525155D8E0;
	Tue, 23 Jan 2024 11:42:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB34BAA8
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010174; cv=none; b=CI3GvRysslhPLm2O3vev3wuNKVdtRIA7uq9GkQLXOcT0fC2psVnzC5nnrytyCYKttNzk9u9OEnR5IbpqI76gbRHTs8JeslAG2oCzIKuLYeLUg7eugiCnAiowgfINoqRccvd/4VlZAMNajSvP/4RLtGquhominf+VZKg4Gr/Ieo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010174; c=relaxed/simple;
	bh=ZC3/FVbisPpd4Qcx11nvMDzzpYnB/jXPEK1h3vFdxBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRHB3lhZ7YNcLzgNqIFrcjJLhHdDgLW0DfTiXvkKrd7lDPifSN1n1e7eFAeR0SbujVn43pd4hbdUzYl/9LI7lGyRQE6XIuTVI0ug9pG1IK1W/sqb4aiDVG1spYbWaFiqpGyVzRyEefJ14xbyVgCOcqd0PN76ocpNdMLn12r/jUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bd6581bca0so2674097b6e.0
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010172; x=1706614972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMtyFA2nDxMkjBKbuvamjWbaZ529how+2RIK6j0SjnI=;
        b=TqSB9RR6bKJp0URCxLDBDGiOMfUbuPitQJ1urEGJQ85WtKQRU5oEtq346hEz4ck77e
         qp1IxkBU0WsRpYzPrDI6DIr9QGhEgyCYvAqFgAqE9oV0FM9lblub7usqOvw/aOkkFHX5
         SxTJNMZ6USEueujlSzlCG3Iir083snoNOV1aB+7k8cDTbdqoAiY6EARHSb8hhQyXX+Oz
         j6YkG7NIPON80zxuYAUyhsTKeJgoSu0wJ4yCpT9GQb/zIwRIkKcodpvXkKa28k4v9bAj
         bxrz8CfkNovqbtqoNujsbUGP0tQ1KOOVf7VwWATPNYC1AfgS9j46xioPKxVuLeSxzvE5
         w8Ow==
X-Gm-Message-State: AOJu0YwpgwmWvZWsPbv0ivllVTsAiram3AMC10eSU1njuIoCJ+TjN1tC
	yttYw+nEqdMHO/krvJ3R16IbchQ+i3T3TT5QYx1CaNasTB3bVdAK
X-Google-Smtp-Source: AGHT+IH425oIqd+8QhS1i4YhOT18r5U/zuRVwRNZufZhydrGlCm0rqxNLZWgwkQA5pWbjGc7hdYCtg==
X-Received: by 2002:a05:6808:2388:b0:3bd:bf75:d653 with SMTP id bp8-20020a056808238800b003bdbf75d653mr1869307oib.83.1706010172089;
        Tue, 23 Jan 2024 03:42:52 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id c20-20020aa781d4000000b006d9a6a9992dsm11405182pfn.123.2024.01.23.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:42:51 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.7.y 4/5] ksmbd: send lease break notification on FILE_RENAME_INFORMATION
Date: Tue, 23 Jan 2024 20:42:27 +0900
Message-Id: <20240123114228.205260-5-linkinjeon@kernel.org>
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
index 3209ace41ab4..53dfaac425c6 100644
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
index b67b2a7c1a43..ba7a72a6a4f4 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5581,6 +5581,7 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
+	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
 	kfree(new_name);
-- 
2.25.1


