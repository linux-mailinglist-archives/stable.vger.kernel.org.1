Return-Path: <stable+bounces-33163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE02891890
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 13:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C3E2860EB
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD485631;
	Fri, 29 Mar 2024 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsNDKfqj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33B8564D
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714818; cv=none; b=iawrtvUMQvkubRkgfDMpa9umEbl+9rvH5Q9ofANDfOSTfZ5ZvNwDY1/1g4PlDu4qa6Hp38TF+Ykjp5piugd+7QcbJYiVemsq7uZW8UeiCIszHd1Hvel9KrfeipRoajawXuRVhcwH5Wzudm/X4Xt9TKN9t77D6UxJ8RaVxg2QvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714818; c=relaxed/simple;
	bh=fu/Iwfg2C5EucGT/NM+0MkaXcwma+uPmagc7xa2zcaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz7o5pOjkpfqzO14TUt0NZOBldoT4nHOPUlBjkVRBw7cSQjjrBPzNaLzhvXjEv0gchLXn4634aON4QPD/Nu732Zob04XNL31Nm+LOoRGjsdscuskRvlTssDMAWW6Xm4b9I7mUO4bO6NRWNue8VYZT2brGkhmT0vJPBSj2On/bD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsNDKfqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAA6C433C7;
	Fri, 29 Mar 2024 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711714818;
	bh=fu/Iwfg2C5EucGT/NM+0MkaXcwma+uPmagc7xa2zcaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsNDKfqjIYk21HDHiMvIhZzdV4SAWVZqGMH+44TjkcOwcIRSX4zVffnudYmTegfSE
	 7sBm+2Sf9h3H3TBj5eza9/BPijv8Q5nVlt7PddOAd3810Iev+Rq3YpFbdlR1FOPhYK
	 FXW/eoy2Ghoxe0HZ7ask+kZwWYfad8ArKZSfneUA=
Date: Fri, 29 Mar 2024 13:20:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: stable@vger.kernel.org, Rickard x Andersson <rickaran@axis.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH 6.1.y] tty: serial: imx: Fix broken RS485
Message-ID: <2024032908-phobia-umbrella-a2b4@gregkh>
References: <2024032746-stilt-vaporizer-fb22@gregkh>
 <20240327185459.4717-1-cniedermaier@dh-electronics.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327185459.4717-1-cniedermaier@dh-electronics.com>

On Wed, Mar 27, 2024 at 07:54:59PM +0100, Christoph Niedermaier wrote:
> From: Rickard x Andersson <rickaran@axis.com>
> 
> When about to transmit the function imx_uart_start_tx is called and in
> some RS485 configurations this function will call imx_uart_stop_rx. The
> problem is that imx_uart_stop_rx will enable loopback in order to
> release the RS485 bus, but when loopback is enabled transmitted data
> will just be looped to RX.
> 
> This patch fixes the above problem by not enabling loopback when about
> to transmit.
> 
> This driver now works well when used for RS485 half duplex master
> configurations.
> 
> Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Rickard x Andersson <rickaran@axis.com>
> Tested-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Link: https://lore.kernel.org/r/20240221115304.509811-1-rickaran@axis.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit 672448ccf9b6a676f96f9352cbf91f4d35f4084a)
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
>  drivers/tty/serial/imx.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

Both now queued up, thanks!

greg k-h

