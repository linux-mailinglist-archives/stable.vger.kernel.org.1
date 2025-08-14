Return-Path: <stable+bounces-169579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2DDB26A21
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B26AF4E0725
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F95A21A421;
	Thu, 14 Aug 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v4E/sjJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9DF2139B5
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183284; cv=none; b=owI43/HDVgLyRTmsnh3Yh12zsb2Z4VBWPWqpWF6Ux7CnYmo/Ms34UKWumQIOoV0AmwwcuqJocor5M+jL3IhZvHXzNcp+znwlHSiFewxdPQW35pZW6oeN1rKMUs7JC8yExf8uvyWAgMK5qhQNkJh4oKYx5m3Se6EIydcM8sLfSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183284; c=relaxed/simple;
	bh=VXkYGsxYFHCSO35/Shtflutn5Ek/u9q4swyCEQzEGgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCV0Wvn23bI0oW7txaC/SozkFbZSrtVR2gK1iuFkQeanFEVQdFuFeR1hfSkKM03w/mcucLue9KDVS8tT3dqcYsFAsZ5nnxEn0BvSmnn2/TYz8cwtO4uTiltFxsl2cQrmaLpLVyi+tD7gMNufLJWC8XxTE9bRTJPU4I6yY8agkGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v4E/sjJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32678C4CEF5;
	Thu, 14 Aug 2025 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755183281;
	bh=VXkYGsxYFHCSO35/Shtflutn5Ek/u9q4swyCEQzEGgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v4E/sjJI5GqCrsgNND57dpaOxCFClOYgpwiqgsemLHOjM2JakyvN7vHGozKCRfBi4
	 TAIHjCTUtJ8zHFTcMzP5tjd2YhbOfd3SRFCl9DdsvRwLolVzGUy5iZ3fdBOLR/VVHa
	 ar3oEvzczntO8aVpYlCprgPRtiJoOrPy9f5Oi3kM=
Date: Thu, 14 Aug 2025 16:54:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Gu Bowen <gubowen5@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, Waiman Long <llong@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v3] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <2025081435-esophagus-crumpet-2622@gregkh>
References: <20250813085310.2260586-1-gubowen5@huawei.com>
 <20250813155616.d7e5a832ce7cda7764942d10@linux-foundation.org>
 <f3e631dc-245a-4efe-98e5-cbe94464daec@huawei.com>
 <aJ3f05Dqzx0OouJa@arm.com>
 <2025081450-tibia-angelfish-3aa2@gregkh>
 <aJ303-YBCCLFeIoy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ303-YBCCLFeIoy@arm.com>

On Thu, Aug 14, 2025 at 03:38:23PM +0100, Catalin Marinas wrote:
> On Thu, Aug 14, 2025 at 03:56:58PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 14, 2025 at 02:08:35PM +0100, Catalin Marinas wrote:
> > > On Thu, Aug 14, 2025 at 10:33:56AM +0800, Gu Bowen wrote:
> > > > On 8/14/2025 6:56 AM, Andrew Morton wrote:
> > > > > I'm not sure which kernel version this was against, but kmemleak.c has
> > > > > changed quite a lot.
> > > > > 
> > > > > Could we please see a patch against a latest kernel version?  Linus
> > > > > mainline will suit.
> > > > > 
> > > > > Thanks.
> > > > 
> > > > I discovered this issue in kernel version 5.10. Afterwards, I reviewed the
> > > > code of the mainline version and found that this deadlock path no longer
> > > > exists due to the refactoring of console_lock in v6.2-rc1. For details on
> > > > the refactoring, you can refer to this link :
> > > > https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/.
> > > > Therefore, theoretically, this issue existed before the refactoring of
> > > > console_lock.
> > > 
> > > Oh, so you can no longer hit this issue with mainline. This wasn't
> > > mentioned (or I missed it) in the commit log.
> > > 
> > > So this would be a stable-only fix that does not have a correspondent
> > > upstream. Adding Greg for his opinion.
> > 
> > Why not take the upstream changes instead?
> 
> Gu reckons there are 40 patches -
> https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/

40 really isn't that much overall, we've taken way more for much smaller
issues :)

> I haven't checked what ended in mainline and whether we could do with
> fewer backports.

I'll leave that all up to the people who are still wanting these older
kernels.

thanks,

greg k-h

