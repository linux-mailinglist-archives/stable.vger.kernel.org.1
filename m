Return-Path: <stable+bounces-179552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6CBB56485
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 05:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2A5189DDD0
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCA625DB1D;
	Sun, 14 Sep 2025 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6bOEs6i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232502745C;
	Sun, 14 Sep 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821035; cv=none; b=c3n7x+irrTzJm0S+I3WQWGK2oh28QDApl6itXp5jgEHE90l7Nitb2loYlmCnQbtw8tsrYprm+BDpB87/b7g2acYUr8c4wbdGpHz62yvPRAl3CJUV29JbEhvetFkywu8Azgs/lEfooLbzt3H1m5LLuhJa8Ws735LyylbH8VDbLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821035; c=relaxed/simple;
	bh=bkHe9Vm5JzUUpMMNjnWLXeYD8tWI4frctGkhsHUCOPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2Ci3MSLXLKVdyCrP32p0ZRYaZBThzVu/MeX4pON74r+fiSX32axFiOwRsCEKUEc4NEWF6NHP8ONJt7PSydmWWTonMnJLs90gtkORqMgL6M6iEC1Abff12WvzbUwKoKsAzVJklTbeOVcm8q5IDLgTvk0cuqwMkylpY+c/gjYdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6bOEs6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853D3C4CEF0;
	Sun, 14 Sep 2025 03:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757821034;
	bh=bkHe9Vm5JzUUpMMNjnWLXeYD8tWI4frctGkhsHUCOPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6bOEs6itfiszz+TTmIHgqY9WY6+rOWbxuP8l2TAnhHcrqnwceeH8gTvLTb9eRVcp
	 XMA1sWV4MCX5qhH67Hwbf29YKDAbPLZz8dtBHtcx737+9jOIHuNZTjulwt9qkFGKi1
	 aE962yFCowlOvpCng7qweI7ERZz1qskpa1XJg81IjUPR1N2GEeFNMWcEwjZSDHXfgO
	 kIxOusj/rkNKJlI8lbZLQ2AuE0RKoidok1chpBDxr425mrLZFHomFaDz08R9gs2Nd6
	 adgarw8snTjgunC8oaT2HoAWxCeCr9twtkEfPGhvn3+/yd6Z1Q5i6/DQGZdQym8S4t
	 NrfsWAY/YUChg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	ze zuo <zuoze1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/damon/lru_sort: avoid divide-by-zero in damon_lru_sort_apply_parameters()
Date: Sat, 13 Sep 2025 20:37:11 -0700
Message-Id: <20250914033711.2344-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250914033350.2284-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Sep 2025 20:33:50 -0700 SeongJae Park <sj@kernel.org> wrote:

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

FYI, the commit was able to be cleanly cherry-picked, but seems it caused a
build error, similar to that [1] for 6.1.y.  This patch fixes the build error.

[1] https://lore.kernel.org/20250914033221.49447-1-sj@kernel.org


Thanks,
SJ

[...]

