Return-Path: <stable+bounces-83315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CC499819E
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 11:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B8A280FD8
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12881BE87C;
	Thu, 10 Oct 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FgAJ1Q+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7D1BE874
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551270; cv=none; b=KLKOX4Bzn7XoDV9BZBJz3nwsVN9BavC+8HgfyX6pRDYgt2bWN6XEXvS7gGaxZzt8g8pVq37qfDiUmVgohUznyTSy/sY7WnByDVvHnMisQSYAtJOkeHxUkHVXbLIUh736PVjjJ0oKLfP56s4+BkSXRHOKSO8ZGaJhczIQCmgi5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551270; c=relaxed/simple;
	bh=gYU3Z21Ql5llsq7K+Qeds45nrx/A7a+MRfuKjpzFBHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3ccCUSE8BAgEwhw9pU9tojWi3ZD5ozU/Or/W5W78j4wC9MbDvxsnMy1SK38xt3BunbUbveMzZSza2DnlY16n4Ug5vae08ey3HU4pWUI+K+kVvH7lJdX+lzfKungPd+OCmwRShBtCxx35hhYntbagk7Wzwoq6aWRH5g0EM3MGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FgAJ1Q+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62CDC4CEC5;
	Thu, 10 Oct 2024 09:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728551270;
	bh=gYU3Z21Ql5llsq7K+Qeds45nrx/A7a+MRfuKjpzFBHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgAJ1Q+Al7Idh+hFz8jjmcSol7vzueitbVQuLM6eZy6bDztu5/Oegwnq2oKPQtgK7
	 fxiqB/cbSJ9R8YKVTi7HA2LvKWBn8wZqu13vq59q+h8RNQrgVudtdrUW8lSh/mypS4
	 z/yOz7vg+Ynalyce/rJkvF3SZPVEHwVFl1e6pvgc=
Date: Thu, 10 Oct 2024 11:07:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: stable <stable@vger.kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	baolu.lu@linux.intel.com, jroedel@suse.de,
	Sasha Levin <sashal@kernel.org>, x86@kernel.org
Subject: Re: [regression]Boot Hang on Kernel 6.1.83+ with Dell PowerEdge R770
 and Intel Xeon 6710E
Message-ID: <2024101006-scanner-unboxed-0190@gregkh>
References: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=dPofoPD_+giBnAC66-+=RqRmO2uBmC88-Ph1RgGN=0Q@mail.gmail.com>

On Thu, Oct 10, 2024 at 09:31:37AM +0200, Jinpu Wang wrote:
> Hello all,
> 
> We are experiencing a boot hang issue when booting kernel version
> 6.1.83+ on a Dell Inc. PowerEdge R770 equipped with an Intel Xeon
> 6710E processor. After extensive testing and use of `git bisect`, we
> have traced the issue to commit:
> 
> `586e19c88a0c ("iommu/vt-d: Retrieve IOMMU perfmon capability information")`
> 
> This commit appears to be part of a larger patchset, which can be found here:
> [Patchset on lore.kernel.org](https://lore.kernel.org/lkml/7c4b3e4e-1c5d-04f1-1891-84f686c94736@linux.intel.com/T/)
> 
> We attempted to boot with the `intel_iommu=off` option, but the system
> hangs in the same manner. However, the system boots successfully after
> disabling `CONFIG_INTEL_IOMMU_PERF_EVENTS`.

Is there any error messages?  Does the latest 6.6.y tree work properly?
If so, why not just use that, no new hardware should be using older
kernel trees anyway :)

thanks,

greg k-h

