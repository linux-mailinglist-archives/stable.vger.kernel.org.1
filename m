Return-Path: <stable+bounces-196628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F82C7EC9F
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 03:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1CE54E12DC
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 02:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF5C1F75A6;
	Mon, 24 Nov 2025 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fO3NIb4z"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A232773E5
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763949688; cv=none; b=EIpIKG5bl/X/G+VkGp8gXAt4EW+8F158nQPuaZOD+qxN4v5RIBdlf8j8nLEuxMRAufA0yG0wBU7EWqqBEY5vsTXay6T4rni1q9HMa5+gCJUPhZvPYQL++Rm1/vdveljXT7GvFEh4+L0W6aNSp+8yQ1dRFiy1dmMGTvpb6fNDwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763949688; c=relaxed/simple;
	bh=ePPHzttxtik95F3nS4r4z9ClMa/6fywbOWwr2h2l3xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq/nOIyyGsRGznzyY7f5uQbjFYIV9K7lV/HEoByWokHSYkiIkZpxDBgJPbY3ACDrw8b0hw7lYf4ZRK2M5IYA6y6kJll9i8sM8AHqcfFtZjUUB3WiNFTuGAEZ20g0+WgYh6seAqV9AiBerW7nOOjB7PTqME8z+RUK2MyIm8lKfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fO3NIb4z; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=R/
	JDXUTpQvMZDqeGofu0opaBpaPUW/UFCx5k7xDJb88=; b=fO3NIb4zre8zEwIdv5
	/ePCEdY1/q7G7Q7lHaFtv8EsOdtPxXUtU/ppuxN35UOUVMHB7OA8UavO+U+KqduI
	FuDaxbXZWSw+YixjbRPZv67RTXvJhCKPEEac+HrT3gF2SrkSB4wLQ/n7GcThiEZs
	TjMXiduhoRVjSCUlFkL/nrh+M=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAHLsVQvCNp21jrEw--.57363S2;
	Mon, 24 Nov 2025 10:00:50 +0800 (CST)
From: albin_yang@163.com
To: stable@vger.kernel.org
Cc: Wei Yang <albinwyang@tencent.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	wangzijie <wangzijie1@honor.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4.y] fs/proc: fix uaf in proc_readdir_de()
Date: Mon, 24 Nov 2025 10:00:27 +0800
Message-ID: <20251124020027.1695168-1-albin_yang@163.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2025112019-mantra-unwind-1db7@gregkh>
References: <2025112019-mantra-unwind-1db7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAHLsVQvCNp21jrEw--.57363S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1UCFWxCw1xuw13Xr43KFg_yoW5ZFW5pF
	Wa9rW3Gr48WFn8Grn3tr1UCF18uF15Aayakr47Cw4SyrsxZryxJF4SqFySgFy7AFy8Ga4a
	qr4jg3srArykA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7Z2-UUUUU=
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/xtbCzRNmCWkjvFO+PwAA3V

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


