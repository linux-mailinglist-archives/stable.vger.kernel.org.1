Return-Path: <stable+bounces-169437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1966AB24FAC
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3C73BBAEB
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A864C92;
	Wed, 13 Aug 2025 16:22:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DB24DCE8
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102154; cv=none; b=m4ub0RBIPcqlePOrWZVRrQDfVIjejBv0TCPUosRpRueCkThr8lhxgnGU/RrQH73CZ32FjWHLtmcZQC/m/M4lgVZYMTyoLScCkuQGSD99kuHCC60B1ce/1cMxLq1f3VcVpHjJmQgTA8iBUhlJUNDmD8upuYbP0perEmcr/hHozaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102154; c=relaxed/simple;
	bh=rQpWQn5pth2OOz9vxOMGoSpHG/2Anatfol3eUK/e5bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOQ6cYJukZMgql1mv2i6R4/OczqXPZSjnTN3J3NOI4u7RgZaAR4eprF/zq6OfqR7jTSa31VOGgEHcRBg5RJXKlYXJdSsHbMnh3ePxFw6V4Pp8vXRq4RQ7UgBg9VmNzijt/K1UEBdBBE9GiawsRoi55QtC7dPOJ5SXZhDar1j/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE50C4CEEB;
	Wed, 13 Aug 2025 16:22:32 +0000 (UTC)
Date: Wed, 13 Aug 2025 17:22:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, Waiman Long <llong@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v3] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <aJy7xdOu51zEGAMH@arm.com>
References: <20250813085310.2260586-1-gubowen5@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813085310.2260586-1-gubowen5@huawei.com>

On Wed, Aug 13, 2025 at 04:53:10PM +0800, Gu Bowen wrote:
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
> [1]
> https://lore.kernel.org/all/20250730094914.566582-1-gubowen5@huawei.com/
> [2]
> https://lore.kernel.org/all/5ca375cd-4a20-4807-b897-68b289626550@redhat.com/
> [3]
> https://lore.kernel.org/all/aJCir5Wh362XzLSx@arm.com/
> ====================
> 
> Cc: stable@vger.kernel.org # 5.10
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

