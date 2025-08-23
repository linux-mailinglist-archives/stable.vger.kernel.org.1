Return-Path: <stable+bounces-172597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4CBB328E4
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AA8176E33
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D91DE2D7;
	Sat, 23 Aug 2025 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JgIa/Vau"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC91C84CB
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755957069; cv=none; b=p5UYUMJb/GqdC/DjebV4oVH3fJc8i2NNQB/gmQjNlRBb6/yai7WGLlWu19PLCkk8NtLhJJf7d5CsEd4aOULkdBnsmqsWt8p5nFXt3/OecS0VkQj9duOqnUKYv76X5gQCfNayR6zMRN62+K5J/web3bnCc0XaekZ+a0bsFGIIirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755957069; c=relaxed/simple;
	bh=D61oXte66imETIR/z5LTOEOEvL+sELnpFqDZonQsiAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScJ9973NBiCTLgK9mp5xtfg3F4h0rcVBvRyrSNOCr99jCjJo6GY8o/SGKXvmZxzffY9u32iQg1aUoZA7+F9qxL9XpoHGXoFbzrjig/ag92RbzhFvguVcoc7eMDcRNtfdVsthCi3XKz6b5d/ZR3DQhnPgPFwi0ZQvzb6o/rRw1Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JgIa/Vau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33504C4CEE7;
	Sat, 23 Aug 2025 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755957068;
	bh=D61oXte66imETIR/z5LTOEOEvL+sELnpFqDZonQsiAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgIa/VauR2IQS8K61RbG0cUdv8lrQGmt76FanwY+fZnnkH1ruEdaCJYKuzTmmJGze
	 FSNkiWbBz8I7o1aAdLVQCAcPD/BYeZJ6CBnY0ZwbK8m1g035fZLH01kY/sFDKPECiO
	 bbq53HtK56z8Dsxq6Y+PcnzT+CDRNjSgjtMS6gIY=
Date: Sat, 23 Aug 2025 15:51:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brett Sheffield <brett@librecast.net>
Cc: stable@vger.kernel.org
Subject: Re: Backporting Selftests to Stable Kernels?
Message-ID: <2025082352-hefty-humorous-700d@gregkh>
References: <aKm8qmts_2Cp4j2p@karahi.gladserv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKm8qmts_2Cp4j2p@karahi.gladserv.com>

On Sat, Aug 23, 2025 at 03:05:46PM +0200, Brett Sheffield wrote:
> Dear Stable Maintainers,
> 
> When a bugfix is backported to stable kernels, should we be backporting the
> associated selftest(s)?

If you want to, sure!

> eg.
> 
> 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> was backported to stable, but the selftest was not:
> 5777d1871bf6 ("selftests: net: add test for variable PMTU in broadcast routes")
> 
> Does stable policy say whether it should be?

It's up to the subsystem/maintainer/developer/whomever if they wish to
do that or not.  Some subsystems want to do this, others don't, others
don't care.

> It does not fix a bug, per se, but it does enable those of us running stable
> kernel tests to more thoroughly test stable RCs.

Note that you should always be running the latest selftests for older
kernels, and I think that's what many of the CI systems are already
doing, so maybe that's why you don't notice stuff like this?

That's the only "rule" we have, all new selftests need to work properly
for older kernels.

> Should mainline authors be encouraged to mark related tests for backporting?

Again, it's up to them if they want to or not.  I will point out mptcp
as one subsystem that does mark selftests to backport, and provides
backports for when they do not apply correctly.

hope this helps,

greg k-h

