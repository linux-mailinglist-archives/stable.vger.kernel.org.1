Return-Path: <stable+bounces-245916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKrSFgFoA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:48:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FB8526259
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0CBB3081CE6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3FA3E0721;
	Tue, 12 May 2026 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p8Dx9fBy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E7E3CDBDD;
	Tue, 12 May 2026 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607885; cv=none; b=uiq34Mv6G+p3QEcqcNkR+XJXXpPFdmbxlImhLit0rQnCZGYN9RqXKxdSi7sYtzbae/jkskkFXLGhWwDdH3ATTz9k0Rw93NB6jxHC+WA7327kEQEUgHo/EqB+1Id0wxouHC4Qq7RdsAOO3fui82AEl0cNgepHjxVjDFqcXcOFgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607885; c=relaxed/simple;
	bh=aXdk/m6LPw3ILPLAPJPCDZ9nF2Zm/GHcJS2oshbqEXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqIKhUrP3v4RHySvhs+6wzR2hfEJgBF2HgMvlT5pxXPinV6gCXQtPuKAleJJMGevnHEgQ/ogD7Gp+EE4oBzy1o0v0soNkTCWsSNN7W4hGW59P6rN/A6UdQNSQzxCc3Ug+xMVWuoduRWvKUI6vzaG6HmWythKCLYgWyk+I+Z7ixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p8Dx9fBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3B2C2BCB0;
	Tue, 12 May 2026 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607885;
	bh=aXdk/m6LPw3ILPLAPJPCDZ9nF2Zm/GHcJS2oshbqEXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8Dx9fBy4eMdET3zVplccFCurwDqn55KaBoLwXIYjTeV62UBdNWI5xwcILZF9S23N
	 s/qG9nPxJF+cHZxrhdbIgpKCuvBYfO8BHMJFPE/tQ9SDpRw95Is3AjtZ6L0u0uSfsT
	 oYo3u79FERBRkakcIWqWRpLYtsScKKCJC/JwaK4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 6.12 074/206] fanotify: fix false positive on permission events
Date: Tue, 12 May 2026 19:38:46 +0200
Message-ID: <20260512173934.416754288@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: D5FB8526259
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245916-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 7746e3bd4cc19b5092e00d32d676e329bfcb6900 upstream.

fsnotify_get_mark_safe() may return false for a mark on an unrelated group,
which results in bypassing the permission check.

Fix by skipping over detached marks that are not in the current group.

CC: stable@vger.kernel.org
Fixes: abc77577a669 ("fsnotify: Provide framework for dropping SRCU lock in ->handle_event")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Link: https://patch.msgid.link/20260410144950.156160-1-mszeredi@redhat.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/fsnotify.c             |    2 +-
 fs/notify/mark.c                 |   18 +++++++++++-------
 include/linux/fsnotify_backend.h |    1 +
 3 files changed, 13 insertions(+), 8 deletions(-)

--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -421,7 +421,7 @@ static struct fsnotify_mark *fsnotify_fi
 	return hlist_entry_safe(node, struct fsnotify_mark, obj_list);
 }
 
-static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
+struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
 {
 	struct hlist_node *node = NULL;
 
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -446,9 +446,6 @@ EXPORT_SYMBOL_GPL(fsnotify_put_mark);
  */
 static bool fsnotify_get_mark_safe(struct fsnotify_mark *mark)
 {
-	if (!mark)
-		return true;
-
 	if (refcount_inc_not_zero(&mark->refcnt)) {
 		spin_lock(&mark->lock);
 		if (mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) {
@@ -489,15 +486,22 @@ bool fsnotify_prepare_user_wait(struct f
 	int type;
 
 	fsnotify_foreach_iter_type(type) {
+		struct fsnotify_mark *mark = iter_info->marks[type];
+
 		/* This can fail if mark is being removed */
-		if (!fsnotify_get_mark_safe(iter_info->marks[type])) {
-			__release(&fsnotify_mark_srcu);
-			goto fail;
+		while (mark && !fsnotify_get_mark_safe(mark)) {
+			if (mark->group == iter_info->current_group) {
+				__release(&fsnotify_mark_srcu);
+				goto fail;
+			}
+			/* This is a mark in an unrelated group, skip */
+			mark = fsnotify_next_mark(mark);
+			iter_info->marks[type] = mark;
 		}
 	}
 
 	/*
-	 * Now that both marks are pinned by refcount in the inode / vfsmount
+	 * Now that all marks are pinned by refcount in the inode / vfsmount / etc
 	 * lists, we can drop SRCU lock, and safely resume the list iteration
 	 * once userspace returns.
 	 */
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -847,6 +847,7 @@ static inline void fsnotify_clear_sb_mar
 }
 extern void fsnotify_get_mark(struct fsnotify_mark *mark);
 extern void fsnotify_put_mark(struct fsnotify_mark *mark);
+struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
 



