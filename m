Return-Path: <stable+bounces-195326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47621C75426
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1263C2B380
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BB833AD99;
	Thu, 20 Nov 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SMKDyyxj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD73376BC2
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655155; cv=none; b=Nb6nsgIOvkmN1LjBIWt3KE6P9iWvmzk9Ibq2KDEInWqSUi49F6GTcXNRvUPXfcg59XXxZEaqGqisUANN7nVBjX3uUqeikqMaKTFIWZN8Lye58ZAbTo7t1078LH7q71qIYCpWdo3VzS0qCXQC/xVF2hTT6kN2yT0f4rc+m110yK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655155; c=relaxed/simple;
	bh=8vMvsn79TLVrmIQXd264gs/iwQ62LVapnxO+rPFQCck=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DO468bWcRAhBvmVrwryms4Dh6m8Ts8GU4mLUkJaz7XrdWEmK/ET7tLZt+mhck+7ASRvzB4XMd01GSl6tce1NuzERcE1gTmz2QsM9PT4MPWx8C26V+esqh7g2Dj9ypATT/755zsZTzAAO9VuR6gALAIlDKU/Qi6nF1v35vTVcXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SMKDyyxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7049C4CEF1;
	Thu, 20 Nov 2025 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655155;
	bh=8vMvsn79TLVrmIQXd264gs/iwQ62LVapnxO+rPFQCck=;
	h=Subject:To:Cc:From:Date:From;
	b=SMKDyyxj53AmXSIHLqowyFskFDK77bxj9CVG1SrqruZBZtDcky6PX86yaVdl2eet/
	 yKSr/dYepWylpb/cog1eWZyBWQdC4NuK03rmP0V9iL64nP0Q0xeLRRr8os4ehMcgld
	 0SkMtcjrqJZjZ3NQ9/rvvFBahc6YssXPcrlH4xeU=
Subject: FAILED: patch "[PATCH] mm/mm_init: fix hash table order logging in" failed to apply to 6.1-stable tree
To: isaacmanjarres@google.com,akpm@linux-foundation.org,david@redhat.com,rppt@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:12:32 +0100
Message-ID: <2025112032-parted-progeny-cd9e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0d6c356dd6547adac2b06b461528e3573f52d953
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112032-parted-progeny-cd9e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d6c356dd6547adac2b06b461528e3573f52d953 Mon Sep 17 00:00:00 2001
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Date: Tue, 28 Oct 2025 12:10:12 -0700
Subject: [PATCH] mm/mm_init: fix hash table order logging in
 alloc_large_system_hash()

When emitting the order of the allocation for a hash table,
alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from log
base 2 of the allocation size.  This is not correct if the allocation size
is smaller than a page, and yields a negative value for the order as seen
below:

TCP established hash table entries: 32 (order: -4, 256 bytes, linear) TCP
bind hash table entries: 32 (order: -2, 1024 bytes, linear)

Use get_order() to compute the order when emitting the hash table
information to correctly handle cases where the allocation size is smaller
than a page:

TCP established hash table entries: 32 (order: 0, 256 bytes, linear) TCP
bind hash table entries: 32 (order: 0, 1024 bytes, linear)

Link: https://lkml.kernel.org/r/20251028191020.413002-1-isaacmanjarres@google.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3db2dea7db4c..7712d887b696 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2469,7 +2469,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 		panic("Failed to allocate %s hash table\n", tablename);
 
 	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
-		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
+		tablename, 1UL << log2qty, get_order(size), size,
 		virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
 
 	if (_hash_shift)


