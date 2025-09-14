Return-Path: <stable+bounces-179548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E400B5647F
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 05:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8A9423D99
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A5B25784F;
	Sun, 14 Sep 2025 03:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdnycFfi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7021254B;
	Sun, 14 Sep 2025 03:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757820142; cv=none; b=uQ5H8iBSpbarjKVQwTCht8cFCeprqHNzXg8JF00C8txkgTUqzQCP+cRv2QkAyls70pmsfu4vupVbFfuR/V5MdO77hJ2tCUykm29xXmmF/sOMV0i4kIqmpGZqI+eqOI7pwQn6WFsVm/oteB50KQ/sNleK0VQfJF9bDuXXzI6tP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757820142; c=relaxed/simple;
	bh=El6nVhFI97/oYWWUFLD4ND//Mg+FlQlLf38ySjrt6UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOMlkFF36pulzOI3iYq6iCXsp5vg9jj8uqw+9QV1YCEyHYkU0bU3ul85wsm0/GAL9trzrtcwyvIYsQyrsvx51oRx9H7VK/NMBRpgDq4Hd5C10GDw01JzZ/gCMSCP2M6paITWd6gzS8T/jXAFkZYnRZXYOgQxghSPfTG8ifKW1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdnycFfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1744EC4CEEB;
	Sun, 14 Sep 2025 03:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757820142;
	bh=El6nVhFI97/oYWWUFLD4ND//Mg+FlQlLf38ySjrt6UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdnycFfis1X5QLtBy1vkrNo3m4N6RsbPiZ4x3yDRg40L4zak2RsiiFioj72hCbKHW
	 +6mqUqcSSR8YhbNwnQ17frYsxm0pFcnb8yZD1L9+mnsK1ixPnBZoZVOiqkXApshn1+
	 IHtrIJTXTEE9PU3nYtlHCBaOB/mFD26687rF5pK/cUfwpRqcduN9IEnsOOKzvTAfxz
	 WpZnIBG6jXzogD1A9iTAM8tcxfSQFJntvNLXqhEf4oBv9624LLqIOhzBrFy0RYO/9K
	 /JzfKhzb3dlesv4idyVRFw+EFMm7v7ydh2oZR8J5s3nMA56gGf8TKxcWSv4gV5ZviI
	 gWt4AlipFv9dA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Quanmin Yan <yanquanmin1@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	ze zuo <zuoze1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()
Date: Sat, 13 Sep 2025 20:22:18 -0700
Message-Id: <20250914032218.2285-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091328-reversing-judiciary-ca17@gregkh>
References: <2025091328-reversing-judiciary-ca17@gregkh>
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
index 66e190f0374a..586daa2cefe4 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -167,6 +167,9 @@ static int damon_reclaim_apply_parameters(void)
 	struct damos_filter *filter;
 	int err = 0;
 
+	if (!damon_reclaim_mon_attrs.aggr_interval)
+		return -EINVAL;
+
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
 	if (err)
 		return err;
-- 
2.39.5


