Return-Path: <stable+bounces-125649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9D4A6A696
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 13:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152668A7C9F
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA6042065;
	Thu, 20 Mar 2025 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtIaQDnG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900FAA944;
	Thu, 20 Mar 2025 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475512; cv=none; b=OV5joAqZxAVT95h3rAjxCRsRS+b3W96Ionf95uwLAHR1qgauAI43E8Y8wRND3Z6T58xp67ZmimVjoQlSvssHzqI7WcifCTOyc9oe4PWg+3D0c/EXnarHaxnj4RCio7UtAvVazc8esZLSYgCPYkHGwfsfA4Fa6KUBZIOwxkc4IcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475512; c=relaxed/simple;
	bh=CbizOdIH7LrylvfnF07cT4lgGLqWxugdpDHGf4mnkkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcBRddnpwdxR8WQdivQjDVti3SPn6SIxYJEudh/q2htdc4MQQA394yZbgkCiayEfB1A0vmxmxFWPPXgFjZrvIP4hhm+tljOuq26hEFJtQHMMAZSkXDmT3Y1rri/FQ36JWRoeBiFuiSpcZaQgs7SguZJVJA4ZRK59O17UH9SqOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtIaQDnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2906C4CEDD;
	Thu, 20 Mar 2025 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742475512;
	bh=CbizOdIH7LrylvfnF07cT4lgGLqWxugdpDHGf4mnkkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtIaQDnGeW/+X+krYiGmP8BwkE5LGruV0ppYqfkyj7eh/RYRQ4aHf9fy2OBYqyxlZ
	 DGOvoiElWHofZOq0KV5xxRNDN6rCfL9JLXkj4fWOYrqmZ7Dr9SiJwEtmNwQtnXrgjQ
	 Sa4yBxMNV9A20fbsF676IC/sPX4cvuSnymDNCAiaJ7YcgOTb6BhC8mFDPNG5KpaK2w
	 QCJXsYliYbI8smIdhrDMxsNmzozplTlIZVB+R0DYWWGWj2iEgNil+la3dDRdavnQ0q
	 WfWIDXUwAAq44b/MHqyZ8Y8Kz7MnFcgU6h9qKXh/Y4nDht2pXkI6gIS3RpX1lkIwvn
	 7SBCCEt7JYUaw==
Date: Thu, 20 Mar 2025 12:58:27 +0000
From: Simon Horman <horms@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] mptcp: sockopt: fix getting IPV6_V6ONLY
Message-ID: <20250320125827.GQ280585@kernel.org>
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
 <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-2-122dbb249db3@kernel.org>
 <20250319153827.GC768132@kernel.org>
 <a2b61202-a257-4317-b454-799da27951e8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b61202-a257-4317-b454-799da27951e8@kernel.org>

On Wed, Mar 19, 2025 at 05:26:35PM +0100, Matthieu Baerts wrote:
> Hi Simon,
> 
> Thank you for your review!
> 
> On 19/03/2025 16:38, Simon Horman wrote:
> > On Fri, Mar 14, 2025 at 09:11:32PM +0100, Matthieu Baerts (NGI0) wrote:
> >> When adding a socket option support in MPTCP, both the get and set parts
> >> are supposed to be implemented.
> >>
> >> IPV6_V6ONLY support for the setsockopt part has been added a while ago,
> >> but it looks like the get part got forgotten. It should have been
> >> present as a way to verify a setting has been set as expected, and not
> >> to act differently from TCP or any other socket types.
> >>
> >> Not supporting this getsockopt(IPV6_V6ONLY) blocks some apps which want
> >> to check the default value, before doing extra actions. On Linux, the
> >> default value is 0, but this can be changed with the net.ipv6.bindv6only
> >> sysctl knob. On Windows, it is set to 1 by default. So supporting the
> >> get part, like for all other socket options, is important.
> >>
> >> Everything was in place to expose it, just the last step was missing.
> >> Only new code is added to cover this specific getsockopt(), that seems
> >> safe.
> >>
> >> Fixes: c9b95a135987 ("mptcp: support IPV6_V6ONLY setsockopt")
> >> Cc: stable@vger.kernel.org
> >> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/550
> >> Reviewed-by: Mat Martineau <martineau@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > 
> > Hi Matthieu, all,
> > 
> > TBH, I would lean towards this being net-next material rather than a fix
> > for net. But that notwithstanding this looks good to me.
> I understand. This patch and the next one target "net" because, with
> MPTCP, we try to mimic TCP when interacting with the userspace.
> 
> Not supporting "getsockopt(IPV6_V6ONLY)" breaks some legacy apps forced
> to use MPTCP instead of TCP. These apps apparently "strangely" check
> this "getsockopt(IPV6_V6ONLY)" before changing the behaviour with
> "setsockopt(IPV6_V6ONLY)" which is supported for a long time. The "get"
> part should have been added from the beginning, and I don't see this
> patch as a new feature. Because it simply sets an integer like most
> other "get" options, it seems better to target net and fix these apps
> ASAP rather than targeting net-next and delay this "safe" fix.
> 
> If that's OK, I would then prefer if these patches are applied in "net".
> Or they can be applied in "net-next" if we can keep their "Cc: stable"
> and "Fixes" tags, but that looks strange.

Hi Matthieu,

Thanks for your detailed explanation.
With that in mind I agree that these seem appropriate for net.

