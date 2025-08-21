Return-Path: <stable+bounces-172206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85B8B3017E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 19:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43B53A5F1D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B32338F57;
	Thu, 21 Aug 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh6qw56/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FB1FE44D;
	Thu, 21 Aug 2025 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798789; cv=none; b=eY/PA8UrOdMNM1PUnE4GeaT/dhGQsJTjdudnErJBsWf5bNMGnLtCWO2tMDK+ioJSg2JjDXYfjmUydFDc/m3dm2wHQugYWjCWDUVgi/3lpR29wooApw4honGk3cj236aSc/5qhmWHSP8Cp4QmPWq9rGDz+PET6NinwT9y88Ae2XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798789; c=relaxed/simple;
	bh=HkSJibYAsBk+7KP9bP1bTvrw2NGup1d12g9fEzw+9e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6CN4IhJMo8RWgLoy9E2es5DAxpkrQtOS3b9bIyGIt8GJhiBPOAJU+JPyPak8oaJkgTuIaBjL06ab1RHduik70SKOe1S74cFrXlCR5hzdTnM4lHIbhAV27ZFPk3EXZst8YxPOjIreJFKLV92zyr6n81onC0EmD+JWlJpClHw4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh6qw56/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFB5C4CEEB;
	Thu, 21 Aug 2025 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755798788;
	bh=HkSJibYAsBk+7KP9bP1bTvrw2NGup1d12g9fEzw+9e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vh6qw56/5TCRJBeoEyYFxuGjnHdIl62D3lD+4oUm9BrnAlZOENKlkw2cNDA5pxA0N
	 zbmDSfe+l1ff6aXaymdNeyugqMpSAS8xZtUfB4782aF916hoIri8Zr4X2h5ImrxFwN
	 x29SAXXKL09OySO0DZWKsy59QOX5wk5OXAT0/lZvpvrjPE9agaIvYbIYyisNTxox1C
	 UvxzUSUowp6IN7N/Toerpz9O0ifNHCqmwCXuNGOvHAoAoEM1jikMUx6VBcuHm4RA5c
	 0rYadFlZwAWd1UOk1Wl1RALPu1rCx8Whkaj7V0q+5J8hr6PQsevFSdmw7BN4Sxsy6d
	 oDrJw0quz0+KA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Thu, 21 Aug 2025 10:53:06 -0700
Message-Id: <20250821175307.82928-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821163346.1690784-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 01:33:46 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> include/linux/jiffies.h
> 
> /*
> * Have the 32 bit jiffies value wrap 5 minutes after boot
> * so jiffies wrap bugs show up earlier.
> */
> #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> 
> And jiffies comparison help functions cast unsigned value to signed to
> cover wraparound
> 
> #define time_after_eq(a,b) \
>  (typecheck(unsigned long, a) && \
>  typecheck(unsigned long, b) && \
>  ((long)((a) - (b)) >= 0))
> 
> When quota->charged_from is initialized to 0, time_after_eq() can incorrectly
> return FALSE even after reset_interval has elapsed. This occurs when 
> (jiffies - reset_interval) produces a value with MSB=1, which is interpreted
> as negative in signed arithmetic.
> 
> This issue primarily affects 32-bit systems because:
> On 64-bit systems: MSB=1 values occur after ~292 million years from boot
> (assuming HZ=1000), almost impossible.
> 
> On 32-bit systems: MSB=1 values occur during the first 5 minutes after boot,
> and the second half of every jiffies wraparound cycle, starting from day 25
> (assuming HZ=1000)
> 
> When above unexpected FALSE return from time_after_eq() occurs, the
> charging window will not reset. The user impact depends on esz value
> at that time.
> 
> If esz is 0, scheme ignores configured quotas and runs without any
> limits.
> 
> If esz is not 0, scheme stops working once the quota is exhausted. It
> remains until the charging window finally resets.
> 
> So, change quota->charged_from to jiffies at damos_adjust_quota() when
> it is considered as the first charge window. By this change, we can avoid
> unexpected FALSE return from time_after_eq()

Thank you for this patch, Sang-Heon!  But, checkpatch.pl raises below three
warnings.  Could you please fix those and send yet another version?

    WARNING: Commit log lines starting with '#' are dropped by git as comments
    #16:
    #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

    WARNING: Commit log lines starting with '#' are dropped by git as comments
    #21:
    #define time_after_eq(a,b) \

    WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
    #26:
    When quota->charged_from is initialized to 0, time_after_eq() can incorrectly


Thanks,
SJ

[...]

