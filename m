Return-Path: <stable+bounces-185865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E489CBE0E7C
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 00:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BE61A21232
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 22:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ABA3054DE;
	Wed, 15 Oct 2025 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA/b0tdm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291B2652A4
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566132; cv=none; b=XSqxFGzyPn76K25jxGjnbvfvSKI9E2pxibsRNYo2BZZmLd5YzyOxLh7Yt+eajeIzA4UJ1Fg8pDIKgnefeQa7wcMRB7Gbrrw+K1fP6Vf8KWlOqryFxD672P15T7ljkz95It83sSw0TVh3II9Bb+QUCZqco+aregKaw4/kGvWvT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566132; c=relaxed/simple;
	bh=csxU2qIpFmJjGK1EdDAtvUJDVYQ9H1LLh4lj2xFXrG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S27RzvYuaQnxJ/74SeWAaKa0S2gA0FyIz44oT6DgsVBc6T0ZtlpZYHOdQ753RcsQ2s0bUPbgTtuf1oqhI7KRjeB4es5hdgdKf8AFnVdNjfcMm+muUju9Mwz7D6zZnxM5mbElurtdSgy891m1cF1acGPogMYzj0V1FK9l6QXPEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA/b0tdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4D1C4CEF8;
	Wed, 15 Oct 2025 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760566132;
	bh=csxU2qIpFmJjGK1EdDAtvUJDVYQ9H1LLh4lj2xFXrG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NA/b0tdmMMcbJ3UBXCjVeds5PTMj24GM5CqLN651Is4DMxtypQrwqKmN/dNkijp9t
	 p4YZVIZcscdKFZkvfF7IvZEhmIG6gDt72yze5TV6ekEB/mz/NK6xvy9p6p6npPdcrs
	 pj47bxoaqW19SB6FR9KhZUoX9RrGHP865m8lkcTt/IJTA5YNpEaXOu5pu7DDkit50K
	 0pgTS2L56Zpk7PIYPO2dsPc7WNv2X8GrZVEAWZZ6Zy9Qf+pg8fIIQtKTVmAkdNmqfx
	 UWR7qzHfRqym5V1KDhhhwaZOswxbfQl5HLrSyWmHAM+8AffusMM3DgvHlUo6jLvtvO
	 CSaPwSmzPzk1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] nfsd: don't use sv_nrthreads in connection limiting calculations.
Date: Wed, 15 Oct 2025 18:08:45 -0400
Message-ID: <20251015220846.1531878-4-sashal@kernel.org>
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

[ Upstream commit eccbbc7c00a5aae5e704d4002adfaf4c3fa4b30d ]

The heuristic for limiting the number of incoming connections to nfsd
currently uses sv_nrthreads - allowing more connections if more threads
were configured.

A future patch will allow number of threads to grow dynamically so that
there will be no need to configure sv_nrthreads.  So we need a different
solution for limiting connections.

It isn't clear what problem is solved by limiting connections (as
mentioned in a code comment) but the most likely problem is a connection
storm - many connections that are not doing productive work.  These will
be closed after about 6 minutes already but it might help to slow down a
storm.

This patch adds a per-connection flag XPT_PEER_VALID which indicates
that the peer has presented a filehandle for which it has some sort of
access.  i.e the peer is known to be trusted in some way.  We now only
count connections which have NOT been determined to be valid.  There
should be relative few of these at any given time.

If the number of non-validated peer exceed a limit - currently 64 - we
close the oldest non-validated peer to avoid having too many of these
useless connections.

Note that this patch significantly changes the meaning of the various
configuration parameters for "max connections".  The next patch will
remove all of these.

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 898374fdd7f0 ("nfsd: unregister with rpcbind when deleting a transport")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/callback.c               |  4 ----
 fs/nfs/callback_xdr.c           |  1 +
 fs/nfsd/netns.h                 |  4 ++--
 fs/nfsd/nfsfh.c                 |  2 ++
 include/linux/sunrpc/svc.h      |  2 +-
 include/linux/sunrpc/svc_xprt.h | 16 ++++++++++++++++
 net/sunrpc/svc_xprt.c           | 32 ++++++++++++++++----------------
 7 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 6cf92498a5ac6..86bdc7d23fb90 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -211,10 +211,6 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 		return ERR_PTR(-ENOMEM);
 	}
 	cb_info->serv = serv;
-	/* As there is only one thread we need to over-ride the
-	 * default maximum of 80 connections
-	 */
-	serv->sv_maxconn = 1024;
 	dprintk("nfs_callback_create_svc: service created\n");
 	return serv;
 }
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index fdeb0b34a3d39..4254ba3ee7c57 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -984,6 +984,7 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 			nfs_put_client(cps.clp);
 			goto out_invalidcred;
 		}
+		svc_xprt_set_valid(rqstp->rq_xprt);
 	}
 
 	cps.minorversion = hdr_arg.minorversion;
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 26f7b34d1a030..a05a45bb19781 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -129,8 +129,8 @@ struct nfsd_net {
 	unsigned char writeverf[8];
 
 	/*
-	 * Max number of connections this nfsd container will allow. Defaults
-	 * to '0' which is means that it bases this on the number of threads.
+	 * Max number of non-validated connections this nfsd container
+	 * will allow.  Defaults to '0' gets mapped to 64.
 	 */
 	unsigned int max_connections;
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 871de925a3df5..a61d057878a06 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -382,6 +382,8 @@ __fh_verify(struct svc_rqst *rqstp,
 	if (error)
 		goto out;
 
+	svc_xprt_set_valid(rqstp->rq_xprt);
+
 	/* Finally, check access permissions. */
 	error = nfsd_permission(cred, exp, dentry, access);
 out:
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e68fecf6eab5b..617ebfff2f304 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -81,7 +81,7 @@ struct svc_serv {
 	unsigned int		sv_xdrsize;	/* XDR buffer size */
 	struct list_head	sv_permsocks;	/* all permanent sockets */
 	struct list_head	sv_tempsocks;	/* all temporary sockets */
-	int			sv_tmpcnt;	/* count of temporary sockets */
+	int			sv_tmpcnt;	/* count of temporary "valid" sockets */
 	struct timer_list	sv_temptimer;	/* timer for aging temporary sockets */
 
 	char *			sv_name;	/* service name */
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 0981e35a9feda..7064ebbd550b5 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -99,8 +99,24 @@ enum {
 	XPT_HANDSHAKE,		/* xprt requests a handshake */
 	XPT_TLS_SESSION,	/* transport-layer security established */
 	XPT_PEER_AUTH,		/* peer has been authenticated */
+	XPT_PEER_VALID,		/* peer has presented a filehandle that
+				 * it has access to.  It is NOT counted
+				 * in ->sv_tmpcnt.
+				 */
 };
 
+static inline void svc_xprt_set_valid(struct svc_xprt *xpt)
+{
+	if (test_bit(XPT_TEMP, &xpt->xpt_flags) &&
+	    !test_and_set_bit(XPT_PEER_VALID, &xpt->xpt_flags)) {
+		struct svc_serv *serv = xpt->xpt_server;
+
+		spin_lock(&serv->sv_lock);
+		serv->sv_tmpcnt -= 1;
+		spin_unlock(&serv->sv_lock);
+	}
+}
+
 static inline void unregister_xpt_user(struct svc_xprt *xpt, struct svc_xpt_user *u)
 {
 	spin_lock(&xpt->xpt_lock);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 43c57124de52f..dbd96b295dfa0 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -606,7 +606,8 @@ int svc_port_is_privileged(struct sockaddr *sin)
 }
 
 /*
- * Make sure that we don't have too many active connections. If we have,
+ * Make sure that we don't have too many connections that have not yet
+ * demonstrated that they have access to the NFS server. If we have,
  * something must be dropped. It's not clear what will happen if we allow
  * "too many" connections, but when dealing with network-facing software,
  * we have to code defensively. Here we do that by imposing hard limits.
@@ -625,27 +626,25 @@ int svc_port_is_privileged(struct sockaddr *sin)
  */
 static void svc_check_conn_limits(struct svc_serv *serv)
 {
-	unsigned int limit = serv->sv_maxconn ? serv->sv_maxconn :
-				(serv->sv_nrthreads+3) * 20;
+	unsigned int limit = serv->sv_maxconn ? serv->sv_maxconn : 64;
 
 	if (serv->sv_tmpcnt > limit) {
-		struct svc_xprt *xprt = NULL;
+		struct svc_xprt *xprt = NULL, *xprti;
 		spin_lock_bh(&serv->sv_lock);
 		if (!list_empty(&serv->sv_tempsocks)) {
-			/* Try to help the admin */
-			net_notice_ratelimited("%s: too many open connections, consider increasing the %s\n",
-					       serv->sv_name, serv->sv_maxconn ?
-					       "max number of connections" :
-					       "number of threads");
 			/*
 			 * Always select the oldest connection. It's not fair,
-			 * but so is life
+			 * but nor is life.
 			 */
-			xprt = list_entry(serv->sv_tempsocks.prev,
-					  struct svc_xprt,
-					  xpt_list);
-			set_bit(XPT_CLOSE, &xprt->xpt_flags);
-			svc_xprt_get(xprt);
+			list_for_each_entry_reverse(xprti, &serv->sv_tempsocks,
+						    xpt_list) {
+				if (!test_bit(XPT_PEER_VALID, &xprti->xpt_flags)) {
+					xprt = xprti;
+					set_bit(XPT_CLOSE, &xprt->xpt_flags);
+					svc_xprt_get(xprt);
+					break;
+				}
+			}
 		}
 		spin_unlock_bh(&serv->sv_lock);
 
@@ -1039,7 +1038,8 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 
 	spin_lock_bh(&serv->sv_lock);
 	list_del_init(&xprt->xpt_list);
-	if (test_bit(XPT_TEMP, &xprt->xpt_flags))
+	if (test_bit(XPT_TEMP, &xprt->xpt_flags) &&
+	    !test_bit(XPT_PEER_VALID, &xprt->xpt_flags))
 		serv->sv_tmpcnt--;
 	spin_unlock_bh(&serv->sv_lock);
 
-- 
2.51.0


