Return-Path: <stable+bounces-83763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B999C5D9
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA64D1C22B8A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A112215539F;
	Mon, 14 Oct 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CN53c6AH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076514A60F
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898545; cv=none; b=NV2p3EblO229nJXpxWkph+n8Jwqiu78ul+je99ihFEGa/46Hlon0yhfVJXZWd4WnrQOz8AGyPDcQwTs+PqfygNed/0z6bxFyBZMJUzFI7YQdWa3KS3TdmNceLmAbGoiQ5pqH8erLBUj5yPKkh7zJG2aUc8X0G7tBLC5l3MJRAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898545; c=relaxed/simple;
	bh=gT+Zk6utJbr299mAbCAxz/+9XvO6XdShoeYnv7pWBsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5UqCindia1Eu9hczidL0o2x84z1sZr6g6LGXn3kyPLfxNvu1fUh2N5Qj2NNwgY//9Jt7MsxkM2DW0fcdVxcNUDDK3I0qCS/CVeY1otSts3ebWXwlTlHgj4He1Vp0KO18uhn79SI+7QX2so3KWrzdfRypmDCOHYR1jl96DJ8jBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CN53c6AH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D8BC4CEC3;
	Mon, 14 Oct 2024 09:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728898544;
	bh=gT+Zk6utJbr299mAbCAxz/+9XvO6XdShoeYnv7pWBsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CN53c6AHnG+5quvsVwkYc7i4m9IMxjPTkYcQEb3SDDcNLylMR9O5iug7mcFEGiugr
	 aNM8TSAUh1oP/RojS/UAXI55+Z0NQnwJJqAyIKmLaP0KCjjU4WnWogmRZzm8lzdc1k
	 uMP69Fm811sX+QgUpsRR9GDa+qTWUJ+u159GCEuQ=
Date: Mon, 14 Oct 2024 11:35:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Jinpu Wang <jinpu.wang@ionos.com>, stable <stable@vger.kernel.org>,
	jroedel@suse.de, Sasha Levin <sashal@kernel.org>, x86@kernel.org
Subject: Re: [regression]Boot Hang on Kernel 6.1.83+ with Dell PowerEdge R770
 and Intel Xeon 6710E
Message-ID: <2024101411-runner-predict-0aae@gregkh>
References: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>
 <2024101006-scanner-unboxed-0190@gregkh>
 <CAMGffE=HvMU4Syy7ATEevKQ+izAvndmpQ8-F9HN_WM+3PKwWyw@mail.gmail.com>
 <2024101000-duplex-justify-97e6@gregkh>
 <CAMGffE=xSDZ8Ad9o7ayg2xwnMyPDojyBDh_AHf+h7WBV7y630w@mail.gmail.com>
 <635be050-f0ab-4242-ac79-db67d561dae9@linux.intel.com>
 <9539f133-2cdb-4aa8-8eac-ddf649819d98@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9539f133-2cdb-4aa8-8eac-ddf649819d98@linux.intel.com>

On Thu, Oct 10, 2024 at 10:00:21PM +0800, Baolu Lu wrote:
> On 2024/10/10 21:25, Liang, Kan wrote:
> > On 2024-10-10 6:10 a.m., Jinpu Wang wrote:
> > > Hi Greg,
> > > 
> > > 
> > > On Thu, Oct 10, 2024 at 11:31 AM Greg KH<gregkh@linuxfoundation.org> wrote:
> > > > On Thu, Oct 10, 2024 at 11:13:42AM +0200, Jinpu Wang wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > On Thu, Oct 10, 2024 at 11:07 AM Greg KH<gregkh@linuxfoundation.org> wrote:
> > > > > > On Thu, Oct 10, 2024 at 09:31:37AM +0200, Jinpu Wang wrote:
> > > > > > > Hello all,
> > > > > > > 
> > > > > > > We are experiencing a boot hang issue when booting kernel version
> > > > > > > 6.1.83+ on a Dell Inc. PowerEdge R770 equipped with an Intel Xeon
> > > > > > > 6710E processor. After extensive testing and use of `git bisect`, we
> > > > > > > have traced the issue to commit:
> > > > > > > 
> > > > > > > `586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")`
> > > > > > > 
> > > > > > > This commit appears to be part of a larger patchset, which can be found here:
> > > > > > > [Patchset on
> > > > > > > lore.kernel.org](https://lore.kernel.org/
> > > > > > > lkml/7c4b3e4e-1c5d-04f1-1891-84f686c94736@linux.intel.com/T/)
> > > > > > > 
> > > > > > > We attempted to boot with the `intel_iommu=off` option, but the system
> > > > > > > hangs in the same manner. However, the system boots successfully after
> > > > > > > disabling `CONFIG_INTEL_IOMMU_PERF_EVENTS`.
> > > > > > Is there any error messages?  Does the latest 6.6.y tree work properly?
> > > > > > If so, why not just use that, no new hardware should be using older
> > > > > > kernel trees anyway 🙂
> > > > > No error, just hang, I've removed "quiet" and added "debug".
> > > > > Yes, the latest 6.6.y tree works for this, but there are other
> > > > > problems/dependency we have to solve.
> > > > Ok, that implies that we need to add some other patch to 6.1.y, OR we
> > > > can revert it from 6.1.y.  Let me know what you think is the better
> > > > thing to do.
> > > > 
> > > I think better to revert both:
> > > 8c91a4bfc7f8 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")
> > I'm not sure about this one. May need baolu's comments.
> 
> I can't find this commit in the mainline kernel. I guess it fixes a
> compilation issue in the stable tree? If so, it depends on whether the
> issue is still there.

It is commit 70bad345e622 ("iommu: Fix compilation without
CONFIG_IOMMU_INTEL") in Linus's tree.

thanks,

greg k-h

