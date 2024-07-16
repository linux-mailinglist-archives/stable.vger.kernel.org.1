Return-Path: <stable+bounces-59557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F46932AAF
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7D81F22EB9
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D21DA4D;
	Tue, 16 Jul 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KsBDqLUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65725D53B;
	Tue, 16 Jul 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144212; cv=none; b=u3uJhaeRWT8nxFSO2Ra2hMEDUMbS+U8PYGIj+AkOeSSvs1Vtsh61hgdSf1iCVsjaJ0xXI1edGDJHUoZ9/0gMSVg9WH0GiT+IqaJbvxp6U+Tcpc6nWsB4XcqCC8VpcoD1+RwIZvnNYgPvgEfgEKE4MgIzvqoceZiLTh7gluQP5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144212; c=relaxed/simple;
	bh=MOSwC4F7FvcyOfbq5MhObB2L8KTbonNTVXkc/s52HdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRvXuPK56x32D73ZoURyqG/02xfO6i4o1kcOMWt42tU4WSg28Nrr3Bp4UXUMS5PPhzwGMthepWf+oiyhy7ouUy9FC8Vx/YzWlZdnVG6HUi4gDEFF30KSKNn0hStmOwQuwE8MjBGDU0D1cqsfTHy/i26PcLSaWFGswHrONlcKzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KsBDqLUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D74C116B1;
	Tue, 16 Jul 2024 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144212;
	bh=MOSwC4F7FvcyOfbq5MhObB2L8KTbonNTVXkc/s52HdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KsBDqLUmN7oQ8sgUAS/mQM4woc0h9rxo4w1OZ11rKOSVwtgltTqZ0YNBSODGf/aBh
	 SnwMVj6Brn8PwQdI/paK7mmnj9LA5LiX5yCiDKMlkd0ulI9TglqlGocrLdZf3fiZX1
	 K+LYx6oiBOCsyYOcUlPf/I+B61A1ezAu9Mi3EBG8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	felix <fuzhen5@huawei.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Hagar Hemdan <hagarhem@amazon.com>
Subject: [PATCH 4.19 64/66] SUNRPC: Fix RPC client cleaned up the freed pipefs dentries
Date: Tue, 16 Jul 2024 17:31:39 +0200
Message-ID: <20240716152740.609537536@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
References: <20240716152738.161055634@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: felix <fuzhen5@huawei.com>

commit bfca5fb4e97c46503ddfc582335917b0cc228264 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/sunrpc/clnt.h |    1 +
 net/sunrpc/clnt.c           |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -70,6 +70,7 @@ struct rpc_clnt {
 	struct dentry		*cl_debugfs;	/* debugfs directory */
 #endif
 	struct rpc_xprt_iter	cl_xpi;
+	struct super_block *pipefs_sb;
 };
 
 /*
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -112,7 +112,8 @@ static void rpc_clnt_remove_pipedir(stru
 
 	pipefs_sb = rpc_get_sb_net(net);
 	if (pipefs_sb) {
-		__rpc_clnt_remove_pipedir(clnt);
+		if (pipefs_sb == clnt->pipefs_sb)
+			__rpc_clnt_remove_pipedir(clnt);
 		rpc_put_sb_net(net);
 	}
 }
@@ -152,6 +153,8 @@ rpc_setup_pipedir(struct super_block *pi
 {
 	struct dentry *dentry;
 
+	clnt->pipefs_sb = pipefs_sb;
+
 	if (clnt->cl_program->pipe_dir_name != NULL) {
 		dentry = rpc_setup_pipedir_sb(pipefs_sb, clnt);
 		if (IS_ERR(dentry))



