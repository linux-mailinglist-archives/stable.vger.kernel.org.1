Return-Path: <stable+bounces-71280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C699612A8
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBEF28231D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E6B1C7B82;
	Tue, 27 Aug 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="feOr6mmO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016A1BDA93;
	Tue, 27 Aug 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772693; cv=none; b=m20Nl+jxqFVbIfq0OWO6jpQJV0wbTFd9bNxsK/CNH/W6r49xPWqAsZlY8fAWQgVFP5hJzr0BfDizkUhYc8A1LkLwiC9C7GAcyqSYCh326Y3mWtEh9A/+j5eyg7DLZ2FkUMWWB9KUQjunnSla1zh/Jlgx5/9YUn2/GCV69bQMXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772693; c=relaxed/simple;
	bh=WYl5D7kudtSY/Spg5xZbl9A5zYradtf1O+E5B9Ni5lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOmznuMV7FNhG56Mea3yfS3t/m+oCgYSZX0I53yNhhitd/EqcZQDlWsX+haE2OMfJENZIHs0BnPWxqfh1KTwfLJ9evCy3VFwg5TyrW8dWjCsPZTyPI2lha2YojRZ2UibclfGlXSLs1H/kMnnrZZAorSl27TpSkkYYd5FWlO/Xvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=feOr6mmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C82CC4DDF0;
	Tue, 27 Aug 2024 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772690;
	bh=WYl5D7kudtSY/Spg5xZbl9A5zYradtf1O+E5B9Ni5lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=feOr6mmOZs5pVnObhRlKSudgDHvhHrOxzIcV3eb9XO3/18AN4Sz5aLL2Du2wOWsaV
	 ui7dFG+L2dNJeNGaxKy7+CkMg+A/EnGl+xrH0u+i8wVIveeuqffUooDpps1XxyZ8BU
	 x4P5H0VSPWBvASqn7AX/DC/tTmyuDhsRJntuK4zI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 290/321] NFSD: simplify error paths in nfsd_svc()
Date: Tue, 27 Aug 2024 16:39:58 +0200
Message-ID: <20240827143849.290509824@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

[ Upstream commit bf32075256e9dd9c6b736859e2c5813981339908 ]

The error paths in nfsd_svc() are needlessly complex and can result in a
final call to svc_put() without nfsd_last_thread() being called.  This
results in the listening sockets not being closed properly.

The per-netns setup provided by nfsd_startup_new() and removed by
nfsd_shutdown_net() is needed precisely when there are running threads.
So we don't need nfsd_up_before.  We don't need to know if it *was* up.
We only need to know if any threads are left.  If none are, then we must
call nfsd_shutdown_net().  But we don't need to do that explicitly as
nfsd_last_thread() does that for us.

So simply call nfsd_last_thread() before the last svc_put() if there are
no running threads.  That will always do the right thing.

Also discard:
 pr_info("nfsd: last server has exited, flushing export cache\n");
It may not be true if an attempt to start the first server failed, and
it isn't particularly helpful and it simply reports normal behaviour.

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfssvc.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -562,7 +562,6 @@ static void nfsd_last_thread(struct net
 		return;
 
 	nfsd_shutdown_net(net);
-	pr_info("nfsd: last server has exited, flushing export cache\n");
 	nfsd_export_flush(net);
 }
 
@@ -778,7 +777,6 @@ int
 nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 {
 	int	error;
-	bool	nfsd_up_before;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
@@ -798,8 +796,6 @@ nfsd_svc(int nrservs, struct net *net, c
 	error = nfsd_create_serv(net);
 	if (error)
 		goto out;
-
-	nfsd_up_before = nn->nfsd_net_up;
 	serv = nn->nfsd_serv;
 
 	error = nfsd_startup_net(net, cred);
@@ -807,17 +803,15 @@ nfsd_svc(int nrservs, struct net *net, c
 		goto out_put;
 	error = svc_set_num_threads(serv, NULL, nrservs);
 	if (error)
-		goto out_shutdown;
+		goto out_put;
 	error = serv->sv_nrthreads;
-	if (error == 0)
-		nfsd_last_thread(net);
-out_shutdown:
-	if (error < 0 && !nfsd_up_before)
-		nfsd_shutdown_net(net);
 out_put:
 	/* Threads now hold service active */
 	if (xchg(&nn->keep_active, 0))
 		svc_put(serv);
+
+	if (serv->sv_nrthreads == 0)
+		nfsd_last_thread(net);
 	svc_put(serv);
 out:
 	mutex_unlock(&nfsd_mutex);



