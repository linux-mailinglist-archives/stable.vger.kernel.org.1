Return-Path: <stable+bounces-23796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F108868708
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 03:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0EB1C2354A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 02:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D157F9F0;
	Tue, 27 Feb 2024 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cWvlttOB"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E2F4EB
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 02:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000829; cv=none; b=ERX2/kG4VfwMAyGW7Tg8PkwZwwLuADvsHTssvpKCwdAHnH0D30jbxdE97S2/mauGAnLw1B8WvYnqimAc+EeCoawT/ARSXGkrGOtnFUN3CSWg0opZGCyYJCnOIniA0QUnnV8W7/zzGldYLdmmdYrgtv7R7NPZgyBZZqKT6PDb6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000829; c=relaxed/simple;
	bh=TI3FX3GMKKpCTgIkKmWXuclUYf7akDrTz/M3K7utqPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ngwcJbvX/KlDLwgjw3vPKICCvNwLDXlWU1U5/KArg2uue39f1c1W8Kmo6UrwNaGi1oeXSQAsy+PAvBFrll2o+FZinYoMf6lgn5KZqVk4MOIEH+1Z+fv3MUgnZmhJVgodmwYYAvHXHVHZQZd07CuXj2pjy4nSLKj1B/09Cd4CShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cWvlttOB; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709000824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYtPvAZvae/S6KTZmG5D7rlUuaN+AS1MPdHjCvSLr0E=;
	b=cWvlttOB+Yi/QniRjIirW9rr5+/oZy5aaOYUiYIRAcWw3bR+cc7Gfr/FNmaAZ6IArNVbH6
	nhh3/EMW78aoxNUvE5ZWjrlmBl7+90Erexl6g3zMj6m4gyrr/neXInRlRiu+wjQBeEddfR
	mYnhWS6FIBYPpLetosEQQStS/Clnq+Q=
From: chengming.zhou@linux.dev
To: stable@vger.kernel.org
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/zswap: invalidate duplicate entry when !zswap_enabled
Date: Tue, 27 Feb 2024 02:26:54 +0000
Message-Id: <20240227022654.3442054-1-chengming.zhou@linux.dev>
In-Reply-To: <2024022622-agony-salvaging-5082@gregkh>
References: <2024022622-agony-salvaging-5082@gregkh>
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
index 74411dfdad92..19425d698e69 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1220,7 +1220,7 @@ bool zswap_store(struct folio *folio)
 	if (folio_test_large(folio))
 		return false;
 
-	if (!zswap_enabled || !tree)
+	if (!tree)
 		return false;
 
 	/*
@@ -1236,6 +1236,9 @@ bool zswap_store(struct folio *folio)
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


