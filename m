Return-Path: <stable+bounces-169921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E39B2992C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 07:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120C55E158F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 05:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F32701BB;
	Mon, 18 Aug 2025 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JXyJL07a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130226E715
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496445; cv=none; b=dUSG05ZV7KbseR4WrP4ljXVodpSVVbK+6HaD4QChYDaZkufIX9GwrqyxnXKKzoyI5F4kQQoSWnrZgc3a6GaMQ89re07VkTI/uBl34M1Dh8xnJsCDNwc+DgOeZo655sUXcUMYxF4FmOdO9CBvZgFI/7gW9HY4o9OE7Hur/jAClxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496445; c=relaxed/simple;
	bh=7VMm1yCipGar/5QC8/PT1FgWUYooGhE6OFcFlzC9534=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3POjNPvDKjyj36tvroyqPHDgYNx/XOV0ajuBAOW1f0Ok3rcxBePzwXHm6XXgKLJ1cSq182LcE/zBE1DS/1i7c14vsqBzQ4Q4zhMQcEDBU7Ek4sokiv2bEu4ef+iY8P3Oog2X2WLGvfSxS3s3FUMBi0o46p0UuJD3dnP0TqIrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JXyJL07a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EDEC4CEEB;
	Mon, 18 Aug 2025 05:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755496445;
	bh=7VMm1yCipGar/5QC8/PT1FgWUYooGhE6OFcFlzC9534=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXyJL07acHqlg5PvXgmSd099vExnnoKfJPfUfBFMDr07Ry4Jsnve36oYcnA8pUhgB
	 QAV/xzCd+VNCenzBRvkU+t49ohBOOrxWoXUngWPYCGbRR44HFJs3ZLe7FhrIauahZi
	 WqmyF3ViC8I+m/EEy82JLpYn4eVHPEmNeuoNXmsM=
Date: Mon, 18 Aug 2025 07:54:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, Waiman Long <llong@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v3] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <2025081846-spongy-cornstalk-ea09@gregkh>
References: <20250813085310.2260586-1-gubowen5@huawei.com>
 <20250813155616.d7e5a832ce7cda7764942d10@linux-foundation.org>
 <f3e631dc-245a-4efe-98e5-cbe94464daec@huawei.com>
 <aJ3f05Dqzx0OouJa@arm.com>
 <2285c764-e6b3-4cb4-ae12-0bfaa1e67358@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2285c764-e6b3-4cb4-ae12-0bfaa1e67358@huawei.com>

On Mon, Aug 18, 2025 at 10:24:38AM +0800, Gu Bowen wrote:
> 
> 
> On 8/14/2025 9:08 PM, Catalin Marinas wrote:
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
> > 
> 
> I have discovered that I made a mistake, this fix patch should be merged
> into the mainline. Since we have identified two types of deadlocks, the AA
> deadlock [1] and the ABBA deadlock[2], the latter's deadlock path no longer
> exists in the mainline due to the 40 patches that refactored console_lock.
> However, the AA deadlock issue persists, so I believe this fix should be
> applied to the mainline.
> 
> [1] https://lore.kernel.org/all/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org/#t
> [2] https://lore.kernel.org/all/20250730094914.566582-1-gubowen5@huawei.com/

Pleasae submit it as a normal patch then.

thanks,

greg k-h

