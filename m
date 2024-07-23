Return-Path: <stable+bounces-61045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF8393A69F
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F2E281B1E
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2942158A36;
	Tue, 23 Jul 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UWhLci3A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4807158A27;
	Tue, 23 Jul 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759813; cv=none; b=NAhqwxeAfFb1iD49HtQcZkFVCxk0Zn4TSseVFIiZ903PpDgW0hQ8Uob88Di3eTJgEa4OEkIWQG4CpOqM21+WI2U+Nd82eW97T4sd0cd4d+898Dk0MAJDmdfddVHMcPJFsLYUs8es0oyFadI+pr9l0YR6tnN3VXMZQDE4WrL9gHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759813; c=relaxed/simple;
	bh=fRALU4xHjLYHjGI+v9lYvF+sL7MBnXfNAmKL4qOFH7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jgu2iHZEHcHTuJg3hrrQOEm9IGEw6JQIGdBFJ8QYZVWrWWeH6meDgI+FTXpl4n4UGrDd89XiGNnr6ULXkjrLgRuY+bSKaGKUvQcP5/crGehJci/8R3x7v0zYbJUbLQvvsCJEkQxqo6lsuyOnkPH8SmKlapOuypiHOwEvwyZTr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UWhLci3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27668C4AF0A;
	Tue, 23 Jul 2024 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759813;
	bh=fRALU4xHjLYHjGI+v9lYvF+sL7MBnXfNAmKL4qOFH7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWhLci3AP4A7R9OpFqIkI44pT/IfXOW8SGKtf23Mpd7XjZf+PmJiNhdpAV/pdt38q
	 cmDGpyalEBiS3O2CunMdPRwPWSVv2naTxjy48Q4jESigLRhj80nidtMXdVZeCgFzeR
	 xUqcqtfDs8ohf3wU9UOLqjGq3bjICZGedGFqaEAE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hou Tao <houtao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.6 129/129] cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
Date: Tue, 23 Jul 2024 20:24:37 +0200
Message-ID: <20240723180409.784442676@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
References: <20240723180404.759900207@linuxfoundation.org>
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

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 5d8f805789072ea7fd39504694b7bd17e5f751c4 ]

We got the following issue in our fault injection stress test:

==================================================================
BUG: KASAN: slab-use-after-free in cachefiles_withdraw_cookie+0x4d9/0x600
Read of size 8 at addr ffff888118efc000 by task kworker/u78:0/109

CPU: 13 PID: 109 Comm: kworker/u78:0 Not tainted 6.8.0-dirty #566
Call Trace:
 <TASK>
 kasan_report+0x93/0xc0
 cachefiles_withdraw_cookie+0x4d9/0x600
 fscache_cookie_state_machine+0x5c8/0x1230
 fscache_cookie_worker+0x91/0x1c0
 process_one_work+0x7fa/0x1800
 [...]

Allocated by task 117:
 kmalloc_trace+0x1b3/0x3c0
 cachefiles_acquire_volume+0xf3/0x9c0
 fscache_create_volume_work+0x97/0x150
 process_one_work+0x7fa/0x1800
 [...]

Freed by task 120301:
 kfree+0xf1/0x2c0
 cachefiles_withdraw_cache+0x3fa/0x920
 cachefiles_put_unbind_pincount+0x1f6/0x250
 cachefiles_daemon_release+0x13b/0x290
 __fput+0x204/0xa00
 task_work_run+0x139/0x230
 do_exit+0x87a/0x29b0
 [...]
==================================================================

Following is the process that triggers the issue:

           p1                |             p2
------------------------------------------------------------
                              fscache_begin_lookup
                               fscache_begin_volume_access
                                fscache_cache_is_live(fscache_cache)
cachefiles_daemon_release
 cachefiles_put_unbind_pincount
  cachefiles_daemon_unbind
   cachefiles_withdraw_cache
    fscache_withdraw_cache
     fscache_set_cache_state(cache, FSCACHE_CACHE_IS_WITHDRAWN);
    cachefiles_withdraw_objects(cache)
    fscache_wait_for_objects(fscache)
      atomic_read(&fscache_cache->object_count) == 0
                              fscache_perform_lookup
                               cachefiles_lookup_cookie
                                cachefiles_alloc_object
                                 refcount_set(&object->ref, 1);
                                 object->volume = volume
                                 fscache_count_object(vcookie->cache);
                                  atomic_inc(&fscache_cache->object_count)
    cachefiles_withdraw_volumes
     cachefiles_withdraw_volume
      fscache_withdraw_volume
      __cachefiles_free_volume
       kfree(cachefiles_volume)
                              fscache_cookie_state_machine
                               cachefiles_withdraw_cookie
                                cache = object->volume->cache;
                                // cachefiles_volume UAF !!!

After setting FSCACHE_CACHE_IS_WITHDRAWN, wait for all the cookie lookups
to complete first, and then wait for fscache_cache->object_count == 0 to
avoid the cookie exiting after the volume has been freed and triggering
the above issue. Therefore call fscache_withdraw_volume() before calling
cachefiles_withdraw_objects().

This way, after setting FSCACHE_CACHE_IS_WITHDRAWN, only the following two
cases will occur:
1) fscache_begin_lookup fails in fscache_begin_volume_access().
2) fscache_withdraw_volume() will ensure that fscache_count_object() has
   been executed before calling fscache_wait_for_objects().

Fixes: fe2140e2f57f ("cachefiles: Implement volume support")
Suggested-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240628062930.2467993-4-libaokun@huaweicloud.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cachefiles/cache.c  |   35 ++++++++++++++++++++++++++++++++++-
 fs/cachefiles/volume.c |    1 -
 2 files changed, 34 insertions(+), 2 deletions(-)

--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -313,7 +313,39 @@ static void cachefiles_withdraw_objects(
 }
 
 /*
- * Withdraw volumes.
+ * Withdraw fscache volumes.
+ */
+static void cachefiles_withdraw_fscache_volumes(struct cachefiles_cache *cache)
+{
+	struct list_head *cur;
+	struct cachefiles_volume *volume;
+	struct fscache_volume *vcookie;
+
+	_enter("");
+retry:
+	spin_lock(&cache->object_list_lock);
+	list_for_each(cur, &cache->volumes) {
+		volume = list_entry(cur, struct cachefiles_volume, cache_link);
+
+		if (atomic_read(&volume->vcookie->n_accesses) == 0)
+			continue;
+
+		vcookie = fscache_try_get_volume(volume->vcookie,
+						 fscache_volume_get_withdraw);
+		if (vcookie) {
+			spin_unlock(&cache->object_list_lock);
+			fscache_withdraw_volume(vcookie);
+			fscache_put_volume(vcookie, fscache_volume_put_withdraw);
+			goto retry;
+		}
+	}
+	spin_unlock(&cache->object_list_lock);
+
+	_leave("");
+}
+
+/*
+ * Withdraw cachefiles volumes.
  */
 static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
 {
@@ -381,6 +413,7 @@ void cachefiles_withdraw_cache(struct ca
 	pr_info("File cache on %s unregistering\n", fscache->name);
 
 	fscache_withdraw_cache(fscache);
+	cachefiles_withdraw_fscache_volumes(cache);
 
 	/* we now have to destroy all the active objects pertaining to this
 	 * cache - which we do by passing them off to thread pool to be
--- a/fs/cachefiles/volume.c
+++ b/fs/cachefiles/volume.c
@@ -133,7 +133,6 @@ void cachefiles_free_volume(struct fscac
 
 void cachefiles_withdraw_volume(struct cachefiles_volume *volume)
 {
-	fscache_withdraw_volume(volume->vcookie);
 	cachefiles_set_volume_xattr(volume);
 	__cachefiles_free_volume(volume);
 }



