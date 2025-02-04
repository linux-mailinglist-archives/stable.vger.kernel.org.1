Return-Path: <stable+bounces-112140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA7EA27045
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 12:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EED18874ED
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06173207669;
	Tue,  4 Feb 2025 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MIJhw51M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC13B791
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668746; cv=none; b=oj7w1MVRiCLIuzg8WhmlSvrsV3QJEcNxHYISevT2tXvQCFPR4XppoJKdGEdTTC5SozPX16WXSqfGPXDJCnF2y2jpEWb2kFeG1d0EP226tb+Tki7/wYp3l0cFUenkPQzoke/0DnPpHUzT7doY4zl4LOyAsmo1ZCYx//Zp/X7aYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668746; c=relaxed/simple;
	bh=7XKcdMuSOCKnYbixiEcVrHungyZbcZqPJ0mCkWII+pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftar7hREf1f3wfuznhO9Oe/pZqk/KhcHdbwl7fDvdqrpZB5e4DN7fKV5lC8AVzDduDToYkBTRhLGPMl7nXRwrSJdVraj3DIvJR9SBsKKu2fI1BpVItyo55i1Dhn9AiFGfT9jQd1mmL2nF+y01tZpvzpJr7WznHZdUUZbS8yX6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MIJhw51M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDA5C4CEDF;
	Tue,  4 Feb 2025 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738668746;
	bh=7XKcdMuSOCKnYbixiEcVrHungyZbcZqPJ0mCkWII+pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIJhw51MxV4dM6n3srhbc6e7leImmkzuQHjuV5PMAsBbvBR51Ag1Oi2qRkb4W0jhc
	 1cBHsXrWcNnBhBRdvvCG18u0eL2ob+JYFLPxNz3omOtK+Rw55al/SETqV+uuPnCKs7
	 cWipRhNfUKO0LXs700HEaQSNnnz9AciukEqVjzOI=
Date: Tue, 4 Feb 2025 12:32:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Rosenberg <drosen@google.com>
Cc: Todd Kjos <tkjos@google.com>, stable <stable@vger.kernel.org>,
	Android Kernel Team <kernel-team@android.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: f2fs: Introduce linear search for dentries
Message-ID: <2025020432-stiffen-expire-30bd@gregkh>
References: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>
 <2025020118-flap-sandblast-6a48@gregkh>
 <CAHRSSExDWR_65wCvaVu3VsCy3hGNU51mRqeQ4uRczEA0EYs-fA@mail.gmail.com>
 <CA+PiJmT-9wL_3PbEXBZbFCBxAFVnoupwcJsRFt8K=YHje-_rLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+PiJmT-9wL_3PbEXBZbFCBxAFVnoupwcJsRFt8K=YHje-_rLg@mail.gmail.com>

On Mon, Feb 03, 2025 at 03:07:10PM -0800, Daniel Rosenberg wrote:
> On Sat, Feb 1, 2025 at 12:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > As the original commit that this says it fixes was reverted, should that
> > also be brought back everywhere also?  Or did that happen already and I
> > missed that?
> >
> > thanks,
> >
> > greg k-h
> 
> The revert of the unicode patch is in all of the stable branches
> already. That f2fs patch is technically a fix for the revert as well,
> since the existence of either of those is a problem for the same
> reason :/

Ok, so that means that the original issue is still in mainline but now
it is safe to bring the unicode patch back there and add it to the
stable branches if we also take this one?

thanks,

greg k-h

