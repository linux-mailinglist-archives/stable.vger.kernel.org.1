Return-Path: <stable+bounces-23659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1AE867197
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AA21F2B19A
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5374359B53;
	Mon, 26 Feb 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U1DAyEFe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9458228
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943508; cv=none; b=fZ2wwYvivXuLZD8Z+Kg2xobod4fLPwV4wx9ebSzJDkOwrC+fjU2FsCIC4KI6/PVK4IgQdZWiklC9kKAxeydkLgiyo1xvJb/eA0vmB/5ZIegmg0+OMPaGJnT3QFFGIwuv5M9/iD1Yhd4OLPRt3SJSOny7r/i5ji41ujsSoB8nl1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943508; c=relaxed/simple;
	bh=JCHg0a1/Iu9Uq1lEMNP+MwghrD81iA7qma2drHB8mFE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=urS1CKScx9sJikymC0WY89kaw5dU4TlkTMXV7hYjCFvfy99+COr3uPM5yS7CtnkCotnpT27Rd7cDTebqtLeQYO3sjBOM7A5PSPxkvJpGZlAtj8a/hXp8LZUDIJFGmd74YkASJoDTiZIiYSiBzH5NFnMgeVxUV9TqYUiNe++uqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U1DAyEFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4968BC433C7;
	Mon, 26 Feb 2024 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943507;
	bh=JCHg0a1/Iu9Uq1lEMNP+MwghrD81iA7qma2drHB8mFE=;
	h=Subject:To:Cc:From:Date:From;
	b=U1DAyEFeGht5o5mG8BdKVw0MgcXKJ7Zm+lVuG6fKbeOYsqHh0DQbtSWlHw/KlOFfS
	 8Z1M5aRL54hytSZz4wRiomo0h29MBBOpTRPyshDIdmwjg8u5Kn3IerPTDprsZhAAuh
	 UKB7zaDycdLL6u9KifKKEztlvZjhfAHYIxWBDiFg=
Subject: FAILED: patch "[PATCH] cachefiles: fix memory leak in cachefiles_add_cache()" failed to apply to 4.19-stable tree
To: libaokun1@huawei.com,brauner@kernel.org,dhowells@redhat.com,jefflexu@linux.alibaba.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:31:39 +0100
Message-ID: <2024022639-selection-angrily-d6ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x e21a2f17566cbd64926fb8f16323972f7a064444
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022639-selection-angrily-d6ff@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

e21a2f17566c ("cachefiles: fix memory leak in cachefiles_add_cache()")
d1065b0a6fd9 ("cachefiles: Implement cache registration and withdrawal")
32759f7d7af5 ("cachefiles: Implement a function to get/create a directory in the cache")
1bd9c4e4f049 ("vfs, cachefiles: Mark a backing file in use with an inode flag")
80f94f29f677 ("cachefiles: Provide a function to check how much space there is")
8667d434b2a9 ("cachefiles: Register a miscdev and parse commands over it")
254947d47945 ("cachefiles: Add security derivation")
1493bf74bcf2 ("cachefiles: Add cache error reporting macro")
ecf5a6ce15f9 ("cachefiles: Add a couple of tracepoints for logging errors")
a70f6526267e ("cachefiles: Add some error injection support")
8390fbc46570 ("cachefiles: Define structs")
77443f6171f3 ("cachefiles: Introduce rewritten driver")
850cba069c26 ("cachefiles: Delete the cachefiles driver pending rewrite")
b6773cdb0e9f ("Merge tag 'for-5.16/ki_complete-2021-10-29' of git://git.kernel.dk/linux-block")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e21a2f17566cbd64926fb8f16323972f7a064444 Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Sat, 17 Feb 2024 16:14:31 +0800
Subject: [PATCH] cachefiles: fix memory leak in cachefiles_add_cache()

The following memory leak was reported after unbinding /dev/cachefiles:

==================================================================
unreferenced object 0xffff9b674176e3c0 (size 192):
  comm "cachefilesd2", pid 680, jiffies 4294881224
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc ea38a44b):
    [<ffffffff8eb8a1a5>] kmem_cache_alloc+0x2d5/0x370
    [<ffffffff8e917f86>] prepare_creds+0x26/0x2e0
    [<ffffffffc002eeef>] cachefiles_determine_cache_security+0x1f/0x120
    [<ffffffffc00243ec>] cachefiles_add_cache+0x13c/0x3a0
    [<ffffffffc0025216>] cachefiles_daemon_write+0x146/0x1c0
    [<ffffffff8ebc4a3b>] vfs_write+0xcb/0x520
    [<ffffffff8ebc5069>] ksys_write+0x69/0xf0
    [<ffffffff8f6d4662>] do_syscall_64+0x72/0x140
    [<ffffffff8f8000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
==================================================================

Put the reference count of cache_cred in cachefiles_daemon_unbind() to
fix the problem. And also put cache_cred in cachefiles_add_cache() error
branch to avoid memory leaks.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
CC: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240217081431.796809-1-libaokun1@huawei.com
Acked-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 7077f72e6f47..f449f7340aad 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -168,6 +168,8 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
 	dput(root);
 error_open_root:
 	cachefiles_end_secure(cache, saved_cred);
+	put_cred(cache->cache_cred);
+	cache->cache_cred = NULL;
 error_getsec:
 	fscache_relinquish_cache(cache_cookie);
 	cache->cache = NULL;
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 3f24905f4066..6465e2574230 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -816,6 +816,7 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 	cachefiles_put_directory(cache->graveyard);
 	cachefiles_put_directory(cache->store);
 	mntput(cache->mnt);
+	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
 	kfree(cache->secctx);


