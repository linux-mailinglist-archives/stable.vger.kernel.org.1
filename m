Return-Path: <stable+bounces-179477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079F9B560DB
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E210562F13
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E301D2ECD22;
	Sat, 13 Sep 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KjfAxYwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD6194124
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767151; cv=none; b=dXbtgqljdXWvoNGsqCA7Iaowd5BC4yvIUVwmkgsvkjxqF1jR3GYZmb7dokzypYjsH3fOQQHx5ypTzVcYxl1FCuJLPPCPLLQ/xtejpu+sd1u/X2/BSVNAg3/7heCOHfZb7o1a1tgdxeXX4FJI9bTk3et/K7NpwMtcEAAdwjG4wn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767151; c=relaxed/simple;
	bh=uUUt6daTDS9s0+M3FKDkcGQYZlNZQ5SCbn1Lyj130B0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m3Z2woYgMT1f6y1kprH0kAey5J2HmjEdZ9F8piAjG780y+T0Mgv3DP3lCYP29vMHyQIB/93MAi2m+SvyR4xAFojxGjR6Ykyuw6vJ8AU1NKx4sFjjJVbQyjPPWn6RrN/NssmKmYd13Izj4q+MW45KTklr86XK0+mMVs+H48eF304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KjfAxYwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18DEC4CEEB;
	Sat, 13 Sep 2025 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757767151;
	bh=uUUt6daTDS9s0+M3FKDkcGQYZlNZQ5SCbn1Lyj130B0=;
	h=Subject:To:Cc:From:Date:From;
	b=KjfAxYwafAOL+5pDPapdkDmzsX92e3ihRX9M7tUwrPwf7hyeRsLbye5sOlFg7jfCB
	 v2w1C23TB3eqfBZwX8Lu5MfggIst+IpjzCSnXJi7hTES+SJaYDbxRBx3z/QUM32h5N
	 omQF/dLLiJLZveTO3FY+QBvTUboUXjogydmhql14=
Subject: FAILED: patch "[PATCH] mm/damon/lru_sort: avoid divide-by-zero in" failed to apply to 6.1-stable tree
To: yanquanmin1@huawei.com,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org,wangkefeng.wang@huawei.com,zuoze1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:39:08 +0200
Message-ID: <2025091308-affix-ungreased-9889@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 711f19dfd783ffb37ca4324388b9c4cb87e71363
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091308-affix-ungreased-9889@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 711f19dfd783ffb37ca4324388b9c4cb87e71363 Mon Sep 17 00:00:00 2001
From: Quanmin Yan <yanquanmin1@huawei.com>
Date: Wed, 27 Aug 2025 19:58:57 +0800
Subject: [PATCH] mm/damon/lru_sort: avoid divide-by-zero in
 damon_lru_sort_apply_parameters()

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

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 151a9de5ad8b..b5a5ed16a7a5 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -198,6 +198,11 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;
 
+	if (!damon_lru_sort_mon_attrs.sample_interval) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
 	if (err)
 		goto out;


