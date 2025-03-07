Return-Path: <stable+bounces-121390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41530A56A00
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE94B1762F5
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9DF21B1B4;
	Fri,  7 Mar 2025 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0qM04HnN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682721ABC3;
	Fri,  7 Mar 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356432; cv=none; b=dfroxNrF3uIj9AVVNRiM/qVUwIweC9Pi4u0MhEV/tJUdadZNGT8n2/5Bc3ZOezGxN2vUCHd9iBkOL9eUrQvUIkZ+/GP5ivQOG1qBjTBEOG50/S50dQO/jSTa0K8XV9NfONKAZf4Qpm+btD3Q5vbMTSv3ugnxXomNu4xugZ9RWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356432; c=relaxed/simple;
	bh=guTpWkuSKjr+xa0rYsZeocaVYSYUy0wyhIGGY0x3ZDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFcsu9m1os+ZEsEBMnjyU2xoneCrHhQLuOATxjgglr1R6X2bqF1D++EuYAoKOh+B+4/+QVXW6Go2MWM6bBmavZIyPPEJV5Bff7hF99iYYGjM7LWme6rkWEOmSW7NOdtGL87dmK256nA9L75IRw62e1PHrI1F5MFkKN+8KcVqDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0qM04HnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF855C4CEE5;
	Fri,  7 Mar 2025 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741356431;
	bh=guTpWkuSKjr+xa0rYsZeocaVYSYUy0wyhIGGY0x3ZDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0qM04HnNtMYCTMrYTRXMqR1yX384AogGabNWObFh0vYEH2c1DNEf3qU84+H+6dTlr
	 LJ2pjNM21nlYVdmYnpNyqcl6Q+TkV+8ClWGHPN4ukiLjCdm58DtAeyLGOQIN9jInzR
	 sTzeI0CjaA5h1I3SxZGdocXC8IC3pqE7+iAu/dk0=
Date: Fri, 7 Mar 2025 15:07:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Se=EFfane?= Idouchach <seifane53@gmail.com>
Cc: dirk.behme@de.bosch.com, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] Long boot times due to USB enumeration
Message-ID: <2025030718-dwindle-degrading-94d3@gregkh>
References: <CAMpRfLORiuJOgUmpmjgCC1LZC1Kp0KFzPGXd9KQZELtr35P+eQ@mail.gmail.com>
 <2025030559-radiated-reviver-eebb@gregkh>
 <CAMpRfLMQ=rWBpYCaco5X4Sh1ecHuiqa91TwsBo6m2MA_UMKM+g@mail.gmail.com>
 <CAMpRfLMakzeazr91DBVyZQnin7y6L9RB+sPFb59U1QZvY3+KBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpRfLMakzeazr91DBVyZQnin7y6L9RB+sPFb59U1QZvY3+KBQ@mail.gmail.com>

On Fri, Mar 07, 2025 at 08:58:04PM +0800, Seïfane Idouchach wrote:
> Dear all,
> 
> I continued bisecting and while applying Dan's fix (15fffc6a5624) along the way.
> While the patch solves the problem for some commits it seems I am
> hitting another commit that exhibits the error again
> (25f51b76f90f10f9bf2fbc05fc51cf685da7ccad).

That is a totally different change, I think you have something odd here
as these bisection points are very confusing.

> I tested on top of v6.14-rc5 (7eb172143d5508) which has the issue,
> applying the fix and reverting the bad commit (25f51b76f90f10) fixes
> it.
> Both the applying fix and the revert are needed to resolve the issue.
> 
> Let me know your thoughts on this.

I think you have a mix of problems here.  Let's fix up all of those
error messages in the log first.  Dan's fix has nothing to do with that
at all, once the USB bus connection stuff is resolved, then it should be
ok.

As that xhci commit you point at is showing an issue, are you sure that
you are properly building the right xhci driver into the system?  Do you
have a Renesas xhci controller?  What is the output of 'lspci'?

thanks,

greg k-h

