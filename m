Return-Path: <stable+bounces-198015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A802C99A15
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 00:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8626341514
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 23:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A219995E;
	Mon,  1 Dec 2025 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAcKieg4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11F8488
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764633212; cv=none; b=MeVJx2J1fP6JPcIuo7Jrl1Ce/i6mbbSiBvB8x49eIFDt03H63eDNyDJEUoMoaqfl8FgTBR8e94KcY6DjsJH2EEOJ76VOSYJwNNnltE7ffvt0Da5FdnOCLNuv53DjGLi5VkQeHplAfB9WBzl+66uBjbAQ2Z/kr7zPJTZbKDr///g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764633212; c=relaxed/simple;
	bh=vTrCEl9bscTok6mct3eLxC3nDPZ9WblBgWRaemzr9a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESYF3QBoI844gjFpjkjL1fpTBNcIZF82qfRWGoZfPtg6NEPvUjm7QVLhk2Tdyrwl4Ju0596C9lnkjAQubLIxLJI+eOkHcSUBGx1BUbfOzlQCrI4GLtSWXqsOeJLqbCAmIWjkcGlwVx/YFTTEOJva7g/rVdb3ymANIcvCape5HTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAcKieg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C2FC4CEF1;
	Mon,  1 Dec 2025 23:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764633212;
	bh=vTrCEl9bscTok6mct3eLxC3nDPZ9WblBgWRaemzr9a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAcKieg4g3b6w7RHFL6+5JrB4hp/jOv0zwvD8ziHWHSnibEGQa6Sh/1+NU+mntvMM
	 mJIDOvKBvoWiA3M76uXc0onaKhnP4ajVW5/9tfH92ew02tER9Du+cBf9nOCQl5qSQn
	 r1RkCqcvb9ZUUJY0hJxrRNWhuIojiZU9Gj27MerB0VuefXnutJ0Cwh36zQpmilCC+E
	 KadmStJjHpuTm/v3uF93+5QKt5BnXYJSyOD83SmwTTAX2fvsT7ccqPfCN50f4JjXgZ
	 4r6MdGLTdEujLQiWXkXK+r4dCRtOdd3Qo3OJNzQVpLLNwzqw6H8QjIMg6SNF7/0LPB
	 xRY1o2J1v04/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Youngjun Park <youngjun.park@lge.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y] mm: swap: remove duplicate nr_swap_pages decrement in get_swap_page_of_type()
Date: Mon,  1 Dec 2025 18:53:26 -0500
Message-ID: <20251201235326.1315049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120121-fifteen-liver-792b@gregkh>
References: <2025120121-fifteen-liver-792b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Youngjun Park <youngjun.park@lge.com>

[ Upstream commit f5e31a196edcd1f1bb44f26b6f9299b9a5b9b3c4 ]

After commit 4f78252da887, nr_swap_pages is decremented in
swap_range_alloc(). Since cluster_alloc_swap_entry() calls
swap_range_alloc() internally, the decrement in get_swap_page_of_type()
causes double-decrementing.

As a representative userspace-visible runtime example of the impact,
/proc/meminfo reports increasingly inaccurate SwapFree values.  The
discrepancy grows with each swap allocation, and during hibernation
when large amounts of memory are written to swap, the reported value
can deviate significantly from actual available swap space, misleading
users and monitoring tools.

Remove the duplicate decrement.

Link: https://lkml.kernel.org/r/20251102082456.79807-1-youngjun.park@lge.com
Fixes: 4f78252da887 ("mm: swap: move nr_swap_pages counter decrement from folio_alloc_swap() to swap_range_alloc()")
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Kairui Song <kasong@tencent.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: <stable@vger.kernel.org> [6.17+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adjusted context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swapfile.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ad438a4d0e68c..73065d75d0e1f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1866,10 +1866,8 @@ swp_entry_t get_swap_page_of_type(int type)
 	if (get_swap_device_info(si)) {
 		if (si->flags & SWP_WRITEOK) {
 			offset = cluster_alloc_swap_entry(si, 0, 1);
-			if (offset) {
+			if (offset)
 				entry = swp_entry(si->type, offset);
-				atomic_long_dec(&nr_swap_pages);
-			}
 		}
 		put_swap_device(si);
 	}
-- 
2.51.0


