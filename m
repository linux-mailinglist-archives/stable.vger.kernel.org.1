Return-Path: <stable+bounces-179549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98275B56482
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 05:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F494189BCF0
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 03:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A9D258CE9;
	Sun, 14 Sep 2025 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4xYnGjq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6971891AB;
	Sun, 14 Sep 2025 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757820530; cv=none; b=Itm8dgt3p9EUOCNBpG8z0f8XOylj2oZZSi7CW2um3H68wWDsPnAyO4QgpfIhW8eqCpHlIBDK8xqvoTt4eVxJ4jTWiCmpbkSvU61e6MqvWyiKb3SDluSiRoFUQgJJo7/kpc1EmY57IDjxieIJWui9UMgZlvZEx9n4i50HK9ngkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757820530; c=relaxed/simple;
	bh=zKFUO0dAbe0G3kl5KxkzLbQ5BddyyVWMYls3G9oKbrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/tiHXf8T4OlkTxFqAYMup0mgBYqAjADNJcsJh5NFYh0w/p7N/fNoOj8hC2t01NXTvDypgma8GxIwmOVCNOXiP72rCvwIRUtcZZD/8qs+FzNwr64BmwBqOQ6vLJkTNbCSGwSE/V/LAYaac9oUlVcteli39g6GOiy0v76Swz23O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4xYnGjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9EEC4CEEB;
	Sun, 14 Sep 2025 03:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757820530;
	bh=zKFUO0dAbe0G3kl5KxkzLbQ5BddyyVWMYls3G9oKbrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4xYnGjqhLL1FdOh24PGzgFTf6h8xI+eGs6WuepI8FiYe28LXfCl/Cq7yi6rmvbdC
	 kiUoVL25aIEP8QUG0/uD+tKRVEbmUn4o6aVsGSOYsE0sWJleXlFaUIgn0igsERJiOs
	 LrbtfDOQ1EkxLXqEPCNcUrsGB2XsmzWgaDBRlyED00gRjKmkZJr9qnuyx3/W+26/o1
	 KDl1t1tbqOc6aw9wEVoqQN+qkqTK93lRQGscfSqArfp6tWp25KoMfcmOmPkAgniNPI
	 ey6R25GrvczG4ThwPby0xzOoYNXd8aMY5kshQDrqWnEwSN+jNQNgXZ+SoUZVroHzxr
	 Wp58En1UfYQRQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Quanmin Yan <yanquanmin1@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	ze zuo <zuoze1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/lru_sort: avoid divide-by-zero in damon_lru_sort_apply_parameters()
Date: Sat, 13 Sep 2025 20:28:45 -0700
Message-Id: <20250914032845.1748-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091308-affix-ungreased-9889@gregkh>
References: <2025091308-affix-ungreased-9889@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quanmin Yan <yanquanmin1@huawei.com>

Patch series "mm/damon: avoid divide-by-zero in DAMON module's parameters
application".

DAMON's RECLAIM and LRU_SORT modules perform no validation on
user-configured parameters during application, which may lead to
division-by-zero errors.

Avoid the divide-by-zero by adding validation checks when DAMON modules
attempt to apply the parameters.

This patch (of 2):

During the calculation of 'hot_thres' and 'cold_thres', either
'sample_interval' or 'aggr_interval' is used as the divisor, which may
lead to division-by-zero errors.  Fix it by directly returning -EINVAL
when such a case occurs.  Additionally, since 'aggr_interval' is already
required to be set no smaller than 'sample_interval' in damon_set_attrs(),
only the case where 'sample_interval' is zero needs to be checked.

Link: https://lkml.kernel.org/r/20250827115858.1186261-2-yanquanmin1@huawei.com
Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: ze zuo <zuoze1@huawei.com>
Cc: <stable@vger.kernel.org>	[6.0+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 711f19dfd783ffb37ca4324388b9c4cb87e71363)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 98a678129b06..61311800abc9 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -203,6 +203,9 @@ static int damon_lru_sort_apply_parameters(void)
 	unsigned int hot_thres, cold_thres;
 	int err = 0;
 
+	if (!damon_lru_sort_mon_attrs.sample_interval)
+		return -EINVAL;
+
 	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
 	if (err)
 		return err;
-- 
2.39.5


