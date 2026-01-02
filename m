Return-Path: <stable+bounces-204469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC579CEE819
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 13:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 421DF300AB2A
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820930FC15;
	Fri,  2 Jan 2026 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2btFMDoM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095730F938
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356569; cv=none; b=jIZcACqK6nduCOlcm1jfDuxyz4M3xK5yt7rvsdkvghLIs/u06fJq0oc7nhI30/0uppncpZBz7zhpkZd48YO2fw5VzhPQjCV0eW2c35JYZewiWJLdHzjFY7y903d2GIDWurE10vGjF38RW/Z/Rr+Md2WkFSQcbyi1B/U+m90zbkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356569; c=relaxed/simple;
	bh=/y5qJ7sooAfhInidOteSGTuhmPZd8DQCWImJwaX+P2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcuxB8aFrb8D4fqvgdLFHKmjiFTI3T0OsXwVFitgZDG0iXuOf/SnKw82qIpRarzA2m7Oj0ulpVu8rOLhnp4/4YCs6iqyLy0k2lnL3L4y9VpyS1lpqc2lbytbVSyGIxXrFayHtF/wmeaL52Hi8H/1huAdE9KjeGwEqVnhWmAsx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2btFMDoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8809CC116B1;
	Fri,  2 Jan 2026 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767356567;
	bh=/y5qJ7sooAfhInidOteSGTuhmPZd8DQCWImJwaX+P2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2btFMDoMXbSB9075BJeGsrivmHUOm7YYWBj+2fmM/OaVNpoqzg/HZnL7fCPsYNco/
	 sdFDhFET0ncfFpDy0DECaDjtg3w0Di+9+Ct/UNnG3v7Smam6UFj0RnlaID7wv7zi82
	 Uw+1QD76OudRkzcdq9tnijIo57wSUvZ5dQMrTmx4=
Date: Fri, 2 Jan 2026 13:22:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Fernand Sieber <sieberf@amazon.com>
Subject: Re: Please add 127b90315ca0 ("sched/proxy: Yield the donor task") to
 6.12.y / 6.18.y
Message-ID: <2026010235-contort-catwalk-835b@gregkh>
References: <04b82346-c38a-08e2-49d5-d64981eb7dae@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04b82346-c38a-08e2-49d5-d64981eb7dae@applied-asynchrony.com>

On Tue, Dec 30, 2025 at 03:38:34PM +0100, Holger Hoffstätte wrote:
> Hi -
> 
> a Gentoo user recently found that 6.18.2 started to reproducuibly
> crash when building their go toolchain [1].
> 
> Apparently the addition of "sched/fair: Forfeit vruntime on yield"
> (mainline 79104becf42b) can result in the infamous NULL returned from
> pick_eevdf(), which is not supposed to happen.
> 
> It turned out that the mentioned commit triggered a bug related
> to the recently added proxy execution feature, which was already
> fixed in mainline by "sched/proxy: Yield the donor task"
> (127b90315ca0), though not marked for stable.
> 
> Applying this to 6.18.2/.3-rc1 (and probably 6.12 as well)
> has reproducibly fixed the problem. A possible reason the crash
> was triggered by the Go runtime could be its specific use of yield(),
> though that's just speculation on my part.
> 
> So please add 127b90315ca0 ("sched/proxy: Yield the donor task")
> to 6.18.y/6.12.y. I know we're already in 6.18.3-rc1, but the
> crasher seems reproducible.

Now queued up to 6.18.y, thanks.

greg k-h

