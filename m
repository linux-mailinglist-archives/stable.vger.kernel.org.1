Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900207B88F0
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbjJDSVM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbjJDSVL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:21:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E6098
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:21:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F692C433C8;
        Wed,  4 Oct 2023 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443667;
        bh=YaAm3MmlE6cjj4OvhDvVI41xF5vM/i6JPWwOHcmilp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5LbNNf7oR1F8NKD4sQut9jp4fvBWCUFN5n5def6uCn0z8OGTnYfUASnUBHw4MgNV
         kbU0TtGPvsJUkR4hm/ENt3k1+PNiL73i1BFsaQUVWw2c4yM6z6WrZyAuM00r8r/qD4
         4y5nbqlPyDr4N0J9Ea2D+jFdd+n3rXTbjN0sYdEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 6.1 237/259] mm/slab_common: fix slab_caches list corruption after kmem_cache_destroy()
Date:   Wed,  4 Oct 2023 19:56:50 +0200
Message-ID: <20231004175228.248443969@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael Aquini <aquini@redhat.com>

commit 46a9ea6681907a3be6b6b0d43776dccc62cad6cf upstream.

After the commit in Fixes:, if a module that created a slab cache does not
release all of its allocated objects before destroying the cache (at rmmod
time), we might end up releasing the kmem_cache object without removing it
from the slab_caches list thus corrupting the list as kmem_cache_destroy()
ignores the return value from shutdown_cache(), which in turn never removes
the kmem_cache object from slabs_list in case __kmem_cache_shutdown() fails
to release all of the cache's slabs.

This is easily observable on a kernel built with CONFIG_DEBUG_LIST=y
as after that ill release the system will immediately trip on list_add,
or list_del, assertions similar to the one shown below as soon as another
kmem_cache gets created, or destroyed:

  [ 1041.213632] list_del corruption. next->prev should be ffff89f596fb5768, but was 52f1e5016aeee75d. (next=ffff89f595a1b268)
  [ 1041.219165] ------------[ cut here ]------------
  [ 1041.221517] kernel BUG at lib/list_debug.c:62!
  [ 1041.223452] invalid opcode: 0000 [#1] PREEMPT SMP PTI
  [ 1041.225408] CPU: 2 PID: 1852 Comm: rmmod Kdump: loaded Tainted: G    B   W  OE      6.5.0 #15
  [ 1041.228244] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc37 05/24/2023
  [ 1041.231212] RIP: 0010:__list_del_entry_valid+0xae/0xb0

Another quick way to trigger this issue, in a kernel with CONFIG_SLUB=y,
is to set slub_debug to poison the released objects and then just run
cat /proc/slabinfo after removing the module that leaks slab objects,
in which case the kernel will panic:

  [   50.954843] general protection fault, probably for non-canonical address 0xa56b6b6b6b6b6b8b: 0000 [#1] PREEMPT SMP PTI
  [   50.961545] CPU: 2 PID: 1495 Comm: cat Kdump: loaded Tainted: G    B   W  OE      6.5.0 #15
  [   50.966808] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc37 05/24/2023
  [   50.972663] RIP: 0010:get_slabinfo+0x42/0xf0

This patch fixes this issue by properly checking shutdown_cache()'s
return value before taking the kmem_cache_release() branch.

Fixes: 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock")
Signed-off-by: Rafael Aquini <aquini@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slab_common.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -474,7 +474,7 @@ void slab_kmem_cache_release(struct kmem
 
 void kmem_cache_destroy(struct kmem_cache *s)
 {
-	int refcnt;
+	int err = -EBUSY;
 	bool rcu_set;
 
 	if (unlikely(!s) || !kasan_check_byte(s))
@@ -485,17 +485,17 @@ void kmem_cache_destroy(struct kmem_cach
 
 	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
 
-	refcnt = --s->refcount;
-	if (refcnt)
+	s->refcount--;
+	if (s->refcount)
 		goto out_unlock;
 
-	WARN(shutdown_cache(s),
-	     "%s %s: Slab cache still has objects when called from %pS",
+	err = shutdown_cache(s);
+	WARN(err, "%s %s: Slab cache still has objects when called from %pS",
 	     __func__, s->name, (void *)_RET_IP_);
 out_unlock:
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
-	if (!refcnt && !rcu_set)
+	if (!err && !rcu_set)
 		kmem_cache_release(s);
 }
 EXPORT_SYMBOL(kmem_cache_destroy);


