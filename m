Return-Path: <stable+bounces-50422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6479F9065BE
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5738A1C23601
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F1813C9A4;
	Thu, 13 Jun 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IRlgwy1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3B713C8E8
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265314; cv=none; b=j651Amn9U2YVd8M9TS+B64LUML7VJfqZ5+zezxvIsqgJgmy8H+iye+sYNH51MRqwb0nmQag2zT7QyYLhh9YGJVd7TkpQhNuRB/Bd7hMN8rMXS9gl1KouqHxKRwQ2RNC0EdxcweFe5KO02rc8REZJv010duc2I6yQiTUirMygUgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265314; c=relaxed/simple;
	bh=Tq4pIUN9djSLDeeAftF7aceBfSDwbXBBokQKy51pM34=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nsGyHyrBPZ3D9hOp8SloZnSW7g/hGkva6jGRgyjmZMw3vwQMgyqUkc4qw9usyNMggyCcq+aHndCt0IkJiv5NK76x7w5tmR7gSul7fbQ7jzt4LzuvOBsohyr78Q47GlGTZP7BmarhaZVbtg+U6dks33yI1MXa8ubWbDQnGDubNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IRlgwy1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6800FC4AF1C;
	Thu, 13 Jun 2024 07:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265313;
	bh=Tq4pIUN9djSLDeeAftF7aceBfSDwbXBBokQKy51pM34=;
	h=Subject:To:Cc:From:Date:From;
	b=IRlgwy1JE3N8JxCWu8Poc77IsZVfhGwrxEqs7++3PChID6mgYPKpGxCDlIzuhbHY5
	 wtEPw5YxNEGv5Dp7bAR/4oVRq2u7ZPLPh/DtxbFhDZOdm+dZCfKCQPw+VGYb8PdKyp
	 +D3wh7/lLL49l6LTpjufSbc9I5xgGvoE06D4WTE4=
Subject: FAILED: patch "[PATCH] mm/cma: drop incorrect alignment check in" failed to apply to 5.10-stable tree
To: fvdl@google.com,akpm@linux-foundation.org,david@redhat.com,m.szyprowski@samsung.com,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:55:02 +0200
Message-ID: <2024061302-polyester-ahead-33a7@gregkh>
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
git cherry-pick -x b174f139bdc8aaaf72f5b67ad1bd512c4868a87e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061302-polyester-ahead-33a7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

b174f139bdc8 ("mm/cma: drop incorrect alignment check in cma_init_reserved_mem")
e16faf26780f ("cma: factor out minimum alignment requirement")
658aafc8139c ("memblock: exclude MEMBLOCK_NOMAP regions from kmemleak")
a7259df76702 ("memblock: make memblock_find_in_range method private")
a70bb580bfea ("Merge tag 'devicetree-for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b174f139bdc8aaaf72f5b67ad1bd512c4868a87e Mon Sep 17 00:00:00 2001
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 4 Apr 2024 16:25:14 +0000
Subject: [PATCH] mm/cma: drop incorrect alignment check in
 cma_init_reserved_mem

cma_init_reserved_mem uses IS_ALIGNED to check if the size represented by
one bit in the cma allocation bitmask is aligned with
CMA_MIN_ALIGNMENT_BYTES (pageblock size).

However, this is too strict, as this will fail if order_per_bit >
pageblock_order, which is a valid configuration.

We could check IS_ALIGNED both ways, but since both numbers are powers of
two, no check is needed at all.

Link: https://lkml.kernel.org/r/20240404162515.527802-1-fvdl@google.com
Fixes: de9e14eebf33 ("drivers: dma-contiguous: add initialization from device tree")
Signed-off-by: Frank van der Linden <fvdl@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/cma.c b/mm/cma.c
index 01f5a8f71ddf..3e9724716bad 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -182,10 +182,6 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	if (!size || !memblock_is_region_reserved(base, size))
 		return -EINVAL;
 
-	/* alignment should be aligned with order_per_bit */
-	if (!IS_ALIGNED(CMA_MIN_ALIGNMENT_PAGES, 1 << order_per_bit))
-		return -EINVAL;
-
 	/* ensure minimal alignment required by mm core */
 	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
 		return -EINVAL;


