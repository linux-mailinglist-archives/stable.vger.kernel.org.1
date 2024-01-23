Return-Path: <stable+bounces-15225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C261483847A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEDF1B2C34C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17F46D1C1;
	Tue, 23 Jan 2024 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vxkGKVBG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4566A354;
	Tue, 23 Jan 2024 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975382; cv=none; b=dFJ7Rmy+EawErkcAHazEASOCAR+d/WkS8T2KUqJaCkQw2MhjenGFe5yTRb8KUqED1qM4V78K3HYYh5yqQsSxsap9eOAn4IgXX5pAuc7Ubz4/k1cs5LmhxDuAlWb/uBISu02uq8UefZiFJjrrjTKCXBswsiDFWo99Mn3e48Dgywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975382; c=relaxed/simple;
	bh=o2cI1DGo/5CkxoqpiqQX2+iEmv7YZ6nBeHeNeqtR45U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb2gtp1zs3qN4e0L8r7Awm/OJFD8PvCqfvEr4Obn5G29r/h4UxxD8K5V8zUknQbG8G5ZZzIIyJmRDoOKGa12EIpO4nHSTXOOWWUij7d/Bzg34kzUQPZey9Ckau1IIWrACCX3LqwAlhiyNvfK4wJeYWXBuDxWGit33pvFVJpi1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vxkGKVBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70367C433C7;
	Tue, 23 Jan 2024 02:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975382;
	bh=o2cI1DGo/5CkxoqpiqQX2+iEmv7YZ6nBeHeNeqtR45U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vxkGKVBG6ZXPNNT/Tqcex+wc2s4Zo88mtVLjDmeIgDBNo0XfNclP4Hl5ATIBlZhyJ
	 baxlhN5txcSoAHSIwhYuF0x88LNDUAD3JCp2lcuoZQy0Z7aec6OBuCAbtId8jR+Uws
	 3yweiVAyGxTd9zn5IeE4W982ZoGufEoAL3UpcRIQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <andrea.righi@canonical.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 6.6 343/583] Revert "kernfs: convert kernfs_idr_lock to an irq safe raw spinlock"
Date: Mon, 22 Jan 2024 15:56:34 -0800
Message-ID: <20240122235822.522796512@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit e3977e0609a07d86406029fceea0fd40d7849368 upstream.

This reverts commit dad3fb67ca1cbef87ce700e83a55835e5921ce8a.

The commit converted kernfs_idr_lock to an IRQ-safe raw_spinlock because it
could be acquired while holding an rq lock through bpf_cgroup_from_id().
However, kernfs_idr_lock is held while doing GPF_NOWAIT allocations which
involves acquiring an non-IRQ-safe and non-raw lock leading to the following
lockdep warning:

  =============================
  [ BUG: Invalid wait context ]
  6.7.0-rc5-kzm9g-00251-g655022a45b1c #578 Not tainted
  -----------------------------
  swapper/0/0 is trying to lock:
  dfbcd488 (&c->lock){....}-{3:3}, at: local_lock_acquire+0x0/0xa4
  other info that might help us debug this:
  context-{5:5}
  2 locks held by swapper/0/0:
   #0: dfbc9c60 (lock){+.+.}-{3:3}, at: local_lock_acquire+0x0/0xa4
   #1: c0c012a8 (kernfs_idr_lock){....}-{2:2}, at: __kernfs_new_node.constprop.0+0x68/0x258
  stack backtrace:
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc5-kzm9g-00251-g655022a45b1c #578
  Hardware name: Generic SH73A0 (Flattened Device Tree)
   unwind_backtrace from show_stack+0x10/0x14
   show_stack from dump_stack_lvl+0x68/0x90
   dump_stack_lvl from __lock_acquire+0x3cc/0x168c
   __lock_acquire from lock_acquire+0x274/0x30c
   lock_acquire from local_lock_acquire+0x28/0xa4
   local_lock_acquire from ___slab_alloc+0x234/0x8a8
   ___slab_alloc from __slab_alloc.constprop.0+0x30/0x44
   __slab_alloc.constprop.0 from kmem_cache_alloc+0x7c/0x148
   kmem_cache_alloc from radix_tree_node_alloc.constprop.0+0x44/0xdc
   radix_tree_node_alloc.constprop.0 from idr_get_free+0x110/0x2b8
   idr_get_free from idr_alloc_u32+0x9c/0x108
   idr_alloc_u32 from idr_alloc_cyclic+0x50/0xb8
   idr_alloc_cyclic from __kernfs_new_node.constprop.0+0x88/0x258
   __kernfs_new_node.constprop.0 from kernfs_create_root+0xbc/0x154
   kernfs_create_root from sysfs_init+0x18/0x5c
   sysfs_init from mnt_init+0xc4/0x220
   mnt_init from vfs_caches_init+0x6c/0x88
   vfs_caches_init from start_kernel+0x474/0x528
   start_kernel from 0x0

Let's rever the commit. It's undesirable to spread out raw spinlock usage
anyway and the problem can be solved by protecting the lookup path with RCU
instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <andrea.righi@canonical.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: http://lkml.kernel.org/r/CAMuHMdV=AKt+mwY7svEq5gFPx41LoSQZ_USME5_MEdWQze13ww@mail.gmail.com
Link: https://lore.kernel.org/r/20240109214828.252092-2-tj@kernel.org
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -27,7 +27,7 @@ static DEFINE_RWLOCK(kernfs_rename_lock)
  */
 static DEFINE_SPINLOCK(kernfs_pr_cont_lock);
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by pr_cont_lock */
-static DEFINE_RAW_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
+static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
 
@@ -539,7 +539,6 @@ void kernfs_put(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent;
 	struct kernfs_root *root;
-	unsigned long flags;
 
 	if (!kn || !atomic_dec_and_test(&kn->count))
 		return;
@@ -564,9 +563,9 @@ void kernfs_put(struct kernfs_node *kn)
 		simple_xattrs_free(&kn->iattr->xattrs, NULL);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
-	raw_spin_lock_irqsave(&kernfs_idr_lock, flags);
+	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
-	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
+	spin_unlock(&kernfs_idr_lock);
 	kmem_cache_free(kernfs_node_cache, kn);
 
 	kn = parent;
@@ -608,7 +607,6 @@ static struct kernfs_node *__kernfs_new_
 	struct kernfs_node *kn;
 	u32 id_highbits;
 	int ret;
-	unsigned long irqflags;
 
 	name = kstrdup_const(name, GFP_KERNEL);
 	if (!name)
@@ -619,13 +617,13 @@ static struct kernfs_node *__kernfs_new_
 		goto err_out1;
 
 	idr_preload(GFP_KERNEL);
-	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
+	spin_lock(&kernfs_idr_lock);
 	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
 	if (ret >= 0 && ret < root->last_id_lowbits)
 		root->id_highbits++;
 	id_highbits = root->id_highbits;
 	root->last_id_lowbits = ret;
-	raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);
+	spin_unlock(&kernfs_idr_lock);
 	idr_preload_end();
 	if (ret < 0)
 		goto err_out2;
@@ -661,9 +659,9 @@ static struct kernfs_node *__kernfs_new_
 	return kn;
 
  err_out3:
-	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
+	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
-	raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);
+	spin_unlock(&kernfs_idr_lock);
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
@@ -704,9 +702,8 @@ struct kernfs_node *kernfs_find_and_get_
 	struct kernfs_node *kn;
 	ino_t ino = kernfs_id_ino(id);
 	u32 gen = kernfs_id_gen(id);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&kernfs_idr_lock, flags);
+	spin_lock(&kernfs_idr_lock);
 
 	kn = idr_find(&root->ino_idr, (u32)ino);
 	if (!kn)
@@ -730,10 +727,10 @@ struct kernfs_node *kernfs_find_and_get_
 	if (unlikely(!__kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
-	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
+	spin_unlock(&kernfs_idr_lock);
 	return kn;
 err_unlock:
-	raw_spin_unlock_irqrestore(&kernfs_idr_lock, flags);
+	spin_unlock(&kernfs_idr_lock);
 	return NULL;
 }
 



