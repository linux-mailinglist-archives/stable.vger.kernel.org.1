Return-Path: <stable+bounces-116375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE9A35857
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 09:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA1B188C214
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC1B21E0A2;
	Fri, 14 Feb 2025 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hZydQFgf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9201632C8;
	Fri, 14 Feb 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520131; cv=none; b=gB9xE9jqraNPTOkD6fN5ZSw0zG6B+QiArzNvFj7Mi2KlTgAzDNvk1CjvpnGj8Us1LkCv6DRLQbSLNG/yytaozcISgpeqLaQsnEjk0l0Y54sPPfTwhjhEOQY3j5918vBpYBpDBW0jkf6Y0t/SMuHrJxXE7iRgGMpf6VQ+COQeO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520131; c=relaxed/simple;
	bh=HSs1YT5/LDHxXgevBneWiW5cpGpDt3fTsX02DsEboJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYC33UNhH+wwXm9ELgBlxbz4OCzH3NN2vFCZZ3m8lciEqgag3M7cNxLp6SfUH9ERyWWTqIy0es5E8DZeBrJ1Xt8OCZmuaI9ETL8PAyLJgIbrz0M12t191eO9ob7OJh03qOy//ts5kD4wR9QYajfqqiLBuDGC0YbpJfCBoPPzlO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hZydQFgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2377AC4CED1;
	Fri, 14 Feb 2025 08:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739520130;
	bh=HSs1YT5/LDHxXgevBneWiW5cpGpDt3fTsX02DsEboJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZydQFgfgpfXG6XUIuyGoSSBgsUhwK0ceWlRw2BsE3A4R+ef9tAC5ZoH0A/S+8zdI
	 MG12pjeAdWxgWu5fIPg3P7t9YdR2rhIMUACML0AtLrwJPpv0UKHs8XjqOtUOhDQRj7
	 KWFnwKGc7FUVx/Ya7XS1V8Fvv+e5e0VMHk1/gLNE=
Date: Fri, 14 Feb 2025 09:02:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC] usb: gadget: Set self-powered based on MaxPower and
 bmAttributes
Message-ID: <2025021435-campfire-vending-ae46@gregkh>
References: <20250204105908.2255686-1-prashanth.k@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204105908.2255686-1-prashanth.k@oss.qualcomm.com>

On Tue, Feb 04, 2025 at 04:29:08PM +0530, Prashanth K wrote:
> Currently the USB gadget will be set as bus-powered based solely
> on whether its bMaxPower is greater than 100mA, but this may miss
> devices that may legitimately draw less than 100mA but still want
> to report as bus-powered. Similarly during suspend & resume, USB
> gadget is incorrectly marked as bus/self powered without checking
> the bmAttributes field. Fix these by configuring the USB gadget
> as self or bus powered based on bmAttributes, and explicitly set
> it as bus-powered if it draws more than 100mA.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5e5caf4fa8d3 ("usb: gadget: composite: Inform controller driver of self-powered")
> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> ---
>  drivers/usb/gadget/composite.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

What type of "comments" are you wanting here?

For obvious reasons, I can't apply patches tagged "RFC" but I don't see
what you are wanting us to do here.

confused,

greg k-h

