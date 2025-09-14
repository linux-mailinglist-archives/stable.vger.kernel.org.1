Return-Path: <stable+bounces-179551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E50B56484
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 05:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A8A7A22D2
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 03:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EB9258CED;
	Sun, 14 Sep 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYiudA3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA34502A;
	Sun, 14 Sep 2025 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757820835; cv=none; b=Rw5/BNzs5upRJ8Zj9eDSZR8wPfZ6oAZJWVNGYi4LsNCTX3+yFzoIlwql5C85YSAZguzGcwBWfHvlYJzIOPbWtsmaMYpIvg06MREvYloP48vb0rkay2lXqZQMf/7kcQ5xnaL5VlFj3ItioZfhmx+1JchqhP4IkP5t4lK44rZ/A0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757820835; c=relaxed/simple;
	bh=C7uDg4mWAymr0VhMJyfYAgxltCUj6zFpE1frXnGWO4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjRh0ENhRgqSsmVnVV7Lbb/gKZSfVy0bpP7KOscmXNM7DUY9+Impo8/+Q6qLJ7y2bO/XbQwkhvrfT/Z2as37G77A1T2NPjMj7eVHmPSpQswmFhe5gBX7NIFny4VGjfJzaFHQFrnLtqxpixuFGLt7OT254fE/xlvS80YD9bCSAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYiudA3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6A9C4CEF1;
	Sun, 14 Sep 2025 03:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757820834;
	bh=C7uDg4mWAymr0VhMJyfYAgxltCUj6zFpE1frXnGWO4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYiudA3WD1QwX2tWliFa11eSrFIe8MqR7ceZ44fgWFNVT+HZVxd+3uVinX4ebFSxO
	 nrj9Fjm9Ht52jWxfs3wIH7AaFq99AEcUK/x/G+i7buTisidsJv8vjEoIVjyUyjhimc
	 YVSqJbpCyhT8P9B9FKdsehgs+NofrqMXSEBs0rJHRso9B98cT7yjLEKpWqor9JiHeW
	 dkn5WaNvTWCjosyg+ZBIw0iIN4Asifey8uSdZbQLZ9nDWSYx+12B0C55G8NEWcknfM
	 P7UPkXAJ6UrpMJNVnNBDRNumXFcdLSU6jlRnpO0TM7db16O7g/OoJ+LguUZMWHE69Z
	 voJZyTQ6tbu/A==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Quanmin Yan <yanquanmin1@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	ze zuo <zuoze1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/lru_sort: avoid divide-by-zero in damon_lru_sort_apply_parameters()
Date: Sat, 13 Sep 2025 20:33:50 -0700
Message-Id: <20250914033350.2284-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091317-snowsuit-earthen-6ad7@gregkh>
References: <2025091317-snowsuit-earthen-6ad7@gregkh>
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
index 3de2916a65c3..b4032538b22c 100644
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


