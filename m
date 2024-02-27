Return-Path: <stable+bounces-23795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07594868704
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 03:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398491C28C8D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 02:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC75125B9;
	Tue, 27 Feb 2024 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="enRxWa93"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A4F4EB
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000781; cv=none; b=ApKlsF/WM5w3J5NlB+4BEUmry0Cd0a6tYUy16kvqwuByGS+wkDSy0t11hdgqUYI4hJPTrO4AWTYHbbNmeA4wy0tBlp2oxZA/4iOI2ECEtckaUmqDGtEXznSJmcqUW3K1WZFPgkUCgjbeQcmJjM48hEjXMfCa3iHHIxlETUvHBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000781; c=relaxed/simple;
	bh=n+gKlSJveT15RNbRq3YvKcHlwlV6NmDGyQ6jff2hqA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKb6viasuizCGHFFTFrcbUOwt+IsCC6YrvgKU9NVCmtQh8JOafxx9smQ69pdk+94uwfO8PmApqYv1J+4X0g+TpsoJZI4+kxEHy4x0kESRLfI3NlU0ZXc0C+6VIfaYfj/1dMTxtyv7E8p/mdlnMwPfeOrjQEWWW6mOvDBj2cLKj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=enRxWa93; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709000772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYphDb6PKbFnhfnnQVegwKnVWlmBky51nArcI1nPHy4=;
	b=enRxWa93NI+zF2GWaMHQgsIs962ENoXCfEAb8404XgzdyQLKh7sPeh7AmUC8Wq/KkqFPrO
	YpeHIQg9pNXRkaeboZXgzYO2fIGE0DNCqUpxzJzbTUOt+7QXeHe55BFQJz5bqO3pVm//re
	pDGlMsud7N0C5PTV7bt8kOc64mdGhgI=
From: chengming.zhou@linux.dev
To: stable@vger.kernel.org
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled
Date: Tue, 27 Feb 2024 02:25:40 +0000
Message-Id: <20240227022540.3441860-1-chengming.zhou@linux.dev>
In-Reply-To: <2024022622-resent-ripeness-43f1@gregkh>
References: <2024022622-resent-ripeness-43f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

We have to invalidate any duplicate entry even when !zswap_enabled since
zswap can be disabled anytime.  If the folio store success before, then
got dirtied again but zswap disabled, we won't invalidate the old
duplicate entry in the zswap_store().  So later lru writeback may
overwrite the new data in swapfile.

Link: https://lkml.kernel.org/r/20240208023254.3873823-1-chengming.zhou@linux.dev
Fixes: 42c06a0e8ebe ("mm: kill frontswap")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 678e54d4bb9a4822f8ae99690ac131c5d490cdb1)
---
 mm/zswap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 37d2b1cb2ecb..63fb94d68e10 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1215,7 +1215,7 @@ bool zswap_store(struct folio *folio)
 	if (folio_test_large(folio))
 		return false;
 
-	if (!zswap_enabled || !tree)
+	if (!tree)
 		return false;
 
 	/*
@@ -1231,6 +1231,9 @@ bool zswap_store(struct folio *folio)
 	}
 	spin_unlock(&tree->lock);
 
+	if (!zswap_enabled)
+		return false;
+
 	/*
 	 * XXX: zswap reclaim does not work with cgroups yet. Without a
 	 * cgroup-aware entry LRU, we will push out entries system-wide based on
-- 
2.40.1


