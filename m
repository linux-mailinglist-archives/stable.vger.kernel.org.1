Return-Path: <stable+bounces-179545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 486A9B56474
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 05:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4171201B8B
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 03:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0921EEA54;
	Sun, 14 Sep 2025 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXmLxIY3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5857EEBD;
	Sun, 14 Sep 2025 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757819099; cv=none; b=ijRHkMd0bGvqfiJT1EJj9ev6ancx4eh7jmEa9WPJND7Q4RyLkobXiYRHXMsWc8q6nKAXGPASOFd3LnoPTnhdjAf9S+6ZWGoKSlVOdZlCERxhJAdV1+wDc+9unrwclN8MVGU+zQpSiiF7Li3wXs1celsWthFI8NIrWgAZFLLxjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757819099; c=relaxed/simple;
	bh=y40KDOWdfDDPNtbMORQTC8pZzhlS+QABKpQZ3J2cRHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qn+4tJhrvz4UJLcGmCoURD117C5jceMNuPmrR7Js1pwqRxKYIEaASVi4qQhU7OoseVDVWv/MODfztmmVJeseMGuSZqn/bI24rFBaUbuhngGsD7Ts/g9vUOpYyKish24kUiHkxPJ03DFDUOS+Qdl4IVMElaqpskBVm7tbFtY7438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXmLxIY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EBCC4CEEB;
	Sun, 14 Sep 2025 03:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757819099;
	bh=y40KDOWdfDDPNtbMORQTC8pZzhlS+QABKpQZ3J2cRHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXmLxIY3P1Kfm3vXs4ki7O7osSIELnVc2Lhlqd3bKM9Q4xtjF8z/sGi4vs4yRy7ra
	 ONAsxpAgh53CmsrY0HbL+HJv1TBcqXeOHcHr4J7j3JNLwXvneXUVZR3W81R2KSZCAN
	 tk6hWZlY4V+/8Q3x3lPMcs3di8vjLSR0Ivr+XfyChKQHZsqaTGTIPENqrkKzB+/JfF
	 +bT99ip1xbM0MB+dbr/FqgJVQhBUKcZ9HBdWMovMJAzdwHUPSsZ3UWKoRQcSod1Ejl
	 3fboLX6/ryy929Uye6hBqDLWEFYVEENsa1SyXEkkf2v4pXGDfqPBAhpbFosOmNRYOo
	 iSgaGLsUCnpow==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Quanmin Yan <yanquanmin1@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	ze zuo <zuoze1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()
Date: Sat, 13 Sep 2025 20:04:56 -0700
Message-Id: <20250914030456.8942-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091327-foil-awaken-b0be@gregkh>
References: <2025091327-foil-awaken-b0be@gregkh>
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
 mm/damon/reclaim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 9e0077a9404e..65842e6854fd 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -194,6 +194,11 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		return err;
 
+	if (!damon_reclaim_mon_attrs.aggr_interval) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
 	if (err)
 		goto out;
-- 
2.39.5


