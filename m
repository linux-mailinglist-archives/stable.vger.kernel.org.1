Return-Path: <stable+bounces-200122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF3CA62E7
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 06:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D9A3197227
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 05:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60F6398FBA;
	Fri,  5 Dec 2025 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TKvvxtGQ"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5172EB85E
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764913600; cv=none; b=iI24umMnAjNoMd/Ov5YguHd/Z2+UalFi0qHscIlxgbvYQVRnqiAlEA12Zv5NSCXQ6ctzmQevNqhgahNgAP4QPH5lsf6RoEY3u5KVo9dsyKjCGqQyFlHSssFDbmu7L0oBf8JpfyfYnqclFWAna5AJXTaKGzHMQX0osd5Ak0GvkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764913600; c=relaxed/simple;
	bh=qWQYLnbDTmHYe8U2XYpH+DELvN4KQem34xYiqhroM/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTK5LW31aMQ4jK9odAwWTU5lHPmLPujMkbNN9XUbR7OE+g4eI2q89JqUlumdLftH6XpsqhUNfdVbhTq6RKq3sD/tW4O5iM5TF6UN/bn6ZxTjza45tOXXVOQ0gEHCnT1HnECFp6SSSO9v0WXTmv9e7VMaURkkhtO6Rq/KPoH7GUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TKvvxtGQ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764913596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkrMidDAv1Ktl1ft9SvRilnJ8T6D0bjcWXGm3Yx/hIA=;
	b=TKvvxtGQj1ZX9rRt8MXgau3yaSZE4bivpnV95OwH3dGKx+KAHiDD5YI756YgioQ5cZO2n7
	QXWQ0J85GtvIWC9hoy87J5aQjOC8rpF6tClJtDA14Rv+ebKcynfpMLF+vNf23HRkgaWNCs
	817XpMyx+j9O4Ok4hsTPDb1D5g+lYjs=
From: Dongsheng Yang <dongsheng.yang@linux.dev>
To: cengku@gmail.com,
	dm-devel@lists.linux.dev,
	chenl311@chinatelecom.cn,
	mpatocka@redhat.com
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] dm pcache: fix segment info indexing
Date: Fri,  5 Dec 2025 05:46:20 +0000
Message-ID: <20251205054621.1744279-3-dongsheng.yang@linux.dev>
In-Reply-To: <20251205054621.1744279-1-dongsheng.yang@linux.dev>
References: <20251205054621.1744279-1-dongsheng.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Li Chen <chenl311@chinatelecom.cn>

Segment info indexing also used sizeof(struct) instead of the
4K metadata stride, so info_index could point between slots and
subsequent writes would advance incorrectly. Derive info_index
from the pointer returned by the segment meta search using
PCACHE_SEG_INFO_SIZE and advance to the next slot for future
updates.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Signed-off-by: Dongsheng Yang <dongsheng.yang@linux.dev>
Reviewed-by: Zheng Gu <cengku@gmail.com>
Cc: stable@vger.kernel.org	# 6.18
---
 drivers/md/dm-pcache/cache_segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-pcache/cache_segment.c b/drivers/md/dm-pcache/cache_segment.c
index ae57cc261422..9d92e2b067ed 100644
--- a/drivers/md/dm-pcache/cache_segment.c
+++ b/drivers/md/dm-pcache/cache_segment.c
@@ -56,7 +56,10 @@ static int cache_seg_info_load(struct pcache_cache_segment *cache_seg)
 		ret = -EIO;
 		goto out;
 	}
-	cache_seg->info_index = cache_seg_info_addr - cache_seg_info_addr_base;
+
+	cache_seg->info_index =
+		((char *)cache_seg_info_addr - (char *)cache_seg_info_addr_base) /
+		PCACHE_SEG_INFO_SIZE;
 out:
 	mutex_unlock(&cache_seg->info_lock);
 
-- 
2.43.0


