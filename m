Return-Path: <stable+bounces-167146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8EB22627
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD5D54E282D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A622EF648;
	Tue, 12 Aug 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WeE+v3a+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067A2EE285
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999554; cv=none; b=o2K8cBz8jG6y92Ilo4hLiQ/wzUm4jnzd9+6vHXZttQwxCtTEyCJOwF3ifwzyTXZ+5iqD8YQkN1GwbZHS/IfBEGILthS2spz8g/krSNolYX8FGXpCfUJa/v3ypZyUxg3+YjXHS0Z+n2nTiERt1Q0hMH6eI0QazqKjuN8V4FccNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999554; c=relaxed/simple;
	bh=UOU3En5IFH/q0JNnwzyVh7IxEt6bQGNlPkTOF1VZooQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rn0TUxf7ONNOSgp5/NFBTuC7csXzDsiT2IgYeSWGHccnH4LTuYkAfjhSmmy7keadI0s6txxbAeVOUG+bLBZavInV39vG/Ta6aKkXnYOMmfuKxxLjGPPmPZrS7lO0n5qdxQMpRGPYvyBWHQJBSfxKBapJ/B0cNUv33DV6ibyuiC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WeE+v3a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA73C4CEF6;
	Tue, 12 Aug 2025 11:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754999553;
	bh=UOU3En5IFH/q0JNnwzyVh7IxEt6bQGNlPkTOF1VZooQ=;
	h=Subject:To:Cc:From:Date:From;
	b=WeE+v3a+6qEKDoBqFCPjhcd3SOE1yMhrU9duVJSoKKgMME+A2d/toNLzUXvIRdoZO
	 v4eRf9J4FgnFQ1IPkXIOK3P7j3r4dL38k30RQEUqRswRWuj5PbUNVMhJY42YhB28ma
	 w9NX/16aASiwSASN3W1SQJ66tjmF4uYkrGsAO5xE=
Subject: FAILED: patch "[PATCH] smb: client: fix netns refcount leak after net_passive" failed to apply to 6.12-stable tree
To: wangzhaolong@huaweicloud.com,ematsumiya@suse.de,kuniyu@google.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 13:52:30 +0200
Message-ID: <2025081230-dentist-cautious-7bb4@gregkh>
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
git cherry-pick -x 59b33fab4ca4d7dacc03367082777627e05d0323
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081230-dentist-cautious-7bb4@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59b33fab4ca4d7dacc03367082777627e05d0323 Mon Sep 17 00:00:00 2001
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Date: Thu, 17 Jul 2025 21:29:26 +0800
Subject: [PATCH] smb: client: fix netns refcount leak after net_passive
 changes

After commit 5c70eb5c593d ("net: better track kernel sockets lifetime"),
kernel sockets now use net_passive reference counting. However, commit
95d2b9f693ff ("Revert "smb: client: fix TCP timers deadlock after rmmod"")
restored the manual socket refcount manipulation without adapting to this
new mechanism, causing a memory leak.

The issue can be reproduced by[1]:
1. Creating a network namespace
2. Mounting and Unmounting CIFS within the namespace
3. Deleting the namespace

Some memory leaks may appear after a period of time following step 3.

unreferenced object 0xffff9951419f6b00 (size 256):
  comm "ip", pid 447, jiffies 4294692389 (age 14.730s)
  hex dump (first 32 bytes):
    1b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 80 77 c2 44 51 99 ff ff  .........w.DQ...
  backtrace:
    __kmem_cache_alloc_node+0x30e/0x3d0
    __kmalloc+0x52/0x120
    net_alloc_generic+0x1d/0x30
    copy_net_ns+0x86/0x200
    create_new_namespaces+0x117/0x300
    unshare_nsproxy_namespaces+0x60/0xa0
    ksys_unshare+0x148/0x360
    __x64_sys_unshare+0x12/0x20
    do_syscall_64+0x59/0x110
    entry_SYSCALL_64_after_hwframe+0x78/0xe2
...
unreferenced object 0xffff9951442e7500 (size 32):
  comm "mount.cifs", pid 475, jiffies 4294693782 (age 13.343s)
  hex dump (first 32 bytes):
    40 c5 38 46 51 99 ff ff 18 01 96 42 51 99 ff ff  @.8FQ......BQ...
    01 00 00 00 6f 00 c5 07 6f 00 d8 07 00 00 00 00  ....o...o.......
  backtrace:
    __kmem_cache_alloc_node+0x30e/0x3d0
    kmalloc_trace+0x2a/0x90
    ref_tracker_alloc+0x8e/0x1d0
    sk_alloc+0x18c/0x1c0
    inet_create+0xf1/0x370
    __sock_create+0xd7/0x1e0
    generic_ip_connect+0x1d4/0x5a0 [cifs]
    cifs_get_tcp_session+0x5d0/0x8a0 [cifs]
    cifs_mount_get_session+0x47/0x1b0 [cifs]
    dfs_mount_share+0xfa/0xa10 [cifs]
    cifs_mount+0x68/0x2b0 [cifs]
    cifs_smb3_do_mount+0x10b/0x760 [cifs]
    smb3_get_tree+0x112/0x2e0 [cifs]
    vfs_get_tree+0x29/0xf0
    path_mount+0x2d4/0xa00
    __se_sys_mount+0x165/0x1d0

Root cause:
When creating kernel sockets, sk_alloc() calls net_passive_inc() for
sockets with sk_net_refcnt=0. The CIFS code manually converts kernel
sockets to user sockets by setting sk_net_refcnt=1, but doesn't call
the corresponding net_passive_dec(). This creates an imbalance in the
net_passive counter, which prevents the network namespace from being
destroyed when its last user reference is dropped. As a result, the
entire namespace and all its associated resources remain allocated.

Timeline of patches leading to this issue:
- commit ef7134c7fc48 ("smb: client: Fix use-after-free of network
  namespace.") in v6.12 fixed the original netns UAF by manually
  managing socket refcounts
- commit e9f2517a3e18 ("smb: client: fix TCP timers deadlock after
  rmmod") in v6.13 attempted to use kernel sockets but introduced
  TCP timer issues
- commit 5c70eb5c593d ("net: better track kernel sockets lifetime")
  in v6.14-rc5 introduced the net_passive mechanism with
  sk_net_refcnt_upgrade() for proper socket conversion
- commit 95d2b9f693ff ("Revert "smb: client: fix TCP timers deadlock
  after rmmod"") in v6.15-rc3 reverted to manual refcount management
  without adapting to the new net_passive changes

Fix this by using sk_net_refcnt_upgrade() which properly handles the
net_passive counter when converting kernel sockets to user sockets.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220343 [1]
Fixes: 95d2b9f693ff ("Revert "smb: client: fix TCP timers deadlock after rmmod"")
Cc: stable@vger.kernel.org
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 205f547ca49e..5eec8957f2a9 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3362,18 +3362,15 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		struct net *net = cifs_net_ns(server);
 		struct sock *sk;
 
-		rc = __sock_create(net, sfamily, SOCK_STREAM,
-				   IPPROTO_TCP, &server->ssocket, 1);
+		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
+				      IPPROTO_TCP, &server->ssocket);
 		if (rc < 0) {
 			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
 			return rc;
 		}
 
 		sk = server->ssocket->sk;
-		__netns_tracker_free(net, &sk->ns_tracker, false);
-		sk->sk_net_refcnt = 1;
-		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
+		sk_net_refcnt_upgrade(sk);
 
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
 		cifs_dbg(FYI, "Socket created\n");


