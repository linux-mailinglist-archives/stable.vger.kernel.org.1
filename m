Return-Path: <stable+bounces-223437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CcjM6yWrGnsqwEAu9opvQ
	(envelope-from <stable+bounces-223437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 22:20:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7632E22DAB9
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 22:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45E09301E23C
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 21:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEF730F816;
	Sat,  7 Mar 2026 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="pEODMVf/"
X-Original-To: stable@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567532F0C62;
	Sat,  7 Mar 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772918428; cv=none; b=cVO619HvpyMrL+3glaO/SUjypuct/GCX6yrQpJQFpRY3HQ25nSjPPYGhkLold/nLqedYiR+jvumezDbfNu9TD7//87kG734cvmBJMiw4REd9u8/xLLm4GQzKMVe/n/eILcUHc5VXkP7uRJGm7zr/pcEAPnIOwm1ATGHH0DIpzM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772918428; c=relaxed/simple;
	bh=aleTJJnZb+piLzDY4H5sQWWZ2Dh8buOPw+9dmwBl+n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHwZrgpCIKCFzqfJ1POGIlxEwU+uB7xRAwmjktorkLj9Hpic7g+RmtZOzd4O50koR1TjM2M2MAboGewEL3EL9Vy1porefxoMOE68/tJt3eWPWmJhV22Lno38cgTIjEFxnsG2AFUSC5bNEhw16rrEqe6+WI28SphJ3JSjqFcPfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=pEODMVf/; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Content-Type:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=M/ljSlVi3XwM4bSh7BpkRbkjLuspxi3HaY9pexHaz9Q=; b=pEODMVf/CThcqaZz70M3Fh0oih
	0adl/MUrYBTSFmlClm6lRAM7mIE25w0cs0qtluxM1uYg2FYlICbPloWykTuyhNTiUmrqUEOM+LaRf
	aDLSA2nuBqDLzRPkUAcAKNDaPjljKZ1SRegrOqPO/PbvwO3uJLJ7cs8YH4emU1A2OrOfX0ngjTl2d
	IjtoZadkyUvQp4PcrltUf4E/wQ7zepbsMgHyj3mM+S3i2xbLwoWDh3HZxYOPTUQe8VleuXt+H0NWP
	wmeJ+3ZfF0L9hH+I9bDOwyZvCStDZ4NuL3bcv3QFxRuwQZxMHh/8tgR8AeoB38tdQa94tuL0lNPOe
	yi9TaK6w==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1vyz4K-00000000S8C-2kQr;
	Sat, 07 Mar 2026 18:20:16 -0300
From: Paulo Alcantara <pc@manguebit.org>
To: smfrench@gmail.com
Cc: "Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix atomic open with O_DIRECT & O_SYNC
Date: Sat,  7 Mar 2026 18:20:16 -0300
Message-ID: <20260307212016.1328931-1-pc@manguebit.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7632E22DAB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223437-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[manguebit.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.985];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,talpey.com:email]
X-Rspamd-Action: no action

When user application requests O_DIRECT|O_SYNC along with O_CREAT on
open(2), CREATE_NO_BUFFER and CREATE_WRITE_THROUGH bits were missed in
CREATE request when performing an atomic open, thus leading to
potentially data integrity issues.

Fix this by setting those missing bits in CREATE request when
O_DIRECT|O_SYNC has been specified in cifs_do_create().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org
---
 fs/smb/client/cifsglob.h | 10 ++++++++++
 fs/smb/client/dir.c      |  1 +
 fs/smb/client/file.c     | 18 +++---------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 6f9b6c72962b..2f4470f9df58 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2375,4 +2375,14 @@ static inline bool cifs_forced_shutdown(const struct cifs_sb_info *sbi)
 	return cifs_sb_flags(sbi) & CIFS_MOUNT_SHUTDOWN;
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
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 953f1fee8cb8..4bc217e9a727 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -308,6 +308,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		goto out;
 	}
 
+	create_options |= cifs_open_create_options(oflags, create_options);
 	/*
 	 * if we're not using unix extensions, see if we need to set
 	 * ATTR_READONLY on the create call
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index cffcf82c1b69..13dda87f7711 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -584,15 +584,8 @@ static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_
  *********************************************************************/
 
 	disposition = cifs_get_disposition(f_flags);
-
 	/* BB pass O_SYNC flag through on file attributes .. BB */
-
-	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
-	if (f_flags & O_SYNC)
-		create_options |= CREATE_WRITE_THROUGH;
-
-	if (f_flags & O_DIRECT)
-		create_options |= CREATE_NO_BUFFER;
+	create_options |= cifs_open_create_options(f_flags, create_options);
 
 retry_open:
 	oparms = (struct cifs_open_parms) {
@@ -1314,13 +1307,8 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		rdwr_for_fscache = 1;
 
 	desired_access = cifs_convert_flags(cfile->f_flags, rdwr_for_fscache);
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
2.53.0


