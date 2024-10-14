Return-Path: <stable+bounces-84805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE0299D22E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91FBB26B3B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B266B1ADFFB;
	Mon, 14 Oct 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9hdYh6t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BE1AC887
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919274; cv=none; b=MkYB0NJU+jgTpJmoRz5x9X6HZYcdyRRrp9Om5n7iJafhAhpirLveyFyLfig6dG8y6xXaHfzeUILrtaat4Dt/oErxBJAvyL+g86jRBKtoqoeiofaikKAsBDZk5vvpNKZbIi29y78qw91IQDNsmmtANzmRenf9zpRl5ng3+vnzFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919274; c=relaxed/simple;
	bh=vfyV2JLArq//R3EZAY5T/9gykyXsGDAtc1ey8X9Ha9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bt4Bzays11pJDvTOJ+ZsL9nGC8SbYIu1MGdeRIgU2tSnYC4APMlL4hXDnn+O1E/JQeFy1kSGDDFg9QLlI+kU/Gb5B3SLJt0CuG8aZxLSViYB43/koltYpb4QnJ0NyuMsTj+gSN2LH867CDxgeaKPMrM+QUiMFHOCTSGscRpBvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9hdYh6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262A8C4CEC3;
	Mon, 14 Oct 2024 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728919274;
	bh=vfyV2JLArq//R3EZAY5T/9gykyXsGDAtc1ey8X9Ha9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9hdYh6tIv2YYru2QRnQcCc+G9LQD89PUvfPXnvxlC0nsxEOL1+6+Qw1dUgYfHlNR
	 12Ghy8D4g89gdjH8HzGDYv7xF9w63t+nTooCQ6J9Ug6sAjX+3tn60CQ2WH7Rv+b9Oc
	 qNLPopQd0vqd3qiNUsUrqcGNsYxghTnGe1gz0bi7sKVORLUGrqAz+ynrUezucXqvsb
	 6XwZnJdIfHqvHyoqJGklrx+lwgSpxDN8E/SyM6ey6PVDA1o1Nb+eJ/KcOUsg0Zz6JQ
	 dJGe5Xzrz0BjnI+D8FXPtc4xH8vw9RFjNg4FYURdCerwGjvPTc54o+BthAtJs3suZk
	 YmldPonncf1uQ==
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Patrick Roy <roypat@amazon.co.uk>
Subject: [PATCH 5.15.y] secretmem: disable memfd_secret() if arch cannot set direct map
Date: Mon, 14 Oct 2024 18:21:03 +0300
Message-ID: <20241014152103.1328260-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024101412-prowling-snowflake-9fe0@gregkh>
References: <2024101412-prowling-snowflake-9fe0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Roy <roypat@amazon.co.uk>

Return -ENOSYS from memfd_secret() syscall if !can_set_direct_map().
This is the case for example on some arm64 configurations, where marking
4k PTEs in the direct map not present can only be done if the direct map
is set up at 4k granularity in the first place (as ARM's
break-before-make semantics do not easily allow breaking apart
large/gigantic pages).

More precisely, on arm64 systems with !can_set_direct_map(),
set_direct_map_invalid_noflush() is a no-op, however it returns success
(0) instead of an error. This means that memfd_secret will seemingly
"work" (e.g. syscall succeeds, you can mmap the fd and fault in pages),
but it does not actually achieve its goal of removing its memory from
the direct map.

Note that with this patch, memfd_secret() will start erroring on systems
where can_set_direct_map() returns false (arm64 with
CONFIG_RODATA_FULL_DEFAULT_ENABLED=n, CONFIG_DEBUG_PAGEALLOC=n and
CONFIG_KFENCE=n), but that still seems better than the current silent
failure. Since CONFIG_RODATA_FULL_DEFAULT_ENABLED defaults to 'y', most
arm64 systems actually have a working memfd_secret() and aren't be
affected.

>From going through the iterations of the original memfd_secret patch
series, it seems that disabling the syscall in these scenarios was the
intended behavior [1] (preferred over having
set_direct_map_invalid_noflush return an error as that would result in
SIGBUSes at page-fault time), however the check for it got dropped
between v16 [2] and v17 [3], when secretmem moved away from CMA
allocations.

[1]: https://lore.kernel.org/lkml/20201124164930.GK8537@kernel.org/
[2]: https://lore.kernel.org/lkml/20210121122723.3446-11-rppt@kernel.org/#t
[3]: https://lore.kernel.org/lkml/20201125092208.12544-10-rppt@kernel.org/

Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/secretmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index d1986ce2e7c7..624663a94808 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -234,7 +234,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	/* make sure local flags do not confict with global fcntl.h */
 	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
 
-	if (!secretmem_enable)
+	if (!secretmem_enable || !can_set_direct_map())
 		return -ENOSYS;
 
 	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
@@ -278,7 +278,7 @@ static int secretmem_init(void)
 {
 	int ret = 0;
 
-	if (!secretmem_enable)
+	if (!secretmem_enable || !can_set_direct_map())
 		return ret;
 
 	secretmem_mnt = kern_mount(&secretmem_fs);
-- 
2.43.0


