Return-Path: <stable+bounces-61202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEA493A751
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7B7284604
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F599158A06;
	Tue, 23 Jul 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q3H2YBlZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D9158873;
	Tue, 23 Jul 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760279; cv=none; b=GHwKE8x0MlxPhFDRPomqIjsgalHmdk8afTlCHMZ6yXpFpAbivgv5RhsRn39f2ep/UKNrGQZbLHbLX+W1D/YmfE/8x58hPwbs2RvQ+ukLQhLp64JYDuxA9jVswxTvmMlo8OzNxuUYEnbLtrK7ODAjlfW+ZYJV6W2JrQfBq/bXPDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760279; c=relaxed/simple;
	bh=e1ZqDmeDjXUWzUNyKrhavLG42S1d2yFtq7Pv91IXvIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaWIcdT96oRDNnK2hA+Kn2pbmejsq8CCZ5eJjyjGGD5tPr5T2nOboiHXlPn3EvXa/0eGgssAHwxg469w31xbVlSB/+zimTMXEYe1h6TBcgSDyJmwu9MJ2Cd1r7Ci09qc0EHQLdP6WVK7z1Yo0nfO62hiYU7EsrJSTIdOkIsdJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q3H2YBlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6496BC4AF0A;
	Tue, 23 Jul 2024 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721760278;
	bh=e1ZqDmeDjXUWzUNyKrhavLG42S1d2yFtq7Pv91IXvIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3H2YBlZHsrtu8zCA+oPM5mzLD36WIPWM0x1JvU0FnrlbCFIf9P2Rz3NRXSDbYWfr
	 5+qXnasEAY/2Nirl+MJ6z4fwSuJNw6mNtm6Ptw7tSEs47XCzDsbkBkgGKwucZFdfL3
	 EckmkIXz5zXWmiSLM9slGJ/ObjGW8Q/21jXV2vwM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.9 162/163] cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
Date: Tue, 23 Jul 2024 20:24:51 +0200
Message-ID: <20240723180149.728544739@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>
References: <20240723180143.461739294@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cachefiles/cache.c          |   10 ++++++++++
 include/trace/events/fscache.h |    4 ++++
 2 files changed, 14 insertions(+)

--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/statfs.h>
 #include <linux/namei.h>
+#include <trace/events/fscache.h>
 #include "internal.h"
 
 /*
@@ -319,12 +320,20 @@ static void cachefiles_withdraw_volumes(
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
@@ -332,6 +341,7 @@ static void cachefiles_withdraw_volumes(
 			break;
 
 		cachefiles_withdraw_volume(volume);
+		fscache_put_volume(vcookie, fscache_volume_put_withdraw);
 	}
 
 	_leave("");
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



