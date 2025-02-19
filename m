Return-Path: <stable+bounces-117410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 209ACA3B5B0
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904A57A255A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E72A1E0E01;
	Wed, 19 Feb 2025 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m/4f93GP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74851E0DFE;
	Wed, 19 Feb 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955193; cv=none; b=IpyDtwaLqpdOC0R7H0EKZLKcbUGIsLzgd0i3APo4pj6iOt1La8kh7Vz7+l61HnJvd1rJSWwS0EfF4A8X/oV2uWkXo7IwftFlL+x5U5Fj+RkxNUZHhRFhR2xOS/h12NavyYVWAZn2q5GgqdCsrDz0nnOf6edtKrlRpu5IBiBUN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955193; c=relaxed/simple;
	bh=JYX1tx/6kv8VNtqq6+ZAy4VMNt2wQBD3ADJ1V4eT5yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufnFEpiMTqgH9qAKc9Gv6/GqaNzmRxbAJTnF3Uf7V0flYMUpchp6SbwHa4CsClI7ZJl36NnGxuDkP4rUha/a/m6lIrxG9xRrKDnV/3CVQlBwW4MXrnAnmfFke7NzxP2aZ3ltfoIDoK+rPDYEh0A0mQvJjc3mulV872nXmMs9vMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m/4f93GP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AE4C4CEE6;
	Wed, 19 Feb 2025 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955192;
	bh=JYX1tx/6kv8VNtqq6+ZAy4VMNt2wQBD3ADJ1V4eT5yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/4f93GPoFntEwRfpUZIwiOiE2leOyqimoPW7mQzLaZzalE/iA0t3gfG17OwwDeJb
	 0xbgrLwxNE2TKvWyq/AVguVDcyj6bM8EoCrkxkbErjgIx9d/SFvCD665b+t7CSZJbx
	 dom0icsdqo0Dh7CnnrN1XyuVHBtLye8CBsvCFLco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 160/230] cifs: pick channels for individual subrequests
Date: Wed, 19 Feb 2025 09:27:57 +0100
Message-ID: <20250219082607.954441698@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

commit f1bf10d7e909fe898a112f5cae1e97ce34d6484d upstream.

The netfs library could break down a read request into
multiple subrequests. When multichannel is used, there is
potential to improve performance when each of these
subrequests pick a different channel.

Today we call cifs_pick_channel when the main read request
is initialized in cifs_init_request. This change moves this to
cifs_prepare_read, which is the right place to pick channel since
it gets called for each subrequest.

Interestingly cifs_prepare_write already does channel selection
for individual subreq, but looks like it was missed for read.
This is especially important when multichannel is used with
increased rasize.

In my test setup, with rasize set to 8MB, a sequential read
of large file was taking 11.5s without this change. With the
change, it completed in 9s. The difference is even more signigicant
with bigger rasize.

Cc: <stable@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsglob.h |    1 -
 fs/smb/client/file.c     |    7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1476,7 +1476,6 @@ struct cifs_io_parms {
 struct cifs_io_request {
 	struct netfs_io_request		rreq;
 	struct cifsFileInfo		*cfile;
-	struct TCP_Server_Info		*server;
 	pid_t				pid;
 };
 
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -147,7 +147,7 @@ static int cifs_prepare_read(struct netf
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
-	struct TCP_Server_Info *server = req->server;
+	struct TCP_Server_Info *server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
 	size_t size;
 	int rc = 0;
@@ -156,6 +156,8 @@ static int cifs_prepare_read(struct netf
 		rdata->xid = get_xid();
 		rdata->have_xid = true;
 	}
+
+	server = cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
 	rdata->server = server;
 
 	if (cifs_sb->ctx->rsize == 0)
@@ -198,7 +200,7 @@ static void cifs_issue_read(struct netfs
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
-	struct TCP_Server_Info *server = req->server;
+	struct TCP_Server_Info *server = rdata->server;
 	int rc = 0;
 
 	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
@@ -265,7 +267,6 @@ static int cifs_init_request(struct netf
 		open_file = file->private_data;
 		rreq->netfs_priv = file->private_data;
 		req->cfile = cifsFileInfo_get(open_file);
-		req->server = cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
 			req->pid = req->cfile->pid;
 	} else if (rreq->origin != NETFS_WRITEBACK) {



