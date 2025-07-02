Return-Path: <stable+bounces-159179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14BDAF0735
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 02:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB29C1C06B32
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3111C32;
	Wed,  2 Jul 2025 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1Kkziel"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69771361;
	Wed,  2 Jul 2025 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415546; cv=none; b=Su+UEjnb8eCDEZeQySPgGXLX5128+AS3C0m5JiguNHw5aaWRKcZNfYok2LBE8+N9o5kcTnoJzzsRIWMQpaTTSYuRtW2ZU1yCnPkkez39iZnYwLx400I39mfWmnFQOWTfvEvqCtlhf2s+9MNjmVf3fHTtt3JNG8zT5aP9rxn3lCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415546; c=relaxed/simple;
	bh=7bxXGamIholbw7+4wzB+BHOO+zX+wIAamKMjO2n1EY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AosI579OwFIDU6whDdlG+HhlA8F5NFryHeDwTkLiZiJoHfB0jHO66x3f8DScDsEaZc3ksNhi47oLgfIJAUTVXn58EU/rmVwknwABLp5w/HwwI1tLMp6AFbqySrMVFxnUDLe4nxF8S04GmzGMa4E4aa3NWa7MlGHe6Fkf3VOQkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1Kkziel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974BCC4CEEB;
	Wed,  2 Jul 2025 00:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415545;
	bh=7bxXGamIholbw7+4wzB+BHOO+zX+wIAamKMjO2n1EY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1Kkziel5JT+mt+BbAP0GklAlCCvf0PmJm2wYMYvKor5d3e3BVSAsKzQj7eTVKB9D
	 TuV5YrCgzN2oxKe7UOpyaZclF2ZmiNRz3JgxTEFBJd51t+vevyg76JCrUro8DmYwHK
	 P7ZKUiZa3HR3wryTn6eXj/OdquHKSsq9fwsR6hIFAyPi9dSVxKCqe/KudwA263OnXh
	 DDtkCnadu3k9E+xhy/uMD97nk5+MV9ZKjU9C/3zgkCjhhh0yqEezb8zTm0rx1d1J39
	 7Femx8GnfJ/yEYnI2i4fl2Jj3YecHz2wI8Kfjh6IWCHMP1bN2Dya3HezA2QbJAeoVM
	 Qi8bMJWAo4PPQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm/damon: fix divide by zero in damon_get_intervals_score()
Date: Tue,  1 Jul 2025 17:19:02 -0700
Message-Id: <20250702001902.937-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702000205.1921-5-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Honggyu,

On Wed,  2 Jul 2025 09:02:04 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> The current implementation allows having zero size regions with no
> special reasons, but damon_get_intervals_score() gets crashed by divide
> by zero when the region size is zero.
> 
>   [   29.403950] Oops: divide error: 0000 [#1] SMP NOPTI
> 
> This patch fixes the bug, but does not disallow zero size regions to
> keep the backward compatibility since disallowing zero size regions
> might be a breaking change for some users.
> 
> In addition, the same crash can happen when intervals_goal.access_bp is
> zero so this should be fixed in stable trees as well.

Thank you for this fix!

> 
> Fixes: f04b0fedbe71 ("mm/damon/core: implement intervals auto-tuning")
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Cc: stable@vger.kernel.org

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

