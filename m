Return-Path: <stable+bounces-19259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2884D7D8
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 03:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216521C2315E
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 02:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05566149E03;
	Thu,  8 Feb 2024 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="weZui6S4"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD311D524
	for <stable@vger.kernel.org>; Thu,  8 Feb 2024 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359598; cv=none; b=qKJ5knsGMdro3aA1xjL2EjkYMLQaqx+X1d3k6hV/YRTuTr/BJCbBhs5zEOVb2tURms8izkPX2bY5ABAlZEjwOSW+rSLcouShCXRPurZwJJW9+GB1e9amm636EOYeUvsmIiWrcvS4himX3x9MDYS/ZJqlpWrQ6zSOls4NkMuTBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359598; c=relaxed/simple;
	bh=vtpZ0m9AT8C+oeZBqgjv+QOJtFQz8dCFsvLGUGtbHRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oh2SHnX90InMfYhu8IfzQ9IBRQQKkRNkON7VaCuXwL56Apg5+33V5FMiiAeuHBEqtrqI/I0yZdjMkml6y9EuiGR0zqwdl4Up6w0VQXhVELx4I9LGWN0XD4PDHsTIEa6ufTMD/9GMCLL2x4Uc+OUHD/+aNqsXDb3qsyJR/MSuijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=weZui6S4; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707359594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCEnBpcFOe2C77Vjk6R5fbEVUxas4awh0L6SVKgqthY=;
	b=weZui6S4T5IvHb+TGoDKMyuF0wqgoxEl+MwiUCXhxT0Byj4eY3WO+9hTkCOHADRHRPdAVB
	UAuJ7a1R632aAgbm3fe4L57GphGBpIK2/1FzbA8KfdBeE/MTAMk568fpswQFaDvDEjISCH
	VGiR5eGWY7km86874ZBREE9N2wQx8rw=
From: chengming.zhou@linux.dev
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH mm-hotfixes-unstable] mm/zswap: invalidate duplicate entry when !zswap_enabled
Date: Thu,  8 Feb 2024 02:32:54 +0000
Message-Id: <20240208023254.3873823-1-chengming.zhou@linux.dev>
In-Reply-To: <20240207154308.bc275f3e72ec1c1fd06cf5a2@linux-foundation.org>
References: <20240207154308.bc275f3e72ec1c1fd06cf5a2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

We have to invalidate any duplicate entry even when !zswap_enabled
since zswap can be disabled anytime. If the folio store success before,
then got dirtied again but zswap disabled, we won't invalidate the old
duplicate entry in the zswap_store(). So later lru writeback may
overwrite the new data in swapfile.

Fixes: 42c06a0e8ebe ("mm: kill frontswap")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zswap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index fe7ee2640c69..32633d0597dc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1516,7 +1516,7 @@ bool zswap_store(struct folio *folio)
 	if (folio_test_large(folio))
 		return false;
 
-	if (!zswap_enabled || !tree)
+	if (!tree)
 		return false;
 
 	/*
@@ -1531,6 +1531,10 @@ bool zswap_store(struct folio *folio)
 		zswap_invalidate_entry(tree, dupentry);
 	}
 	spin_unlock(&tree->lock);
+
+	if (!zswap_enabled)
+		return false;
+
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
 		memcg = get_mem_cgroup_from_objcg(objcg);
-- 
2.40.1


