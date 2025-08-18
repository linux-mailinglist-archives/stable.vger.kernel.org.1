Return-Path: <stable+bounces-170058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87BB2A180
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734F45E6187
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8F7320398;
	Mon, 18 Aug 2025 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uQ5Mvvv4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9232038A;
	Mon, 18 Aug 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519924; cv=none; b=MRR77oSXiwfKHvkJu3a8S5aGB97lWOLjQbcZvbLybZ9qa+I0HbOUeLj13AQtrT4NmR5egw4IocRqSkzU3Oebor/Ii0c0nNiehMdQ92/4Si/gxE8hz93sJEhZakqxexwDHeP376jIiLIWwfIFod6B9k1a68GMBtZCbX3TkRj0M78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519924; c=relaxed/simple;
	bh=iD6KeXUwjZMsgFo/1JAR0XHMdc17qr2DRiM+TxaZ1uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so/6HS3uw5ggP8Q1MgTvK5rvUTfGonvnaPJ2IyActGAlqbVHCiTM5o+4CQPoDbomDSs8E2sYCt8BbXvXBwjsNEIQHaLcjSdX766isRcN4FkjngVllG2zl0vOekGNp3tLWK1v5fmGmzg8LSnHprgehIMDvY2vws7hiFJA5wWtpnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uQ5Mvvv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD88C4CEEB;
	Mon, 18 Aug 2025 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755519924;
	bh=iD6KeXUwjZMsgFo/1JAR0XHMdc17qr2DRiM+TxaZ1uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQ5Mvvv4fu0nC0YpmZgbfHu77T7H6ZmwX7iwmSNDtatMlKdVOjuyRM0UgVb1I0mCl
	 Zay/DkvieMXj9TcmK+x3wQIlcpcZVPu4tYXaaClJR9zAV6g7pv7BsRfA/SnMhAIBtT
	 YF79JC5gZXqumBvDreF5yQ/mmYejRZMOIzA68GMk=
Date: Mon, 18 Aug 2025 14:25:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5Za15YWs5a2Q?= <miaogongzi0227@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] IPv6 RA default router advertisement fails after
 kernel 6.12.42 updates
Message-ID: <2025081831-viewable-vanquish-e8bc@gregkh>
References: <CACBcRw+Fu1B+fXEFvhfsZFtPqa5G=AYSW0K3L2RBWh8YfkgUhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBcRw+Fu1B+fXEFvhfsZFtPqa5G=AYSW0K3L2RBWh8YfkgUhg@mail.gmail.com>

On Mon, Aug 18, 2025 at 08:03:00PM +0800, 喵公子 wrote:
> Hi,
> 
> While testing Linux kernel 6.12.42 on OpenWrt, we observed a
> regression in IPv6 Router Advertisement (RA) handling for the default
> router.
> 
> Affected commits
> 
> The following commits appear related and may have introduced the issue:
> 
> ipv6: fix possible infinite loop in fib6_info_uses_dev()：
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.12.42&id=db65739d406c72776fbdbbc334be827ef05880d2
> 
> ipv6: prevent infinite loop in rt6_nlmsg_size()：
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.12.42&id=cd8d8bbd9ced4cc5d06d858f67d4aa87745e8f38
> 
> ipv6: annotate data-races around rt->fib6_nsiblings：
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.12.42&id=0c58f74f8aa991c2a63bb58ff743e1ff3d584b62

Does this also happen on the latest kernel releases?

Also, please always include the developers/maintainers/mailing list of
the subsystem where you find an issue with.  Otherwise you are not going
to reach the developers who can help you out.

thanks,

greg k-h

