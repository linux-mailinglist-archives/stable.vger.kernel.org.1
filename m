Return-Path: <stable+bounces-194691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A46EC57D1C
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 15:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC943BC5BF
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12830351FC1;
	Thu, 13 Nov 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DMoxs1wk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B9346A16;
	Thu, 13 Nov 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040256; cv=none; b=X4xKnm6Fvf6ewGTwjhtGrBbB6QM1tQ12uc1sTeNZQedAxRTT5OsYBXXe3d22XoyWmSq73GH9gB4b3jeUtRp/abKelJSPM/dJ1brpcbMjbyLupJ/mZJnbvFyUhjEAPph/RmYK67aLRoaN/jJYuRSs4+gwn5wQLQHzlHK2MpRiBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040256; c=relaxed/simple;
	bh=8MEvE85ASs8TWT1DKTYjn3gNwdHSLFIkIMQR4I4pw6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uI3IuZsBNQti9xqz48ndwVBsKyh/exae8spAxlLF19b3/ArTz+VJJViYqvoRR6dZOkMBtbg04CYMi0YmAgLCFvFG5L2n1QZDo2m58UMs35IYi3vNswbFxVe4xQbytqlZRx5rfh43THX35Ezujtbt/+jlGpMKzblbrlAKXIwpzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DMoxs1wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379BDC116D0;
	Thu, 13 Nov 2025 13:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763040256;
	bh=8MEvE85ASs8TWT1DKTYjn3gNwdHSLFIkIMQR4I4pw6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMoxs1wkyxu7gUQKIKtD+IFA3JWQsWrDLT6LUY7zJRTr+RtZdn0i52yunOBPH99xE
	 yQPn67kI7GAgWzfHHdMghQHgLl+9HOidVPNIhUgyWhNl/r5Qn5MNvJ7BI68+aE25Yb
	 7/vXOM4i+iZxJcL/aWsKWsJ663VZ3gGvRrr7RIJs=
Date: Thu, 13 Nov 2025 08:24:14 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com, sakari.ailus@linux.intel.com,
	khalid@kernel.org, shuah@kernel.org, david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, hariconscious@gmail.com
Subject: Re: [PATCH v2] ASoC: Intel: avs: Fix potential buffer overflow by
 snprintf()
Message-ID: <2025111313-submerge-strength-ada6@gregkh>
References: <20251112181851.13450-1-hariconscious@gmail.com>
 <2025111239-sturdily-entire-d281@gregkh>
 <bc479d42-af01-466f-b066-1da9a99b29bb@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc479d42-af01-466f-b066-1da9a99b29bb@intel.com>

On Thu, Nov 13, 2025 at 09:46:12AM +0100, Cezary Rojewski wrote:
> On 2025-11-12 8:20 PM, Greg KH wrote:
> > On Wed, Nov 12, 2025 at 11:48:51PM +0530, hariconscious@gmail.com wrote:
> > > From: HariKrishna Sagala <hariconscious@gmail.com>
> > > 
> > > snprintf() returns the would-be-filled size when the string overflows
> > > the given buffer size, hence using this value may result in a buffer
> > > overflow (although it's unrealistic).
> > 
> > unrealistic == impossible
> > 
> > So why make this change at all?
> 
> The problem will never occur in production-scenario given the AudioDSP
> firmware limitation - max ~10 probe-point entries so, the built string will
> be far away from 4K_SZ bytes.
> 
> If the verdict is: ignore the recommendation as the problem is unrealistic,
> I'm OK with that. Typically though I'd prefer to stick to the
> recommendations.

That's fine, but don't claim that it fixes a buffer overflow when that
is NOT what this is doing at all.

> > > This patch replaces it with a safer version, scnprintf() for papering
> > > over such a potential issue.
> > 
> > Don't "paper over", actually fix real things.
> > 
> > 
> > > Link: https://github.com/KSPP/linux/issues/105
> > > 'Fixes: 5a565ba23abe ("ASoC: Intel: avs: Probing and firmware tracing
> > > over debugfs")'
> > 
> > No, this is not a "fix".
> 
> The patch isn't worded well, that's clear.
> While the patch is an outcome of static-analysis, isn't it good to have
> 'Fixes:' to point out the offending commit regardless?

No, it is not "fixing" anything.  Please don't claim that it does.  It
is "just" a code transformation to get rid of an api that some people do
not like.

thanks,

greg k-h

