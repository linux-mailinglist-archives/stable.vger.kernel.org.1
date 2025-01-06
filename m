Return-Path: <stable+bounces-106800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E931EA02272
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A881646A8
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEF31D934B;
	Mon,  6 Jan 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tLd2snDH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2751D63F6
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157864; cv=none; b=D3LLJajmuCyCuPEkKIROqZXfL1ZM0E1VEJNIhrKR+1ZvuxRUxCYYIZfljjfkbN0EhanI45cEjnup6IZAF6swjAt9HZViBysoX04tCjB2061WOd2aetvnmP727VZ0tJXXKzGqsFdJsNX/8J7Wmb3pCc1oZ0Bvy+r4m6L9kh57nrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157864; c=relaxed/simple;
	bh=vUH5PGV8SpYKjzZ74mBnLgRshGzKO3UDk9urF2Xtk4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZiO/jfTs5jPpv94tWI+5qyl40yKgMOQrdspeyP/fAxwshCHy7mtI18Cc7UOghdarLXaxQWfabp9SJcICVIngUOR/DPqi1MfraJQYo271xY7/+077b3IK1e3TFnTWxvRFoNu3o+AhchCp+ADfHIX8l5yGQdgpFCmM3XpKDexCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tLd2snDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B991EC4CED2;
	Mon,  6 Jan 2025 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736157864;
	bh=vUH5PGV8SpYKjzZ74mBnLgRshGzKO3UDk9urF2Xtk4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLd2snDHHs40gtEjTaM8Cr8NuG+jcGTskm6NKccfnWWrRcow+EppEHLNSgerqagX8
	 GI5GnLA/1kQG5IwqUUEANE6J7VU5XDT3a4NyVGDgeFkrRqAVAOxETSYKTudHSD5zlZ
	 t2HvMhJvEW3X967ocRa5cb3JwE4Jdk2TaOZR0ikA=
Date: Mon, 6 Jan 2025 11:04:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@denx.de>
Cc: stable@vger.kernel.org
Subject: Re: Buggy patch -- Re: [PATCH 6.1 00/60] 6.1.123-rc1 review
Message-ID: <2025010645-uncloak-obstruct-fb39@gregkh>
References: <20241230154207.276570972@linuxfoundation.org>
 <Z3ZtrwAGkr1XZZy7@duo.ucw.cz>
 <2025010357-laziness-shield-0ad0@gregkh>
 <Z3l1xYCf6nHkRwpt@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3l1xYCf6nHkRwpt@duo.ucw.cz>

On Sat, Jan 04, 2025 at 06:54:13PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > This is the start of the stable review cycle for the 6.1.123 release.
> > > > There are 60 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > 
> > > > Dan Carpenter <dan.carpenter@linaro.org>
> > > >     mtd: rawnand: fix double free in atmel_pmecc_create_user()
> > > 
> > > This is wrong for 6.1 and older -- we don't use devm_kzalloc there, so
> > > it creates memory leak.
> > 
> > Thanks for testing and letting me know,
> 
> This was not "all good" mail. Patch cited above is buggy. But you
> still included it in 6.1.123. Please drop.

Please send a revert for this.

thanks,

greg k-h

