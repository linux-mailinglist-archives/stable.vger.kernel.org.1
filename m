Return-Path: <stable+bounces-78320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81A98B4E8
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19C41C23506
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869C663D;
	Tue,  1 Oct 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CHjLvkD9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43709192D65
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765552; cv=none; b=OU3W6fbB7xUXX96gKDK0G13wxRqZ+4Eym0QbQ2s07qhLuiTnNYZXogW4hkxKHCZDwfmMkS0/3ZvN2s+v5cu8hfJSQRVtc7bISbCbACTSfGZgclBZlhAjGVIQhDXNrsOdtcJUa6vr6S9BgRotsXU1Q/o1KuNiP1k8IEJAidQRtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765552; c=relaxed/simple;
	bh=QN0Hn69HMSkjEUv1OGdqOX3Bjlq35lE6Ios0VBR7bq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T92dPXCOo1rKJCyaJtd9SyRJ1u6GjNmzTpY6dfIDsGju29G819hCmnucmrt/RZ1Pnv+/shMk4qAxpNytlYP09WjO64N1+aJiEXRtngqmh7JxIFePa5IdHP5HFSioE3uTOVKObMVrbQ2kUMCmCl84zVKfOSsD5uRgrw3ONkeBroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CHjLvkD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4781CC4CEC6;
	Tue,  1 Oct 2024 06:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727765551;
	bh=QN0Hn69HMSkjEUv1OGdqOX3Bjlq35lE6Ios0VBR7bq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHjLvkD9WnJrrtrlgkd0y2sthyj2Pa1pUnpJ4w3LHADyLrWxPfrFZiGQzQuSorR9L
	 SuOmGS0Uhico7vjFW6pR3qU9HLoA9XGsr26c0+1AZUbSl1hzW+cykaKcp4XY3tk70T
	 snpoImamqZv3/Z1ydw07XVgcxTve2HQ5vExg1vaI=
Date: Tue, 1 Oct 2024 08:52:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: patches sent up to 6.13-rc1 that shouldn't be backported
Message-ID: <2024100107-womb-share-931a@gregkh>
References: <CAHmME9rtJ1YZGjYkWR10Wc24bVoJ4yZ-uQn0eTWjpfKxngBvvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rtJ1YZGjYkWR10Wc24bVoJ4yZ-uQn0eTWjpfKxngBvvA@mail.gmail.com>

On Tue, Oct 01, 2024 at 06:02:45AM +0200, Jason A. Donenfeld wrote:
> Hi Sasha,
> 
> I've been getting emails from your bots...
> 
> I sent two pulls to Linus for 6.13-rc1:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4a39ac5b7d62679c07a3e3d12b0f6982377d8a7d
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e1a5d43c5deec563b94f3330b690dde9d1de53
> 
> In these, I'm not sure there's actually much valid stable material. I
> didn't mark anything as Cc: stable@vger.kernel.org, I don't think.
> 
> As such, can you make sure none of those get backported?
> 
> Alternatively, if you do have reason to want to pick some of these,
> can you be clear with what and why, and actually carefully decide
> which ones and which dependencies are required as such in a
> non-automated way?

They say so directly in the commit, i.e.:
	Stable-dep-of: 6eda706a535c ("selftests: vDSO: fix the way vDSO functions are called for powerpc")

in each one.  So this seem to be needed to fix up the powerpc stuff.

I'll drop them all if you feel these should not be applied.

thanks,

greg k-h

