Return-Path: <stable+bounces-249995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOwvAb3UDWrW3wUAu9opvQ
	(envelope-from <stable+bounces-249995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:35:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9C590FF6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9218C30488E7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C07F3EE1FD;
	Wed, 20 May 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CCth8thK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF93EE1EE
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289030; cv=none; b=ZVxjv7eLzOOTX0FBicnEgGKy9Ys9OiTwWgo9q3VSnYO5wy3HFYR2LcnAZULa4CqBWKzcgmEJUKuEGJG5zX+ja+OxiUd/a0bJusLuddctC7ya5OxDVJioqt4J9pdZCEaBDSJvIpWAwaSTOR3fyGq6+6/OmZvTqUP/RsS73oRBmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289030; c=relaxed/simple;
	bh=dqjg27JbMBWac7/3o12jP4321MAh027S/7V3p3fUj3w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lzXZCCeladC3znAQO4nOMKe0afJLgBavBR0kBtSPRfuCxqSvSlCFDqNNnvgQOLFFJ/cTKBcXwboK2IV+G0WRfU+sHZIfhvLBmL93UNq8quHtE2sGrEvqxxX/IouY2VCfw2gN55nMiXanzzwLA0aS8GG4/bwewt1iFA1t39N6vr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CCth8thK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B087A1F000E9;
	Wed, 20 May 2026 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779289029;
	bh=brHJ1OdWL0rYHMX5MmL45+MItjvVDQxtbBlvzrE/3Zs=;
	h=Subject:To:Cc:From:Date;
	b=CCth8thKcfQRXURqo+Z59NxfFXYiJpgJcpLVPRv6vNzL29EP+hqZhcXAzBNRJ9uh1
	 gjyVuyZP80LIwOfErjjy4klXB4qySL8k7DCUlQuIL67Sy56B+Nss+Cg5KSasxt/66M
	 V07YD9qXamPR4m7m8lzOAQrW3iu+Tfc6pl+16tHA=
Subject: FAILED: patch "[PATCH] nfsd: update mtime/ctime on CLONE in presense of delegated" failed to apply to 6.18-stable tree
To: okorniev@redhat.com,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:55:32 +0200
Message-ID: <2026052032-acutely-resize-ed3e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249995-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 84F9C590FF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2863bac7f49c4acd80a048ce52506a2b9c8db015
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052032-acutely-resize-ed3e@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2863bac7f49c4acd80a048ce52506a2b9c8db015 Mon Sep 17 00:00:00 2001
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Fri, 10 Apr 2026 12:09:19 -0400
Subject: [PATCH] nfsd: update mtime/ctime on CLONE in presense of delegated
 attributes

When delegated attributes are given on open, the file is opened with
NOCMTIME and modifying operations do not update mtime/ctime as to not get
out-of-sync with the client's delegated view. However, for CLONE operation,
the server should update its view of mtime/ctime and reflect that in any
GETATTR queries.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Cc: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2797da8cc950..5de8f37df78a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1413,6 +1413,9 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			dst, clone->cl_dst_pos, clone->cl_count,
 			EX_ISSYNC(cstate->current_fh.fh_export));
 
+	if (!status && (READ_ONCE(dst->nf_file->f_mode) & FMODE_NOCMTIME) != 0)
+		nfsd_update_cmtime_attr(dst->nf_file, 0);
+
 	nfsd_file_put(dst);
 	nfsd_file_put(src);
 out:
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a9f7bd491b8c..3cd8b3b59de4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1221,10 +1221,6 @@ static void put_deleg_file(struct nfs4_file *fp)
 
 static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct file *f)
 {
-	struct iattr ia = { .ia_valid = ATTR_ATIME | ATTR_CTIME | ATTR_MTIME | ATTR_DELEG };
-	struct inode *inode = file_inode(f);
-	int ret;
-
 	/* don't do anything if FMODE_NOCMTIME isn't set */
 	if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) == 0)
 		return;
@@ -1242,17 +1238,7 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 		return;
 
 	/* Stamp everything to "now" */
-	inode_lock(inode);
-	ret = notify_change(&nop_mnt_idmap, f->f_path.dentry, &ia, NULL);
-	inode_unlock(inode);
-	if (ret) {
-		struct inode *inode = file_inode(f);
-
-		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%lu: %d\n",
-					MAJOR(inode->i_sb->s_dev),
-					MINOR(inode->i_sb->s_dev),
-					inode->i_ino, ret);
-	}
+	nfsd_update_cmtime_attr(f, ATTR_ATIME);
 }
 
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
@@ -9563,3 +9549,31 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	put_nfs4_file(fp);
 	return ERR_PTR(status);
 }
+
+/**
+ * nfsd_update_cmtime_attr - update file's delegated ctime/mtime,
+ *                           and optionally other attributes (ie ATTR_ATIME).
+ * @f: pointer to an opened file
+ * @flags: any additional flags that should be updated
+ *
+ * Given upon opening a file delegated attributes were issues, update
+ * @f attributes to current times.
+ */
+void nfsd_update_cmtime_attr(struct file *f, unsigned int flags)
+{
+	int ret;
+	struct inode *inode = file_inode(f);
+	struct iattr attr = {
+		.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_DELEG | flags,
+	};
+
+	inode_lock(inode);
+	ret = notify_change(&nop_mnt_idmap, f->f_path.dentry, &attr, NULL);
+	inode_unlock(inode);
+	if (ret)
+		pr_notice_ratelimited("nfsd: Unable to update timestamps on "
+				      "inode %02x:%02x:%lu: %d\n",
+				      MAJOR(inode->i_sb->s_dev),
+				      MINOR(inode->i_sb->s_dev),
+				      inode->i_ino, ret);
+}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 953675eba5c3..c5ccea64c281 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -843,6 +843,7 @@ extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
 void nfsd4_put_client(struct nfs4_client *clp);
 void nfsd4_async_copy_reaper(struct nfsd_net *nn);
 bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
+void nfsd_update_cmtime_attr(struct file *f, unsigned int flags);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
 				struct xdr_netobj princhash, struct nfsd_net *nn);
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);


