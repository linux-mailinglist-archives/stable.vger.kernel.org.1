Return-Path: <stable+bounces-195325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B4BC7558E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0591A4F2D45
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45C12BDC27;
	Thu, 20 Nov 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHmxF9P6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E73587BD
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655144; cv=none; b=UJoOGi1AKysK4j0jQixslMvexsYp41WlxRcIFN10RfAn7I3GRt8eaje5oYQ9Whbj2XCESnaZvnRXsP3OMRsKJB0D1Wwhq48R0CdVmK/bbiDImfhg+zol60bUjeyL4uMs3sWWWCXNqyMjKb1iktt5F6Q8W2sH/dZXL/xkGBKhmI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655144; c=relaxed/simple;
	bh=viKC8V7jtmi5rWDVkIJSImGPLk1E4GVWiQoP69hq8NA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MTMDSLGCtHIS9N7jvVJNfVnmud+JLlKmPkBk3CCTakNYzS/qiQji43rPw413CzPtzZDZRwWCoY6HaAJDiWyMnDUMdROivcfJSUz/U0PU4BnhtdmPa7QjbcXwRG2Fj9n7G5pFR726V30sVvY8o9+/bBjueTBJPo62bofw/dyOR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHmxF9P6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE1AC4CEF1;
	Thu, 20 Nov 2025 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655142;
	bh=viKC8V7jtmi5rWDVkIJSImGPLk1E4GVWiQoP69hq8NA=;
	h=Subject:To:Cc:From:Date:From;
	b=zHmxF9P6wuO/w0y1OLkMjNHi+aoEeMk93dWNgrk9BvZzof4aQyX1KXCyLgfU0qDOY
	 6rcIWqvuxgh+RSPXsTqKlQcNft0mcNtxA1oSn3KD5lazaOkdHkb0KlquCxhozEjcXV
	 98Q/L0F1hFsowF3sXZIHMxWG/ngte98QWNUP8XDY=
Subject: FAILED: patch "[PATCH] fs/proc: fix uaf in proc_readdir_de()" failed to apply to 5.4-stable tree
To: albinwyang@tencent.com,adobriyan@gmail.com,akpm@linux-foundation.org,brauner@kernel.org,stable@vger.kernel.org,viro@zeniv.linux.org.uk,wangzijie1@honor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:12:19 +0100
Message-ID: <2025112019-mantra-unwind-1db7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 895b4c0c79b092d732544011c3cecaf7322c36a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112019-mantra-unwind-1db7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 895b4c0c79b092d732544011c3cecaf7322c36a1 Mon Sep 17 00:00:00 2001
From: Wei Yang <albinwyang@tencent.com>
Date: Sat, 25 Oct 2025 10:42:33 +0800
Subject: [PATCH] fs/proc: fix uaf in proc_readdir_de()

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

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 176281112273..501889856461 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -698,6 +698,12 @@ void pde_put(struct proc_dir_entry *pde)
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
@@ -720,7 +726,7 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 			WARN(1, "removing permanent /proc entry '%s'", de->name);
 			de = NULL;
 		} else {
-			rb_erase(&de->subdir_node, &parent->subdir);
+			pde_erase(de, parent);
 			if (S_ISDIR(de->mode))
 				parent->nlink--;
 		}
@@ -764,7 +770,7 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 			root->parent->name, root->name);
 		return -EINVAL;
 	}
-	rb_erase(&root->subdir_node, &parent->subdir);
+	pde_erase(root, parent);
 
 	de = root;
 	while (1) {
@@ -776,7 +782,7 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 					next->parent->name, next->name);
 				return -EINVAL;
 			}
-			rb_erase(&next->subdir_node, &de->subdir);
+			pde_erase(next, de);
 			de = next;
 			continue;
 		}


