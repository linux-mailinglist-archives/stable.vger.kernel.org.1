Return-Path: <stable+bounces-25951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1340E870752
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 17:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128631C20AFE
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 16:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FDA495F0;
	Mon,  4 Mar 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DTF5OPxs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF471E48B
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570240; cv=none; b=OGaNMzymwSl+pNWz+/17Ck8FrGCKqGiAP10FRocDgIQ9sS1XxebEycMelnDx2hu8ARlgrXuh8vas/UTbtopR86fth9+wm5g/PFc3Jmkvh87lUNUfL7Yvi1a33eDj3u7zGKbt0OvxkV5nbqbiklA+AXTmLpAdLw5/XNCfOPLavQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570240; c=relaxed/simple;
	bh=BJqbUjHd/3ATRS5Knuik6KJWikLXLMiQbhw3HtDy83w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtbS0N4j9dHi0hkhDYfg0AZgDw3Rvu3mbWM51ucTZMj2UYl44R/scOz2iP0NMijOleSShNOB98wV7kOIQDPbWL1OPsinzEBbNDdZwrsDAp8UNDPHx1CNXMugpK8gJ1y5cLhWhFcL1okJDUOViVChfOY5N1b10i99ndGaOYQkBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DTF5OPxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A3AC433C7;
	Mon,  4 Mar 2024 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709570239;
	bh=BJqbUjHd/3ATRS5Knuik6KJWikLXLMiQbhw3HtDy83w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTF5OPxsb6R4HzRewDwreZonHvILkFb3EJIlWugY0Oi8JVpq3Xe5KB8ZaDDbA+0nE
	 tGkADVyRzhO9RAQltU9UyY8HGVC0CeCBAPQfb1Qx6bIrzoOw/LPGwjcEWUXAjurOjV
	 WVTwB9Mxqws12q69Drr53PCMekahU5sH/ExsxcTQ=
Date: Mon, 4 Mar 2024 17:37:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: pabeni@redhat.com, kuba@kernel.org, martineau@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mptcp: fix snd_wnd initialization for
 passive socket" failed to apply to 5.15-stable tree
Message-ID: <2024030403-dubbed-singer-5c5a@gregkh>
References: <2024030417-jaws-icky-a0f2@gregkh>
 <edc84ad2-61b0-4f17-8825-f1074c386bd4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc84ad2-61b0-4f17-8825-f1074c386bd4@kernel.org>

On Mon, Mar 04, 2024 at 05:13:29PM +0100, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 04/03/2024 10:30, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> 
> (...)
> 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > From adf1bb78dab55e36d4d557aa2fb446ebcfe9e5ce Mon Sep 17 00:00:00 2001
> > From: Paolo Abeni <pabeni@redhat.com>
> > Date: Fri, 23 Feb 2024 17:14:15 +0100
> > Subject: [PATCH] mptcp: fix snd_wnd initialization for passive socket
> > 
> > Such value should be inherited from the first subflow, but
> > passive sockets always used 'rsk_rcv_wnd'.
> > 
> > Fixes: 6f8a612a33e4 ("mptcp: keep track of advertised windows right edge")
> 
> This commit depends on commit 7e8b88ec35ee ("mptcp: consolidate passive
> msk socket initialization") which has apparently not been backported to
> v5.15 due to a too long list of dependences.
> 
> Even if it would be better to have this fix, I don't think it is worth
> having it in v5.15.

Thanks for looking into this and letting us know.

greg k-h

