Return-Path: <stable+bounces-195327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE717C75555
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 235124E49F2
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F1718DF80;
	Thu, 20 Nov 2025 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kzb4iiYH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040F34BA22
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655164; cv=none; b=qHrHeli1SmsztP6jzvdgTmUiSzkQ0ScrRctDD9wlvGrB36iT4P8nTnUnwtn9srZs1OibPEGGOaWRl81yN/v4GcYMPJ3ECKco7MVjxUT4qBi9u/5z4osK3Icr0hiHbsc3cGFO/mHxJEuCAkm7gezT+xSz4tKur3opRlA3tSTr+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655164; c=relaxed/simple;
	bh=Yg+w1PkKVmwqJXyIsBwYbd5AV7vGERNaVA3ip7uXdcY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pkUl2KEyOKfLXPIaUnZmxnpix6QnIgr9xlzGDAUeCWgmJeNbQAa2GL+aubKHdYd82k0RaS3n2Vb3BkuWhKf3+0M32NII3kMYu427ZiGkhypIpckWPkbKUHRunHryut6zWdYDxmyWI1rgO9KZB7V6hp2hDtJaoityOvKIVdGTU7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kzb4iiYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8580DC4CEF1;
	Thu, 20 Nov 2025 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655163;
	bh=Yg+w1PkKVmwqJXyIsBwYbd5AV7vGERNaVA3ip7uXdcY=;
	h=Subject:To:Cc:From:Date:From;
	b=Kzb4iiYHlOBuTcv7Uegi+nqNIwiiPfG7S8U8SeN1j4yqBEtMbIyCKu6sWnPMPjryX
	 iWf0jYItXeAmavDfo48FE3NvUhCliAxA5iMPDSzGoWKAHv+iHv0+JP2XQL9ZpH7Zvt
	 U9KZqyvwFpQjKHxuJcq9yxwjC2d3incpaZrDxyGI=
Subject: FAILED: patch "[PATCH] mm/mm_init: fix hash table order logging in" failed to apply to 5.10-stable tree
To: isaacmanjarres@google.com,akpm@linux-foundation.org,david@redhat.com,rppt@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:12:33 +0100
Message-ID: <2025112033-barista-manicure-43e9@gregkh>
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
git cherry-pick -x 0d6c356dd6547adac2b06b461528e3573f52d953
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112033-barista-manicure-43e9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


