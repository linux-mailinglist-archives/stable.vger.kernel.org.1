Return-Path: <stable+bounces-46130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D08CEF5E
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125ED281895
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9C143AD6;
	Sat, 25 May 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Buv5Xr4S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493371DA5F
	for <stable@vger.kernel.org>; Sat, 25 May 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648323; cv=none; b=G6lIOm0CRO9PoFaFYtm7WFjoYKNXjYsa8IPnU/B07RqW2XK7APlwavTl9sZQ/pilttlPpRbCA3yygjTf33w8gyBPO5XsJ7vaR7M7G9Jf9drQoaWUtZ5VL7jVkZzzRLym3AH9QSC+Cao5jMfOa8wKyUmr+wHeAjSIqnwFUSY+scQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648323; c=relaxed/simple;
	bh=MFjPgJHlxXh+gfrOtFJyyB23qoe30D3BsfHe2LfEpVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbm9zZUzYr0kq8V2IUmvgGxcNaHFZXtg3e0CSbNRZDy7tbOP8N2SUUCxBYnmLgU4AhZM+MpqvIRdtZCZJQ0cPrTugGrSe61Not3icpQyiaT0sHtU5anf0sxX+K75RsvLqr6chtLXJFQDtGDKwhKFS7TGGGderv05rn8lTIJq+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Buv5Xr4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA655C2BD11;
	Sat, 25 May 2024 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648323;
	bh=MFjPgJHlxXh+gfrOtFJyyB23qoe30D3BsfHe2LfEpVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Buv5Xr4SStvGMFdziG+ccEQl41dq+wKsXv+OjPbVZ4C3FFQoVHEZX9U71AAWMq6c0
	 IaTbodzsfZufvOQoLt0PkzMGnIiBRtTxuwLIOZjjNmXzFOVjcGvA4aUZeX408IRj/X
	 F26RVEXxDoLwQIJWMX3hUdNX88p2XuuQTe7TJeN4=
Date: Sat, 25 May 2024 16:45:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Klink <flokli@flokli.de>
Cc: stable@vger.kernel.org, thorsten@leemhuis.info
Subject: Re: cherry-pick request for "arm64/fpsimd: Avoid erroneous elide of
 user state reload"
Message-ID: <2024052538-kerosene-aide-3e93@gregkh>
References: <xvhrz2hqorwt42c4bdx7qzbofjpkv5x4ryzfmoptde5aztygha@pi7mq5dxdq75>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xvhrz2hqorwt42c4bdx7qzbofjpkv5x4ryzfmoptde5aztygha@pi7mq5dxdq75>

On Sat, May 25, 2024 at 02:36:41PM +0200, Florian Klink wrote:
> 
> Hey,
> 
> I got encouraged to send another email here from
> https://github.com/tpwrules/nixos-apple-silicon/issues/200.
> 
> "arm64/fpsimd: Avoid erroneous elide of user state reload" / https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=e92bee9f861b466c676f0200be3e46af7bc4ac6b
> fixes a data corruption issue with dm-crypt on aarch64, reproducible on
> the mainline Linux kernel (not just asahi specific!).
> 
> This list has been included as Cc on this commit, but it'd be very nice
> to make sure this already lands in 6.9.2, due to its data corruption
> nature.

Now queued up for the next release.  As this fixes an issue that has
been there for a while (back to 6.8 days), I can't just add it to an
untested -rc cycle.

thanks,

greg k-h

