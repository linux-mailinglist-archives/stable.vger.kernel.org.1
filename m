Return-Path: <stable+bounces-136557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F182A9AA94
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3307B8469
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7157D22AE76;
	Thu, 24 Apr 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="keZTWgFW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB822A4FA;
	Thu, 24 Apr 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490854; cv=none; b=ahyg/OZPxKXxqE7nJ1zH4Bg+zHfd00+dgJ2BWqs/sW5/jge9D3Ys+XAJL+SyXuXLyOfJEhAQ5N38QFiK+Q5trb5J8Wx3iixOICKo2Y+0rIQfEBHwkx1BUOncbwC+hzHlL0cqFjFcSsmkWdlDyyxFRtYsBI8zGg2y4fRSQEcsdkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490854; c=relaxed/simple;
	bh=gA2UxQqlLFPwEP0NKKHr0A+IRi4dfKbHfD4ZUz5RCSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU3AJin+E2wSYN6f+EHO6+WJ0Bj9uB6TQmG1mRSNzMCanFnjTXoCkijIIoV4OTLNtzew5GU1OdwicEQqSD87BdNh4MkVtd0oMDO5i6q8qgVwtgua5yf8x4/czNTYEN3hQ8UP82LM71hpswJS1/bVpYFP2fG2domeereB2S8nC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=keZTWgFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0DAC4CEE3;
	Thu, 24 Apr 2025 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745490853;
	bh=gA2UxQqlLFPwEP0NKKHr0A+IRi4dfKbHfD4ZUz5RCSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keZTWgFWSzMWH7Qrxoe+GuvmXBG+ITmOagXehi264gmg300rfR7i582U0U8Nbu62R
	 HC8DFfydurX1ppefokyc7cj5eF3ad+3BzOEabHrEN7Hg/QQY2CWYiG0hXS2CTGeuNx
	 9+NFp6OXN4MgN+HvdS0F588gxFbGpzbH/80Ig+Hw=
Date: Thu, 24 Apr 2025 12:34:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Karol Wachowski <karol.wachowski@intel.com>
Subject: Re: [PATCH] accel/ivpu: Add handling of
 VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Message-ID: <2025042449-capitol-neuron-b6fe@gregkh>
References: <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>
 <2025042227-crumb-rubble-7854@gregkh>
 <80f49ba8-caea-47d5-be38-dd1eefd09988@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f49ba8-caea-47d5-be38-dd1eefd09988@linux.intel.com>

On Thu, Apr 24, 2025 at 12:22:31PM +0200, Jacek Lawrynowicz wrote:
> Hi,
> 
> On 4/22/2025 2:17 PM, Greg KH wrote:
> > On Tue, Apr 08, 2025 at 11:57:11AM +0200, Jacek Lawrynowicz wrote:
> >> From: Karol Wachowski <karol.wachowski@intel.com>
> >>
> >> commit dad945c27a42dfadddff1049cf5ae417209a8996 upstream.
> >>
> >> Trigger recovery of the NPU upon receiving HW context violation from
> >> the firmware. The context violation error is a fatal error that prevents
> >> any subsequent jobs from being executed. Without this fix it is
> >> necessary to reload the driver to restore the NPU operational state.
> >>
> >> This is simplified version of upstream commit as the full implementation
> >> would require all engine reset/resume logic to be backported.
> > 
> > We REALLY do not like taking patches that are not upstream.  Why not
> > backport all of the needed patches instead, how many would that be?
> > Taking one-off patches like this just makes it harder/impossible to
> > maintain the code over time as further fixes in this same area will NOT
> > apply properly at all.
> > 
> > Think about what you want to be touching 5 years from now, a one-off
> > change that doesn't match the rest of the kernel tree, or something that
> > is the same?
> 
> Sure, I'm totally on board with backporting all required patches.
> I thought it was not possible due to 100 line limit.
> 
> This would be the minimum set of patches:
> 
> Patch 1:
>  drivers/accel/ivpu/ivpu_drv.c   | 32 +++-----------
>  drivers/accel/ivpu/ivpu_drv.h   |  2 +
>  drivers/accel/ivpu/ivpu_job.c   | 78 ++++++++++++++++++++++++++-------
>  drivers/accel/ivpu/ivpu_job.h   |  1 +
>  drivers/accel/ivpu/ivpu_mmu.c   |  3 +-
>  drivers/accel/ivpu/ivpu_sysfs.c |  5 ++-
>  6 files changed, 75 insertions(+), 46 deletions(-)
> 
> Patch 2:
>  drivers/accel/ivpu/ivpu_job.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> Patch 3:
>  drivers/accel/ivpu/ivpu_job.c     |   2 +-
>  drivers/accel/ivpu/ivpu_jsm_msg.c |   3 +-
>  drivers/accel/ivpu/vpu_boot_api.h |  45 +++--
>  drivers/accel/ivpu/vpu_jsm_api.h  | 303 +++++++++++++++++++++++++-----
>  4 files changed, 293 insertions(+), 60 deletions(-)
> 
> Patch 4:
>  drivers/accel/ivpu/ivpu_job.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> First patch needs some changes to apply correctly to 6.12 but the rest of them apply pretty cleanly.
> Is this acceptable?

Totally acceptable, that's trivial compared to many of the larger
backports we have taken over the years :)

thanks,

greg k-h

