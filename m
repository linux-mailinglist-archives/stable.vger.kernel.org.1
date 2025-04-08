Return-Path: <stable+bounces-128899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C488A7FB40
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41553A7BFA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC226560E;
	Tue,  8 Apr 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EakqrRJ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF05264F90
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106897; cv=none; b=FQ86MRGMKI0YIttxQ+ejR3Jl4U0ndHJwpHFCuXHDX2bF9qFln2IgHEiPMGLSWZ4f+3c8RYQ6Ghi+u3H3KqBHKYkIUjHh1/W+pkVnVSEi5CW4sKTLR5LRGwl2boQ9bpnnNNNq5vGR8lCcbfwQSaAFYfsrNgL13DnrkHqFMNBIqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106897; c=relaxed/simple;
	bh=LCb0fz+It+cjwG/pMqBqQ9oI4x4WDCQheQLygiCoLVo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lq4gw41II/c8S5cPq/ijWE7f7u876b5YwIVB74orMYlb3ilEElbzYKo/gRKwN62Dpvi53gwI02cj2DSOGdogNQycONRG4Nbsd/KRceQkisukJUO8tjBMFAEhPk43oL4aMKtkPbS/6laf04giONpf57pT6wUiX+dwshIHJKgpRxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EakqrRJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960EBC4CEE5;
	Tue,  8 Apr 2025 10:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106894;
	bh=LCb0fz+It+cjwG/pMqBqQ9oI4x4WDCQheQLygiCoLVo=;
	h=Subject:To:Cc:From:Date:From;
	b=EakqrRJ1O3bd/7LH6/yZJrBxfEkw1WMIjeL7S8sTyMWSbO6iZQCz8A0kI7hlQvZxF
	 VGigjkm9gMN7vuySdk3S3J5Wz9B1Jdxns7SXul1vVg1f5g53dJzJYvJ7TUpD0wdM6x
	 NuF81i6dpTSFlGFBeXGw0fUkP7jeIY1Z8dwRSTiY=
Subject: FAILED: patch "[PATCH] nfsd: don't ignore the return code of svc_proc_register()" failed to apply to 6.12-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:06:38 +0200
Message-ID: <2025040838-january-snooper-9ce0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 930b64ca0c511521f0abdd1d57ce52b2a6e3476b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040838-january-snooper-9ce0@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 930b64ca0c511521f0abdd1d57ce52b2a6e3476b Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 6 Feb 2025 13:12:13 -0500
Subject: [PATCH] nfsd: don't ignore the return code of svc_proc_register()

Currently, nfsd_proc_stat_init() ignores the return value of
svc_proc_register(). If the procfile creation fails, then the kernel
will WARN when it tries to remove the entry later.

Fix nfsd_proc_stat_init() to return the same type of pointer as
svc_proc_register(), and fix up nfsd_net_init() to check that and fail
the nfsd_net construction if it occurs.

svc_proc_register() can fail if the dentry can't be allocated, or if an
identical dentry already exists. The second case is pretty unlikely in
the nfsd_net construction codepath, so if this happens, return -ENOMEM.

Reported-by: syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-nfs/67a47501.050a0220.19061f.05f9.GAE@google.com/
Cc: stable@vger.kernel.org # v6.9
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index cca60a33697f..ac265d6fde35 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2202,8 +2202,14 @@ static __net_init int nfsd_net_init(struct net *net)
 					  NFSD_STATS_COUNTERS_NUM);
 	if (retval)
 		goto out_repcache_error;
+
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
 	nn->nfsd_svcstats.program = &nfsd_programs[0];
+	if (!nfsd_proc_stat_init(net)) {
+		retval = -ENOMEM;
+		goto out_proc_error;
+	}
+
 	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
 		nn->nfsd_versions[i] = nfsd_support_version(i);
 	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
@@ -2213,13 +2219,14 @@ static __net_init int nfsd_net_init(struct net *net)
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
-	nfsd_proc_stat_init(net);
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	spin_lock_init(&nn->local_clients_lock);
 	INIT_LIST_HEAD(&nn->local_clients);
 #endif
 	return 0;
 
+out_proc_error:
+	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 out_repcache_error:
 	nfsd_idmap_shutdown(net);
 out_idmap_error:
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index bb22893f1157..f7eaf95e20fc 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -73,11 +73,11 @@ static int nfsd_show(struct seq_file *seq, void *v)
 
 DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
-void nfsd_proc_stat_init(struct net *net)
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
+	return svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
 void nfsd_proc_stat_shutdown(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 04aacb6c36e2..e4efb0e4e56d 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,7 +10,7 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-void nfsd_proc_stat_init(struct net *net);
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)


