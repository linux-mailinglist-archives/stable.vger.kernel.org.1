Return-Path: <stable+bounces-51180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F28F906EAE
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A8D1F211AC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E9E1482E2;
	Thu, 13 Jun 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Zk4flRz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8699B1448DD;
	Thu, 13 Jun 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280541; cv=none; b=TC8IzzejuTdTiZ671KoSb++WDNKnxw2xRyTLRsq8YAmO7hjd45IRIWy0Tfu7jGoi8tHAkfdbiPH3g6+1+UttXSoYFeH8idy7s29jaJHIZQQSSBBjf9ojXsfZ+/m9YdmxZ9paOAJ3jtqX3YLN3ap6e2MSH3y8E5AkkbAePZOEaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280541; c=relaxed/simple;
	bh=9SyS69gAEoipQSV0zGvhTy2YWeeYoJnFnyeqEtsxXJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+EFnGDBHJvcvcxG8VcFWteqEHU9dH6VoGXsb8U8Y+O7rt8KMVTvr+sKnDPxZaIDW3wqTVItSeCBn/UtFWSiYa5VVdTtr7FOds5AB0ZhB9PznAq+J46Xdajmv11gxGsmd0EnJ5V2Nj3aWjtPC5Oc7zajU0k8LK8iBRg8XcYUFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Zk4flRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD8FC4AF1A;
	Thu, 13 Jun 2024 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280541;
	bh=9SyS69gAEoipQSV0zGvhTy2YWeeYoJnFnyeqEtsxXJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1Zk4flRzCbcJGCmskQ0imT9TmvF9C0IjOs335ZTqSfKUJKP+KlSmXyX7ipmMpO1xx
	 D9rBXQJ7Wdk94kdJMqd+43ZsCQF9kIkzptwlJVZkkFUIgj3US4fkEB3ZLGYp/viLqR
	 Z5v9zeaHXAdsGz4UtLr40cHZoVOJ8otpK7N7gYj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank van der Linden <fvdl@google.com>,
	David Hildenbrand <david@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 089/137] mm/cma: drop incorrect alignment check in cma_init_reserved_mem
Date: Thu, 13 Jun 2024 13:34:29 +0200
Message-ID: <20240613113226.751704726@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank van der Linden <fvdl@google.com>

commit b174f139bdc8aaaf72f5b67ad1bd512c4868a87e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/cma.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/mm/cma.c
+++ b/mm/cma.c
@@ -187,10 +187,6 @@ int __init cma_init_reserved_mem(phys_ad
 	if (!size || !memblock_is_region_reserved(base, size))
 		return -EINVAL;
 
-	/* alignment should be aligned with order_per_bit */
-	if (!IS_ALIGNED(CMA_MIN_ALIGNMENT_PAGES, 1 << order_per_bit))
-		return -EINVAL;
-
 	/* ensure minimal alignment required by mm core */
 	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
 		return -EINVAL;



