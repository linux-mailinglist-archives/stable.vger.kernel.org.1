Return-Path: <stable+bounces-134704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99492A94348
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C634F3BF453
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511D11D63FC;
	Sat, 19 Apr 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzeS+pJs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118721D5CE8
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063444; cv=none; b=UfmMCgbnoHsukss1LNvnZ0yxo5LUlggGvP9cJpU5mCKOJ7dlWE1XDscoyPBnwy1xsDs8fCNSvU1E4zzNioesRhW24HfrZ8xgruXI1UWEgZxe+g2DRBb8g7v3dyJfDWS0ih5i99fmp5tmPGrPsoDrDS9zvTog4qhqcngR6CXWo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063444; c=relaxed/simple;
	bh=uTvaMv30uen2oJhwQ5GJPtyl2pxb4qXgtiBV/lZBZdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL+J0cUJsSmF7BXDBhaxkzSmOFp14QFRo8rUf3xt1FHPpCfNL2qYWDVi8gkoNvybD6GEuNtDFaGCEQPwxs45U2OWq2yI0JoOKkz3RB3Rjh/LgDhFNaic1bZKKfZQtiOTSsuIx4szXgaBPcndHWpoPXewGQPNlsiukOUteqFMEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzeS+pJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76369C4CEE7;
	Sat, 19 Apr 2025 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063443;
	bh=uTvaMv30uen2oJhwQ5GJPtyl2pxb4qXgtiBV/lZBZdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BzeS+pJsexEIgNnsKnyp044Bh+ZyQGzRvYxg9iE3JuN6DZ9MfMZyfbTyGY5BVsZn3
	 Jgyj3zgnPaXyjv8as0eic3TdaM+2qALtB2uxNk/HxQXSNkGiehU33O8R6P64AIU5sN
	 wsNg3aF4KrogBM9ISz6GOt7UGfHKZer4/B/K6CsjaGFgQbsvFboV5IdDx2roGW96VY
	 OSyouzcTM14eLhqvxJtRWB9VlMpGMzhEGxBiUyJYUmOvWlzCIrhF8V78QYisJ1Kj1a
	 GwecIPwVpVgGKhUuabAWFhzHTlNwJ+j+0sdboKoB9tTgzpejHvojpK6AxqCuHrlRRQ
	 dSkPDFWA771vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhi Yang <Zhi.Yang@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
Date: Sat, 19 Apr 2025 07:50:42 -0400
Message-Id: <20250418202234-b96311b8843d9891@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418030314.1404446-1-Zhi.Yang@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: fd7b4f9f46d46acbc7af3a439bb0d869efdc5c58

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhi Yang<Zhi.Yang@eng.windriver.com>
Commit author: Qun-Wei Lin<qun-wei.lin@mediatek.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 2d2b19ed4169)
6.1.y | Present (different SHA1: 397383db9c69)

Note: The patch differs from the upstream commit:
---
1:  fd7b4f9f46d46 ! 1:  882fab17b75b7 sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
    @@ Metadata
      ## Commit message ##
         sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
     
    +    commit fd7b4f9f46d46acbc7af3a439bb0d869efdc5c58 upstream.
    +
         When CONFIG_KASAN_SW_TAGS and CONFIG_KASAN_STACK are enabled, the
         object_is_on_stack() function may produce incorrect results due to the
         presence of tags in the obj pointer, while the stack pointer does not have
    @@ Commit message
         Cc: Shakeel Butt <shakeel.butt@linux.dev>
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    [Minor context change fixed]
    +    Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## include/linux/sched/task_stack.h ##
     @@
    + 
      #include <linux/sched.h>
      #include <linux/magic.h>
    - #include <linux/refcount.h>
     +#include <linux/kasan.h>
      
      #ifdef CONFIG_THREAD_INFO_IN_TASK
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

