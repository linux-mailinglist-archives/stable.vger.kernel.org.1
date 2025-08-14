Return-Path: <stable+bounces-169605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65681B26D34
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECEB1CE1380
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238F2040B6;
	Thu, 14 Aug 2025 17:00:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5117332C
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190815; cv=none; b=hEDdyO9op5ej1uf9Gap2oKgyerRkikcfAXTXYBIrYa7qBRDiI0rZGCUTqQAMTwrOnE5B2a8tkMhwCABoyvRUfDlD7FqcVlF6uFigwMMBzwjhlypB654uOKLBuZ02czMO+wJr2ReAC2UbHLQnJEDeU9mi00Ej93xA3iC1f0K9h0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190815; c=relaxed/simple;
	bh=Qtjv+0z+bgRL4oYQkx3CSumff7VS5Ho9TiLgKtddUdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkXoNvkkig9dz2xaIhRhWelBzCXWmC38c7LSmoZDWjXfeohf6xSOy+Fs8noHuEhnDGBIcEVTaXEPebjNNWM6fJ7f1zz7eBNjrHV2WPIL2/3Ud6erd6NruZJHSxuRtPtBM059uthOuJX1lSMnKtJxAs0QwOXHYYTlIAzWJ6eIGIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8539AC4CEED;
	Thu, 14 Aug 2025 17:00:13 +0000 (UTC)
Date: Thu, 14 Aug 2025 18:00:11 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gu Bowen <gubowen5@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, Waiman Long <llong@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v3] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <aJ4WG0wZks-cdCm8@arm.com>
References: <20250813085310.2260586-1-gubowen5@huawei.com>
 <20250813155616.d7e5a832ce7cda7764942d10@linux-foundation.org>
 <f3e631dc-245a-4efe-98e5-cbe94464daec@huawei.com>
 <aJ3f05Dqzx0OouJa@arm.com>
 <2025081450-tibia-angelfish-3aa2@gregkh>
 <aJ303-YBCCLFeIoy@arm.com>
 <2025081435-esophagus-crumpet-2622@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081435-esophagus-crumpet-2622@gregkh>

On Thu, Aug 14, 2025 at 04:54:33PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 14, 2025 at 03:38:23PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 14, 2025 at 03:56:58PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Aug 14, 2025 at 02:08:35PM +0100, Catalin Marinas wrote:
> > > > On Thu, Aug 14, 2025 at 10:33:56AM +0800, Gu Bowen wrote:
> > > > > On 8/14/2025 6:56 AM, Andrew Morton wrote:
> > > > > > I'm not sure which kernel version this was against, but kmemleak.c has
> > > > > > changed quite a lot.
> > > > > > 
> > > > > > Could we please see a patch against a latest kernel version?  Linus
> > > > > > mainline will suit.
> > > > > > 
> > > > > > Thanks.
> > > > > 
> > > > > I discovered this issue in kernel version 5.10. Afterwards, I reviewed the
> > > > > code of the mainline version and found that this deadlock path no longer
> > > > > exists due to the refactoring of console_lock in v6.2-rc1. For details on
> > > > > the refactoring, you can refer to this link :
> > > > > https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/.
> > > > > Therefore, theoretically, this issue existed before the refactoring of
> > > > > console_lock.
> > > > 
> > > > Oh, so you can no longer hit this issue with mainline. This wasn't
> > > > mentioned (or I missed it) in the commit log.
> > > > 
> > > > So this would be a stable-only fix that does not have a correspondent
> > > > upstream. Adding Greg for his opinion.
> > > 
> > > Why not take the upstream changes instead?
> > 
> > Gu reckons there are 40 patches -
> > https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/
> 
> 40 really isn't that much overall, we've taken way more for much smaller
> issues :)

TBH, I'm not sure it's worth it. That's a potential deadlock on a rare
error condition (a kmemleak bug or something wrong with the sites
calling the kmemleak API).

> > I haven't checked what ended in mainline and whether we could do with
> > fewer backports.
> 
> I'll leave that all up to the people who are still wanting these older
> kernels.

Good point. Thanks for the advice ;).

-- 
Catalin

