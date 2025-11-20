Return-Path: <stable+bounces-195420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64910C76310
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 21:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6812328F57
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C00272E6D;
	Thu, 20 Nov 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF0cSBrU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0D36D511
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670201; cv=none; b=o5yCeXFPrwgTA2bM+EVk06gJ4A9qQgCToBV1RxGvGLOzALMcSPVfAMQAPUPV0JexI7C36opEoMBT6fdlufrFYw0aQtKZEm5ACLwoOvuUnFUl8AfuixrdbTx2T/aKGNNLqhvUp1Wt/GAMg7oYJo8cRAprUbML4m7m+nyaxzIHj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670201; c=relaxed/simple;
	bh=9oXKKf6bMIAszvdTeriKX/qVxVbYKuAMcrnlrs+kMm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz4CN3JhXAG+zS5r05Fvxibrj2IQ4d5n4Li/JJVXvjh5tYyepg7pBYwdSQVNNmBlB+UMYb3cAJKrEX1fkfBXcI3iUUy3fYdXgcQJWiHN4s5gA4phIJxzS7YwDNQxItqHqRA2KYs9ETvBi/XZwdR1rbUclk/obaMMtlfeDP+B/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF0cSBrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8625C4CEF1;
	Thu, 20 Nov 2025 20:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763670201;
	bh=9oXKKf6bMIAszvdTeriKX/qVxVbYKuAMcrnlrs+kMm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dF0cSBrUEOt8GHqH6WG9EmOsSKLShe98fFgUfNZa/BS7lbZTT/rC+hpQtMhNaKiT4
	 jq0Lf4+AfVBd5hyfzfcXhmAFEiYcevE+Jx9sot54I5kCvW8uQrWJUsxNEAqs52GuRr
	 ul52+qI6F0yDPPJdaxvC72QCU8moxdlE3YK35d7qyvswgP8rvYjqYm+wYSqFmb/5kq
	 m2Z+DNKEzTytSPsoyizulVFxplJoDaWGC/L4WI9V1kNjMPaFqDnlIg5WOSXuRFdgF+
	 WANhaScC8ndCG+4SFXBB8iUcC8j5mbdBLobWLRxdYFtFMCpn8OnBs6+HXT1bXibig1
	 nVXdC6MMohhiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wei Yang <albinwyang@tencent.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	wangzijie <wangzijie1@honor.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] fs/proc: fix uaf in proc_readdir_de()
Date: Thu, 20 Nov 2025 15:23:17 -0500
Message-ID: <20251120202317.2307846-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112019-mantra-unwind-1db7@gregkh>
References: <2025112019-mantra-unwind-1db7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Yang <albinwyang@tencent.com>

[ Upstream commit 895b4c0c79b092d732544011c3cecaf7322c36a1 ]

Pde is erased from subdir rbtree through rb_erase(), but not set the node
to EMPTY, which may result in uaf access.  We should use RB_CLEAR_NODE()
set the erased node to EMPTY, then pde_subdir_next() will return NULL to
avoid uaf access.

We found an uaf issue while using stress-ng testing, need to run testcase
getdent and tun in the same time.  The steps of the issue is as follows:

1) use getdent to traverse dir /proc/pid/net/dev_snmp6/, and current
   pde is tun3;

2) in the [time windows] unregister netdevice tun3 and tun2, and erase
   them from rbtree.  erase tun3 first, and then erase tun2.  the
   pde(tun2) will be released to slab;

3) continue to getdent process, then pde_subdir_next() will return
   pde(tun2) which is released, it will case uaf access.

CPU 0                                      |    CPU 1
-------------------------------------------------------------------------
traverse dir /proc/pid/net/dev_snmp6/      |   unregister_netdevice(tun->dev)   //tun3 tun2
sys_getdents64()                           |
  iterate_dir()                            |
    proc_readdir()                         |
      proc_readdir_de()                    |     snmp6_unregister_dev()
        pde_get(de);                       |       proc_remove()
        read_unlock(&proc_subdir_lock);    |         remove_proc_subtree()
                                           |           write_lock(&proc_subdir_lock);
        [time window]                      |           rb_erase(&root->subdir_node, &parent->subdir);
                                           |           write_unlock(&proc_subdir_lock);
        read_lock(&proc_subdir_lock);      |
        next = pde_subdir_next(de);        |
        pde_put(de);                       |
        de = next;    //UAF                |

rbtree of dev_snmp6
                        |
                    pde(tun3)
                     /    \
                  NULL  pde(tun2)

Link: https://lkml.kernel.org/r/20251025024233.158363-1-albin_yang@163.com
Signed-off-by: Wei Yang <albinwyang@tencent.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: wangzijie <wangzijie1@honor.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/generic.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 372b4dad4863e..c4a7d96787f36 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -671,6 +671,12 @@ void pde_put(struct proc_dir_entry *pde)
 	}
 }
 
+static void pde_erase(struct proc_dir_entry *pde, struct proc_dir_entry *parent)
+{
+	rb_erase(&pde->subdir_node, &parent->subdir);
+	RB_CLEAR_NODE(&pde->subdir_node);
+}
+
 /*
  * Remove a /proc entry and free it if it's not currently in use.
  */
@@ -689,7 +695,7 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 
 	de = pde_subdir_find(parent, fn, len);
 	if (de) {
-		rb_erase(&de->subdir_node, &parent->subdir);
+		pde_erase(de, parent);
 		if (S_ISDIR(de->mode)) {
 			parent->nlink--;
 		}
@@ -727,13 +733,13 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 		write_unlock(&proc_subdir_lock);
 		return -ENOENT;
 	}
-	rb_erase(&root->subdir_node, &parent->subdir);
+	pde_erase(root, parent);
 
 	de = root;
 	while (1) {
 		next = pde_subdir_first(de);
 		if (next) {
-			rb_erase(&next->subdir_node, &de->subdir);
+			pde_erase(next, de);
 			de = next;
 			continue;
 		}
-- 
2.51.0


