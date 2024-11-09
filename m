Return-Path: <stable+bounces-91997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A89C2C5A
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096801F214C0
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B9F14D456;
	Sat,  9 Nov 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cCJKqKNU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723212F5B1
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153433; cv=none; b=MVOkx2Ua9m/w81LPOzlWjf2dTV8w9KS/BKn/K2+RsCBQ62mKwinA2rmv+Qiwg6zLgh9P0BWDfQ5Ya6wq6zNWwaIDT0KLaJTK1FcX37eHOua/s+CvQaTiI3/PDukoRn3CEoumRJXBRYBpiC6Fg6Pmmc1XYJHRGpbm1z3HhKFavj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153433; c=relaxed/simple;
	bh=Rcf8R2vZXVQWsjyYqAK+OLRAwfeTEur1rrurzMRlMJM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dC5XTSCr90IX8TfTebYKzzlnmIaDzky8/ZI279DRZV5u7tEZlUS+vNSWRY1mNkJfQhy7R3OjlASWXiH2vhk4VW9Z8ae7wfEJVG+yIt0G7jDNsCYsSd5dvzuiSAkeDDc153xLZ1Vpe76cq4FblQESLnYUxxVxUSeiKfg4qvwFBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cCJKqKNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AC1C4CECE;
	Sat,  9 Nov 2024 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731153433;
	bh=Rcf8R2vZXVQWsjyYqAK+OLRAwfeTEur1rrurzMRlMJM=;
	h=Subject:To:Cc:From:Date:From;
	b=cCJKqKNU59Rir5LH6UlSLJY3sWTUY9hjWQLGSWSy6VZiR04LRdtjXkQ4vBojj0Ybf
	 ebEczx1ziRUIQtNMZZLG8amnTKgoVk0iRBseqfwg38jrgHZjj7ta50yQQUaDBfMxLN
	 FLjqxOjA2nYkLN/XelXm7VpLnaK7n3fy1KI4g91w=
Subject: FAILED: patch "[PATCH] ksmbd: Fix the missing xa_store error check" failed to apply to 5.15-stable tree
To: ruanjinjie@huawei.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 12:56:57 +0100
Message-ID: <2024110956-unwired-hence-eb8d@gregkh>
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
git cherry-pick -x 3abab905b14f4ba756d413f37f1fb02b708eee93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110956-unwired-hence-eb8d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3abab905b14f4ba756d413f37f1fb02b708eee93 Mon Sep 17 00:00:00 2001
From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Mon, 28 Oct 2024 08:28:30 +0900
Subject: [PATCH] ksmbd: Fix the missing xa_store error check

xa_store() can fail, it return xa_err(-EINVAL) if the entry cannot
be stored in an XArray, or xa_err(-ENOMEM) if memory allocation failed,
so check error for xa_store() to fix it.

Cc: stable@vger.kernel.org
Fixes: b685757c7b08 ("ksmbd: Implements sess->rpc_handle_list as xarray")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 1e4624e9d434..9756a4bbfe54 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -90,7 +90,7 @@ static int __rpc_method(char *rpc_name)
 
 int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 {
-	struct ksmbd_session_rpc *entry;
+	struct ksmbd_session_rpc *entry, *old;
 	struct ksmbd_rpc_command *resp;
 	int method;
 
@@ -106,16 +106,19 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	entry->id = ksmbd_ipc_id_alloc();
 	if (entry->id < 0)
 		goto free_entry;
-	xa_store(&sess->rpc_handle_list, entry->id, entry, GFP_KERNEL);
+	old = xa_store(&sess->rpc_handle_list, entry->id, entry, GFP_KERNEL);
+	if (xa_is_err(old))
+		goto free_id;
 
 	resp = ksmbd_rpc_open(sess, entry->id);
 	if (!resp)
-		goto free_id;
+		goto erase_xa;
 
 	kvfree(resp);
 	return entry->id;
-free_id:
+erase_xa:
 	xa_erase(&sess->rpc_handle_list, entry->id);
+free_id:
 	ksmbd_rpc_id_free(entry->id);
 free_entry:
 	kfree(entry);


