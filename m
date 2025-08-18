Return-Path: <stable+bounces-170022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FBFB2A008
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D66137A2C05
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBE30E0DE;
	Mon, 18 Aug 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="grDfBNHl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DF7261B67
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515241; cv=none; b=XLuUWjHeyTy1ALeYq6V4WCafFDDWvSoRZG05r59R+JyZYeeJpkwb6iDTopQptvBvOKrWOpk8putOFZXhhLt/vYvD6OuqFp5sA6MOb9dYebLy/KdRVXW4E85+xQr8KDhxLB71X910Qtgqp5AFLc9nQLqHvcu2LlHRf2NV4B6gtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515241; c=relaxed/simple;
	bh=KJa8wvSMD5qBlYSvKhvnaOI6pdBivDO2hJSWT4d7vOE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PjhZrwrVLXRM/DpKVhqX16zsVGRt+xqYeusu7mkONrEIOrNOs1Umys9SB4AdUkOQluFR8FPKkk2/S84a1Gxva4p0PzUfjuyOaNdFbyeEEpDqSmO7BE4YJx4024DGif1XjlZo9NK+Pz7TkFFkiDIL5tFsqzQ+PqaG3WvtjWN0k4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=grDfBNHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B198DC4CEEB;
	Mon, 18 Aug 2025 11:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755515241;
	bh=KJa8wvSMD5qBlYSvKhvnaOI6pdBivDO2hJSWT4d7vOE=;
	h=Subject:To:Cc:From:Date:From;
	b=grDfBNHl7ujGgkvrwVvzOmamQgwHBOvq5NMxQmbf7u6ZIF7uuN6V93XawmSbsY6Qi
	 HwETV7jIZmZbzSkZiW2i/wQOjzLKdIFRrolzkJ6ygxhDWvupIpYNW2Tt3vbDZnBZ7W
	 8LAVqDlnj7vbvHYzVzICwqzVdCm0bLKzdowQgsRA=
Subject: FAILED: patch "[PATCH] mm, slab: restore NUMA policy support for large kmalloc" failed to apply to 6.6-stable tree
To: vbabka@suse.cz,cl@gentwo.org,harry.yoo@oracle.com,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 13:07:18 +0200
Message-ID: <2025081818-fragrant-plausibly-d214@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e2d18cbf178775ad377ad88ee55e6e183c38d262
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081818-fragrant-plausibly-d214@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2d18cbf178775ad377ad88ee55e6e183c38d262 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 2 Jun 2025 13:02:12 +0200
Subject: [PATCH] mm, slab: restore NUMA policy support for large kmalloc

The slab allocator observes the task's NUMA policy in various places
such as allocating slab pages. Large kmalloc() allocations used to do
that too, until an unintended change by c4cab557521a ("mm/slab_common:
cleanup kmalloc_large()") resulted in ignoring mempolicy and just
preferring the local node. Restore the NUMA policy support.

Fixes: c4cab557521a ("mm/slab_common: cleanup kmalloc_large()")
Cc: <stable@vger.kernel.org>
Acked-by: Christoph Lameter (Ampere) <cl@gentwo.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

diff --git a/mm/slub.c b/mm/slub.c
index 31e11ef256f9..06d64a5fb1bf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4269,7 +4269,12 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
 		flags = kmalloc_fix_flags(flags);
 
 	flags |= __GFP_COMP;
-	folio = (struct folio *)alloc_pages_node_noprof(node, flags, order);
+
+	if (node == NUMA_NO_NODE)
+		folio = (struct folio *)alloc_pages_noprof(flags, order);
+	else
+		folio = (struct folio *)__alloc_pages_noprof(flags, order, node, NULL);
+
 	if (folio) {
 		ptr = folio_address(folio);
 		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,


