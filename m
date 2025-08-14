Return-Path: <stable+bounces-169549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01BEB26699
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 15:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9489C1CC7B81
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BF63002CB;
	Thu, 14 Aug 2025 13:08:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB363002BF
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176919; cv=none; b=kaFkplMkgB9LtvqHu6XXZVMLI//99Q2oxklwwQec2nRO/Jag0n0onUcGj+BAXRE0yHVM+KEOAitHBXYeY/P5eadUSsZwMTb96O5YmgMssFuZr84ySgkL8+wqPFX9WUxNvf8nVD12bRB5oBUaZXMZJfmK+O3t1F8bU47HqNOSte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176919; c=relaxed/simple;
	bh=FuZUXMmhHJGVUjBnFYOgaSI3zy0JsnycBebl5UMzPPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfTATowc9NKlp45wvdGQcY+sS0pSFE7bot2twPij1+ai3IOoP1+Icn64b/l92weCDNa9vbRhFsNr3Tt3ELeqvVVLoxO5iaXW9M7Mzoi3qUOxSp8cVGwDEw+fN9ixERIfm7FiH2wtoS/JRGqCoscFtofmiyzP+xhfnCAVAdV65OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5C2C4CEF1;
	Thu, 14 Aug 2025 13:08:37 +0000 (UTC)
Date: Thu, 14 Aug 2025 14:08:35 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, Waiman Long <llong@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <aJ3f05Dqzx0OouJa@arm.com>
References: <20250813085310.2260586-1-gubowen5@huawei.com>
 <20250813155616.d7e5a832ce7cda7764942d10@linux-foundation.org>
 <f3e631dc-245a-4efe-98e5-cbe94464daec@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e631dc-245a-4efe-98e5-cbe94464daec@huawei.com>

On Thu, Aug 14, 2025 at 10:33:56AM +0800, Gu Bowen wrote:
> On 8/14/2025 6:56 AM, Andrew Morton wrote:
> > I'm not sure which kernel version this was against, but kmemleak.c has
> > changed quite a lot.
> > 
> > Could we please see a patch against a latest kernel version?  Linus
> > mainline will suit.
> > 
> > Thanks.
> 
> I discovered this issue in kernel version 5.10. Afterwards, I reviewed the
> code of the mainline version and found that this deadlock path no longer
> exists due to the refactoring of console_lock in v6.2-rc1. For details on
> the refactoring, you can refer to this link :
> https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/.
> Therefore, theoretically, this issue existed before the refactoring of
> console_lock.

Oh, so you can no longer hit this issue with mainline. This wasn't
mentioned (or I missed it) in the commit log.

So this would be a stable-only fix that does not have a correspondent
upstream. Adding Greg for his opinion.

-- 
Catalin

