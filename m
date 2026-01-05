Return-Path: <stable+bounces-204900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE7CCF5612
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 20:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC06A30C9002
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 19:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47031346E55;
	Mon,  5 Jan 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avr7l/zR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9ED346AF5
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641319; cv=none; b=eWknxVLKMB46gHXkgMWAdCJBDbXgaSxSz28sB8pg9sBZml6FtnaO7vbjXzRukFhO1qf2BhrZ8Uj8qAzGU3FEIu5JDbK3gGY4hLsYjPfSSHokM4Qks10vVXK7qDBKn6Qahx/77FH/2pngSfYpoNXNaEEXTq89UyNWNsRYkTypYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641319; c=relaxed/simple;
	bh=ie+dGc43XsYVBI4wrf9ySpnP7Q+07+MvKEmg1B7prqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuhnwK5HKbZAtwcBsez5yydMEbME29j0LF8N7oXqpOMSlU+xYZSEZcaQqNyHKskNV18DdllJwt9NsytDogxIkG6xrKfTc+CDy6VM/af3OLnQs23x2AbXefIvxIoFWoKfYh2GbaecjZCLGlK0pRPC+I63yDOY2czE8v6NOl+M66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avr7l/zR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B53C19423;
	Mon,  5 Jan 2026 19:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767641319;
	bh=ie+dGc43XsYVBI4wrf9ySpnP7Q+07+MvKEmg1B7prqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avr7l/zRx785UYtW3vLebPS1ym4HGyEEWUg9Muxfo7WT2rSOCxPcEIELcHgxWiYoG
	 /pSbFdx7MAUvwImbRSbMjf2CCnkMNxjcCdErPBVlUjZwCdDJz7vn3MsneDjoO4wpno
	 /4eVqlp8aU2TD3kYq84E0Lz8wq0RjYyoITjBwX0oxPDbuf7SxcxauSaOqcnwCMzhZn
	 06T2nr5A87fs9bcl/+kxN/lJqLVq0yCm2D6uvMWTyEeLpk3+Oz3sLDu1Cx5FnRebfi
	 3HSU7nozCwBy04J5lTS13R5zolRkMujHXBWGdrVkRG2Hza7Iy1HYBBiaa3+/4YjIxT
	 vqoyilf/CL+bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages
Date: Mon,  5 Jan 2026 14:28:26 -0500
Message-ID: <20260105192826.2740369-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105192826.2740369-1-sashal@kernel.org>
References: <2026010548-impulse-unspoken-ac63@gregkh>
 <20260105192826.2740369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 0da2ba35c0d532ca0fe7af698b17d74c4d084b9a ]

Let's properly adjust BALLOON_MIGRATE like the other drivers.

Note that the INFLATE/DEFLATE events are triggered from the core when
enqueueing/dequeueing pages.

This was found by code inspection.

Link: https://lkml.kernel.org/r/20251021100606.148294-3-david@redhat.com
Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/cmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 0507d3874c45..de93f31768d3 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -550,6 +550,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	balloon_page_insert(b_dev_info, newpage);
+	__count_vm_event(BALLOON_MIGRATE);
 	b_dev_info->isolated_pages--;
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 
-- 
2.51.0


