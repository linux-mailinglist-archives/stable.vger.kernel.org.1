Return-Path: <stable+bounces-92009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DA19C2DE9
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 15:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7C11F2198C
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94061940BC;
	Sat,  9 Nov 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NsbP+8hJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1913DB99
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164149; cv=none; b=ijiabPK/f4vhM2JraXt7OXur2XK8oFXmslqaChen8LOU9B2jVPdDA4mhT24JnLt7ZK66hgzdXK2l/Ld2T0tx5920RyGs7jpUrl7gz8xxOvMbsQP7VKkYGE34LZ6DG2s1KFj+OT8GP0dqDpVDbHCvODi/h1neTxtCqKJeyYr3Fcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164149; c=relaxed/simple;
	bh=2wkilNz0geuuBiFw7PBoZlcDP1ubH/Q0iZYhI8zKVhE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I8oIX5SACROjncK/iGv3BcTrmsGUeqUA53rXR/CO+AjaZj/9mRZwQmlKhRkcnYTZlL7GCHhP8cOhLdTVrRCF6BXqgOTI8KqCcMrpdqwZYLAbvDTnD5wwuq8KfWIo4XpMAuGt6oAFRD4qDI/YruX6i8PFHQdbQzUFBxwa4MGYirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NsbP+8hJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F62C4CECE;
	Sat,  9 Nov 2024 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731164149;
	bh=2wkilNz0geuuBiFw7PBoZlcDP1ubH/Q0iZYhI8zKVhE=;
	h=Subject:To:Cc:From:Date:From;
	b=NsbP+8hJisKEBPAYJ3T1F6yFpOWomMP6SmBXF5w55Xa7C+jtT614aXiunhIWY6K0x
	 CmqN2xWjSmyMfyRf1JYlD5xv22D9z1l517z6pqKvVWahto7qaKEedtoROHzYhU+5Z9
	 2RHSwzvo44RWoTZDnDi2wNvzJFh+q6iOePk5RfZs=
Subject: FAILED: patch "[PATCH] dm cache: fix flushing uninitialized delayed_work on" failed to apply to 5.15-stable tree
To: mtsai@redhat.com,mpatocka@redhat.com,thornber@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 15:55:46 +0100
Message-ID: <2024110945-caress-unmasked-1f81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 135496c208ba26fd68cdef10b64ed7a91ac9a7ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110945-caress-unmasked-1f81@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 135496c208ba26fd68cdef10b64ed7a91ac9a7ff Mon Sep 17 00:00:00 2001
From: Ming-Hung Tsai <mtsai@redhat.com>
Date: Tue, 22 Oct 2024 15:12:49 +0800
Subject: [PATCH] dm cache: fix flushing uninitialized delayed_work on
 cache_ctr error

An unexpected WARN_ON from flush_work() may occur when cache creation
fails, caused by destroying the uninitialized delayed_work waker in the
error path of cache_create(). For example, the warning appears on the
superblock checksum error.

Reproduce steps:

dmsetup create cmeta --table "0 8192 linear /dev/sdc 0"
dmsetup create cdata --table "0 65536 linear /dev/sdc 8192"
dmsetup create corig --table "0 524288 linear /dev/sdc 262144"
dd if=/dev/urandom of=/dev/mapper/cmeta bs=4k count=1 oflag=direct
dmsetup create cache --table "0 524288 cache /dev/mapper/cmeta \
/dev/mapper/cdata /dev/mapper/corig 128 2 metadata2 writethrough smq 0"

Kernel logs:

(snip)
WARNING: CPU: 0 PID: 84 at kernel/workqueue.c:4178 __flush_work+0x5d4/0x890

Fix by pulling out the cancel_delayed_work_sync() from the constructor's
error path. This patch doesn't affect the use-after-free fix for
concurrent dm_resume and dm_destroy (commit 6a459d8edbdb ("dm cache: Fix
UAF in destroy()")) as cache_dtr is not changed.

Signed-off-by: Ming-Hung Tsai <mtsai@redhat.com>
Fixes: 6a459d8edbdb ("dm cache: Fix UAF in destroy()")
Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Acked-by: Joe Thornber <thornber@redhat.com>

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 90772b42c234..68e9a1abd303 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -1905,16 +1905,13 @@ static void check_migrations(struct work_struct *ws)
  * This function gets called on the error paths of the constructor, so we
  * have to cope with a partially initialised struct.
  */
-static void destroy(struct cache *cache)
+static void __destroy(struct cache *cache)
 {
-	unsigned int i;
-
 	mempool_exit(&cache->migration_pool);
 
 	if (cache->prison)
 		dm_bio_prison_destroy_v2(cache->prison);
 
-	cancel_delayed_work_sync(&cache->waker);
 	if (cache->wq)
 		destroy_workqueue(cache->wq);
 
@@ -1942,13 +1939,22 @@ static void destroy(struct cache *cache)
 	if (cache->policy)
 		dm_cache_policy_destroy(cache->policy);
 
+	bioset_exit(&cache->bs);
+
+	kfree(cache);
+}
+
+static void destroy(struct cache *cache)
+{
+	unsigned int i;
+
+	cancel_delayed_work_sync(&cache->waker);
+
 	for (i = 0; i < cache->nr_ctr_args ; i++)
 		kfree(cache->ctr_args[i]);
 	kfree(cache->ctr_args);
 
-	bioset_exit(&cache->bs);
-
-	kfree(cache);
+	__destroy(cache);
 }
 
 static void cache_dtr(struct dm_target *ti)
@@ -2561,7 +2567,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	*result = cache;
 	return 0;
 bad:
-	destroy(cache);
+	__destroy(cache);
 	return r;
 }
 
@@ -2612,7 +2618,7 @@ static int cache_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	r = copy_ctr_args(cache, argc - 3, (const char **)argv + 3);
 	if (r) {
-		destroy(cache);
+		__destroy(cache);
 		goto out;
 	}
 


