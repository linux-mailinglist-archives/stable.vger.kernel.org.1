Return-Path: <stable+bounces-218397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOK1HOJSnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:39:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E120D18F59D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62C9931BFDFC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCD242D9B;
	Wed, 25 Feb 2026 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j1LyFYp5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315C1D5ABA;
	Wed, 25 Feb 2026 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983211; cv=none; b=hva7aDl5S2ja0AP7rcOjcZBlxo9Ct/5RU7tQogUCPNHH1zY+kgj0t3aw4JRrCnEvHVOF1J7VKxoJV8A/crrlFmukcCFqwjj5Xy4BmFSc6GC8Td2XvtehVt9XmAi1tq3gxs+pLmz2RWWzKsIX2RNJ94Yo/4cK6KwsiAj3I4gUhF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983211; c=relaxed/simple;
	bh=LnFu5jJrcJKDSYBpgF8jtCbBa5UuzrrXLI6hknBj6kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ET41BYgCs4iMndIKCfL+AR6LDx+pAho9s02APhka9TUqwlJSyH3/jNk7VEbLXZR2B5ZKv3iXY6FSCKlCJ8dBXdFsuQF15sUkw62YSq6nCKx5l/sE9V7Y9U//dKEZkxSdQbX35AUomjslkuM+SaOr7rFRG+B5JTu61Rh2Qg7/H+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j1LyFYp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCA1C116D0;
	Wed, 25 Feb 2026 01:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983211;
	bh=LnFu5jJrcJKDSYBpgF8jtCbBa5UuzrrXLI6hknBj6kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1LyFYp5NI5r1BEjdlqTZ9+O1z0E2Qw8/vyFwpoRX/AY10mQE7bpsFmBG73txrrWs
	 5zZR0V3UThoGhIhXZg1IPc4ViWFUwaVfEYxFsLwRLmzKDvPqMytumbwzND7qJYmmmJ
	 YOmMxsN+6HgeqyYVHp1y3iRzdsRjd/ULOduGJTeA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 360/781] NFS: NFSERR_INVAL is not defined by NFSv2
Date: Tue, 24 Feb 2026 17:17:49 -0800
Message-ID: <20260225012408.513906113@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218397-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,brown.name:email]
X-Rspamd-Queue-Id: E120D18F59D
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 0ac903d1bfdce8ff40657c2b7d996947b72b6645 ]

A documenting comment in include/uapi/linux/nfs.h claims incorrectly
that NFSv2 defines NFSERR_INVAL. There is no such definition in either
RFC 1094 or https://pubs.opengroup.org/onlinepubs/9629799/chap7.htm

NFS3ERR_INVAL is introduced in RFC 1813.

NFSD returns NFSERR_INVAL for PROC_GETACL, which has no
specification (yet).

However, nfsd_map_status() maps nfserr_symlink and nfserr_wrong_type
to nfserr_inval, which does not align with RFC 1094. This logic was
introduced only recently by commit 438f81e0e92a ("nfsd: move error
choice for incorrect object types to version-specific code."). Given
that we have no INVAL or SERVERFAULT status in NFSv2, probably the
only choice is NFSERR_IO.

Fixes: 438f81e0e92a ("nfsd: move error choice for incorrect object types to version-specific code.")
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs2acl.c        | 2 +-
 fs/nfsd/nfsproc.c        | 2 +-
 include/uapi/linux/nfs.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 5fb202acb0fd0..0ac538c761800 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -45,7 +45,7 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqstp)
 	inode = d_inode(fh->fh_dentry);
 
 	if (argp->mask & ~NFS_ACL_MASK) {
-		resp->status = nfserr_inval;
+		resp->status = nfserr_io;
 		goto out;
 	}
 	resp->mask = argp->mask;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 481e789a76974..8873033d1e82f 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -33,7 +33,7 @@ static __be32 nfsd_map_status(__be32 status)
 		break;
 	case nfserr_symlink:
 	case nfserr_wrong_type:
-		status = nfserr_inval;
+		status = nfserr_io;
 		break;
 	}
 	return status;
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index 71c7196d32817..e629c49535345 100644
--- a/include/uapi/linux/nfs.h
+++ b/include/uapi/linux/nfs.h
@@ -55,7 +55,7 @@
 	NFSERR_NODEV = 19,		/* v2 v3 v4 */
 	NFSERR_NOTDIR = 20,		/* v2 v3 v4 */
 	NFSERR_ISDIR = 21,		/* v2 v3 v4 */
-	NFSERR_INVAL = 22,		/* v2 v3 v4 */
+	NFSERR_INVAL = 22,		/*    v3 v4 */
 	NFSERR_FBIG = 27,		/* v2 v3 v4 */
 	NFSERR_NOSPC = 28,		/* v2 v3 v4 */
 	NFSERR_ROFS = 30,		/* v2 v3 v4 */
-- 
2.51.0




