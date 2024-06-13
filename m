Return-Path: <stable+bounces-50417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3FA9065B9
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB7A1F268FB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC113CF89;
	Thu, 13 Jun 2024 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NsMMu7w2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DC13C8E8
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265305; cv=none; b=sDBTkwodK1v5ofJWUvsb/UFtn596oB29YG/OSBWms7zvnW+IEwQkf6PK3Za6Yl/AsvGKVkfQNsvEkMAKLJRVZmRfGso+pm/QvIpQ6fib+D2CAV55/gSPzAVoOA52IJICmNxcXUmr+3s9BTlRkoIbqaBXCaf82bzJTtmwuQZEhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265305; c=relaxed/simple;
	bh=CmIG8imGeZaXwDnz7QKfLYHvN3EVUyhIfBm5Xkc77Mc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cuGVro5i3Les+hCPTZ+tFvIvvPTaxqta3qR7TVimtRU1Kow/eRuuMlEXiuARIvjt70SlPniW3v4T6QGZsyZq6zF7U6ETrM9iWl3IVzcQ8tyvgRMJUyqUh/zbAkerWOhWOZYXTd6DnJg6eqypQRmebFYtQo8JO6DizZEiHpGddOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NsMMu7w2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57294C4AF4D;
	Thu, 13 Jun 2024 07:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265304;
	bh=CmIG8imGeZaXwDnz7QKfLYHvN3EVUyhIfBm5Xkc77Mc=;
	h=Subject:To:Cc:From:Date:From;
	b=NsMMu7w23pXyfYMvV5CZO9881BJIVaXnxJ/tH+UDcfPs92Lul87k65t0O2eQsejXz
	 Aeb5x7q9mRRtWq0SFZeRSqd+EtfdpNbiVGloDNzcIQ3BL3GyWCnHLO+YUv5CKyL7fs
	 jt94ggKAyb6vPpf20CJAJtp8NCszNQOItDVMo3oY=
Subject: FAILED: patch "[PATCH] mm/cma: drop incorrect alignment check in" failed to apply to 5.15-stable tree
To: fvdl@google.com,akpm@linux-foundation.org,david@redhat.com,m.szyprowski@samsung.com,muchun.song@linux.dev,roman.gushchin@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:55:01 +0200
Message-ID: <2024061301-runt-mannish-7604@gregkh>
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
git cherry-pick -x b174f139bdc8aaaf72f5b67ad1bd512c4868a87e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061301-runt-mannish-7604@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b174f139bdc8 ("mm/cma: drop incorrect alignment check in cma_init_reserved_mem")
e16faf26780f ("cma: factor out minimum alignment requirement")

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


