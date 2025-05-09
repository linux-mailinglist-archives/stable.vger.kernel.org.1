Return-Path: <stable+bounces-143019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DEAAB0DDE
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAA43A5E0C
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560AC2741BE;
	Fri,  9 May 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yz0hOloK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A321FF23
	for <stable@vger.kernel.org>; Fri,  9 May 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780887; cv=none; b=mrTaYFRRBelBxpbVRNJRp+VybQrZUV7SOpeda3KajXwHv6tTUiAvf+5S74RIdKdQLtD0Dkmi7sIN8ziZo2K1kKB4kQJywE2naN5HP3GLbxfZKzq7i4m6BHP9pc/askOVe8loteAYeVGoNu+rlPPplWvEZc91j+iZRDWQnTBsUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780887; c=relaxed/simple;
	bh=PzjpeR5ZG+4hsXTyIArpJya3ZKxtyDewBIR3qDqHpXA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BK6j0Tf2WzqswHlqynEplReWYUVKpdVS/PGIOC21weyGO1PA6jRF6i4W4IL9zW7vcD5Zh2lLT/RZZTOLoKBw4Hnoim77TDJ96EotSqjIiYfCOonvHAuIrkuSfQEOLApTRDm2AaoBmLGVrYdUfbl5EYXei13E04BAIZKEQkoWEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yz0hOloK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6BDC4CEE4;
	Fri,  9 May 2025 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746780882;
	bh=PzjpeR5ZG+4hsXTyIArpJya3ZKxtyDewBIR3qDqHpXA=;
	h=Subject:To:Cc:From:Date:From;
	b=Yz0hOloKrJ40T7Bfp5sR58WbAZuT8x+OCnMVqmuRg1mZFvcKPDMNDwmqbtu7uSHGa
	 fYDQxc5jXOTH4ayMoZT7+Svm9dRFEyyzzpTnBBEys+KmAQNaIYLsoZ4nHSL3qb7dsQ
	 Sj/+f28E6cpaEtl1kS7qvdQf+qMdOQ07B0lwMB1E=
Subject: FAILED: patch "[PATCH] ksmbd: Fix UAF in __close_file_table_ids" failed to apply to 6.1-stable tree
To: seanheelan@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 09 May 2025 10:54:39 +0200
Message-ID: <2025050939-activism-hesitant-7576@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 36991c1ccde2d5a521577c448ffe07fcccfe104d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050939-activism-hesitant-7576@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36991c1ccde2d5a521577c448ffe07fcccfe104d Mon Sep 17 00:00:00 2001
From: Sean Heelan <seanheelan@gmail.com>
Date: Tue, 6 May 2025 22:04:52 +0900
Subject: [PATCH] ksmbd: Fix UAF in __close_file_table_ids

A use-after-free is possible if one thread destroys the file
via __ksmbd_close_fd while another thread holds a reference to
it. The existing checks on fp->refcount are not sufficient to
prevent this.

The fix takes ft->lock around the section which removes the
file from the file table. This prevents two threads acquiring the
same file pointer via __close_file_table_ids, as well as the other
functions which retrieve a file from the IDR and which already use
this same lock.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Heelan <seanheelan@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 1f8fa3468173..dfed6fce8904 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -661,21 +661,40 @@ __close_file_table_ids(struct ksmbd_file_table *ft,
 		       bool (*skip)(struct ksmbd_tree_connect *tcon,
 				    struct ksmbd_file *fp))
 {
-	unsigned int			id;
-	struct ksmbd_file		*fp;
-	int				num = 0;
+	struct ksmbd_file *fp;
+	unsigned int id = 0;
+	int num = 0;
 
-	idr_for_each_entry(ft->idr, fp, id) {
-		if (skip(tcon, fp))
+	while (1) {
+		write_lock(&ft->lock);
+		fp = idr_get_next(ft->idr, &id);
+		if (!fp) {
+			write_unlock(&ft->lock);
+			break;
+		}
+
+		if (skip(tcon, fp) ||
+		    !atomic_dec_and_test(&fp->refcount)) {
+			id++;
+			write_unlock(&ft->lock);
 			continue;
+		}
 
 		set_close_state_blocked_works(fp);
+		idr_remove(ft->idr, fp->volatile_id);
+		fp->volatile_id = KSMBD_NO_FID;
+		write_unlock(&ft->lock);
+
+		down_write(&fp->f_ci->m_lock);
+		list_del_init(&fp->node);
+		up_write(&fp->f_ci->m_lock);
 
-		if (!atomic_dec_and_test(&fp->refcount))
-			continue;
 		__ksmbd_close_fd(ft, fp);
+
 		num++;
+		id++;
 	}
+
 	return num;
 }
 


