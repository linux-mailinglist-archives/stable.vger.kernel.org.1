Return-Path: <stable+bounces-71630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D873F96600F
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91495286D08
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2080199FB3;
	Fri, 30 Aug 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HbNq/mM/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593D199FAE;
	Fri, 30 Aug 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016002; cv=none; b=o8LFibCxAEhbSJCDltwzO/u2Rj+ZIusDDggLH5c5bWih/vr1UqK+9o+9FpMb7UG+XgEQ6tsm0S1NPcpgbW4r+mGe0SclVlzOKqQllqRQmqaHNzCMJ8krFh+kcPj/WQGzay//LiHv4k8xnUpqFt1cWsX8xIjYjmjq+233zuAZAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016002; c=relaxed/simple;
	bh=d+UZ5rR/XJ0uiV33JsZnGNgXqNE+fGWSIU2/sa2Gi80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZTd1AYx1d6z9R7ahpPwUw+OMGgkUrFNa58/7G7dr0W0s7J36t2O195/CnPj5KAtp1Z4DZ6C/L9YPssYJES88FVDjdSwvrflKw+L963TTNJtwKSJpMuh607HHl6FIXqMPYs5LYoXH//x2xw1COcoHO7CVOk5X3uosSmHZJXWzZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HbNq/mM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC54C4CEC2;
	Fri, 30 Aug 2024 11:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725016002;
	bh=d+UZ5rR/XJ0uiV33JsZnGNgXqNE+fGWSIU2/sa2Gi80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbNq/mM/pVldNcOCGlYaFpUXuGxPkVjmFxYGdIUo+faOfNhJUnY7DYXHLT1uFTrDv
	 QjdJcAUkdpj6yNosxljNA8OwMSLR6VCo4WisRPsWY2GIQ5/2Mr2TxdHxTJne5pxkKX
	 ryt57w9weoKtsKREu9oi13raAzD3l5OdeZvhMfN8=
Date: Fri, 30 Aug 2024 13:06:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
	kernel-team@cloudflare.com
Subject: Re: [PATCH 6.6 046/139] selftests/net: fix uninitialized variables
Message-ID: <2024083021-cytoplasm-width-3e44@gregkh>
References: <20240709110658.146853929@linuxfoundation.org>
 <20240709110659.948165869@linuxfoundation.org>
 <8B1717DB-8C4A-47EE-B28C-170B630C4639@cloudflare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8B1717DB-8C4A-47EE-B28C-170B630C4639@cloudflare.com>

On Thu, Jul 11, 2024 at 04:31:45PM +0100, Ignat Korchagin wrote:
> Hi,
> > On 9 Jul 2024, at 12:09, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: John Hubbard <jhubbard@nvidia.com>
> > 
> > [ Upstream commit eb709b5f6536636dfb87b85ded0b2af9bb6cd9e6 ]
> > 
> > When building with clang, via:
> > 
> >    make LLVM=1 -C tools/testing/selftest
> > 
> > ...clang warns about three variables that are not initialized in all
> > cases:
> > 
> > 1) The opt_ipproto_off variable is used uninitialized if "testname" is
> > not "ip". Willem de Bruijn pointed out that this is an actual bug, and
> > suggested the fix that I'm using here (thanks!).
> > 
> > 2) The addr_len is used uninitialized, but only in the assert case,
> >   which bails out, so this is harmless.
> > 
> > 3) The family variable in add_listener() is only used uninitialized in
> >   the error case (neither IPv4 nor IPv6 is specified), so it's also
> >   harmless.
> > 
> > Fix by initializing each variable.
> > 
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Acked-by: Mat Martineau <martineau@kernel.org>
> > Link: https://lore.kernel.org/r/20240506190204.28497-1-jhubbard@nvidia.com
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> > tools/testing/selftests/net/gro.c                 | 3 +++
> > tools/testing/selftests/net/ip_local_port_range.c | 2 +-
> > tools/testing/selftests/net/mptcp/pm_nl_ctl.c     | 2 +-
> > 3 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> > index 30024d0ed3739..b204df4f33322 100644
> > --- a/tools/testing/selftests/net/gro.c
> > +++ b/tools/testing/selftests/net/gro.c
> > @@ -113,6 +113,9 @@ static void setup_sock_filter(int fd)
> > next_off = offsetof(struct ipv6hdr, nexthdr);
> > ipproto_off = ETH_HLEN + next_off;
> > 
> > + /* Overridden later if exthdrs are used: */
> > + opt_ipproto_off = ipproto_off;
> > +
> 
> This breaks selftest compilation on 6.6, because opt_ipproto_off is not
> defined in the first place in 6.6

So should it be reverted or fixed up?

Can you send a patch doing either one of these?

thanks,

greg k-h

