Return-Path: <stable+bounces-179550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3BFB56483
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 05:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6923820060A
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 03:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CD921C18C;
	Sun, 14 Sep 2025 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7PHb6Sn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987D135957;
	Sun, 14 Sep 2025 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757820745; cv=none; b=pyGkHSJI1Z0g02P0AqNI+aR6zPvQfi6P4gmUGjzlSIIdL+qVUmIIGAsOYkxekbEBvreaqRxoS2UTARdefeyin5wQNUXRRYVazovVDjJ2Ma74Ugx0SG2Dcdra/wIW6Q344r1WH1AqtZYeG5wCsSH+QuyT9QlOnkf3ZSeodjt46K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757820745; c=relaxed/simple;
	bh=ebkUiPOPOzzkhwqAHAp0QzL6nd+nxLgun25s4L9H3Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H5YE8yudSs4MfUAjk3k7207nBjRw+80Y3RJAbP7SxQ1eZ/556WP3QkplgcEK/qmXjMQ4229L3pTSRkzAg3/+vg2LFf8mTtI56xcvpAN6q5BjfJ3ZS//d17LEZKs10jYQCVeqS3Df93GUrbTFa0P4tG9qvndFKFV9DqNJgpS6u5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7PHb6Sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC38EC4CEF1;
	Sun, 14 Sep 2025 03:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757820745;
	bh=ebkUiPOPOzzkhwqAHAp0QzL6nd+nxLgun25s4L9H3Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7PHb6SnciR1qdjVcAHeYdKtnRWIx9uNinlbXVouX/3td6JYa6sgZ/al3p9oVLHl5
	 REAEJNIcalT76O4nJOOBKhxP7j1GTt6ew/Hs46xMSTUAO1EM6Kt8IAYTzwcJ1nlWKb
	 9D6N3mj8dWyfBkUygzZPfh1W/t0ysiUzwTqY64L8kfwW7ODP4kQp9BnTl7k4YOIWr2
	 8L4a0nvm09Ro2M2Uu7gIHGWzPKyOvVsWgeLpQ0y/hCDjiEduMZq7N3fMFXXVN6V7wH
	 Pa3ypiC44XSFnq5QuJFEWnoF21h1JbP28KP/XK6IhZMDxexliGcKVQorOHZ+CwTS10
	 OgzyZKNNk4l9w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	ze zuo <zuoze1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/lru_sort: avoid divide-by-zero in damon_lru_sort_apply_parameters()
Date: Sat, 13 Sep 2025 20:32:21 -0700
Message-Id: <20250914033221.49447-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250914032845.1748-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Sep 2025 20:28:45 -0700 SeongJae Park <sj@kernel.org> wrote:

> From: Quanmin Yan <yanquanmin1@huawei.com>
> 
> Patch series "mm/damon: avoid divide-by-zero in DAMON module's parameters
> application".
> 
> DAMON's RECLAIM and LRU_SORT modules perform no validation on
> user-configured parameters during application, which may lead to
> division-by-zero errors.
> 
> Avoid the divide-by-zero by adding validation checks when DAMON modules
> attempt to apply the parameters.
> 
> This patch (of 2):
> 
> During the calculation of 'hot_thres' and 'cold_thres', either
> 'sample_interval' or 'aggr_interval' is used as the divisor, which may
> lead to division-by-zero errors.  Fix it by directly returning -EINVAL
> when such a case occurs.  Additionally, since 'aggr_interval' is already
> required to be set no smaller than 'sample_interval' in damon_set_attrs(),
> only the case where 'sample_interval' is zero needs to be checked.
> 
> Link: https://lkml.kernel.org/r/20250827115858.1186261-2-yanquanmin1@huawei.com
> Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: ze zuo <zuoze1@huawei.com>
> Cc: <stable@vger.kernel.org>	[6.0+]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 711f19dfd783ffb37ca4324388b9c4cb87e71363)
> Signed-off-by: SeongJae Park <sj@kernel.org>

FYI, the commit was able to be cleanly cherry-pcked, but seems caused a build
error.  This patch fixes the build error.


Thanks,
SJ

[...]

