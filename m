Return-Path: <stable+bounces-69490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708C956717
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBC9B2267A
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02A615FA67;
	Mon, 19 Aug 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l2pxeSa+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D415F406
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059894; cv=none; b=ibEkP7Uin/tNyo07xB8H90cp9OLM2dwAf5UEbi4yFvyCFYdvU+19zqTy0tdhCtPjBJcLR/VWoq59KLQSPUTwyd8wIKmv/aY3U96NZqYj/KjTyUZrEXjW/2T6rxAjRIn7bXDUhAauc2Y3QA2hi7jYcRfYIA2aEXI3nWEmtCCymE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059894; c=relaxed/simple;
	bh=0fEJKSmKl16D9fOIFQt5SqhJvh+pjn7U7BoczK/fW2A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y25lJOT1vBAKd4Mj/iXyWo+1im/Q7bQvv0tGNUw+FljEu+HKT7MKceMgZadIiRE0X7wCAH5Nz2lZAWB0ahlNyzhyhDk4l4AENpDaSHcz8URPq92mtzw8/WYWMNoeu//CPAtz1wnR5r5NmG5F5xUu+C4M+Kp/WOMZLznbsvhCvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l2pxeSa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE47C32782;
	Mon, 19 Aug 2024 09:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724059894;
	bh=0fEJKSmKl16D9fOIFQt5SqhJvh+pjn7U7BoczK/fW2A=;
	h=Subject:To:Cc:From:Date:From;
	b=l2pxeSa+nfSZ5y7p6L5WsQNPcZSLvPIuYouj7ho2KTGzyGuuHhpdu5HvrEpJEgjp7
	 jD7joWRhafqllcvF7CT/ODfn9wopo6WTwjTuPutacK7HCApmJvCkkh2wO4i2TAPJKa
	 hRkawrbvJhQfs4I4kxWAEqPDfEbEwtL5T8ng+bxc=
Subject: FAILED: patch "[PATCH] smb/client: avoid possible NULL dereference in" failed to apply to 6.10-stable tree
To: suhui@nfschina.com,dhowells@redhat.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:31:28 +0200
Message-ID: <2024081927-sustained-humbly-8aaf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 74c2ab6d653b4c2354df65a7f7f2df1925a40a51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081927-sustained-humbly-8aaf@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

74c2ab6d653b ("smb/client: avoid possible NULL dereference in cifs_free_subrequest()")
519be989717c ("cifs: Add a tracepoint to track credits involved in R/W requests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74c2ab6d653b4c2354df65a7f7f2df1925a40a51 Mon Sep 17 00:00:00 2001
From: Su Hui <suhui@nfschina.com>
Date: Thu, 8 Aug 2024 20:23:32 +0800
Subject: [PATCH] smb/client: avoid possible NULL dereference in
 cifs_free_subrequest()

Clang static checker (scan-build) warning:
	cifsglob.h:line 890, column 3
	Access to field 'ops' results in a dereference of a null pointer.

Commit 519be989717c ("cifs: Add a tracepoint to track credits involved in
R/W requests") adds a check for 'rdata->server', and let clang throw this
warning about NULL dereference.

When 'rdata->credits.value != 0 && rdata->server == NULL' happens,
add_credits_and_wake_if() will call rdata->server->ops->add_credits().
This will cause NULL dereference problem. Add a check for 'rdata->server'
to avoid NULL dereference.

Cc: stable@vger.kernel.org
Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b2405dd4d4d4..45459af5044d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -315,7 +315,7 @@ static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
 #endif
 	}
 
-	if (rdata->credits.value != 0)
+	if (rdata->credits.value != 0) {
 		trace_smb3_rw_credits(rdata->rreq->debug_id,
 				      rdata->subreq.debug_index,
 				      rdata->credits.value,
@@ -323,8 +323,12 @@ static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
 				      rdata->server ? rdata->server->in_flight : 0,
 				      -rdata->credits.value,
 				      cifs_trace_rw_credits_free_subreq);
+		if (rdata->server)
+			add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
+		else
+			rdata->credits.value = 0;
+	}
 
-	add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
 	if (rdata->have_xid)
 		free_xid(rdata->xid);
 }


