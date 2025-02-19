Return-Path: <stable+bounces-116961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF79FA3B121
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F8F3AFFDF
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 05:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856391B85D6;
	Wed, 19 Feb 2025 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sH7QCyML"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E961AF0DC
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944552; cv=none; b=QFvUumSOu5HjT4wDL05VCjQtkjtgZui+M77bpOvOnBP4es52ZrIlg/lxZdo0XQf9vMmnOcM1XWo1gFWB6ZHYGA1h5YmZNAg8TL6l8TlG6uVecZ+UazOddUejObq+AUM9Q9k1xWeM8UVfEO3/f1Bpghl6iVHorl0wfTd2J313dJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944552; c=relaxed/simple;
	bh=WuKHW7I8g0i2VFxzixLMsnGBuOYV8ZWL0p4l8pQadao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdizSuKkAkYYXw95LQQWjvNDqUhzPVXBs/aRcyEDZZ0lY0I2eJ4L1zcaSy71Vhy+gTmdrNE6L+ragyqdR5pkzrM6xR/fxngAssT+ONto1o9XVLflc5sXiDQ97ITfHNU+n2JBpCZcpf69aiz8BBueDJ+VOM2A2wIOMpynJVjVDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sH7QCyML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682A3C4CED1;
	Wed, 19 Feb 2025 05:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739944551;
	bh=WuKHW7I8g0i2VFxzixLMsnGBuOYV8ZWL0p4l8pQadao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sH7QCyMLgkGb9oAam0oh7bLAvzvbzMTAn6taApioL++z85udjnMKP/sj6VWrZCX9T
	 bzykAnbZB7/ID083W6rpbYgCKG08siO6fmaUcQtnCSkTQfxg4Cb1K/jqRs3ZUwiHOr
	 W0NBO8M7+68k1sFNjA3rWpXW1gnMDU5FkPQ4O7Zc=
Date: Wed, 19 Feb 2025 06:55:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jay Wang <wanjay@amazon.com>
Cc: stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Kelley <mhkelley@outlook.com>
Subject: Re: [PATCH v5.10/v5.15/v6.1] x86/i8253: Disable PIT timer 0 when not
 in use
Message-ID: <2025021959-headfirst-dayroom-c1bc@gregkh>
References: <20250218203526.17408-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218203526.17408-1-wanjay@amazon.com>

On Tue, Feb 18, 2025 at 08:35:23PM +0000, Jay Wang wrote:
> commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60 upstream
> 
> Leaving the PIT interrupt running can cause noticeable steal time for
> virtual guests. The VMM generally has a timer which toggles the IRQ input
> to the PIC and I/O APIC, which takes CPU time away from the guest. Even
> on real hardware, running the counter may use power needlessly (albeit
> not much).
> 
> Make sure it's turned off if it isn't going to be used.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Michael Kelley <mhkelley@outlook.com>
> Link: https://lore.kernel.org/all/20240802135555.564941-1-dwmw2@infradead.org
> Signed-off-by: Jay Wang <wanjay@amazon.com>
> Cc: stable@vger.kernel.org #v5.10/v5.15/v6.1
> ---
>  arch/x86/kernel/i8253.c     | 11 +++++++++--
>  drivers/clocksource/i8253.c | 13 +++++++++----
>  include/linux/i8253.h       |  1 +
>  3 files changed, 19 insertions(+), 6 deletions(-)

Why don't you also want this in 6.6.y?  You can't submit patches for
only older kernels without them also being in newer ones, otherwise you
will get a regression when upgrading.

Please always submit patches for all relevant kernel trees.

thanks,

greg k-h

