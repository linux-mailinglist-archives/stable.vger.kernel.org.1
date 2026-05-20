Return-Path: <stable+bounces-249982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDX0IyzMDWqq3QUAu9opvQ
	(envelope-from <stable+bounces-249982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:58:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847E59052D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CEB33117620
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4143F3ED110;
	Wed, 20 May 2026 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zzhC5JtI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D4272E61
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288221; cv=none; b=o96QY6DkiPfmMoVGkOrIFCDMoQS5hYsIQWeyJeC/AEfYjanzEwZYfFUQM6N+yH/dRX/4QlN1NLcbYWUPhSbWJz7o+OH034frOKGa06bMyzst/nlQT6FvieoqrREQQI995vDjye8lMPCU0+yTTJDg3cAylKlqB5EYZ9FgDYgkNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288221; c=relaxed/simple;
	bh=XMEQJe6l3d/BN+dvzRD5P6XKtARSiH98qJV3mD9rDuw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PKtUBQC4xUfwXvdyLMTkfrfa74gxEZuz4rBNUCCrSEKIBOVnmY4ebGB5QZS9tyi5q0ljgJH9nd8HhPPfVmX817PeMhXGTdWRo+xYCh9Li8PK4BsLvGIZLauTQxLnRM5xePAUDF6XlAlcMw6sf4uaLM9IJwqftKLUfAc8MmAuMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zzhC5JtI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041871F00894;
	Wed, 20 May 2026 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288219;
	bh=XEkWoMx/Mmg+pc5PRe/YVkgrJonxnSkyV5BIejoDz3Y=;
	h=Subject:To:Cc:From:Date;
	b=zzhC5JtIZchs0uk3u5h3+yqgwM+xIusqiQEjSbmqhXjox7NQ2FK8cz15yp/mjW+0q
	 ueeu4aVZ91gEHDXYX6tLt0tagMnkrTxO0hEIusUPkwJkzmzkiUh/4uVFH05lPLNU6L
	 lPeEEudAhw2wt/PzwyhkC9bg/yGufQm/QwszA3f4=
Subject: FAILED: patch "[PATCH] nfsd: fix file change detection in CB_GETATTR" failed to apply to 6.12-stable tree
To: smayhew@redhat.com,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:43:42 +0200
Message-ID: <2026052042-skinning-easeful-2b7e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249982-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2847E59052D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 304d81a2fbf2b454def4debcb38ea173911b72cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052042-skinning-easeful-2b7e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 304d81a2fbf2b454def4debcb38ea173911b72cd Mon Sep 17 00:00:00 2001
From: Scott Mayhew <smayhew@redhat.com>
Date: Tue, 7 Apr 2026 18:08:57 -0400
Subject: [PATCH] nfsd: fix file change detection in CB_GETATTR

RFC 8881, section 10.4.3 doesn't say anything about caching the file
size in the delegation record, nor does it say anything about comparing
a cached file size with the size reported by the client in the
CB_GETATTR reply for the purpose of determining if the client holds
modified data for the file.

What section 10.4.3 of RFC 8881 does say is that the server should
compare the *current* file size with the size reported by the client
holding the delegation in the CB_GETATTR reply, and if they differ to
treat it as a modification regardless of the change attribute retrieved
via the CB_GETATTR.

Doing otherwise would cause the server to believe the client holding the
delegation has a modified version of the file, even if the client
flushed the modifications to the server prior to the CB_GETATTR.  This
would have the added side effect of subsequent CB_GETATTRs causing
updates to the mtime, ctime, and change attribute even if the client
holding the delegation makes no further updates to the file.

Modify nfsd4_deleg_getattr_conflict() to obtain the current file size
via i_size_read().  Retain the ncf_cur_fsize field, since it's a
convenient way to return the file size back to nfsd4_encode_fattr4(),
but don't use it for the purpose of detecting file changes.  Remove the
unnecessary initialization of ncf_cur_fsize in nfs4_open_delegation().

Also, if we recall the delegation (because the client didn't respond to
the CB_GETATTR), then skip the logic that checks the nfs4_cb_fattr
fields.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Cc: stable@vger.kernel.org
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b4d0e82b2690..a9f7bd491b8c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6378,7 +6378,6 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		}
 		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG :
 						    OPEN_DELEGATE_WRITE;
-		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
 		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
 		dp->dl_atime = stat.atime;
 		dp->dl_ctime = stat.ctime;
@@ -9429,11 +9428,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 		if (status != nfserr_jukebox ||
 		    !nfsd_wait_for_delegreturn(rqstp, inode))
 			goto out_status;
+		status = nfs_ok;
+		goto out_status;
+	}
+	if (!ncf->ncf_file_modified) {
+		if (ncf->ncf_initial_cinfo != ncf->ncf_cb_change)
+			ncf->ncf_file_modified = true;
+		else if (i_size_read(inode) != ncf->ncf_cb_fsize)
+			ncf->ncf_file_modified = true;
 	}
-	if (!ncf->ncf_file_modified &&
-	    (ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
-	     ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
-		ncf->ncf_file_modified = true;
 	if (ncf->ncf_file_modified) {
 		int err;
 


