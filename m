Return-Path: <stable+bounces-185864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F01F3BE0E79
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 00:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D84F54FF
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 22:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6609C3054CE;
	Wed, 15 Oct 2025 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgCogou9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249442652A4
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566132; cv=none; b=DBSuZe+JT94y2GZoTO1d82mk3wQP/sG56BhOjcn3ahnxcNcIdReUgKez9IuW3nNEUPvp4HxBNJzhLuJ3eeA+ubEdSuEgn/BrXPtLmjoF95rxjdh7YDZLDn34t/9eETbtJNue9sNCwctvnYGaprsWa00Q7++fiASvW5Ms7mpmJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566132; c=relaxed/simple;
	bh=ixMA+0nYdu0zdxgZfX8/NMfV21NSNWhwApV1Na1pW1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bs/UrspHbMjtm5JpNJ9E+NQRhnxRguKDiYX+rp0iQoQMEAeNsPxnZ8ga+uD/FfqPVkzte0VXsRG641kzpQGova0E7lfeuWet2lqnZJ7mwysUiES8hqB0DjxucoG27JEK/BNEqD+vYaiwioW+rpVoCoMK6WIcNGcA8zBqpavygqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgCogou9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B38C4CEFE;
	Wed, 15 Oct 2025 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760566131;
	bh=ixMA+0nYdu0zdxgZfX8/NMfV21NSNWhwApV1Na1pW1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgCogou9CcUNoIGMzc/FVPS97i6rKogbaAWTPX2OyUbuq00YlbDPMbu0vzxfxrrnL
	 XiIlUy5lO8gG7b+W9wJfcCViEoraLWzUNEiq3TPL6a+zmHEQdZw2h97DDLSRMCnv1A
	 wloUJGMCAyP8KFfCaqqPX6WN02egP7eJceaxJqpWqQ4KgsXSpc3jWUOYjJytp/WH4V
	 o5bss2ECSXh3NhHqHu82DDeiXiwtflrZT9I8GGHC3mvrRQcBGJT16jssL+73pn4Myw
	 ODFrLvVJ+Gmw24LkrFnUP9rb2IaTAnK+3k2Gca/ty0oc+g3NUlKwyZP3spw7sI+dQc
	 uK7kWZNoOzgWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] nfsd: refine and rename NFSD_MAY_LOCK
Date: Wed, 15 Oct 2025 18:08:44 -0400
Message-ID: <20251015220846.1531878-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015220846.1531878-1-sashal@kernel.org>
References: <2025101547-demeanor-rectify-27be@gregkh>
 <20251015220846.1531878-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit 4cc9b9f2bf4dfe13fe573da978e626e2248df388 ]

NFSD_MAY_LOCK means a few different things.
- it means that GSS is not required.
- it means that with NFSEXP_NOAUTHNLM, authentication is not required
- it means that OWNER_OVERRIDE is allowed.

None of these are specific to locking, they are specific to the NLM
protocol.
So:
 - rename to NFSD_MAY_NLM
 - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fopen()
   so that NFSD_MAY_NLM doesn't need to imply these.
 - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
   into fh_verify where other special-case tests on the MAY flags
   happen.  nfsd_permission() can be called from other places than
   fh_verify(), but none of these will have NFSD_MAY_NLM.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 898374fdd7f0 ("nfsd: unregister with rpcbind when deleting a transport")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/lockd.c | 13 +++++++++++--
 fs/nfsd/nfsfh.c | 12 ++++--------
 fs/nfsd/trace.h |  2 +-
 fs/nfsd/vfs.c   | 12 +-----------
 fs/nfsd/vfs.h   |  2 +-
 5 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 46a7f9b813e52..edc9f75dc75c6 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
 	fh.fh_export = NULL;
 
+	/*
+	 * Allow BYPASS_GSS as some client implementations use AUTH_SYS
+	 * for NLM even when GSS is used for NFS.
+	 * Allow OWNER_OVERRIDE as permission might have been changed
+	 * after the file was opened.
+	 * Pass MAY_NLM so that authentication can be completely bypassed
+	 * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH_NULL
+	 * for NLM requests.
+	 */
 	access = (mode == O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
-	access |= NFSD_MAY_LOCK;
+	access |= NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_BYPASS_GSS;
 	nfserr = nfsd_open(rqstp, &fh, S_IFREG, access, filp);
 	fh_put(&fh);
- 	/* We return nlm error codes as nlm doesn't know
+	/* We return nlm error codes as nlm doesn't know
 	 * about nfsd, but nfsd does know about nlm..
 	 */
 	switch (nfserr) {
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index cbb046f88eec6..871de925a3df5 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
 	if (error)
 		goto out;
 
-	/*
-	 * pseudoflavor restrictions are not enforced on NLM,
-	 * which clients virtually always use auth_sys for,
-	 * even while using RPCSEC_GSS for NFS.
-	 */
-	if (access & NFSD_MAY_LOCK)
-		goto skip_pseudoflavor_check;
+	if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
+		/* NLM is allowed to fully bypass authentication */
+		goto out;
+
 	if (access & NFSD_MAY_BYPASS_GSS)
 		may_bypass_gss = true;
 	/*
@@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
 	if (error)
 		goto out;
 
-skip_pseudoflavor_check:
 	/* Finally, check access permissions. */
 	error = nfsd_permission(cred, exp, dentry, access);
 out:
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b8470d4cbe99e..3448e444d4100 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 		{ NFSD_MAY_READ,		"READ" },		\
 		{ NFSD_MAY_SATTR,		"SATTR" },		\
 		{ NFSD_MAY_TRUNC,		"TRUNC" },		\
-		{ NFSD_MAY_LOCK,		"LOCK" },		\
+		{ NFSD_MAY_NLM,			"NLM" },		\
 		{ NFSD_MAY_OWNER_OVERRIDE,	"OWNER_OVERRIDE" },	\
 		{ NFSD_MAY_LOCAL_ACCESS,	"LOCAL_ACCESS" },	\
 		{ NFSD_MAY_BYPASS_GSS_ON_ROOT,	"BYPASS_GSS_ON_ROOT" },	\
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4b9ab32173105..8c4f4e2f9cee0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2519,7 +2519,7 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 		(acc & NFSD_MAY_EXEC)?	" exec"  : "",
 		(acc & NFSD_MAY_SATTR)?	" sattr" : "",
 		(acc & NFSD_MAY_TRUNC)?	" trunc" : "",
-		(acc & NFSD_MAY_LOCK)?	" lock"  : "",
+		(acc & NFSD_MAY_NLM)?	" nlm"  : "",
 		(acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride" : "",
 		inode->i_mode,
 		IS_IMMUTABLE(inode)?	" immut" : "",
@@ -2544,16 +2544,6 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 	if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
 		return nfserr_perm;
 
-	if (acc & NFSD_MAY_LOCK) {
-		/* If we cannot rely on authentication in NLM requests,
-		 * just allow locks, otherwise require read permission, or
-		 * ownership
-		 */
-		if (exp->ex_flags & NFSEXP_NOAUTHNLM)
-			return 0;
-		else
-			acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
-	}
 	/*
 	 * The file owner always gets access permission for accesses that
 	 * would normally be checked at open time. This is to make
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 3ff1465225569..a61ada4fd9203 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -20,7 +20,7 @@
 #define NFSD_MAY_READ			0x004 /* == MAY_READ */
 #define NFSD_MAY_SATTR			0x008
 #define NFSD_MAY_TRUNC			0x010
-#define NFSD_MAY_LOCK			0x020
+#define NFSD_MAY_NLM			0x020 /* request is from lockd */
 #define NFSD_MAY_MASK			0x03f
 
 /* extra hints to permission and open routines: */
-- 
2.51.0


