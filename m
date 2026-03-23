Return-Path: <stable+bounces-228826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOVUCoxpwWmoSwQAu9opvQ
	(envelope-from <stable+bounces-228826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:25:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7790E2F80FE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25BD2314EA29
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5C1241695;
	Mon, 23 Mar 2026 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WzmfjNYd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1B1A5B84;
	Mon, 23 Mar 2026 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277240; cv=none; b=WzwPrig7KGsn6cwETyi86oJqlBNz+U6U9UMx0XaiQ63bK/yICThc5b2D8KfcGqdsXPG8bOzRWV1GcAij3yzNA3PjNbA7LDAHymOtLNotggFp8k9o5Ibxl7r8yWt76diWhzYaMUuCewbG2PDtxXvxL1x6Csg4IwOyLSp20OG/hzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277240; c=relaxed/simple;
	bh=KBXUMrBJkFMGJTXNsm3FuRt/2qMgCTdOgqgngnPEdBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUIzTQHDUUo3974FQcdBfjpwr6cWk6YjHZZzFVs5MaLLj1gocNJowQjlcEn04LAcXvRawmS14dHF2ULhqr+3P7hrV3Ml/NL2iKoFKy7E7mJDfndvKAEE+X6pLkGqV57wzTPWubru8Ird57il6Y7zCZqMVb4yqF9UkYQ+6CJJ3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WzmfjNYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F81C4CEF7;
	Mon, 23 Mar 2026 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277240;
	bh=KBXUMrBJkFMGJTXNsm3FuRt/2qMgCTdOgqgngnPEdBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzmfjNYdGJWDrJQd9QbhaoOkZJwh6lQScM12U4XGBjm8ti4tJ/cWDInccm/4cqDhD
	 9JRpskARBI+tAEaIieTihhN30CDeY1VK6a3hFf2YhY3QSWpOf21rS651rgTZEexdGK
	 ylUT9xLL5p2El5H1yU9aoR4FoBr4Liz3XbzkML/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 366/460] btrfs: log new dentries when logging parent dir of a conflicting inode
Date: Mon, 23 Mar 2026 14:46:02 +0100
Message-ID: <20260323134535.558042447@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228826-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,bur.io,suse.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,bur.io:email]
X-Rspamd-Queue-Id: 7790E2F80FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 9573a365ff9ff45da9222d3fe63695ce562beb24 ]

If we log the parent directory of a conflicting inode, we are not logging
the new dentries of the directory, so when we finish we have the parent
directory's inode marked as logged but we did not log its new dentries.
As a consequence if the parent directory is explicitly fsynced later and
it does not have any new changes since we logged it, the fsync is a no-op
and after a power failure the new dentries are missing.

Example scenario:

  $ mkdir foo

  $ sync

  $rmdir foo

  $ mkdir dir1
  $ mkdir dir2

  # A file with the same name and parent as the directory we just deleted
  # and was persisted in a past transaction. So the deleted directory's
  # inode is a conflicting inode of this new file's inode.
  $ touch foo

  $ ln foo dir2/link

  # The fsync on dir2 will log the parent directory (".") because the
  # conflicting inode (deleted directory) does not exists anymore, but it
  # it does not log its new dentries (dir1).
  $ xfs_io -c "fsync" dir2

  # This fsync on the parent directory is no-op, since the previous fsync
  # logged it (but without logging its new dentries).
  $ xfs_io -c "fsync" .

  <power failure>

  # After log replay dir1 is missing.

Fix this by ensuring we log new dir dentries whenever we log the parent
directory of a no longer existing conflicting inode.

A test case for fstests will follow soon.

Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/182055fa-e9ce-4089-9f5f-4b8a23e8dd91@gmail.com/
Fixes: a3baaf0d786e ("Btrfs: fix fsync after succession of renames and unlink/rmdir")
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fa1199fb6b3dd..28dcf8a8997b5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5886,6 +5886,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 				  struct btrfs_root *root,
 				  struct btrfs_log_ctx *ctx)
 {
+	const bool orig_log_new_dentries = ctx->log_new_dentries;
 	int ret = 0;
 
 	/*
@@ -5947,7 +5948,11 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			 * dir index key range logged for the directory. So we
 			 * must make sure the deletion is recorded.
 			 */
+			ctx->log_new_dentries = false;
 			ret = btrfs_log_inode(trans, inode, LOG_INODE_ALL, ctx);
+			if (!ret && ctx->log_new_dentries)
+				ret = log_new_dir_dentries(trans, inode, ctx);
+
 			btrfs_add_delayed_iput(inode);
 			if (ret)
 				break;
@@ -5982,6 +5987,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			break;
 	}
 
+	ctx->log_new_dentries = orig_log_new_dentries;
 	ctx->logging_conflict_inodes = false;
 	if (ret)
 		free_conflicting_inodes(ctx);
-- 
2.51.0




