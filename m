Return-Path: <stable+bounces-8654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6252481F80E
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 13:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026F01F22549
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5316FDF;
	Thu, 28 Dec 2023 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkWK1d/V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE06FDA
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 12:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30919C433C7;
	Thu, 28 Dec 2023 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703765369;
	bh=ysBKr/7HjeclqYNV1s6ZZAn3Bv54Khfieeza/mNQXBE=;
	h=Subject:To:Cc:From:Date:From;
	b=VkWK1d/V397XBxw0HIVbOsyskLGPTZLsEK3hXOrLlrpEl/bnT719f1+duyUcqjcG6
	 HurKFiLUUO2rR1ObOULLrFdKz92nBZOjDcAQDto27sw0/lAskDWGqD2pybB3hfiOnF
	 Ioa05BKyoW+YkaMXJ9InHrFNM7RXlzbfwwKUOSyM=
Subject: FAILED: patch "[PATCH] nfsd: call nfsd_last_thread() before final nfsd_put()" failed to apply to 6.1-stable tree
To: neilb@suse.de,chuck.lever@oracle.com,jlayton@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 12:09:27 +0000
Message-ID: <2023122826-siding-ocean-a757@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2a501f55cd641eb4d3c16a2eab0d678693fac663
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122826-siding-ocean-a757@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

2a501f55cd64 ("nfsd: call nfsd_last_thread() before final nfsd_put()")
9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a501f55cd641eb4d3c16a2eab0d678693fac663 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Fri, 15 Dec 2023 11:56:31 +1100
Subject: [PATCH] nfsd: call nfsd_last_thread() before final nfsd_put()

If write_ports_addfd or write_ports_addxprt fail, they call nfsd_put()
without calling nfsd_last_thread().  This leaves nn->nfsd_serv pointing
to a structure that has been freed.

So remove 'static' from nfsd_last_thread() and call it when the
nfsd_serv is about to be destroyed.

Fixes: ec52361df99b ("SUNRPC: stop using ->sv_nrthreads as a refcount")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 739ed5bf71cd..79efb1075f38 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -705,8 +705,10 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 
 	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (err >= 0 &&
-	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+		nfsd_last_thread(net);
+	else if (err >= 0 &&
+		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
 		svc_get(nn->nfsd_serv);
 
 	nfsd_put(net);
@@ -757,6 +759,9 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		svc_xprt_put(xprt);
 	}
 out_err:
+	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+		nfsd_last_thread(net);
+
 	nfsd_put(net);
 	return err;
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index f5ff42f41ee7..3286ffacbc56 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -155,6 +155,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
 int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
 void nfsd_reset_versions(struct nfsd_net *nn);
 int nfsd_create_serv(struct net *net);
+void nfsd_last_thread(struct net *net);
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index fe61d9bbcc1f..d6939e23ffcf 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -542,7 +542,7 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 /* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
-static void nfsd_last_thread(struct net *net)
+void nfsd_last_thread(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;


