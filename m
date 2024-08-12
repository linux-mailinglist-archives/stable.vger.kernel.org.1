Return-Path: <stable+bounces-66544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E3694EF6E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F4A1F22487
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ABC17D8A9;
	Mon, 12 Aug 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qiW6WsBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB255174EEB
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472550; cv=none; b=MoX3ioTBLXRlIFe177tRYEUYctCLI4kAKq5YRzeCXU+bGeOUphpde3Qacf/P7Ru+0td3m4DeXs+AtBmC1yaMrhk5bh6FzGzW2BNpYIAEWQ9f9jMTGawaWypRgYEGXwIzJVx6CqFmW5nB2KMZ1EB1wDcopaoZ/FWetXRAQ0/YrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472550; c=relaxed/simple;
	bh=4KZn5vmARLZr90m5XVzMcy5BNe0xrP8ft/UK/HO5NX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sugjF1aQAIZsvMOeeak62SUsk35B6Yxs358KpZvD6VfupNaQzRHpOId7De0iSgOxmYx8udLX1ZNEhDGNY4tF0idhSJhA+eBj3uJT/sImfk431TEMxjTVSb/UAQLcelmvrBAeCoIl9V+7rMT2Oiv/EgA5ssyT0Uedmt1OjdvkxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qiW6WsBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55D9C32782;
	Mon, 12 Aug 2024 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723472549;
	bh=4KZn5vmARLZr90m5XVzMcy5BNe0xrP8ft/UK/HO5NX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiW6WsBaRVs3HFaRJwHPRbp3caj7KzE/QS61brdX60CnjI9ddGJOaFbyUHDvbjdJd
	 vDmaAE4eL2TqwZHSS8S/9TiMcJ204rkq6zUbLO+LWhphZVvqp8iuw3YOENOrTEz51A
	 U2A7zwgGb5pEBSJwFW3Ml3MlHmEWmOvcxLGu5JT0=
Date: Mon, 12 Aug 2024 16:22:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y] ipv6: fix source address selection with route leak
Message-ID: <2024081215-maturing-unsliced-a989@gregkh>
References: <2024072906-causation-conceal-2567@gregkh>
 <20240805125340.1039685-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805125340.1039685-1-nicolas.dichtel@6wind.com>

On Mon, Aug 05, 2024 at 02:53:40PM +0200, Nicolas Dichtel wrote:
> Commit 252442f2ae317d109ef0b4b39ce0608c09563042 upstream.
> 
> By default, an address assigned to the output interface is selected when
> the source address is not specified. This is problematic when a route,
> configured in a vrf, uses an interface from another vrf (aka route leak).
> The original vrf does not own the selected source address.
> 
> Let's add a check against the output interface and call the appropriate
> function to select the source address.
> 
> There was a conflict during the backport in the function
> ip6_dst_lookup_tail(). The upstream commit fa17a6d8a5bd ("ipv6: lockless
> IPV6_ADDR_PREFERENCES implementation") added a READ_ONCE() on
> inet6_sk(sk)->srcprefs.
> 
> CC: stable@vger.kernel.org
> Fixes: 0d240e7811c4 ("net: vrf: Implement get_saddr for IPv6")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Link: https://patch.msgid.link/20240710081521.3809742-3-nicolas.dichtel@6wind.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  include/net/ip6_route.h | 22 +++++++++++++++-------
>  net/ipv6/ip6_output.c   |  1 +
>  net/ipv6/route.c        |  2 +-
>  3 files changed, 17 insertions(+), 8 deletions(-)

Now queued up, thanks.

greg k-h

