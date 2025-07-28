Return-Path: <stable+bounces-164950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA7B13BFE
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D34417E980
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AFD26B0BC;
	Mon, 28 Jul 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QFjYbJP0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B426AABD
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710623; cv=none; b=Hq4Ea67PTGwryuzqXaHIfcsUL5H+0/iv3Mt/j3HC/0fWjBcYAlVfmU3BWBH8iDwsk0qY9e9RBsh8iDOFSj4f67n0xuNpcFW16lIu+E5IqyMzSLx/aq/DTDs+ERqFwQn7D0h/dXykubhW8mjmqb2OqbwlrIuokQkD1dq4MJiCjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710623; c=relaxed/simple;
	bh=39NgPOewE0NKR0K1DyaCJUodV4CMRFQq/Mhtfh2jkNg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RbCh4OT1wOz8VKEy0NwORgn73PZslZ6y2ka40uyWHQpSwE7zXQop6qWjAnedNoMDOr5JKARuIvbCR2njqhGsOThvlFeeU+1hCL4aUTFwAJONrdWsXd0NQhTHW/EXs7Ni3TxMCwTTenNCeTOilxfTLg3C+lC7BRQe7ZhZEdyvap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QFjYbJP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6807AC4CEE7;
	Mon, 28 Jul 2025 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753710622;
	bh=39NgPOewE0NKR0K1DyaCJUodV4CMRFQq/Mhtfh2jkNg=;
	h=Subject:To:Cc:From:Date:From;
	b=QFjYbJP0/3nQkxIm2uTIIHq1pulgyLJC7QnXcFIqhyyYXUWWLo3gpd2ZZctrtRlpK
	 82rRT+I7qau6KV6dBiWOQxKa2yaqbF+6o4FD+UX9EpS0a5mocUsTkRspA2Nfx/6eE8
	 Rlyb7onQ6CQWYIa4kcRmQ+Sr/JJmsLd7JhpG20Fc=
Subject: FAILED: patch "[PATCH] mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n" failed to apply to 5.4-stable tree
To: harry.yoo@oracle.com,akpm@linux-foundation.org,david@redhat.com,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 15:50:11 +0200
Message-ID: <2025072811-ethanol-arbitrary-a664@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 694d6b99923eb05a8fd188be44e26077d19f0e21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072811-ethanol-arbitrary-a664@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 694d6b99923eb05a8fd188be44e26077d19f0e21 Mon Sep 17 00:00:00 2001
From: Harry Yoo <harry.yoo@oracle.com>
Date: Fri, 4 Jul 2025 19:30:53 +0900
Subject: [PATCH] mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n

Commit 48b4800a1c6a ("zsmalloc: page migration support") added support for
migrating zsmalloc pages using the movable_operations migration framework.
However, the commit did not take into account that zsmalloc supports
migration only when CONFIG_COMPACTION is enabled.  Tracing shows that
zsmalloc was still passing the __GFP_MOVABLE flag even when compaction is
not supported.

This can result in unmovable pages being allocated from movable page
blocks (even without stealing page blocks), ZONE_MOVABLE and CMA area.

Possible user visible effects:
- Some ZONE_MOVABLE memory can be not actually movable
- CMA allocation can fail because of this
- Increased memory fragmentation due to ignoring the page mobility
  grouping feature
I'm not really sure who uses kernels without compaction support, though :(


To fix this, clear the __GFP_MOVABLE flag when
!IS_ENABLED(CONFIG_COMPACTION).

Link: https://lkml.kernel.org/r/20250704103053.6913-1-harry.yoo@oracle.com
Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 999b513c7fdf..f3e2215f95eb 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1043,6 +1043,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	if (!zspage)
 		return NULL;
 
+	if (!IS_ENABLED(CONFIG_COMPACTION))
+		gfp &= ~__GFP_MOVABLE;
+
 	zspage->magic = ZSPAGE_MAGIC;
 	zspage->pool = pool;
 	zspage->class = class->index;


