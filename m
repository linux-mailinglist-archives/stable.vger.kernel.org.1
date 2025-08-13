Return-Path: <stable+bounces-169469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D3B2570E
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 00:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3869016E957
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CEF2FB992;
	Wed, 13 Aug 2025 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="17ddbz9y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5FF2FB982
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125777; cv=none; b=KRg8vK6+8GwJ9Cg/6ONsbLRmYGhB6AZVZFc+0OkBp4djAYIX26DWVJqz4RKtZ8upf5a1Oj3UUKb4ix75R/pmqeSRaRr54i2KMfeHmt7p1yloGp1M0jGCel5943+Z5ehgbZnfCPn53qRZo8KG1reR7IdXuhw04pQuuiys8ZRkKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125777; c=relaxed/simple;
	bh=d23EsXtELamPsXVJ4AIY1uWBmbAVOZMh52loO7Lxxis=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Hvs2YCC8XJF32W6STEiyBpElBeiUAIPanPEUWaFPok1v9OwU+G7KfVB0s8VtJcuKlRIZPbkgpHt5Cm56+MBtxEO6WkuZTHJWdPWUFh1GNirxL1bWiyO75+K23rJqxWcfQDMWzbTZu9fUB3kfII1Lgt4Wenx5Bamaz+xUH36fp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=17ddbz9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA8EC4CEEB;
	Wed, 13 Aug 2025 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755125777;
	bh=d23EsXtELamPsXVJ4AIY1uWBmbAVOZMh52loO7Lxxis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=17ddbz9y+pgU9Mv5Ai+T+ED66rlk3aQvwnrd9ondRRsX+nwL5+OUQz5KCMxADNpzo
	 XoEzH0Wxz0Bz4/JQLfK9ZIdazh/gpylEDQI3B77MJVk6Lw6hiUEBwIzOJVWNMD2efA
	 hL2yIjlNuIX4OkAC4ijVpQqkj3tSxzMHJcT1vRVw=
Date: Wed, 13 Aug 2025 15:56:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, <stable@vger.kernel.org>,
 <linux-mm@kvack.org>, Waiman Long <llong@redhat.com>, Breno Leitao
 <leitao@debian.org>, John Ogness <john.ogness@linutronix.de>, Lu Jialin
 <lujialin4@huawei.com>
Subject: Re: [PATCH v3] mm: Fix possible deadlock in
 console_trylock_spinning
Message-Id: <20250813155616.d7e5a832ce7cda7764942d10@linux-foundation.org>
In-Reply-To: <20250813085310.2260586-1-gubowen5@huawei.com>
References: <20250813085310.2260586-1-gubowen5@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 16:53:10 +0800 Gu Bowen <gubowen5@huawei.com> wrote:

> Our syztester report the lockdep WARNING [1]. kmemleak_scan_thread()
> invokes scan_block() which may invoke a nomal printk() to print warning
> message. This can cause a deadlock in the scenario reported below:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(kmemleak_lock);
>                                lock(&port->lock);
>                                lock(kmemleak_lock);
>   lock(console_owner);
> 
> To solve this problem, switch to printk_safe mode before printing warning
> message, this will redirect all printk()-s to a special per-CPU buffer,
> which will be flushed later from a safe context (irq work), and this
> deadlock problem can be avoided. The proper API to use should be
> printk_deferred_enter()/printk_deferred_exit() if we want to deferred the
> printing [2].
> 
> This patch also fixes other similar case that need to use the printk
> deferring [3].
> 
> ...
>
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c

I'm not sure which kernel version this was against, but kmemleak.c has
changed quite a lot.

Could we please see a patch against a latest kernel version?  Linus
mainline will suit.

Thanks.


