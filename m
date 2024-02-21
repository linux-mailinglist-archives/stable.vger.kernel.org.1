Return-Path: <stable+bounces-22086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791885DA37
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC81B2721F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A87BAFB;
	Wed, 21 Feb 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gZhE46zk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE97BAFA;
	Wed, 21 Feb 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521977; cv=none; b=hGbpNJAfU4fNN67Zwg6xw4hrNPezBmyRTl7syDJjHZHkXY9tX2PvtFXllw8f25z1NIt8NW5A2LAVQ2tIzhXO5pshSq8368Ds3gRfw4KIXuVfLpXzduZrnb7A/6qPN1RzLr1272DEOB+yraGPjLYnbcUnlK6MDLk1JDI53vaUlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521977; c=relaxed/simple;
	bh=mHWQxkTVkyCvnIHPxB5xzTwlwsf91XnFg7TJuytVaRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kStUeEd/fpC8S9p9FyUnTdXlviE7t2HNKsRUxHUux3c+559Bv5fC+E9NlYb+WzKb2OEDIuiE8LAkCc3Sth7Mg853BCnl01WC0cdilpnVRxHIkLASoUWDmXP/hRRMKcTEMeA/0YOu0Oe6l3fy0lNZef8m00Sn8Y3O+dB4NkDyDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gZhE46zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FA3C433F1;
	Wed, 21 Feb 2024 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521977;
	bh=mHWQxkTVkyCvnIHPxB5xzTwlwsf91XnFg7TJuytVaRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZhE46zkPtyEK247y02D5KNB8UvkhqQ/I/4L8dxkN5una4JabZMNUx/Pomk4kWADW
	 6pobLHnNIVNrCfNCmZ2BSC/cDbPCEVDhRyNOedNwk/VOZgvNzN3nj1W35xNAxD2Xow
	 6zw2fa87ngZmB0x1R/HfYxRKRpe1AzQdCbvp6mTY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 043/476] ksmbd: send lease break notification on FILE_RENAME_INFORMATION
Date: Wed, 21 Feb 2024 14:01:34 +0100
Message-ID: <20240221130009.525034093@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 3fc74c65b367476874da5fe6f633398674b78e5a ]

Send lease break notification on FILE_RENAME_INFORMATION request.
This patch fix smb2.lease.v2_epoch2 test failure.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/oplock.c  |   12 +++++++-----
 fs/ksmbd/smb2pdu.c |    1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -541,14 +541,12 @@ static struct oplock_info *same_client_h
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
@@ -559,13 +557,17 @@ static struct oplock_info *same_client_h
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
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5581,6 +5581,7 @@ static int smb2_rename(struct ksmbd_work
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
+	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
 	kfree(new_name);



