Return-Path: <stable+bounces-263988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 38XWE19sMWrXiwUAu9opvQ
	(envelope-from <stable+bounces-263988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:31:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2B6911B2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:31:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ntPB7oGR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263988-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263988-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48EE331F7197
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F8F4418CA;
	Tue, 16 Jun 2026 15:25:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764343E486;
	Tue, 16 Jun 2026 15:25:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623543; cv=none; b=WHDP29bpyigUidCU7018i4bx0rjDQTs8/Zy80FsXDmpdoSBJ7FTYn4fuXbkEWE28S7lp1SbUCSTLyDDGY9qd1K9Bia1AC6BL+gPPBJRmm+GEJdcc1lMO9OM2PDfOLG4qyKEClQmdCVGyvHnCMc1NERxuQ+fGqMYpM5GGaHNXbuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623543; c=relaxed/simple;
	bh=6krX0OjVdnJD/4qdUcNyIrjgLskBucxEMMdqIFaThzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXZKGC546qp/ypiCJpBD15pJgcahyfLqtcJ8RCWXdhMFn8bH61fcd0rpNZbJO4qQ3FUHIpVGCBCOOHrekNiNNkU1h7wfFNk0WIBO7XQEMyXuAdXEOZG45l40wxwqOdoKFrreMp2QR+lPjF7yCZmVmZbn96UmhpFsnTG5MjvqBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ntPB7oGR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBDE1F000E9;
	Tue, 16 Jun 2026 15:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623542;
	bh=fYZYuYb/P4iXPUMEtd0nSuRjC0FTjSywXmI1QuGhNDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ntPB7oGRc1e/5UM5lOPaZ9tSWG6hsAOWW/nCLbLJAC4VaoQuZzw3HAUI8al3Ufxm8
	 TCYCf1wSUEM+g+60cwC0nvvCQUP8jFMx3Qg0gqGjqhqcGilVRpH9Ru4nYsGE1lowZn
	 Sx5eEqqYrqicU79Kd0VlGvsZbl/ERMYrFg6+PeMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	stable@kernel.org,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 7.0 168/378] namespace: restrict OPEN_TREE_NAMESPACE/FSMOUNT_NAMESPACE to directories
Date: Tue, 16 Jun 2026 20:26:39 +0530
Message-ID: <20260616145119.152117642@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263988-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:stable@kernel.org,m:jannh@google.com,m:torvalds@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83B2B6911B2

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 805d5a2b792819171be100c50c9ddafa0f8c2231 upstream.

open_tree(..., OPEN_TREE_NAMESPACE) and
fsmount(..., FSMOUNT_NAMESPACE, ...) currently work on non-directories,
like regular files. That's bad for two reasons:

 - It ends up mounting a regular file over the inherited namespace root,
   which is a directory; mounting a non-directory over a directory is
   normally explicitly forbidden, see for example do_move_mount()

 - It causes setns() on the new namespace to set the cwd to a regular
   file, which the rest of VFS does not expect

Fix it by restricting create_new_namespace() (which is used by both of
these flags) to directories.

Leave the behavior for OPEN_TREE_CLONE as-is, that seems unproblematic.

Fixes: 9b8a0ba68246 ("mount: add OPEN_TREE_NAMESPACE")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: stable@kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/namespace.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3098,6 +3098,9 @@ static struct mnt_namespace *create_new_
 	unsigned int copy_flags = 0;
 	bool locked = false;
 
+	if (unlikely(!d_can_lookup(path->dentry)))
+		return ERR_PTR(-ENOTDIR);
+
 	if (user_ns != ns->user_ns)
 		copy_flags |= CL_SLAVE;
 



