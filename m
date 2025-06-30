Return-Path: <stable+bounces-158902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F786AED888
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657BD189A712
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBFC23F26A;
	Mon, 30 Jun 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u41IdtE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E19478
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275300; cv=none; b=nDmtErfW8QYdYOmz4zQvbxeKQBwqHFjEKHJvbWlACKuEjqPLg+MXUASWwgMuMUzLyLOGFLnGX5RbQAIsVA5QeLViKjFYJj5smZ9QdS5fJs5Dwnn3/TI+VW10hGsIuppEUw6ZUC9yKd9vlL+y6AomBoqZCMFofA2OjmD11+QaVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275300; c=relaxed/simple;
	bh=onFRGwJX2pJCvyqBlb4Ghmniku3F9PvUzhCDvrL62Zk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jZuwOFDJ8GvvfGtZnsuFIg4mA0kDo+USz7qBLt6C/MHg0yANjYlVls7ZM+DFXRZJSJ7Unk6SaZVpuPUPCxaGTnnv774+ozdVVf5VGjnScHgyY7dZ5oixn8lJGGA/Ta6qa/7Tbq3CTHpXl1Xk7CvwhasCnP758Iy3Jz5cq5pKisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u41IdtE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182C4C4CEE3;
	Mon, 30 Jun 2025 09:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275300;
	bh=onFRGwJX2pJCvyqBlb4Ghmniku3F9PvUzhCDvrL62Zk=;
	h=Subject:To:Cc:From:Date:From;
	b=u41IdtE8HfJ/j+N8QDrRJMIa1ESnONdVULJwoyJ18sYucNkhB6RmxkUSFu8U3ok9y
	 NIPBcDnlVOCF5mnj3YIdKbE0vcHsMNmRpAZONRG4K+aTBzxUwTqMuQRPhSGNpMv/ab
	 qtNDiy/fsKAsXfo3k6kODvRL1aRMOh8Y8SEQdqbE=
Subject: FAILED: patch "[PATCH] maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()" failed to apply to 6.6-stable tree
To: Liam.Howlett@oracle.com,Steve.Kang@unisoc.com,akpm@linux-foundation.org,hailong.liu@oppo.com,lorenzo.stoakes@oracle.com,sidhartha.kumar@oracle.com,stable@vger.kernel.org,surenb@google.com,willy@infradead.org,zhangpeng.00@bytedance.com,zhaoyang.huang@unisoc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:21:32 +0200
Message-ID: <2025063032-shed-reseller-6709@gregkh>
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
git cherry-pick -x fba46a5d83ca8decb338722fb4899026d8d9ead2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063032-shed-reseller-6709@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fba46a5d83ca8decb338722fb4899026d8d9ead2 Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Mon, 16 Jun 2025 14:45:20 -0400
Subject: [PATCH] maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()

Temporarily clear the preallocation flag when explicitly requesting
allocations.  Pre-existing allocations are already counted against the
request through mas_node_count_gfp(), but the allocations will not happen
if the MA_STATE_PREALLOC flag is set.  This flag is meant to avoid
re-allocating in bulk allocation mode, and to detect issues with
preallocation calculations.

The MA_STATE_PREALLOC flag should also always be set on zero allocations
so that detection of underflow allocations will print a WARN_ON() during
consumption.

User visible effect of this flaw is a WARN_ON() followed by a null pointer
dereference when subsequent requests for larger number of nodes is
ignored, such as the vma merge retry in mmap_region() caused by drivers
altering the vma flags (which happens in v6.6, at least)

Link: https://lkml.kernel.org/r/20250616184521.3382795-3-Liam.Howlett@oracle.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Reported-by: Hailong Liu <hailong.liu@oppo.com>
Link: https://lore.kernel.org/all/1652f7eb-a51b-4fee-8058-c73af63bacd1@oppo.com/
Link: https://lore.kernel.org/all/20250428184058.1416274-1-Liam.Howlett@oracle.com/
Link: https://lore.kernel.org/all/20250429014754.1479118-1-Liam.Howlett@oracle.com/
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Hailong Liu <hailong.liu@oppo.com>
Cc: zhangpeng.00@bytedance.com <zhangpeng.00@bytedance.com>
Cc: Steve Kang <Steve.Kang@unisoc.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index affe979bd14d..00524e55a21e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5527,8 +5527,9 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	mas->store_type = mas_wr_store_type(&wr_mas);
 	request = mas_prealloc_calc(&wr_mas, entry);
 	if (!request)
-		return ret;
+		goto set_flag;
 
+	mas->mas_flags &= ~MA_STATE_PREALLOC;
 	mas_node_count_gfp(mas, request, gfp);
 	if (mas_is_err(mas)) {
 		mas_set_alloc_req(mas, 0);
@@ -5538,6 +5539,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 		return ret;
 	}
 
+set_flag:
 	mas->mas_flags |= MA_STATE_PREALLOC;
 	return ret;
 }


