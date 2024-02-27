Return-Path: <stable+bounces-24970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD9E86971B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABFB1C21D49
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A813DB92;
	Tue, 27 Feb 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qewofy37"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66878B61;
	Tue, 27 Feb 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043495; cv=none; b=rQbN1k0+Ne6T7o2/+LYWkHqRpDHregoD4YnJO+3U7kN0qW3wYg2qPTd+iKMem9Uh9N3/eJAx4loZs6v9YdhvV8f3hF8b5ZNHR/lSXP+zrIQ7L09MmKwCzRmv7RENpUeVV6Jl43eh2rExVvrc+XUG0Yj9xldBfsXdql7b/IasMiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043495; c=relaxed/simple;
	bh=ZPIrUjQfaRp5Kf7S9ttsPY9vJrCa8wqieksMJiRDzVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beHdhk6vw6WEvuQ24kKmsEs0AfDXCV9tILsy02zuOL1d6fBl+4pApP9yPS0mgvWdDoW7elbVGCWhClYmkMw8zeAMr6lvXklYMIJRL7ilaiJxi0l583edlDxnh/C5b4AZVqQfaaLCOv/E2HBE7OebqxS8nX2giCawPDMU0D+8jl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qewofy37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E201C433F1;
	Tue, 27 Feb 2024 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043495;
	bh=ZPIrUjQfaRp5Kf7S9ttsPY9vJrCa8wqieksMJiRDzVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qewofy37oUbWTWnYpsRRdve5Pwq14aHQFLXC6JJ2DWECUniGJP7nD82qIW+zbYJ9J
	 JXHgvVE1hF6jncHWc1pRkZai4NOuQAtuM2yRd6ockH+ff9bjhNNpHKCo3Enth7Hi3o
	 sHwlTNG14f7XScleHv/AdusamHmQyEFlyiJrapAM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baokun Li <libaokun1@huawei.com>,
	David Howells <dhowells@redhat.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 101/195] cachefiles: fix memory leak in cachefiles_add_cache()
Date: Tue, 27 Feb 2024 14:26:02 +0100
Message-ID: <20240227131613.808225072@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

commit e21a2f17566cbd64926fb8f16323972f7a064444 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cachefiles/cache.c  |    2 ++
 fs/cachefiles/daemon.c |    1 +
 2 files changed, 3 insertions(+)

--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -168,6 +168,8 @@ error_unsupported:
 	dput(root);
 error_open_root:
 	cachefiles_end_secure(cache, saved_cred);
+	put_cred(cache->cache_cred);
+	cache->cache_cred = NULL;
 error_getsec:
 	fscache_relinquish_cache(cache_cookie);
 	cache->cache = NULL;
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -805,6 +805,7 @@ static void cachefiles_daemon_unbind(str
 	cachefiles_put_directory(cache->graveyard);
 	cachefiles_put_directory(cache->store);
 	mntput(cache->mnt);
+	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
 	kfree(cache->secctx);



