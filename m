Return-Path: <stable+bounces-169865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF0B28F58
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 18:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64D81C25E3C
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39D291C16;
	Sat, 16 Aug 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX9I0BMF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7D23AE9A;
	Sat, 16 Aug 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755360620; cv=none; b=O2ATxAnLXx163PTd7nVPQs7u1riwpCXpxBz5ob7RLQplu/3rU70WunF8j3Jp6aplWft2sbF23ufpCvYq5zflc7IZEea2KGWcnnVzhca/YI1qQCovUuhrS5NKXSKxuvS6yV1GGiDJOVewciDC92xj2BqmdbDeYGlU6B2xw4Bqsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755360620; c=relaxed/simple;
	bh=dvV7dkSDKHOe3uTIJaHJRjvzm9dgErExd276G6LKKEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNLtkGGS+fFNDueL8TK61hgZjvGMwu+UxLE8md4v0zk5Ozyjwoq9L/XdHMY8ntdGW6YZa2AAvyOJTGiPAV+S7vz8JQC/Gj3G3Qbijn7txuq8PuMdPMV8usHG+bZJp1g9sFVIQm+qWW37LIUHIeyzBiNQR6wiCh8Y6fPVe9QFDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX9I0BMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60A1C4CEEF;
	Sat, 16 Aug 2025 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755360620;
	bh=dvV7dkSDKHOe3uTIJaHJRjvzm9dgErExd276G6LKKEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gX9I0BMFfx847u0g9Qcvr0PdLMcjCdGZGNF3ef3Oh225nzkdRmmSTVoBVpORDEx4s
	 Vbt0HW2IdbwcRQ3XJl9I/9OfAP9bsATqnAEHKKTr9iNU3Ga2BB4AanixDYSXvYo6ax
	 qBuedFW/UVm4yMqIUVZy17SCg09iM+yLo/7bfb8efllSCbTPC6nMqE6ItjEY7sbECJ
	 50lIuAVwbMy9wddoBLOid0prubrnqb+gXz3hNPC8n5PyEhFerVndjbK++WyAfcL6U2
	 S72uG1VUmVJ1Y9ac6ISI47bbM0o4GghpRaqRK7oiN9P9v+i3xw3EqiW9pqqlataqs7
	 5io568DjxjABA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/damon/core: fix damos_commit_filter not changing allow
Date: Sat, 16 Aug 2025 09:10:17 -0700
Message-Id: <20250816161017.63692-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250816015116.194589-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Sat, 16 Aug 2025 10:51:16 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Current damos_commit_filter() not persist allow value of filter. As a
> result, changing allow value of filter and commit doesn't change
> allow value.
> 
> Add the missing allow value update, so commit filter now persist changing
> allow value well.
> 
> Fixes: fe6d7fdd6249 ("mm/damon/core: add damos_filter->allow field")
> Cc: stable@vger.kernel.org # 6.14.x
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

