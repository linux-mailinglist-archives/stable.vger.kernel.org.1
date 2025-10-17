Return-Path: <stable+bounces-187090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24747BEA63C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3737C5E56
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7532F2F12DE;
	Fri, 17 Oct 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0bCvoO93"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4423EA9E;
	Fri, 17 Oct 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715090; cv=none; b=rfvoserguk0q5fW6InPfRvmnLrz/761qokz4k7beg1pNoUH4r8TvGdw8GOQ5mRbdnPsYtZ7Q2IEBE/WjZh5Ph1oLh9lD/y4aor8cQXdNnUlY66SzqfOHqDTQl+1mbz6ZZKjGyKollLu3uxOEUkkhpi0R58lErkfvw/XV9Py8N3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715090; c=relaxed/simple;
	bh=ZlHeaABB83dShpATG0phGc8j+9EscWVnRmzRa5U2heU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUKIHqf+slSmaPnQVBsS4eN8xrg6tFJCFj6aj9bjy9wXh6WSfPbub2pjDwubjWRs2yJd3/MSrrI/bYs7nAJQFpLl3nzdZ4eIl1isYoxL6ZXs5aWQYfg2Wbxa7q1RmcxL7One16GPOTRQsVSN6iqD+TcN25pPw+e/bkKsLortRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0bCvoO93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD399C4CEE7;
	Fri, 17 Oct 2025 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715090;
	bh=ZlHeaABB83dShpATG0phGc8j+9EscWVnRmzRa5U2heU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0bCvoO93YfxMC9Kw+ttuR0RIqvaTQRsGPslff69NPHpphtXCsMY/HOZLikRUQWrZh
	 LJUuV+AHWXHIY4mJhApTAOurGr9754DavN/9Y713TeFhr+NVa3YIY4mQWtAAT86Zf1
	 bW+Bymtefo3MBA1HfN4nwZhD+WKrmY4yVnhlE870=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 061/371] nfsd: fix SETATTR updates for delegated timestamps
Date: Fri, 17 Oct 2025 16:50:36 +0200
Message-ID: <20251017145204.008886612@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 3952f1cbcbc454b2cb639ddbf165c07068e90371 ]

SETATTRs containing delegated timestamp updates are currently not being
vetted properly. Since we no longer need to compare the timestamps vs.
the current timestamps, move the vetting of delegated timestamps wholly
into nfsd.

Rename the set_cb_time() helper to nfsd4_vet_deleg_time(), and make it
non-static. Add a new vet_deleg_attrs() helper that is called from
nfsd4_setattr that uses nfsd4_vet_deleg_time() to properly validate the
all the timestamps. If the validation indicates that the update should
be skipped, unset the appropriate flags in ia_valid.

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4state.c | 24 +++++++++++-------------
 fs/nfsd/state.h     |  3 +++
 3 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 71b428efcbb59..9bd49783db932 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1133,6 +1133,33 @@ nfsd4_secinfo_no_name_release(union nfsd4_op_u *u)
 		exp_put(u->secinfo_no_name.sin_exp);
 }
 
+/*
+ * Validate that the requested timestamps are within the acceptable range. If
+ * timestamp appears to be in the future, then it will be clamped to
+ * current_time().
+ */
+static void
+vet_deleg_attrs(struct nfsd4_setattr *setattr, struct nfs4_delegation *dp)
+{
+	struct timespec64 now = current_time(dp->dl_stid.sc_file->fi_inode);
+	struct iattr *iattr = &setattr->sa_iattr;
+
+	if ((setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) &&
+	    !nfsd4_vet_deleg_time(&iattr->ia_atime, &dp->dl_atime, &now))
+		iattr->ia_valid &= ~(ATTR_ATIME | ATTR_ATIME_SET);
+
+	if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
+		if (nfsd4_vet_deleg_time(&iattr->ia_mtime, &dp->dl_mtime, &now)) {
+			iattr->ia_ctime = iattr->ia_mtime;
+			if (!nfsd4_vet_deleg_time(&iattr->ia_ctime, &dp->dl_ctime, &now))
+				iattr->ia_valid &= ~(ATTR_CTIME | ATTR_CTIME_SET);
+		} else {
+			iattr->ia_valid &= ~(ATTR_CTIME | ATTR_CTIME_SET |
+					     ATTR_MTIME | ATTR_MTIME_SET);
+		}
+	}
+}
+
 static __be32
 nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	      union nfsd4_op_u *u)
@@ -1170,8 +1197,10 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			struct nfs4_delegation *dp = delegstateid(st);
 
 			/* Only for *_ATTRS_DELEG flavors */
-			if (deleg_attrs_deleg(dp->dl_type))
+			if (deleg_attrs_deleg(dp->dl_type)) {
+				vet_deleg_attrs(setattr, dp);
 				status = nfs_ok;
+			}
 		}
 	}
 	if (st)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8737b721daf34..f2fd0cbe256b9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9135,25 +9135,25 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
 }
 
 /**
- * set_cb_time - vet and set the timespec for a cb_getattr update
- * @cb: timestamp from the CB_GETATTR response
+ * nfsd4_vet_deleg_time - vet and set the timespec for a delegated timestamp update
+ * @req: timestamp from the client
  * @orig: original timestamp in the inode
  * @now: current time
  *
- * Given a timestamp in a CB_GETATTR response, check it against the
+ * Given a timestamp from the client response, check it against the
  * current timestamp in the inode and the current time. Returns true
  * if the inode's timestamp needs to be updated, and false otherwise.
- * @cb may also be changed if the timestamp needs to be clamped.
+ * @req may also be changed if the timestamp needs to be clamped.
  */
-static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
-			const struct timespec64 *now)
+bool nfsd4_vet_deleg_time(struct timespec64 *req, const struct timespec64 *orig,
+			  const struct timespec64 *now)
 {
 
 	/*
 	 * "When the time presented is before the original time, then the
 	 *  update is ignored." Also no need to update if there is no change.
 	 */
-	if (timespec64_compare(cb, orig) <= 0)
+	if (timespec64_compare(req, orig) <= 0)
 		return false;
 
 	/*
@@ -9161,10 +9161,8 @@ static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
 	 *  clamp the new time to the current time, or it may
 	 *  return NFS4ERR_DELAY to the client, allowing it to retry."
 	 */
-	if (timespec64_compare(cb, now) > 0) {
-		/* clamp it */
-		*cb = *now;
-	}
+	if (timespec64_compare(req, now) > 0)
+		*req = *now;
 
 	return true;
 }
@@ -9184,10 +9182,10 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
 		attrs.ia_atime = ncf->ncf_cb_atime;
 		attrs.ia_mtime = ncf->ncf_cb_mtime;
 
-		if (set_cb_time(&attrs.ia_atime, &atime, &now))
+		if (nfsd4_vet_deleg_time(&attrs.ia_atime, &atime, &now))
 			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
 
-		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
+		if (nfsd4_vet_deleg_time(&attrs.ia_mtime, &mtime, &now)) {
 			attrs.ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
 					  ATTR_MTIME | ATTR_MTIME_SET;
 			attrs.ia_ctime = attrs.ia_mtime;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ce7c0d129ba33..bf9436cdb93c5 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -247,6 +247,9 @@ static inline bool deleg_attrs_deleg(u32 dl_type)
 	       dl_type == OPEN_DELEGATE_WRITE_ATTRS_DELEG;
 }
 
+bool nfsd4_vet_deleg_time(struct timespec64 *cb, const struct timespec64 *orig,
+			  const struct timespec64 *now);
+
 #define cb_to_delegation(cb) \
 	container_of(cb, struct nfs4_delegation, dl_recall)
 
-- 
2.51.0




