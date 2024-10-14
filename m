Return-Path: <stable+bounces-83797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99EE99C98F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933D91F25489
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEFE19DFAC;
	Mon, 14 Oct 2024 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lnTink2D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4413C67C
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907037; cv=none; b=jjlsVYn+Cptlo5PHPgfm9EAWRrhiN0wAO+FjgePsZtmV8wi4elu0ITLSpY9wr1lKyrqXacRwISiz9NiQ0KnpHp3hKGJl78cgxQVR2j1KmgFd5fMKg26Q0PuXgavGI2Rdd+hPFjwIRpeCq6STVU4Iln5idXJtuQQMDYJgHuooJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907037; c=relaxed/simple;
	bh=11O/SDAeKNhh4e+9LsVA8TxSxJ05O7FIWt0G6rENq3s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dot4vam15abtQnouuHA44zq3FyNcAKmaWphW8zd3id59q90XHO3fKEAj/Ib7i1wLN6oIZk/SFMmN0kWu9hUwFcdOTW9ZHvGMg3ZbTB1OeJtYDuCcnmlAXTCrGfz4b+8x8PTWqGtsu1goLpoG4kUjJreLRzRxRfb5TcPS3OjMJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lnTink2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E96C4CEC7;
	Mon, 14 Oct 2024 11:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728907036;
	bh=11O/SDAeKNhh4e+9LsVA8TxSxJ05O7FIWt0G6rENq3s=;
	h=Subject:To:Cc:From:Date:From;
	b=lnTink2DRnfi53n1dB7YxQPpS1JLnhlWWnj7B4eNby/DSHE9wZAp39iTbmPeKwye0
	 Yn2+ozwG3FFarJ71mirGfmd1+xdaWE31FnQV9Ux2FmIQBq5rLe84KvxVovGf7lvKyR
	 8m8fOvhePumWRz4pmMMXseQcXu82pf3fTSiFuQqY=
Subject: FAILED: patch "[PATCH] secretmem: disable memfd_secret() if arch cannot set direct" failed to apply to 5.15-stable tree
To: roypat@amazon.co.uk,akpm@linux-foundation.org,david@redhat.com,graf@amazon.com,jgowans@amazon.com,rppt@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 13:57:13 +0200
Message-ID: <2024101412-prowling-snowflake-9fe0@gregkh>
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
git cherry-pick -x 532b53cebe58f34ce1c0f34d866f5c0e335c53c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101412-prowling-snowflake-9fe0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

532b53cebe58 ("secretmem: disable memfd_secret() if arch cannot set direct map")
f7c5b1aab5ef ("mm/secretmem: remove reduntant return value")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 532b53cebe58f34ce1c0f34d866f5c0e335c53c6 Mon Sep 17 00:00:00 2001
From: Patrick Roy <roypat@amazon.co.uk>
Date: Tue, 1 Oct 2024 09:00:41 +0100
Subject: [PATCH] secretmem: disable memfd_secret() if arch cannot set direct
 map

Return -ENOSYS from memfd_secret() syscall if !can_set_direct_map().  This
is the case for example on some arm64 configurations, where marking 4k
PTEs in the direct map not present can only be done if the direct map is
set up at 4k granularity in the first place (as ARM's break-before-make
semantics do not easily allow breaking apart large/gigantic pages).

More precisely, on arm64 systems with !can_set_direct_map(),
set_direct_map_invalid_noflush() is a no-op, however it returns success
(0) instead of an error.  This means that memfd_secret will seemingly
"work" (e.g.  syscall succeeds, you can mmap the fd and fault in pages),
but it does not actually achieve its goal of removing its memory from the
direct map.

Note that with this patch, memfd_secret() will start erroring on systems
where can_set_direct_map() returns false (arm64 with
CONFIG_RODATA_FULL_DEFAULT_ENABLED=n, CONFIG_DEBUG_PAGEALLOC=n and
CONFIG_KFENCE=n), but that still seems better than the current silent
failure.  Since CONFIG_RODATA_FULL_DEFAULT_ENABLED defaults to 'y', most
arm64 systems actually have a working memfd_secret() and aren't be
affected.

From going through the iterations of the original memfd_secret patch
series, it seems that disabling the syscall in these scenarios was the
intended behavior [1] (preferred over having
set_direct_map_invalid_noflush return an error as that would result in
SIGBUSes at page-fault time), however the check for it got dropped between
v16 [2] and v17 [3], when secretmem moved away from CMA allocations.

[1]: https://lore.kernel.org/lkml/20201124164930.GK8537@kernel.org/
[2]: https://lore.kernel.org/lkml/20210121122723.3446-11-rppt@kernel.org/#t
[3]: https://lore.kernel.org/lkml/20201125092208.12544-10-rppt@kernel.org/

Link: https://lkml.kernel.org/r/20241001080056.784735-1-roypat@amazon.co.uk
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: James Gowans <jgowans@amazon.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 3afb5ad701e1..399552814fd0 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -238,7 +238,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	/* make sure local flags do not confict with global fcntl.h */
 	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
 
-	if (!secretmem_enable)
+	if (!secretmem_enable || !can_set_direct_map())
 		return -ENOSYS;
 
 	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
@@ -280,7 +280,7 @@ static struct file_system_type secretmem_fs = {
 
 static int __init secretmem_init(void)
 {
-	if (!secretmem_enable)
+	if (!secretmem_enable || !can_set_direct_map())
 		return 0;
 
 	secretmem_mnt = kern_mount(&secretmem_fs);


