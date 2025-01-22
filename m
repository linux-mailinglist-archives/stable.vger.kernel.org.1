Return-Path: <stable+bounces-110136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B618A18ED4
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 10:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C0557A40C8
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E320FAB2;
	Wed, 22 Jan 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goPeOUeB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5D13213E;
	Wed, 22 Jan 2025 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737539532; cv=none; b=hCJe51iPKAoAJQLomDeibzgCAYtwlUFrNyrM0oV5pP1JMejG1O6vBiABsOLAqbqQcCIHr4Mu0BaiVpiRkBADfbYyhYuQ5a4WpCWb825U8Q6tHlnmmagq1HJObDQipUDIe0P+ISX+jCE8tVBT5ESqDzfNdWZ6DhnL84es1itOESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737539532; c=relaxed/simple;
	bh=xBE64dWKEOaM3rijW34rlVGznRRuzugbPt+pk+WX8fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3jxf8STxqnrCzk23Un4cvwssXktZD8ivjbNXrOT2aIGmhkIAZagsAlY9jt3wivj4h91rnPADAy09Zx3yVTX7LXwJ1DrPKAryTOjQaNpxEiFAIsKvjXKnvTq+/wNOEvMtXzSzPRxcFAa9xoEbeusFcd2fqzTVFbD7H1+YpsEkhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goPeOUeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB8CC4CED6;
	Wed, 22 Jan 2025 09:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737539531;
	bh=xBE64dWKEOaM3rijW34rlVGznRRuzugbPt+pk+WX8fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goPeOUeBpXZkqVClbSGf8uHqVQRmHpegRb98IQBiDvYtOwzHGACVx4QqWCBvekoHc
	 t580lCKYZiFIAXbC19lU1MMYUkExyhNNyRElnYWfPLg60TD1Fa1uvitjOZwuK/+Egw
	 iOYKnZK/yED7QUwfqDqJBc6QLevlZ5qA0iGZS2xD7rtxYwg/b9ZLITHskvBOrBZGs3
	 xEhPy0zDO60H0jBdG2EiW1T1I9R0mGfwU7gk1w223SvC5hXXEl7KDLChROe4AqmXtu
	 xORF/7bLQyUKQ3qrJZbAilMFxzNUuBPg5k1wc92/7Lhknic9mSsac5LxjYqo/XF3GF
	 2HQrIMtjddmng==
Date: Wed, 22 Jan 2025 09:52:04 +0000
From: Simon Horman <horms@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <johnstul@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Cyrill Gorcunov <gorcunov@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] posix-clock: Explicitly handle compat ioctls
Message-ID: <20250122095204.GB385045@kernel.org>
References: <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>

On Tue, Jan 21, 2025 at 11:41:24PM +0100, Thomas Weißschuh wrote:
> Pointer arguments passed to ioctls need to pass through compat_ptr() to
> work correctly on s390; as explained in Documentation/driver-api/ioctl.rst.
> Plumb the compat_ioctl callback through 'struct posix_clock_operations'
> and handle the different ioctls cmds in the new ptp_compat_ioctl().
> 
> Using compat_ptr_ioctl is not possible.
> For the commands PTP_ENABLE_PPS/PTP_ENABLE_PPS2 on s390
> it would corrupt the argument 0x80000000, aka BIT(31) to zero.
> 
> Fixes: 0606f422b453 ("posix clocks: Introduce dynamic clocks")
> Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

...

> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 77a36e7bddd54e8f45eab317e687f033f57cc5bc..dec84b81cedfd13bcf8c97be6c3c27d73cd671f6 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -180,6 +180,7 @@ static struct posix_clock_operations ptp_clock_ops = {
>  	.clock_getres	= ptp_clock_getres,
>  	.clock_settime	= ptp_clock_settime,
>  	.ioctl		= ptp_ioctl,
> +	.compat_ioctl	= ptp_compat_ioctl,
>  	.open		= ptp_open,
>  	.release	= ptp_release,
>  	.poll		= ptp_poll,


nit: compat_ioctl should also be added to the Kernel doc for
     struct posix_clock_operations

...

