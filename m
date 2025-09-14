Return-Path: <stable+bounces-179546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73562B56476
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 05:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F032A0C46
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 03:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C594248176;
	Sun, 14 Sep 2025 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twLnKCqV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1DEEAB;
	Sun, 14 Sep 2025 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757819477; cv=none; b=Ydp1CMlRpwloFflC/Zf3/xwTUuAxk3JslRJo5LlZg9mQOJuu7ie/OQ09O1cYUMkDTGv8vL/eYGsMiX8ZNuqsDTagmZ42I34Ppje4v6tmQuFGcPpFVaysp80xMQOm9LZeXEVncP+PBSOrO9ovuFsbBm5Pb6TB7T2s/flmlx3s114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757819477; c=relaxed/simple;
	bh=5hMrbR5LpkI7tlDHhuOTtEAX9Z5OL/xteiwO3VbdpSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDftUAU+fnlxAzZB7fTudvm0IYt12r5x2tBn/foam/dyCYR4nKpA4nTuTfZhGrZ4WtQvXzRca26RHGIrBnoA3OYkgAMLWBgAXYcfgp1dHPgOSxBZa6JfY/y8wL61QZxFzlYG+Ms2vXGS8Tsj6IyUwLNr+/gP2SenTElLfmQ47ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twLnKCqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33478C4CEF9;
	Sun, 14 Sep 2025 03:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757819477;
	bh=5hMrbR5LpkI7tlDHhuOTtEAX9Z5OL/xteiwO3VbdpSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twLnKCqVp2QSLomhtOX/P8B5KkFUFQa2Jdeli4ipN9dGQ5ye2n/4OsU6bJSjoKIA/
	 BIaRM/NTcDc4djCCDnUVJ4dH5cBV7DfhehwYuowOPWumuKVUovMK40EOlgS9mD2DIN
	 wiv5eQhmAPnhAvKv8hCJlKAA3BXnyELh7Km1L0loBcVOBrRgkdL4YLVUD3cqPT3jx9
	 jlxpgbSMoubyFFBKFsBxZ6xMqNgrsCcSe7lgH51qhJzj9FXMQQZXgOSzt/eN8gup4F
	 Svd3qedYlVmukRiU1J9HKOIhoVeXEYYE5+qMoVlv407anm1XkM7Kye+THdgOzQXnox
	 ZGk6R9BuPKAyA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Quanmin Yan <yanquanmin1@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	ze zuo <zuoze1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.16.y] mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()
Date: Sat, 13 Sep 2025 20:11:13 -0700
Message-Id: <20250914031113.2390-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025091327-cyclist-impeach-ca7c@gregkh>
References: <2025091327-cyclist-impeach-ca7c@gregkh>
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
index a675150965e0..ade3ff724b24 100644
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


