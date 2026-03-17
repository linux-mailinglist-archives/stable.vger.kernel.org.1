Return-Path: <stable+bounces-225984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WASnC5ZRuWkoAgIAu9opvQ
	(envelope-from <stable+bounces-225984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:05:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794E2AA6DA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B71C3303FD03
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88183CA49E;
	Tue, 17 Mar 2026 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+4FET7g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF333CA49B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752479; cv=none; b=qeXt8iQahxUFgQvNCAAeKo/ZCNlgAiTGWgcaHoqEDH1VFhCNfDCR1ySnKWbNgr8RrX+xY7wfZ3C+qBbs0dPKGYB4HSNcIfOeMoDReP3/4MQ9AuRwQ50KM+GzR7inSeW896Mwd/S1BsQn8Rth2i9MsdlGNeZCyY6m2lX2SLkfnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752479; c=relaxed/simple;
	bh=zJZWnzi5GNavtgc0KCygdBY5yWPayx+TGAyePv1zm9E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NiItnU3jKQaU6aNwfe4p/kLPFzFYCYe293aCqgD7WQbjfNQLG6Xg/PZ8MLP9ekxHgt1ob7RgBC0ydVY2kzLPiJFhiVmV/Ulxua8vnZZyKthMZ+R+QhiCr6+Ey3+Z8Q7xVrdV2rNhqDDEPjsSrPZJxCvFfYUqawOGYjYQFJQpDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i+4FET7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42964C2BC86;
	Tue, 17 Mar 2026 13:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773752479;
	bh=zJZWnzi5GNavtgc0KCygdBY5yWPayx+TGAyePv1zm9E=;
	h=Subject:To:Cc:From:Date:From;
	b=i+4FET7gKnEEcbj05FIWegLUgWUqD2QKNshh26BKHZwGwCLtfH5f6EGfySdfEBjAX
	 qXzL3Rc+9NHCJdk93ZyDGWF7n8t5CDSTBAIRWxpbpsgP7JS3CjQOA8RJU0542KXZRU
	 wcDpJN8imFZHWiRhckIncrgDd/ETFZ95ZMJktq58=
Subject: FAILED: patch "[PATCH] smb: client: fix atomic open with O_DIRECT & O_SYNC" failed to apply to 5.10-stable tree
To: pc@manguebit.org,dhowells@redhat.com,henrique.carvalho@suse.com,stfrench@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 14:01:06 +0100
Message-ID: <2026031706-baritone-circle-1085@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225984-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,talpey.com:email,manguebit.org:email]
X-Rspamd-Queue-Id: 9794E2AA6DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4a7d2729dc99437dbb880a64c47828c0d191b308
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031706-baritone-circle-1085@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a7d2729dc99437dbb880a64c47828c0d191b308 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sat, 7 Mar 2026 18:20:16 -0300
Subject: [PATCH] smb: client: fix atomic open with O_DIRECT & O_SYNC

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

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 6f9b6c72962b..bb0fe4b60240 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -20,6 +20,7 @@
 #include <linux/utsname.h>
 #include <linux/sched/mm.h>
 #include <linux/netfs.h>
+#include <linux/fcntl.h>
 #include "cifs_fs_sb.h"
 #include "cifsacl.h"
 #include <crypto/internal/hash.h>
@@ -2375,4 +2376,14 @@ static inline bool cifs_forced_shutdown(const struct cifs_sb_info *sbi)
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


