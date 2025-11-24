Return-Path: <stable+bounces-196627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9489CC7EC7B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 02:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39D7B4E0356
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 01:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974BA239E9A;
	Mon, 24 Nov 2025 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cax5l+gS"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0919E839
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763949334; cv=none; b=EjSNF3axRtG0OvY4iQvUkkWnQor3bqSpr6ztjAJZ5zKs6iuwWVFTAxoxxqIrlyURaH4CIgQKm3awn3exWOGdWlK6ftC8JR5okVjaJDV6BOEFjZjLMJitDm6qzaPRYEVjyBbqljipAfMPmxtSl1EslIN3mp1Up6m+Yjcx4DN2eZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763949334; c=relaxed/simple;
	bh=ePPHzttxtik95F3nS4r4z9ClMa/6fywbOWwr2h2l3xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gb9jpZuKVuHVHomJDaDNSAzkk0IrwEQkPHcFs2LPLFaVbOrb1m1xs2Q+yVCKVVFojqy4Up2wK0rQHclLj0AracoHCJTSCaPgcfxjpy9gLQaE4jwiXLxxQCUutpkyON1JEZUWqUKbOGLmE2DsiHw0wOs7jm54Edyd2KZ1PvL9NYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cax5l+gS; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=R/
	JDXUTpQvMZDqeGofu0opaBpaPUW/UFCx5k7xDJb88=; b=cax5l+gSiS62+C5LCU
	27cyPOE0L7dUxvo093tmBTTIZpPwhWeJ9QftmKiwrhipQ3ZHqtEnS4gX9BtzJwMN
	lwbrHvuleXaHBxGDsgjdHfjQ1/0IHLizWQi4l1vnhx42k3MGTDcJzXYSXW82uFni
	oYYyLRT82RmPATL4j7QFDOX0A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3n37fuiNp34qFCQ--.1413S2;
	Mon, 24 Nov 2025 09:54:40 +0800 (CST)
From: albin_yang@163.com
To: albin_yang@163.com
Cc: Wei Yang <albinwyang@tencent.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	wangzijie <wangzijie1@honor.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4.y] fs/proc: fix uaf in proc_readdir_de()
Date: Mon, 24 Nov 2025 09:54:32 +0800
Message-ID: <20251124015432.1692016-1-albin_yang@163.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n37fuiNp34qFCQ--.1413S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1UCFWxCw1xuw13Xr43KFg_yoW5ZFW5pF
	Wa9rW3Gr48WFn8Grn3tr1UCF18uF15Aayakr47Cw4SyrsxZryxJF4SqFySgFy7AFy8Ga4a
	qr4jg3srArykA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMKZG-UUUUU=
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/1tbiYBkQomkjuKtPhAAAsZ

From: Wei Yang <albinwyang@tencent.com>

commit 895b4c0c79b092d732544011c3cecaf7322c36a1 upstream.

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
---
 fs/proc/generic.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 372b4dad4863..c4a7d96787f3 100644
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
2.43.7


