Return-Path: <stable+bounces-114645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F40BA2F0E2
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AD01883C84
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5DC2309AC;
	Mon, 10 Feb 2025 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YCRWgLe/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F97082E
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199902; cv=none; b=SrvhYZ+M4ldwALqiwyuV0dDqphaIaXu1Q4diececV9ncWnE7RtYY+2Vow5VTHiK7XTAvNJCV5+oCpMRDrN4DobjYVmPImJlZQOR162+cIlzx80yo1JxZU1n72aTIsU+I2Selq2hzAcCQh9eME5XJN+N68CV2Y7/O5cH/AleTb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199902; c=relaxed/simple;
	bh=Bf3+ctUjEVsab6iAMWP7jY53vJOrr/j+KjX/038zQ/0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EBJHc28di/iQInwgWST+3ZjTlciIR3damVRU9TdvFfAEYAnP2vFqSLfrYpU5GDCCMU6XsLNK66OnPNz+1Te9x9GThwwZoNSIaZ41EfSQgk0XH8JxDZt2t7//1lwc3f7MOi4DqfP5eWaxzMFvFFo+LE+GZr5iaBOVx+800xhdNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YCRWgLe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5ADC4CED1;
	Mon, 10 Feb 2025 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199901;
	bh=Bf3+ctUjEVsab6iAMWP7jY53vJOrr/j+KjX/038zQ/0=;
	h=Subject:To:Cc:From:Date:From;
	b=YCRWgLe/nxZrTwKIIdHqoZ2kk3Pj1tgOlYhiIG7MnuwN49J8bmlObHs++5bUsGan9
	 Z/YehW5hwMPkEKZcz54FiMzVnAjSgz+wkiZI4Pn0SMtOg+pmdCMzu5+xYtIHdMYK9H
	 lK9+p3EyGKKy0HzddbFVkgC/zM+/247BQt3pltFs=
Subject: FAILED: patch "[PATCH] kfence: skip __GFP_THISNODE allocations on NUMA systems" failed to apply to 5.15-stable tree
To: elver@google.com,akpm@linux-foundation.org,cl@linux.com,dvyukov@google.com,glider@google.com,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:04:58 +0100
Message-ID: <2025021058-paramount-dance-41da@gregkh>
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
git cherry-pick -x e64f81946adf68cd75e2207dd9a51668348a4af8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021058-paramount-dance-41da@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e64f81946adf68cd75e2207dd9a51668348a4af8 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Fri, 24 Jan 2025 13:01:38 +0100
Subject: [PATCH] kfence: skip __GFP_THISNODE allocations on NUMA systems

On NUMA systems, __GFP_THISNODE indicates that an allocation _must_ be on
a particular node, and failure to allocate on the desired node will result
in a failed allocation.

Skip __GFP_THISNODE allocations if we are running on a NUMA system, since
KFENCE can't guarantee which node its pool pages are allocated on.

Link: https://lkml.kernel.org/r/20250124120145.410066-1-elver@google.com
Fixes: 236e9f153852 ("kfence: skip all GFP_ZONEMASK allocations")
Signed-off-by: Marco Elver <elver@google.com>
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Chistoph Lameter <cl@linux.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 67fc321db79b..102048821c22 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -21,6 +21,7 @@
 #include <linux/log2.h>
 #include <linux/memblock.h>
 #include <linux/moduleparam.h>
+#include <linux/nodemask.h>
 #include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/random.h>
@@ -1084,6 +1085,7 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	 * properties (e.g. reside in DMAable memory).
 	 */
 	if ((flags & GFP_ZONEMASK) ||
+	    ((flags & __GFP_THISNODE) && num_online_nodes() > 1) ||
 	    (s->flags & (SLAB_CACHE_DMA | SLAB_CACHE_DMA32))) {
 		atomic_long_inc(&counters[KFENCE_COUNTER_SKIP_INCOMPAT]);
 		return NULL;


