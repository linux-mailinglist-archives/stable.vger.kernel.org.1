Return-Path: <stable+bounces-81359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4BF99318C
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26105282ABF
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B01D9346;
	Mon,  7 Oct 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KMHuPGdF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D21D90D1
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315577; cv=none; b=FaDFMTgzRTKoNGh600lJoO+j3wS+NXk3TNz9DYuK073VAzOxT4L1nxr+Pqrv5l30+CK0HJdI/VeFmzYYZC9f9cC6nECKzjy3wwZW0ZkJ4JdyXyZWfCuasyWmGgH3otdjgGrYs9uXxbkAG1Kae7X3sYrbUTQJqa7rLgSx1ZYGI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315577; c=relaxed/simple;
	bh=UqBrVqqHycaJWXWAmj7QZleEmvuhCXuFcQB082UDzYM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KapRFcxjtDr090ape662P+Yx9ZAAKlqVhhfDAReGNFBvDjYfm4IiltdLBB6wGPI3KTJYT5YbkfgUBKkNPmV5Bqwq2dhoj5TESILshevAqbosoSWrqfAoFa6Px5LLOFRBLDmE09G+4MKHY10w1gVicZiXoN+uhvr/Z0DtDFYpL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KMHuPGdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FBDC4CED2;
	Mon,  7 Oct 2024 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728315576;
	bh=UqBrVqqHycaJWXWAmj7QZleEmvuhCXuFcQB082UDzYM=;
	h=Subject:To:Cc:From:Date:From;
	b=KMHuPGdFUXOnKF7LqosjdVFKpxmg4eXvEGyQKCabMIeI/XBvvz7Cx4gJOfePt2mAc
	 ypPBS6gFmhfkFd9a/HfhRic5WTwOYwjNcN4Tn/eZvr2lBgpURDAIVrQ2HccRkngbAi
	 +3OAa6DGQTyLgVhN3SLBRob8bx/KexHHo+xiO2E4=
Subject: FAILED: patch "[PATCH] NFSD: Limit the number of concurrent async COPY operations" failed to apply to 5.10-stable tree
To: chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:39:21 +0200
Message-ID: <2024100721-crusher-anaerobic-cc9b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x aadc3bbea163b6caaaebfdd2b6c4667fbc726752
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100721-crusher-anaerobic-cc9b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operations")
9ed666eba4e0 ("NFSD: Async COPY result needs to return a write verifier")
8d915bbf3926 ("NFSD: Force all NFSv4.2 COPY requests to be synchronous")
15d1975b7279 ("NFSD: initialize copy->cp_clp early in nfsd4_copy for use by trace point")
81e722978ad2 ("NFSD: fix problems with cleanup on errors in nfsd4_copy")
34e8f9ec4c9a ("NFSD: fix leaked reference count of nfsd4_ssc_umount_item")
6ba434cb1a8d ("nfsd: clean up potential nfsd_file refcount leaks in COPY codepath")
75333d48f922 ("NFSD: fix use-after-free in __nfs42_ssc_open()")
781fde1a2ba2 ("NFSD: Rename the fields in copy_stateid_t")
754035ff79a1 ("NFSD enforce filehandle check for source file in COPY")
a11ada99ce93 ("NFSD: Move copy offload callback arguments into a separate structure")
e72f9bc006c0 ("NFSD: Add nfsd4_send_cb_offload()")
ad1e46c9b07b ("NFSD: Remove kmalloc from nfsd4_do_async_copy()")
3b7bf5933cad ("NFSD: Refactor nfsd4_do_copy()")
478ed7b10d87 ("NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)")
24d796ea383b ("NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)")
1913cdf56cb5 ("NFSD: Replace boolean fields in struct nfsd4_copy")
87689df69491 ("NFSD: Shrink size of struct nfsd4_copy")
3988a57885ee ("NFSD: Rename boot verifier functions")
91d2e9b56cf5 ("NFSD: Clean up the nfsd_net::nfssvc_boot field")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aadc3bbea163b6caaaebfdd2b6c4667fbc726752 Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Wed, 28 Aug 2024 13:40:04 -0400
Subject: [PATCH] NFSD: Limit the number of concurrent async COPY operations

Nothing appears to limit the number of concurrent async COPY
operations that clients can start. In addition, AFAICT each async
COPY can copy an unlimited number of 4MB chunks, so can run for a
long time. Thus IMO async COPY can become a DoS vector.

Add a restriction mechanism that bounds the number of concurrent
background COPY operations. Start simple and try to be fair -- this
patch implements a per-namespace limit.

An async COPY request that occurs while this limit is exceeded gets
NFS4ERR_DELAY. The requesting client can choose to send the request
again after a delay or fall back to a traditional read/write style
copy.

If there is need to make the mechanism more sophisticated, we can
visit that in future patches.

Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 238fc4e56e53..37b8bfdcfeea 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -148,6 +148,7 @@ struct nfsd_net {
 	u32		s2s_cp_cl_id;
 	struct idr	s2s_cp_stateids;
 	spinlock_t	s2s_cp_lock;
+	atomic_t	pending_async_copies;
 
 	/*
 	 * Version information
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 231c6035602f..9655acb407b7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1280,6 +1280,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
+	atomic_dec(&copy->cp_nn->pending_async_copies);
 	kfree(copy->cp_src);
 	kfree(copy);
 }
@@ -1835,10 +1836,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-		status = nfserrno(-ENOMEM);
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out_err;
+		async_copy->cp_nn = nn;
+		/* Arbitrary cap on number of pending async copy operations */
+		if (atomic_inc_return(&nn->pending_async_copies) >
+				(int)rqstp->rq_pool->sp_nrthreads) {
+			atomic_dec(&nn->pending_async_copies);
+			goto out_err;
+		}
 		INIT_LIST_HEAD(&async_copy->copies);
 		refcount_set(&async_copy->refcount, 1);
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
@@ -1878,7 +1885,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (async_copy)
 		cleanup_async_copy(async_copy);
-	status = nfserrno(-ENOMEM);
+	status = nfserr_jukebox;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7ade551bc022..a49aa75bc0b7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8554,6 +8554,7 @@ static int nfs4_state_create_net(struct net *net)
 	spin_lock_init(&nn->client_lock);
 	spin_lock_init(&nn->s2s_cp_lock);
 	idr_init(&nn->s2s_cp_stateids);
+	atomic_set(&nn->pending_async_copies, 0);
 
 	spin_lock_init(&nn->blocked_locks_lock);
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index fbdd42cde1fa..2a21a7662e03 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -713,6 +713,7 @@ struct nfsd4_copy {
 	struct nfsd4_ssc_umount_item *ss_nsui;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
+	struct nfsd_net		*cp_nn;
 };
 
 static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)


