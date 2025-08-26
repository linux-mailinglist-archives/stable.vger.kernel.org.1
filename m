Return-Path: <stable+bounces-176431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A04B37346
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 21:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7BD7C868D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115630CD89;
	Tue, 26 Aug 2025 19:37:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911C30CD88
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237051; cv=none; b=FlbzOoDK1iNVpehedtVK3ccWNifdTEgZ/vXP4KQuhXT0n1phbqzGrAx1w6fGjU3DfZDVkSwCpyD8d26TVHzYe9sB9sW2pCPxi89jq3Jxt2qZKgjnnmpcW+rqjSvfMRsNY9uwprQukjnhFUbXRA6IOkTFdukPF883ZcHTxlBf/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237051; c=relaxed/simple;
	bh=oxs+PvObaK39R+7A1I//vR3NL8vTRnezgDzvQYCuthg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqil1+i3S2Pcabh8ESlw77oSUwsV2v44ftVM6S+n5+bD5sSdAK+m55+NAOsBIjnCt3nfQWEgl21yfQISuE/ywA/P/dcU/1K+Ryo/YDa/J8D22Y+3IEaQhcHtnoPTRwoKI1Kn5neMSbOlqLQ6YsRKNviAlUP36fJWRagpZdzwTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28118C4CEF1;
	Tue, 26 Aug 2025 19:37:29 +0000 (UTC)
Date: Tue, 26 Aug 2025 20:37:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Waiman Long <llong@redhat.com>, stable@vger.kernel.org,
	linux-mm@kvack.org, Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v5] mm: Fix possible deadlock in kmemleak
Message-ID: <aK4M-2ZWN3aq7mwx@arm.com>
References: <20250822073541.1886469-1-gubowen5@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822073541.1886469-1-gubowen5@huawei.com>

On Fri, Aug 22, 2025 at 03:35:41PM +0800, Gu Bowen wrote:
> There are some AA deadlock issues in kmemleak, similar to the situation
> reported by Breno [1]. The deadlock path is as follows:
> 
> mem_pool_alloc()
>   -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
>       -> pr_warn()
>           -> netconsole subsystem
> 	     -> netpoll
> 	         -> __alloc_skb
> 		   -> __create_object
> 		     -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
> 
> To solve this problem, switch to printk_safe mode before printing warning
> message, this will redirect all printk()-s to a special per-CPU buffer,
> which will be flushed later from a safe context (irq work), and this
> deadlock problem can be avoided. The proper API to use should be
> printk_deferred_enter()/printk_deferred_exit() [2]. Another way is to
> place the warn print after kmemleak is released.
> 
> [1]
> https://lore.kernel.org/all/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org/#t
> [2]
> https://lore.kernel.org/all/5ca375cd-4a20-4807-b897-68b289626550@redhat.com/
> ====================
> 
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

