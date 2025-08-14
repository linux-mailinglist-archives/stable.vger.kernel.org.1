Return-Path: <stable+bounces-169573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B706B269F1
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F6604B16
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C9C1C8612;
	Thu, 14 Aug 2025 14:38:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC271DDA09
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182307; cv=none; b=t9iWl5uxexg/Yh7QlwrqEs9Oy7qdDxrEbpPFeHTdfUj+TsQHO1bepxpGEqY2F88fklJj0w2ojzY16P2xJV3iKlFG7wDnSpL5oGKYk9zV4iloJs8Gf0hZcV/nHF/efBEhfcxlb03BxQYaQu+c4Q72NPrgSG5Gbv3HkVTAqcLvg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182307; c=relaxed/simple;
	bh=rD0PD1U86FJ4htRzmnGEXOB+DK4LfEOIyk2ipev5fCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQvADmM6t01l2dCqAo3fMYEl7kRE72bkXAW9UZ0aCaUY2wCzqXyuD1D6U2yytPw/xxCB5wdpVlmd5R4s/qQvGrPCh5cwnTmAmlwpKTvkkTVXHDeiThRrztDrGAic1Yik9X/CWHJtG5kvcFuPluMwCzDyWSO0U2deJG1hYi/K9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F94C4CEED;
	Thu, 14 Aug 2025 14:38:25 +0000 (UTC)
Date: Thu, 14 Aug 2025 15:38:23 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gu Bowen <gubowen5@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, Waiman Long <llong@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v3] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <aJ303-YBCCLFeIoy@arm.com>
References: <20250813085310.2260586-1-gubowen5@huawei.com>
 <20250813155616.d7e5a832ce7cda7764942d10@linux-foundation.org>
 <f3e631dc-245a-4efe-98e5-cbe94464daec@huawei.com>
 <aJ3f05Dqzx0OouJa@arm.com>
 <2025081450-tibia-angelfish-3aa2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081450-tibia-angelfish-3aa2@gregkh>

On Thu, Aug 14, 2025 at 03:56:58PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 14, 2025 at 02:08:35PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 14, 2025 at 10:33:56AM +0800, Gu Bowen wrote:
> > > On 8/14/2025 6:56 AM, Andrew Morton wrote:
> > > > I'm not sure which kernel version this was against, but kmemleak.c has
> > > > changed quite a lot.
> > > > 
> > > > Could we please see a patch against a latest kernel version?  Linus
> > > > mainline will suit.
> > > > 
> > > > Thanks.
> > > 
> > > I discovered this issue in kernel version 5.10. Afterwards, I reviewed the
> > > code of the mainline version and found that this deadlock path no longer
> > > exists due to the refactoring of console_lock in v6.2-rc1. For details on
> > > the refactoring, you can refer to this link :
> > > https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/.
> > > Therefore, theoretically, this issue existed before the refactoring of
> > > console_lock.
> > 
> > Oh, so you can no longer hit this issue with mainline. This wasn't
> > mentioned (or I missed it) in the commit log.
> > 
> > So this would be a stable-only fix that does not have a correspondent
> > upstream. Adding Greg for his opinion.
> 
> Why not take the upstream changes instead?

Gu reckons there are 40 patches -
https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/

I haven't checked what ended in mainline and whether we could do with
fewer backports.

-- 
Catalin

