Return-Path: <stable+bounces-179547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B6FB5647A
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 05:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B134B423A7D
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 03:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1C23504B;
	Sun, 14 Sep 2025 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayfTv6kg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300BEEBD;
	Sun, 14 Sep 2025 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757819845; cv=none; b=glM+BeJNihUO+J9ge+TAlfmxgqCXsOt2iZ16Zci/VbYWvWGku0z36HfLk/p8ocu2ceLqk0t1Hf9vuwbhmy00E2qkGKHsuEu6TOgefNSr6Z9gu3ezCrxp3sDQawE/pJDWBW1rxEL/2V1AZBJXdeaMCAP2rnasrqvDW9u7l4FB6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757819845; c=relaxed/simple;
	bh=N3Bq1lBNiGb8iUjR18jIPX6Gx2fzM5lXJnRk+eEJAqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBivkT9xyO1DJctIznZ9CKRa2CPy6MMS8F20mjXPLnhi9kigGC93zOxHcSMXmgAoGqo0puQAEK1ALBxaMkd6WfriEb6Q6eeeei9dEciRY540HuX8ljaRQLXJMrFDFdPl/Y75gWwJeMTsu/5TEZfxLz8pRDE8g86KoIWxQWYXQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayfTv6kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3894C4CEEB;
	Sun, 14 Sep 2025 03:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757819845;
	bh=N3Bq1lBNiGb8iUjR18jIPX6Gx2fzM5lXJnRk+eEJAqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ayfTv6kg2S29t4XF0ABImmmnmzkszetRht3pMF/1aMRwTDoqF+cbyP3IkZ6DMJWwc
	 1e+8N0F43iLbL/QdbtdqugVO5RAcVKpqHJh45p/8I/jreLxsDSTe6krd6bq1F9UCgl
	 trlF8x84uYPosyu0Qiv7QiRZZcforB3iewj2rMbrSGaVXRyZuGN7/H+vaBjCfCPNcj
	 ilVd06LswhvVe/xZmJtAka+DUMJkPZ2+qj72kPRRtljzpWmTg2gkiQyKX8aRJqCYMd
	 6GVg3fmkexRdbaoAs5UhpdNPd2OcVZqPkCXzjp16Lqog7cGzporx6dnlwCWMz1BaBA
	 m8oC5KQ6r7Drg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Quanmin Yan <yanquanmin1@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	ze zuo <zuoze1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()
Date: Sat, 13 Sep 2025 20:17:21 -0700
Message-Id: <20250914031721.1782-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091328-batboy-overexert-6511@gregkh>
References: <2025091328-batboy-overexert-6511@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quanmin Yan <yanquanmin1@huawei.com>

When creating a new scheme of DAMON_RECLAIM, the calculation of
'min_age_region' uses 'aggr_interval' as the divisor, which may lead to
division-by-zero errors.  Fix it by directly returning -EINVAL when such a
case occurs.

Link: https://lkml.kernel.org/r/20250827115858.1186261-3-yanquanmin1@huawei.com
Fixes: f5a79d7c0c87 ("mm/damon: introduce struct damos_access_pattern")
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: ze zuo <zuoze1@huawei.com>
Cc: <stable@vger.kernel.org>	[6.1+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit e6b543ca9806d7bced863f43020e016ee996c057)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index cc337e94acfd..7952a0b7f409 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -157,6 +157,9 @@ static int damon_reclaim_apply_parameters(void)
 	struct damos *scheme, *old_scheme;
 	int err = 0;
 
+	if (!damon_reclaim_mon_attrs.aggr_interval)
+		return -EINVAL;
+
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
 	if (err)
 		return err;
-- 
2.39.5


