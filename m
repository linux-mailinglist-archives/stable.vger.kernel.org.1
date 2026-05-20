Return-Path: <stable+bounces-252445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGNIMyUCDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-252445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:49:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3045973FF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05835396FFB4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470183F88B8;
	Wed, 20 May 2026 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="leAbChsj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589C331220;
	Wed, 20 May 2026 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300692; cv=none; b=JKckhHkF1iKso6UPtlU4llBJd2wmPbALpeoLyavf2eADTZRQRTTFj/bccqZLd+3ywgh2WnDSDNIuNnbQJvIUh88nXrl05NEhOM2Edh6B5wxB5axNHNMfFH78ayoY9+zArsYI/w4S/FvGPS0fgykoOEOgfROWkbUptZSIL1Fhn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300692; c=relaxed/simple;
	bh=8aUYuQAgaylzAjG9bjCIKsDvp8UcnrkQbv9TGy8NBpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSS7rfNIeCuwtIOEs7XI+c0m8sMWJogMALsx4sbpr8ntbKO7uXVxtd0yIcOzkL77sHE9xabFnEQwklGXCtDmU2SU6DbIU9kuHl0uPVQYj1bMhSv2nFVstmD1YIFhr1eb9KqWMULR1NAVk/sKxB6eg2T5qANSGaEZsz+nivKINNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=leAbChsj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4321F000E9;
	Wed, 20 May 2026 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300690;
	bh=p5o6bfIl+MJGw0fq1hYViBCGDUzbfGx2IgY617+x9t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=leAbChsjIXPZ0YjXfaJxAMsraV+dQC2KWKShIOBGO4ab6K7kyvdJlIhk/N0flnNMN
	 972CVswS4zVzoxeWruzQE1T26267I6PdTFqwqD5s3LjqvrYX+rpLrb6yZjuieDDZJH
	 RDo12mJcsh+HvVgnwXZMq6lYVPUC5CsVnsGikdwo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 254/666] fanotify: call fanotify_events_supported() before path_permission() and security_path_notify()
Date: Wed, 20 May 2026 18:17:45 +0200
Message-ID: <20260520162116.722454890@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252445-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,gmail.com,paul-moore.com,suse.cz,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,paul-moore.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.cz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1B3045973FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 66052a768d4726a31e939b5ac902f2b0b452c8d5 ]

The latter trigger LSM (e.g. SELinux) checks, which will log a denial
when permission is denied, so it's better to do them after validity
checks to avoid logging a denial when the operation would fail anyway.

Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc filesystem")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Paul Moore <paul@paul-moore.com>
Link: https://patch.msgid.link/20260216150625.793013-3-omosnace@redhat.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f3f957bac71b0..93c1619cdad65 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1025,6 +1025,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 
 		*path = fd_file(f)->f_path;
 		path_get(path);
+		ret = 0;
 	} else {
 		unsigned int lookup_flags = 0;
 
@@ -1034,22 +1035,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 			lookup_flags |= LOOKUP_DIRECTORY;
 
 		ret = user_path_at(dfd, filename, lookup_flags, path);
-		if (ret)
-			goto out;
-	}
-
-	/* you can only watch an inode if you have read permissions on it */
-	ret = path_permission(path, MAY_READ);
-	if (ret) {
-		path_put(path);
-		goto out;
 	}
-
-	ret = security_path_notify(path, mask, obj_type);
-	if (ret)
-		path_put(path);
-
-out:
 	return ret;
 }
 
@@ -1841,6 +1827,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			goto path_put_and_out;
 	}
 
+	/* you can only watch an inode if you have read permissions on it */
+	ret = path_permission(&path, MAY_READ);
+	if (ret)
+		goto path_put_and_out;
+
+	ret = security_path_notify(&path, mask, obj_type);
+	if (ret)
+		goto path_put_and_out;
+
 	if (fid_mode) {
 		ret = fanotify_test_fsid(path.dentry, flags, &__fsid);
 		if (ret)
-- 
2.53.0




