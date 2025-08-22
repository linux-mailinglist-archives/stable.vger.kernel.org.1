Return-Path: <stable+bounces-172486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115AEB321E1
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696DA1D63A1D
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD18429B237;
	Fri, 22 Aug 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM39cQLp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67459299AA9;
	Fri, 22 Aug 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885628; cv=none; b=W7ez/Vl+RaLMO+g2WCWnad2lbEcVDHhI6/QOVflplKzPdnzoHECA5VdibcEeL3dgtaFJNQxH7gFt9OURvYpS37opwEQ6E/gFkZWnCex0+PYmcTJDNL0b1vpLU6R5a49sQSe9pTRWhyjPbV/cO24mdWxV3LcTp1JDo28T5ZNWRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885628; c=relaxed/simple;
	bh=+5NIoRI3gqVex+BUi5UZsNV1yheEo0BfWMcN1z3yUSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q41Se3qv5bX1iJROmmzAGsETwYDdFk+PfS/t1UHobUq4nDQkjIvOvgbKB9pTy0OJlyF/OmoEvOvH5TSVmCs9K4DOW5CIF1lXEYOQTvxG1joUTMG5N+BYElNDyUj/LOKEJ1xI0RK8YauPtqh2f++pT2uFEzR6xN7CueYcRz1MA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM39cQLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31DCC4CEED;
	Fri, 22 Aug 2025 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755885628;
	bh=+5NIoRI3gqVex+BUi5UZsNV1yheEo0BfWMcN1z3yUSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DM39cQLpXocbfHciUQyB13E5+LoZ9yMqZwjosYd3WryN1bSmWKHUovDu9cWyHfmrZ
	 F1Vnabz9BnTGW1hhUyaEdKJGAEH/JHNDFVO/2xJ6bHe7k7JNMGtQU/HdqC/8tc2NIh
	 TfjsQPWZoKxnfk3PMB8skY6hApMiAut6WFn6x4ijyIv+GdwSLCGW1bS/Nwa2Yb5XI/
	 1f4F/uZyMLRpLbNT5QiYN14yRp5AaDFyRUGLJKozPOR6lgZ/KcRNK17zDkdZm5gqp/
	 WnRIpZnwGgmhKL0yXwRIV5dfJtRp/ScJ9ukg84R5/kWwSWhZfE3EMmlgOby7Cm9W94
	 kU8J+J+BAxlGA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Fri, 22 Aug 2025 11:00:12 -0700
Message-Id: <20250822180012.47379-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822025057.1740854-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 11:50:57 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> include/linux/jiffies.h
> 
>  /*
>  * Have the 32 bit jiffies value wrap 5 minutes after boot
>  * so jiffies wrap bugs show up earlier.
>  */
>  #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> 
> And jiffies comparison help functions cast unsigned value to signed to
> cover wraparound
> 
>  #define time_after_eq(a,b) \
>   (typecheck(unsigned long, a) && \
>   typecheck(unsigned long, b) && \
>   ((long)((a) - (b)) >= 0))
> 
> When quota->charged_from is initialized to 0, time_after_eq() can 
> incorrectly return FALSE even after reset_interval has elapsed.
> This occurs when (jiffies - reset_interval) produces a value with MSB=1, 
> which is interpreted as negative in signed arithmetic.
> 
> This issue primarily affects 32-bit systems because:
> On 64-bit systems: MSB=1 values occur after ~292 million years from boot
> (assuming HZ=1000), almost impossible.
> 
> On 32-bit systems: MSB=1 values occur during the first 5 minutes after 
> boot, and the second half of every jiffies wraparound cycle, starting
> from day 25 (assuming HZ=1000)
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
> 
> Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
> Cc: stable@vger.kernel.org
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> Changes from v3 [3]
> - fix checkpatch script errors

Thank you for doing this, Sang-Heon!


Thanks,
SJ

[...]

