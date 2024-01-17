Return-Path: <stable+bounces-11818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4527682FFF4
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 06:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB53E1F25EA0
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 05:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB1879CD;
	Wed, 17 Jan 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xgw52jl9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A579C2
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 05:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705470913; cv=none; b=KxUpX49ID9TSU+gOQh6rYxHFUyjYILV9ijK9J3BRpfuitjJTusYGemwF52tGD3clKJkWTtD/6n8zfBqiulvzqN5jbVSF0BbKfOMj0jN6tPAAZEendYrIrs7i8r06R5Jxw88ycdfVbNceC3LhPAlbCkA5zsVlFaqowKMBE89q8/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705470913; c=relaxed/simple;
	bh=l4hHsXxDuaY6bucx8rE9I6NYDTycMAAU5l/I4jSYm5U=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Btk7eveNigs522A28bYaGec4fphezTRzpGBz01mO/t/4TRO5LJ53l2W2vA3mpwtrHFRG3W1kvLZSaU8Tt/970YnhztBsdzsewY4WrQcwUv0jcW7v8X23rq32QOpZQKZzgJxiymm4zuYOW09CiuwfAcFZA2yMQYgjns7/guA2uU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xgw52jl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A176C433F1;
	Wed, 17 Jan 2024 05:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705470912;
	bh=l4hHsXxDuaY6bucx8rE9I6NYDTycMAAU5l/I4jSYm5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xgw52jl9IR63pY+hurKYprPgLfRPDK7OMY1k0VJaaoQvPON5qbMsygF513R2hySii
	 N4VbqvHr4X8IE6Ndg9+1T/6VHs6jSye/CpTXS8J7RV9MAsJwxR60h0044rxGuwwalJ
	 mykIaCI70FOwqrGZVtPrfKn5yh/AJrNJwI+AIZJQ=
Date: Wed, 17 Jan 2024 06:55:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, kernelci-results@groups.io,
	bot@kernelci.org, stable@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: kernelci/kernelci.org bisection:
 baseline-nfs.bootrr.deferred-probe-empty on at91sam9g20ek
Message-ID: <2024011716-undocked-external-9eae@gregkh>
References: <65a6ca18.170a0220.9f7f3.fa9a@mx.google.com>
 <845b3053-d47b-4717-9665-79b120da133b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845b3053-d47b-4717-9665-79b120da133b@sirena.org.uk>

On Tue, Jan 16, 2024 at 07:02:19PM +0000, Mark Brown wrote:
> On Tue, Jan 16, 2024 at 10:25:28AM -0800, KernelCI bot wrote:
> 
> The KernelCI bisection bot has identified bc7d0133181e5f33aca ("ASoC:

Nit, typo in your sha1 here :(

> atmel: Remove system clock tree configuration for at91sam9g20ek") from
> the v5.15 stable tree as causing something to fail to probe on
> at91sam9g20ek, most likely the audio driver though I didn't pull the
> logs to verify.  The commit isn't a particularly obvious one for
> backporting.
> 
> Full bisection report below.

This is also in the following kernel releases:
	4.19.240 5.4.191 5.10.113
do they also have issues?  Does 6.1 and newer work properly?

And wow, this is old, nice to see it reported, but for a commit that
landed in April, 2022?  Does that mean that no one uses this hardware?

I'll be glad to revert, but should I also revert for 4.19.y and 5.4.y
and 5.10.y?

thanks,

greg k-h

