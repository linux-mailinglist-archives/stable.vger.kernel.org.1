Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1770C9F9
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjEVTxs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjEVTxo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1388B5
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5663F61F1D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFDDC433D2;
        Mon, 22 May 2023 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785221;
        bh=rkpcN8xnTzapscIWZXJo0yyS7buhUyYESJCcosCGDHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFgQIUzMzkCGpjwV2EJZzczMUPYnajYLORs+hh476HVDvYd7vonV+MkFyJ8PTDSVV
         iJGsiGtKR6cCwmpilwtZq8u9d/1S049jjiC3Rcsc66Cmt2nrtCR6tJcD6QiHhjvNTK
         o+lhcsou5KrgFPe4l5ytcZEVCQzrhVhdjXRx9uz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.3 320/364] SMB3: drop reference to cfile before sending oplock break
Date:   Mon, 22 May 2023 20:10:25 +0100
Message-Id: <20230522190420.776352360@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bharath SM <bharathsm@microsoft.com>

commit 59a556aebc43dded08535fe97d94ca3f657915e4 upstream.

In cifs_oplock_break function we drop reference to a cfile at
the end of function, due to which close command goes on wire
after lease break acknowledgment even if file is already closed
by application but we had deferred the handle close.
If other client with limited file shareaccess waiting on lease
break ack proceeds operation on that file as soon as first client
sends ack, then we may encounter status sharing violation error
because of open handle.
Solution is to put reference to cfile(send close on wire if last ref)
and then send oplock acknowledgment to server.

Fixes: 9e31678fb403 ("SMB3: fix lease break timeout when multiple deferred close handles for the same file.")
Cc: stable@kernel.org
Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifsglob.h |    4 ++--
 fs/cifs/file.c     |   17 ++++++++++++-----
 fs/cifs/smb1ops.c  |    9 ++++-----
 fs/cifs/smb2ops.c  |    7 +++----
 4 files changed, 21 insertions(+), 16 deletions(-)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -424,8 +424,8 @@ struct smb_version_operations {
 	/* check for STATUS_NETWORK_SESSION_EXPIRED */
 	bool (*is_session_expired)(char *);
 	/* send oplock break response */
-	int (*oplock_response)(struct cifs_tcon *, struct cifs_fid *,
-			       struct cifsInodeInfo *);
+	int (*oplock_response)(struct cifs_tcon *tcon, __u64 persistent_fid, __u64 volatile_fid,
+			__u16 net_fid, struct cifsInodeInfo *cifs_inode);
 	/* query remote filesystem */
 	int (*queryfs)(const unsigned int, struct cifs_tcon *,
 		       struct cifs_sb_info *, struct kstatfs *);
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4881,7 +4881,9 @@ void cifs_oplock_break(struct work_struc
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
 	int rc = 0;
-	bool purge_cache = false;
+	bool purge_cache = false, oplock_break_cancelled;
+	__u64 persistent_fid, volatile_fid;
+	__u16 net_fid;
 
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
@@ -4926,19 +4928,24 @@ oplock_break_ack:
 	if (!CIFS_CACHE_HANDLE(cinode) && !list_empty(&cinode->deferred_closes))
 		cifs_close_deferred_file(cinode);
 
+	persistent_fid = cfile->fid.persistent_fid;
+	volatile_fid = cfile->fid.volatile_fid;
+	net_fid = cfile->fid.netfid;
+	oplock_break_cancelled = cfile->oplock_break_cancelled;
+
+	_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 	/*
 	 * releasing stale oplock after recent reconnect of smb session using
 	 * a now incorrect file handle is not a data integrity issue but do
 	 * not bother sending an oplock release if session to server still is
 	 * disconnected since oplock already released by the server
 	 */
-	if (!cfile->oplock_break_cancelled) {
-		rc = tcon->ses->server->ops->oplock_response(tcon, &cfile->fid,
-							     cinode);
+	if (!oplock_break_cancelled) {
+		rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
+				volatile_fid, net_fid, cinode);
 		cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
 	}
 
-	_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 	cifs_done_oplock_break(cinode);
 }
 
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -897,12 +897,11 @@ cifs_close_dir(const unsigned int xid, s
 }
 
 static int
-cifs_oplock_response(struct cifs_tcon *tcon, struct cifs_fid *fid,
-		     struct cifsInodeInfo *cinode)
+cifs_oplock_response(struct cifs_tcon *tcon, __u64 persistent_fid,
+		__u64 volatile_fid, __u16 net_fid, struct cifsInodeInfo *cinode)
 {
-	return CIFSSMBLock(0, tcon, fid->netfid, current->tgid, 0, 0, 0, 0,
-			   LOCKING_ANDX_OPLOCK_RELEASE, false,
-			   CIFS_CACHE_READ(cinode) ? 1 : 0);
+	return CIFSSMBLock(0, tcon, net_fid, current->tgid, 0, 0, 0, 0,
+			   LOCKING_ANDX_OPLOCK_RELEASE, false, CIFS_CACHE_READ(cinode) ? 1 : 0);
 }
 
 static int
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2383,15 +2383,14 @@ smb2_is_network_name_deleted(char *buf,
 }
 
 static int
-smb2_oplock_response(struct cifs_tcon *tcon, struct cifs_fid *fid,
-		     struct cifsInodeInfo *cinode)
+smb2_oplock_response(struct cifs_tcon *tcon, __u64 persistent_fid,
+		__u64 volatile_fid, __u16 net_fid, struct cifsInodeInfo *cinode)
 {
 	if (tcon->ses->server->capabilities & SMB2_GLOBAL_CAP_LEASING)
 		return SMB2_lease_break(0, tcon, cinode->lease_key,
 					smb2_get_lease_state(cinode));
 
-	return SMB2_oplock_break(0, tcon, fid->persistent_fid,
-				 fid->volatile_fid,
+	return SMB2_oplock_break(0, tcon, persistent_fid, volatile_fid,
 				 CIFS_CACHE_READ(cinode) ? 1 : 0);
 }
 


