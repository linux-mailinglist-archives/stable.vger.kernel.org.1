Return-Path: <stable+bounces-37651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B2289C69F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE1BB2C2F0
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA3B7F47A;
	Mon,  8 Apr 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="suLf4uFh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB417F46F;
	Mon,  8 Apr 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584859; cv=none; b=WN5fZpSSoGyNASN/9QDH2RFspY5Cc//0hFW/ILY3DCLGwqG7bMNnA84kI2uu4PygxOiXMUSWk4jOyVM4vzeaeAzBC3cLiRk+a+qHtNiT5Zog/XCzX8sNBOl6eudO3nKPScI9IrvsONJfvSWeSxAKUESeWhF1II9pwN7yMRjAnQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584859; c=relaxed/simple;
	bh=efgo0h+dBmu1TR0Ei2cDdNHSWt3+3n++Vjis2WywAC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odP+19lViXYLIjhngYWb8iaa4431bUOviPPfHwHsqKHlfMrV6LAXkjxIG7W7dFLe38IFVQqCy+vMrlvEcCKuR2P06NiNj5Igw50ZPSCIbR12bNePnxHsAGrE1J6PXP0RGmvwKPcDqEk4TFaijZZL7YX3WhcsNoqE6Z0jX1znmGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=suLf4uFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53BAC43399;
	Mon,  8 Apr 2024 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584859;
	bh=efgo0h+dBmu1TR0Ei2cDdNHSWt3+3n++Vjis2WywAC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=suLf4uFhDN2EohbK0WQ/iVF+sKDyb/ZONXpDqnAKJPUU9QTdv8qELAoL2fcCuo86l
	 diQqBO7vETKv0mNRStlLZdsPBV0bskNqx7JjVsNpyTv5+yD/mryi5iCCmdMNsBDhMd
	 UCnVbj8+28pYdw7Qyh1GEcPnSZTjPCI7gqgLc7hM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 551/690] nfsd: call nfsd_last_thread() before final nfsd_put()
Date: Mon,  8 Apr 2024 14:56:57 +0200
Message-ID: <20240408125419.591466944@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

[ Upstream commit 2a501f55cd641eb4d3c16a2eab0d678693fac663 ]

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
---
 fs/nfsd/nfsctl.c | 9 +++++++--
 fs/nfsd/nfsd.h   | 1 +
 fs/nfsd/nfssvc.c | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 76a60e7a75097..eec442edb6556 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -720,8 +720,10 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 
 	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (err >= 0 &&
-	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+		nfsd_last_thread(net);
+	else if (err >= 0 &&
+		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
 		svc_get(nn->nfsd_serv);
 
 	nfsd_put(net);
@@ -771,6 +773,9 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
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
index 867dcfd64d426..3796015dc7656 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -138,6 +138,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
 int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
 void nfsd_reset_versions(struct nfsd_net *nn);
 int nfsd_create_serv(struct net *net);
+void nfsd_last_thread(struct net *net);
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 2a1dd580dfb94..3d4fd40c987bd 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -529,7 +529,7 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 /* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
-static void nfsd_last_thread(struct net *net)
+void nfsd_last_thread(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
-- 
2.43.0




