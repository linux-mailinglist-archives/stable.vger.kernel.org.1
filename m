Return-Path: <stable+bounces-227346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL6ALVksvGnXuAIAu9opvQ
	(envelope-from <stable+bounces-227346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:03:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F102CF56B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 547C5306BD45
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8F3EB7FF;
	Thu, 19 Mar 2026 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckJGezZC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1E535E951;
	Thu, 19 Mar 2026 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939104; cv=none; b=pjvPvL8tml8XRNf9SbG3DCk8OvdGLdvv3U5jKPRqUcJBBdiWgYMIx2eR/7+Moh1jKt2FXoQmn25U0AimBv3SnMI7tF7IXwhQOZ+53c0l6bd+lULknbCMJE8WsSaVjIXYr3r921BSzbSvNr7+VkmsFUlLDtt9fq41yDKQn4RHgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939104; c=relaxed/simple;
	bh=CFA0vVUo0opQ7/M33G27yH5Puc4oyBNEhadjE9jHDoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcoKEl0OgDi/tKk7YCd4m7HkNUkB79tJw2d1x1E8+nhjvPF5qNdNZz4Gk6VF6XoGDkZXRRaNX1qGC63BEFFHCuxoTAA3J0fogMTpvlgQWSHmcp7bIKDjn+7sQMnDGQIoPJhwFRzPoiQA+ScMYeKgX/mocCsrHwT4INztNlrKDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckJGezZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C0DC19424;
	Thu, 19 Mar 2026 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773939104;
	bh=CFA0vVUo0opQ7/M33G27yH5Puc4oyBNEhadjE9jHDoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckJGezZCSFWHzWTy6uQeu0Xyt1oQ0WpTekp2PKswt9nJEtxo/BU/SrmHqUvEygvl0
	 +g0/Sv6GmTGLf1U4VbKfNpIFJC0cW1vFxyY9m572urowoEzzSFvqpNvNZ2wICc/mQh
	 JNqK2ewUwHQtiNBXV+1wK8LAJKHAbllw0lzDob7H/Vu9ipKTosK5CF4mTSNW3QDy3Q
	 VzyuJqvfh08LTt4DwzYkTK1sybtJapAIpa4+fJTn5Y56YYYeGeLUAZ8oXy/ok7Q48v
	 3SoE333yOWRlD3K7PunA0sG6o7/jVj146b2ZKloqzGh0Ob55+eO0Y7NDXGfcU0V253
	 1MElnJSY/qjDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix atomic open with O_DIRECT & O_SYNC
Date: Thu, 19 Mar 2026 12:51:41 -0400
Message-ID: <20260319165141.2733759-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031706-baritone-circle-1085@gregkh>
References: <2026031706-baritone-circle-1085@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-227346-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.613];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talpey.com:email,suse.com:email]
X-Rspamd-Queue-Id: B7F102CF56B
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 4a7d2729dc99437dbb880a64c47828c0d191b308 ]

When user application requests O_DIRECT|O_SYNC along with O_CREAT on
open(2), CREATE_NO_BUFFER and CREATE_WRITE_THROUGH bits were missed in
CREATE request when performing an atomic open, thus leading to
potentially data integrity issues.

Fix this by setting those missing bits in CREATE request when
O_DIRECT|O_SYNC has been specified in cifs_do_create().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Acked-by: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
[ adapted file paths from fs/smb/client/ to fs/cifs/ ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsglob.h | 11 +++++++++++
 fs/cifs/dir.c      |  1 +
 fs/cifs/file.c     | 17 +++--------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index fab543bb0eaf1..a1a27a11dd950 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/mempool.h>
 #include <linux/workqueue.h>
+#include <linux/fcntl.h>
 #include "cifs_fs_sb.h"
 #include "cifsacl.h"
 #include <crypto/internal/hash.h>
@@ -2124,4 +2125,14 @@ static inline bool cifs_ses_exiting(struct cifs_ses *ses)
 	return ret;
 }
 
+static inline int cifs_open_create_options(unsigned int oflags, int opts)
+{
+	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
+	if (oflags & O_SYNC)
+		opts |= CREATE_WRITE_THROUGH;
+	if (oflags & O_DIRECT)
+		opts |= CREATE_NO_BUFFER;
+	return opts;
+}
+
 #endif	/* _CIFS_GLOB_H */
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 0d7238cb45b56..73d43d8911aa5 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -348,6 +348,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 		goto out;
 	}
 
+	create_options |= cifs_open_create_options(oflags, create_options);
 	/*
 	 * if we're not using unix extensions, see if we need to set
 	 * ATTR_READONLY on the create call
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index a56738244f3a9..0191ae0ff8c13 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -216,19 +216,13 @@ cifs_nt_open(char *full_path, struct inode *inode, struct cifs_sb_info *cifs_sb,
  *********************************************************************/
 
 	disposition = cifs_get_disposition(f_flags);
-
 	/* BB pass O_SYNC flag through on file attributes .. BB */
 
 	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
-	if (f_flags & O_SYNC)
-		create_options |= CREATE_WRITE_THROUGH;
-
-	if (f_flags & O_DIRECT)
-		create_options |= CREATE_NO_BUFFER;
+	create_options |= cifs_open_create_options(f_flags, create_options);
 
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
@@ -750,13 +744,8 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	}
 
 	desired_access = cifs_convert_flags(cfile->f_flags);
-
-	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
-	if (cfile->f_flags & O_SYNC)
-		create_options |= CREATE_WRITE_THROUGH;
-
-	if (cfile->f_flags & O_DIRECT)
-		create_options |= CREATE_NO_BUFFER;
+	create_options |= cifs_open_create_options(cfile->f_flags,
+						   create_options);
 
 	if (server->ops->get_lease_key)
 		server->ops->get_lease_key(inode, &cfile->fid);
-- 
2.51.0


