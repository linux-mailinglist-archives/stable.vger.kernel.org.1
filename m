Return-Path: <stable+bounces-59180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C664D92F6B8
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 10:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17651F2162B
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 08:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477AB13D8BA;
	Fri, 12 Jul 2024 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nmTW7MVZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C413D899
	for <stable@vger.kernel.org>; Fri, 12 Jul 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771865; cv=none; b=iJDp/VXHAps6rMAf6yNDYlwvfbTzJImyOq8whS2YhmbphiQi8bUZAr7vVxWsKE6i1PTG85XAdpY/LS1UAbjEnLTcJ4j2sWdztcZtiYDKm2scGpOKtEczX99dgWbY3xv5cH7SPx4l6XOgmABmKiLR03+1xELFCQfqExvrxgLVQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771865; c=relaxed/simple;
	bh=i1+qZclYiOIInwUHzr+r2Hd+CoX3xcH06uERIYaiPJc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mOUne/0AUX+jeRKd6FpX6OUyTTvkmKJo2Af8ssDxw+FMGXU/Eq5cCG8n2ESJxIOuO4ctD8tJEHWafiEPNJIc1qkBCrp4fVNLNXFf+/Pm99Dy4VGDNe5a2X1zvmwIi+dSuG/+c8QJXqbr1M2BiiXzbd8mM0P/mxQR23wwL+oIwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nmTW7MVZ; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720771863; x=1752307863;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wpPd6LiFf6ZQVqiwLNKMA9gLj8OXIYXSqFUGbY2xP2Q=;
  b=nmTW7MVZR6FjHpS2nQ+snbyRIv/tMEgbeNCVbypHPjvl7lXBVBLRxhZX
   MlNyuM/xLjJBxObs2F7VHsI4UvGadSl6t02fT+30AheRVYUSBjQjLGID8
   ZpQr+CUd/SWE7yxHKarx2bTRKK6motYrGAbT/gpoHA/BWlBuu4e0ycBlp
   8=;
X-IronPort-AV: E=Sophos;i="6.09,202,1716249600"; 
   d="scan'208";a="105128984"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 08:10:58 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.44.209:20673]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.23.255:2525] with esmtp (Farcaster)
 id c2839147-7647-426e-af02-0585773b0ade; Fri, 12 Jul 2024 08:10:58 +0000 (UTC)
X-Farcaster-Flow-ID: c2839147-7647-426e-af02-0585773b0ade
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 12 Jul 2024 08:10:58 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 12 Jul 2024 08:10:58 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1258.34 via Frontend Transport; Fri, 12 Jul 2024 08:10:58
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id B341420D54; Fri, 12 Jul 2024 08:10:57 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, felix <fuzhen5@huawei.com>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Hagar Hemdan <hagarhem@amazon.com>
Subject: [PATCH 5.4] SUNRPC: Fix RPC client cleaned up the freed pipefs dentries
Date: Fri, 12 Jul 2024 08:10:56 +0000
Message-ID: <20240712081056.12721-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: felix <fuzhen5@huawei.com>

[ Upstream commit bfca5fb4e97c46503ddfc582335917b0cc228264 ]

RPC client pipefs dentries cleanup is in separated rpc_remove_pipedir()
workqueue,which takes care about pipefs superblock locking.
In some special scenarios, when kernel frees the pipefs sb of the
current client and immediately alloctes a new pipefs sb,
rpc_remove_pipedir function would misjudge the existence of pipefs
sb which is not the one it used to hold. As a result,
the rpc_remove_pipedir would clean the released freed pipefs dentries.

To fix this issue, rpc_remove_pipedir should check whether the
current pipefs sb is consistent with the original pipefs sb.

This error can be catched by KASAN:
=========================================================
[  250.497700] BUG: KASAN: slab-use-after-free in dget_parent+0x195/0x200
[  250.498315] Read of size 4 at addr ffff88800a2ab804 by task kworker/0:18/106503
[  250.500549] Workqueue: events rpc_free_client_work
[  250.501001] Call Trace:
[  250.502880]  kasan_report+0xb6/0xf0
[  250.503209]  ? dget_parent+0x195/0x200
[  250.503561]  dget_parent+0x195/0x200
[  250.503897]  ? __pfx_rpc_clntdir_depopulate+0x10/0x10
[  250.504384]  rpc_rmdir_depopulate+0x1b/0x90
[  250.504781]  rpc_remove_client_dir+0xf5/0x150
[  250.505195]  rpc_free_client_work+0xe4/0x230
[  250.505598]  process_one_work+0x8ee/0x13b0
...
[   22.039056] Allocated by task 244:
[   22.039390]  kasan_save_stack+0x22/0x50
[   22.039758]  kasan_set_track+0x25/0x30
[   22.040109]  __kasan_slab_alloc+0x59/0x70
[   22.040487]  kmem_cache_alloc_lru+0xf0/0x240
[   22.040889]  __d_alloc+0x31/0x8e0
[   22.041207]  d_alloc+0x44/0x1f0
[   22.041514]  __rpc_lookup_create_exclusive+0x11c/0x140
[   22.041987]  rpc_mkdir_populate.constprop.0+0x5f/0x110
[   22.042459]  rpc_create_client_dir+0x34/0x150
[   22.042874]  rpc_setup_pipedir_sb+0x102/0x1c0
[   22.043284]  rpc_client_register+0x136/0x4e0
[   22.043689]  rpc_new_client+0x911/0x1020
[   22.044057]  rpc_create_xprt+0xcb/0x370
[   22.044417]  rpc_create+0x36b/0x6c0
...
[   22.049524] Freed by task 0:
[   22.049803]  kasan_save_stack+0x22/0x50
[   22.050165]  kasan_set_track+0x25/0x30
[   22.050520]  kasan_save_free_info+0x2b/0x50
[   22.050921]  __kasan_slab_free+0x10e/0x1a0
[   22.051306]  kmem_cache_free+0xa5/0x390
[   22.051667]  rcu_core+0x62c/0x1930
[   22.051995]  __do_softirq+0x165/0x52a
[   22.052347]
[   22.052503] Last potentially related work creation:
[   22.052952]  kasan_save_stack+0x22/0x50
[   22.053313]  __kasan_record_aux_stack+0x8e/0xa0
[   22.053739]  __call_rcu_common.constprop.0+0x6b/0x8b0
[   22.054209]  dentry_free+0xb2/0x140
[   22.054540]  __dentry_kill+0x3be/0x540
[   22.054900]  shrink_dentry_list+0x199/0x510
[   22.055293]  shrink_dcache_parent+0x190/0x240
[   22.055703]  do_one_tree+0x11/0x40
[   22.056028]  shrink_dcache_for_umount+0x61/0x140
[   22.056461]  generic_shutdown_super+0x70/0x590
[   22.056879]  kill_anon_super+0x3a/0x60
[   22.057234]  rpc_kill_sb+0x121/0x200

Fixes: 0157d021d23a ("SUNRPC: handle RPC client pipefs dentries by network namespace aware routines")
Signed-off-by: felix <fuzhen5@huawei.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
---
 include/linux/sunrpc/clnt.h | 1 +
 net/sunrpc/clnt.c           | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 18d4cf2d637b..db22a87f3b0a 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -73,6 +73,7 @@ struct rpc_clnt {
 #endif
 	struct rpc_xprt_iter	cl_xpi;
 	const struct cred	*cl_cred;
+	struct super_block *pipefs_sb;
 };
 
 /*
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index dc3226edf22f..2e08876bf856 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -113,7 +113,8 @@ static void rpc_clnt_remove_pipedir(struct rpc_clnt *clnt)
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
-		__rpc_clnt_remove_pipedir(clnt);
+		if (pipefs_sb == clnt->pipefs_sb)
+			__rpc_clnt_remove_pipedir(clnt);
 		rpc_put_sb_net(net);
 	}
 }
@@ -153,6 +154,8 @@ rpc_setup_pipedir(struct super_block *pipefs_sb, struct rpc_clnt *clnt)
 {
 	struct dentry *dentry;
 
+	clnt->pipefs_sb = pipefs_sb;
+
 	if (clnt->cl_program->pipe_dir_name != NULL) {
 		dentry = rpc_setup_pipedir_sb(pipefs_sb, clnt);
 		if (IS_ERR(dentry))
-- 
2.40.1


