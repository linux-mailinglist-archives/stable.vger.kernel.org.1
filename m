Return-Path: <stable+bounces-100323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64AB9EAB48
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15CF1888BBC
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13C6231C83;
	Tue, 10 Dec 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vU88cccu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DD230D38
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821532; cv=none; b=gPzSpULhBEL8Wj85DgjEjj0ThQYj1SHARrv4Qm9O/DBNOEX5nCf+GGnk3464CmB/hbn/LGsMkHPiLU7xsHZP0IhmlFN3lUT4S0QP0mUUmyxmWBhgG81OW00cwQ+pCYDTqZDmVY8l1qwdFs4BHPBvnmUxlEt7QxGVUYCEbgJEJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821532; c=relaxed/simple;
	bh=Ga7C8eLns0n1x9dwKIbxJCWgeSB3QYCYFvOk23auVEo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rOpq/ln2SmjBaD/me7uWN3zMBdutY64vYGoECUtHhABHmPE4lvjW5dq76l5/NVuoyzt0igD58mzFV94c22QsOlsL+2NLL6DRHglNXI9P0qB/OB7C7NI6ufgKYz7PBvrKW4leaqTdqqjmdUGzqbiMCWRAKHWCFKQEAY7Z9NS/shs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vU88cccu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3B9C4CED6;
	Tue, 10 Dec 2024 09:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733821532;
	bh=Ga7C8eLns0n1x9dwKIbxJCWgeSB3QYCYFvOk23auVEo=;
	h=Subject:To:Cc:From:Date:From;
	b=vU88cccupOpOczRRHNDF9xbUJV/SdErXlVZ99+/Z14Mh0vzrH0MD9DdK7QAxnBtRa
	 DI5B5VjPju6S3K/+i3NlOmsPiNkp6rTf+7fEjjQwjgj7O7zPvo13BEVqfmjizxbmGv
	 NouPe2E7skHzbLeC8+KpH7xhraW0BD7nbjPK2l7s=
Subject: FAILED: patch "[PATCH] ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read" failed to apply to 5.15-stable tree
To: jordyzomer@google.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:04:56 +0100
Message-ID: <2024121056-come-ultimatum-bead@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fc342cf86e2dc4d2edb0fc2ff5e28b6c7845adb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121056-come-ultimatum-bead@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc342cf86e2dc4d2edb0fc2ff5e28b6c7845adb9 Mon Sep 17 00:00:00 2001
From: Jordy Zomer <jordyzomer@google.com>
Date: Thu, 28 Nov 2024 09:32:45 +0900
Subject: [PATCH] ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read

An offset from client could be a negative value, It could lead
to an out-of-bounds read from the stream_buf.
Note that this issue is coming when setting
'vfs objects = streams_xattr parameter' in ksmbd.conf.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: Jordy Zomer <jordyzomer@google.com>
Signed-off-by: Jordy Zomer <jordyzomer@google.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 416f7df4edef..7b6a3952f228 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6663,6 +6663,10 @@ int smb2_read(struct ksmbd_work *work)
 	}
 
 	offset = le64_to_cpu(req->Offset);
+	if (offset < 0) {
+		err = -EINVAL;
+		goto out;
+	}
 	length = le32_to_cpu(req->Length);
 	mincount = le32_to_cpu(req->MinimumCount);
 


