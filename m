Return-Path: <stable+bounces-164949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CFCB13BFB
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9283BF3EC
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DC226CE28;
	Mon, 28 Jul 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="10pYcAfa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710BE26CE21
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710616; cv=none; b=Y/lzV71PnFCa9+ZALUzyoGCM8nwQln0/FMVA+99RHdlkGhf/C8h7uxu7rjJlJECYoAmNvquVbfnnl6FKUXdMX1ruSnAt35toL832ZJsywWvHpOfLUJBVwvadvsF9cSpDL361IOBUftDmKwl+k+kPRxXYsHm3TMYYkAtBMrvqKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710616; c=relaxed/simple;
	bh=Cix1uWH6YjI6yhiafrvqHu7zG0FHLKcLOU9Ce3KGrg4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AqIQM0LQ52gM9cUa3Nei9IOFD9kKD2/J2aA5KpQtbcI/7VOVxt+nuChajT/ddhU5Jd3H5LvYsh89ORNy3/2MVL5lixteUOvKjArV+AebefICAq3wX732L8ZSKQmXTs0Xvjufsot5uahxBFzs6EtGe7rD5be27TC+OFYmG04U088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=10pYcAfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B65AC4CEFC;
	Mon, 28 Jul 2025 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753710614;
	bh=Cix1uWH6YjI6yhiafrvqHu7zG0FHLKcLOU9Ce3KGrg4=;
	h=Subject:To:Cc:From:Date:From;
	b=10pYcAfaNc/ARAxaWHiuolo3P0hvHwGkp4hp1xn7vnHju/ZeiIjbNk1HX6fv4WnVp
	 lMmD8/oVhUAcMIYlc8DSjZnNc6x8BCUBS40D/SksmnWGzDOtnUGSMHPxN1IRf3VJjH
	 W8StFmeCa+H1xH7OqMVbZfRQNVfj9afOT1mE3B2E=
Subject: FAILED: patch "[PATCH] mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n" failed to apply to 5.10-stable tree
To: harry.yoo@oracle.com,akpm@linux-foundation.org,david@redhat.com,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 15:50:10 +0200
Message-ID: <2025072810-footgear-grumpily-4fd5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 694d6b99923eb05a8fd188be44e26077d19f0e21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072810-footgear-grumpily-4fd5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


