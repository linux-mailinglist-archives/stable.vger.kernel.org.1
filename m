Return-Path: <stable+bounces-60615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A709378B0
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F66A1F22574
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 13:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8113D501;
	Fri, 19 Jul 2024 13:46:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B928288F
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396785; cv=none; b=m/ycM/WpjUfEgA2aRTONLr51S9FplOFgjtBHSbZtdhoJewzGXFja+pUX6+Fe9y9AAoEzbIeel5CNCptfB9JMisDXGNpHSQqfwf3tW+eNRWuZNTbuBzuXqjqphVsdICyLjdsL7Bllgooncl4VffUgqMwUyJUcU5R6x7OQ4Bn9PUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396785; c=relaxed/simple;
	bh=pCDocoJMBIa+8SDU6j+wXnId+Tyrf+kDprOvFmHaMCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CG4izWCBANhGEQaUoPzeHkFBedZ7uWsett5E1ysN2Jo8G39nUnhMlcr9QJQTH28fHgt3n+p1h1o9Aa0U9d3JNN57KDDHvGWLyCPj5y2yuTQDw34q0BZPqyPszwmh/u+pOxScyJbqavYUFI7ez/GCK8VZFFDb6l6pcXolpHPbdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WQWCz40d8z4f3js9
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 21:46:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B83371A0FA6
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 21:46:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHazkpbppmDkhQAg--.11349S5;
	Fri, 19 Jul 2024 21:46:19 +0800 (CST)
From: libaokun@huaweicloud.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	patches@lists.linux.dev,
	hsiangkao@linux.alibaba.com,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 2/3] cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
Date: Fri, 19 Jul 2024 21:43:37 +0800
Message-Id: <20240719134338.1642739-2-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240719134338.1642739-1-libaokun@huaweicloud.com>
References: <20240719134338.1642739-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHazkpbppmDkhQAg--.11349S5
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy3Ww47Xw4UZr4UGrW5Awb_yoWxJw4xpF
	ZIvryxtrW8u3yUGw45Xw47Xr93X3s8Ja1kWw18Jr18Cw4rAr1YqF1jkw1rZFy3C3ykArZ2
	k3WUKryUWw1UAr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07j-L05UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAJBWaaJBUU0AAAsH

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 522018a0de6b6fcce60c04f86dfc5f0e4b6a1b36 ]

We got the following issue in our fault injection stress test:

==================================================================
BUG: KASAN: slab-use-after-free in fscache_withdraw_volume+0x2e1/0x370
Read of size 4 at addr ffff88810680be08 by task ondemand-04-dae/5798

CPU: 0 PID: 5798 Comm: ondemand-04-dae Not tainted 6.8.0-dirty #565
Call Trace:
 kasan_check_range+0xf6/0x1b0
 fscache_withdraw_volume+0x2e1/0x370
 cachefiles_withdraw_volume+0x31/0x50
 cachefiles_withdraw_cache+0x3ad/0x900
 cachefiles_put_unbind_pincount+0x1f6/0x250
 cachefiles_daemon_release+0x13b/0x290
 __fput+0x204/0xa00
 task_work_run+0x139/0x230

Allocated by task 5820:
 __kmalloc+0x1df/0x4b0
 fscache_alloc_volume+0x70/0x600
 __fscache_acquire_volume+0x1c/0x610
 erofs_fscache_register_volume+0x96/0x1a0
 erofs_fscache_register_fs+0x49a/0x690
 erofs_fc_fill_super+0x6c0/0xcc0
 vfs_get_super+0xa9/0x140
 vfs_get_tree+0x8e/0x300
 do_new_mount+0x28c/0x580
 [...]

Freed by task 5820:
 kfree+0xf1/0x2c0
 fscache_put_volume.part.0+0x5cb/0x9e0
 erofs_fscache_unregister_fs+0x157/0x1b0
 erofs_kill_sb+0xd9/0x1c0
 deactivate_locked_super+0xa3/0x100
 vfs_get_super+0x105/0x140
 vfs_get_tree+0x8e/0x300
 do_new_mount+0x28c/0x580
 [...]
==================================================================

Following is the process that triggers the issue:

        mount failed         |         daemon exit
------------------------------------------------------------
 deactivate_locked_super        cachefiles_daemon_release
  erofs_kill_sb
   erofs_fscache_unregister_fs
    fscache_relinquish_volume
     __fscache_relinquish_volume
      fscache_put_volume(fscache_volume, fscache_volume_put_relinquish)
       zero = __refcount_dec_and_test(&fscache_volume->ref, &ref);
                                 cachefiles_put_unbind_pincount
                                  cachefiles_daemon_unbind
                                   cachefiles_withdraw_cache
                                    cachefiles_withdraw_volumes
                                     list_del_init(&volume->cache_link)
       fscache_free_volume(fscache_volume)
        cache->ops->free_volume
         cachefiles_free_volume
          list_del_init(&cachefiles_volume->cache_link);
        kfree(fscache_volume)
                                     cachefiles_withdraw_volume
                                      fscache_withdraw_volume
                                       fscache_volume->n_accesses
                                       // fscache_volume UAF !!!

The fscache_volume in cache->volumes must not have been freed yet, but its
reference count may be 0. So use the new fscache_try_get_volume() helper
function try to get its reference count.

If the reference count of fscache_volume is 0, fscache_put_volume() is
freeing it, so wait for it to be removed from cache->volumes.

If its reference count is not 0, call cachefiles_withdraw_volume() with
reference count protection to avoid the above issue.

Fixes: fe2140e2f57f ("cachefiles: Implement volume support")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240628062930.2467993-3-libaokun@huaweicloud.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/cache.c          | 10 ++++++++++
 include/trace/events/fscache.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index f449f7340aad..56ef519a36a0 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/statfs.h>
 #include <linux/namei.h>
+#include <trace/events/fscache.h>
 #include "internal.h"
 
 /*
@@ -319,12 +320,20 @@ static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
 	_enter("");
 
 	for (;;) {
+		struct fscache_volume *vcookie = NULL;
 		struct cachefiles_volume *volume = NULL;
 
 		spin_lock(&cache->object_list_lock);
 		if (!list_empty(&cache->volumes)) {
 			volume = list_first_entry(&cache->volumes,
 						  struct cachefiles_volume, cache_link);
+			vcookie = fscache_try_get_volume(volume->vcookie,
+							 fscache_volume_get_withdraw);
+			if (!vcookie) {
+				spin_unlock(&cache->object_list_lock);
+				cpu_relax();
+				continue;
+			}
 			list_del_init(&volume->cache_link);
 		}
 		spin_unlock(&cache->object_list_lock);
@@ -332,6 +341,7 @@ static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
 			break;
 
 		cachefiles_withdraw_volume(volume);
+		fscache_put_volume(vcookie, fscache_volume_put_withdraw);
 	}
 
 	_leave("");
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index a6190aa1b406..f1a73aa83fbb 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -35,12 +35,14 @@ enum fscache_volume_trace {
 	fscache_volume_get_cookie,
 	fscache_volume_get_create_work,
 	fscache_volume_get_hash_collision,
+	fscache_volume_get_withdraw,
 	fscache_volume_free,
 	fscache_volume_new_acquire,
 	fscache_volume_put_cookie,
 	fscache_volume_put_create_work,
 	fscache_volume_put_hash_collision,
 	fscache_volume_put_relinquish,
+	fscache_volume_put_withdraw,
 	fscache_volume_see_create_work,
 	fscache_volume_see_hash_wake,
 	fscache_volume_wait_create_work,
@@ -120,12 +122,14 @@ enum fscache_access_trace {
 	EM(fscache_volume_get_cookie,		"GET cook ")		\
 	EM(fscache_volume_get_create_work,	"GET creat")		\
 	EM(fscache_volume_get_hash_collision,	"GET hcoll")		\
+	EM(fscache_volume_get_withdraw,		"GET withd")            \
 	EM(fscache_volume_free,			"FREE     ")		\
 	EM(fscache_volume_new_acquire,		"NEW acq  ")		\
 	EM(fscache_volume_put_cookie,		"PUT cook ")		\
 	EM(fscache_volume_put_create_work,	"PUT creat")		\
 	EM(fscache_volume_put_hash_collision,	"PUT hcoll")		\
 	EM(fscache_volume_put_relinquish,	"PUT relnq")		\
+	EM(fscache_volume_put_withdraw,		"PUT withd")            \
 	EM(fscache_volume_see_create_work,	"SEE creat")		\
 	EM(fscache_volume_see_hash_wake,	"SEE hwake")		\
 	E_(fscache_volume_wait_create_work,	"WAIT crea")
-- 
2.39.2


