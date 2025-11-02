Return-Path: <stable+bounces-192019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4EEC28C26
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 09:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649A7188B7BB
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3FE17A309;
	Sun,  2 Nov 2025 08:25:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B037E7DA66
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762071912; cv=none; b=YR5DF16TOqpU7WiZfyPArdLg++R77c2Nq6CrfvvWazWY88QheqOi6OccdNBuvK1kXkYLGRiFFvhcElxKB4sr6TMqUj07k8NHB1gIHksZ6Uy7IF7H2a+7bg47gG4miP0FO2XOXqbF1rfUACZBgZeF1iVyqLEznutz8L8kRHjCYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762071912; c=relaxed/simple;
	bh=gJw5i3mpUyROXgiHahaNmIVtOHd7oxaINfmpU5mtobw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hvuv4p1MP7/8KTG97Erve60tFcIbVBqwO698onO6UVcOu7tLLOLrSlo4JahKcL1VbMFneJ/9ywSxDRSp8DQNM1T0huk+rTWxGS7Ao3/3cxeyoSbUX+7ypwa0vynhDq+7B67s2slSfXQCmSB8gssfoEQUvoAh55XUzeh5TdHNFsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 2 Nov 2025 17:25:01 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	youngjun.park@lge.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] mm: swap: remove duplicate nr_swap_pages decrement in get_swap_page_of_type()
Date: Sun,  2 Nov 2025 17:24:56 +0900
Message-Id: <20251102082456.79807-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 4f78252da887, nr_swap_pages is decremented in
swap_range_alloc(). Since cluster_alloc_swap_entry() calls
swap_range_alloc() internally, the decrement in get_swap_page_of_type()
causes double-decrementing.

Remove the duplicate decrement.

Fixes: 4f78252da887 ("mm: swap: move nr_swap_pages counter decrement from folio_alloc_swap() to swap_range_alloc()")
Cc: stable@vger.kernel.org # v6.17-rc1
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
---
v1 -> v2:
 - Collect Acked-by from Chris - thank you!
 - Collect Reviewed-by from Barry - thank you!
 - Link to v1: https://lore.kernel.org/linux-mm/20251101134158.69908-1-youngjun.park@lge.com/

 mm/swapfile.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 543f303f101d..66a502cd747b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2020,10 +2020,8 @@ swp_entry_t get_swap_page_of_type(int type)
 			local_lock(&percpu_swap_cluster.lock);
 			offset = cluster_alloc_swap_entry(si, 0, 1);
 			local_unlock(&percpu_swap_cluster.lock);
-			if (offset) {
+			if (offset)
 				entry = swp_entry(si->type, offset);
-				atomic_long_dec(&nr_swap_pages);
-			}
 		}
 		put_swap_device(si);
 	}
-- 
2.34.1


